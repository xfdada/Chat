<?php

namespace app\api\controller;


use think\Controller;
use think\Db;
use think\Request;
use think\response\Json;

class Chat extends Controller
{

    /**
     * 查询聊天记录，desc排序显示最新的10条消息  手动分页
     */
    public function getMsg(){
        $page = 1;
        $row = 10;
        $from = input("from",10);
        $to = input("to",11);
        $froms = Db::table('user_message')->where('fromid=:from and toid=:toid||fromid=:tos and toid=:froms',['from'=>$from,'toid'=>$to,'tos'=>$to,'froms'=>$from])
            ->order("time desc")->limit(($page-1)*$row,$row)->select();
        $new= array_column($froms,'id');//选中id列为一个数组
        array_multisort($new,SORT_ASC,$froms);//以数组中$new顺序的方式对$froms进行排序
        return $this->ToJson($froms,'',1);
    }

    /**
     * 保存聊天记录
     */
    public function save_msg(Request $request)
    {
        if ($request->isAjax()) {
            $info = input("post.");
            $content = json_decode($info['msg'], true);
            $data = [
                'fromid' => $content['fromid'],
                'from_name' => $this->getNname($content['fromid']),
                'toid' => $content['toid'],
                'to_name' => $this->getNname($content['toid']),
                'content' => $content['msg'],
                'time' => $content['time'],
                'is_read' => $content['is_read'],
                'type' => 1
            ];
            $res = Db::table('user_message')->insert($data);
            if ($res) {
                return json_encode(['msg' => 'success', 'code' => 1]);
            }
            return json_encode(['msg' => 'fail', 'code' => 5]);
        }
        return json_encode(['msg' => 'not Ajax request', 'code' => 5]);
    }
    /**
     * 上传图片 并将数据保存到数据库中
     */
    public function img(Request $request)
    {
        $file = request()->file('file');
        if ($file) {
            $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads/img/');
            if ($info) {
                $name = $info->getSaveName();
            } else {
                // 上传失败获取错误信息
                return $this->ToJson('',$file->getError(),5);
            }
        }
        $info = input("post.");
        $data = [
            'fromid' => $info['formid'],
            'from_name' => $this->getNname($info['formid']),
            'toid' => $info['toid'],
            'to_name' => $this->getNname($info['toid']),
            'content' => 'http://' . $_SERVER['HTTP_HOST'] . '/uploads/img/' . $name,
            'is_read' => 2,
            'type' => 2,
            'time' => time(),
        ];
        $res = Db::table('user_message')->insert($data);
        if ($res){
            return $this->ToJson(['url'=>'http://' . $_SERVER['HTTP_HOST'] . '/uploads/img/' . $name],'',1);
        }
        return $this->ToJson('','发送图片失败',5);
    }

    /**
     * 视频上传
     * @param $file
     * @return mixed
     */

    public function video(){
        $video = $_FILES['file'];
//        dump($video);exit;
        $mime ='video/mp4';
        if($video['error']!=0){
            return $this->ToJson('','上传出错',5);
        }
        if ($video['type']!=$mime){
            return $this->ToJson('','只支持MP4格式视频上传',5);
        }
        if($video['size']>200*1024*1024){
            return $this->ToJson('','视频文件上传大于50MB',5);
        }
        if(strtolower(strrchr($video['name'],'.'))!='.mp4'){
            return $this->ToJson('','上传文件格式错误',5);
        }
        $tmp = $video['tmp_name'];
        $path= ROOT_PATH . 'public' . DS . 'uploads/video/'.date('Ymd');
        if(!is_dir($path)){
            mkdir('uploads/video/'.date('Ymd'),0777);
        }
        $path =  ROOT_PATH . 'public' . DS . 'uploads/video/'.date('Ymd');
        $name = md5(date('YmdHis')).'.mp4';
        if(!move_uploaded_file($tmp,$path.'/'.$name)){
            return $this->ToJson('','上传失败',5);
        }
        $src = '/uploads/video/'.date('Ymd').'/'.$name;
        $info = input("post.");
        $data = [
            'fromid' => $info['formid'],
            'from_name' => $this->getNname($info['formid']),
            'toid' => $info['toid'],
            'to_name' => $this->getNname($info['toid']),
            'content' => 'http://' . $_SERVER['HTTP_HOST'] . $src,
            'is_read' => 2,
            'type' => 3,
            'time' => time(),
        ];
        $res = Db::table('user_message')->insert($data);
        if ($res){
            return $this->ToJson($src,'',1);
        }
    }



    /**
     * 好友列表
     */

    public function getFriend(){
        $id = input('id/d',0);
        if ($id===0){
            return $this->ToJson(null,'参数错误',5);
        }
        $res = Db::table('user_list')->where("user_id =:id",['id'=>$id])->column('friend_id');
        if (!$res){
            return $this->ToJson(null,'没有好友',5);
        }
        $list = Db::table('user')->where("id", "in",$res)->select();
        if ($list){
            return $this->ToJson(['info'=>$list,'id'=>$res],'',1);
        }
        return $this->ToJson(null,'没有数据',5);
    }

    /**
     * 我的好友消息
     */
    public function myMessage(){
        $id = input('id/d',0);
        if ($id===0){
            return $this->ToJson(null,'参数错误',5);
        }
        $res = Db::table('user_list')->where("user_id =:id",['id'=>$id])->column('friend_id');
        if (!$res){
            return $this->ToJson(null,'没有聊天记录',5);
        }
        $message = [];
       foreach ($res as $v){
           $message[] = [
               'id'=>$v,
               'name'=>$this->getNname($v),
               'icon'=>$this->getIcon($v),
               'last_msg'=>$this->lastMsg($v,$id)['content'],
               'times'=>$this->lastMsg($v,$id)['time'],
               'type'=>$this->lastMsg($v,$id)['type'],
               'no_read'=>$this->noRead($v,$id)
           ];
       }
       return $this->ToJson($message,'',1);
    }

    /**
     * json格式化
     * @param $data
     * @param $msg
     * @param $code
     * @return Json
     */
    public function ToJson($data,$msg,$code){
        $data = ['data'=>$data,'msg'=>$msg,'code'=>$code];
        return json($data);
    }
    /**
     * 获取用户的昵称
     */
    private function getNname($id)
    {
        $name = Db::table('user')->field('name')->find($id);
        return $name['name'];
    }
    /**
     * 获取用户的头像
     */
    private function getIcon($id)
    {
        $name = Db::table('user')->field('icon')->find($id);
        return $name['icon'];
    }
    private function lastMsg($id,$from_id){

        $sql = "SELECT time,content,type FROM user_message WHERE (fromid={$id} AND toid={$from_id}) OR(fromid={$from_id} AND toid={$id}) ORDER BY id DESC LIMIT 1";
        $res = Db::query($sql);
//        dump( Db::table('user_message')->getLastSql());
        $res[0]['time']=date('Y-m-d H:i:s',$res[0]['time']);
//        dump($res[0]);exit;
        return $res[0];
    }

    private function noRead($id,$from_id){
        $res = Db::table('user_message')->where('fromid=:toid&&toid=:fromid',['toid'=>$id,'fromid'=>$from_id])->where('is_read=1')->count('id');
//        dump( Db::table('user_message')->getLastSql());
//        dump($res);exit;
        return $res;
    }
}