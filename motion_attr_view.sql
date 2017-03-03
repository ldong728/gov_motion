-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-03-03 09:30:48
-- 服务器版本： 10.1.9-MariaDB
-- PHP Version: 5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gov_motion_db`
--

-- --------------------------------------------------------

--
-- 视图结构 `motion_attr_view`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_attr_view`  AS  select `b`.`attr_name` AS `attr_name`,`c`.`motion_template_name` AS `motion_template_name`,`d`.`step_name` AS `step_name`,`a`.`motion_attr_id` AS `motion_attr_id`,`a`.`motion_template` AS `motion_template`,`a`.`attr_template` AS `attr_template`,`a`.`default_value` AS `default_value`,`a`.`hidden` AS `hidden`,`a`.`value_type` AS `value_type`,`a`.`value_sort` AS `value_sort`,`b`.`option` AS `option`,`a`.`step` AS `step` from (((`motion_attr_tbl` `a` left join `attr_template_tbl` `b` on((`a`.`attr_template` = `b`.`attr_template_id`))) left join `motion_template_tbl` `c` on((`a`.`motion_template` = `c`.`motion_template_id`))) left join `step_tbl` `d` on((`b`.`step` = `d`.`step_id`))) ;

--
-- VIEW  `motion_attr_view`
-- Data: 无
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
