## 基于Tp5.0和workerman开发的简易聊天应用
   功能：初期目标是用户一对一聊天，能够发送图片，和视频文件给对方


### 介绍
 由于workerman是独立于其他web服务器，由于workerman是常驻内存的PHP文件只从磁盘读取一次，所以如果修改了代码需要进行重启
 
 如需运行测试需要修改 start_businessworker.php start_businessworker.php start_gateway.php  start_register.php 三个文件中的IP地址
 
 Windows下直接打开mychat文件夹下的 start_for_win.bat
 linux进入myChat\Applications\YourApp目录下 运行 php start_businessworker.php php start_businessworker.php start_gateway.php php start_register.php 三个文件
 
 sql文件中没有提供数据 ，需要自己创建几个用户 ，后期加上群聊天等功能
 配置好域名后直接访问 域名/index/index/index/from/发送者id/to/接收者id
