/*
SQLyog Ultimate v12.09 (64 bit)
MySQL - 8.0.12 : Database - chat
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`chat` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;

USE `chat`;

/*Table structure for table `group` */

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `group_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `group_account` int(11) DEFAULT NULL COMMENT '群账号',
  `group_name` varchar(20) NOT NULL COMMENT '群名称',
  `group_introduce` varchar(255) DEFAULT NULL COMMENT '群介绍',
  `group_icon` varchar(255) DEFAULT NULL COMMENT '群头像',
  `id` int(11) DEFAULT NULL COMMENT '创建者id',
  `group_count` int(11) DEFAULT NULL COMMENT '群人数',
  `create_time` int(11) DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='群列表';

/*Data for the table `group` */

insert  into `group`(`group_id`,`group_account`,`group_name`,`group_introduce`,`group_icon`,`id`,`group_count`,`create_time`) values (1,688688,'小白兔的家','兔子宠物家园','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1177508692,91472600&fm=15&gp=0.jpg',10,12,154515665);

/*Table structure for table `group_list` */

DROP TABLE IF EXISTS `group_list`;

CREATE TABLE `group_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) DEFAULT NULL COMMENT '群id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='群成员列表';

/*Data for the table `group_list` */

/*Table structure for table `group_message` */

DROP TABLE IF EXISTS `group_message`;

CREATE TABLE `group_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `group_id` int(11) DEFAULT NULL COMMENT '群id',
  `group_content` varchar(2000) DEFAULT NULL COMMENT '消息内容',
  `type` tinyint(1) DEFAULT NULL COMMENT '消息类型 1文本 2图片 3视频',
  `time` int(11) unsigned DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='群消息表';

/*Data for the table `group_message` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `account` int(11) unsigned DEFAULT NULL COMMENT '账号',
  `password` varchar(100) DEFAULT NULL COMMENT '密码',
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号',
  `name` varchar(50) DEFAULT NULL COMMENT '昵称',
  `icon` varchar(255) DEFAULT NULL COMMENT '头像',
  `introduce` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '简介',
  `register_time` int(11) DEFAULT NULL COMMENT '注册时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `user` */

insert  into `user`(`id`,`account`,`password`,`phone`,`name`,`icon`,`introduce`,`register_time`) values (10,445566,'123456','13020269544','小白','https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1014572345,705313395&fm=16&gp=0.jpg','没啥好说的',NULL),(11,123456,'123456','13020269544','小黑','https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566298526880&di=6cd6dbd201dafe4d39f55204c1fabad5&imgtype=0&src=http%3A%2F%2Fimg.bqatj.com%2Fimg%2F6d218fd30c15efee.jpg','干哈呀',NULL),(12,754731,'123456','13020269544','小林','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1177508692,91472600&fm=15&gp=0.jpg','微微一笑',NULL);

/*Table structure for table `user_list` */

DROP TABLE IF EXISTS `user_list`;

CREATE TABLE `user_list` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `friend_id` int(11) DEFAULT NULL COMMENT '好友id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户好友列表';

/*Data for the table `user_list` */

insert  into `user_list`(`id`,`user_id`,`friend_id`) values (1,10,11),(2,10,12),(3,11,10),(4,12,10),(5,11,12);

/*Table structure for table `user_message` */

DROP TABLE IF EXISTS `user_message`;

CREATE TABLE `user_message` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `fromid` int(11) DEFAULT NULL COMMENT '发送者id',
  `from_name` varchar(50) DEFAULT NULL COMMENT '发送者',
  `toid` int(11) DEFAULT NULL COMMENT '接收者id',
  `to_name` varchar(50) DEFAULT NULL COMMENT '接收者',
  `content` text COMMENT '内容',
  `is_read` tinyint(1) DEFAULT NULL COMMENT '是否已读',
  `type` tinyint(1) DEFAULT NULL COMMENT '消息类型 1文本 2图片 3视频',
  `time` int(11) DEFAULT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=113 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户消息表';

/*Data for the table `user_message` */

insert  into `user_message`(`id`,`fromid`,`from_name`,`toid`,`to_name`,`content`,`is_read`,`type`,`time`) values (1,20,NULL,10,NULL,'hello',2,1,1566294670),(2,10,'小白',11,'小黑','nice to meet you',2,1,1566295150),(3,11,'小黑',10,'小白','nice to meet you too',2,1,1566295850),(4,10,'小白',11,'小黑','gdf',2,1,1566296476),(5,11,'小黑',10,'小白','4564165',2,1,1566296670),(6,10,'小白',11,'小黑','51465',2,1,1566296677),(7,10,'小白',11,'小黑','redfgdf',2,1,1566296840),(8,10,'小白',11,'小黑','啊啊啊啊啊啊',2,1,1566354331),(9,11,'小黑',10,'小白','我要奔溃啦',2,1,1566354356),(10,11,'小黑',10,'小白','谁来救救我呀',2,1,1566354372),(11,10,'小白',11,'小黑','救你个毛线，老老实实干活去',2,1,1566354401),(12,11,'小黑',10,'小白','你这头像怪怪的，看的我头晕',2,1,1566355309),(13,10,'小白',11,'小黑','真的吗',2,1,1566355383),(14,10,'小白',11,'小黑','你还在线吗',2,1,1566355432),(15,10,'小白',11,'小黑','你还在线吗',2,1,1566355498),(16,11,'小黑',10,'小白','在的呀',2,1,1566355533),(17,10,'小白',11,'小黑','判断$uid是否在线，此方法需要配合Gateway::bindUid($client_uid, $uid)使用。  如果某uid没有通过Gateway::bindUid($client_uid, $uid)进行任何绑定，那么对该uid调用Gateway::isUidOnline($uid)将返回0。  如果某uid绑定的client_id都已经下线，那么对该uid调用Gateway::isUidO',2,1,1566355646),(18,11,'小黑',10,'小白','判断$uid是否在线，此方法需要配合Gateway::bindUid($client_uid, $uid)使用。  如果某uid没有通过Gateway::bindUid($client_uid, $uid)进行任何绑定，那么对该uid调用Gateway::isUidOnline($uid)将返回0。  如果某uid绑定的client_id都已经下线，那么对该uid调用Gateway::isUidO',2,1,1566355684),(19,13,NULL,10,'小白','规范',2,1,1566357033),(20,12,'龙霸',10,'小白','啦啦',2,1,1566357052),(21,11,'小黑',10,'小白','第三方',2,1,1566367122),(22,11,'小黑',10,'小白','第三方',2,1,1566367186),(23,10,'小白',11,'小黑','4546456',2,1,1566381785),(43,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\f09c0912ce241b24996b9568fae976f5.jpg',2,2,1566464652),(44,10,'小白',11,'小黑','http://chat.com/uploads/20190822\\cbbc59ca3eb04d6b2a72185a78fff2c5.jpg',2,2,1566465472),(45,10,'小白',11,'小黑','哈哈哈',2,1,1566466150),(46,10,'小白',11,'小黑','6666999',2,1,1566466181),(47,11,'小黑',10,'小白','阿所发生的',2,1,1566466316),(48,10,'小白',11,'小黑','http://chat.com/uploads/20190822\\aaab76e7311af8140c1df050b611a6e6.jpg',2,2,1566466325),(49,10,'小白',11,'小黑','http://chat.com/uploads/20190822\\36ec295b0fcfdd67b244f643d5c01af1.jpg',2,2,1566466381),(50,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\93faf6b44a20c3583f5db1fb8f1ae056.jpg',2,2,1566466438),(51,10,'小白',11,'小黑','http://chat.com/uploads/20190822\\a1f5801d54ad1fe266a05d721c5d3487.jpg',2,2,1566466532),(52,10,'小白',11,'小黑','效果怎么样呀',2,1,1566466978),(53,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\6df5d5afac4d48fc28cc3074eb099a1b.jpg',2,2,1566467174),(54,10,'小白',11,'小黑','还挺丰富有几个',2,1,1566468159),(55,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\ccc8c46ae0ce2a099856e4b3fa7fa532.jpg',2,2,1566468169),(56,11,'小黑',10,'小白','哈哈哈哈',2,1,1566468190),(57,11,'小黑',10,'小白','阿斯顿发大水发',2,1,1566468288),(58,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\f83498edf60c574d2b2eca19a291c7d1.jpg',2,2,1566468356),(59,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\743612fc7af072f6d04550695f693d6b.jpg',2,2,1566468399),(60,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\56318b1bc7063e27d924fd7561da71d1.jpg',2,2,1566468456),(61,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\dae3a7faf8f46b86f41d7e1af191e88d.jpg',2,2,1566468472),(62,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\8d318d76f5ce8cf018a9c83927c18e9c.jpg',2,2,1566468603),(63,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\642258074c264b0695e4666a64b083aa.jpg',2,2,1566469119),(64,11,'小黑',10,'小白','http://chat.com/uploads/20190822\\4934a6c20e4c1d411aba4aa25d7cfc63.jpg',2,2,1566469614),(65,10,'小白',11,'小黑','http://chat.com/uploads/20190823\\c2806a260a525b9215521c3d10f43bec.jpg',2,2,1566529223),(66,10,'小白',11,'小黑','http://chat.com/uploads/img/20190823\\90ce5cab5b0e6882a444b7c83cac0663.jpg',2,2,1566529260),(67,10,'小白',11,'小黑','http://chat.com/uploads/img/20190823\\ee818cf88a304b2536a6701aa00fe590.jpg',2,2,1566529315),(68,10,'小白',11,'小黑','http://chat.com/uploads/img/20190823\\986b024b412798adf5cb8c0fb64e879f.jpg',2,2,1566529913),(69,10,'小白',11,'小黑','http://chat.com/uploads/img/20190823\\483ad48c4cbad1c95d573ccf72163f8f.jpg',2,2,1566529940),(70,10,'小白',11,'小黑','http://chat.com/uploads/video/20190823/256eb6af6ecb70c8db861509c15e0bab.mp4',2,3,1566538829),(71,11,'小黑',10,'小白','http://chat.com/uploads/video/20190823/3f2dbd96409652aa08fba487c064b6ab.mp4',2,3,1566543296),(72,10,'小白',11,'小黑','呵呵呵',2,1,1566814119),(73,10,'小白',12,'龙霸','瞅你咋地',2,1,1566814382),(74,11,'小黑',10,'小白','啦啦啦',2,1,1566893823),(75,11,'小黑',10,'小白','你愁啥呢',2,1,1566893850),(76,10,'小白',11,'小黑','没钱啊',2,1,1566893865),(77,10,'小白',12,'龙霸','看你就想打你一顿',2,1,1566893919),(78,10,'小白',11,'小黑','http://chat.com/uploads/video/20190827/8225ea041b7d54ec195c3c06f6f1ae01.mp4',2,3,1566894060),(79,11,'小黑',10,'小白','http://chat.com/uploads/video/20190827/893479c96dad2e5c980af571c7f4ff2c.mp4',2,3,1566894122),(80,11,'小黑',10,'小白','http://chat.com/uploads/video/20190827/34014b7387fc64ec9690cb8dbfb3d207.mp4',2,3,1566894177),(81,11,'小黑',10,'小白','http://chat.com/uploads/video/20190827/65aba7c44fc27f8a63f6d870fed1fad2.mp4',2,3,1566894249),(82,10,'小白',11,'小黑','http://chat.com/uploads/img/20190827\\1b8bc3da4adfa81f5697040593236260.jpg',2,2,1566895524),(83,10,'小白',11,'小黑','http://chat.com/uploads/img/20190827\\2108c3fcad892130edf19ee80586328a.jpg',2,2,1566895580),(84,10,'小白',11,'小黑','http://chat.com/uploads/img/20190827\\4ad5ca225c4f8cc9350f29e118b4cdee.jpg',2,2,1566895810),(85,11,'小黑',10,'小白','http://chat.com/uploads/img/20190827\\567f60cdd12aeef175c7121cc6171abb.jpg',2,2,1566895943),(86,11,'小黑',10,'小白','http://chat.com/uploads/img/20190827\\52a38996180010f1d4a0004eeed9b57e.jpg',2,2,1566897837),(87,12,'龙霸',10,'小白','我就是看看咋地',2,1,1566957868),(88,12,'龙霸',10,'小白','有红点吗',2,1,1566957953),(89,12,'龙霸',10,'小白','有没有吗',2,1,1566958040),(90,12,'龙霸',10,'小白','还是没有',2,1,1566958102),(91,12,'龙霸',10,'小白','再试一次',2,1,1566958176),(92,12,'龙霸',10,'小白','kakak',2,1,1566958334),(93,12,'龙霸',10,'小白','好非常好',2,1,1566958932),(94,10,'小白',12,'龙霸','还在线吗',2,1,1566959324),(95,10,'小白',12,'龙霸','http://chat.com/uploads/img/20190828\\eb724df83404fb6094a7e55be4a211d7.jpg',2,2,1566959334),(96,12,'龙霸',10,'小白','http://chat.com/uploads/img/20190828\\c8016c33196ce814423c97b0fcb2aa4b.jpg',2,2,1566959537),(97,12,'龙霸',10,'小白','http://chat.com/uploads/img/20190828\\6ef0c4a48b084c2a868335232c8ce15b.jpg',2,2,1566959722),(98,12,'龙霸',10,'小白','hahaha',2,1,1566961011),(99,12,'龙霸',10,'小白','lalal',2,1,1566961024),(100,10,'小白',11,'小黑','看你看',2,1,1567217890),(101,10,'小白',12,'小林','小林啊',2,1,1567218223),(102,12,'小林',10,'小白','干嘛啊',2,1,1567218389),(103,12,'小林',10,'小白','有事吗',2,1,1567218409),(104,10,'小白',12,'小林','当然有事啊',2,1,1567218428),(106,12,'小林',11,'小黑','小林想添加你为好友',2,4,1567245136),(107,11,'小黑',12,'小林','哈喽',1,1,1567391710),(108,10,'小白',12,'小林','看看你',2,1,1567391754),(109,11,'小黑',12,'小林','嘿嘿',1,1,1567391783),(110,11,'小黑',12,'小林','123123',1,1,1567392198),(111,10,'小白',12,'小林','嘿嘿',2,1,1567392353),(112,10,'小白',12,'小林','看看',2,1,1567392834);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
