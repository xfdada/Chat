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
        $formid = input('fromid/d',0);
        if ($formid==0){return false;}
        $this->assign('fromid',$formid);
        return $this->fetch('list');
    }

    /**
     * 我的消息
     */
    public function message_List(){
        $formid = input('fromid/d',0);
        if ($formid==0){return false;}
        $this->assign('fromid',$formid);
        return $this->fetch('message_list');
    }

    /**
     * 我的群消息
     */
    public function group_List(){
        $formid = input('fromid/d',0);
        if ($formid==0){return false;}
        $this->assign('fromid',$formid);
        return $this->fetch('group_list');
    }
    /**
     * 添加群或人
     */

    public function add(){
        $formid = input('fromid/d',0);
        if ($formid==0){return false;}
        $this->assign('fromid',$formid);
        return $this->fetch('add');
    }

    /**
     * 用户/群信息
     */
    public function Info(){
        $id = input('id/d',0);
        $myid = input('myid/d',0);
        $type = input('types');
        $this->assign('info',['id'=>$id,'myid'=>$myid,'type'=>$type]);
        return $this->fetch('detail');
    }
}
