-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-03-07 09:39:34
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
-- 表的结构 `attr_tbl`
--

CREATE TABLE `attr_tbl` (
  `attr_id` int(11) NOT NULL,
  `motion` int(11) NOT NULL,
  `motion_attr` int(11) NOT NULL,
  `attr_template` int(11) NOT NULL,
  `content` varchar(500) DEFAULT NULL,
  `content_int` int(11) NOT NULL DEFAULT '0',
  `attachment` varchar(500) DEFAULT NULL,
  `staff` int(11) DEFAULT NULL,
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `attr_tbl`
--

INSERT INTO `attr_tbl` (`attr_id`, `motion`, `motion_attr`, `attr_template`, `content`, `content_int`, `attachment`, `staff`, `update_time`) VALUES
(1, 7, 14, 5, 'abc', 0, 'asd', 3, '2017-03-07 07:52:58'),
(2, 7, 14, 5, 'def', 0, NULL, NULL, '2017-03-07 07:56:05');

-- --------------------------------------------------------

--
-- 表的结构 `attr_template_tbl`
--

CREATE TABLE `attr_template_tbl` (
  `attr_template_id` int(11) NOT NULL,
  `motion_template` int(11) NOT NULL DEFAULT '0',
  `attr_name` varchar(100) NOT NULL,
  `option` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `attr_template_tbl`
--

INSERT INTO `attr_template_tbl` (`attr_template_id`, `motion_template`, `attr_name`, `option`) VALUES
(1, 1, '是否公开', '["公开","不公开"]'),
(2, 1, '类别', '["建议","议案","提案"]'),
(3, 0, '案由', NULL),
(4, 0, '领衔人', NULL),
(5, 0, '附议人', NULL),
(6, 0, '性质类别', NULL),
(7, 0, '登记时间', NULL),
(8, 0, '状态', NULL),
(9, 0, '性质', NULL),
(10, 0, '审核', '["立案","不予立案"]'),
(11, 0, '审核意见', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `category_tbl`
--

CREATE TABLE `category_tbl` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(10) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `category_tbl`
--

INSERT INTO `category_tbl` (`category_id`, `category_name`) VALUES
(1, '人大'),
(2, '政协'),
(3, '其他');

-- --------------------------------------------------------

--
-- 表的结构 `duty_tbl`
--

CREATE TABLE `duty_tbl` (
  `duty_id` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `meeting` int(11) NOT NULL,
  `user_group` int(11) NOT NULL,
  `response_area` int(11) DEFAULT NULL,
  `admin_type` varchar(10) DEFAULT NULL,
  `activity` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `meeting_tbl`
--

CREATE TABLE `meeting_tbl` (
  `meeting_id` int(11) NOT NULL,
  `meeting_name` varchar(50) NOT NULL,
  `start_time` int(11) NOT NULL,
  `end_time` int(11) NOT NULL,
  `deadline_time` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `motion_template` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `meeting_tbl`
--

INSERT INTO `meeting_tbl` (`meeting_id`, `meeting_name`, `start_time`, `end_time`, `deadline_time`, `category`, `motion_template`) VALUES
(1, '政协第X届第Y次会议', 123, 1234, 1490511241, 2, 2);

-- --------------------------------------------------------

--
-- 表的结构 `motion_attr_tbl`
--

CREATE TABLE `motion_attr_tbl` (
  `motion_attr_id` int(11) NOT NULL,
  `motion_template` int(11) NOT NULL,
  `attr_template` int(11) NOT NULL,
  `default_value` varchar(500) NOT NULL,
  `value_type` varchar(10) NOT NULL DEFAULT 'string',
  `target` varchar(30) DEFAULT NULL,
  `value_sort` int(11) NOT NULL DEFAULT '0',
  `step` int(11) NOT NULL DEFAULT '0',
  `hidden` tinyint(4) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `motion_attr_tbl`
--

INSERT INTO `motion_attr_tbl` (`motion_attr_id`, `motion_template`, `attr_template`, `default_value`, `value_type`, `target`, `value_sort`, `step`, `hidden`) VALUES
(1, 1, 1, '公开', 'string', NULL, 0, 2, 0),
(4, 1, 2, '建议', 'string', '', 0, 1, 0),
(5, 1, 3, '', 'string', NULL, 0, 2, 0),
(6, 1, 4, '', 'string', NULL, 0, 2, 0),
(7, 1, 5, '', 'string', NULL, 0, 2, 0),
(8, 1, 10, '立案', 'string', NULL, 0, 3, 0),
(9, 1, 11, '', 'string', NULL, 0, 3, 0),
(10, 2, 1, '公开', 'string', NULL, 0, 2, 0),
(11, 2, 2, '提案', 'string', NULL, 0, 2, 0),
(12, 2, 3, '', 'string', NULL, 0, 1, 0),
(13, 2, 4, '', 'string', NULL, 0, 1, 0),
(14, 2, 5, '', 'string', NULL, 0, 1, 0),
(15, 2, 6, '', 'string', NULL, 0, 2, 0),
(16, 2, 8, '', 'string', NULL, 0, 2, 0),
(17, 2, 10, '立案', 'string', NULL, 0, 3, 0),
(18, 2, 11, '', 'string', NULL, 0, 3, 0),
(19, 2, 7, '', 'time', NULL, 0, 0, 0),
(20, 2, 9, '', 'string', NULL, 0, 2, 0);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `motion_attr_view`
--
CREATE TABLE `motion_attr_view` (
`attr_name` varchar(100)
,`motion_template_name` varchar(50)
,`step_name` varchar(50)
,`motion_attr_id` int(11)
,`motion_template` int(11)
,`attr_template` int(11)
,`default_value` varchar(500)
,`hidden` tinyint(4)
,`value_type` varchar(10)
,`target` varchar(30)
,`value_sort` int(11)
,`option` varchar(500)
,`step` int(11)
);

-- --------------------------------------------------------

--
-- 表的结构 `motion_handler_tbl`
--

CREATE TABLE `motion_handler_tbl` (
  `motion_handler_id` int(11) NOT NULL,
  `motion` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `staff` int(11) NOT NULL,
  `receive_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `reply_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `contact_name` varchar(15) NOT NULL,
  `contact_phone` varchar(20) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `attachment` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `motion_tbl`
--

CREATE TABLE `motion_tbl` (
  `motion_id` int(11) NOT NULL,
  `meeting` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `motion_name` varchar(50) NOT NULL,
  `motion_template` int(11) NOT NULL,
  `user` int(11) NOT NULL,
  `document` varchar(400) NOT NULL,
  `step` int(11) NOT NULL,
  `document_sha` varchar(50) NOT NULL,
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `motion_tbl`
--

INSERT INTO `motion_tbl` (`motion_id`, `meeting`, `category`, `motion_name`, `motion_template`, `user`, `document`, `step`, `document_sha`, `upload_time`) VALUES
(7, 1, 2, '测试提案6', 2, 1, 'none', 2, 'abas', '2017-03-06 08:16:17'),
(8, 1, 2, 'asdfas', 2, 1, 'none', 2, 'abas', '2017-03-06 08:20:52'),
(9, 1, 2, 'asdf', 2, 1, 'none', 2, 'abas', '2017-03-06 08:27:32'),
(10, 1, 2, 'asdfas', 2, 1, 'none', 2, 'abas', '2017-03-06 08:29:03');

-- --------------------------------------------------------

--
-- 表的结构 `motion_template_tbl`
--

CREATE TABLE `motion_template_tbl` (
  `motion_template_id` int(11) NOT NULL,
  `motion_template_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `motion_template_tbl`
--

INSERT INTO `motion_template_tbl` (`motion_template_id`, `motion_template_name`) VALUES
(1, '人大建议模板'),
(2, '政协提案模板');

-- --------------------------------------------------------

--
-- 替换视图以便查看 `motion_view`
--
CREATE TABLE `motion_view` (
`motion_id` int(11)
,`meeting` int(11)
,`category` int(11)
,`motion_name` varchar(50)
,`attr_id` int(11)
,`motion_template` int(11)
,`motion_attr` int(11)
,`attr_template` int(11)
,`user` int(11)
,`document` varchar(400)
,`step` int(11)
,`attr_step` int(11)
,`document_sha` varchar(50)
,`upload_time` timestamp
,`default_value` varchar(500)
,`value_type` varchar(10)
,`target` varchar(30)
,`value_sort` int(11)
,`hidden` tinyint(4)
,`attr_name` varchar(100)
,`option` varchar(500)
,`content` varchar(500)
,`content_int` int(11)
,`attachment` varchar(500)
);

-- --------------------------------------------------------

--
-- 表的结构 `operator_tbl`
--

CREATE TABLE `operator_tbl` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `pwd` varchar(40) NOT NULL,
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creator` varchar(20) NOT NULL DEFAULT 'admin',
  `md5` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `operator_tbl`
--

INSERT INTO `operator_tbl` (`id`, `name`, `pwd`, `create_time`, `creator`, `md5`) VALUES
(1, 'abc', 'def', '2017-02-25 06:09:55', '-1', '4ed9407630eb1000c0f6b63842defa7d'),
(2, 'ds', 'defsd', '2017-02-25 06:11:39', '-1', '5372cc50384141a2c62f206db5e56db1');

-- --------------------------------------------------------

--
-- 表的结构 `op_pms_tbl`
--

CREATE TABLE `op_pms_tbl` (
  `o_id` int(11) NOT NULL,
  `pms_id` varchar(20) NOT NULL,
  `remark` varchar(50) DEFAULT NULL,
  `remark2` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 替换视图以便查看 `op_pms_view`
--
CREATE TABLE `op_pms_view` (
`pms_id` varchar(20)
,`id` int(11)
,`name` varchar(20)
,`pwd` varchar(40)
,`create_time` timestamp
,`creator` varchar(20)
,`md5` varchar(40)
);

-- --------------------------------------------------------

--
-- 表的结构 `pms_tbl`
--

CREATE TABLE `pms_tbl` (
  `id` int(11) NOT NULL,
  `key_word` varchar(20) NOT NULL,
  `name` varchar(20) NOT NULL,
  `remark` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `pms_tbl`
--

INSERT INTO `pms_tbl` (`id`, `key_word`, `name`, `remark`) VALUES
(103, 'vemfljmDYk', '权限管理', NULL),
(104, 'HwUVAMBMpr', '模板管理', NULL);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `pms_view`
--
CREATE TABLE `pms_view` (
`f_id` int(11)
,`f_key` varchar(20)
,`f_name` varchar(20)
,`s_id` int(11)
,`s_key` varchar(30)
,`s_name` varchar(30)
);

-- --------------------------------------------------------

--
-- 表的结构 `response_area_tbl`
--

CREATE TABLE `response_area_tbl` (
  `response_area_id` int(11) NOT NULL,
  `response_area_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `staff_tbl`
--

CREATE TABLE `staff_tbl` (
  `staff_id` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `staff_name` varchar(20) NOT NULL,
  `staff_phone` varchar(20) NOT NULL,
  `staff_email` varchar(50) NOT NULL,
  `staff_password` varchar(50) NOT NULL,
  `steps` varchar(10) NOT NULL,
  `category` tinyint(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `staff_tbl`
--

INSERT INTO `staff_tbl` (`staff_id`, `unit`, `staff_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`) VALUES
(1, 2, 'test', '123', 'abc@abc.abc', 'test', '12', 2);

-- --------------------------------------------------------

--
-- 表的结构 `step_tbl`
--

CREATE TABLE `step_tbl` (
  `step_id` int(11) NOT NULL,
  `step_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `step_tbl`
--

INSERT INTO `step_tbl` (`step_id`, `step_name`) VALUES
(1, '提交'),
(2, '登记'),
(3, '审核'),
(4, '交办'),
(5, '办理'),
(6, '反馈'),
(7, '完成');

-- --------------------------------------------------------

--
-- 表的结构 `sub_menu_tbl`
--

CREATE TABLE `sub_menu_tbl` (
  `id` int(11) NOT NULL,
  `parent_id` int(11) NOT NULL DEFAULT '-1',
  `key_word` varchar(30) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `sub_menu_tbl`
--

INSERT INTO `sub_menu_tbl` (`id`, `parent_id`, `key_word`, `name`) VALUES
(7, 103, 'operator', '操作员'),
(8, 103, 'options', '控制选项'),
(10, 104, 'motion_temp_edit', '模板编辑'),
(11, 104, 'attr_temp_edit', '选项编辑');

-- --------------------------------------------------------

--
-- 替换视图以便查看 `sub_menu_view`
--
CREATE TABLE `sub_menu_view` (
`f_id` int(11)
,`f_key` varchar(20)
,`f_name` varchar(20)
,`s_id` int(11)
,`s_key` varchar(30)
,`s_name` varchar(30)
);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `unit_detail_view`
--
CREATE TABLE `unit_detail_view` (
`unit_id` int(11)
,`unit_group` int(11)
,`parent_unit` int(11)
,`parent_unit_name` varchar(50)
,`category` int(11)
,`steps` varchar(20)
,`unit_name` varchar(50)
,`unit_group_name` varchar(50)
,`category_name` varchar(10)
);

-- --------------------------------------------------------

--
-- 表的结构 `unit_group_tbl`
--

CREATE TABLE `unit_group_tbl` (
  `unit_group_id` int(11) NOT NULL,
  `unit_group_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `unit_group_tbl`
--

INSERT INTO `unit_group_tbl` (`unit_group_id`, `unit_group_name`) VALUES
(1, '党委系统'),
(2, '人大机关'),
(3, '政府系统'),
(4, '政协机关'),
(5, '其他单位');

-- --------------------------------------------------------

--
-- 表的结构 `unit_tbl`
--

CREATE TABLE `unit_tbl` (
  `unit_id` int(11) NOT NULL,
  `unit_group` int(11) NOT NULL,
  `parent_unit` int(11) NOT NULL DEFAULT '0',
  `category` int(11) NOT NULL,
  `steps` varchar(20) NOT NULL,
  `unit_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `unit_tbl`
--

INSERT INTO `unit_tbl` (`unit_id`, `unit_group`, `parent_unit`, `category`, `steps`, `unit_name`) VALUES
(1, 1, 0, 3, '5', '市科技局'),
(2, 4, 0, 2, '123', '市政协提案委');

-- --------------------------------------------------------

--
-- 表的结构 `user_group_tbl`
--

CREATE TABLE `user_group_tbl` (
  `user_group_id` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `user_group_name` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `user_tbl`
--

CREATE TABLE `user_tbl` (
  `user_id` int(11) NOT NULL,
  `user_name` varchar(10) NOT NULL,
  `user_phone` varchar(11) NOT NULL,
  `id_card` varchar(18) DEFAULT NULL,
  `mail` varchar(50) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `password` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user_tbl`
--

INSERT INTO `user_tbl` (`user_id`, `user_name`, `user_phone`, `id_card`, `mail`, `address`, `password`) VALUES
(1, '测试用户', '1234567', NULL, NULL, NULL, '123');

-- --------------------------------------------------------

--
-- 视图结构 `motion_attr_view`
--
DROP TABLE IF EXISTS `motion_attr_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_attr_view`  AS  select `b`.`attr_name` AS `attr_name`,`c`.`motion_template_name` AS `motion_template_name`,`d`.`step_name` AS `step_name`,`a`.`motion_attr_id` AS `motion_attr_id`,`a`.`motion_template` AS `motion_template`,`a`.`attr_template` AS `attr_template`,`a`.`default_value` AS `default_value`,`a`.`hidden` AS `hidden`,`a`.`value_type` AS `value_type`,`a`.`target` AS `target`,`a`.`value_sort` AS `value_sort`,`b`.`option` AS `option`,`a`.`step` AS `step` from (((`motion_attr_tbl` `a` left join `attr_template_tbl` `b` on((`a`.`attr_template` = `b`.`attr_template_id`))) left join `motion_template_tbl` `c` on((`a`.`motion_template` = `c`.`motion_template_id`))) left join `step_tbl` `d` on((`a`.`step` = `d`.`step_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `motion_view`
--
DROP TABLE IF EXISTS `motion_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_view`  AS  select `a`.`motion_id` AS `motion_id`,`a`.`meeting` AS `meeting`,`a`.`category` AS `category`,`a`.`motion_name` AS `motion_name`,`d`.`attr_id` AS `attr_id`,`a`.`motion_template` AS `motion_template`,`b`.`motion_attr_id` AS `motion_attr`,`c`.`attr_template_id` AS `attr_template`,`a`.`user` AS `user`,`a`.`document` AS `document`,`a`.`step` AS `step`,`b`.`step` AS `attr_step`,`a`.`document_sha` AS `document_sha`,`a`.`upload_time` AS `upload_time`,`b`.`default_value` AS `default_value`,`b`.`value_type` AS `value_type`,`b`.`target` AS `target`,`b`.`value_sort` AS `value_sort`,`b`.`hidden` AS `hidden`,`c`.`attr_name` AS `attr_name`,`c`.`option` AS `option`,`d`.`content` AS `content`,`d`.`content_int` AS `content_int`,`d`.`attachment` AS `attachment` from (((`motion_tbl` `a` left join `motion_attr_tbl` `b` on((`a`.`motion_template` = `b`.`motion_template`))) left join `attr_template_tbl` `c` on((`b`.`attr_template` = `c`.`attr_template_id`))) left join `attr_tbl` `d` on(((`a`.`motion_id` = `d`.`motion`) and (`b`.`motion_attr_id` = `d`.`motion_attr`)))) ;

-- --------------------------------------------------------

--
-- 视图结构 `op_pms_view`
--
DROP TABLE IF EXISTS `op_pms_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `op_pms_view`  AS  select `a`.`pms_id` AS `pms_id`,`b`.`id` AS `id`,`b`.`name` AS `name`,`b`.`pwd` AS `pwd`,`b`.`create_time` AS `create_time`,`b`.`creator` AS `creator`,`b`.`md5` AS `md5` from (`operator_tbl` `b` left join `op_pms_tbl` `a` on((`a`.`o_id` = `b`.`id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `pms_view`
--
DROP TABLE IF EXISTS `pms_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `pms_view`  AS  select `f`.`id` AS `f_id`,`f`.`key_word` AS `f_key`,`f`.`name` AS `f_name`,`s`.`id` AS `s_id`,`s`.`key_word` AS `s_key`,`s`.`name` AS `s_name` from (`pms_tbl` `f` left join `sub_menu_tbl` `s` on((`s`.`parent_id` = `f`.`id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `sub_menu_view`
--
DROP TABLE IF EXISTS `sub_menu_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sub_menu_view`  AS  select `f`.`id` AS `f_id`,`f`.`key_word` AS `f_key`,`f`.`name` AS `f_name`,`s`.`id` AS `s_id`,`s`.`key_word` AS `s_key`,`s`.`name` AS `s_name` from (`sub_menu_tbl` `s` left join `pms_tbl` `f` on((`s`.`parent_id` = `f`.`id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `unit_detail_view`
--
DROP TABLE IF EXISTS `unit_detail_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `unit_detail_view`  AS  select `a`.`unit_id` AS `unit_id`,`a`.`unit_group` AS `unit_group`,`a`.`parent_unit` AS `parent_unit`,`e`.`unit_name` AS `parent_unit_name`,`a`.`category` AS `category`,`a`.`steps` AS `steps`,`a`.`unit_name` AS `unit_name`,`b`.`unit_group_name` AS `unit_group_name`,`c`.`category_name` AS `category_name` from (((`unit_tbl` `a` left join `unit_group_tbl` `b` on((`a`.`unit_group` = `b`.`unit_group_id`))) left join `category_tbl` `c` on((`a`.`category` = `c`.`category_id`))) left join `unit_tbl` `e` on((`a`.`parent_unit` = `e`.`unit_id`))) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attr_tbl`
--
ALTER TABLE `attr_tbl`
  ADD PRIMARY KEY (`attr_id`),
  ADD KEY `motion` (`motion`);

--
-- Indexes for table `attr_template_tbl`
--
ALTER TABLE `attr_template_tbl`
  ADD PRIMARY KEY (`attr_template_id`);

--
-- Indexes for table `category_tbl`
--
ALTER TABLE `category_tbl`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `duty_tbl`
--
ALTER TABLE `duty_tbl`
  ADD PRIMARY KEY (`duty_id`);

--
-- Indexes for table `meeting_tbl`
--
ALTER TABLE `meeting_tbl`
  ADD PRIMARY KEY (`meeting_id`),
  ADD KEY `category` (`category`);

--
-- Indexes for table `motion_attr_tbl`
--
ALTER TABLE `motion_attr_tbl`
  ADD PRIMARY KEY (`motion_attr_id`);

--
-- Indexes for table `motion_handler_tbl`
--
ALTER TABLE `motion_handler_tbl`
  ADD PRIMARY KEY (`motion_handler_id`);

--
-- Indexes for table `motion_tbl`
--
ALTER TABLE `motion_tbl`
  ADD PRIMARY KEY (`motion_id`);

--
-- Indexes for table `motion_template_tbl`
--
ALTER TABLE `motion_template_tbl`
  ADD PRIMARY KEY (`motion_template_id`);

--
-- Indexes for table `operator_tbl`
--
ALTER TABLE `operator_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `op_pms_tbl`
--
ALTER TABLE `op_pms_tbl`
  ADD PRIMARY KEY (`o_id`,`pms_id`);

--
-- Indexes for table `pms_tbl`
--
ALTER TABLE `pms_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `response_area_tbl`
--
ALTER TABLE `response_area_tbl`
  ADD PRIMARY KEY (`response_area_id`);

--
-- Indexes for table `staff_tbl`
--
ALTER TABLE `staff_tbl`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `step_tbl`
--
ALTER TABLE `step_tbl`
  ADD PRIMARY KEY (`step_id`);

--
-- Indexes for table `sub_menu_tbl`
--
ALTER TABLE `sub_menu_tbl`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `unit_group_tbl`
--
ALTER TABLE `unit_group_tbl`
  ADD PRIMARY KEY (`unit_group_id`);

--
-- Indexes for table `unit_tbl`
--
ALTER TABLE `unit_tbl`
  ADD PRIMARY KEY (`unit_id`);

--
-- Indexes for table `user_group_tbl`
--
ALTER TABLE `user_group_tbl`
  ADD PRIMARY KEY (`user_group_id`);

--
-- Indexes for table `user_tbl`
--
ALTER TABLE `user_tbl`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_name` (`user_name`,`user_phone`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `attr_tbl`
--
ALTER TABLE `attr_tbl`
  MODIFY `attr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `attr_template_tbl`
--
ALTER TABLE `attr_template_tbl`
  MODIFY `attr_template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- 使用表AUTO_INCREMENT `category_tbl`
--
ALTER TABLE `category_tbl`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `duty_tbl`
--
ALTER TABLE `duty_tbl`
  MODIFY `duty_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `meeting_tbl`
--
ALTER TABLE `meeting_tbl`
  MODIFY `meeting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `motion_attr_tbl`
--
ALTER TABLE `motion_attr_tbl`
  MODIFY `motion_attr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
--
-- 使用表AUTO_INCREMENT `motion_handler_tbl`
--
ALTER TABLE `motion_handler_tbl`
  MODIFY `motion_handler_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `motion_tbl`
--
ALTER TABLE `motion_tbl`
  MODIFY `motion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
--
-- 使用表AUTO_INCREMENT `motion_template_tbl`
--
ALTER TABLE `motion_template_tbl`
  MODIFY `motion_template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `operator_tbl`
--
ALTER TABLE `operator_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `pms_tbl`
--
ALTER TABLE `pms_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;
--
-- 使用表AUTO_INCREMENT `response_area_tbl`
--
ALTER TABLE `response_area_tbl`
  MODIFY `response_area_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `staff_tbl`
--
ALTER TABLE `staff_tbl`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- 使用表AUTO_INCREMENT `step_tbl`
--
ALTER TABLE `step_tbl`
  MODIFY `step_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- 使用表AUTO_INCREMENT `sub_menu_tbl`
--
ALTER TABLE `sub_menu_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- 使用表AUTO_INCREMENT `unit_group_tbl`
--
ALTER TABLE `unit_group_tbl`
  MODIFY `unit_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `unit_tbl`
--
ALTER TABLE `unit_tbl`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `user_group_tbl`
--
ALTER TABLE `user_group_tbl`
  MODIFY `user_group_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `user_tbl`
--
ALTER TABLE `user_tbl`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
