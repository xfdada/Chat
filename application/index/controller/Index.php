<?php
namespace app\index\controller;

use think\Controller;
use think\Db;

class Index extends Controller
{
    public function index()
    {
        $from = input("from");
        $to = input("to");
        $this->assign('to_info',$this->getUserInfo($to));
        $this->assign('from_info',$this->getUserInfo($from));
        $this->assign("from",$from);
        $this->assign("to",$to);
       return $this->fetch();
    }

    /**
     * 获取用户信息
     */
    private function getUserInfo($id){
        $info = Db::table('user')->find($id);
        return $info;
    }

    /**
     * 我的好友列表
     */
    public function userList(){
        return $this->fetch('list');
    }

    /**
     * 我的消息
     */
    public function message_List(){
        return $this->fetch('message_list');
    }

    /**
     * 我的群消息
     */
    public function group_List(){
        return $this->fetch('group_list');
    }
    /**
     * 添加群或人
     */

    public function add(){
        return $this->fetch('add');
    }

    /**
     * 用户/群信息
     */
    public function Info(){
        $id = input('id/d',0);
        $myid = input('myid/d',0);
        $type = input('types');
        if($type=='user'){ $option='id';$filed = 'id,account,name,icon,introduce';}
        else{$option='group_id';$filed = 'group_id,group_account,group_name,group_introduce,group_icon,group_count,create_by';}
        $my_info = Db::table('user')->where('id',$myid)->field( 'id,account,name,icon,introduce')->find();
        $res = Db::table($type)->where($option,$id)->field($filed)->find();
        $this->assign('info',['id'=>$id,'myid'=>$myid,'type'=>$type]);
        $this->assign('detail',$res);
        $this->assign('my_info',$my_info);
        return $this->fetch('detail');
    }
}
