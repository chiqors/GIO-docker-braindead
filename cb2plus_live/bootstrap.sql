SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;


CREATE USER IF NOT EXISTS 'hk4e_work'@'172.10.%' IDENTIFIED BY 'miHoYo2012';
CREATE USER IF NOT EXISTS 'hk4e_readonly'@'172.10.%' IDENTIFIED BY 'miHoYo2012';


DROP DATABASE IF EXISTS `hk4e_db_user`; CREATE DATABASE `hk4e_db_user` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
DROP DATABASE IF EXISTS `hk4e_db_config`; CREATE DATABASE `hk4e_db_config` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
DROP DATABASE IF EXISTS `hk4e_db_deploy_config`; CREATE DATABASE `hk4e_db_deploy_config` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;


GRANT ALL PRIVILEGES ON hk4e_db_user . * TO 'hk4e_work'@'172.10.%';
GRANT ALL PRIVILEGES ON hk4e_db_config . * TO 'hk4e_work'@'172.10.%';
GRANT ALL PRIVILEGES ON hk4e_db_deploy_config . * TO 'hk4e_work'@'172.10.%';

GRANT SELECT ON hk4e_db_user . * TO 'hk4e_readonly'@'172.10.%';
GRANT SELECT ON hk4e_db_config . * TO 'hk4e_readonly'@'172.10.%';
GRANT SELECT ON hk4e_db_deploy_config . * TO 'hk4e_readonly'@'172.10.%';


FLUSH PRIVILEGES;
