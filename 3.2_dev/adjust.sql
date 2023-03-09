SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;


USE `hk4e_db_config`;

SET @NOW = NOW();

UPDATE `t_activity_schedule_config` SET `end_time` = ADDTIME(@NOW, TIMEDIFF(`end_time`, `begin_time`)), `begin_time` = @NOW;

UPDATE `t_gacha_schedule_config` SET `begin_time` = @NOW WHERE `gacha_type` IN (301, 302, 400) AND `enabled` = 1;
UPDATE `t_gacha_schedule_config` SET `begin_time` = ADDDATE(@NOW, INTERVAL '16 00:00:01' DAY_SECOND) WHERE `gacha_type` IN (301, 302, 400) AND `enabled` = 0;
UPDATE `t_gacha_schedule_config` SET `end_time` = ADDDATE(`begin_time`, INTERVAL 16 DAY), `enabled` = 1 WHERE `gacha_type` IN (301, 302, 400);