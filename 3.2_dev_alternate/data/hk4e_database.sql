-- MySQL dump 10.13  Distrib 5.7.39, for Win64 (x86_64)
--
-- Host: localhost    Database: *
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `db_hk4e_config`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_hk4e_config` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_hk4e_config`;

--
-- Table structure for table `t_account_cancellation_config`
--

DROP TABLE IF EXISTS `t_account_cancellation_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_account_cancellation_config` (
  `uid` int unsigned NOT NULL COMMENT '游戏uid',
  `account_uid` bigint unsigned NOT NULL COMMENT '通行证aid',
  `cancellation_time` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号注销时间',
  `create_timestamp` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='米哈游通行证注销名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_account_cancellation_config`
--

LOCK TABLES `t_account_cancellation_config` WRITE;
/*!40000 ALTER TABLE `t_account_cancellation_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_account_cancellation_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_activity_data`
--

DROP TABLE IF EXISTS `t_activity_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_activity_data` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `activity_id` int unsigned NOT NULL,
  `schedule_id` int unsigned NOT NULL,
  `activity_type` int unsigned NOT NULL COMMENT '活动类型，避免策划activity_id做新的活动',
  `bin_data` blob NOT NULL COMMENT '使用protobuf序列化后的二进制字段',
  `update_time` datetime NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `activity_schedule_id` (`activity_id`,`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='全服活动存档数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_activity_data`
--

LOCK TABLES `t_activity_data` WRITE;
/*!40000 ALTER TABLE `t_activity_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_activity_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_activity_schedule_config`
--

DROP TABLE IF EXISTS `t_activity_schedule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_activity_schedule_config` (
  `schedule_id` int NOT NULL AUTO_INCREMENT COMMENT '排期ID',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='活动排期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_activity_schedule_config`
--

LOCK TABLES `t_activity_schedule_config` WRITE;
/*!40000 ALTER TABLE `t_activity_schedule_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_activity_schedule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_announce_config`
--

DROP TABLE IF EXISTS `t_announce_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_announce_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `center_system_text` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '中央系统提示文本',
  `count_down_text` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '倒计时提示文本',
  `dungeon_confirm_text` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地下城确认框文本',
  `center_system_frequency` int NOT NULL COMMENT '跑马灯频率',
  `count_down_frequency` int NOT NULL COMMENT '倒计时频率',
  `channel_config_str` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道配置',
  `is_center_system_last_5_every_minutes` tinyint NOT NULL DEFAULT '1' COMMENT '跑马灯最后5分钟每分钟通知',
  `channel_id_list` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道ID列表',
  `platform_type_list` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端平台类型',
  `enable` tinyint NOT NULL DEFAULT '1' COMMENT '是否有效',
  `server_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='预告功能配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_announce_config`
--

LOCK TABLES `t_announce_config` WRITE;
/*!40000 ALTER TABLE `t_announce_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_announce_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_anti_offline_whitelist`
--

DROP TABLE IF EXISTS `t_anti_offline_whitelist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anti_offline_whitelist` (
  `uid` int unsigned NOT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='反脱机挂强对抗白名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anti_offline_whitelist`
--

LOCK TABLES `t_anti_offline_whitelist` WRITE;
/*!40000 ALTER TABLE `t_anti_offline_whitelist` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anti_offline_whitelist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_battle_pass_schedule_config`
--

DROP TABLE IF EXISTS `t_battle_pass_schedule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_battle_pass_schedule_config` (
  `schedule_id` int NOT NULL COMMENT '排期ID, 与Excel中配置一致',
  `begin_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NOT NULL COMMENT '结束日期',
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='战令(BattlePass)排期配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_battle_pass_schedule_config`
--

LOCK TABLES `t_battle_pass_schedule_config` WRITE;
/*!40000 ALTER TABLE `t_battle_pass_schedule_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_battle_pass_schedule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_chat_block_config`
--

DROP TABLE IF EXISTS `t_chat_block_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_chat_block_config` (
  `uid` int unsigned NOT NULL,
  `end_time` datetime NOT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家禁言配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_chat_block_config`
--

LOCK TABLES `t_chat_block_config` WRITE;
/*!40000 ALTER TABLE `t_chat_block_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_chat_block_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_client_watchdog_uid_list_config`
--

DROP TABLE IF EXISTS `t_client_watchdog_uid_list_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_client_watchdog_uid_list_config` (
  `uid` int unsigned NOT NULL,
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='watchdog开启名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_client_watchdog_uid_list_config`
--

LOCK TABLES `t_client_watchdog_uid_list_config` WRITE;
/*!40000 ALTER TABLE `t_client_watchdog_uid_list_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_client_watchdog_uid_list_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_cmd_frequency_config`
--

DROP TABLE IF EXISTS `t_cmd_frequency_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_cmd_frequency_config` (
  `cmd_id` int unsigned NOT NULL,
  `frequency_limit` float NOT NULL COMMENT '单位时间内最大收包量',
  `discard_packet_freq_limit` float NOT NULL COMMENT '超过此频率时丢弃本次协议包',
  `disconnect_freq_limit` float NOT NULL COMMENT '超过此频率时踢玩家下线'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='协议频率限制配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_cmd_frequency_config`
--

LOCK TABLES `t_cmd_frequency_config` WRITE;
/*!40000 ALTER TABLE `t_cmd_frequency_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_cmd_frequency_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_cmd_str_frequency_config`
--

DROP TABLE IF EXISTS `t_cmd_str_frequency_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_cmd_str_frequency_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `cmd_str` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '通信包名',
  `frequency_limit` float NOT NULL COMMENT '单位时间内最大收包量',
  `discard_packet_freq_limit` float NOT NULL COMMENT '超过此频率时丢弃本次协议包',
  `disconnect_freq_limit` float NOT NULL COMMENT '超过此频率时踢玩家下线',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='协议频率限制配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_cmd_str_frequency_config`
--

LOCK TABLES `t_cmd_str_frequency_config` WRITE;
/*!40000 ALTER TABLE `t_cmd_str_frequency_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_cmd_str_frequency_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_feature_block_config`
--

DROP TABLE IF EXISTS `t_feature_block_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_feature_block_config` (
  `uid` int unsigned NOT NULL,
  `type` int unsigned NOT NULL,
  `end_time` datetime NOT NULL,
  `begin_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00',
  PRIMARY KEY (`uid`,`type`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家玩法封禁配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_feature_block_config`
--

LOCK TABLES `t_feature_block_config` WRITE;
/*!40000 ALTER TABLE `t_feature_block_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_feature_block_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_feature_switch_off_config`
--

DROP TABLE IF EXISTS `t_feature_switch_off_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_feature_switch_off_config` (
  `id` int unsigned NOT NULL,
  `type` int unsigned NOT NULL,
  `msg` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='关闭系统开关表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_feature_switch_off_config`
--

LOCK TABLES `t_feature_switch_off_config` WRITE;
/*!40000 ALTER TABLE `t_feature_switch_off_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_feature_switch_off_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_gacha_newbie_url_config`
--

DROP TABLE IF EXISTS `t_gacha_newbie_url_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_gacha_newbie_url_config` (
  `priority` int unsigned NOT NULL COMMENT '优先级',
  `gacha_prob_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '扭蛋概率展示url',
  `gacha_record_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '扭蛋记录url',
  PRIMARY KEY (`priority`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='新手扭蛋url配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_gacha_newbie_url_config`
--

LOCK TABLES `t_gacha_newbie_url_config` WRITE;
/*!40000 ALTER TABLE `t_gacha_newbie_url_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_gacha_newbie_url_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_gacha_schedule_config`
--

DROP TABLE IF EXISTS `t_gacha_schedule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_gacha_schedule_config` (
  `schedule_id` int NOT NULL AUTO_INCREMENT COMMENT '活动ID',
  `gacha_type` int NOT NULL DEFAULT '0' COMMENT '扭蛋类型',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `cost_item_id` int unsigned NOT NULL COMMENT '消耗材料ID',
  `cost_item_num` int unsigned NOT NULL COMMENT '消耗材料数量',
  `gacha_pool_id` int unsigned NOT NULL COMMENT 'Gacha根ID',
  `gacha_prob_rule_id` int unsigned NOT NULL COMMENT 'Gacha概率配置ID',
  `gacha_up_config` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'UP配置',
  `gacha_rule_config` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '保底规则配置',
  `gacha_prefab_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '扭蛋Prefab路径',
  `gacha_preview_prefab_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '扭蛋预览Prefab路径',
  `gacha_prob_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '扭蛋概率展示url',
  `gacha_record_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '扭蛋记录url',
  `gacha_prob_url_oversea` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '海外扭蛋概率展示url',
  `gacha_record_url_oversea` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '海外扭蛋记录url',
  `gacha_sort_id` int unsigned NOT NULL COMMENT '扭蛋排序权重 Priority',
  `enabled` tinyint NOT NULL DEFAULT '1' COMMENT '0不生效，1生效',
  `title_textmap` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'Gacha显示多语言文本',
  `display_up4_item_list` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '显示up4星物品',
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='扭蛋活动配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_gacha_schedule_config`
--

LOCK TABLES `t_gacha_schedule_config` WRITE;
/*!40000 ALTER TABLE `t_gacha_schedule_config` DISABLE KEYS */;
INSERT INTO `t_gacha_schedule_config` (`schedule_id`, `gacha_type`, `begin_time`, `end_time`, `cost_item_id`, `cost_item_num`, `gacha_pool_id`, `gacha_prob_rule_id`, `gacha_up_config`, `gacha_rule_config`, `gacha_prefab_path`, `gacha_preview_prefab_path`, `gacha_prob_url`, `gacha_record_url`, `gacha_prob_url_oversea`, `gacha_record_url_oversea`, `gacha_sort_id`, `enabled`, `title_textmap`, `display_up4_item_list`) VALUES (1, 200, '2022-01-01 00:00:00', '2030-01-01 00:00:00', 224, 1, 101, 3, '{}', '{}', 'GachaShowPanel_A022', 'UI_Tab_GachaShowPanel_A022', '', '', '', '', 1000, 1, 'UI_GACHA_SHOW_PANEL_A022_TITLE', '');
INSERT INTO `t_gacha_schedule_config` (`schedule_id`, `gacha_type`, `begin_time`, `end_time`, `cost_item_id`, `cost_item_num`, `gacha_pool_id`, `gacha_prob_rule_id`, `gacha_up_config`, `gacha_rule_config`, `gacha_prefab_path`, `gacha_preview_prefab_path`, `gacha_prob_url`, `gacha_record_url`, `gacha_prob_url_oversea`, `gacha_record_url_oversea`, `gacha_sort_id`, `enabled`, `title_textmap`, `display_up4_item_list`) VALUES (2, 301, '2022-01-01 00:00:00', '2030-01-01 00:00:00', 223, 1, 201, 1, '{\"gacha_up_list\":[{\"item_parent_type\":1,\"prob\":500,\"item_list\":[1022]},{\"item_parent_type\":2,\"prob\":500,\"item_list\":[1043,1020,1034]}]}', '{}', 'GachaShowPanel_A036', 'UI_Tab_GachaShowPanel_A036', '', '', '', '', 9000, 1, 'UI_GACHA_SHOW_PANEL_A036_TITLE', '');
INSERT INTO `t_gacha_schedule_config` (`schedule_id`, `gacha_type`, `begin_time`, `end_time`, `cost_item_id`, `cost_item_num`, `gacha_pool_id`, `gacha_prob_rule_id`, `gacha_up_config`, `gacha_rule_config`, `gacha_prefab_path`, `gacha_preview_prefab_path`, `gacha_prob_url`, `gacha_record_url`, `gacha_prob_url_oversea`, `gacha_record_url_oversea`, `gacha_sort_id`, `enabled`, `title_textmap`, `display_up4_item_list`) VALUES (3, 400, '2022-01-01 00:00:00', '2030-01-01 00:00:00', 223, 1, 201, 1, '{\"gacha_up_list\":[{\"item_parent_type\":1,\"prob\":500,\"item_list\":[1033]},{\"item_parent_type\":2,\"prob\":500,\"item_list\":[1024,1027,1039]}]}', '{}', 'GachaShowPanel_A023', 'UI_Tab_GachaShowPanel_A023', '', '', '', '', 8000, 1, 'UI_GACHA_SHOW_PANEL_A023_TITLE', '');
INSERT INTO `t_gacha_schedule_config` (`schedule_id`, `gacha_type`, `begin_time`, `end_time`, `cost_item_id`, `cost_item_num`, `gacha_pool_id`, `gacha_prob_rule_id`, `gacha_up_config`, `gacha_rule_config`, `gacha_prefab_path`, `gacha_preview_prefab_path`, `gacha_prob_url`, `gacha_record_url`, `gacha_prob_url_oversea`, `gacha_record_url_oversea`, `gacha_sort_id`, `enabled`, `title_textmap`, `display_up4_item_list`) VALUES (4, 302, '2022-01-01 00:00:00', '2030-01-01 00:00:00', 223, 1, 201, 2, '{\"gacha_up_list\":[{\"item_parent_type\":1,\"prob\":750,\"item_list\":[15509,11504]},{\"item_parent_type\":2,\"prob\":500,\"item_list\":[14410,15410,11402,12403,13401]}]}', '{}', 'GachaShowPanel_A090', 'UI_Tab_GachaShowPanel_A090', '', '', '', '', 7000, 1, 'UI_GACHA_SHOW_PANEL_A021_TITLE', '14410');
/*!40000 ALTER TABLE `t_gacha_schedule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_gameplay_recommendation_config`
--

DROP TABLE IF EXISTS `t_gameplay_recommendation_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_gameplay_recommendation_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '条目ID',
  `begin_time` datetime NOT NULL COMMENT '生效时间',
  `json_str` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '定义为proto::GameplayRecommendationConfig',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0不生效，1生效',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `begin_time` (`begin_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='养成推荐数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_gameplay_recommendation_config`
--

LOCK TABLES `t_gameplay_recommendation_config` WRITE;
/*!40000 ALTER TABLE `t_gameplay_recommendation_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_gameplay_recommendation_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_h5_activity_schedule_config`
--

DROP TABLE IF EXISTS `t_h5_activity_schedule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_h5_activity_schedule_config` (
  `schedule_id` int NOT NULL COMMENT '排期ID',
  `activity_id` int NOT NULL COMMENT '活动ID',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `content_close_time` datetime NOT NULL COMMENT '玩法结束时间',
  `prefab_path` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '活动底图文件',
  `url_cn` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '活动链接（国内）',
  `url_os` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '活动链接（海外）',
  `is_entrance_open` tinyint NOT NULL DEFAULT '1' COMMENT '入口开关：0关闭，1开放',
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='H5活动排期配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_h5_activity_schedule_config`
--

LOCK TABLES `t_h5_activity_schedule_config` WRITE;
/*!40000 ALTER TABLE `t_h5_activity_schedule_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_h5_activity_schedule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_inject_fix_config`
--

DROP TABLE IF EXISTS `t_inject_fix_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_inject_fix_config` (
  `config_id` int unsigned NOT NULL,
  `inject_fix` blob NOT NULL COMMENT 'inject_fix',
  `uid_list` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '白名单多个,隔开，空表示不开启白名单',
  `platform_type_list` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '(如安卓 ios) 多个,隔开，空表示对平台不做要求',
  `percent` tinyint NOT NULL DEFAULT '0' COMMENT '灰度百分比',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='inject_fix 配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_inject_fix_config`
--

LOCK TABLES `t_inject_fix_config` WRITE;
/*!40000 ALTER TABLE `t_inject_fix_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_inject_fix_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_live_schedule_config`
--

DROP TABLE IF EXISTS `t_live_schedule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_live_schedule_config` (
  `live_id` int NOT NULL AUTO_INCREMENT COMMENT '直播ID',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  `live_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '直播地址',
  `spare_live_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '备用直播地址',
  PRIMARY KEY (`live_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='直播排期表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_live_schedule_config`
--

LOCK TABLES `t_live_schedule_config` WRITE;
/*!40000 ALTER TABLE `t_live_schedule_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_live_schedule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_black_ip_config`
--

DROP TABLE IF EXISTS `t_login_black_ip_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_black_ip_config` (
  `ip` int unsigned NOT NULL,
  `ip_str` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '对应的字符串',
  PRIMARY KEY (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='注册&登录ip黑名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_black_ip_config`
--

LOCK TABLES `t_login_black_ip_config` WRITE;
/*!40000 ALTER TABLE `t_login_black_ip_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_login_black_ip_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_black_uid_config`
--

DROP TABLE IF EXISTS `t_login_black_uid_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_black_uid_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `uid` int unsigned NOT NULL,
  `begin_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `msg` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='登入黑名单配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_black_uid_config`
--

LOCK TABLES `t_login_black_uid_config` WRITE;
/*!40000 ALTER TABLE `t_login_black_uid_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_login_black_uid_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_reward_config`
--

DROP TABLE IF EXISTS `t_login_reward_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_reward_config` (
  `config_id` int NOT NULL AUTO_INCREMENT,
  `config_type` tinyint NOT NULL DEFAULT '0',
  `reward_rules` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_valid_days` int NOT NULL,
  `email_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_sender` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `item_list` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖励列表，proto3的json格式',
  `effective_account_type_list` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `begin_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `enabled` tinyint NOT NULL DEFAULT '1' COMMENT '0不生效，1生效',
  `tag` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签',
  `importance` int NOT NULL DEFAULT '0',
  `is_collectible` tinyint NOT NULL DEFAULT '0' COMMENT '0不可收藏，1可收藏',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='每日登入奖励配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_reward_config`
--

LOCK TABLES `t_login_reward_config` WRITE;
/*!40000 ALTER TABLE `t_login_reward_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_login_reward_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_luashell_config`
--

DROP TABLE IF EXISTS `t_luashell_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_luashell_config` (
  `luashell_config_id` int unsigned NOT NULL,
  `lua_shell` mediumblob NOT NULL COMMENT 'lua脚本',
  `uid_list` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '白名单多个,隔开，空表示不开启白名单',
  `platform_type_list` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '(如安卓 ios) 多个,隔开，空表示对平台不做要求',
  `percent` tinyint NOT NULL DEFAULT '0' COMMENT '灰度百分比',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `protocol_type` int unsigned NOT NULL DEFAULT '0' COMMENT '协议类型',
  `use_type` int unsigned NOT NULL DEFAULT '1' COMMENT '用于标识luashell的用途：1.普通luashell；2.安全库lua',
  `is_check_client_report` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否检查客户端回复上报',
  `is_kick` tinyint(1) NOT NULL DEFAULT '0' COMMENT '检查客户端回复失败后是否踢下线',
  `check_json_key` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '检查客户端回复的key的字符串',
  `channel` int NOT NULL DEFAULT '0' COMMENT '下发通道',
  PRIMARY KEY (`luashell_config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='luashell 配置表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_luashell_config`
--

LOCK TABLES `t_luashell_config` WRITE;
/*!40000 ALTER TABLE `t_luashell_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_luashell_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_mail_block_tag_config`
--

DROP TABLE IF EXISTS `t_mail_block_tag_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_mail_block_tag_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `tag` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='邮件屏蔽标签配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_mail_block_tag_config`
--

LOCK TABLES `t_mail_block_tag_config` WRITE;
/*!40000 ALTER TABLE `t_mail_block_tag_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_mail_block_tag_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_mtp_blacklist_config`
--

DROP TABLE IF EXISTS `t_mtp_blacklist_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_mtp_blacklist_config` (
  `ID` int NOT NULL AUTO_INCREMENT COMMENT '默认主键',
  `type` int unsigned NOT NULL DEFAULT '0' COMMENT '对抗类型',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='MTP要踢下线的黑名单ID';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_mtp_blacklist_config`
--

LOCK TABLES `t_mtp_blacklist_config` WRITE;
/*!40000 ALTER TABLE `t_mtp_blacklist_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_mtp_blacklist_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_mtp_whitelist_config`
--

DROP TABLE IF EXISTS `t_mtp_whitelist_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_mtp_whitelist_config` (
  `id` int NOT NULL COMMENT 'mtp上报id',
  `reason` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'mtp上报id对应的reason',
  `match_type` int NOT NULL COMMENT '匹配类型：1、2、3分别表示包含、开头、单一'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='MTP白名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_mtp_whitelist_config`
--

LOCK TABLES `t_mtp_whitelist_config` WRITE;
/*!40000 ALTER TABLE `t_mtp_whitelist_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_mtp_whitelist_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_op_activity_schedule_config`
--

DROP TABLE IF EXISTS `t_op_activity_schedule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_op_activity_schedule_config` (
  `schedule_id` int NOT NULL AUTO_INCREMENT COMMENT '排期ID',
  `config_id` int NOT NULL DEFAULT '0' COMMENT '活动配置ID',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='运营活动配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_op_activity_schedule_config`
--

LOCK TABLES `t_op_activity_schedule_config` WRITE;
/*!40000 ALTER TABLE `t_op_activity_schedule_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_op_activity_schedule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_questionnaire_mail_config`
--

DROP TABLE IF EXISTS `t_questionnaire_mail_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_questionnaire_mail_config` (
  `config_id` int NOT NULL AUTO_INCREMENT,
  `email_valid_days` int NOT NULL,
  `email_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_sender` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `email_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `item_list` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖励列表，proto3的json格式',
  `begin_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `enabled` tinyint NOT NULL DEFAULT '1' COMMENT '0不生效，1生效',
  `tag` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '标签',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='邮件配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_questionnaire_mail_config`
--

LOCK TABLES `t_questionnaire_mail_config` WRITE;
/*!40000 ALTER TABLE `t_questionnaire_mail_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_questionnaire_mail_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rebate_config`
--

DROP TABLE IF EXISTS `t_rebate_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rebate_config` (
  `account_type` int unsigned NOT NULL DEFAULT '0' COMMENT '账号类型',
  `account_uid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '绑定的账号UID',
  `item_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '充值返利道具列表，先逗号再冒号分隔',
  PRIMARY KEY (`account_type`,`account_uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='充值返利名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rebate_config`
--

LOCK TABLES `t_rebate_config` WRITE;
/*!40000 ALTER TABLE `t_rebate_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_rebate_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_red_point_config`
--

DROP TABLE IF EXISTS `t_red_point_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_red_point_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '条目ID',
  `content_id` int unsigned NOT NULL COMMENT '活动ID或调查问卷ID等二级ID',
  `trigger_time` datetime NOT NULL COMMENT '触发时间',
  `expire_time` datetime NOT NULL COMMENT '失效时间',
  `red_point_type` int unsigned NOT NULL COMMENT '红点类型（红点ID/红点位key）',
  `is_daily_refresh` int unsigned NOT NULL COMMENT '是否进行每日刷新',
  `daily_refresh_second` int unsigned NOT NULL COMMENT '每天0点开始的第几秒进行每日刷新',
  `player_level` int unsigned NOT NULL DEFAULT '0' COMMENT '最小玩家等级',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='全服红点配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_red_point_config`
--

LOCK TABLES `t_red_point_config` WRITE;
/*!40000 ALTER TABLE `t_red_point_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_red_point_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_register_black_ip_config`
--

DROP TABLE IF EXISTS `t_register_black_ip_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_register_black_ip_config` (
  `ip` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ip_desc` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'IP地址备注信息',
  PRIMARY KEY (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='注册ip黑名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_register_black_ip_config`
--

LOCK TABLES `t_register_black_ip_config` WRITE;
/*!40000 ALTER TABLE `t_register_black_ip_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_register_black_ip_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_security_library_config`
--

DROP TABLE IF EXISTS `t_security_library_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_security_library_config` (
  `platform_type_str` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '平台类型，定义在define.proto的PlatformType',
  `version_str` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版本号',
  `md5_list` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'md5校验值，逗号分隔',
  `is_forbid_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'MD5不一致时是否禁止登录',
  `enabled` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0不生效，1生效',
  PRIMARY KEY (`platform_type_str`,`version_str`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='安全库配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_security_library_config`
--

LOCK TABLES `t_security_library_config` WRITE;
/*!40000 ALTER TABLE `t_security_library_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_security_library_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sign_in_schedule_config`
--

DROP TABLE IF EXISTS `t_sign_in_schedule_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sign_in_schedule_config` (
  `schedule_id` int NOT NULL AUTO_INCREMENT COMMENT '排期ID',
  `config_id` int NOT NULL DEFAULT '0' COMMENT '签到配置ID',
  `begin_time` datetime NOT NULL COMMENT '开始时间',
  `end_time` datetime NOT NULL COMMENT '结束时间',
  PRIMARY KEY (`schedule_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='签到活动配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sign_in_schedule_config`
--

LOCK TABLES `t_sign_in_schedule_config` WRITE;
/*!40000 ALTER TABLE `t_sign_in_schedule_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_sign_in_schedule_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_stop_server_login_white_ip_config`
--

DROP TABLE IF EXISTS `t_stop_server_login_white_ip_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_stop_server_login_white_ip_config` (
  `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='停服时二级dispatch登录白名单';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_stop_server_login_white_ip_config`
--

LOCK TABLES `t_stop_server_login_white_ip_config` WRITE;
/*!40000 ALTER TABLE `t_stop_server_login_white_ip_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_stop_server_login_white_ip_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_textmap_config`
--

DROP TABLE IF EXISTS `t_textmap_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_textmap_config` (
  `text_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'textmap的key',
  `delete_time` datetime NOT NULL COMMENT '失效时间，时间一到就会删除这条记录',
  `en` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '英文',
  `sc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '简体中文',
  `tc` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '繁体中文',
  `fr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '法语',
  `de` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '德语',
  `es` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '西班牙语',
  `pt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '葡萄牙语',
  `ru` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '俄语',
  `jp` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '日语',
  `kr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '韩语',
  `th` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '泰文',
  `vn` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '越南语',
  `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '印尼语',
  `tr` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '土耳其语',
  `it` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '意大利语',
  PRIMARY KEY (`text_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='服务端的textmap一般用于邮件，需要控制条目，因为全部加载到内存中';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_textmap_config`
--

LOCK TABLES `t_textmap_config` WRITE;
/*!40000 ALTER TABLE `t_textmap_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_textmap_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `db_hk4e_global_deploy`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_hk4e_global_deploy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_hk4e_global_deploy`;

--
-- Table structure for table `t_anti_cheat_client_channel_id_config`
--

DROP TABLE IF EXISTS `t_anti_cheat_client_channel_id_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_anti_cheat_client_channel_id_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版本号',
  `channel_id` int unsigned NOT NULL DEFAULT '0' COMMENT '渠道类型',
  `is_forbid_login` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否禁止登录',
  `checksum` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'checksum校验值',
  `anti_cheat_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '其他配置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='客户端渠道配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_anti_cheat_client_channel_id_config`
--

LOCK TABLES `t_anti_cheat_client_channel_id_config` WRITE;
/*!40000 ALTER TABLE `t_anti_cheat_client_channel_id_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_anti_cheat_client_channel_id_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_area_config`
--

DROP TABLE IF EXISTS `t_area_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_area_config` (
  `area_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '地区类型',
  `business` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务英文标识',
  `business_cn` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '业务中文标识',
  PRIMARY KEY (`area_type`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='地区信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_area_config`
--

LOCK TABLES `t_area_config` WRITE;
/*!40000 ALTER TABLE `t_area_config` DISABLE KEYS */;
INSERT INTO `t_area_config` VALUES ('CN','bus','业务'),('OS','bus','业务');
/*!40000 ALTER TABLE `t_area_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_authkey_config`
--

DROP TABLE IF EXISTS `t_authkey_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_authkey_config` (
  `version` int unsigned NOT NULL COMMENT '密钥版本',
  `private_key` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '密钥',
  PRIMARY KEY (`version`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='密钥管理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_authkey_config`
--

LOCK TABLES `t_authkey_config` WRITE;
/*!40000 ALTER TABLE `t_authkey_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_authkey_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_bind_config`
--

DROP TABLE IF EXISTS `t_bind_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_bind_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '客户端版本号',
  `region_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '绑定的服务器分区',
  `channel_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '渠道类型',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `FK_t_bind_config_t_client_config` (`client_version`) USING BTREE,
  KEY `FK_t_bind_config_t_region_config` (`region_name`) USING BTREE,
  CONSTRAINT `FK_t_bind_config_t_client_config` FOREIGN KEY (`client_version`) REFERENCES `t_client_config` (`version`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_t_bind_config_t_region_config` FOREIGN KEY (`region_name`) REFERENCES `t_region_config` (`name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='客户端、服务器绑定关系';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_bind_config`
--

LOCK TABLES `t_bind_config` WRITE;
/*!40000 ALTER TABLE `t_bind_config` DISABLE KEYS */;
INSERT INTO `t_bind_config` VALUES (1,'OSCBWin3.1.50','dev_docker','1');
INSERT INTO `t_bind_config` VALUES (2,'OSRELWin3.2.0','dev_docker','1');
INSERT INTO `t_bind_config` VALUES (3,'OSRELAndroid3.2.0','dev_docker','1');
/*!40000 ALTER TABLE `t_bind_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_channel_id_config`
--

DROP TABLE IF EXISTS `t_channel_id_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_channel_id_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `channel_id` int unsigned NOT NULL DEFAULT '0' COMMENT '渠道类型',
  `enable_login_pc` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否可以登陆PC',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `channel_id` (`channel_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='渠道配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_channel_id_config`
--

LOCK TABLES `t_channel_id_config` WRITE;
/*!40000 ALTER TABLE `t_channel_id_config` DISABLE KEYS */;
INSERT INTO `t_channel_id_config` VALUES (1,1,1);
/*!40000 ALTER TABLE `t_channel_id_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_client_channel_id_config`
--

DROP TABLE IF EXISTS `t_client_channel_id_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_client_channel_id_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版本号',
  `channel_id` int unsigned NOT NULL DEFAULT '0' COMMENT '渠道类型',
  `sub_channel_id` int unsigned NOT NULL DEFAULT '0' COMMENT '子渠道类型',
  `force_update_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '强更配置',
  `stop_server_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '停服配置',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='客户端渠道配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_client_channel_id_config`
--

LOCK TABLES `t_client_channel_id_config` WRITE;
/*!40000 ALTER TABLE `t_client_channel_id_config` DISABLE KEYS */;
INSERT INTO `t_client_channel_id_config` VALUES (1,'OSCBWin3.1.50',1,1,'','');
INSERT INTO `t_client_channel_id_config` VALUES (2,'OSRELWin3.2.0',1,1,'','');
INSERT INTO `t_client_channel_id_config` VALUES (3,'OSRELAndroid3.2.0',1,1,'','');
/*!40000 ALTER TABLE `t_client_channel_id_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_client_config`
--

DROP TABLE IF EXISTS `t_client_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_client_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版本号',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版本名',
  `stop_server_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '停服配置',
  `client_custom_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客户端自定义配置，服务器直接转发回客户端',
  `dispatch_seed` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '二级dispatch版本校验码',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `version` (`version`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='客户端配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_client_config`
--

LOCK TABLES `t_client_config` WRITE;
/*!40000 ALTER TABLE `t_client_config` DISABLE KEYS */;
INSERT INTO `t_client_config` VALUES (1,'OSCBWin3.1.50','OSCBWin','','{\"sdkenv\":\"1\",\"checkdevice\":false,\"loadPatch\":false,\"showexception\":false,\"regionConfig\":\"pm|fk|add\",\"downloadMode\":\"0\"}','8b8977a642eff22b');
INSERT INTO `t_client_config` VALUES (2,'OSRELWin3.2.0','OSRELWin','','{\"sdkenv\":\"1\",\"checkdevice\":false,\"loadPatch\":false,\"showexception\":false,\"regionConfig\":\"pm|fk|add\",\"downloadMode\":\"0\"}','b196f78211a8c830');
INSERT INTO `t_client_config` VALUES (3,'OSRELAndroid3.2.0','OSRELAndroid','','{\"sdkenv\":\"1\",\"checkdevice\":false,\"loadPatch\":false,\"showexception\":false,\"regionConfig\":\"pm|fk|add\",\"downloadMode\":\"0\"}','027d8a5fcdc9c5cf');
/*!40000 ALTER TABLE `t_client_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_client_region_config`
--

DROP TABLE IF EXISTS `t_client_region_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_client_region_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `client_version` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版本号',
  `region_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '版本名',
  `client_region_custom_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客户端区服自定义配置',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `client_version` (`client_version`) USING BTREE,
  KEY `region_name` (`region_name`) USING BTREE,
  CONSTRAINT `client_version` FOREIGN KEY (`client_version`) REFERENCES `t_client_config` (`version`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `region_name` FOREIGN KEY (`region_name`) REFERENCES `t_region_config` (`name`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='客户端对应分区配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_client_region_config`
--

LOCK TABLES `t_client_region_config` WRITE;
/*!40000 ALTER TABLE `t_client_region_config` DISABLE KEYS */;
INSERT INTO `t_client_region_config` VALUES (1,'OSCBWin3.1.50','dev_docker','');
INSERT INTO `t_client_region_config` VALUES (2,'OSRELWin3.2.0','dev_docker','');
INSERT INTO `t_client_region_config` VALUES (3,'OSRELAndroid3.2.0','dev_docker','');
/*!40000 ALTER TABLE `t_client_region_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_deploy_textmap_config`
--

DROP TABLE IF EXISTS `t_deploy_textmap_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_deploy_textmap_config` (
  `text_id` int unsigned NOT NULL AUTO_INCREMENT COMMENT 'textmap的key',
  `en` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '英文',
  `sc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '简体中文',
  `tc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '繁体中文',
  `fr` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '法语',
  `de` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '德语',
  `es` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '西班牙语',
  `pt` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '葡萄牙语',
  `ru` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '俄语',
  `jp` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '日语',
  `kr` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '韩语',
  `th` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '泰文',
  `vn` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '越南语',
  `id` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '印尼语',
  `tr` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '土耳其语',
  `it` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '意大利语',
  PRIMARY KEY (`text_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='服务端的textmap一般用于停服强更等多文本，需要控制条目，因为全部加载到内存中';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_deploy_textmap_config`
--

LOCK TABLES `t_deploy_textmap_config` WRITE;
/*!40000 ALTER TABLE `t_deploy_textmap_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_deploy_textmap_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_login_white_ip_config`
--

DROP TABLE IF EXISTS `t_login_white_ip_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_login_white_ip_config` (
  `ip` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `desc` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`ip`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='登入IP白名单列表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_login_white_ip_config`
--

LOCK TABLES `t_login_white_ip_config` WRITE;
/*!40000 ALTER TABLE `t_login_white_ip_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_login_white_ip_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_psn_region_config`
--

DROP TABLE IF EXISTS `t_psn_region_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_psn_region_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `psn_region` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'psn地区',
  `region_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '区服名称',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `psn_region` (`psn_region`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='psn对应区服配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_psn_region_config`
--

LOCK TABLES `t_psn_region_config` WRITE;
/*!40000 ALTER TABLE `t_psn_region_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_psn_region_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_region_config`
--

DROP TABLE IF EXISTS `t_region_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_region_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分区名称',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '显示名称',
  `region_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '分区类型，线上、审核等',
  `area_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '地区类型',
  `dispatch_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'dispatch的URL',
  `muipserver_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'muipserver的URL',
  `account_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '通行证URL, CB2后废弃',
  `account_url_bak` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '通行证URL备份, CB2后废弃',
  `sdk_env` int NOT NULL COMMENT 'CB2启用，0:国内正式环境 1:国内测试环境 2: 海外正式环境  3:海外测试环境',
  `account_inner_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '通行证玩家信息URL',
  `pay_callback_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支付回调URL',
  `resource_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '资源URL',
  `resource_url_bak` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '资源url备份',
  `data_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '数据URL',
  `data_url_bak` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '数据url备份',
  `feedback_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '反馈URL运营方的需求',
  `bulletin_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '公告URL运营方的需求',
  `handbook_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '游戏指南url',
  `stop_server_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '停服配置',
  `stop_register_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '注册配置',
  `region_custom_config_str` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客户端自定义配置，如果和client_config有字段冲突，则以client表为准',
  `client_secret_key` varbinary(4096) NOT NULL DEFAULT '' COMMENT '客户端首包加密密钥',
  `server_secret_key` varbinary(4096) NOT NULL DEFAULT '' COMMENT '服务端首包加密密钥',
  `official_community_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '官方社区URL',
  `psn_region` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支持psn地区',
  `user_center_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户中心URL',
  `account_bind_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '帐户绑定URL',
  `cdkey_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '兑换码URL',
  `privacy_policy_url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '隐私政策URL',
  `rsa_key_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '该区服允许的key_id_list，包含0时表示全部允许，以逗号隔开',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `name` (`name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_region_config`
--

LOCK TABLES `t_region_config` WRITE;
/*!40000 ALTER TABLE `t_region_config` DISABLE KEYS */;
INSERT INTO `t_region_config` VALUES (1,'dev_docker','Docker','DEV_PUBLIC','OS','http://127.0.0.1:10105/query_cur_region','http://127.0.0.1:10106/','','',1,'','','','','','','','','','','','{}',0x4563326210000000E8CCEF322ACCB92712341C504398F2100008000091C5FD1F634CB902E83F2D8B17F64257975F2FF6D87DC927E5143373C161358237BCB7CB9210B73C06A466FB5152A85B2CE6492C55650B24D37F0CF8F57C3672824EC0B26AAA22F025D8076A143F4BD6D38D16A7857AA099BB047166D1B459F7C4E6FCD8F930B14A6CBAE72D92349474B8124EFDAC812ABE73A90E5023EA147981F5A5CE6E96E835BC495C0971EE0D3B9D7DFA4BF0B90C9FF431A1C86FEB17FD4AC209BC2908DA83C4D82ACC02254894DD9ECE909AF2425D15AE5EBF80F6BDA3CB146F988FC630D2CCD718F61719D1C0417D659B9171BDEB18BD7A561A37D0769F9071EE8138263DA0165DCA8A5966B861B227E818564EBB65CA164FE1F64370A7C985810CFB41E25A26AA3FF5CD869E3FB4752C8AEA6BD475C01206E02000C104833CE1F55DCA1D8B1EDBDBA655659B9E07A47CB53814E580D6D781C2C5886BFC1D32ED4BA59F0CD71D0075BD6B64779E3AE1126BF25298A82B3870038F832098689662EBBBA48D5704D8240FD5CE216C9BBB78F71FFF1C6E18A02ACA4BBAF1E382AAF42205E8DEB210AB653A60F277C10A71F3878F06DEC093443831663CF246FC04B5A9F5CBBAC304D30147B0C7E368D5FAFEF2BE90A316CC78E8953575F50FAA5E441D051C0E22194D1F5E979409265CA905F59D487ADDE466FA0DE4C803021471C0C1C592761CA9030228D1E7B78E813225ADD3E953045997C14165F07A4B80774B923434D3E57262D77CBBA1F78EB2184D18096D197652955FBA1F86749E3DBEEE045B67DAE4706F995D2796833F76BDD6E3C79EC130CC8663E587B8CEFC18BFE49DAC2620046A5B78743BB9245AB9BF127AFDD203088D66A21CB5070B5905A4E0B97CBA6A8E08DA68B3C2B26298CC5D2CA72B10EE10C9CA196A040263CDFD0B8194C04DE9066484A259408352792AA104C7F194439AAFE28BDB2657CEBF8BBC8E17E3E82F2D321CD097F8D1AA2946E1817DB6CDB4250ED6F03AF90E75221DC6DF73441CB5B95DD5975B763E09214E76FFE1A5FD53D33B7A028D162EA095BF97180085FDB7966C742CAB876EDC26A65CF49D0332DF3C1E87B52E3B3B179596493E57BAF4930E377AFA7284F83B27B0637B1E5AA8F2FE0DD2D2CCDBE85193C814997D27EA0F4CBC5BC9502D0F8C5843121D2B4DD72E609F436229F680BEB6C452AED0B242E2D494B103F8DA04334B87FAF1D98FDEFD7E9D271D13F73EE8410EBA274DEA3D971B3249FECB664054864A4B38C22C81C0C88DCD94D91B360613E3E013AC3AAF4199DDE83CE09540092719EB9427A703942C15F43F710511FF70DDD6A8ECA21E6A47818A427E9C9602669D62348FEF853A8ED899BA103BFDE332BADEDD32360520236E726BED85CA61CB2A7B121C6BCCEA18A96423537373BA6EAEEF4E67192D9FEFC548C904C7A1543999593198C59821C14A0E53A30C3A625690418C35B4481FB393ECF3F2DE7546BBD38F6451A4A9FCC1F6569492DED5B5D9D65B281FC84530191D9DFD9A3171D127177CB5FE7C4360D64C301C0BE6BED4CB99D1AF347B94304E840B6CAB918E1822E1EE8E5D22C18F27C7DD02C37FE3AC5AF00C7CF3486DDA9B7BC2E16125CEE5563C19E053E295BEF6360098943DC7AFA34DEBE20D38495016B3741E4BB29822B359B4E4DE3F9BD3CCC45229D6FB0770EBCD39359EC5180D2EF5B924DD52C50ACD8A8B7CCAB17EC4E4450DB7FF34DF8BBD53BB65363177E454110567233C98A709C0E692E86B5563B1BF15A3D101723D7576574D9B1FCCC1DC2183752472E4C0122CE91F3C5596A2BE255CD4F864DF4DF86134E211F8960965468B247391DB41AFF476722F1660A4F0485CB936582F378CCF70E00BAB488E9265CFFB81A603239947040A6EF44AAD71DEDB3CC64E4391257D90F08CE2794385C9CDD23B3518692C9E35A0932284EF6EE39EC43FBBC287C70912867AF909A0F37E9B34545617CC8BDBDEC9774401470B13B5BDAB6F320B8E615B76EE80C93E7B6FDFB6A4AC9F3568B9BDF8B2DDFC178E0C8F930B84DC9B01878FDC0947C01BF41F3ADB041896AE4D36F79A2664B6F3CE8E956601ED4661DEF7F57E1698A06C1B357B7FA44CAC0BDC8E7EBF967C5B710503D8542717686DCEA557C4783289AFAD7F239892AAFE5E82D8AF022BA624162C47DA68B5D2EDD089DEC046B069628A95AF9A2DFCA9AE0D62DF5C901FC5AD63CE24F288C07E54D54B4720B53802BF2308FC7D16E79CDD384556468195CCFAFF8CE1EDF0E23528939ABB4899E4B10A02800F5511A5B7D92FC2632361C59699B9D0136873409DAAE2889C7E6618F18AAB360F26615A478756BBF123397A10958F3DDB8D9F33EB320E1027942030A991C92A3BE48188F4EB904C7187BBB22F662C2D2E360C827597DD05227CE75E9B532688756CF444AD387D7BF814ECE5472B17A9EA67974C286C6E5EEFAE9851D2766B8027A00A4807178B71FB707247A45D2EC53EBAB8C30F3C99EC333D132BD5C98222CE6D0E46D83ED248AC7E8394BC56CE399307B93369CADBC7DFD6E543772C59118FB1DF5EB9F092EAFD1D2E488D611B5691E85CABABFC8DC3A6F0C24278F86156B35E36A8382C60978217DAA37E692B997CC99940A737D7FA21B781C69D0D4A60F62A85E73C2F5914FD32AA9B7E871BC4EE0D4DA491A7E7575554C2FCC66EA27362A0153A978B31E9DD8BDD393DFAAF747CA1F24DABEE7634F09BA2D9366E6C645DD993FA51AEE8AEFB2635A73E8D50D2AA02AE4CD75DA282DBFCD2B6AA9C4085B5895B716F6E4F7A58841FD39EB2902FBAABB554DBCE362CA701C446F482E95478F49D97176819B08780DD43CB3BEB3E41B1AE60978DA1D2C570A9A691D913FC316F6C052CB1481A3D2640520B471ECEB2BCAF2CCE8413,0x74E16FB83D07E99841998B1F5E30E525B0B0D265C4A60DF6534AA1C38E80E87C0D2EA19265153C17728ECEB4E3B27673031121ADE3E0C5CCEE2F15721D601EFFDF3F0D614009F21111EFF89B1391DB905E77791989948D35FCD5EB656617E50D4B1D74DF217A9FC5EC1E86821F668FB71612563DABA167C801D92314DC448471DEFB9DAEAFF653A0134F92712EDE86A93B48F3ABB11ABD889F67A42D44947C9142CB8ABF5331C2625691377D46ED8FA73C1C5B6C6C9EF282E2F53B2F14C970B3534ED607922B7EA4DA2CA75B760FF2CB767762684F36AEA8E624CB8CBEE13DF3E5963107BD17CC30001430C79D080EE47617400A4089119D7803C5CA209B97807595A9BD33CCC4D83B0AAEBB72DB616C906E0248E08A4FB01271A8AAEBAE21460CC93984E26E9D939847B39D8429854E7135AFF55738D8F5E2FC434D445F15CACF332D90D9F406489347A10A56B9073E14C43F32A059404D987EDBEA29C1191BD2CFD985DD226A6D69FF3E66D17EC8D04C71AB967D04DC203B08B375C3D1C2FD38A1B5FEEAC31EFD7F210047B8E9D483A8C33FAA5854FFABC5C329BA481B99A8D196B6DD43477C421B922D80771A03EACCE5DCB2BEE7F8294F76072E398FDC3DEEE65DD16BFFE9BE1F57917FA2B5F6E5A78B1995F8984ED9FF24BDAAE836099A0DF65F788198FCCEEC0D8C74F7E9D4AA3243DFAE931D2DA9518088EC0EBB8244CDEFF4E9DDAD7F73DB771DACF7C4C612F1AC3664342B56209A5D20BEA7126A12F1795F5A962DE20D60A2EF935FA692B5D7DA05B7C85B8E99F0335B4C2F7C81346ABAB4A4DEE84A7F330876973EE9D10EAC028310BF33A1FAF97A1917E8746F5942EDDEA75FC59BB057E1742AA4DF203B8056ACB72121173B08E39E936BAE68D119C30296C90794B7C7676A314EC14B555AD2234053D960380A8605609114860FDFCDDDC47207A70F721015EE1B838393C48FCE1852651F58CCC79A3114B258AA08C7718D8B10C7CD39D8E1276092B7ACA41FB12AB934041F487F16D1C28FF27A4F7857C3217DFC1A6CC8FB212C237DB8AE462D7969F63F15C9FAFB61733C24F2F100AE7501C468B796CBD94D931967CC374C38CD84BB743A128CD3FCB90239A6BDB149B7079347BA07E9F18FA121E64759F740AE1C07707D6B97DBDEDA15175C17A335304C46C57C48B4F7935B4D2A59144B1A5713B59DB53C71384AFE69E9FA834C0E9A342BD016E79F0276B51AA58DB6C7AA6BCFC093DEDDA286C2E6076ED6A57E10D8F3F20E3757CB524D4EB0B959D4BC6358DED7A2FC4C439688080AB9266CACAD135F053DEF06BB8BB6286B4C0A62B5B83F1315978A9F328CE8FA31803F41B57EBCF6C5107ACAC0C07DE62FF7640C9EFEA8E905E36DD4541B18FD25420A74001295F7236CE71BB8220683F8366DFF64D500A2740D68B7145C8AA1292A26ED4DAD8368ACD4FF106A20E250614BC8678C8F5A1E3642EA6ADF402540DBEBAD2F6D2F6777911203D9B9BF0A974DF84AE87651554BB4DA337CE032E76BA539080EBC3ED8432177863EE2BCEE960B37C676CD843873103D5A9A1F44B9928AF1447E92182AAF8A0BDE387ADE7851CB0441A2214351CE7D8723E77137AB1DCE3175BD6B5B8A7EDC4F5E9E4C329E54E1279DF9FE16DC52B0631BC7C3D52BEC9D08F127C90D054A5C337F5323527EBE4A73DECC6AA2C9ABA880866077313146B9FC0D8AE8A35B1A1779350FA365380994D534AE8010D4F2D682BA533BA7D1FAD786DECEBC5A605E5999B56C43BA7023A5A5C2C7321EA158DC0F77308EBA066FAAA22D5BE3A454C57E2B28A3DA7552C27C62F40D9F199C4A986FE86BC80A0ABFA9E70CEF1861A820DBAD1F8AB674576DC15B802B8F505DB3660E8D6CDF8AB54D15E89CB3B5B688E18C184D2F8894FCBBE08862164A376BC799704B932917D9C1A9F55C981C90B3980412761B9E40E1E771CD20926EBD801E868CFE17EFB0A28435C0AEEDBD7775D95D8563C860859A31E5E5FF67E019D574BA25338B652ED236B910D14BE052FAF871B53432788F33A6D50E9F3FA29226FB314034EA161902F7B3528DD854D85BEC3594DAA8B665B22CC3AA7E6F10ADBCB06DED77B83B56EE921A5F9D8642CE74B68BA2C8E6D1ED5748BF6990246EC4C38DB375DADBE094719A4796E499932698F571A67F05DF1A2F3D2F7DF262DB0E12946CF7B478E946E64DA03813185976F1C664F17944956C318676B2907742F01BE18D7D397CAE7A8A22BD28C9751A2E978B33F277B360D87C9EAFF15ECCD869DF2A40E214054732766FCE8D03FC778E1FDC581B479AE6AC870073CD33F6845937A7824F190F75086C3A53F5F2D815C9CF05519C1D26DA9239A2027FEB2DCCB5C352D8690DE27FE99D1EC4D64BDA22E9F61EE1B03EE368DFDD8244DD839BBAD531C0B47D03BEEDFF7DB11E31135ADA00068F0A9937AA140B614AFBD62C3B95A971F5CBC1EDA932596E3A998E7AB01333ED11E992CAE80BC3778404583024B39B29FDF8C75AD9B0D67FDE99D55145263A251C9C841641F04CA8DC8464FC8D38175A2145A56972322F298D29877C17A34F2C5332DD787A24DD939DE9926110FC121376208DB2B3D1B3DF9201CBAF50044E86BED0775D724D2F0AE40E5972451067D452D5C67BFEED9F7BDD7B4FC14389E24EBF406F4CE199E589A89831783334EF24A1C96F8B207A1C45958AFB5950498D97BCDE76A10FB87501B8BC306AF8F7F937C020FC47BE6342C9D1A8F206FB3B390F80E225E4B105F27A5EDDE6C8464FCCB1CEEBCCF016A64E5B1AB03A1DF23A6F254AD47AA4196E88AF8A3381625AFB155F88292BF1E709718243C873E0F08EC3D7C5DADCAB0AAC9AF1528671F3EA27236C612E9C9317B416E8F156E1655C0A6F0524E99D2E1E945E73EE71EE59D7377B3630077311B235E0AE77CFF8887FB05E16A0D5479C07868AA7F6806887DA8DDF98AF4591C2A69DDE6EBE598675ED240C2D06BB9460AF0287E9B96A525D7CC1E962F5AC5A4A3D4960B17BFAA266D1C988CF54F3AA1E6F49A8D57A51853822501E8CC313C581C269F85517473A847E13B583F4C2D3C595B71702DD6A9163606A6CE4879BBF894036EB31A9FA1C816BEF8FACA2214568F6429FCE8DE163DE1D54748CE1F5A517BE0D14C46E72C63891EC77C70D46C0F7B61FCD97588DA485D00D071D7B47134E457BBEA8ADC9E960EE7ED78CE279AEC3726E427E17B0079110A118B30F3F77B53390601BF846007D671923CE4CA4638116F9BCD4E80070035D9D3602FD645B783B3D1DA37BB31B8D8C0653FD276E719E9F5B566604D59205C1DFCB59C98827DF243515D290122A58EFB9FF5E176272947A8C5B3209C7608A07D33A308B08C771FB4B8D895D38EECA073081B84926239814238B90EA34183B5975A1E3BE64B919CFA04669A9D7A23E408D125418AA369408E20695592C5A8B7119F0F02A2FBF09DDAE5470351046AFC84583FEB1BDE038B97079A189E97484190E6B54C992EFA04B7875A0086AC7F227A4F176826211C7B574372AC746CEF93657D64E769E82A32B112B412569E23ED2CA52C80EA6B473C001FC4E8846725B0518E1CB5F22A8CF7E54FCC47E56146996F8379EE5790086A90E6B6F2EB3B5BC9252C0019DC764B6ACE5DBDA691E636C03AC1780B9452645FC63C564FCF58A12859F17A0B418E9B123E29A2F9426FBBC306C65198AD98E592B2D2AC8FA17AE4857F911E8D4A8E1D0AEB846986F1BC0AA9C00F726066D631B6E3DA788F69D69BAF3C9423440D62DFAF13275E4896BB4323E32F710CF46EA4FDABFB0B371A7A221CDA0AF153D4213082888AB27F51FF3E2CC12B39D708B65379B78C5076B2CA780097D3A128B81548DDCB6FD58CA37D688DCA0B0763701EB5F6BB202F46F207247C65F38C9F5A28B72CF5179CFB9FC4C3A20A24AB203707571C14089DDFD2E60327F8708C81F257CD464AFFAB9F7B61A96B2F7F9ACF86B02A5F5F7F84475B2715DD2B59A1E813D4F9A9369AC031DB18A92211CEE94A1D87EC2B4ADAC410BE8CCB82AF0FC69E9D97C11815FDC2A3C7DB81ECF0D8BC7F131DAFD3E3E9CA3D96EF3C67D870ECD3D6B2D6C56E7DD8A2037495DEBEF10AB2205E318BBA3580A9FAB33ED3FF5EE1B294DA7D8DE841F300392F3C1D8FD80F418437C71A300F0E9A027314E1B54492414716CCEFA63987D9700B2D605CFB8B48FE677AC7DD89E5F276E8EE0CB06F253EC2B469786F2608505F1CF9111F4E4E457D60F9F3CF1B60239B5CB720111C457A54663C9C29C6E61F66A16EEB0003480953F53791C69BED06CDDA32082F9CDD2B20BCAE12B2603DD1373C642B1853375F4F80CCDFC03AFEFF5CB0A32E5777C60CBCA82A35C1F72B707705CAA94765C1C4FC161DCAC77527F9A1902E5C2D284E5153DDDC67384C8AC606FB539653921A57951B047800B737CEDE67EBC5F2105BA64324C02FC7B0AC500E2B71C4F7345D3B8CC22DEB06A782CBC642EA8DB0C486145DA51150D47EE7A3097659110D087702BA5B729A372EDB54F563A09CC63E6FFF18393BCB9ECE054B15843CEC292379EC6803D18EB58A6E3F1549041509B11742EED3C8160718B0249C08AD0525A63DCB103373887C29D8C5998F02BDAA4AC633F404B807C990C7AE33E80DFEACC2E5405AB702EE15EA638BC4A27DCCFFD4D97DEBA3C6CB71218FB0DDA39D8CC84B84095BCF47625F62CAA980C46CC8FEFA68BFC668628C3F0116AE8BE441EADC52DA7A7A296E914B20511D58C266B2ABD160254CCC4AF1E3BD2577EF658B99323A785FC76F2009F87F3D23B08EFE81C2ED9F7E8649CC0C1CD8D071931A090F0C91081F65CA27BD1ABE97A3A1E2AFE7EF2A0E8960F6C2D530246C2AEEE680CCEC439B5E687B7CB6E492CAFA7ACE828C166499C10193DCE5F161EA06BD31BFF074665E31F2E63B2CA29079CB097210EF7C90D2466FBB3F9AC87CEE641979D3C60A0105D5E514650997C568B8B5C84D04DD2048761E996684AB0787659D30F97F3839B393214310F4FCA54C96731BBBB77889C3722DB6B6C0CA2ED2CFD0524E8B3200F2710BF1D947233F39E28020CB663E2ADA7A1ED88359844CFA2E9976EDA8120F08D9C63071D8C98F6C589575C5184A9C9D93C8FD04AE9CBF843176E4F8594BD15846BD2CD0BC2F12CCE412B9E8193F836F8F0F346C11A27AFC2A1AC520EA6555FFA4584A4D7CFBFA7F82E860A363EAB96CAB6575F159484D33F7BC5CA080E3E8AD526F91AD7F18DD61B7F9ED52A92CE44B2FDE67E9C94C44B99BB60DAA87C3106E7313168EF24CFBB14F93FEB0160C661AB6AB8B73D4712E38FA086639857461D27F9E8BE29B0A5EE3686A0E4AA5C62BAB83D6EC976BB876E8786E0D692FD70FAE7C780AC5006C328B10B347FA74A12F246469058AEC0FBF29099ECF5D01FD3EB85A9658932DC249F9ACBAAC2EB2E41C96681806BD17B8584552FA74CC08F4CE75ED120CCE9E90F083C83B9E964BBD27586959FD884160A1CE2D1D779336DC550CBCDCCA8249A273FDCF90204756CE27699BAB55E1E83B269F4F486D7DDF9709F23D413801C904C48D9307D66406B294D913401A702C02F971DCD6CE183A3F0716C8E5AC9F9181A6F7756B71E2BAA0E27B7340863B3976C39E9B86DE47549849AE532188E525CFC25CEAB86AE7DFBB31CA9BD12B9C1F9CC3CF393B2B435FDE1067E73386DC725FFF19D546227D321A680E427160A92A2FE38EBF296794CA2B96C6262CA3DF01361CA38EE60E3CEA393D2242348251619E2F71CF220DF96,'','','','','','','2,3,4,5');
/*!40000 ALTER TABLE `t_region_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_rsakey_config`
--

DROP TABLE IF EXISTS `t_rsakey_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_rsakey_config` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '密钥对id',
  `client_public_key` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客户端公钥',
  `server_private_key` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '服务器私钥',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='非对称加密密钥';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_rsakey_config`
--

LOCK TABLES `t_rsakey_config` WRITE;
/*!40000 ALTER TABLE `t_rsakey_config` DISABLE KEYS */;
INSERT INTO `t_rsakey_config` VALUES (2,'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz/fyfozlDIDWG9e3Lb29\n+7j3c66wvUJBaBWP10rB9HTE6prjfcGMqC9imr6zAdD9q+Gr1j7egvqgi3Da+VBA\nMFH92/5wD5PsD7dX8Z2f4o65Vk2nVOY8Dl75Z/uRhg0Euwnfrved69z9LG6utmly\nv6YUPAflXh/JFw7Dq6c4EGeR+KejFTwmVhEdzPGHjXhFmsVt9HdXRYSf4NxHPzOw\nj8tiSaOQA0jC4E4mM7rvGSH5GX6hma+7pJnl/5+rEVM0mSQvm0m1XefmuFy040bE\nZ/6O7ZenOGBsvvwuG3TT4FNDNzW8Dw9ExH1l6NoRGaVkDdtrl/nFu5+a09Pm/E0E\nlwIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAxbbx2m1feHyrQ7jP+8mtDF/pyYLrJWKWAdEv3wZrOtjOZzeL\nGPzsmkcgncgoRhX4dT+1itSMR9j9m0/OwsH2UoF6U32LxCOQWQD1AMgIZjAkJeJv\nFTrtn8fMQ1701CkbaLTVIjRMlTw8kNXvNA/A9UatoiDmi4TFG6mrxTKZpIcTInvP\nEpkK2A7Qsp1E4skFK8jmysy7uRhMaYHtPTsBvxP0zn3lhKB3W+HTqpneewXWHjCD\nfL7Nbby91jbz5EKPZXWLuhXIvR1Cu4tiruorwXJxmXaP1HQZonytECNU/UOzP6GN\nLdq0eFDE4b04Wjp396551G99YiFP2nqHVJ5OMQIDAQABAoIBAQDEeYZhjyq+avUu\neSuFhOaIU4/ZhlXycsOqzpwJvzEz61tBSvrZPA5LSb9pzAvpic+7hDH94jX89+8d\nNfO7qlADsVNEQJBxuv2o1MCjpCRkmBZz506IBGU60Kt1j5kwdCEergTW1q375z4w\nl8f7LmSL2U6WvKcdojTVxohBkIUJ7shtmmukDi2YnMfe6T/2JuXDDL8rvIcnfr5E\nMCgPQs+xLeLEGrIJdpUy1iIYZYrzvrpJwf9EJL3D0e7jkpbvAQZ8EF9YhEizJhOm\ndzTqW4PgW2yUaHYd3q5QjiILy7AC+oOYoTZln3RfjPOxl+bYjeMOWlqkgtpPQkAE\n4I64w8RZAoGBAPLR44pEkmTdfIIF8ZtzBiVfDZ29bT96J0CWXGVzp8x6bSu5J5jl\ns7sP8DEcjGZ6vHsLGOvkcNxzcnR3l/5HOz6TIuvVuUm36b1jHltq1xZStjGeKZs1\nihhJSu2lIA+TrK8FCRnKARJ0ughXGNZFItgeM230Sgjp2RL4ISXJ724XAoGBANBy\nS2RwNpUYvkCSZHSFnQM/jq1jldxw+0p4jAGpWLilEaA/8xWUnZrnCrPFF/t9llpb\ndTR/dCI8ntIMAy2dH4IUHyYKUahyHSzCAUNKpS0s433kn5hy9tGvn7jyuOJ4dk9F\no1PIZM7qfzmkdCBbX3NF2TGpzOvbYGJHHC3ssVr3AoGBANHJDopN9iDYzpJTaktA\nVEYDWnM2zmUyNylw/sDT7FwYRaup2xEZG2/5NC5qGM8NKTww+UYMZom/4FnJXXLd\nvcyxOFGCpAORtoreUMLwioWJzkkN+apT1kxnPioVKJ7smhvYAOXcBZMZcAR2o0m0\nD4eiiBJuJWyQBPCDmbfZQFffAoGBAKpcr4ewOrwS0/O8cgPV7CTqfjbyDFp1sLwF\n2A/Hk66dotFBUvBRXZpruJCCxn4R/59r3lgAzy7oMrnjfXl7UHQk8+xIRMMSOQwK\np7OSv3szk96hy1pyo41vJ3CmWDsoTzGs7bcdMl72wvKemRaU92ckMEZpzAT8cEMC\ncWKLb8yzAoGAMibG8IyHSo7CJz82+7UHm98jNOlg6s73CEjp0W/+FL45Ka7MF/lp\nxtR3eSmxltvwvjQoti3V4Qboqtc2IPCt+EtapTM7Wo41wlLCWCNx4u25pZPH/c8g\n1yQ+OvH+xOYG+SeO98Phw/8d3IRfR83aqisQHv5upo2Rozzo0Kh3OsE=\n-----END RSA PRIVATE KEY-----');
INSERT INTO `t_rsakey_config` VALUES (3,'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA02M1I1V/YvxANOvLFX8R\n7D8At40IlT7HDWpAW3t+tAgQ7sqjCeYOxiXqOaaw2kJhM3HT5nZll48UmykVq45Q\n05J57nhdSsGXLJshtLcTg9liMEoW61BjVZi9EPPRSnE05tBJc57iqZw+aEcaSU0a\nwfzBc8IkRd6+pJ5iIgEVfuTluanizhHWvRli3EkAF4VNhaTfP3EkYfr4NE899aUe\nScbbdLFI6u1XQudlJCPTxaISx5ZcwM+nP3v242ABcjgUcfCbz0AY547WazK4bWP3\nqicyxo4MoLOoe9WBq6EuG4CuZQrzKnq8ltSxud/6chdg8Mqp/IasEQ2TpvY78tEX\nDQIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAxbbx2m1feHyrQ7jP+8mtDF/pyYLrJWKWAdEv3wZrOtjOZzeL\nGPzsmkcgncgoRhX4dT+1itSMR9j9m0/OwsH2UoF6U32LxCOQWQD1AMgIZjAkJeJv\nFTrtn8fMQ1701CkbaLTVIjRMlTw8kNXvNA/A9UatoiDmi4TFG6mrxTKZpIcTInvP\nEpkK2A7Qsp1E4skFK8jmysy7uRhMaYHtPTsBvxP0zn3lhKB3W+HTqpneewXWHjCD\nfL7Nbby91jbz5EKPZXWLuhXIvR1Cu4tiruorwXJxmXaP1HQZonytECNU/UOzP6GN\nLdq0eFDE4b04Wjp396551G99YiFP2nqHVJ5OMQIDAQABAoIBAQDEeYZhjyq+avUu\neSuFhOaIU4/ZhlXycsOqzpwJvzEz61tBSvrZPA5LSb9pzAvpic+7hDH94jX89+8d\nNfO7qlADsVNEQJBxuv2o1MCjpCRkmBZz506IBGU60Kt1j5kwdCEergTW1q375z4w\nl8f7LmSL2U6WvKcdojTVxohBkIUJ7shtmmukDi2YnMfe6T/2JuXDDL8rvIcnfr5E\nMCgPQs+xLeLEGrIJdpUy1iIYZYrzvrpJwf9EJL3D0e7jkpbvAQZ8EF9YhEizJhOm\ndzTqW4PgW2yUaHYd3q5QjiILy7AC+oOYoTZln3RfjPOxl+bYjeMOWlqkgtpPQkAE\n4I64w8RZAoGBAPLR44pEkmTdfIIF8ZtzBiVfDZ29bT96J0CWXGVzp8x6bSu5J5jl\ns7sP8DEcjGZ6vHsLGOvkcNxzcnR3l/5HOz6TIuvVuUm36b1jHltq1xZStjGeKZs1\nihhJSu2lIA+TrK8FCRnKARJ0ughXGNZFItgeM230Sgjp2RL4ISXJ724XAoGBANBy\nS2RwNpUYvkCSZHSFnQM/jq1jldxw+0p4jAGpWLilEaA/8xWUnZrnCrPFF/t9llpb\ndTR/dCI8ntIMAy2dH4IUHyYKUahyHSzCAUNKpS0s433kn5hy9tGvn7jyuOJ4dk9F\no1PIZM7qfzmkdCBbX3NF2TGpzOvbYGJHHC3ssVr3AoGBANHJDopN9iDYzpJTaktA\nVEYDWnM2zmUyNylw/sDT7FwYRaup2xEZG2/5NC5qGM8NKTww+UYMZom/4FnJXXLd\nvcyxOFGCpAORtoreUMLwioWJzkkN+apT1kxnPioVKJ7smhvYAOXcBZMZcAR2o0m0\nD4eiiBJuJWyQBPCDmbfZQFffAoGBAKpcr4ewOrwS0/O8cgPV7CTqfjbyDFp1sLwF\n2A/Hk66dotFBUvBRXZpruJCCxn4R/59r3lgAzy7oMrnjfXl7UHQk8+xIRMMSOQwK\np7OSv3szk96hy1pyo41vJ3CmWDsoTzGs7bcdMl72wvKemRaU92ckMEZpzAT8cEMC\ncWKLb8yzAoGAMibG8IyHSo7CJz82+7UHm98jNOlg6s73CEjp0W/+FL45Ka7MF/lp\nxtR3eSmxltvwvjQoti3V4Qboqtc2IPCt+EtapTM7Wo41wlLCWCNx4u25pZPH/c8g\n1yQ+OvH+xOYG+SeO98Phw/8d3IRfR83aqisQHv5upo2Rozzo0Kh3OsE=\n-----END RSA PRIVATE KEY-----');
INSERT INTO `t_rsakey_config` VALUES (4,'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAyaxqjPJP5+Innfv5IdfQ\nqY/ftS++lnDRe3EczNkIjESWXhHSOljEw9b9C+/BtF+fO9QZL7Z742y06eIdvsMP\nQKdGflB26+9OZ8AF4SpXDn3aVWGr8+9qpB7BELRZI/Ph2FlFL4cobCzMHunncW8z\nTfMId48+fgHkAzCjRl5rC6XT0Yge6+eKpXmF+hr0vGYWiTzqPzTABl44WZo3rw0y\nurZTzkrmRE4kR2VzkjY/rBnQAbFKKFUKsUozjCXvSag4l461wDkhmmyivpNkK5cA\nxuDbsmC39iqagMt9438fajLVvYOvpVs9ci5tiLcbBtfB4Rf/QVAkqtTm86Z0O3e7\nDwIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAxbbx2m1feHyrQ7jP+8mtDF/pyYLrJWKWAdEv3wZrOtjOZzeL\nGPzsmkcgncgoRhX4dT+1itSMR9j9m0/OwsH2UoF6U32LxCOQWQD1AMgIZjAkJeJv\nFTrtn8fMQ1701CkbaLTVIjRMlTw8kNXvNA/A9UatoiDmi4TFG6mrxTKZpIcTInvP\nEpkK2A7Qsp1E4skFK8jmysy7uRhMaYHtPTsBvxP0zn3lhKB3W+HTqpneewXWHjCD\nfL7Nbby91jbz5EKPZXWLuhXIvR1Cu4tiruorwXJxmXaP1HQZonytECNU/UOzP6GN\nLdq0eFDE4b04Wjp396551G99YiFP2nqHVJ5OMQIDAQABAoIBAQDEeYZhjyq+avUu\neSuFhOaIU4/ZhlXycsOqzpwJvzEz61tBSvrZPA5LSb9pzAvpic+7hDH94jX89+8d\nNfO7qlADsVNEQJBxuv2o1MCjpCRkmBZz506IBGU60Kt1j5kwdCEergTW1q375z4w\nl8f7LmSL2U6WvKcdojTVxohBkIUJ7shtmmukDi2YnMfe6T/2JuXDDL8rvIcnfr5E\nMCgPQs+xLeLEGrIJdpUy1iIYZYrzvrpJwf9EJL3D0e7jkpbvAQZ8EF9YhEizJhOm\ndzTqW4PgW2yUaHYd3q5QjiILy7AC+oOYoTZln3RfjPOxl+bYjeMOWlqkgtpPQkAE\n4I64w8RZAoGBAPLR44pEkmTdfIIF8ZtzBiVfDZ29bT96J0CWXGVzp8x6bSu5J5jl\ns7sP8DEcjGZ6vHsLGOvkcNxzcnR3l/5HOz6TIuvVuUm36b1jHltq1xZStjGeKZs1\nihhJSu2lIA+TrK8FCRnKARJ0ughXGNZFItgeM230Sgjp2RL4ISXJ724XAoGBANBy\nS2RwNpUYvkCSZHSFnQM/jq1jldxw+0p4jAGpWLilEaA/8xWUnZrnCrPFF/t9llpb\ndTR/dCI8ntIMAy2dH4IUHyYKUahyHSzCAUNKpS0s433kn5hy9tGvn7jyuOJ4dk9F\no1PIZM7qfzmkdCBbX3NF2TGpzOvbYGJHHC3ssVr3AoGBANHJDopN9iDYzpJTaktA\nVEYDWnM2zmUyNylw/sDT7FwYRaup2xEZG2/5NC5qGM8NKTww+UYMZom/4FnJXXLd\nvcyxOFGCpAORtoreUMLwioWJzkkN+apT1kxnPioVKJ7smhvYAOXcBZMZcAR2o0m0\nD4eiiBJuJWyQBPCDmbfZQFffAoGBAKpcr4ewOrwS0/O8cgPV7CTqfjbyDFp1sLwF\n2A/Hk66dotFBUvBRXZpruJCCxn4R/59r3lgAzy7oMrnjfXl7UHQk8+xIRMMSOQwK\np7OSv3szk96hy1pyo41vJ3CmWDsoTzGs7bcdMl72wvKemRaU92ckMEZpzAT8cEMC\ncWKLb8yzAoGAMibG8IyHSo7CJz82+7UHm98jNOlg6s73CEjp0W/+FL45Ka7MF/lp\nxtR3eSmxltvwvjQoti3V4Qboqtc2IPCt+EtapTM7Wo41wlLCWCNx4u25pZPH/c8g\n1yQ+OvH+xOYG+SeO98Phw/8d3IRfR83aqisQHv5upo2Rozzo0Kh3OsE=\n-----END RSA PRIVATE KEY-----');
INSERT INTO `t_rsakey_config` VALUES (5,'-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAsJbFp3WcsiojjdQtVnTu\nvtawL2m4XxK93F6lCnFwcZqUP39txFGGlrogHMqreyawIUN7E5shtwGzigzjW8Ly\n5CryBJpXP3ehNTqJS7emb+9LlC19Oxa1eQuUQnatgcsd16DPH7kJ5JzN3vXnhvUy\nk4Qficdmm0uk7FRaNYFi7EJs4xyqFTrp3rDZ0dzBHumlIeK1om7FNt6Nyivgp+Uy\nbO7kl0NLFEeSlV4S+7ofitWQsO5xYqKAzSzz+KIRQcxJidGBlZ1JN/g5DPDpx/zt\nvOWYUlM7TYk6xN3focZpU0kBzAw/rn94yW9z8jpXfzk+MvWzVL/HAcPy4ySwkay0\nNwIDAQAB\n-----END PUBLIC KEY-----','-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIBAAKCAQEAxbbx2m1feHyrQ7jP+8mtDF/pyYLrJWKWAdEv3wZrOtjOZzeL\nGPzsmkcgncgoRhX4dT+1itSMR9j9m0/OwsH2UoF6U32LxCOQWQD1AMgIZjAkJeJv\nFTrtn8fMQ1701CkbaLTVIjRMlTw8kNXvNA/A9UatoiDmi4TFG6mrxTKZpIcTInvP\nEpkK2A7Qsp1E4skFK8jmysy7uRhMaYHtPTsBvxP0zn3lhKB3W+HTqpneewXWHjCD\nfL7Nbby91jbz5EKPZXWLuhXIvR1Cu4tiruorwXJxmXaP1HQZonytECNU/UOzP6GN\nLdq0eFDE4b04Wjp396551G99YiFP2nqHVJ5OMQIDAQABAoIBAQDEeYZhjyq+avUu\neSuFhOaIU4/ZhlXycsOqzpwJvzEz61tBSvrZPA5LSb9pzAvpic+7hDH94jX89+8d\nNfO7qlADsVNEQJBxuv2o1MCjpCRkmBZz506IBGU60Kt1j5kwdCEergTW1q375z4w\nl8f7LmSL2U6WvKcdojTVxohBkIUJ7shtmmukDi2YnMfe6T/2JuXDDL8rvIcnfr5E\nMCgPQs+xLeLEGrIJdpUy1iIYZYrzvrpJwf9EJL3D0e7jkpbvAQZ8EF9YhEizJhOm\ndzTqW4PgW2yUaHYd3q5QjiILy7AC+oOYoTZln3RfjPOxl+bYjeMOWlqkgtpPQkAE\n4I64w8RZAoGBAPLR44pEkmTdfIIF8ZtzBiVfDZ29bT96J0CWXGVzp8x6bSu5J5jl\ns7sP8DEcjGZ6vHsLGOvkcNxzcnR3l/5HOz6TIuvVuUm36b1jHltq1xZStjGeKZs1\nihhJSu2lIA+TrK8FCRnKARJ0ughXGNZFItgeM230Sgjp2RL4ISXJ724XAoGBANBy\nS2RwNpUYvkCSZHSFnQM/jq1jldxw+0p4jAGpWLilEaA/8xWUnZrnCrPFF/t9llpb\ndTR/dCI8ntIMAy2dH4IUHyYKUahyHSzCAUNKpS0s433kn5hy9tGvn7jyuOJ4dk9F\no1PIZM7qfzmkdCBbX3NF2TGpzOvbYGJHHC3ssVr3AoGBANHJDopN9iDYzpJTaktA\nVEYDWnM2zmUyNylw/sDT7FwYRaup2xEZG2/5NC5qGM8NKTww+UYMZom/4FnJXXLd\nvcyxOFGCpAORtoreUMLwioWJzkkN+apT1kxnPioVKJ7smhvYAOXcBZMZcAR2o0m0\nD4eiiBJuJWyQBPCDmbfZQFffAoGBAKpcr4ewOrwS0/O8cgPV7CTqfjbyDFp1sLwF\n2A/Hk66dotFBUvBRXZpruJCCxn4R/59r3lgAzy7oMrnjfXl7UHQk8+xIRMMSOQwK\np7OSv3szk96hy1pyo41vJ3CmWDsoTzGs7bcdMl72wvKemRaU92ckMEZpzAT8cEMC\ncWKLb8yzAoGAMibG8IyHSo7CJz82+7UHm98jNOlg6s73CEjp0W/+FL45Ka7MF/lp\nxtR3eSmxltvwvjQoti3V4Qboqtc2IPCt+EtapTM7Wo41wlLCWCNx4u25pZPH/c8g\n1yQ+OvH+xOYG+SeO98Phw/8d3IRfR83aqisQHv5upo2Rozzo0Kh3OsE=\n-----END RSA PRIVATE KEY-----');
/*!40000 ALTER TABLE `t_rsakey_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_sdk_config`
--

DROP TABLE IF EXISTS `t_sdk_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_sdk_config` (
  `sdkenv` int unsigned NOT NULL COMMENT 'sdk环境编号',
  `app_id` int unsigned NOT NULL,
  `account_key` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号校验key',
  `account_url` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '账号校验url',
  `recharge_key` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '支付校验key',
  `desc` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '描述文本',
  PRIMARY KEY (`sdkenv`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='配置sdk环境相关的配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_sdk_config`
--

LOCK TABLES `t_sdk_config` WRITE;
/*!40000 ALTER TABLE `t_sdk_config` DISABLE KEYS */;
INSERT INTO `t_sdk_config` VALUES (1,1,'1','http://127.0.0.1:80/','1','');
/*!40000 ALTER TABLE `t_sdk_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_security_file_config`
--

DROP TABLE IF EXISTS `t_security_file_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_security_file_config` (
  `file_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `file_data` blob NOT NULL COMMENT '安全dispatch文件内容',
  PRIMARY KEY (`file_key`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='安全dispatch文件配置';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_security_file_config`
--

LOCK TABLES `t_security_file_config` WRITE;
/*!40000 ALTER TABLE `t_security_file_config` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_security_file_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `db_hk4e_order`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_hk4e_order` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_hk4e_order`;

--
-- Table structure for table `t_order_data`
--

DROP TABLE IF EXISTS `t_order_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_order_data` (
  `id` int unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `uid` int unsigned NOT NULL DEFAULT '0' COMMENT '玩家UID',
  `product_id` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '透传的商品id',
  `product_name` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '商品名称',
  `product_num` int NOT NULL DEFAULT '0' COMMENT '商品数量',
  `coin_num` int NOT NULL DEFAULT '0' COMMENT '自定义充值水晶',
  `total_fee` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '订单金额',
  `currency` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '币种',
  `price_tier` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '价格档位',
  `trade_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '流水号全局唯一',
  `trade_time` int NOT NULL DEFAULT '0' COMMENT '交易时间-SDK传来的时间戳',
  `channel_id` int unsigned NOT NULL DEFAULT '0' COMMENT '渠道id',
  `channel_order_no` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '外部订单号，渠道+订单号唯一确定一个订单',
  `pay_plat` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支付渠道',
  `extend` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '其它信息',
  `env` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT 'sandbox - 沙箱环境, prod - 生产环境, prod-os - 海外生产环境（其他值请忽略）',
  `is_sandbox` int NOT NULL DEFAULT '0' COMMENT '1-沙箱支付，非真钱； 0-真实支付',
  `region` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '区服名',
  `bonus` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '额外赠送代币名',
  `bonus_num` int NOT NULL DEFAULT '0' COMMENT '额外赠送代币数量',
  `vip_point_num` int NOT NULL DEFAULT '0' COMMENT '额外赠送的vip点数',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'oaserver生成订单的时间',
  `finish_time` int DEFAULT '0' COMMENT 'gameserver结算订单的时间',
  `pay_type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支付方式，仅用于数据平台分析',
  `pay_vendor` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '支付发卡机构，仅用于数据平台分析',
  `client_type` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '充值时使用的设备类，仅用于数据平台分析',
  `device` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '充值时使用的设备，仅用于数据平台分析',
  `client_ip` varchar(46) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '客户端IP地址',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `trade_no` (`trade_no`) USING BTREE,
  KEY `uid_create_finish_time` (`uid`,`create_time`,`finish_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='订单数据';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_order_data`
--

LOCK TABLES `t_order_data` WRITE;
/*!40000 ALTER TABLE `t_order_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_order_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `db_hk4e_user`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `db_hk4e_user` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_hk4e_user`;

--
-- Table structure for table `t_block_data_0`
--

DROP TABLE IF EXISTS `t_block_data_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_0` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_0`
--

LOCK TABLES `t_block_data_0` WRITE;
/*!40000 ALTER TABLE `t_block_data_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_1`
--

DROP TABLE IF EXISTS `t_block_data_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_1` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_1`
--

LOCK TABLES `t_block_data_1` WRITE;
/*!40000 ALTER TABLE `t_block_data_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_2`
--

DROP TABLE IF EXISTS `t_block_data_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_2` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_2`
--

LOCK TABLES `t_block_data_2` WRITE;
/*!40000 ALTER TABLE `t_block_data_2` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_3`
--

DROP TABLE IF EXISTS `t_block_data_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_3` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_3`
--

LOCK TABLES `t_block_data_3` WRITE;
/*!40000 ALTER TABLE `t_block_data_3` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_4`
--

DROP TABLE IF EXISTS `t_block_data_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_4` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_4`
--

LOCK TABLES `t_block_data_4` WRITE;
/*!40000 ALTER TABLE `t_block_data_4` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_5`
--

DROP TABLE IF EXISTS `t_block_data_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_5` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_5`
--

LOCK TABLES `t_block_data_5` WRITE;
/*!40000 ALTER TABLE `t_block_data_5` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_6`
--

DROP TABLE IF EXISTS `t_block_data_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_6` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_6`
--

LOCK TABLES `t_block_data_6` WRITE;
/*!40000 ALTER TABLE `t_block_data_6` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_7`
--

DROP TABLE IF EXISTS `t_block_data_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_7` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_7`
--

LOCK TABLES `t_block_data_7` WRITE;
/*!40000 ALTER TABLE `t_block_data_7` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_8`
--

DROP TABLE IF EXISTS `t_block_data_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_8` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_8`
--

LOCK TABLES `t_block_data_8` WRITE;
/*!40000 ALTER TABLE `t_block_data_8` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_block_data_9`
--

DROP TABLE IF EXISTS `t_block_data_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_block_data_9` (
  `uid` int NOT NULL DEFAULT '0',
  `block_id` int NOT NULL DEFAULT '0',
  `data_version` int NOT NULL,
  `bin_data` mediumblob NOT NULL,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`uid`,`block_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='场景block存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_block_data_9`
--

LOCK TABLES `t_block_data_9` WRITE;
/*!40000 ALTER TABLE `t_block_data_9` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_block_data_9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_0`
--

DROP TABLE IF EXISTS `t_home_data_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_0` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_0`
--

LOCK TABLES `t_home_data_0` WRITE;
/*!40000 ALTER TABLE `t_home_data_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_1`
--

DROP TABLE IF EXISTS `t_home_data_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_1` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_1`
--

LOCK TABLES `t_home_data_1` WRITE;
/*!40000 ALTER TABLE `t_home_data_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_2`
--

DROP TABLE IF EXISTS `t_home_data_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_2` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_2`
--

LOCK TABLES `t_home_data_2` WRITE;
/*!40000 ALTER TABLE `t_home_data_2` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_3`
--

DROP TABLE IF EXISTS `t_home_data_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_3` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_3`
--

LOCK TABLES `t_home_data_3` WRITE;
/*!40000 ALTER TABLE `t_home_data_3` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_4`
--

DROP TABLE IF EXISTS `t_home_data_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_4` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_4`
--

LOCK TABLES `t_home_data_4` WRITE;
/*!40000 ALTER TABLE `t_home_data_4` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_5`
--

DROP TABLE IF EXISTS `t_home_data_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_5` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_5`
--

LOCK TABLES `t_home_data_5` WRITE;
/*!40000 ALTER TABLE `t_home_data_5` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_6`
--

DROP TABLE IF EXISTS `t_home_data_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_6` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_6`
--

LOCK TABLES `t_home_data_6` WRITE;
/*!40000 ALTER TABLE `t_home_data_6` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_7`
--

DROP TABLE IF EXISTS `t_home_data_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_7` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_7`
--

LOCK TABLES `t_home_data_7` WRITE;
/*!40000 ALTER TABLE `t_home_data_7` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_8`
--

DROP TABLE IF EXISTS `t_home_data_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_8` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_8`
--

LOCK TABLES `t_home_data_8` WRITE;
/*!40000 ALTER TABLE `t_home_data_8` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_home_data_9`
--

DROP TABLE IF EXISTS `t_home_data_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_home_data_9` (
  `uid` int NOT NULL DEFAULT '0',
  `bin_data` mediumblob NOT NULL,
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `block_end_time` datetime NOT NULL DEFAULT '1970-01-01 00:00:00' COMMENT '封禁结束时间',
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='家园存档';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_home_data_9`
--

LOCK TABLES `t_home_data_9` WRITE;
/*!40000 ALTER TABLE `t_home_data_9` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_home_data_9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_0`
--

DROP TABLE IF EXISTS `t_player_data_0`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_0` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_0`
--

LOCK TABLES `t_player_data_0` WRITE;
/*!40000 ALTER TABLE `t_player_data_0` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_0` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_1`
--

DROP TABLE IF EXISTS `t_player_data_1`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_1` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_1`
--

LOCK TABLES `t_player_data_1` WRITE;
/*!40000 ALTER TABLE `t_player_data_1` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_1` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_2`
--

DROP TABLE IF EXISTS `t_player_data_2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_2` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_2`
--

LOCK TABLES `t_player_data_2` WRITE;
/*!40000 ALTER TABLE `t_player_data_2` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_3`
--

DROP TABLE IF EXISTS `t_player_data_3`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_3` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_3`
--

LOCK TABLES `t_player_data_3` WRITE;
/*!40000 ALTER TABLE `t_player_data_3` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_3` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_4`
--

DROP TABLE IF EXISTS `t_player_data_4`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_4` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_4`
--

LOCK TABLES `t_player_data_4` WRITE;
/*!40000 ALTER TABLE `t_player_data_4` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_4` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_5`
--

DROP TABLE IF EXISTS `t_player_data_5`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_5` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_5`
--

LOCK TABLES `t_player_data_5` WRITE;
/*!40000 ALTER TABLE `t_player_data_5` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_5` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_6`
--

DROP TABLE IF EXISTS `t_player_data_6`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_6` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_6`
--

LOCK TABLES `t_player_data_6` WRITE;
/*!40000 ALTER TABLE `t_player_data_6` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_6` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_7`
--

DROP TABLE IF EXISTS `t_player_data_7`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_7` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_7`
--

LOCK TABLES `t_player_data_7` WRITE;
/*!40000 ALTER TABLE `t_player_data_7` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_7` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_8`
--

DROP TABLE IF EXISTS `t_player_data_8`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_8` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_8`
--

LOCK TABLES `t_player_data_8` WRITE;
/*!40000 ALTER TABLE `t_player_data_8` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_8` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_data_9`
--

DROP TABLE IF EXISTS `t_player_data_9`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_data_9` (
  `uid` int unsigned NOT NULL DEFAULT '0',
  `nickname` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0',
  `level` int unsigned NOT NULL DEFAULT '0',
  `exp` int unsigned NOT NULL DEFAULT '0',
  `vip_point` int unsigned NOT NULL DEFAULT '0',
  `json_data` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `bin_data` mediumblob NOT NULL,
  `extra_bin_data` blob COMMENT 'login前用的数据',
  `data_version` int unsigned NOT NULL DEFAULT '0',
  `tag_list` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_save_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delete` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否为polardb扩容后废弃数据',
  `reserved_1` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段1',
  `reserved_2` int unsigned NOT NULL DEFAULT '0' COMMENT '预留字段2',
  `before_login_bin_data` blob COMMENT 'login前用的数据（对比extra_bin_data没有多写的问题）',
  PRIMARY KEY (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家核心数据包';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_data_9`
--

LOCK TABLES `t_player_data_9` WRITE;
/*!40000 ALTER TABLE `t_player_data_9` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_data_9` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_online_id_data`
--

DROP TABLE IF EXISTS `t_player_online_id_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_online_id_data` (
  `online_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uid` int unsigned NOT NULL,
  PRIMARY KEY (`online_id`) USING BTREE,
  UNIQUE KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='PS玩家online与uid映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_online_id_data`
--

LOCK TABLES `t_player_online_id_data` WRITE;
/*!40000 ALTER TABLE `t_player_online_id_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_online_id_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_psn_online_id_data`
--

DROP TABLE IF EXISTS `t_player_psn_online_id_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_psn_online_id_data` (
  `psn_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `online_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `uid` int unsigned NOT NULL,
  PRIMARY KEY (`psn_id`) USING BTREE,
  UNIQUE KEY `uid` (`uid`) USING BTREE,
  KEY `online_id` (`online_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='ps用户psn_id到online_id/uid映射';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_psn_online_id_data`
--

LOCK TABLES `t_player_psn_online_id_data` WRITE;
/*!40000 ALTER TABLE `t_player_psn_online_id_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_psn_online_id_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_player_uid`
--

DROP TABLE IF EXISTS `t_player_uid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `t_player_uid` (
  `uid` int unsigned NOT NULL AUTO_INCREMENT,
  `account_type` int unsigned NOT NULL DEFAULT '0' COMMENT '账号类型',
  `account_uid` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '绑定的账号UID',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `ext` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '自定义信息，Json格式',
  `tag` int unsigned NOT NULL DEFAULT '0' COMMENT 'TAG，由MUIP设置',
  PRIMARY KEY (`uid`) USING BTREE,
  UNIQUE KEY `account_type_account_uid` (`account_type`,`account_uid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC COMMENT='玩家身份信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_player_uid`
--

LOCK TABLES `t_player_uid` WRITE;
/*!40000 ALTER TABLE `t_player_uid` DISABLE KEYS */;
/*!40000 ALTER TABLE `t_player_uid` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
