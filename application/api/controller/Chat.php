<?php

namespace app\api\controller;


use think\Controller;
use think\Db;
use think\Request;
use think\response\Json;

class Chat extends Controller
{

    public function getMsg(){
        $page = 1;
        $row = 10;
        $from = input("from",10);
        $to = input("to",11);
        $froms = Db::table('message')->where('fromid=:from and toid=:toid||fromid=:tos and toid=:froms',['from'=>$from,'toid'=>$to,'tos'=>$to,'froms'=>$from])
            ->order("time desc")->limit(($page-1)*$row,$row)->select();
        $new= array_column($froms,'id');
        array_multisort($new,SORT_ASC,$froms);
        return $this->ToJson($froms,'',1);
    }

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
            $res = Db::table('message')->insert($data);
            if ($res) {
                return json_encode(['msg' => 'success', 'code' => 1]);
            }
            return json_encode(['msg' => 'fail', 'code' => 5]);
        }
        return json_encode(['msg' => 'not Ajax request', 'code' => 5]);
    }

    private function getNname($id)
    {
        $name = Db::table('user')->field('name')->find($id);
        return $name['name'];
    }

    public function upload(Request $request)
    {
        $file = request()->file('file');
        $name = $this->img($file);
        $info = input("post.");
        $data = [
            'fromid' => $info['formid'],
            'from_name' => $this->getNname($info['formid']),
            'toid' => $info['toid'],
            'to_name' => $this->getNname($info['toid']),
            'content' => 'http://' . $_SERVER['HTTP_HOST'] . '/uploads/' . $name,
            'is_read' => 2,
            'type' => 2,
            'time' => time(),
        ];
        $res = Db::table('message')->insert($data);
        if ($res){
            return $this->ToJson(['url'=>'http://' . $_SERVER['HTTP_HOST'] . '/uploads/' . $name],'',1);
        }
        return $this->ToJson('','发送图片失败',5);
    }

    public function img($file)
    {
        if ($file) {
            $info = $file->move(ROOT_PATH . 'public' . DS . 'uploads');
            if ($info) {
                return $info->getSaveName();
            } else {
                // 上传失败获取错误信息
                echo $file->getError();
            }
        }

    }

    public function ToJson($data,$msg,$code){
        $data = ['data'=>$data,'msg'=>$msg,'code'=>$code];
        return json($data);
    }

}