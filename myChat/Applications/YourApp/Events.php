<?php
/**
 * This file is part of workerman.
 *
 * Licensed under The MIT License
 * For full copyright and license information, please see the MIT-LICENSE.txt
 * Redistributions of files must retain the above copyright notice.
 *
 * @author walkor<walkor@workerman.net>
 * @copyright walkor<walkor@workerman.net>
 * @link http://www.workerman.net/
 * @license http://www.opensource.org/licenses/mit-license.php MIT License
 */

/**
 * 用于检测业务代码死循环或者长时间阻塞等问题
 * 如果发现业务卡死，可以将下面declare打开（去掉//注释），并执行php start.php reload
 * 然后观察一段时间workerman.log看是否有process_timeout异常
 */
//declare(ticks=1);

use \GatewayWorker\Lib\Gateway;

/**
 * 主逻辑
 * 主要是处理 onConnect onMessage onClose 三个方法
 * onConnect 和 onClose 如果不需要可以不用实现并删除
 */
class Events
{
    /**
     * 当客户端连接时触发
     * 如果业务不需此回调可以删除onConnect
     * 
     * @param int $client_id 连接id
     */
    public static function onConnect($client_id)
    {
        global $num;
//         //向当前client_id发送数据
        Gateway::sendToClient($client_id,json_encode(['type'=>'init']));
//         //向所有人发送
//        Gateway::sendToAll("$client_id login~~~~~~\r\n");
//
        echo "connect".++$num.":".$client_id."\n";

    }
    
   /**
    * 当客户端发来消息时触发
    * @param int $client_id 连接id
    * @param mixed $message 具体消息
    */
   public static function onMessage($client_id, $message) //此方法是处理逻辑的地方
   {
       $msg = json_decode($message,true);
//       var_dump($msg);
       $type = $msg['type'];
        switch ($type){
            case "bind"://绑定用户id
                Gateway::bindUid($client_id,$msg["fromid"]);
                break;
            case "text": //发送文本消息
                $data['type'] = $msg['type'];
                $data['fromid'] = $msg['fromid'];
                $data['toid'] = $msg['toid'];
                $data['msg'] = $msg['msg'];
                $data['time'] = time();
//                var_dump(Gateway::isUidOnline($msg['fromid']));
                if (Gateway::isUidOnline($msg['toid'])){//判断用户是否在线 ，在线的话向其发送消息
                    Gateway::sendToUid($msg['toid'],json_encode($data));
                    $data['is_read'] = 2;
                }else{
                    $data['is_read'] = 1;
                }
                $data['type'] = 'save'; //将消息类型改为保存，
                Gateway::sendToUid($msg['fromid'],json_encode($data));
                break;
            case 'img'://发送到是图片消息
                $data['type'] = $msg['type'];
                $data['fromid'] = $msg['fromid'];
                $data['toid'] = $msg['toid'];
                $data['msg'] = $msg['msg'];
                $data['time'] = time();
                Gateway::sendToUid($msg['toid'],json_encode($data));
                break;
            case 'video'://发送到是视频消息
                $data['type'] = $msg['type'];
                $data['fromid'] = $msg['fromid'];
                $data['toid'] = $msg['toid'];
                $data['msg'] = $msg['msg'];
                $data['time'] = time();
                Gateway::sendToUid($msg['toid'],json_encode($data));
                break;
            case 'is_line'://判断用户是否在线
                $is_line = Gateway::isUidOnline($msg['uid']);
                $data['type'] = 'is_line';
                $data['uid'] = $msg['uid'];
                $data['is_line'] = $is_line;
                Gateway::sendToUid($msg['from_id'],json_encode($data));

        }
   }
   
   /**
    * 当用户断开连接时触发
    * @param int $client_id 连接id
    */
   public static function onClose($client_id)
   {
       // 向所有人发送 
//        GateWay::sendToAll("$client_id logout\r\n");
   }
}
