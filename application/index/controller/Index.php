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
}
