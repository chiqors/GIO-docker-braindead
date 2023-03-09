SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;


USE `hk4e_db_config`;

SET @NOW = NOW();

UPDATE `t_activity_schedule_config` SET `end_time` = ADDTIME(@NOW, TIMEDIFF(`end_time`, `begin_time`)), `begin_time` = @NOW;

UPDATE `t_gacha_schedule_config` SET `begin_time` = @NOW WHERE `schedule_id` IN (31);
UPDATE `t_gacha_schedule_config` SET `begin_time` = ADDDATE(@NOW, INTERVAL '28 00:00:01' DAY_SECOND) WHERE `schedule_id` IN (32);
UPDATE `t_gacha_schedule_config` SET `begin_time` = ADDDATE(@NOW, INTERVAL '42 00:00:02' DAY_SECOND) WHERE `schedule_id` IN (33);
UPDATE `t_gacha_schedule_config` SET `end_time` = ADDDATE(`begin_time`, INTERVAL 14 DAY) WHERE `schedule_id` IN (31,32,33);
UPDATE `t_gacha_schedule_config` SET `end_time` = ADDDATE(`begin_time`, INTERVAL 21 DAY) WHERE `schedule_id` IN (34,35);