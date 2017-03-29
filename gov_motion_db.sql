-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2017-03-29 10:31:33
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
(48, 6, 25, 16, '委员', 0, NULL, 6725, '2017-03-29 06:13:09'),
(49, 6, 36, 3, '附件测试', 0, NULL, 6725, '2017-03-29 06:13:09');

-- --------------------------------------------------------

--
-- 表的结构 `attr_template_tbl`
--

CREATE TABLE `attr_template_tbl` (
  `attr_template_id` int(11) NOT NULL,
  `attr_name` varchar(100) NOT NULL,
  `option` varchar(500) DEFAULT NULL,
  `system` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `attr_template_tbl`
--

INSERT INTO `attr_template_tbl` (`attr_template_id`, `attr_name`, `option`, `system`) VALUES
(1, '是否公开', '["公开","不公开"]', 0),
(2, '类别', '["建议","议案","提案"]', 0),
(3, '案由', NULL, 0),
(4, '领衔人', NULL, 0),
(5, '附议人', NULL, 0),
(6, '性质类别2', '["工业经济","农林水利","财贸金融","道路交通","城建管理","环境保护","医药卫生","科技教育","文化体育","劳动人事","政法统战","其他"]', 0),
(7, '登记时间', NULL, 0),
(8, '状态', '["大会期间","闭会期间","重新办理"]', 0),
(9, '性质', '["当年","多年重复","重点督办","重点提案","重点提案备选"]', 0),
(10, '审核', '["立案","不予立案"]', 0),
(11, '审核意见', NULL, 0),
(12, '原文', NULL, 0),
(13, '主办单位', NULL, 1),
(14, '协办单位', NULL, 1),
(15, '交办单位', NULL, 1),
(16, '提案分类', '["委员","党派团体","联合提案"]', 0),
(17, '案号', '', 0),
(18, '摘要', NULL, 0),
(19, '主办答复时间', NULL, 0),
(20, '文号', NULL, 0),
(21, '类别标记', '["A","B","C","D"]', 0),
(22, '主办签发人', NULL, 0),
(23, '主办联系人', NULL, 0),
(24, '主办联系电话', NULL, 0),
(25, '已落实事项', NULL, 0),
(26, '计划落实事项', NULL, 0),
(27, '落实时限', NULL, 0),
(28, '未采纳或未落实理由', NULL, 0),
(29, '主办答复全文', NULL, 0),
(30, '反馈签收人', NULL, 0),
(31, '反馈时间', NULL, 0),
(32, '反馈联系电话', NULL, 0),
(33, '反馈手机', NULL, 0),
(34, '办理工作', '["满意","基本满意","不满意","未表态"]', 0),
(35, '办理结果', '["满意","基本满意","不满意","未表态"]', 0),
(36, '面商形式', '["登门走访","其他"]', 0),
(37, '面商人', NULL, 0),
(38, '采纳情况', NULL, 0),
(39, '落实情况', NULL, 0),
(40, '反馈意见全文', NULL, 0),
(41, '性质类别1', '["工业经济","农林水利","财贸金融","道路交通","城建管理","环境保护"]', 0);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `attr_view`
--
CREATE TABLE `attr_view` (
`attr_id` int(11)
,`motion` int(11)
,`motion_attr` int(11)
,`attr_template` int(11)
,`content` varchar(500)
,`content_int` int(11)
,`attachment` varchar(500)
,`staff` int(11)
,`update_time` timestamp
,`attr_name` varchar(100)
);

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
  `user_unit` int(11) NOT NULL,
  `user_group` int(11) DEFAULT NULL,
  `admin_type` varchar(10) DEFAULT NULL,
  `activity` tinyint(4) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `duty_tbl`
--

INSERT INTO `duty_tbl` (`duty_id`, `user`, `category`, `meeting`, `user_unit`, `user_group`, `admin_type`, `activity`) VALUES
(1, 1, 2, 1, 1, 1, NULL, 1),
(2, 2, 2, 1, 1, 1, NULL, 1);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `duty_view`
--
CREATE TABLE `duty_view` (
`meeting_name` varchar(50)
,`start_time` int(11)
,`end_time` int(11)
,`deadline_time` int(11)
,`duty_id` int(11)
,`user` int(11)
,`category` int(11)
,`meeting` int(11)
,`user_unit` int(11)
,`user_group` int(11)
,`admin_type` varchar(10)
,`activity` tinyint(4)
,`user_name` varchar(10)
,`user_phone` varchar(11)
,`party` varchar(10)
,`user_unit_name` varchar(20)
,`unit` int(11)
,`user_group_name` varchar(20)
);

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
  `motion_template` int(11) NOT NULL,
  `jie` int(11) DEFAULT '0',
  `ci` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `meeting_tbl`
--

INSERT INTO `meeting_tbl` (`meeting_id`, `meeting_name`, `start_time`, `end_time`, `deadline_time`, `category`, `motion_template`, `jie`, `ci`) VALUES
(1, '慈溪市政协第XX届第XX次会议', 123, 1234, 1490511241, 2, 2, 0, 0),
(2, '慈溪市人大第XX届第XX次会议', 123, 1234, 12345, 1, 1, 1, 1);

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
  `hidden` tinyint(4) NOT NULL DEFAULT '0',
  `has_attachment` tinyint(1) NOT NULL DEFAULT '0',
  `multiple` tinyint(4) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `motion_attr_tbl`
--

INSERT INTO `motion_attr_tbl` (`motion_attr_id`, `motion_template`, `attr_template`, `default_value`, `value_type`, `target`, `value_sort`, `step`, `hidden`, `has_attachment`, `multiple`) VALUES
(1, 1, 1, '公开', 'string', NULL, 0, 2, 0, 0, 0),
(6, 1, 4, '', 'index', 'duty', 0, 1, 0, 0, 0),
(7, 1, 5, '', 'index', 'duty', 0, 1, 0, 0, 1),
(8, 1, 10, '立案', 'string', NULL, 0, 3, 0, 0, 0),
(9, 1, 11, '', 'string', NULL, 0, 3, 0, 0, 0),
(10, 2, 1, '公开', 'string', NULL, 80, 2, 0, 0, 0),
(13, 2, 4, '', 'index', 'duty', 0, 1, 0, 0, 0),
(14, 2, 5, '', 'index', 'duty', 0, 1, 0, 0, 1),
(15, 2, 6, '其他', 'string', NULL, 0, 2, 0, 0, 0),
(16, 2, 8, '大会期间', 'string', NULL, 0, 2, 0, 0, 0),
(17, 2, 10, '立案', 'string', NULL, 0, 3, 0, 0, 0),
(18, 2, 11, '', 'string', NULL, 0, 3, 0, 0, 0),
(19, 2, 7, '', 'time', NULL, 0, 2, 0, 0, 0),
(20, 2, 9, '当年', 'string', NULL, 0, 2, 0, 0, 0),
(21, 2, 12, '', 'attachment', NULL, 0, 1, 0, 1, 0),
(22, 2, 13, '', 'index', 'unit', 0, 4, 0, 0, 0),
(23, 2, 14, '', 'index', 'unit', 0, 4, 0, 0, 1),
(24, 2, 15, '', 'index', 'unit', 0, 3, 0, 0, 0),
(25, 2, 16, '委员', 'string', NULL, 70, 1, 0, 0, 0),
(26, 2, 17, '', 'int', NULL, 100, 2, 0, 0, 0),
(27, 1, 7, '', 'time', NULL, 0, 2, 0, 0, 0),
(29, 1, 9, '当年', 'string', NULL, 0, 2, 0, 0, 0),
(30, 1, 8, '大会期间', 'string', NULL, 0, 2, 0, 0, 0),
(31, 1, 12, '', 'attachment', NULL, 0, 1, 0, 1, 0),
(32, 1, 13, '', 'index', 'unit', 0, 4, 0, 0, 0),
(33, 1, 14, '', 'index', 'unit', 0, 4, 0, 0, 1),
(34, 1, 17, '', 'int', NULL, 100, 2, 0, 0, 0),
(35, 2, 18, '', 'string', NULL, 0, 2, 0, 0, 0),
(36, 2, 3, '', 'string', NULL, 95, 1, 0, 0, 0),
(37, 2, 19, '', 'time', NULL, 0, 5, 0, 0, 0),
(38, 2, 20, '', 'string', NULL, 0, 5, 0, 0, 0),
(39, 2, 21, 'A', 'string', NULL, 0, 5, 0, 0, 0),
(40, 2, 22, '', 'string', NULL, 0, 5, 0, 0, 0),
(41, 2, 23, '', 'string', NULL, 0, 5, 0, 0, 0),
(42, 2, 24, '', 'string', NULL, 0, 5, 0, 0, 0),
(43, 2, 25, '', 'string', NULL, 0, 5, 0, 0, 0),
(44, 2, 26, '', 'string', NULL, 0, 5, 0, 0, 0),
(45, 2, 27, '', 'time', NULL, 0, 5, 0, 0, 0),
(46, 2, 28, '', 'string', NULL, 0, 5, 0, 0, 0),
(47, 2, 29, '', 'attachment', NULL, 0, 5, 0, 0, 0),
(48, 2, 30, '', 'string', NULL, 0, 6, 0, 0, 0),
(49, 2, 31, '', 'time', NULL, 0, 6, 0, 0, 0),
(50, 2, 32, '', 'string', NULL, 0, 6, 0, 0, 0),
(51, 2, 33, '', 'string', NULL, 0, 6, 0, 0, 0),
(52, 2, 34, '满意', 'string', NULL, 0, 6, 0, 0, 0),
(53, 2, 35, '满意', 'string', NULL, 0, 6, 0, 0, 0),
(54, 2, 36, '登门走访', 'string', NULL, 0, 6, 0, 0, 0),
(55, 2, 37, '', 'string', NULL, 0, 6, 0, 0, 0),
(56, 2, 38, '', 'string', NULL, 0, 6, 0, 0, 0),
(57, 2, 39, '', 'string', NULL, 0, 6, 0, 0, 0),
(58, 2, 40, '', 'attachment', NULL, 0, 6, 0, 0, 0),
(59, 1, 18, '', 'string', NULL, 0, 2, 0, 0, 0),
(60, 1, 19, '', 'string', NULL, 0, 5, 0, 0, 0),
(61, 1, 3, '', 'string', NULL, 95, 1, 0, 0, 0),
(62, 1, 20, '', 'string', NULL, 0, 5, 0, 0, 0),
(63, 1, 21, 'B', 'string', NULL, 0, 5, 0, 0, 0),
(64, 1, 22, '', 'string', NULL, 0, 5, 0, 0, 0),
(65, 1, 23, '', 'string', NULL, 0, 5, 0, 0, 0),
(66, 1, 24, '', 'string', NULL, 0, 5, 0, 0, 0),
(67, 1, 25, '', 'string', NULL, 0, 5, 0, 0, 0),
(68, 1, 26, '', 'string', NULL, 0, 5, 0, 0, 0),
(69, 1, 27, '', 'time', NULL, 0, 5, 0, 0, 0),
(70, 1, 28, '', 'string', NULL, 0, 5, 0, 0, 0),
(71, 1, 29, '', 'attachment', NULL, 0, 5, 0, 0, 0),
(72, 1, 30, '', 'string', NULL, 0, 6, 0, 0, 0),
(73, 1, 31, '', 'time', NULL, 0, 6, 0, 0, 0),
(74, 1, 32, '', 'string', NULL, 0, 6, 0, 0, 0),
(75, 1, 33, '', 'string', NULL, 0, 6, 0, 0, 0),
(76, 1, 34, '满意', 'string', NULL, 0, 6, 0, 0, 0),
(77, 1, 35, '满意', 'string', NULL, 0, 6, 0, 0, 0),
(78, 1, 36, '登门走访', 'string', NULL, 0, 6, 0, 0, 0),
(79, 1, 37, '', 'string', NULL, 0, 6, 0, 0, 0),
(80, 1, 38, '', 'string', NULL, 0, 6, 0, 0, 0),
(81, 1, 39, '', 'string', NULL, 0, 6, 0, 0, 0),
(82, 1, 40, '', 'attachment', NULL, 0, 6, 0, 0, 0),
(83, 1, 41, '工业经济', 'string', NULL, 0, 1, 0, 0, 0);

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
,`has_attachment` tinyint(1)
,`multiple` tinyint(4)
,`option` varchar(500)
,`step` int(11)
);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `motion_for_index_view`
--
CREATE TABLE `motion_for_index_view` (
`motion_id` int(11)
,`meeting` int(11)
,`category` int(11)
,`motion_name` varchar(50)
,`motion_template` int(11)
,`user` int(11)
,`document` varchar(400)
,`step` int(11)
,`document_sha` varchar(50)
,`upload_time` timestamp
,`step_name` varchar(50)
);

-- --------------------------------------------------------

--
-- 表的结构 `motion_handler_tbl`
--

CREATE TABLE `motion_handler_tbl` (
  `motion_handler_id` int(11) NOT NULL,
  `motion` int(11) NOT NULL,
  `attr` int(11) NOT NULL,
  `unit` int(11) NOT NULL,
  `staff` int(11) DEFAULT NULL,
  `receive_time` int(11) DEFAULT NULL,
  `reply_time` int(11) DEFAULT NULL,
  `contact_name` varchar(15) DEFAULT NULL,
  `contact_phone` varchar(20) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `attachment` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 替换视图以便查看 `motion_handler_view`
--
CREATE TABLE `motion_handler_view` (
`motion_handler_id` int(11)
,`motion` int(11)
,`attr` int(11)
,`unit` int(11)
,`staff` int(11)
,`receive_time` int(11)
,`reply_time` int(11)
,`contact_name` varchar(15)
,`contact_phone` varchar(20)
,`phone` varchar(20)
,`attachment` varchar(500)
,`unit_name` varchar(50)
,`full_name` varchar(30)
);

-- --------------------------------------------------------

--
-- 替换视图以便查看 `motion_inf_view`
--
CREATE TABLE `motion_inf_view` (
`motion_id` int(11)
,`meeting` int(11)
,`category` int(11)
,`motion_name` varchar(50)
,`motion_template` int(11)
,`user` int(11)
,`duty` int(11)
,`document` varchar(400)
,`step` int(11)
,`document_sha` varchar(50)
,`upload_time` timestamp
,`meeting_name` varchar(50)
,`start_time` int(11)
,`end_time` int(11)
,`deadline_time` int(11)
);

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
  `user` int(11) DEFAULT NULL,
  `duty` int(11) DEFAULT NULL,
  `document` varchar(400) DEFAULT NULL,
  `step` int(11) NOT NULL,
  `document_sha` varchar(50) DEFAULT NULL,
  `upload_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `motion_tbl`
--

INSERT INTO `motion_tbl` (`motion_id`, `meeting`, `category`, `motion_name`, `motion_template`, `user`, `duty`, `document`, `step`, `document_sha`, `upload_time`) VALUES
(6, 1, 2, '附件测试', 2, NULL, 0, NULL, 2, NULL, '2017-03-29 06:12:06'),
(7, 1, 2, '新建', 2, NULL, NULL, NULL, 1, NULL, '2017-03-29 06:30:44');

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
,`zx_motion` int(11)
,`meeting` int(11)
,`category` int(11)
,`motion_name` varchar(50)
,`attr_id` int(11)
,`motion_template` int(11)
,`motion_attr` int(11)
,`attr_template` int(11)
,`duty` int(11)
,`document` varchar(400)
,`step` int(11)
,`step_name` varchar(50)
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
,`has_attachment` tinyint(1)
,`attachment` varchar(500)
,`multiple` tinyint(4)
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

--
-- 转存表中的数据 `op_pms_tbl`
--

INSERT INTO `op_pms_tbl` (`o_id`, `pms_id`, `remark`, `remark2`) VALUES
(1, '103', NULL, NULL),
(1, '104', NULL, NULL),
(1, '105', NULL, NULL);

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
(104, 'HwUVAMBMpr', '模板管理', NULL),
(105, 'tyNYcGfxbV', '流程权限', NULL),
(106, 'NPAsVCpYHn', '会议管理', NULL);

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
-- 替换视图以便查看 `staff_admin_view`
--
CREATE TABLE `staff_admin_view` (
`staff_id` int(11)
,`out_id` int(11)
,`staff_unid` varchar(35)
,`unit` int(11)
,`staff_name` varchar(20)
,`full_name` varchar(30)
,`staff_phone` varchar(20)
,`staff_email` varchar(50)
,`staff_password` varchar(50)
,`steps` varchar(10)
,`unit_steps` varchar(20)
,`category` tinyint(1)
,`user_admin` varchar(80)
,`reorder` int(11)
,`unit_name` varchar(50)
,`parent_unit` int(11)
,`unit_group` int(11)
,`parent_unit_name` varchar(50)
);

-- --------------------------------------------------------

--
-- 表的结构 `staff_tbl`
--

CREATE TABLE `staff_tbl` (
  `staff_id` int(11) NOT NULL,
  `out_id` int(11) DEFAULT NULL,
  `staff_unid` varchar(35) DEFAULT NULL,
  `unit` int(11) NOT NULL,
  `staff_name` varchar(20) NOT NULL,
  `full_name` varchar(30) DEFAULT NULL,
  `staff_phone` varchar(20) DEFAULT NULL,
  `staff_email` varchar(50) DEFAULT NULL,
  `staff_password` varchar(50) DEFAULT NULL,
  `steps` varchar(10) DEFAULT '',
  `category` tinyint(1) NOT NULL DEFAULT '3',
  `user_admin` varchar(80) DEFAULT '{}' COMMENT 'key:表名，v:id，保存可访问的用户群组',
  `reorder` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `staff_tbl`
--

INSERT INTO `staff_tbl` (`staff_id`, `out_id`, `staff_unid`, `unit`, `staff_name`, `full_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`, `user_admin`, `reorder`) VALUES
(3657, 2, '49C681109A3FAB1948257380000E74D5', 157, 'adzcl', '庵东镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3658, 3, 'FDD64BCCD171890548256CB4000B9C9D', 157, 'adzczb', '庵东镇村镇办', NULL, NULL, NULL, '', 3, '{}', 88),
(3659, 4, '3ED9BC7B819561D148256B38002AAB16', 157, 'adzczs', '庵东镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(3660, 5, '4505FBEAACF8633B48256CB4000B8CA0', 157, 'adzdqb', '庵东镇党群办', NULL, NULL, NULL, '', 3, '{}', 88),
(3661, 6, '5F3017E017F5258848256CB4000B7470', 157, 'adzdqsj', '庵东镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3662, 7, '32154666CF32509B48256B38002AA9EF', 157, 'adzdzb', '庵东镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(3663, 8, '2E197C8C13BB9BF948257559001BFA44', 157, 'adzfl', '庵东镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(3664, 9, 'EF16D926586CE6D54825705200042BD4', 157, 'adzgh', '庵东镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3665, 10, '82A50FE55F636A1448256DA6000CAEA4', 157, 'adzhzb', '庵东镇环治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3666, 11, 'F5881836B59EE7BE48256CB4000B94A8', 157, 'adzjfb', '庵东镇经发办', NULL, NULL, NULL, '5', 3, '{}', 88),
(3667, 12, '8F7DCF124508718348256EF400044177', 157, 'adzjpb', '庵东镇经普办', NULL, NULL, NULL, '', 3, '{}', 88),
(3668, 13, 'A340750DA7E7D05D48256B38002AADED', 157, 'adzjsb', '庵东镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(3669, 14, '800CC47F58F3A96348256CB4000B98C0', 157, 'adzjwb', '庵东镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(3670, 15, '57172A0B514CFFDC48256D4000041628', 157, 'adzmzb', '庵东镇社保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3671, 16, 'B460479134B1069948256CB4000B909B', 157, 'adznb', '庵东镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(3672, 17, 'F7E86F0830E91C0548256CB4000B7C9A', 157, 'adzrdzxt', '庵东镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(3673, 18, 'B48753AECD95F40D48256CB4000B88B9', 157, 'adzrwb', '庵东镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(3674, 19, '47E1AA7498535DE448256CB4000B6C09', 157, 'adzsj', '庵东镇书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3675, 20, 'B03824BD3A38E7C148256EF400065BAC', 157, 'adztgs', '庵东镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(3676, 21, '18DD2E33D639BAF848256B38002AAC59', 157, 'adztjz', '庵东镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3677, 22, '70E79E632F34D25248256D2B002A2CC0', 157, 'adztw', '庵东镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(3678, 23, '87C8547329C4C67A48256CB4000BA466', 157, 'adzws', '庵东镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(3679, 24, '4C560848B754704948256CB4000B84CF', 157, 'adzxcwy', '庵东镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3680, 25, 'EE73E4904B68A64548256CB4000B788C', 157, 'adzzfsj', '庵东镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3681, 26, 'BC56CE3CCC3613494825722F002F34CB', 157, 'adzzxllw', '庵东镇政协联络委', NULL, NULL, NULL, '1', 2, '{"unit":4}', 88),
(3682, 27, '2F26D7E380F6E66E48256CB4000B7032', 157, 'adzzz', '庵东镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(3683, 28, '6C07ACB030FEA55248256CB4000BA077', 157, 'adzzzb', '庵东镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3684, 29, '1ADC17FD8B20E57948256CB4000B8096', 157, 'adzzzwy', '庵东镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3685, 30, 'FBEB2AC3CEC2FF0F482572C3002B5E84', 42, 'ajck', '安监窗口', NULL, NULL, NULL, '', 3, '{}', 88),
(3686, 32, '172C9DA9F9A64546482574780026CF29', 161, 'bsljd1', '白沙路街道党工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3687, 33, '07A35989257D26FB48257478002703BE', 161, 'bsljd10', '白沙路街道工业主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3688, 34, 'CEBE313B9414FE6D4825747800270A6C', 161, 'bsljd11', '白沙路街道农业主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3689, 35, 'FE0C8FBD2612C5E9482574780027115B', 161, 'bsljd12', '白沙路街道城建主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3690, 36, '6DE04FA342A1DBE1482574780027163D', 161, 'bsljd13', '白沙路街道人大副主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3691, 37, '972E26389BE8301D4825747800271C4E', 161, 'bsljd14', '白沙路街道调研员1', NULL, NULL, NULL, '', 3, '{}', 88),
(3692, 38, 'E7B76C3A368BCE04482574780027221F', 161, 'bsljd15', '白沙路街道调研员2', NULL, NULL, NULL, '', 3, '{}', 88),
(3693, 39, '0760D17070348286482574780026D913', 161, 'bsljd2', '白沙路街道办事处主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3694, 40, 'B14E954BE078378D482574780026DE65', 161, 'bsljd3', '白沙路街道党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3695, 41, 'B2C74BFF31AB785A482574780026E330', 161, 'bsljd4', '白沙路街道政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3696, 42, '5AF9E3C0E0E3444F482574780026E8D2', 161, 'bsljd5', '白沙路街道人大主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3697, 43, '4BA939BC46425D7E482574780026EE4C', 161, 'bsljd6', '白沙路街道纪工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3698, 44, '642339CC37E9379E482574780026F3E6', 161, 'bsljd7', '白沙路街道宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3699, 45, 'FFF6DFCBD539F971482574780026F9C3', 161, 'bsljd8', '白沙路街道人武委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3700, 46, '36BC9793BE26D654482574780026FEF2', 161, 'bsljd9', '白沙路街道党工委委员（派出所）', NULL, NULL, NULL, '', 3, '{}', 88),
(3701, 47, '82463EC07A8E7B014825749E00293740', 161, 'bsljdcl', '白沙路街道残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3702, 48, '419B4D0EFBBA210A48257478002794F8', 161, 'bsljdcqb', '白沙路街道城区改造办', NULL, NULL, NULL, '', 3, '{}', 88),
(3703, 49, '9653823B32AC11EA4825747800279B6A', 161, 'bsljdcsb', '白沙路街道城市管理办', NULL, NULL, NULL, '', 3, '{}', 88),
(3704, 50, '4CCA531A7779E3BE482574780027AA62', 161, 'bsljdczs', '白沙路街道财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(3705, 51, 'D58420695F509230482574780027BF7E', 161, 'bsljdfl', '白沙路街道妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(3706, 52, '818FEC0ADAE3FB22482574780027B073', 161, 'bsljdfws', '白沙路街道发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(3707, 53, '1C066A022D5D9179482574780027B5EF', 161, 'bsljdgh', '白沙路街道工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3708, 54, 'CF846C80B5213515482574780027BB2A', 161, 'bsljdgqt', '白沙路街道共青团', NULL, NULL, NULL, '', 3, '{}', 88),
(3709, 55, '72787EF34C507BF3482575B600086BCC', 161, 'bsljdhws', '白沙路街道环卫所', NULL, NULL, NULL, '', 3, '{}', 88),
(3710, 56, '34369DDE6B7D81E04825747800272C12', 161, 'bsljdjfb', '白沙路街道经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(3711, 57, '05733D99C6E444F5482574780027A0AF', 161, 'bsljdshb', '白沙路街道社会事业办', NULL, NULL, NULL, '', 3, '{}', 88),
(3712, 58, '13CA4C7661EA695048257480002BAA0B', 161, 'bsljdtjz', '白沙路街道统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3713, 59, '00E813870CEA6F9C48257478002726A1', 161, 'bsljdzhb', '白沙路街道综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(3714, 60, '3D8C9530866F519F482574780027A632', 161, 'bsljdzzb', '白沙路街道综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3715, 62, 'C93B0677EFC678E84825717E000218B3', 6, 'caisj', '开发区蔡世杰', NULL, NULL, NULL, '', 3, '{}', 88),
(3716, 63, '58CB50263AC8315C4825717E0001FA62', 6, 'caoag', '开发区曹爱国', NULL, NULL, NULL, '', 3, '{}', 88),
(3717, 65, 'F493977E2E9BD1F048256D1800319487', 0, 'cdc', '市疾控中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3718, 66, 'A0EB21DDA0BD86AE48256EBA000F2286', 82, 'cdgybbgs', '慈溪滨海经济开发区办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(3719, 67, '9505BA9543B3371348256EBA000F4114', 82, 'cdgybcwk', '慈溪滨海经济开发区财政局', NULL, NULL, NULL, '', 3, '{}', 88),
(3720, 68, '307F16EF3905314048256EBA000EDF80', 82, 'cdgybfzr1', '慈溪滨海经济开发区经发局局长', NULL, NULL, NULL, '', 3, '{}', 88),
(3721, 69, '6A1D117306D98FB148256EBA000F01C7', 82, 'cdgybfzr2', '慈溪滨海经济开发区建设局局长', NULL, NULL, NULL, '', 3, '{}', 88),
(3722, 70, '81B58E4D4C3B625148256EBA000F7E63', 82, 'cdgybghk', '慈溪滨海经济开发区建设局', NULL, NULL, NULL, '', 3, '{}', 88),
(3723, 72, '87972503C64B8EEA48256EBA000F6151', 82, 'cdgybkfk', '慈溪滨海经济开发区经发局', NULL, NULL, NULL, '', 3, '{}', 88),
(3724, 73, 'A38E48A89006D56848256EBA000EA8CA', 82, 'cdgybzr', '慈溪滨海经济开发区办公室主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3725, 74, '69BBE7E5FD2EE0A8482571BE00044ABC', 82, 'cdgyqfsj', '慈溪滨海经济开发区副书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3726, 77, '5B97E2F5A661E1F448256C2B00088AC5', 8, 'cenhc', '市委办岑华潮', NULL, NULL, NULL, '', 3, '{}', 88),
(3727, 84, 'F5CDE85F267079564825717E000383C1', 6, 'chenhongj', '开发区陈红捷', NULL, NULL, NULL, '', 3, '{}', 88),
(3728, 85, '984A944169E4D4DA48256B3A002BEA44', 8, 'chenj', '市委办陈　均', NULL, NULL, NULL, '', 3, '{}', 88),
(3729, 88, '8D24C1E75B71BBD0482570EC001D1978', 6, 'chensd', '开发区陈寿旦', NULL, NULL, NULL, '', 3, '{}', 88),
(3730, 91, '5AD4649B7AE8B81948256B39000846BB', 10, 'chenxm', '市府办陈旭明', NULL, NULL, NULL, '', 3, '{}', 88),
(3731, 92, '95A53FFCF68DF26748256C7C000C950C', 10, 'chenyg', '市府办陈永高', NULL, NULL, NULL, '', 3, '{}', 88),
(3732, 94, 'D46E0CB76EF433DB4825717E0002C521', 6, 'chenyw', '开发区陈亚伟', NULL, NULL, NULL, '', 3, '{}', 88),
(3733, 96, '8A5CC911F48753AF48256B3A002BCB96', 8, 'chenzq', '市委办陈宗群', NULL, NULL, NULL, '', 3, '{}', 88),
(3734, 97, '631AB3F003BB237448256B38004265A1', 8, 'chenzw', '市委办06', NULL, NULL, NULL, '', 3, '{}', 88),
(3735, 98, '2678E4CDCE53B3A548256F2D002220B3', 156, 'chzbmzx', '长河镇便民中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3736, 99, '38A9AA5E0869FECE48257380000E5E86', 156, 'chzcl', '长河镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3737, 100, '7890A0864C2C230948256D17002A9683', 156, 'chzczb', '长河镇村镇办', NULL, NULL, NULL, '', 3, '{}', 88),
(3738, 101, '2D931B3C66DFEF0D48256B38002A9998', 156, 'chzczs', '长河镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(3739, 102, 'B42EB185E06B3A2148256D17002A830B', 156, 'chzdqsj', '长河镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3740, 103, 'FFB4FD52C821196048256B38002A95C1', 156, 'chzdzb', '长河镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(3741, 104, '997B584DA6ACC75B48256F2D0021D46B', 156, 'chzfzzg', '长河镇副镇长(工)', NULL, NULL, NULL, '', 3, '{}', 88),
(3742, 105, '58B6F69BBC26D8A548256F2D0021F51F', 156, 'chzfzzj', '长河镇副镇长(建)', NULL, NULL, NULL, '', 3, '{}', 88),
(3743, 106, '890041FF05C1D73148256F2D0021DF40', 156, 'chzfzzn', '长河镇副镇长(农)', NULL, NULL, NULL, '', 3, '{}', 88),
(3744, 107, '0CAD9D993F41035048256F2D0021EAF7', 156, 'chzfzzw', '长河镇副镇长(文)', NULL, NULL, NULL, '', 3, '{}', 88),
(3745, 108, '72AF1EE780401053482570520004348B', 156, 'chzgh', '长河镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3746, 109, 'C60A5DC3CD7D3C4748256F2D0022004A', 156, 'chzhzb', '长河镇环治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3747, 110, 'A4BEAC19CD8F6AC048256D17002A8FED', 156, 'chzjfb', '长河镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(3748, 111, '568DC13D1976FA3248256B38002A9717', 156, 'chzjsb', '长河镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(3749, 112, '68B0ED7C9ED47C2C48256EC30007B805', 156, 'chzms', '长河镇秘书', NULL, NULL, NULL, '', 3, '{}', 88),
(3750, 113, 'F6C80B60BAB85B3E48256D4000041207', 156, 'chzmzb', '长河镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(3751, 114, '121C5EE91D387BAA48256D17002A9348', 156, 'chznb', '长河镇农　办', NULL, NULL, NULL, '', 3, '{}', 88),
(3752, 115, 'FFB13B890FE5858848256F2D00221681', 156, 'chzrdzxt', '长河镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(3753, 116, '8E29B9C8541C264548256F2D0021CA92', 156, 'chzrwbz', '长河镇人武部长', NULL, NULL, NULL, '', 3, '{}', 88),
(3754, 117, '65004C974904AB5848256F2D002229E4', 156, 'chzsbzx', '长河镇社保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3755, 118, 'EBB89B1EC6E9E43348256EC30007A633', 156, 'chzsfs', '长河镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(3756, 119, '3C9A7067ECCB13A548256D17002A7BCD', 156, 'chzsj', '长河镇书　记', NULL, NULL, NULL, '', 3, '{}', 88),
(3757, 120, '120E2862221D68CF48256EF400064BE3', 156, 'chztgs', '长河镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(3758, 121, '25B3A03A04322FE648256B38002A9846', 156, 'chztjz', '长河镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3759, 122, '17A10B8732B3E8BE48256D2B002A2847', 156, 'chztw', '长河镇团　妇', NULL, NULL, NULL, '', 3, '{}', 88),
(3760, 123, 'A6BF48AD2846112648256EC3000833F3', 156, 'chzwys', '长河镇文印室', NULL, NULL, NULL, '', 3, '{}', 88),
(3761, 124, '8584847F0826742C48256EC3000817A3', 156, 'chzxcb', '长河镇宣传办', NULL, NULL, NULL, '', 3, '{}', 88),
(3762, 125, '743C5EFBCC65DE6248256D17002A8CA2', 156, 'chzxcwy', '长河镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3763, 126, '1CECD8CDE255D805482571F5002EE88A', 156, 'chzzfwy', '长河镇政法副书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3764, 127, '41F96B0193B53D7648256EC30008249C', 156, 'chzzjb', '长河镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(3765, 128, '0C1FF46402C8DDE448256D17002A896B', 156, 'chzzjwy', '长河镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3766, 129, '9AB2ABE9DBFFE614482572AB0007633C', 156, 'chzzxllw', '长河镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(3767, 130, 'B7DB3CD218D105D448256D17002A7F57', 156, 'chzzz', '长河镇镇　长', NULL, NULL, NULL, '', 3, '{}', 88),
(3768, 131, 'F688A19EDED3CD5C482571370022FB70', 156, 'chzzzb', '长河镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3769, 132, '8EE70C0E2A483C5648256D1E002A2579', 9, 'cjhbgw', '市人大城环工委', NULL, NULL, NULL, '', 3, '{}', 88),
(3770, 133, '5317D9D0924A27C148257186002D8A47', 154, 'cszajs', '崇寿镇安监所', NULL, NULL, NULL, '', 3, '{}', 88),
(3771, 134, '1B79827987758F2248256CDE00066B1C', 154, 'cszcjb', '崇寿镇城建办', NULL, NULL, NULL, '', 3, '{}', 88),
(3772, 135, '817847979BB323DF48257380000E2D3C', 154, 'cszcl', '崇寿镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3773, 136, '52033D1079D6862D48256B38002A5B25', 154, 'cszczs', '崇寿镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(3774, 137, 'EAF9B58EFE08E52348256CDE000659A0', 154, 'cszdqb', '崇寿镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(3775, 138, 'E50198CE8D70709A48256CDE0006C973', 154, 'cszdqsj', '崇寿镇专职书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3776, 139, '95FB32E5A604656048256C3E000AEE6F', 154, 'cszdzb', '崇寿镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(3777, 140, '3B771B3C8D935C8F482571C40026B06C', 154, 'cszfl', '崇寿镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(3778, 141, 'EC24EEBBEC7B21084825705200043DC2', 154, 'cszgh', '崇寿镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3779, 142, '9FE84DE9FB68E72C48256EDF0029AA70', 154, 'cszhzb', '崇寿镇环治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3780, 143, 'E24DE99C83180BD048256CDE00065DE5', 154, 'cszjfb', '崇寿镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(3781, 144, '37DD96EEDA17CE0D48256C41002D3359', 154, 'cszjsb', '崇寿镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(3782, 145, '3AFD8DD1B2A6D90948256CDE000666D1', 154, 'cszjwb', '崇寿镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(3783, 146, '90DE802C454E6DB448256D40000409C4', 154, 'cszmzb', '崇寿镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(3784, 147, 'C1C67F52AA3684B148256CDE00066259', 154, 'csznb', '崇寿镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(3785, 148, '5CFD3125A6070EC54825715C002D1321', 154, 'csznpb', '崇寿镇农普办', NULL, NULL, NULL, '', 3, '{}', 88),
(3786, 149, 'BAC9D0C1FD2F5DB348256CDE00065557', 154, 'cszrdzxt', '崇寿镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(3787, 150, '6A8167CC06F210C8482571C400269D64', 154, 'cszrwb', '崇寿镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(3788, 151, '920B83606FD4F2A7482571C400268E31', 154, 'cszrwbz', '崇寿镇人武部长', NULL, NULL, NULL, '', 3, '{}', 88),
(3789, 152, 'AA8A75947B87221648256EDF00299AC0', 154, 'cszsbzx', '崇寿镇劳动保障所', NULL, NULL, NULL, '', 3, '{}', 88),
(3790, 153, '4795BDA5D29581E548256EB30030CDCB', 154, 'cszsfs', '崇寿镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(3791, 154, '0D9853E61E2B9D7048256CDE00063A62', 154, 'cszsj', '崇寿镇书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3792, 155, '29E6CF6C9B684FE948256EF400062AD9', 154, 'csztgs', '崇寿镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(3793, 156, '2BAD104DCF874B3148256B38002A59C6', 154, 'csztjz', '崇寿镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3794, 157, '3AA5E18932F4B1E848256D2B002A1F9F', 154, 'csztw', '崇寿镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(3795, 158, 'E003F80F8D66A3AA48256EDF0029BDE0', 154, 'cszwsb', '崇寿镇文书办', NULL, NULL, NULL, '', 3, '{}', 88),
(3796, 159, 'FAD275AC640F70B848256CDE0006739C', 154, 'cszwys', '崇寿镇文印室', NULL, NULL, NULL, '', 3, '{}', 88),
(3797, 160, 'C20F7CA3D75E200A48256CDE000650ED', 154, 'cszxcwy', '崇寿镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3798, 161, '1C7143B68C10964E482570290023678D', 154, 'cszxfb', '崇寿镇信访办', NULL, NULL, NULL, '', 3, '{}', 88),
(3799, 162, '4BC98F4AD3CDF93C48256CDE00064882', 154, 'cszzfsj', '崇寿镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3800, 163, '6E610EC5D34F97CA482572A400124778', 154, 'cszzx', '崇寿镇政协', NULL, NULL, NULL, '', 3, '{}', 88),
(3801, 164, '5EF5A1885B9A9692482572AB00074988', 154, 'cszzxllw', '崇寿镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(3802, 165, '2033BDCB8750A44648256CDE00063EEC', 154, 'cszzz', '崇寿镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(3803, 166, 'AF400E42291310B048256CDE00066F58', 154, 'cszzzb', '崇寿镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3804, 167, 'F205282B166FA71F48256CDE00064CAD', 154, 'cszzzwy', '崇寿镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3805, 168, 'D6AD9AF09049D61748256EEB000D6E1E', 6, 'cxkfqcfj', '开发区陈富均', NULL, NULL, NULL, '', 3, '{}', 88),
(3806, 169, 'D8B0C3D4C128665848256EEB000E0675', 6, 'cxkfqfj', '开发区方健', NULL, NULL, NULL, '', 3, '{}', 88),
(3807, 170, '91158DD340F3047A4825717E000269D8', 6, 'cxkfqghjsj', '规划建设管理局', NULL, NULL, NULL, '', 3, '{}', 88),
(3808, 171, 'BD5359F19461FDF348256EEB000E7E85', 6, 'cxkfqjjfzj', '开发区经济发展局', NULL, NULL, NULL, '', 3, '{}', 88),
(3809, 173, 'FC4A13405030E4A148256EEB000E5133', 6, 'cxkfqshswj', '开发区社会事务局', NULL, NULL, NULL, '', 3, '{}', 88),
(3810, 174, 'F91139F5EE2C777948256EEB000E160B', 6, 'cxkfqsk', '开发区施科', NULL, NULL, NULL, '', 3, '{}', 88),
(3811, 175, '927B3F63A21ADC4E48256EEB000E97D0', 6, 'cxkfqtzhzj', '开发区投资合作局', NULL, NULL, NULL, '', 3, '{}', 88),
(3812, 176, '251B67209013BDDF48256EEB000D9E6D', 6, 'cxkfqygr', '开发区严国如', NULL, NULL, NULL, '', 3, '{}', 88),
(3813, 177, '9B85053556DD5A8A48256EEB000DFB65', 6, 'cxkfqyjq', '开发区余建强', NULL, NULL, NULL, '', 3, '{}', 88),
(3814, 178, '2EC31D370CE9C75C48256EEB000DE6C4', 6, 'cxkfqyzl', '开发区余自力', NULL, NULL, NULL, '', 3, '{}', 88),
(3815, 179, '6BD0CEA7E63F14374825717F002999A7', 6, 'cxkfqzyy', '开发区周尧云', NULL, NULL, NULL, '', 3, '{}', 88),
(3816, 180, '6D10AFC9F5CA8F6948256B370024739F', 27, 'cxrbsbgs', '慈溪日报社办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(3817, 181, '9B9575586D5F781D4825743A00089752', 27, 'cxrbsywb', '慈溪日报社要闻部', NULL, NULL, NULL, '', 3, '{}', 88),
(3818, 182, 'B697C838DAE91604482574C700251041', 61, 'cxshbsc', '慈溪上海办事处', NULL, NULL, NULL, '', 3, '{}', 88),
(3819, 183, '4788DDEDE347942F4825741A000ACDFE', 130, 'cxyzcxyh', '慈溪邮政储蓄银行', NULL, NULL, NULL, '', 3, '{}', 88),
(3820, 185, '0E2264ACDFF7E95848256B39000BDECC', 5, 'dainz', '市政协戴南璋', NULL, NULL, NULL, '', 3, '{}', 88),
(3821, 186, 'FA41B037D0C43E0B482572CC002AE5E5', 59, 'dhskglc', '市杜湖水库管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(3822, 187, 'EDBC141FB4D5B7C948256B3A002BDD50', 8, 'dinghf', '市委办丁洪锋', NULL, NULL, NULL, '', 3, '{}', 88),
(3823, 189, 'EA6288636BA60C3A48256FFC002F75B3', 11, 'dingkj', '市政协办丁科技', NULL, NULL, NULL, '', 3, '{}', 88),
(3824, 191, 'D3CB3A3A5C8F4A7648256E62002EC474', 77, 'dlz', '市机关事务管理局基建设备和节能管理科3', NULL, NULL, NULL, '', 3, '{}', 88),
(3825, 192, '310E1D12A9D57F4F48256E9400069FB3', 0, 'dpgsb', '党派工商办', NULL, NULL, NULL, '', 3, '{}', 88),
(3826, 193, '26606E6802166C8C4825740100072B1A', 10, 'dzzwbgs', '电子政务办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(3827, 194, '03B3F81C23089564482571D10032C5EF', 8, 'fancb', '市委办樊慈波', NULL, NULL, NULL, '', 3, '{}', 88),
(3828, 195, '3659FD055B9BA3AE48256C23002854CA', 8, 'fanfj', '市委办范峰杰', NULL, NULL, NULL, '', 3, '{}', 88),
(3829, 196, '3E132B4801E0A74B4825751A00223821', 147, 'fhzcjzz', '附海镇城建镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(3830, 197, '4F8550E480D3910D48257380000D592F', 147, 'fhzcl', '附海镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3831, 198, '3866B8D6FCFD227348256CC90010C49D', 147, 'fhzczb', '附海镇村镇办', NULL, NULL, NULL, '', 3, '{}', 88),
(3832, 199, 'AD7F9C8DC993478E48256B3800287D6A', 147, 'fhzczs', '附海镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(3833, 200, '7C5145AED5FC5DA248256CC90010B2BB', 147, 'fhzdqsj', '附海镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3834, 201, '8DCB732E823DDB5C48256CC90010A9D7', 147, 'fhzdwsj', '附海镇党委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3835, 202, '84DA8CB245BAE27A48256B3800287926', 147, 'fhzdzb', '附海镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(3836, 203, '076638AAA22E90E4482575B3002438B2', 147, 'fhzfl', '附海镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(3837, 204, 'A5FEC010ED5965AA482570520004500A', 147, 'fhzgh', '附海镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3838, 205, '352856A6E1659F144825751A00222F05', 147, 'fhzgyzz', '附海镇工业镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(3839, 206, 'C83A31355D6170DC48256CC90010B736', 147, 'fhzjfb', '附海镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(3840, 207, '7AE118E82F94F1E648256B3800287BD6', 147, 'fhzjsb', '附海镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(3841, 208, '708796F05F84AF3348256CC90010C032', 147, 'fhzjwb', '附海镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(3842, 209, '63649DD1001FFA11482572740002277B', 147, 'fhzldfw', '附海镇劳动保障管理服务所', NULL, NULL, NULL, '', 3, '{}', 88),
(3843, 210, 'ED83EAA618F7CF914825736200015AE9', 147, 'fhzmsb', '附海镇秘书办', NULL, NULL, NULL, '', 3, '{}', 88),
(3844, 211, '54ABB403E08EA5B348256D3D000B18F7', 147, 'fhzmzb', '附海镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(3845, 212, 'F4E84305A188F5AD48256CC90010BBBB', 147, 'fhznb', '附海镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(3846, 213, '20F957A9A0FDFF2D482575BB002C3708', 147, 'fhznyzz', '附海镇农业镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(3847, 214, '263A928F2EADDE9D482574900034476B', 147, 'fhzrdfzx', '附海镇人大副主席', NULL, NULL, NULL, '', 3, '{}', 88),
(3848, 215, '3AC82B54B4F8F8D24825749000343A3F', 147, 'fhzrdzx', '附海镇人大主席', NULL, NULL, NULL, '', 3, '{}', 88),
(3849, 216, 'C792B35CCE17388748256ECB002DCD1E', 147, 'fhzrdzxt', '附海镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(3850, 217, '3237512B0582367D48256CC90010E248', 147, 'fhzrwb', '附海镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(3851, 218, '983D6A63CDB8B04348256ECC002D2FFC', 147, 'fhzsfs', '附海镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(3852, 219, 'F3DD80BB76FF826E48256EF4000558BB', 147, 'fhztgs', '附海镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(3853, 220, '73AC2F3B832B03EF48256B3800287A6A', 147, 'fhztjz', '附海镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3854, 221, '53CCA0FB20310BC148256D2B0023FCDA', 147, 'fhztw', '附海镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(3855, 222, '49DF5F5727B92DB64825751A00222061', 147, 'fhzwzbz', '附海镇武装部长', NULL, NULL, NULL, '', 3, '{}', 88),
(3856, 223, '81EA696F7004CD7448256E07001E5EF5', 147, 'fhzzfsj', '附海镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3857, 224, '41C26EDA5760CCDF48256CC900118DB7', 147, 'fhzzozb', '附海镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3858, 225, 'B78184483B39EDD1482572AB0006F038', 147, 'fhzzxllw', '附海镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(3859, 226, 'B78CF3C7D927549D48256CC90010AE5F', 147, 'fhzzz', '附海镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(3860, 227, 'EA278F4D4E24FAB948256BB5000AF2A7', 147, 'fhzzzb', '附海镇党群办', NULL, NULL, NULL, '', 3, '{}', 88),
(3861, 228, '3ED4351DA345F25548256EDF00098C70', 147, 'fhzzzjj', '附海镇纪委', NULL, NULL, NULL, '', 3, '{}', 88),
(3862, 229, '934BF7083E15537248256BB50008D45C', 153, 'frb', '横河镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3863, 230, '327F7ADB705D6F3C4825749D000C24C2', 144, 'fsbsc1', '范市办事处主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3864, 231, '93A7126827ACB9944825749D000C4D03', 144, 'fsbsc10', '范市办事处农业', NULL, NULL, NULL, '', 3, '{}', 88),
(3865, 232, 'D50E02C34BE789764825749D000C2B7B', 144, 'fsbsc2', '范市办事处副主任（党务）', NULL, NULL, NULL, '', 3, '{}', 88),
(3866, 233, '109ADAAAD4E844934825749D000C301A', 144, 'fsbsc3', '范市办事处副书记（社事）', NULL, NULL, NULL, '', 3, '{}', 88),
(3867, 234, 'BD18C2A27D7286354825749D000C34AA', 144, 'fsbsc4', '范市办事处副主任（综治）', NULL, NULL, NULL, '', 3, '{}', 88),
(3868, 235, '49129FB6330CAE654825749D000C38B3', 144, 'fsbsc5', '范市办事处副主任（农业）', NULL, NULL, NULL, '', 3, '{}', 88),
(3869, 236, '6D3637D89FAD89D94825749D000C3C9E', 144, 'fsbsc6', '范市办事处劳动保障', NULL, NULL, NULL, '', 3, '{}', 88),
(3870, 237, '12FE0E58748117BF4825749D000C40C3', 144, 'fsbsc7', '范市办事处计划生育', NULL, NULL, NULL, '', 3, '{}', 88),
(3871, 238, 'F360CA9C8B56A3DC4825749D000C450C', 144, 'fsbsc8', '范市办事处民政、残联、初保', NULL, NULL, NULL, '', 3, '{}', 88),
(3872, 239, 'F5177184A03303044825749D000C48FA', 144, 'fsbsc9', '范市办事处综治、安全生产', NULL, NULL, NULL, '', 3, '{}', 88),
(3873, 240, '1EFE3B7CDBB55B5448257380000CF189', 0, 'fszcl', '范市镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3874, 244, '33C73441CB0B96794825758A00281EE6', 132, 'gdyh', '光大银行', NULL, NULL, NULL, '', 3, '{}', 88),
(3875, 245, '3C184E49E29AE83E4825748F000821AF', 56, 'ghj1', '市规划局楼树芳', NULL, NULL, NULL, '', 3, '{}', 88),
(3876, 246, 'FA45446136EFB18D4825748F00082761', 56, 'ghj2', '市规划局虞晓', NULL, NULL, NULL, '', 3, '{}', 88),
(3877, 247, 'C1186903D364B4264825748F00082BFB', 56, 'ghj3', '市规划局马百壮', NULL, NULL, NULL, '', 3, '{}', 88),
(3878, 248, '54F4B9EC859E3EC64825748F00083117', 56, 'ghj4', '市规划局胡志棠', NULL, NULL, NULL, '', 3, '{}', 88),
(3879, 249, 'E1264E331B61E8134825748F00083683', 56, 'ghj5', '市规划局张美亮', NULL, NULL, NULL, '', 3, '{}', 88),
(3880, 250, '0098ACE968D07B9F4825748F00083CA5', 56, 'ghj6', '市规划局黄光辉', NULL, NULL, NULL, '', 3, '{}', 88),
(3881, 251, '097562823CF2F8A64825748F0008415E', 56, 'ghj7', '市规划局岑士达', NULL, NULL, NULL, '', 3, '{}', 88),
(3882, 252, 'B227A7B836C4811C48257520000DFCF7', 56, 'ghj8', '市规划局毛群谊', NULL, NULL, NULL, '', 3, '{}', 88),
(3883, 253, '27BE983ADDE62E4F48256B3700274B82', 56, 'ghjbgs', '规划局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(3884, 254, '6FB0F8E2A5FC24EA4825724F00112D71', 56, 'ghjbsk', '市规划局规划编审科', NULL, NULL, NULL, '', 3, '{}', 88),
(3885, 255, '2BA10EA8B710FE3E4825724F00113CC1', 56, 'ghjczk', '市规划局村镇规划科', NULL, NULL, NULL, '', 3, '{}', 88),
(3886, 256, '052CF723151BD8754825724F001144D8', 56, 'ghjfgk', '市规划局法规监察科', NULL, NULL, NULL, '', 3, '{}', 88),
(3887, 257, '3B7278009C5AC6F94825724F00115870', 56, 'ghjgck', '市规划局工程管线科', NULL, NULL, NULL, '', 3, '{}', 88),
(3888, 258, '9DEC0BD70B4ADFF348256F0E00110CC9', 56, 'ghjxxzx', '规划局信息中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3889, 259, 'B1908564FE05ACB54825724F0011362A', 56, 'ghjydk', '市规划局用地与建筑科', NULL, NULL, NULL, '', 3, '{}', 88),
(3890, 260, '3F1AFD2A99A7523448256F1900217592', 146, 'ghwzbadd', '观海卫镇保安大队', NULL, NULL, NULL, '', 3, '{}', 88),
(3891, 261, '477F868362B67DF348257380000D3C79', 146, 'ghwzcl', '观海卫镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3892, 262, '5BB47AC590C4011848256BCF002399F3', 146, 'ghwzczjsb', '观海卫镇村镇建设办', NULL, NULL, NULL, '', 3, '{}', 88),
(3893, 263, '976A05C692A0F78448256B380028665E', 146, 'ghwzczs', '观海卫镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(3894, 264, '7027F5C5DCCAC77648256BCF00236B75', 146, 'ghwzdqsj', '观海卫镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3895, 265, 'EBD4882A2E1974E748256B380028635D', 146, 'ghwzdzb', '观海卫镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(3896, 266, 'A63A3938B06D67174825705200045CEE', 146, 'ghwzgh', '观海卫镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3897, 267, '15D2F0A9A97A342148256BCF0023865A', 146, 'ghwzgqfb', '观海卫镇工青妇办', NULL, NULL, NULL, '', 3, '{}', 88),
(3898, 268, '003105566950DDA148256BCF00238E31', 146, 'ghwzjfb', '观海卫镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(3899, 269, 'B4E5F8E0296D7E1E48256BCF00237B3B', 146, 'ghwzjjwy', '观海卫镇纪检委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3900, 270, 'FB00F30CAB9DB02348256B38002867EE', 146, 'ghwzjsb', '观海卫镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(3901, 271, 'EAA2BBD2A671F66E48256BCF0023961D', 146, 'ghwzjwb', '观海卫镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(3902, 272, '1CD3165F6C03B3974825745E00049C14', 146, 'ghwzldsh', '观海卫镇劳动和社会保障', NULL, NULL, NULL, '', 3, '{}', 88),
(3903, 273, '25004882A9ADD99048256D3D000B1465', 146, 'ghwzmzb', '观海卫镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(3904, 274, '414A61528AF7112548256BCF002391EA', 146, 'ghwznb', '观海卫镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(3905, 275, '5ABD0EACB7E0727248256BCF00237399', 146, 'ghwzrdzxt', '观海卫镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(3906, 276, '52EB922095F77E0748256BCF0023829C', 146, 'ghwzrwb', '观海卫镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(3907, 277, 'F931588DEE30283248256F1900215CDD', 146, 'ghwzsfs', '观海卫镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(3908, 278, 'E99EB9E22E08159D48256BCF00236308', 146, 'ghwzsj', '观海卫镇张炳华', NULL, NULL, NULL, '', 3, '{}', 88),
(3909, 279, 'C2130393DE3850BB48256F1900216ADB', 146, 'ghwzsjs', '观海卫镇审计所', NULL, NULL, NULL, '', 3, '{}', 88),
(3910, 280, '4E0E7005CF5CBB5C48256EF4000549D2', 146, 'ghwztgs', '观海卫镇国土资源分局', NULL, NULL, NULL, '', 3, '{}', 88),
(3911, 281, '20D825DF3A8CFE2748256B38002864EC', 146, 'ghwztjz', '观海卫镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3912, 282, 'E693EA9B355BB6CF48256D2B002BB86C', 146, 'ghwztw', '观海卫镇团委', NULL, NULL, NULL, '', 3, '{}', 88),
(3913, 283, 'CE3E5E567BC2737348256BCF00237F15', 146, 'ghwzxcwy', '观海卫镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3914, 284, 'A0580B2DE868914D48256BCF00236F7F', 146, 'ghwzzfsj', '观海卫镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3915, 285, '61768F9014CEBC8248256C2C000C4331', 146, 'ghwzzhb1', '观海卫镇文　书', NULL, NULL, NULL, '', 3, '{}', 88),
(3916, 286, '7819D670214017ED48256BCF00238A1E', 146, 'ghwzzjxb', '观海卫镇组纪宣办', NULL, NULL, NULL, '', 3, '{}', 88),
(3917, 287, '0920F5A5AE3DC08B482572AB0006DFE6', 146, 'ghwzzxllw', '观海卫镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(3918, 288, '600D2B4D7421BE6C48256BCF00236754', 146, 'ghwzzz', '观海卫镇鲁小明', NULL, NULL, NULL, '', 3, '{}', 88),
(3919, 289, 'B6296788447EE70D48256BCF00239D56', 146, 'ghwzzzb', '观海卫镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3920, 290, 'E60C203C31D37CB048256BCF0023776B', 146, 'ghwzzzwy', '观海卫镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3921, 291, 'CC899BDD271E240948257474007F51B8', 159, 'gtjd1', '古塘街道党工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3922, 292, '83548C7616ABFC6248257474007F7280', 159, 'gtjd10', '古塘街道城建主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3923, 293, '55DB23F0CB8338F448257474007F75DC', 159, 'gtjd11', '古塘街道工业主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3924, 294, 'DAB127D5B9A52C9B48257474007F7921', 159, 'gtjd12', '古塘街道人大副主任1', NULL, NULL, NULL, '', 3, '{}', 88),
(3925, 295, '848FAE524FADEDA948257474007F55F5', 159, 'gtjd2', '古塘街道办事处主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3926, 296, 'D2F390CDA8EFB72548257474007F5A36', 159, 'gtjd3', '古塘街道党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3927, 297, '20A8DFF3FB9E019548257474007F5DD6', 159, 'gtjd4', '古塘街道政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3928, 298, '3494E593192954AF48257474007F611B', 159, 'gtjd5', '古塘街道人大主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3929, 299, '2130344C696100BF48257474007F64EA', 159, 'gtjd6', '古塘街道纪工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3930, 300, '080F049EB7249B7F48257474007F6847', 159, 'gtjd7', '古塘街道文卫主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3931, 301, '5D9E8FCB7575498C48257474007F6BA7', 159, 'gtjd8', '古塘街道人武委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3932, 302, 'D7CC29717B5C9D9448257474007F6F06', 159, 'gtjd9', '古塘街道宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3933, 303, '390F155993CEA3CA482574CD00277029', 159, 'gtjdbadd', '古塘街道保安大队', NULL, NULL, NULL, '', 3, '{}', 88),
(3934, 304, '679DCF8BC6755AE8482574CD002769F3', 159, 'gtjdcgb', '古塘街道城管办', NULL, NULL, NULL, '', 3, '{}', 88),
(3935, 305, '89DECD6C3396887048257474007F7FEC', 159, 'gtjdcjb', '古塘街道城建办', NULL, NULL, NULL, '', 3, '{}', 88),
(3936, 306, 'FD2CD6C4497688984825749E00292B47', 159, 'gtjdcl', '古塘街道残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3937, 307, 'BDB84ADC9165CE7D48257474007F8A64', 159, 'gtjdczs', '古塘街道财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(3938, 308, '240DFF299E346E33482574CD00274520', 159, 'gtjdfl', '古塘街道妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(3939, 309, 'EDC831F39909A3C3482574740029BCD5', 159, 'gtjdfws', '古塘街道发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(3940, 310, 'F82ED077860BE0C948257474007F8D29', 159, 'gtjdfwzx', '古塘街道服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3941, 311, '62AE85D4DCEA6800482574CD002736B2', 159, 'gtjdgh', '古塘街道工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3942, 312, '9B203FAD9BDA5FFD482574CD00273E91', 159, 'gtjdgqt', '古塘街道共青团', NULL, NULL, NULL, '', 3, '{}', 88),
(3943, 313, 'FF09EF6B773AF26548257474007F7C8E', 159, 'gtjdjfb', '古塘街道经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(3944, 314, 'BA015C4D63A95B96482574CD00277BB6', 159, 'gtjdldbzs', '古塘街道劳动保障所', NULL, NULL, NULL, '', 3, '{}', 88),
(3945, 315, '5C0BD9FA19559CBE482574CD002762BC', 159, 'gtjdmzcl', '古塘街道民政残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3946, 316, '93BD7FD73EF4AB2C482574CD002776DB', 159, 'gtjdsfs', '古塘街道司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(3947, 317, '1374A1BB330F505448257474007F8356', 159, 'gtjdshsy', '古塘街道社会事业办（宣传）', NULL, NULL, NULL, '', 3, '{}', 88),
(3948, 318, '34F4D0C3210C35F0482574CD00275807', 159, 'gtjdtjz', '古塘街道统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3949, 319, '43C5CD9AB19BC2F0482574CD00275D55', 159, 'gtjdws', '古塘街道文书', NULL, NULL, NULL, '', 3, '{}', 88),
(3950, 320, 'C13ED18B237290C4482574CD0027529C', 159, 'gtjdxcwh', '古塘街道宣传文化', NULL, NULL, NULL, '', 3, '{}', 88),
(3951, 321, '243F84F1D61EC9D44825747400299CF9', 159, 'gtjdzhb', '古塘街道综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(3952, 322, 'A7E2F2C2DFDFD083482574CD00274AF6', 159, 'gtjdzjbgs', '古塘街道组纪办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(3953, 323, 'BB5B3679FDCCD8AC48257474007F86C4', 159, 'gtjdzzb', '古塘街道综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3954, 325, 'F1DCCBCEBA9E400748256BB5000B0A39', 52, 'gwyysyglk', '市人事局华建淼', NULL, NULL, NULL, '', 3, '{}', 88),
(3955, 326, 'D955B5BAC2CE634A48256F350001CD01', 0, 'gysyglzx', '市公用事业管理中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3956, 332, '00DA2DE0B55AA5BB48256B35003EB1F8', 10, 'heds', '市府办何登森', NULL, NULL, NULL, '', 3, '{}', 88),
(3957, 333, '30A5FB618FDC978C48256F0F000C5BAC', 153, 'hhzbmzx', '横河镇便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(3958, 334, '0CA4BA50215EF31B48257380000E1536', 153, 'hhzcl', '横河镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(3959, 335, '6B0F558F5F653E0D48256F0E0007604B', 153, 'hhzczb', '横河镇城建办', NULL, NULL, NULL, '', 3, '{}', 88),
(3960, 336, 'CC68C85DD90E40A748256B38002A3B51', 153, 'hhzczs', '横河镇财政管理办', NULL, NULL, NULL, '', 3, '{}', 88),
(3961, 337, '8B5BE79FA2B7F6CC48256D6D002CB47F', 153, 'hhzfzzg', '横河镇副镇长(工)', NULL, NULL, NULL, '', 3, '{}', 88),
(3962, 338, '60EFC88F3BE6A52948256D6D002D378D', 153, 'hhzfzzj', '横河镇副镇长(城建)', NULL, NULL, NULL, '', 3, '{}', 88),
(3963, 339, '0AC12CAF1894EBAA48256D6D002D30FF', 153, 'hhzfzzn', '横河镇副镇长(农)', NULL, NULL, NULL, '', 3, '{}', 88),
(3964, 340, '02C9E833FA55A8D648256D6D002D3470', 153, 'hhzfzzw', '横河镇副镇长(文)', NULL, NULL, NULL, '', 3, '{}', 88),
(3965, 341, 'E69F55BF4B35B8A7482570520004665C', 153, 'hhzgh', '横河镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(3966, 342, 'D6A255735D10C43148256F0E0007487D', 153, 'hhzhzb', '横河镇环卫站', NULL, NULL, NULL, '', 3, '{}', 88),
(3967, 343, '331894D98D4007F048256D780007B023', 153, 'hhzjfb', '横河镇经发办（工）', NULL, NULL, NULL, '', 3, '{}', 88),
(3968, 344, '53593A770DC318D248256D6C000C4119', 153, 'hhzjjwy', '横河镇纪检办', NULL, NULL, NULL, '', 3, '{}', 88),
(3969, 345, '91DFE9AF086F67F448256B38002A3A15', 153, 'hhzjsb', '横河镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(3970, 346, '23072A056372BA6548256D6C000C34BD', 153, 'hhzms', '横河镇秘　书', NULL, NULL, NULL, '', 3, '{}', 88),
(3971, 347, 'E02BE60B21ABE43B48256D4000040589', 153, 'hhzmzb', '横河镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(3972, 348, '3A06ABC60F9F3BA648256BBC0009F711', 153, 'hhznb', '横河镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(3973, 349, '15E23F63F6F1121548256F5C000219DE', 153, 'hhzrdb', '横河镇人大办', NULL, NULL, NULL, '', 3, '{}', 88),
(3974, 350, '9C49FC9E4A320E8048256D780007BA2F', 153, 'hhzrwbz', '横河镇人武部长', NULL, NULL, NULL, '', 3, '{}', 88),
(3975, 351, '71A918FD629CBCDB48256F0F000C6A4D', 153, 'hhzsbzx', '横河镇劳保所', NULL, NULL, NULL, '', 3, '{}', 88),
(3976, 352, '2B1A24CFDCB37EE048256D6C000C38FB', 153, 'hhzsfs', '横河镇党政办（收发）', NULL, NULL, NULL, '', 3, '{}', 88),
(3977, 353, 'A21981EA597857BF48256ECC002743C0', 153, 'hhzsifs', '横河镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(3978, 354, 'FE96052E4E4A66E648256BBC0009DC74', 153, 'hhzsj', '横河镇书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3979, 355, '3447533435B5BDBE48256D780007BE25', 153, 'hhztgs', '横河镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(3980, 356, 'C45661B713ACDFE948256B38002A3C92', 153, 'hhztjz', '横河镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(3981, 357, '4BC6B389F951409448256D2B002A1B43', 153, 'hhztw', '横河镇妇　团', NULL, NULL, NULL, '', 3, '{}', 88),
(3982, 358, '6098B3E856F097CA482574E8002238F7', 153, 'hhzwhz', '横河镇文化站', NULL, NULL, NULL, '', 3, '{}', 88),
(3983, 359, '242944B913F3128E482575D900028665', 153, 'hhzwsx1', '横河镇爱卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(3984, 360, 'F1FEC1025415969648256BBC0009EF88', 153, 'hhzxcb', '横河镇宣传办', NULL, NULL, NULL, '', 3, '{}', 88),
(3985, 361, '064BF3D6F0FA131648256D6C000C4511', 153, 'hhzxcwy', '横河镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3986, 362, 'F205196F28CCC8CB48256BBC0009E49B', 153, 'hhzzfsj', '横河镇政法委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3987, 363, 'DD2589AD1207AAFA48256D780007FFBB', 153, 'hhzzhzlb', '横河镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(3988, 364, 'A4CAC36382E9A964482572AB00073D00', 153, 'hhzzxllw', '横河镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(3989, 365, '73661C572601709448256BBC0009E0C4', 153, 'hhzzz', '横河镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(3990, 366, '5C3D1FEB7729C3A048256BBC0009E853', 153, 'hhzzzb', '横河镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(3991, 367, '0A118FDE6B47990B48256D6C000C3D23', 153, 'hhzzzwy', '横河镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(3992, 368, 'FC7DC934A14309F848256F2A00286F4B', 102, 'hjxsz', '环境消杀组', NULL, NULL, NULL, '', 3, '{}', 88),
(3993, 369, '57E114869E5D2B50482574780030B0A9', 160, 'hsjd1', '浒山街道党工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(3994, 370, '556181856A7B28184825747800805E84', 160, 'hsjd10', '浒山街道城建主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3995, 371, 'F504C9ACB0968ACD4825747800806222', 160, 'hsjd11', '浒山街道人大副主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3996, 372, 'A4383678557A2B8A482574780080661A', 160, 'hsjd12', '浒山街道调研员1', NULL, NULL, NULL, '', 3, '{}', 88),
(3997, 373, '8675CA54CB09198B482574780080699E', 160, 'hsjd13', '浒山街道政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(3998, 374, 'F38753982201F358482574780030B83C', 160, 'hsjd2', '浒山街道办事处主任', NULL, NULL, NULL, '', 3, '{}', 88),
(3999, 375, '064604EEF680FEC0482574780030BD3A', 160, 'hsjd3', '浒山街道党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4000, 376, '582CA59E90342683482574780030C3EC', 160, 'hsjd4', '浒山街道政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4001, 377, 'E337F4C4F5468DFF482574780030CCB3', 160, 'hsjd5', '浒山街道人大主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4002, 378, 'E7042CCA21A70FCB4825747800804F9F', 160, 'hsjd6', '浒山街道组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(4003, 379, '59DF1243D4F453874825747800805371', 160, 'hsjd7', '浒山街道宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(4004, 380, '406B6F8FCA6CA8A8482574780080572E', 160, 'hsjd8', '浒山街道人武委员', NULL, NULL, NULL, '', 3, '{}', 88),
(4005, 381, '8EB0335D34A435E74825747800805A84', 160, 'hsjd9', '浒山街道工业（三产）主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4006, 382, '5BD04DF646B6A3774825749E0028F14B', 160, 'hsjdcl', '浒山街道残联', NULL, NULL, NULL, '', 3, '{}', 88),
(4007, 383, '985A8E993773D19D4825747800806DCE', 160, 'hsjdcqb', '浒山街道城区改造办', NULL, NULL, NULL, '', 3, '{}', 88),
(4008, 384, '88B4F0D485F7AFBC4825747800807152', 160, 'hsjdcsb', '浒山街道城市管理办', NULL, NULL, NULL, '', 3, '{}', 88),
(4009, 385, 'B39CD3E2A61FE08148256B38002AD3BE', 160, 'hsjdczs', '浒山街道财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(4010, 386, '04BF677B245FEC2848256D3C0011092F', 160, 'hsjddzb', '浒山街道综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(4011, 387, 'A0C4FA85A8036F264825747800807C5E', 160, 'hsjdfl', '浒山街道妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(4012, 388, 'E06AAA9758370E0948257478008078DD', 160, 'hsjdfws', '浒山街道发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4013, 389, '2E5CC880D0E493554825705200046F41', 160, 'hsjdgh', '浒山街道工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4014, 390, 'CB2DAB79D2598EF748256C23002B2A2E', 160, 'hsjdjfb', '浒山街道经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(4015, 391, '9731FC7873F9593E4825747800807545', 160, 'hsjdshb', '浒山街道社会事业办', NULL, NULL, NULL, '', 3, '{}', 88),
(4016, 392, '2BEDF5267A4FA33F48256D2B002A3576', 160, 'hsjdtw', '浒山街道团委', NULL, NULL, NULL, '', 3, '{}', 88),
(4017, 393, '65E0F97C8C72D11C48256C2300301374', 160, 'hsjdzzb', '浒山街道综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(4018, 394, '29DD5D8A1C39010648256DA5002C0C4C', 2, 'huah', '市委宣传部华　红', NULL, NULL, NULL, '', 3, '{}', 88),
(4019, 402, '6A59DC7E20512EA948256E700004E60A', 10, 'hulz', '市府办胡黎洲', NULL, NULL, NULL, '', 3, '{}', 88),
(4020, 403, '343B780FA223206548256B35003F11DF', 10, 'humb', '市府办04', NULL, NULL, NULL, '', 3, '{}', 88),
(4021, 404, '68B2D5710B04DA3748256B3A002BF360', 8, 'husf', '市委办胡淑芳', NULL, NULL, NULL, '', 3, '{}', 88),
(4022, 407, 'EB8C42262F37440848257220000A31F0', 10, 'huxd', '市府办胡旭东', NULL, NULL, NULL, '', 3, '{}', 88),
(4023, 413, '78B41C8E0CF95A2748256E62002EC02B', 77, 'jgst', '市机关后勤服务中心（机关公务用车服务中心）', NULL, NULL, NULL, '', 3, '{}', 88),
(4024, 416, '971AAECE5288E93C482570CF0022BDD9', 65, 'jjfj1', '市审计局龚利君', NULL, NULL, NULL, '', 3, '{}', 88),
(4025, 417, '7E9F82FE2AF0CC5B482570CF0022E722', 65, 'jjfjjsaz', '基建分局建筑安装', NULL, NULL, NULL, '', 3, '{}', 88),
(4026, 418, '9C96049EABA95CC5482570CF0022F80B', 65, 'jjfjjtsl', '基建分局市政交通', NULL, NULL, NULL, '', 3, '{}', 88),
(4027, 420, '59927DEED1C447CD48256BC700041685', 63, 'jsxh', '计生协会', NULL, NULL, NULL, '', 3, '{}', 88),
(4028, 421, 'A8D89B04126CC63248256ED800088496', 63, 'jszdz', '市计生指导站', NULL, NULL, NULL, '', 3, '{}', 88),
(4029, 422, '1FB1612F774367674825736F002D10F4', 119, 'jtyhxczh', '交通银行新城支行', NULL, NULL, NULL, '', 3, '{}', 88),
(4030, 423, '6ED067705805117248256BB5000D0C14', 163, 'kdjdcjb', '坎墩街道城建办', NULL, NULL, NULL, '', 3, '{}', 88),
(4031, 424, '9102B914A2327DC148257380000EF860', 163, 'kdjdcl', '坎墩街道残联', NULL, NULL, NULL, '', 3, '{}', 88),
(4032, 425, 'CAB09B848A44F7C948256B38002AFE24', 163, 'kdjdczs', '坎墩街道财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(4033, 426, 'A219BC574FC16C0A48256BB5000D03D9', 163, 'kdjddqsj', '坎墩街道党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4034, 427, '2A513F4A9BF4B5D848256B38002AFB5D', 163, 'kdjddzb', '坎墩街道综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(4035, 428, '673941E0D8A2051448256D6D00302E2C', 163, 'kdjdfzrg', '坎墩街道副主任（工）', NULL, NULL, NULL, '', 3, '{}', 88),
(4036, 429, 'F4B055972C52879348256D6D0032024E', 163, 'kdjdfzrj', '坎墩街道副主任（建）', NULL, NULL, NULL, '', 3, '{}', 88),
(4037, 430, 'D62851C4A473092948256D6D0031FAC5', 163, 'kdjdfzrn', '坎墩街道副主任（农）', NULL, NULL, NULL, '', 3, '{}', 88),
(4038, 431, '9CF16C7551D91D5648256D6D0031FE7F', 163, 'kdjdfzrw', '坎墩街道副主任（文）', NULL, NULL, NULL, '', 3, '{}', 88),
(4039, 432, 'EBEFF6F3E53C6A4E48257052000477EE', 163, 'kdjdgh', '坎墩街道工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4040, 433, '613D29ED02E4088B4825704900078C15', 163, 'kdjdjfb', '坎墩街道经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(4041, 434, 'B8634F1361511F6648256BB8002A8568', 163, 'kdjdjsb', '坎墩街道计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(4042, 435, '74C67FF88446A76148256D4000042742', 163, 'kdjdmzb', '坎墩街道民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(4043, 436, 'AE49F2FE7C68868248257142000EC640', 163, 'kdjdrdgw', '坎墩街道人大工委', NULL, NULL, NULL, '', 3, '{}', 88),
(4044, 437, 'BFB231E82668B72248256D6D003031BE', 163, 'kdjdsfs', '坎墩街道收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(4045, 438, 'EB005229A6836B6148256BB5000CFAF0', 163, 'kdjdsj', '坎墩街道书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4046, 439, 'F04C4771C3729D7F48256EF40006A1E8', 163, 'kdjdtgs', '坎墩街道国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(4047, 440, 'A3F37AA9C3406DFF48256B38002AFFCF', 163, 'kdjdtjz', '坎墩街道统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(4048, 441, '07437E615E78389248256D2B002A3E15', 163, 'kdjdtw', '坎墩街道团委', NULL, NULL, NULL, '', 3, '{}', 88),
(4049, 442, '12F8567F0EB6814248256D6D00302AD5', 163, 'kdjdwyw', '坎墩街道委员（武）', NULL, NULL, NULL, '', 3, '{}', 88),
(4050, 443, '5E9340A3373910E148256D6D0031F6E8', 163, 'kdjdwyx', '坎墩街道委员（宣）', NULL, NULL, NULL, '', 3, '{}', 88),
(4051, 444, 'EFE25EB933A34EC448256D6D0030271B', 163, 'kdjdwyz', '坎墩街道委员（组）', NULL, NULL, NULL, '', 3, '{}', 88),
(4052, 445, 'BDA8E1A583F3E15348256BB5000D100E', 163, 'kdjdwzb', '坎墩街道武装部', NULL, NULL, NULL, '', 3, '{}', 88),
(4053, 446, '8AE7E38E6867A9CA48256BB5000D082B', 163, 'kdjdzfsj', '坎墩街道政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4054, 447, 'C0699D91058684EA48256BB5000CFFDF', 163, 'kdjdzr', '坎墩街道主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4055, 448, '81F7112A469BA25C482572AB00079B34', 163, 'kdjdzxllw', '坎墩街道政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(4056, 449, 'D4A93351AAEFF79C48256BB5000D1455', 163, 'kdjdzzb', '坎墩街道综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(4057, 450, '4EC9E3A0B3080F6B48257266002E841E', 163, 'kdldfl', '坎墩街道妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(4058, 451, 'FB34F8B9EC46B18D48257266002E8F0E', 163, 'kdldldfw', '坎墩街道劳动管理服务所', NULL, NULL, NULL, '', 3, '{}', 88),
(4059, 452, '64322A461D13D8D448256E5A000E648F', 6, 'kfqczj', '开发区财政局', NULL, NULL, NULL, '', 3, '{}', 88),
(4060, 453, 'A91A9E46953F58964825717E000321CB', 6, 'kfqgtzyj', '国土资源局', NULL, NULL, NULL, '', 3, '{}', 88),
(4061, 454, '0689E64B3C411E404825717E00033042', 6, 'kfqjjsjj', '纪检审计局', NULL, NULL, NULL, '', 3, '{}', 88),
(4062, 455, 'BC97E304B5F6347D4825717E00086896', 6, 'kfqrsldsbj', '人事劳动社会保障局', NULL, NULL, NULL, '', 3, '{}', 88),
(4063, 456, '5A95A079E27AF22C48256BB8002004BE', 152, 'kyzcjb', '匡堰镇城建办', NULL, NULL, NULL, '', 3, '{}', 88),
(4064, 457, '955E7462D7D7EA4C48257380000DEFB2', 152, 'kyzcl', '匡堰镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(4065, 458, '3D241AB194454DD148256B38002A27E9', 152, 'kyzczs', '匡堰镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(4066, 459, 'D67A8739646CE31248256BB8001FF94D', 152, 'kyzdqsj', '匡堰镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4067, 460, '965E7A3FE42E9E8748256B38002A259A', 152, 'kyzdzb', '匡堰镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(4068, 461, '8CE27A5893AB3B1148256CB4002AA160', 152, 'kyzfl', '匡堰镇人事干部、妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(4069, 462, '3174203E0ADC54C848256DC20004B422', 152, 'kyzfzzg', '匡堰镇副镇长（工）', NULL, NULL, NULL, '', 3, '{}', 88),
(4070, 463, '935A85366813957848256DC20004BD09', 152, 'kyzfzzj', '匡堰镇副镇长（建）', NULL, NULL, NULL, '', 3, '{}', 88),
(4071, 464, '8BD6332C8AE0A89548256DC20004B8C4', 152, 'kyzfzzn', '匡堰镇副镇长（农）', NULL, NULL, NULL, '', 3, '{}', 88),
(4072, 465, 'AAEF950EADCD95A648256DC20004AFC0', 152, 'kyzfzzw', '匡堰镇副镇长（文）', NULL, NULL, NULL, '', 3, '{}', 88),
(4073, 466, 'F529BD691E737E9948256BB800200103', 152, 'kyzgb', '匡堰镇工办', NULL, NULL, NULL, '', 3, '{}', 88),
(4074, 467, '18BF7CB20192979F482570520004809E', 152, 'kyzgh', '匡堰镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4075, 468, 'FAD501B079D9E8C848256B38002A26C1', 152, 'kyzjsb', '匡堰镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(4076, 469, '531B8049EBEBE59948256DC20004C15A', 152, 'kyzjwb', '匡堰镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(4077, 470, 'B141D61BB55B0BEF48256CB4002A9CFA', 152, 'kyzmzb', '匡堰镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(4078, 471, 'C8FC3B0729D1E47548256BB800200D1F', 152, 'kyznb', '匡堰镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(4079, 472, '7173509BBBF6D6E148256CB4002A8B5E', 152, 'kyzrdzxt', '匡堰镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(4080, 473, 'F04FC6E06C00939348256DC20004C5B4', 152, 'kyzsbzx', '匡堰镇社保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4081, 474, '49FEFAB86BB822B848256CB4002AAE66', 152, 'kyzscb', '匡堰镇三产办', NULL, NULL, NULL, '', 3, '{}', 88),
(4082, 475, '9484AD7765091BAF48256DC20004CECB', 152, 'kyzsfc', '匡堰镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(4083, 476, '02D20344269C0FD4482570C40003D5B1', 152, 'kyzshsyb', '匡堰镇社会事业办', NULL, NULL, NULL, '', 3, '{}', 88),
(4084, 477, '2501BE8DD4760DF948256BB8001FF193', 152, 'kyzsj', '匡堰镇书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4085, 478, '39B65EFD78AB0AC948256CB4002AA9E0', 152, 'kyztgs', '匡堰镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(4086, 479, 'D02621B4301AC1BB48256B38002A2922', 152, 'kyztjz', '匡堰镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(4087, 480, '4852C26B99086CCE48256CB4002AA597', 152, 'kyztw', '匡堰镇团委纪检干事', NULL, NULL, NULL, '', 3, '{}', 88),
(4088, 481, 'C5102403633D29D748256DC20004CA40', 152, 'kyzwhxcb', '匡堰镇文化宣传办', NULL, NULL, NULL, '', 3, '{}', 88),
(4089, 482, '7BEA6B7DCA90B41A48256DC20004D35D', 152, 'kyzws', '匡堰镇文书档案', NULL, NULL, NULL, '', 3, '{}', 88),
(4090, 483, '9A4C870F6479421748256CB4002AB325', 152, 'kyzwzb', '匡堰镇武装部', NULL, NULL, NULL, '', 3, '{}', 88),
(4091, 484, '8883D0903D0BE78748256DFA00017558', 152, 'kyzzfsj', '匡堰镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4092, 485, '287DCF00742BD2AD48256DC20004AB7D', 152, 'kyzzjwy', '匡堰镇组纪委员', NULL, NULL, NULL, '', 3, '{}', 88),
(4093, 486, 'D6EE223C1C1A86A348256BB8001FFCC4', 152, 'kyzzuzb', '匡堰镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(4094, 487, '3F9C23AA64EA6784482572AB00073111', 152, 'kyzzxllw', '匡堰镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(4095, 488, '867CB56D51AC62CF48256BB8001FF552', 152, 'kyzzz', '匡堰镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(4096, 489, '045A93E574DE889D48256BB8002008F4', 152, 'kyzzzb', '匡堰镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(4097, 490, 'A71363B565B91C2648256B38004262EF', 51, 'ligs', '市财政地税局厉国胜', NULL, NULL, NULL, '', 3, '{}', 88),
(4098, 491, '276A665077FB253B4825717E00025612', 6, 'linlt', '开发区林利挺', NULL, NULL, NULL, '', 3, '{}', 88),
(4099, 493, '6EFE60EC71D22B864825717E0002AF68', 6, 'liym', '开发区李毓敏', NULL, NULL, NULL, '', 3, '{}', 88),
(4100, 494, 'B5466D0AED4922EA48256B3900084C08', 10, 'loujh', '市府办楼建航', NULL, NULL, NULL, '', 3, '{}', 88),
(4101, 495, '1D982F2D589A6E12482573B70029DA03', 76, 'lpzxywk', '市行政服务中心业务科', NULL, NULL, NULL, '', 3, '{}', 88),
(4102, 496, 'E39C9BBB52F46392482573B70029A705', 76, 'lpzxzrs1', '市行政服务中心宓国聪', NULL, NULL, NULL, '', 3, '{}', 88),
(4103, 497, '6D8E20694B886327482573B70029B81D', 76, 'lpzxzrs2', '市行政服务中心王挺飞', NULL, NULL, NULL, '', 3, '{}', 88),
(4104, 498, 'DEDB1091961A4CC3482573B70029C84B', 76, 'lpzxzrs3', '市行政服务中心张晶晶', NULL, NULL, NULL, '', 3, '{}', 88),
(4105, 499, 'BF57E5D6E0B541F84825749D000C5136', 144, 'lsbsc1', '龙山办事处主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4106, 500, '2D0697153DFF5D5C4825749D000C5529', 144, 'lsbsc2', '龙山办事处综合', NULL, NULL, NULL, '', 3, '{}', 88),
(4107, 501, '2DADA3269DA4D4D64825749D000C5916', 144, 'lsbsc3', '龙山办事处综治', NULL, NULL, NULL, '', 3, '{}', 88),
(4108, 502, '4FB08967134A49C64825749D000C5CA3', 144, 'lsbsc4', '龙山办事处社会事业', NULL, NULL, NULL, '', 3, '{}', 88),
(4109, 503, '6E782668221760F74825749D000C6056', 144, 'lsbsc5', '龙山办事处劳动保障', NULL, NULL, NULL, '', 3, '{}', 88),
(4110, 504, '3AF8D33EA720CC184825749D000C647B', 144, 'lsbsc6', '龙山办事处计生', NULL, NULL, NULL, '', 3, '{}', 88),
(4111, 505, '7C6B447BDFD883254825749D000C6858', 144, 'lsbsc7', '龙山办事处民政', NULL, NULL, NULL, '', 3, '{}', 88),
(4112, 514, '2D65B3EFA7A35EEA4825749D000B5CB1', 144, 'lsz1', '龙山镇邹柏涌', NULL, NULL, NULL, '', 3, '{}', 88),
(4113, 515, '237D945C6AE0DC794825749D000BE6CD', 144, 'lsz10', '龙山镇城建副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(4114, 516, '50C1B4A4A1A7ADEA4825749D000BF84C', 144, 'lsz11', '龙山镇综合办主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4115, 517, 'C143DC4E3B60A40A4825749D000C01DC', 144, 'lsz12', '龙山镇工业副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(4116, 518, 'A0AF423C0739C4664825749D000C06CB', 144, 'lsz13', '龙山镇农业副镇长', NULL, NULL, NULL, '', 3, '{}', 88);
INSERT INTO `staff_tbl` (`staff_id`, `out_id`, `staff_unid`, `unit`, `staff_name`, `full_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`, `user_admin`, `reorder`) VALUES
(4117, 519, 'ECDDCB1B4D8A65234825749D000B6A0C', 144, 'lsz2', '龙山镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(4118, 520, 'DE9C30728CF8E2954825749D000B7456', 144, 'lsz3', '龙山镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(4119, 521, '2046315EA70915744825749D000B7F05', 144, 'lsz4', '龙山镇党群副书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4120, 522, 'BFDFEC8037F92A4B4825749D000B881D', 144, 'lsz5', '龙山镇人大主席', NULL, NULL, NULL, '', 3, '{}', 88),
(4121, 523, '05EE33A1E9C71C884825749D000B91D9', 144, 'lsz6', '龙山镇纪检副书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4122, 524, 'FA4D97CB5E370F454825749D000BA02F', 144, 'lsz7', '龙山镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(4123, 525, '2EEF15FA9CDBF3544825749D000BB6B2', 144, 'lsz8', '龙山镇文卫副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(4124, 526, 'B90F0399B458DD324825749D000BCDC7', 144, 'lsz9', '龙山镇武装部长', NULL, NULL, NULL, '', 3, '{}', 88),
(4125, 527, '34BA4A18A3D5FA0B4825749D000C15C8', 144, 'lszcjb', '龙山镇城建办', NULL, NULL, NULL, '', 3, '{}', 88),
(4126, 528, '5E9A165F96DCE0B848257380000CB714', 144, 'lszcl', '龙山镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(4127, 529, '67EDB34D9238C0D148256B380027F305', 144, 'lszczs', '龙山镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(4128, 530, '13BAFA3D4399FC4948256CFE00083E3F', 144, 'lszdqb', '龙山镇党群办', NULL, NULL, NULL, '', 3, '{}', 88),
(4129, 531, '6177ED680BC0E39248256B380027F03A', 144, 'lszdzb', '龙山镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(4130, 532, '98E4CA35A6E687684825749D000C1963', 144, 'lszfl', '龙山镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(4131, 533, 'EFBFE3856F6B737A4825749D000C0E91', 144, 'lszgb', '龙山镇工办', NULL, NULL, NULL, '', 3, '{}', 88),
(4132, 534, 'FAC220629CFB7B1D4825705200048A65', 144, 'lszgh', '龙山镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4133, 535, '6C40EAE4EA71B9A148257591000EAAAF', 144, 'lszgtzysxf', '龙山镇国土资源所信访办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4134, 536, '78BD622852C74CBC48256B380027F1A4', 144, 'lszjsb', '龙山镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(4135, 537, 'AB980C9E15D64F71482573410033533B', 144, 'lszldbzs', '龙山镇劳动保障所', NULL, NULL, NULL, '', 3, '{}', 88),
(4136, 538, '044FF3A155F0238B4825749D000C0AFC', 144, 'lszms', '龙山镇秘书', NULL, NULL, NULL, '', 3, '{}', 88),
(4137, 539, 'A4BF249FEBDB791F48256D3D000B0366', 144, 'lszmzb', '龙山镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(4138, 540, '6A9D1159C6FD4E0748256CFE000846A6', 144, 'lsznb', '龙山镇农　办', NULL, NULL, NULL, '', 3, '{}', 88),
(4139, 541, '5CC52F718B8DCC8348256CFE000857A4', 144, 'lszrwb', '龙山镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(4140, 542, '7E04027026CC05B748256EE70004AAC0', 144, 'lszsfs', '龙山镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(4141, 543, 'CECE5081B2E76B1B4825749D000C121F', 144, 'lszssb', '龙山镇社事办', NULL, NULL, NULL, '', 3, '{}', 88),
(4142, 544, '674F45B3BD294A6848257591000EB006', 144, 'lszssbws', '龙山镇社事办卫生监督所', NULL, NULL, NULL, '', 3, '{}', 88),
(4143, 545, 'F1A8A5D1CD933A1248256EF40004B1BA', 144, 'lsztgs', '龙山镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(4144, 546, '434D99B398D6CEB948256B380027ED6B', 144, 'lsztjz', '龙山镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(4145, 547, 'F898B1448514457748256D2B000C048B', 144, 'lsztw', '龙山镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(4146, 548, '1BA6C9384ABF62BA4825749D000C1E87', 144, 'lszxw', '龙山镇新闻信息专报', NULL, NULL, NULL, '', 3, '{}', 88),
(4147, 549, '2028230189D24F14482572AB0006B883', 144, 'lszzxllw', '龙山镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(4148, 550, 'B9952117E968C3D248256CFE00085316', 144, 'lszzzb', '龙山镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(4149, 551, '1CC321AE7CE7A64648256EF3002825B7', 111, 'ltcxfgs', '联通慈溪分公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4150, 552, '9AD819C507EFC3B148256E7700024A0D', 9, 'luj', '城环工委陆　军', NULL, NULL, NULL, '', 3, '{}', 88),
(4151, 553, '9A56E49EDE4B2AB6482570EC001DF8F4', 6, 'lujianz', '开发区卢建中', NULL, NULL, NULL, '', 3, '{}', 88),
(4152, 554, 'BE2CD507FB317FDF48256D1E002AAB14', 9, 'luochen', '市人大办罗　陈', NULL, NULL, NULL, '', 3, '{}', 88),
(4153, 555, '16B1B6472486C4AB4825734B0009BFF5', 10, 'luogf', '市府办罗高峰', NULL, NULL, NULL, '', 3, '{}', 88),
(4154, 556, '3FEB5188EB28E4AF48256C23002BCD03', 8, 'luoj', '市委办08', NULL, NULL, NULL, '', 3, '{}', 88),
(4155, 558, '449FCFE4464D148348256EEB000AD9B3', 11, 'luys', '市政协办陆云苏', NULL, NULL, NULL, '', 3, '{}', 88),
(4156, 559, '1C7AA9C96F9720CA482573E0002883B4', 74, 'lyjdyys1', '市旅游局胡能良', NULL, NULL, NULL, '', 3, '{}', 88),
(4157, 560, '577999C51CB0B54E48256CE5002D145D', 74, 'lyjghjsk', '市旅游局规划建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(4158, 561, '1D1035AA1E5F37DE48256CE5002D35D9', 74, 'lyjhyglk', '市旅游局行业管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4159, 562, '93982E50DBB4A49C48256CE5002D3A28', 74, 'lyjsfs', '市旅游局收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(4160, 563, '1DE0479E0138211A48256B35003EF6E1', 10, 'maomj', '市府办05', NULL, NULL, NULL, '', 3, '{}', 88),
(4161, 566, '4FBC4DB1E62B416C482572CC002AFB0A', 59, 'mhskglc', '市梅湖水库管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(4162, 567, 'BA88B8EEC23E4D99482573D0002DC401', 6, 'miyb', '开发区宓永波', NULL, NULL, NULL, '', 3, '{}', 88),
(4163, 568, 'C0A36FA4F0C1C4FD48256B3A002BEBA3', 8, 'mozh', '市委办10', NULL, NULL, NULL, '', 3, '{}', 88),
(4164, 570, '2B80F1656D7025F748256E6D002B0E4C', 22, 'ncgzbgs', '农村工作指导员办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4165, 571, '48214DC81BDF812E4825717E00020D1C', 6, 'panyt', '开发区潘岳钿', NULL, NULL, NULL, '', 3, '{}', 88),
(4166, 572, '0DE54B7E752B566248256C2300179106', 123, 'pfhzhbgs', '浦发行支行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4167, 573, 'ACFDDB27FECDF90D48256BB5000B199A', 52, 'pxzx', '培训中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4168, 577, 'CFB83805672A6FA248256B3900083AF0', 10, 'qiuzh', '市府办裘振华', NULL, NULL, NULL, '', 3, '{}', 88),
(4169, 579, '7D03CD9F97BC995448257380000DD97B', 151, 'qtzcl', '桥头镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(4170, 580, '1C9B3C8417B7106348256D41000AF76A', 151, 'qtzczb', '桥头镇村镇办', NULL, NULL, NULL, '', 3, '{}', 88),
(4171, 581, '8EE6D304CB6AA70748256B38002A0FBA', 151, 'qtzczs', '桥头镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(4172, 582, 'B6936877CBCB2AA648256D41000AD27C', 151, 'qtzdqsj', '桥头镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4173, 583, 'D327C350CC9081B548256B38002A0D74', 151, 'qtzdzb', '桥头镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(4174, 584, 'EA0985244174E31D48256EBC0006C8E6', 151, 'qtzfl', '桥头镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(4175, 585, 'C121690550AE3032482570520004923E', 151, 'qtzgh', '桥头镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4176, 586, 'B85C78BF79E9027048256D41000AE935', 151, 'qtzjfb', '桥头镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(4177, 587, '2016B4E465F518A648256B38002A0E9E', 151, 'qtzjsb', '桥头镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(4178, 588, 'CB4E38C8C42C77C648256D41000AF23A', 151, 'qtzjwb', '桥头镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(4179, 589, '75AA56D9579BE73A48256D400003EF0D', 151, 'qtzmzb', '桥头镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(4180, 590, '1371EA54E6409B2A48256D41000AEE0E', 151, 'qtznb', '桥头镇农　办', NULL, NULL, NULL, '', 3, '{}', 88),
(4181, 591, 'F5F8263CAF4860CF48256D41000ADC59', 151, 'qtzrdzxt', '桥头镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(4182, 592, '85BEFBBA75BF6B4248256D41000AE36D', 151, 'qtzrwb', '桥头镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(4183, 593, '08B9C301CF0DEA3048256E54002EBA76', 151, 'qtzsbzx', '桥头镇社保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4184, 594, 'D9C1CFB000F6A3E648256EBC0006B7B9', 151, 'qtzsfs', '桥头镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(4185, 595, '4A2E4A726F593BDC48256D41000AC96A', 151, 'qtzsj', '桥头镇书　记', NULL, NULL, NULL, '', 3, '{}', 88),
(4186, 596, '2E01F4FEB724E80348256EF40005A873', 151, 'qtztgs', '桥头镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(4187, 597, '8069180F4DD77CAD48256B38002A10E9', 151, 'qtztjz', '桥头镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(4188, 598, 'CDF0B163F4EF99AE48256D2B002A07F8', 151, 'qtztw', '桥头镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(4189, 599, '5FD62920BA87C76248256EBC00069FD2', 151, 'qtzwxb', '桥头镇文宣办', NULL, NULL, NULL, '', 3, '{}', 88),
(4190, 600, 'DB84B94062B4ECB048256D41000AFC75', 151, 'qtzwys', '桥头镇文印室', NULL, NULL, NULL, '', 3, '{}', 88),
(4191, 601, '3D968E51039C6F2A48256D41000AD74E', 151, 'qtzzfsj', '桥头镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4192, 602, 'E8BD2AE948CFBFE6482572AB000725FC', 151, 'qtzzxllw', '桥头镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(4193, 603, '927CF3A5A9E6DE6C48256D41000ACE46', 151, 'qtzzz', '桥头镇镇　长', NULL, NULL, NULL, '', 3, '{}', 88),
(4194, 605, '3BAE0CAB210B48E9482573CA0010C947', 151, 'qtzzzwy', '桥头镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(4195, 606, 'B916CAE395C79A6A48256BB5000B15AC', 52, 'rcfwzx', '人才服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4196, 608, 'BD7575DB1DB8E2CB48256C670028328F', 10, 'ruanf', '市府办阮　峰', NULL, NULL, NULL, '', 3, '{}', 88),
(4197, 609, 'DB9FFA0C36D5D6DF48256D09000B482D', 42, 'sab', '市安办', NULL, NULL, NULL, '', 3, '{}', 88),
(4198, 610, '6ADB38258612E54B4825703F00256D8D', 42, 'sajj1', '市安监局马清', NULL, NULL, NULL, '', 3, '{}', 88),
(4199, 611, '5D26DC8193F60B724825703F00257701', 42, 'sajj2', '市安监局房建法', NULL, NULL, NULL, '', 3, '{}', 88),
(4200, 612, '85B89080504F51994825703F00257F38', 42, 'sajj3', '市安监局杨进', NULL, NULL, NULL, '', 3, '{}', 88),
(4201, 613, 'DC5BC170DEBB62FF4825703F00258771', 42, 'sajj4', '市安监局范鹏华', NULL, NULL, NULL, '', 3, '{}', 88),
(4202, 614, 'C69612511397BC874825703F00258F25', 42, 'sajj5', '市安监局李明华', NULL, NULL, NULL, '', 3, '{}', 88),
(4203, 615, '0DE57AB4EFE722EE4825714500242CDF', 42, 'sajj6', '市安监局林建华', NULL, NULL, NULL, '', 3, '{}', 88),
(4204, 616, 'F3F640D206CEFD0C4825714500243A7E', 42, 'sajj7', '市安监局李建赞', NULL, NULL, NULL, '', 3, '{}', 88),
(4205, 617, '201EF645F9F96F4F482571B700105EEF', 42, 'sajj8', '市安监局倪国威', NULL, NULL, NULL, '', 3, '{}', 88),
(4206, 618, '67F5D4D6E23BDED8482571B700106B38', 42, 'sajj9', '市安监局华士成', NULL, NULL, NULL, '', 3, '{}', 88),
(4207, 619, '09B49E43BDA3A01648256F6B002618C1', 42, 'sajjbgs', '市安监局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4208, 620, 'FE4CC73B60E576A34825703F0025E48D', 42, 'sajjgkwhk', '市安监局矿山危化科', NULL, NULL, NULL, '', 3, '{}', 88),
(4209, 621, 'FD23D3F82534A9EE4825703F0025D2EE', 42, 'sajjzcfgk', '市安监局政策法规科', NULL, NULL, NULL, '', 3, '{}', 88),
(4210, 622, '7AA4B2A5D25D4A384825703F0025DABF', 42, 'sajjzhk', '市安监局综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4211, 623, '243D0BD999BC5D34482572CC002B050B', 59, 'saskglc', '市邵岙水库管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(4212, 625, '0A01CD205C7077C64825720D002FBE24', 0, 'sawb2', '市爱卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(4213, 626, '4C0D9E85593EEFB948256BB5000B065D', 52, 'sbb', '市人事局范张焕', NULL, NULL, NULL, '', 3, '{}', 88),
(4214, 627, '36A1213AE1C797EC4825749D000C6BFB', 144, 'sbbsc1', '三北办事处主任（方伦聪）', NULL, NULL, NULL, '', 3, '{}', 88),
(4215, 628, '7436D84437D971C24825749D000C7004', 144, 'sbbsc2', '三北办事处党务综合线', NULL, NULL, NULL, '', 3, '{}', 88),
(4216, 629, '405AC8558637692B4825749D000C7400', 144, 'sbbsc3', '三北办事处社会事业线', NULL, NULL, NULL, '', 3, '{}', 88),
(4217, 630, '1E91E8B3181814574825749D000C7897', 144, 'sbbsc4', '三北办事处综治安全线', NULL, NULL, NULL, '', 3, '{}', 88),
(4218, 631, '2DCF683E2F47CB944825749D000C7DBD', 144, 'sbbsc5', '政协联络委主任（黄岳大）', NULL, NULL, NULL, '', 3, '{}', 88),
(4219, 632, '1301F2FAB4AA9D7F482574B400056AB3', 144, 'sbbsc6', '三北办事处计划生育', NULL, NULL, NULL, '', 3, '{}', 88),
(4220, 633, 'A0667C533D7674E5482575A1000645D9', 160, 'sbdjgczhb', '三北大街工程指挥部', NULL, NULL, NULL, '', 3, '{}', 88),
(4221, 634, '0FCC6B12A41C1D6D48256D420007C4C3', 47, 'sbfzx', '市帮扶中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4222, 635, '7783EE88310FE54948257364000D922E', 47, 'sbgs', '市民政执法大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4223, 636, '8FD3C5F7F6B6805D48256B7D0043AEEC', 36, 'sbmj', '市保密局', NULL, NULL, NULL, '', 3, '{}', 88),
(4224, 637, '9D2270FE45A62D6F482573CB0008455D', 141, 'sbxxh', '市保险协会', NULL, NULL, NULL, '', 3, '{}', 88),
(4225, 638, 'BAB0EA805F7C3C9148257364000DDA78', 47, 'sbyg', '市殡仪馆', NULL, NULL, NULL, '', 3, '{}', 88),
(4226, 639, '48CB121C250773E9482573D20023846C', 55, 'scdnpgzb', '市城区东南片骨干道路指挥部', NULL, NULL, NULL, '', 3, '{}', 88),
(4227, 641, '8FAFF4EC743457834825747F0005DE6E', 75, 'scgb2', '市综合行政执法局（市城管局）许建明', NULL, NULL, NULL, '', 3, '{}', 88),
(4228, 642, '1F0D8E69155CAA904825747F0005E4A6', 75, 'scgb3', '市综合行政执法局（市城管局）卞益锋', NULL, NULL, NULL, '', 3, '{}', 88),
(4229, 643, '0113B6FF50F75C4D4825747F0005E9E5', 75, 'scgb4', '市综合行政执法局（市城管局）杨志江', NULL, NULL, NULL, '', 3, '{}', 88),
(4230, 644, 'F5183A23ED5A904D4825747F0005EE2E', 75, 'scgb5', '市综合行政执法局（市城管局）徐伯达', NULL, NULL, NULL, '', 3, '{}', 88),
(4231, 645, '53ADF24F39062EC848256B37001EAE19', 75, 'scgbbgs', '市综合行政执法局（市城管局）办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4232, 646, 'CD05A1ADE4E6F29E4825757100055D36', 75, 'scgbcws', '市综合行政执法局（市城管局）财务室', NULL, NULL, NULL, '', 3, '{}', 88),
(4233, 647, '0D24F5E60943697B4825747F00060586', 75, 'scgbsrz', '市综合行政执法局（市城管局）市容管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4234, 648, '9587873F1F045C214825757100056489', 75, 'scgbxxzx', '市智慧城管中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4235, 649, '280736ECAC40512E4825747F0006132D', 75, 'scgbzfd', '市综合行政执法局（市城管局）直属中队', NULL, NULL, NULL, '', 3, '{}', 88),
(4236, 650, '0E75A0E055831FEF4825747F00060C74', 75, 'scgbzsz', '市综合行政执法局（市城管局）法制科', NULL, NULL, NULL, '', 3, '{}', 88),
(4237, 651, 'E81421C06D69F42A48256E4A0005EB0F', 77, 'scgzx', '市机关事务管理局安全保卫科（车管科）2', NULL, NULL, NULL, '', 3, '{}', 88),
(4238, 652, '340D30EC1BF01D44482573D200239521', 55, 'schb', '市城河办', NULL, NULL, NULL, '', 3, '{}', 88),
(4239, 653, '946E1DACEE4D4FC8482572B2000D2887', 55, 'scjdaglc', '市城建档案管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(4240, 654, '27841F8EC83FB2C748256B3700274A3E', 55, 'scjwbgs', '市住建局办公室（收发）', NULL, NULL, NULL, '', 3, '{}', 88),
(4241, 655, 'DBFBB9D7947F22DC482571CB0004786B', 33, 'scl1', '市残联许国权', NULL, NULL, NULL, '', 3, '{}', 88),
(4242, 656, '26537AD8D95F60A3482571CB00048178', 33, 'scl2', '市残联毛志国', NULL, NULL, NULL, '', 3, '{}', 88),
(4243, 657, '3B98D2AB30F13EE1482571CB00048D4C', 33, 'scl3', '市残联孙月飞', NULL, NULL, NULL, '', 3, '{}', 88),
(4244, 658, '85CCC01FFDB7BCD6482571CB00049CBF', 33, 'scl4', '市残联应杰', NULL, NULL, NULL, '', 3, '{}', 88),
(4245, 659, 'C49580D33459173448256B37001EC012', 33, 'sclbgs', '市残联办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4246, 660, '2A9C91571D1EE806482571CB000A5A0F', 33, 'scllfs', '市残联教就文体部部长', NULL, NULL, NULL, '', 3, '{}', 88),
(4247, 662, 'C0C3C90293ED343D48257051000B9044', 69, 'scqb', '市查取办', NULL, NULL, NULL, '', 3, '{}', 88),
(4248, 663, '66CB67F8E79C4EE2482572F40009C79C', 0, 'scqsws', '市拆迁事务所', NULL, NULL, NULL, '', 3, '{}', 88),
(4249, 664, 'D1B34350A092030048256FDA002DC9A1', 48, 'scsh', '市慈善总会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4250, 665, '05103D1585E5BB9548256FC400244E48', 51, 'scsjcjk', '市财税局财政监督局', NULL, NULL, NULL, '', 3, '{}', 88),
(4251, 666, '69CFDC5A2F333CA9482575C7000999A5', 51, 'scsjczxh', '市财政地税局财政学会', NULL, NULL, NULL, '', 3, '{}', 88),
(4252, 667, 'E35D7AC5C65ED93648256FC400243E8A', 51, 'scsjfzk', '市财税局法规与研究室', NULL, NULL, NULL, '', 3, '{}', 88),
(4253, 668, 'E42522377AA03E2B482572C2002429E5', 51, 'scsjfzw', '市财税局范哲慰', NULL, NULL, NULL, '', 3, '{}', 88),
(4254, 670, '2CAE895C4FE485FD482571C4000F6F95', 51, 'scsjjcj', '市财税局稽查局', NULL, NULL, NULL, '', 3, '{}', 88),
(4255, 671, 'E4BAF20435703D0C48256F51000D22C6', 51, 'scsjjck', '市财税局基本建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(4256, 672, '479C0C2B0E6AF34948256D5C000AC580', 51, 'scsjjkk', '市财税局计划会计科', NULL, NULL, NULL, '', 3, '{}', 88),
(4257, 674, '3CC7E5E4101A449E4825743900047F2A', 51, 'scsjjz3', '市财政地税局马志灿', NULL, NULL, NULL, '', 3, '{}', 88),
(4258, 676, 'B26CAD5C6CE6D98D48256D5C000AAFF0', 51, 'scsjnck', '市财税局农业科', NULL, NULL, NULL, '', 3, '{}', 88),
(4259, 677, 'F4F1EB25BC515BE048256D5C000AB88B', 51, 'scsjqck', '市财政局企业科', NULL, NULL, NULL, '', 3, '{}', 88),
(4260, 678, '4CB6FACDAA7AF08248256FC40024230E', 51, 'scsjrjk', '市财税局人事教育科', NULL, NULL, NULL, '', 3, '{}', 88),
(4261, 679, '5F66E5A017C959B348256D5C000AAB8B', 51, 'scsjsfs', '市财税局收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(4262, 681, '159F225EBFE7DD7748256D5C000AC153', 51, 'scsjszk', '市财税局税政科', NULL, NULL, NULL, '', 3, '{}', 88),
(4263, 683, '19682136618B80EF48256D5C000AC986', 51, 'scsjxxzx', '市财税局信息中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4264, 685, '8DFB4AE50A7520DB48257138002791C5', 51, 'scsjzcz', '市财税局镇财政', NULL, NULL, NULL, '', 3, '{}', 88),
(4265, 686, 'C2D910EA582D6A9048256D5C000ABD07', 51, 'scsjzgk', '市财税局征收与纳税服务科', NULL, NULL, NULL, '', 3, '{}', 88),
(4266, 687, '53C1C272EA4D8F3B48256D5C000AB43F', 51, 'scsjzhk', '市财税局资产与财务管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4267, 688, 'B642DBE04BB8F067482575500023E929', 51, 'scsjzhkbb', '市财政局资产与财务管理科报表', NULL, NULL, NULL, '', 3, '{}', 88),
(4268, 689, '4CCB34C49517EAC948256FC400243167', 51, 'scsjzjk', '市财税局国库局', NULL, NULL, NULL, '', 3, '{}', 88),
(4269, 690, '72525C6514DDE9CA48256B37001EBA69', 51, 'sczdsjbgs', '市财政地税局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4270, 691, 'C7A5836C33AFAE8648256CE800240221', 51, 'sczdsjgsk', '市财政地税局会计管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4271, 692, '606A149A0675C2A048256B37001EBC6B', 51, 'sczdsjysk', '市财政地税局预算局', NULL, NULL, NULL, '', 3, '{}', 88),
(4272, 693, '4CE7E0F410069280482571700015AFC8', 203, 'sczx', '市商贸集团有限公司人力资源部', NULL, NULL, NULL, '', 3, '{}', 88),
(4273, 694, '2B35C78198D0FC344825714100036B83', 28, 'sdaj1', '市档案局蔡伟仁', NULL, NULL, NULL, '', 3, '{}', 88),
(4274, 695, 'A489EC1283BEF9F14825714100037A40', 28, 'sdaj2', '市档案局方如良', NULL, NULL, NULL, '', 3, '{}', 88),
(4275, 696, '12C4E77BA5D6C6BE4825714100038712', 28, 'sdaj3', '市档案局杨映辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4276, 697, 'C98A7359AA7B740D482571410003C112', 28, 'sdaj4', '市档案局徐建华', NULL, NULL, NULL, '', 3, '{}', 88),
(4277, 698, 'DA5A9E13C9FBD88B482575C700098F92', 28, 'sdaj5', '市档案局龚�]霞', NULL, NULL, NULL, '', 3, '{}', 88),
(4278, 699, '4D9BA910B33B9DD6482571410003AD4D', 28, 'sdajbglyk', '市档案局保管利用科', NULL, NULL, NULL, '', 3, '{}', 88),
(4279, 700, '8B3B9B0683F3518748256B380042ECE6', 28, 'sdajbgs', '市档案局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4280, 701, 'BE0501BFE28E07E94825714100039ECE', 28, 'sdajjdzdk', '市档案局监督指导科', NULL, NULL, NULL, '', 3, '{}', 88),
(4281, 702, 'FBDC36EE53E0F8414825734B00051175', 28, 'sdajjz', '市档案局张红专', NULL, NULL, NULL, '', 3, '{}', 88),
(4282, 703, '211FBC17EE4E914E482575C700088297', 28, 'sdajxxbyk', '市档案局信息编研科', NULL, NULL, NULL, '', 3, '{}', 88),
(4283, 704, 'F14A2E1A71B7DBCB4825708A0024606C', 59, 'sdhq', '市东河区', NULL, NULL, NULL, '', 3, '{}', 88),
(4284, 705, '355DB0BC749BF5EB48256D420007BCCC', 47, 'sdmb', '市地名办', NULL, NULL, NULL, '', 3, '{}', 88),
(4285, 709, 'EC538DB204B4882F48256B38000D3AA2', 95, 'sdxjbgs', '市电信局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4286, 710, 'D4229F655A0FC9D248256D390021CDC2', 137, 'sdzbxbgs', '市大众保险公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4287, 712, 'FD83D6468947E0A148256F500024881C', 10, 'sfbcs', '市府办测试', NULL, NULL, NULL, '', 3, '{}', 88),
(4288, 714, '0F173E91966676DD482573B4000272E7', 10, 'sfbfk', '市府办房科', NULL, NULL, NULL, '', 3, '{}', 88),
(4289, 715, '6C7201C84D38EA6E48256B350008DCB2', 10, 'sfbfws', '市府办发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4290, 716, '2BA33D0640E7B20148256B35003F4F58', 10, 'sfbfzj', '市政府法制办', NULL, NULL, NULL, '', 3, '{}', 88),
(4291, 718, '0094ADA3FDE21AF5482575A5002655FA', 10, 'sfbgjf', '市府办顾杰飞', NULL, NULL, NULL, '', 3, '{}', 88),
(4292, 720, '0A95F41F7213E6F54825750E00244C8D', 10, 'sfbhww', '市府办胡伟伟', NULL, NULL, NULL, '', 3, '{}', 88),
(4293, 721, 'FBD4CBC1BFDD39EC48256B37002769C9', 10, 'sfbjdb', '接待交流办', NULL, NULL, NULL, '', 3, '{}', 88),
(4294, 723, '907B35A1503184D148256B35003F3DF3', 10, 'sfbmsk', '市府办秘书科', NULL, NULL, NULL, '', 3, '{}', 88),
(4295, 724, '906185A993C5B80A4825751900081956', 10, 'sfbsdy', '市府办斯冬育', NULL, NULL, NULL, '', 3, '{}', 88),
(4296, 726, '03B16A55A8B7996548256B350008E302', 10, 'sfbsws', '市府办收文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4297, 727, '0796A89185C7F2FE482573A7000AC76C', 10, 'sfbsy', '市府办施云', NULL, NULL, NULL, '', 3, '{}', 88),
(4298, 728, '0C28D2723B3030DD482574C80025FEBE', 10, 'sfbwyc', '市府办王一川', NULL, NULL, NULL, '', 3, '{}', 88),
(4299, 729, 'E6889C9CA609CA0E48256B35003F451E', 10, 'sfbxdk', '市府办信息科', NULL, NULL, NULL, '', 3, '{}', 88),
(4300, 734, '651116FEA2293617482575AC0021EA1E', 10, 'sfbxzr', '市府办谢志荣', NULL, NULL, NULL, '', 3, '{}', 88),
(4301, 735, '4621C0796D878DAB48256B35003F5598', 10, 'sfbzgk', '市府办政工科', NULL, NULL, NULL, '', 3, '{}', 88),
(4302, 736, '7E924FFEC164C01048256B35003F19E0', 10, 'sfbzhk', '市府办综合一科', NULL, NULL, NULL, '', 3, '{}', 88),
(4303, 737, '346E83684AC29D27482572BC00050196', 0, 'sfdcglzx', '市房地产管理中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4304, 738, 'A6175C67741AD4CB4825739A0000574F', 31, 'sfegwwqb', '组联部 妇儿工委办', NULL, NULL, NULL, '', 3, '{}', 88),
(4305, 739, '05D6E7474228824048256FD900061DCF', 38, 'sfgj1', '市发展改革局余银国', NULL, NULL, NULL, '', 3, '{}', 88),
(4306, 740, '37CFD540C39022F048256FD900068496', 38, 'sfgj10', '市发展改革局郑延艳', NULL, NULL, NULL, '', 3, '{}', 88),
(4307, 741, '5050714E1DE290E6482572800003D775', 38, 'sfgj11', '市发展改革局章寿乐', NULL, NULL, NULL, '', 3, '{}', 88),
(4308, 742, '4B46A69D5AA7A00648257424002045F2', 38, 'sfgj12', '市发展改革局赵玉宝', NULL, NULL, NULL, '', 3, '{}', 88),
(4309, 743, '53A7C635D4F62F924825750500122B5F', 38, 'sfgj13', '市发展改革局张新江', NULL, NULL, NULL, '', 3, '{}', 88),
(4310, 744, '11352138C06771EE48256FD900062C9C', 38, 'sfgj2', '市发展改革局宓潭', NULL, NULL, NULL, '', 3, '{}', 88),
(4311, 745, 'DEF9EFD48342120B48256FD900063BFA', 38, 'sfgj3', '市发展改革局张冰', NULL, NULL, NULL, '', 3, '{}', 88),
(4312, 746, '0191A2EB164D946648256FD9000647B5', 38, 'sfgj4', '市发展改革局陈岳根', NULL, NULL, NULL, '', 3, '{}', 88),
(4313, 747, 'CA45C686FE83C9F748256FD9000651EA', 38, 'sfgj5', '市发展改革局徐静静', NULL, NULL, NULL, '', 3, '{}', 88),
(4314, 749, '137FFBC9A6CFE1A148256FD90006680D', 38, 'sfgj7', '市发展改革局丁建权', NULL, NULL, NULL, '', 3, '{}', 88),
(4315, 750, 'D282E393C98533B648256FD900067203', 38, 'sfgj8', '市发展改革局徐旭', NULL, NULL, NULL, '', 3, '{}', 88),
(4316, 751, 'C7765315F8DEA21248256FD900067C06', 38, 'sfgj9', '市发展改革局调研员室', NULL, NULL, NULL, '', 3, '{}', 88),
(4317, 752, '994C087D2725F92548256FD900069761', 38, 'sfgjbgs', '市发展改革局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4318, 753, 'C63FD9A8CE23F30048256FD90006AC1B', 38, 'sfgjdw', '市发展改革局办公室(党务)', NULL, NULL, NULL, '', 3, '{}', 88),
(4319, 754, '9C258B5298F90E7A48256FD90006DEDD', 38, 'sfgjfgk', '市发展改革局综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4320, 755, '59B4DD1ED16D994B48256FD90007B492', 38, 'sfgjghb', '市发展改革局规划办', NULL, NULL, NULL, '', 3, '{}', 88),
(4321, 756, '830FFC01DD22FD8448256FD900071163', 38, 'sfgjjcb', '市发展改革局稽查办', NULL, NULL, NULL, '', 3, '{}', 88),
(4322, 757, '5FADFAB1E688739548256FD900074BB5', 38, 'sfgjjgk', '市发展改革局价格科', NULL, NULL, NULL, '', 3, '{}', 88),
(4323, 759, 'C3054571AC2670A648256FD900073E8E', 38, 'sfgjqqb', '市发展改革局前期科', NULL, NULL, NULL, '', 3, '{}', 88),
(4324, 760, '8FDAB5F34EB3789748256FD9000880C2', 38, 'sfgjrzzx', '市发展改革局认证中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4325, 761, '57430B7A0E08BF6D48256FD900083BA9', 38, 'sfgjsanzb', '市发展改革局社会发展科', NULL, NULL, NULL, '', 3, '{}', 88),
(4326, 762, 'A77EF6D25A9EA1A448256FD900075B4A', 38, 'sfgjsfk', '市发展改革局收费科', NULL, NULL, NULL, '', 3, '{}', 88),
(4327, 765, '93087C3A115BC42248256FD90007A6BF', 38, 'sfgjszb', '市发展改革局海洋经济科', NULL, NULL, NULL, '', 3, '{}', 88),
(4328, 766, '359DAB84A528D8FA48256FD900076A3B', 38, 'sfgjtgk', '市发展改革局体改科', NULL, NULL, NULL, '', 3, '{}', 88),
(4329, 767, 'F358AE5F18E5480D48256FD90006F24F', 38, 'sfgjtzk', '市发展改革局投资科', NULL, NULL, NULL, '', 3, '{}', 88),
(4330, 768, '6F884B33CEA84A4248256FD90007827F', 38, 'sfgjwjs', '市发展改革局物检分局', NULL, NULL, NULL, '', 3, '{}', 88),
(4331, 769, '478D9212D66E25E2482571C30027F101', 38, 'sfgjxhb', '市发展改革局张鹰', NULL, NULL, NULL, '', 3, '{}', 88),
(4332, 770, '4414BACCE9A2EA5948256FD90007304A', 38, 'sfgjzcfgk', '市发展改革局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(4333, 771, '04811587AB00E4ED48256FD9000776C0', 38, 'sfgjzdb', '市发展改革局重点办', NULL, NULL, NULL, '', 3, '{}', 88),
(4334, 772, '8437CE21811A3F2F48256FD90006CB31', 38, 'sfgjzw', '市发展改革局胡铁劲', NULL, NULL, NULL, '', 3, '{}', 88),
(4335, 774, '3866A24D79C5FF9E48256B37001ECD39', 74, 'sfjlyjbgs', '市旅游局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4336, 775, '4C45BD47A163631048257204000D8EFC', 31, 'sfl1', '市妇联王晓引', NULL, NULL, NULL, '', 3, '{}', 88),
(4337, 776, '9BA1C5EC5E5A559D48257204000D97F3', 31, 'sfl2', '市妇联童亚冲', NULL, NULL, NULL, '', 3, '{}', 88),
(4338, 777, '3540E45604D9708548257204000DA0A0', 31, 'sfl3', '市妇联马雅珍', NULL, NULL, NULL, '', 3, '{}', 88),
(4339, 778, 'D456B03947AC839C4825751D000460BF', 31, 'sfl4', '市妇联施晶晶', NULL, NULL, NULL, '', 3, '{}', 88),
(4340, 779, '9C2CFC48AEEEC79548256B370022E263', 31, 'sflbgs', '市妇联办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4341, 780, '1172E6AE68A958DB48257204000DB6CB', 31, 'sfljcgzb', '基层权益部', NULL, NULL, NULL, '', 3, '{}', 88),
(4342, 781, '817C13D6B11E83C94825746A000B0B85', 31, 'sflxxzy', '市妇联信息专用', NULL, NULL, NULL, '', 3, '{}', 88),
(4343, 783, '935BCD561DD2D95F48256B370026100F', 13, 'sfybgs', '市法院办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4344, 784, 'A93EFD508DE846CA48256B3700260D49', 45, 'sgaj110', '市公安局110', NULL, NULL, NULL, '', 3, '{}', 88),
(4345, 785, 'E1BE535B71BDD67B48256B3700260C15', 45, 'sgajbgs', '市公安局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4346, 786, '7CED269CC419C1B248256E4C00226F64', 45, 'sgajcws', '市公安局财务室', NULL, NULL, NULL, '', 3, '{}', 88),
(4347, 787, 'E8ED056DCE303A1948256B41000AED6A', 45, 'sgajgaxx', '市公安局公安信息', NULL, NULL, NULL, '', 3, '{}', 88),
(4348, 788, '295A9D6703BBE3A348256EB3002DD91A', 45, 'sgajgbdd', '市公安局国保大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4349, 789, '325A20289460F7A9482573AA0021A1A6', 45, 'sgajjdw', '市公安局局党委', NULL, NULL, NULL, '', 3, '{}', 88),
(4350, 790, '5F6827508FA39E41482573F6001D5C05', 45, 'sgajjw', '市公安局纪委', NULL, NULL, NULL, '', 3, '{}', 88),
(4351, 791, 'B0C0FEF4E43B260848256E00000485EC', 45, 'sgajjyxl', '市公安局教育训练', NULL, NULL, NULL, '', 3, '{}', 88),
(4352, 792, '8EA69174C59F4FDD48256ED1000E3924', 45, 'sgajxfs', '市公安局信访室', NULL, NULL, NULL, '', 3, '{}', 88),
(4353, 793, 'AF40CE5D472C984348256C8300091B0E', 45, 'sgajzzc', '市公安局政治处', NULL, NULL, NULL, '', 3, '{}', 88),
(4354, 795, '8D6D10341F6C88C84825750C000269A4', 72, 'sgbdstbgs2', '市广播电视台办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(4355, 796, '7E65409C4F54B04448256B3700246DDB', 72, 'sgdjbgs', '市广播电视台办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4356, 797, 'E0AE0AD2DA6F1212482571DA000A65E7', 72, 'sgdzx1', '市广播电视台胡建灿', NULL, NULL, NULL, '', 3, '{}', 88),
(4357, 798, '92EA53FC03D8A8B4482571DA000AC0C4', 72, 'sgdzx10', '市广播电视台杨智峰', NULL, NULL, NULL, '', 3, '{}', 88),
(4358, 799, 'DB2583E775B2A273482574600002F902', 72, 'sgdzx11', '市广播电视台顾坚斌', NULL, NULL, NULL, '', 3, '{}', 88),
(4359, 800, '89B1DE72552662E7482571DA000A6E1D', 72, 'sgdzx2', '市广播电视台胡岳鹏', NULL, NULL, NULL, '', 3, '{}', 88),
(4360, 801, '4BFD3E2CCE5969D3482571DA000A75C3', 72, 'sgdzx3', '市广播电视台胡志明', NULL, NULL, NULL, '', 3, '{}', 88),
(4361, 802, '8E8B6F74E3C72A74482571DA000A8547', 72, 'sgdzx4', '市广播电视台陈军', NULL, NULL, NULL, '', 3, '{}', 88),
(4362, 803, 'C92246D97F404994482571DA000A8F33', 72, 'sgdzx5', '市广播电视台胡国安', NULL, NULL, NULL, '', 3, '{}', 88),
(4363, 804, '0B22B4F5D499297E482571DA000AA07F', 72, 'sgdzx6', '市广播电视台冯立中', NULL, NULL, NULL, '', 3, '{}', 88),
(4364, 805, '4B0CA144FBEFCC8D482571DA000AA9F2', 72, 'sgdzx7', '市广播电视台网站', NULL, NULL, NULL, '', 3, '{}', 88),
(4365, 806, 'D96A952341A2CC80482571DA000AB1B7', 72, 'sgdzx8', '市广播电视台总编室', NULL, NULL, NULL, '', 3, '{}', 88),
(4366, 807, '7D4F934380F3F947482571DA000AB8FC', 72, 'sgdzx9', '市广播电视台办公室主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4367, 808, '03792022D5519477482572C90030BE8C', 72, 'sgdzxxwb', '市广播电视台新闻部', NULL, NULL, NULL, '', 3, '{}', 88),
(4368, 809, '3249478835665F7948256F4A0008E869', 57, 'sggs', '市交通运输局运管所', NULL, NULL, NULL, '', 3, '{}', 88),
(4369, 810, '6ECCCA8D64F1578A482572F40009D58C', 57, 'sgjgs', '市交通运输局城市客运管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(4370, 811, 'DED02DEB51C778CE4825746B00057579', 78, 'sgjzx1', '市公建中心杨锋辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4371, 812, 'F5D19037599DBC394825746B00057CA9', 78, 'sgjzx2', '市公建中心黄大文', NULL, NULL, NULL, '', 3, '{}', 88),
(4372, 813, 'E71B61657C6FCD2F4825746B00058475', 78, 'sgjzx3', '市公建中心吕建淼', NULL, NULL, NULL, '', 3, '{}', 88),
(4373, 815, '65C079D27936F0274825746B0005C269', 78, 'sgjzx5', '市公建中心胡建权', NULL, NULL, NULL, '', 3, '{}', 88),
(4374, 816, '4CE762B359E49F9F48257592001044A0', 78, 'sgjzx6', '市公建中心成佩君', NULL, NULL, NULL, '', 3, '{}', 88),
(4375, 817, '54118BA173BE6BA448256DC50009ED90', 78, 'sgjzxbgs', '市公建中心办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4376, 818, '3990BE19025E497B4825746B0005CDD7', 78, 'sgjzxcwk', '市公建中心财务科', NULL, NULL, NULL, '', 3, '{}', 88),
(4377, 819, 'AE81542475490A7B4825746B0005C927', 78, 'sgjzxjzk', '市公建中心建筑科', NULL, NULL, NULL, '', 3, '{}', 88),
(4378, 820, '44919CEC381D06664825746B0005C5EB', 78, 'sgjzxqqk', '市公建中心前期科', NULL, NULL, NULL, '', 3, '{}', 88),
(4379, 821, '31CD5E0F771FDD2D48256F4A0009104B', 57, 'sglyszgs', '市交通运输局公路运输有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4380, 822, 'CC06E3093F42DE5148256B38000D4EEC', 91, 'sgongdjbgs', '市供电局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4381, 830, 'E4A4BCF1E9922EFA48256B3800208376', 69, 'sgsfjbgs', '市工商分局办公室(备份）', NULL, NULL, NULL, '', 3, '{}', 88),
(4382, 834, 'CBBC9AF2F23FF5364825717100127F2E', 68, 'sgsj1', '市国税局杨斌', NULL, NULL, NULL, '', 3, '{}', 88),
(4383, 835, '03E0168D9A3DDF4948256B37001EC21F', 68, 'sgsjbgs', '市国税局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4384, 836, '0BF0DCECEDBBA7D548256B7D0044A4B4', 32, 'sgslbgs', '市工商联办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4385, 837, '5E813B0EECB8037548256B380020C9E5', 114, 'sgsyhbgs', '市工商银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4386, 838, 'F3C00D85FB082DA9482572970006B196', 54, 'sgtjxfs', '市国土资源局信访室', NULL, NULL, NULL, '', 3, '{}', 88),
(4387, 839, 'A952B6F9664F468748256B380020ADCC', 92, 'sgxlsbgs', '市农合联执委会（市供销社)办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4388, 840, 'A92501A575553CBA482573FE00031A34', 41, 'sgyjjghyjs', '市工业经济规划研究所', NULL, NULL, NULL, '', 3, '{}', 88),
(4389, 841, '4E92976ECFC9FF3F48256B7D00444B55', 51, 'sgzb', '市国资办', NULL, NULL, NULL, '', 3, '{}', 88),
(4390, 842, '1B9A3E68E50F3260482570150004BF35', 80, 'sgzb1', '市国资局魏徐林', NULL, NULL, NULL, '', 3, '{}', 88),
(4391, 843, 'D0E95412B5697A29482570150004C85B', 80, 'sgzb2', '市国资局郑建杰', NULL, NULL, NULL, '', 3, '{}', 88),
(4392, 845, 'B77EC175C92A5B0248257015000503D5', 80, 'sgzbglk', '市国资局统评科', NULL, NULL, NULL, '', 3, '{}', 88),
(4393, 846, '82DBDD74164245D4482570150004FD77', 80, 'sgzbkfk', '市国资局产权科', NULL, NULL, NULL, '', 3, '{}', 88),
(4394, 847, 'BBD6B9AF8ABBDE03482570150004F52A', 80, 'sgzbzhk', '市国资局办公室２', NULL, NULL, NULL, '', 3, '{}', 88),
(4395, 848, '0FDD1E63E04B93AF482572CB0020DC30', 66, 'shbj1', '市环保局调研员', NULL, NULL, NULL, '', 3, '{}', 88),
(4396, 849, 'D27B1F61FDAA7A9148256B370027539E', 66, 'shbjbgs', '市环保局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4397, 850, '720275D33E86F9BA48256DEF001C5AC3', 66, 'shbjbgszr', '市环保局办公室主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4398, 851, 'C66F919DA1C3A8E848256DEF001C703D', 66, 'shbjfgk', '市环保局法规监督科', NULL, NULL, NULL, '', 3, '{}', 88),
(4399, 852, '466FC4D368A03C9548256DEF001C64FF', 66, 'shbjglk', '市环保局业务科', NULL, NULL, NULL, '', 3, '{}', 88),
(4400, 853, 'FE761C7CD26A6E9948256DEF001C5FCA', 66, 'shbjjcz', '市环保局监测站', NULL, NULL, NULL, '', 3, '{}', 88),
(4401, 854, '1DB90E1C8444639748256DEF001C75D9', 66, 'shbjjlz', '市环保局监察大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4402, 855, '52DA27CF6CB5BEE948256DEF001C417D', 66, 'shbjjzs1', '市环保局郑松华', NULL, NULL, NULL, '', 3, '{}', 88),
(4403, 856, 'A4E970D1F9F2B00248256DEF001C46BB', 66, 'shbjjzs2', '市环保局杨建华', NULL, NULL, NULL, '', 3, '{}', 88),
(4404, 857, 'BC1E9E3C27E0CB6848256DEF001C4C4D', 66, 'shbjjzs3', '市环保局胡立江', NULL, NULL, NULL, '', 3, '{}', 88),
(4405, 858, '146EAAEC36DB3A4648256DEF001C5135', 66, 'shbjjzs4', '市环保局胡建强', NULL, NULL, NULL, '', 3, '{}', 88),
(4406, 861, '9B0999884AC8FEEC48256DEF001C6A25', 66, 'shbjkfk', '市环保局建管科', NULL, NULL, NULL, '', 3, '{}', 88),
(4407, 862, 'BEBB2307240265EB482572CB0022E8EB', 66, 'shbjstb', '市环保局生态办', NULL, NULL, NULL, '', 3, '{}', 88),
(4408, 863, '7999B4021D8EA87148256B39000847F7', 8, 'shencq', '市委办沈聪奇', NULL, NULL, NULL, '', 3, '{}', 88),
(4409, 866, '6FAEFD3CAC43D28048256B37001EC417', 87, 'shgbscbgs', '市海关办事处办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4410, 867, '79D2A41CC053F40E48256F4A0008FE94', 57, 'shgs', '市交通运输局港航处', NULL, NULL, NULL, '', 3, '{}', 88),
(4411, 868, 'E2F645A4F84CFB9A48256B37001EB388', 0, 'shgwbgs', '市海管委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4412, 870, '22FD3F1CB32AB20B48256B35003F06EB', 10, 'shigj', '市府办02', NULL, NULL, NULL, '', 3, '{}', 88),
(4413, 872, '333C709B2333070B482571CC00103D8D', 0, 'shwcbgs', '市环卫处办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4414, 873, '895C18ADD34710CC482571CC0010473D', 0, 'shwczrs', '市环卫处主任室', NULL, NULL, NULL, '', 3, '{}', 88),
(4415, 877, '442AEFE6903D778E48257562001105C9', 131, 'shyh', '上海银行', NULL, NULL, NULL, '', 3, '{}', 88),
(4416, 879, '118E7380912431D7482573D20023A4A9', 185, 'sjcbzhk', '市景观大道改造指挥部综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4417, 880, '389F8E04A29404B74825703F0025C884', 42, 'sjcdd', '市监察大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4418, 883, '50B555277DD89E6948256B7D0042FBFA', 15, 'sjcj', '市监察局', NULL, NULL, NULL, '', 3, '{}', 88),
(4419, 884, 'AA53165E54DE40EC48256FF00010A614', 61, 'sjckgs', '市进出口公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4420, 885, 'E13D5D8E0776EF1948256B3700260ED9', 12, 'sjcybgs', '市检察院办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4421, 886, 'B68950FFA5EB906E48257366001280DD', 12, 'sjcybgs2', '市检察院办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(4422, 888, '8A256148BEE4321A4825736600098A8D', 12, 'sjcyjcz', '市检察院陈贺评', NULL, NULL, NULL, '', 3, '{}', 88),
(4423, 889, 'EA7E40A3C81B3AAD482573660009C24C', 12, 'sjcyjcz1', '市检察院王春媛', NULL, NULL, NULL, '', 3, '{}', 88),
(4424, 890, '6688DC6EE5810210482573660009EB24', 12, 'sjcyjcz2', '市检察院成建明', NULL, NULL, NULL, '', 3, '{}', 88),
(4425, 891, 'DD2FBEAA2EF5D2FF48257366000A1272', 12, 'sjcyjcz3', '市检察院宋亚男', NULL, NULL, NULL, '', 3, '{}', 88),
(4426, 892, 'D361DC509C40C48048257366000A3549', 12, 'sjcyjcz4', '市检察院陆漫', NULL, NULL, NULL, '', 3, '{}', 88),
(4427, 893, '44E3A2E838C0C86F48256FFD00283838', 12, 'sjcyksk', '市检察院控申科', NULL, NULL, NULL, '', 3, '{}', 88),
(4428, 894, '7169093E5AD7574D48256D41000DF127', 12, 'sjcyzzc', '市检察院政治处', NULL, NULL, NULL, '', 3, '{}', 88),
(4429, 897, '7AB2D79CF5E73475482570BA001FEA6E', 41, 'sjfjcw', '市经信局办公室（财务）', NULL, NULL, NULL, '', 3, '{}', 88),
(4430, 898, '24EAB7A150ABE9D648256D09000B3B9E', 41, 'sjfjdlzyk', '市经信局能源综合利用科', NULL, NULL, NULL, '', 3, '{}', 88),
(4431, 900, '9FC9E5A9ECCD106448256D09000B1519', 41, 'sjfjfsjs', '市经信局陈飞达', NULL, NULL, NULL, '', 3, '{}', 88),
(4432, 901, '95E477DDF48623754825752A00057652', 41, 'sjfjfwqy', '市经信局干部服务企业办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4433, 902, 'C1F38CF2B4294888482575AC0021F8E2', 41, 'sjfjgnjjhz', '市经信局经济合作科', NULL, NULL, NULL, '', 3, '{}', 88),
(4434, 906, '857EB3F56786A06D48256D09000B2E82', 41, 'sjfjjjyhk', '市经信局经济运行科', NULL, NULL, NULL, '', 3, '{}', 88),
(4435, 907, 'CABF8DAB6737998048256D09000B1067', 41, 'sjfjjzs1', '市经信局局长', NULL, NULL, NULL, '', 3, '{}', 88),
(4436, 908, '196E2F991C91676948256D09000B19AF', 41, 'sjfjjzs2', '市经信局罗维昌', NULL, NULL, NULL, '', 3, '{}', 88),
(4437, 909, 'FC47752C87185F1248256D09000B1DB5', 41, 'sjfjjzs3', '市经信局许百远', NULL, NULL, NULL, '', 3, '{}', 88),
(4438, 910, 'D3BE47968DAFB3EF48256D09000B21E8', 41, 'sjfjjzs4', '市经信局孙跃', NULL, NULL, NULL, '', 3, '{}', 88),
(4439, 911, 'CFBD8FF8F5079944482570BA00205361', 41, 'sjfjlgbzx', '市经信局老干部中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4440, 912, '71BF1315C080EB0748256D09000B374C', 41, 'sjfjqyzdk', '市经信局企业指导科', NULL, NULL, NULL, '', 3, '{}', 88),
(4441, 913, '4B3CECD7BC9E5A7348256D09000B3F85', 41, 'sjfjtzkjk', '市经信局技术改造与进步科', NULL, NULL, NULL, '', 3, '{}', 88),
(4442, 914, '0BF8D2E7F4934969482571B60005D582', 41, 'sjfjwy', '市经信局周建明', NULL, NULL, NULL, '', 3, '{}', 88),
(4443, 915, '8057CA774A45F23248256D09000B262F', 41, 'sjfjwy1', '市经信局韩满园', NULL, NULL, NULL, '', 3, '{}', 88),
(4444, 917, '9A9ABBE2E6FFFF1A482570BA00206582', 41, 'sjfjwyjg', '市经信局黄椒柏', NULL, NULL, NULL, '', 3, '{}', 88),
(4445, 918, 'FDA08632C71FA68C482570BA0020330D', 41, 'sjfjxx', '市经信局办公室（信息）', NULL, NULL, NULL, '', 3, '{}', 88),
(4446, 919, 'CEDBDC6A3BFABE8B482570BA00201533', 41, 'sjfjzg', '市经信局办公室（政工）', NULL, NULL, NULL, '', 3, '{}', 88),
(4447, 920, '0224A86B859CE24D482570BA00202411', 41, 'sjfjzh', '市经信局办公室（综合）', NULL, NULL, NULL, '', 3, '{}', 88),
(4448, 921, '7C2A0547273F40E248256B370022E631', 23, 'sjgdgwbgs', '市机关党工委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4449, 922, 'F4DB98BB458D23FE4825750500264641', 23, 'sjgdgwsj', '市机关党工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4450, 923, 'AD2F20A9E3F9409848256E62002EAF99', 77, 'sjgfwzxcgk', '市机关事务管理局安全保卫（车管科）1', NULL, NULL, NULL, '', 3, '{}', 88),
(4451, 924, 'D0DB05B4AB3E1A3048256E62002EA10C', 10, 'sjgfwzxjz1', '市府办蒋永亮', NULL, NULL, NULL, '', 3, '{}', 88),
(4452, 925, '28C15A0D90E1B4C448256E62002EA550', 77, 'sjgfwzxjz2', '市机关事务管理局黄国范', NULL, NULL, NULL, '', 3, '{}', 88),
(4453, 926, '8B7AD9066729071A48256E62002EAB1D', 77, 'sjgfwzxjz3', '市机关事务管理局李德洲', NULL, NULL, NULL, '', 3, '{}', 88),
(4454, 928, 'E866E0E4A9387E6748257483000A70B7', 77, 'sjgfwzxsbk2', '市机关事务管理局基建设备和节能管理科1', NULL, NULL, NULL, '', 3, '{}', 88),
(4455, 929, '5663D8CF206BC06A48256B37001ECB77', 77, 'sjggljbgs', '市机关事务管理局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4456, 930, '0CB285433EB37B2C482573FA00277304', 77, 'sjgjnb', '市机关事务管理局基建设备和节能管理科2', NULL, NULL, NULL, '', 3, '{}', 88),
(4457, 931, 'CDEC14D187AF2FEE48256FEB000E0970', 77, 'sjgyry', '市机关幼儿园', NULL, NULL, NULL, '', 3, '{}', 88),
(4458, 932, '68EDE874909474FE48256B3700248655', 43, 'sjiaowbgs', '市教育局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4459, 933, 'E2E684722E3689AD48256B3700295C85', 41, 'sjingwbgs', '市经信局办公室(收发)', NULL, NULL, NULL, '', 3, '{}', 88),
(4460, 934, '3F40257B56C3EB7448256B37001EB1CD', 6, 'sjjkfqbgs', '开发区管委会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4461, 935, 'B28CC9F5EC1B73FF482572BF00234D86', 41, 'sjnb', '市节能办', NULL, NULL, NULL, '', 3, '{}', 88),
(4462, 936, '9B336CBBB26AA9C948257364000E682D', 47, 'sjng', '市纪念馆', NULL, NULL, NULL, '', 3, '{}', 88),
(4463, 937, '13422F29374030CB482574600029BE0B', 39, 'sjpb', '市经普办', NULL, NULL, NULL, '', 3, '{}', 88),
(4464, 938, '151852B9533617894825750E000681D2', 84, 'sjrb1', '市金融办谢志荣', NULL, NULL, NULL, '', 3, '{}', 88),
(4465, 939, 'ABC654B6EA31A3DD4825750E00067773', 84, 'sjrbjrk', '市金融办金融科', NULL, NULL, NULL, '', 3, '{}', 88),
(4466, 940, '022DBB29E34ED7F04825750E00066E66', 84, 'sjrbssk', '市金融办上市科', NULL, NULL, NULL, '', 3, '{}', 88),
(4467, 941, 'CA1715D3DAEAF21448256F54002D879F', 63, 'sjsj5', '市卫生和计划生育局沈国联', NULL, NULL, NULL, '', 3, '{}', 88),
(4468, 947, 'C47C823491D5BFEB48256F350001993F', 55, 'sjsjcwk', '市住建局财务审计科', NULL, NULL, NULL, '', 3, '{}', 88),
(4469, 953, '95765B6E91B72454482572B2000CDA27', 55, 'sjsjdyys3', '市住建局方龙耀（调研员）', NULL, NULL, NULL, '', 3, '{}', 88),
(4470, 954, '5D4FAE6B9DABF7EC482573D2002468AB', 55, 'sjsjdyys4', '市住建局章金富（调研员）', NULL, NULL, NULL, '', 3, '{}', 88),
(4471, 955, '03D1A9F39DD759E648256F350001A60B', 55, 'sjsjfdk', '市住建局房地产业科', NULL, NULL, NULL, '', 3, '{}', 88),
(4472, 956, 'F75BB07A2E2CC6A1482572B2000CF932', 55, 'sjsjfgjc', '市住建局法规监察科(行政审批科)', NULL, NULL, NULL, '', 3, '{}', 88),
(4473, 958, '5D6D6FDA4B6FC083482572B2000C5DFE', 55, 'sjsjfjzs1', '市住建局黄光辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4474, 959, '2E2611C74047B83F482572B2000C66C4', 55, 'sjsjfjzs2', '市住建局陈锋', NULL, NULL, NULL, '', 3, '{}', 88),
(4475, 961, '9B5DA5EF97F6469C4825747A002CE7B0', 55, 'sjsjfjzs6', '市住建局励聪', NULL, NULL, NULL, '', 3, '{}', 88),
(4476, 962, '1A4F692CD20D30674825750E0002CDED', 55, 'sjsjfsj', '市住建局卢文明', NULL, NULL, NULL, '', 3, '{}', 88),
(4477, 964, '949FFCCA26AEB76648256F350001B44F', 55, 'sjsjjsk', '市住建局建设管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4478, 965, '2FF9C8C9ED937143482573E20006D78E', 55, 'sjsjjszb', '市住建局建设志办', NULL, NULL, NULL, '', 3, '{}', 88),
(4479, 968, '0DE5BFD722A8649748256BC70003FDE4', 63, 'sjsjjzs2', '市卫生和计划生育局黄立孟', NULL, NULL, NULL, '', 3, '{}', 88),
(4480, 969, 'B41B7CC77A6C271748256BC70004016F', 63, 'sjsjjzs3', '市卫生和计划生育局马海娣', NULL, NULL, NULL, '', 3, '{}', 88),
(4481, 970, '1264BAA523629AEC48256BC7000404FD', 63, 'sjsjjzs4', '市卫生和计划生育局朱国泉', NULL, NULL, NULL, '', 3, '{}', 88),
(4482, 971, '8BBFD337ECFF76B648256F3500018672', 55, 'sjsjrsk', '市住建局人事监察科', NULL, NULL, NULL, '', 3, '{}', 88),
(4483, 972, '09BFBF3A8A00B32548256F350001BFBF', 55, 'sjsjszc', '市市政工程管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(4484, 973, '77507EE8162C5725482573D200236DFF', 188, 'sjsjt', '市建设集团王洪敏', NULL, NULL, NULL, '', 3, '{}', 88),
(4485, 974, '53198F3759F40C05482573D20023B4AA', 188, 'sjsjtzhb', '市建设集团综合事务部', NULL, NULL, NULL, '', 3, '{}', 88),
(4486, 975, 'C25AC16973945ECA482572B2000D0EE4', 55, 'sjsjwyk', '市住建局物管中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4487, 977, '00E27168209C8699482572B2000CEBCF', 55, 'sjsjzgcs', '市住建局总工程师室', NULL, NULL, NULL, '', 3, '{}', 88),
(4488, 979, '9CE42A258DDF6FC748256B380020E52D', 117, 'sjsyhbgs', '市建设银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4489, 980, '7E5BB18F00F65F234825751C0021E2CA', 117, 'sjsyhsf', '市建设银行市府办事处', NULL, NULL, NULL, '', 3, '{}', 88),
(4490, 981, '7390BCB20D182B5448256E62002EB3E7', 77, 'sjszx', '市机关事务管理局财务科（市结算中心）', NULL, NULL, NULL, '', 3, '{}', 88),
(4491, 982, '0E30F6893F7F4F5048256F0B003255DC', 57, 'sjtj1', '市交通运输局许裕龙', NULL, NULL, NULL, '', 3, '{}', 88),
(4492, 983, 'EF7A42661C4E13A248256F0B00325FB3', 57, 'sjtj2', '市交通运输局徐雪尔', NULL, NULL, NULL, '', 3, '{}', 88),
(4493, 984, '73B9505622DB835248256F0B00326AAC', 57, 'sjtj3', '市交通运输局胡伯权', NULL, NULL, NULL, '', 3, '{}', 88),
(4494, 985, '826487D5E388B1E448256F0B003272C4', 57, 'sjtj4', '市交通运输局吴松达', NULL, NULL, NULL, '', 3, '{}', 88),
(4495, 987, '815793F866FFB836482571BD00200E01', 57, 'sjtj6', '市交通运输局陆幼菊', NULL, NULL, NULL, '', 3, '{}', 88),
(4496, 988, '03E2E4F345681C7C48256B37002961A1', 57, 'sjtjbgs', '市交通运输局办公室收发', NULL, NULL, NULL, '', 3, '{}', 88),
(4497, 989, '171F1B0618DCC9F848256F4A000822A5', 57, 'sjtjbgs2', '市交通运输局办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(4498, 990, '6099C7195EBDF55A48256F4A00082DAE', 57, 'sjtjbgs3', '市交通运输局办公室3', NULL, NULL, NULL, '', 3, '{}', 88),
(4499, 991, 'DB7505C75CA0257C48256F4A000838A9', 57, 'sjtjbgs4', '市交通运输局办公室主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4500, 992, 'D18A626D46D518A548256F4A000842CD', 57, 'sjtjbgs5', '市交通运输局办公室5', NULL, NULL, NULL, '', 3, '{}', 88),
(4501, 993, 'D8DC94028C12533E4825722000218588', 57, 'sjtjbgs6', '市交通运输局办公室6', NULL, NULL, NULL, '', 3, '{}', 88),
(4502, 994, '257383162A0E10CA482574640000E5FB', 57, 'sjtjbgs7', '市交通运输局办公室7', NULL, NULL, NULL, '', 3, '{}', 88),
(4503, 997, '5D9C1581CB6CCE1548256F4A0008119C', 57, 'sjtjdyy3', '市交通运输局陈志军', NULL, NULL, NULL, '', 3, '{}', 88),
(4504, 998, '4D87E0AD295233CE48256EC3000D2E50', 57, 'sjtjgld', '市交通运输局公路管理段', NULL, NULL, NULL, '', 3, '{}', 88),
(4505, 999, '9DB555037005835B48256F0B0032CA9B', 57, 'sjtjjck', '市交通运输局计财科', NULL, NULL, NULL, '', 3, '{}', 88),
(4506, 1000, '05BBFE3C7A7B983948256F4A0008BB24', 57, 'sjtjjck2', '市交通运输局计财科2', NULL, NULL, NULL, '', 3, '{}', 88),
(4507, 1001, '53288477F9A5088A48256F4A0008D04A', 57, 'sjtjjck3', '市交通运输局计财科3', NULL, NULL, NULL, '', 3, '{}', 88),
(4508, 1002, '78B7704A5AA9C60548256F4A0008D93D', 57, 'sjtjjck4', '市交通运输局计财科4', NULL, NULL, NULL, '', 3, '{}', 88),
(4509, 1003, '53D423B71110054B482571BD00201CD7', 57, 'sjtjjck5', '市交通运输局计财科5', NULL, NULL, NULL, '', 3, '{}', 88),
(4510, 1004, '8B072EADAB75BCFA48256F0B0032BEF9', 57, 'sjtjjgk', '市交通运输局建管科', NULL, NULL, NULL, '', 3, '{}', 88),
(4511, 1005, '17609B3111FD6A8248256F4A0008985D', 57, 'sjtjjgk2', '市交通运输局建管科2', NULL, NULL, NULL, '', 3, '{}', 88),
(4512, 1006, '0EF6DCF8DC785DD148256F4A0008A224', 57, 'sjtjjgk3', '市交通运输局建管科3', NULL, NULL, NULL, '', 3, '{}', 88),
(4513, 1007, '900E5680F2EDC75C48256F4A0008ACBE', 57, 'sjtjjgk4', '市交通运输局建管科4', NULL, NULL, NULL, '', 3, '{}', 88),
(4514, 1008, '353D0E64520451FD48256F0B002D2A08', 57, 'sjtjsfs', '市交通运输局前期办', NULL, NULL, NULL, '', 3, '{}', 88),
(4515, 1009, 'CE04BDBBA94F2B1948256F0B0032B480', 57, 'sjtjygk', '市交通运输局运管科', NULL, NULL, NULL, '', 3, '{}', 88),
(4516, 1010, 'B41DEF3A7E57C84E48256F4A000852FE', 57, 'sjtjygk2', '市交通运输局运管科2', NULL, NULL, NULL, '', 3, '{}', 88),
(4517, 1011, '1F72287CB11293D748256F4A00085FE8', 57, 'sjtjygk3', '市交通运输局运管科3', NULL, NULL, NULL, '', 3, '{}', 88),
(4518, 1012, 'B2F85B7C9885862048256F4A000869D2', 57, 'sjtjygk4', '市交通运输局运管科4', NULL, NULL, NULL, '', 3, '{}', 88),
(4519, 1013, '36DA7D8C2F30FAD248256F4A000873A2', 57, 'sjtjygk5', '市交通运输局运管科5', NULL, NULL, NULL, '', 3, '{}', 88),
(4520, 1014, 'C8ADA2B39298A18948256F4A00087C6B', 57, 'sjtjygk6', '市交通运输局运管科6', NULL, NULL, NULL, '', 3, '{}', 88),
(4521, 1015, 'F701774767189AB348256F4A000886D9', 57, 'sjtjygk7', '市交通运输局运管科7', NULL, NULL, NULL, '', 3, '{}', 88),
(4522, 1016, '632B0625FA1EE70B48256B380020E7ED', 118, 'sjtyhbgs', '市交通银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4523, 1017, '450BCA1636009886482572A4001BA496', 15, 'sjw10', '市纪委潘柏云', NULL, NULL, NULL, '', 3, '{}', 88),
(4524, 1018, '3E6874301DE882AC482572A4001BAA0B', 15, 'sjw11', '市纪委章坚', NULL, NULL, NULL, '', 3, '{}', 88),
(4525, 1019, 'C14930BFF6E974AA482572A4001BAF2F', 15, 'sjw12', '市纪委高慈波', NULL, NULL, NULL, '', 3, '{}', 88),
(4526, 1020, 'C546154C0EC88DA8482574C80025FA1A', 15, 'sjw13', '市纪委郑洁', NULL, NULL, NULL, '', 3, '{}', 88),
(4527, 1021, 'E93C268707166A62482574C800256FFC', 15, 'sjw14', '市纪委洪叶', NULL, NULL, NULL, '', 3, '{}', 88),
(4528, 1022, 'B858EF9D0330FDCB482574C8002578EA', 15, 'sjw15', '市纪委高建民', NULL, NULL, NULL, '', 3, '{}', 88),
(4529, 1023, 'DFCDA27BB2D6ECEC482574C800257F6C', 15, 'sjw16', '市纪委杨志宏', NULL, NULL, NULL, '', 3, '{}', 88),
(4530, 1024, '17861134B57F16A4482574C80025853A', 15, 'sjw17', '市纪委周小明', NULL, NULL, NULL, '', 3, '{}', 88),
(4531, 1025, '726D6FDEC8FE4CC4482574C800258EA3', 15, 'sjw18', '市纪委张挺松', NULL, NULL, NULL, '', 3, '{}', 88),
(4532, 1026, '05C890E42131EB36482574C800259517', 15, 'sjw19', '市纪委孙群辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4533, 1027, '7F1E16BAAD2932E3482574C800259A92', 15, 'sjw20', '市纪委周建校', NULL, NULL, NULL, '', 3, '{}', 88),
(4534, 1028, '091A189DA9FF868A482574C800259FC0', 15, 'sjw21', '市纪委林煊治', NULL, NULL, NULL, '', 3, '{}', 88),
(4535, 1029, '1E31359A8970942A482574C80025A76C', 15, 'sjw22', '市纪委罗益', NULL, NULL, NULL, '', 3, '{}', 88),
(4536, 1030, 'C7D71AAFEAFAEE71482574C80025AD15', 15, 'sjw23', '市纪委陈海军', NULL, NULL, NULL, '', 3, '{}', 88),
(4537, 1031, 'C78A663BF964E3E4482574C80025B1BB', 15, 'sjw24', '市纪委裘利惠', NULL, NULL, NULL, '', 3, '{}', 88),
(4538, 1032, 'A4FD2E6E15387561482574C80025B6CF', 15, 'sjw25', '市纪委胡军朝', NULL, NULL, NULL, '', 3, '{}', 88),
(4539, 1033, '2A74ACEF0FD02929482574C80025BD3A', 15, 'sjw26', '市纪委唐利平', NULL, NULL, NULL, '', 3, '{}', 88),
(4540, 1034, 'EC7306BED1201CF4482574C80025C51C', 15, 'sjw27', '市纪委周旭', NULL, NULL, NULL, '', 3, '{}', 88),
(4541, 1035, 'B672B940F77C5F66482574C80025CD20', 15, 'sjw28', '市纪委韩冲波', NULL, NULL, NULL, '', 3, '{}', 88),
(4542, 1036, '888194D471D5ED2B482574C80025D38D', 15, 'sjw29', '市纪委陆胜迪', NULL, NULL, NULL, '', 3, '{}', 88),
(4543, 1037, 'DBD6060B3B651FD7482574C80025DA4F', 15, 'sjw30', '市纪委宓碧辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4544, 1038, 'BB29E64500AD5EFC482574C80025E01D', 15, 'sjw31', '市纪委周立锋', NULL, NULL, NULL, '', 3, '{}', 88),
(4545, 1039, 'E9DA24367E024287482574C80025E654', 15, 'sjw32', '市纪委邵建育', NULL, NULL, NULL, '', 3, '{}', 88),
(4546, 1040, 'B51716C6674FB9B4482574C80025EB68', 15, 'sjw33', '市纪委胡崇波', NULL, NULL, NULL, '', 3, '{}', 88),
(4547, 1041, '90B0301FF5DDDC3D482574C80025F072', 15, 'sjw34', '市纪委岑圆圆', NULL, NULL, NULL, '', 3, '{}', 88),
(4548, 1042, '9A23067BCA477F04482574C80025F5E4', 15, 'sjw35', '市纪委张和君', NULL, NULL, NULL, '', 3, '{}', 88),
(4549, 1043, '01946931E0BD6058482572A4001B8192', 15, 'sjw4', '市纪委戚自军', NULL, NULL, NULL, '', 3, '{}', 88),
(4550, 1044, '13FE76DC19BC7D6D482572A4001B8820', 15, 'sjw5', '市纪委徐荷芬', NULL, NULL, NULL, '', 3, '{}', 88),
(4551, 1045, '62B51F8450373243482572A4001B8DBC', 15, 'sjw6', '市纪委毛巍', NULL, NULL, NULL, '', 3, '{}', 88),
(4552, 1046, '35D78E23CCBD0108482572A4001B92FD', 15, 'sjw7', '市监察局邹枫', NULL, NULL, NULL, '', 3, '{}', 88),
(4553, 1047, '443FA51162E2E7BD482572A4001B98AC', 15, 'sjw8', '市纪委张路', NULL, NULL, NULL, '', 3, '{}', 88),
(4554, 1048, '3310297A544297CF482572A4001B9F3C', 15, 'sjw9', '市纪委胡金泽', NULL, NULL, NULL, '', 3, '{}', 88),
(4555, 1049, '87A5958DB4F875DE48256C25002E0E9E', 15, 'sjwass', '市纪委案审室', NULL, NULL, NULL, '', 3, '{}', 88),
(4556, 1052, 'B1D17A614D2B58EB48256D3D00056BBA', 15, 'sjwcjs', '市纪委宣教室', NULL, NULL, NULL, '', 3, '{}', 88),
(4557, 1053, '7C5541069DD830F148256C25002E125D', 15, 'sjwdfs', '市纪委党风政风监督室', NULL, NULL, NULL, '', 3, '{}', 88),
(4558, 1054, '986EC03A8975478348256C25002E0322', 8, 'sjwfsj2', '市委办周国爱', NULL, NULL, NULL, '', 3, '{}', 88),
(4559, 1055, '7C25AFC6D391A24848257264001F9431', 15, 'sjwfsj3', '市纪委胡志安', NULL, NULL, NULL, '', 3, '{}', 88),
(4560, 1056, '39A30F6A16D850FF48256B380042E2AE', 15, 'sjwjcjbgs', '市纪委（监察局）办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4561, 1058, 'F9D071EF5846BDD048256C25002E1630', 15, 'sjwjfs', '市纪委纠风室', NULL, NULL, NULL, '', 3, '{}', 88),
(4562, 1059, '5552DFE1A39CBBCF48256C25002E06C2', 15, 'sjwjjs', '市纪委第一纪检室', NULL, NULL, NULL, '', 3, '{}', 88),
(4563, 1060, '4F53696E54C6E15C48256C25002E0AD0', 15, 'sjwxfs', '市纪委信访室', NULL, NULL, NULL, '', 3, '{}', 88),
(4564, 1062, '85627F29BA9462A348256BB50009CFC2', 45, 'sjxjdd', '市交警大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4565, 1063, '53AD0B30121928D348256FEB000DCACA', 43, 'sjyj1', '市教育局沈百宗', NULL, NULL, NULL, '', 3, '{}', 88),
(4566, 1064, 'C6DD18DE666A46E048256FEB000DD41C', 43, 'sjyj2', '市教育局沈乾苗', NULL, NULL, NULL, '', 3, '{}', 88),
(4567, 1065, 'ABFFF338AD6822DF48256FEB000DDD4F', 43, 'sjyj3', '市教育局张幸华', NULL, NULL, NULL, '', 3, '{}', 88),
(4568, 1066, '7C52305B627B8D9648256FEB000DED64', 43, 'sjyj4', '市教育局鲍旭明', NULL, NULL, NULL, '', 3, '{}', 88),
(4569, 1067, 'D0ECB5A9B7BC2EDF48256FEB000DF89C', 43, 'sjyj5', '市教育局彭飞龙', NULL, NULL, NULL, '', 3, '{}', 88),
(4570, 1068, 'B1B598A5EBB1D32D48256FFF00225E2B', 43, 'sjyj6', '市教育局孙剑波', NULL, NULL, NULL, '', 3, '{}', 88),
(4571, 1069, 'E4062AFD9DBB541F48257483000A6A8C', 43, 'sjyj7', '市教育局陈宗群', NULL, NULL, NULL, '', 3, '{}', 88),
(4572, 1070, 'FA406CDEB3D204C7482571B700103E51', 43, 'sjyjddk', '市教育局督导科', NULL, NULL, NULL, '', 3, '{}', 88),
(4573, 1071, '6BB6650F0B93E80F482571B700104D39', 43, 'sjyjgh', '市教育局工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4574, 1072, '9EB9FA12117BB035482574AB00080B83', 43, 'sjyjhjzx', '市教育局会计代理中心', NULL, NULL, NULL, '', 3, '{}', 88);
INSERT INTO `staff_tbl` (`staff_id`, `out_id`, `staff_unid`, `unit`, `staff_name`, `full_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`, `user_admin`, `reorder`) VALUES
(4575, 1073, 'FD4CE0EECA7204D948256FFF00226FFA', 43, 'sjyjjck', '市教育局计财科', NULL, NULL, NULL, '', 3, '{}', 88),
(4576, 1074, 'BF52D57736DCB483482574AB00081053', 43, 'sjyjjyfz', '市教育局教育发展公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4577, 1075, '58EBA79463949621482571B7001033A4', 43, 'sjyjpjk', '市教育局普教科', NULL, NULL, NULL, '', 3, '{}', 88),
(4578, 1076, '3ED99E5B984DBACA48256FFF0022682A', 43, 'sjyjrsk', '市教育局人事科', NULL, NULL, NULL, '', 3, '{}', 88),
(4579, 1077, '474488C282A84F5448256B3700296053', 89, 'sjyjyjbgs', '市检验检疫局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4580, 1078, '853C13527E275545482571B70010244F', 43, 'sjyjzcjk', '市教育局职成教科', NULL, NULL, NULL, '', 3, '{}', 88),
(4581, 1079, 'DC80AE8C81BD936F48257364000D57C3', 47, 'sjzglz', '市救助管理站', NULL, NULL, NULL, '', 3, '{}', 88),
(4582, 1080, '0563DE5B6F79BBBF482571CE000BDEAD', 6, 'skfqczj', '开发区陈宗军', NULL, NULL, NULL, '', 3, '{}', 88),
(4583, 1081, '0DD2C6D5E8D38382482573F600269ED9', 6, 'skfqfgm', '开发区房国明', NULL, NULL, NULL, '', 3, '{}', 88),
(4584, 1082, 'FDAF5BF6BD81DF27482575C1002549B2', 6, 'skfqggzy', '开发区管委会公共资源交易中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4585, 1083, '70EF6387DF2ABC7B4825731E0000B73B', 6, 'skfqgsfj', '开发区工商分局', NULL, NULL, NULL, '', 3, '{}', 88),
(4586, 1084, 'F5807B6EC4CB23FA4825731E0000D727', 6, 'skfqgsfjfjz', '开发区工商分局陈红梅', NULL, NULL, NULL, '', 3, '{}', 88),
(4587, 1085, '63F1DC7F4C42C9BD4825731E0000C617', 6, 'skfqgsfjjz', '开发区工商分局沈建光', NULL, NULL, NULL, '', 3, '{}', 88),
(4588, 1087, '9EF1E18E5DC277B3482571CE000BD11C', 6, 'skfqhzc', '开发区胡志冲', NULL, NULL, NULL, '', 3, '{}', 88),
(4589, 1088, '401A3976E1A0D2EB482571CE000BC3E4', 6, 'skfqlyf', '开发区陆益富', NULL, NULL, NULL, '', 3, '{}', 88),
(4590, 1089, '31A2320A90943A04482573F6002671A7', 6, 'skfqqqh', '开发区戚启华', NULL, NULL, NULL, '', 3, '{}', 88),
(4591, 1090, 'D99F004AAC7545244825719D000D1191', 6, 'skfqsgc', '开发区水管处', NULL, NULL, NULL, '', 3, '{}', 88),
(4592, 1091, '86730BDE2CFEAEFB482573F60026006D', 6, 'skfqsjg', '开发区沈建国', NULL, NULL, NULL, '', 3, '{}', 88),
(4593, 1092, 'C1D5AD3A65D1A3744825729D0021E3BE', 6, 'skfqwc', '开发区王程', NULL, NULL, NULL, '', 3, '{}', 88),
(4594, 1093, '703E19AA3CDF50B7482570F10023C955', 6, 'skfqxlx', '开发区夏利祥', NULL, NULL, NULL, '', 3, '{}', 88),
(4595, 1094, 'AAF3E6A5E56DB1C3482573F5001B7FE0', 6, 'skfqyb', '开发区于波', NULL, NULL, NULL, '', 3, '{}', 88),
(4596, 1095, '44A1F8B08973BDC14825759700107F95', 6, 'skfqzgh', '市开发区总工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4597, 1096, 'A3F13DFFDA34F1714825731A000212D3', 6, 'skfqzxh', '开发区周晓虹', NULL, NULL, NULL, '', 3, '{}', 88),
(4598, 1097, '371F96BA2740B633482571CB000A6CC3', 33, 'skfzx', '市残联组织康复部', NULL, NULL, NULL, '', 3, '{}', 88),
(4599, 1098, '6E39885C2AFBC4C74825745100224435', 8, 'skhb', '市考核办', NULL, NULL, NULL, '', 3, '{}', 88),
(4600, 1099, 'ACFBB49310AB893248256C54000F83DC', 51, 'skjhszx', '市国库支付中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4601, 1100, '8780E992DE313BEA482574AB003017C4', 44, 'skjj6', '市科技局黄国淼', NULL, NULL, NULL, '', 3, '{}', 88),
(4602, 1101, '18DD64B7E5206C72482573C000031103', 44, 'skjjdyys', '市科技局茅连行', NULL, NULL, NULL, '', 3, '{}', 88),
(4603, 1102, '463B3F66714ACC6048256C30002FA0E3', 44, 'skjjghk', '市科技局计划科', NULL, NULL, NULL, '', 3, '{}', 88),
(4604, 1103, '44F7D11D45E234EA48256C30002F8253', 44, 'skjjjzs1', '市科技局霍建君', NULL, NULL, NULL, '', 3, '{}', 88),
(4605, 1104, '10FB9925F13EB10948256C30002F8751', 44, 'skjjjzs2', '市科技局周百荣', NULL, NULL, NULL, '', 3, '{}', 88),
(4606, 1105, '82CB005D094F03DC48256C30002F8BA0', 44, 'skjjjzs3', '市科技局许登坤', NULL, NULL, NULL, '', 3, '{}', 88),
(4607, 1106, 'BE024EEAC36B2FC348256C30002F8FE2', 44, 'skjjjzs4', '市科技局徐裔君', NULL, NULL, NULL, '', 3, '{}', 88),
(4608, 1107, 'A9F7867F79BF561648256D05000AD97F', 44, 'skjjjzs5', '市科技局孙灿华', NULL, NULL, NULL, '', 3, '{}', 88),
(4609, 1108, '2B413DB480670C6A48256F1200011C5D', 44, 'skjjkjs', '市科技局会计室', NULL, NULL, NULL, '', 3, '{}', 88),
(4610, 1109, '92D40A681AE921A248256D6A0002B4A0', 44, 'skjjsmzx', '市科技局农业和社会发展科技科', NULL, NULL, NULL, '', 3, '{}', 88),
(4611, 1111, '53D7B68D4F9D076E48256C30002FA90E', 44, 'skjjtgzx', '市科技局推广中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4612, 1113, '9885A0633DC0815548256C30002FA4F3', 44, 'skjjzlk', '市科技局专利与合作科', NULL, NULL, NULL, '', 3, '{}', 88),
(4613, 1114, '196EEBE88465475C48256B37001EAFD4', 44, 'skwbgs', '市科技局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4614, 1115, '7FF27FEB2016F2C248256BE200315D81', 34, 'skx', '市科协', NULL, NULL, NULL, '', 3, '{}', 88),
(4615, 1116, '9BB4B901A57EEC1248257042002B8553', 34, 'skx1', '市科协李森龙', NULL, NULL, NULL, '', 3, '{}', 88),
(4616, 1117, 'B2401E3BD6836B8F48257042002B8E2C', 34, 'skx2', '市科协宓维郎', NULL, NULL, NULL, '', 3, '{}', 88),
(4617, 1118, 'F3E99F2BDE358F9448257042002B9740', 34, 'skx3', '市科协虞科娜', NULL, NULL, NULL, '', 3, '{}', 88),
(4618, 1119, '8C5C8F15709C0EE2482573630008EE30', 34, 'skx4', '市科协方若波', NULL, NULL, NULL, '', 3, '{}', 88),
(4619, 1120, '3A99CE77DFEE5DA14825759B00288684', 34, 'skx5', '市科协冯昭辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4620, 1121, 'EC1E03F86B0C4AA34825723A0010E94C', 34, 'skxbgs', '市科协', NULL, NULL, NULL, '', 3, '{}', 88),
(4621, 1122, '8E47DBF4E8F7247648257042002B6E35', 34, 'skxkp', '市科协科普', NULL, NULL, NULL, '', 3, '{}', 88),
(4622, 1123, '74825761E383377248256C30002FC877', 34, 'skxmsz', '市科协秘书长', NULL, NULL, NULL, '', 3, '{}', 88),
(4623, 1124, '9CE3D63F143A5D2B48257042002B7B03', 34, 'skxxh', '市科协学会', NULL, NULL, NULL, '', 3, '{}', 88),
(4624, 1125, '1DE7BBF1464BECCB48256F4A00092C1D', 57, 'skyzx', '市交通运输局客运中心有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4625, 1133, '9795586ACAC78D2748256B3700274F71', 53, 'sldjbgs', '市人力社保局办公室1', NULL, NULL, NULL, '', 3, '{}', 88),
(4626, 1134, '8DDE58EF53731D2348256EA5001100CF', 53, 'sldjbgs1', '市人力社保局办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(4627, 1135, 'C48BAC01DFF6A5DD48256EA5001105C7', 53, 'sldjbgs2', '市人力社保局办公室3', NULL, NULL, NULL, '', 3, '{}', 88),
(4628, 1136, 'BF869CB3331F1A8948256EA500110AAC', 53, 'sldjbgs3', '市人力社保局办公室4', NULL, NULL, NULL, '', 3, '{}', 88),
(4629, 1138, '308BBBA81C317D3B48256F5500303743', 53, 'sldjdwwy', '市人力社保局王焕银', NULL, NULL, NULL, '', 3, '{}', 88),
(4630, 1139, 'DE225F3AC1054AD248256CED002E755F', 53, 'sldjdyy1', '市人力社保局岑华权', NULL, NULL, NULL, '', 3, '{}', 88),
(4631, 1141, '0615545A8D1AECED48256C23001D7293', 53, 'sldjfgk', '市人力社保局政策法规科', NULL, NULL, NULL, '', 3, '{}', 88),
(4632, 1143, 'CAFED92EAD8DC5F848256EA500112985', 53, 'sldjjcdd', '市劳动监察大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4633, 1144, '38758D7537E7093E48256EA600227FD1', 53, 'sldjjyc', '市就业处', NULL, NULL, NULL, '', 3, '{}', 88),
(4634, 1145, 'CE3F3EE130A4FAA548256C23001E4ED5', 53, 'sldjjyk', '市人力社保局就业和职业能力建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(4635, 1147, 'FF832CAE95C3783648256CED002E63DA', 53, 'sldjjzs1', '市人力社保局周干尔', NULL, NULL, NULL, '', 3, '{}', 88),
(4636, 1149, 'AA4AF6ACF880640C48256CED002E6D01', 53, 'sldjjzs3', '市人力社保局虞骏', NULL, NULL, NULL, '', 3, '{}', 88),
(4637, 1151, 'C7E07DBF330723D648256D030024DDE9', 53, 'sldjjzs5', '市人力社保局陈泽辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4638, 1153, 'B8B535716CF7BD9348256EA50011250A', 53, 'sldjpxz', '市鉴定中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4639, 1154, '07782A1FCE513B7648256EA500112065', 53, 'sldjsbc', '市社保处', NULL, NULL, NULL, '', 3, '{}', 88),
(4640, 1155, '22DA59485C247EE848256CCD001CBB61', 53, 'sldjsfs', '市人力社保局办公室发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4641, 1156, '8BF11AA6642F19E54825744100037140', 53, 'sldjtzb', '市人力社保局统征办', NULL, NULL, NULL, '', 3, '{}', 88),
(4642, 1157, '76F20B9C94782B8548257424000FD333', 53, 'sldjxxb', '局窗口信息中心（社保卡中心）', NULL, NULL, NULL, '', 3, '{}', 88),
(4643, 1158, 'CD33657A44C6E18B4825745C000AB052', 53, 'sldjxzsp', '市人力社保局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(4644, 1159, '3CA87210C6D4CCC348256C23001EFE41', 53, 'sldjylk', '市人力社保局社会保险科', NULL, NULL, NULL, '', 3, '{}', 88),
(4645, 1162, 'F6D8F736098B4BA848256C23001DE9F2', 53, 'sldjzck', '市劳动人事仲裁院', NULL, NULL, NULL, '', 3, '{}', 88),
(4646, 1165, '3CB39086BDBF194B48256E4A0005E5C3', 24, 'slgbhds', '市老干部活动中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4647, 1166, '682A2AE64D98280E482572CC002AF407', 59, 'slhskglc', '市上林湖水库管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(4648, 1167, '2DB0213EB3ACB88648256B7D004426C6', 49, 'sllw', '市老龄委（办）办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4649, 1168, '942821EA74B0954548257363002CD2D4', 49, 'sllw1', '市老龄委(办)老年活动中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4650, 1169, 'CF9203E4FC26895248257364000DFFEF', 47, 'slngy', '市老年公寓', NULL, NULL, NULL, '', 3, '{}', 88),
(4651, 1170, '19B48245A913370748257364000E4AF8', 47, 'slnhdzx', '市老年活动中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4652, 1171, 'D28E21E77F805E48482573D900249462', 142, 'slnrtx', '市老年人体育协会', NULL, NULL, NULL, '', 3, '{}', 88),
(4653, 1172, 'DD1BFC511D6F130E48256B37001BBFD0', 76, 'slpzxbgs', '市行政服务中心综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4654, 1173, '303A6241ABD0BDF948256B37001EC60B', 0, 'slqbbgs', '市老区办办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4655, 1174, '45162D1EE672F97A48257364001B9599', 47, 'slrgy', '市老人公寓', NULL, NULL, NULL, '', 3, '{}', 88),
(4656, 1175, '69863B80A4AF6BC44825722F000FF836', 0, 'slsjszx', '市粮食结算中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4657, 1176, '0CAE2550F715D62B48256CE5002D06CE', 74, 'slyjjzs1', '市旅游局王小平', NULL, NULL, NULL, '', 3, '{}', 88),
(4658, 1177, 'E166B9C65E9DDD4748256CE5002D0B47', 74, 'slyjjzs2', '市旅游局韩曙红', NULL, NULL, NULL, '', 3, '{}', 88),
(4659, 1178, '42F9F35B190D669D48256CE5002D0FC1', 74, 'slyjjzs3', '市旅游局方丽川', NULL, NULL, NULL, '', 3, '{}', 88),
(4660, 1179, 'D37E74214A7A080748256D0B000242C4', 74, 'slyjjzs4', '市旅游局周铁军', NULL, NULL, NULL, '', 3, '{}', 88),
(4661, 1180, '15C7DCC48164DDB94825733700092218', 74, 'slyjjzs5', '市旅游局应国浩', NULL, NULL, NULL, '', 3, '{}', 88),
(4662, 1181, '425E0BB2E8BDC9024825735B0002EBDC', 74, 'slyjsdb', '市旅游局旅游信息咨询中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4663, 1182, '3E754A36480E25A5482573370009B411', 74, 'slyjtgzx', '市旅游局市场开发科', NULL, NULL, NULL, '', 3, '{}', 88),
(4664, 1183, '244DA6A36AEB9512482573FA000A5A96', 20, 'slylb', '市委防范处理邪教办', NULL, NULL, NULL, '', 3, '{}', 88),
(4665, 1184, '2610E7300608513148256D4700262D7B', 47, 'smgb', '市民管办', NULL, NULL, NULL, '', 3, '{}', 88),
(4666, 1185, '4814C680DA19F7E4482575A70007E22D', 98, 'smhfjq1', '市鸣鹤风景区开发建设办黄磊', NULL, NULL, NULL, '', 3, '{}', 88),
(4667, 1186, 'FAAA78D713E76893482575A70007EC2B', 98, 'smhfjq2', '市鸣鹤风景区开发建设办陈周', NULL, NULL, NULL, '', 3, '{}', 88),
(4668, 1187, 'B252F659E26990CB482575A7000801BA', 98, 'smhfjqghk', '市鸣鹤风景区开发建设办规划建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(4669, 1188, '508777602C70EE6A482575A700080A9B', 98, 'smhfjqtzgs', '市鸣鹤风景区开发建设办五磊山景区投资公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4670, 1189, 'ABAA7E05E1660FB1482575A70007F5F1', 98, 'smhfjqzhk', '市鸣鹤风景区开发建设办综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4671, 1190, '50C8C373E371A8C148256B7D0043CC1C', 0, 'smj', '市民建', NULL, NULL, NULL, '', 3, '{}', 88),
(4672, 1192, '3F6AFFD82248EEA148256FE100037BE8', 60, 'smljrs', '市商务局人事', NULL, NULL, NULL, '', 3, '{}', 88),
(4673, 1196, 'A07FE9CB9C0BBFE648256B7D0043CA33', 18, 'smm', '市民盟', NULL, NULL, NULL, '', 3, '{}', 88),
(4674, 1197, '7CC73279EBCE79F64825735D00099CFA', 126, 'smsyhbgs', '市民生银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4675, 1198, '6E4E97CAA0195F1C482571B700107FEB', 60, 'smylsj1', '市商务局胡东奋', NULL, NULL, NULL, '', 3, '{}', 88),
(4676, 1199, '5A867EBF136549E7482571B700108BB6', 60, 'smylsj2', '市商务局陈福根', NULL, NULL, NULL, '', 3, '{}', 88),
(4677, 1201, '85CB89DD8933606A482573390034F8DF', 60, 'smylsj4', '市商务局童丹霞', NULL, NULL, NULL, '', 3, '{}', 88),
(4678, 1202, '73FA0549443B7B384825733900351E08', 60, 'smylsj5', '市商务局陆晓昕', NULL, NULL, NULL, '', 3, '{}', 88),
(4679, 1203, 'F4A2DD1D662D890F4825750E0002C0C9', 60, 'smylsj6', '市商务局杨新华', NULL, NULL, NULL, '', 3, '{}', 88),
(4680, 1204, '5212328502635BB448256B7D0044A15C', 60, 'smylsjbgs', '市商务局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4681, 1205, 'A98C5A59EF1931A148256FBD00080E3B', 60, 'smylsjcw', '市商务局财务', NULL, NULL, NULL, '', 3, '{}', 88),
(4682, 1207, '7D0272EFD119D34448256C43000B87F6', 60, 'smylsjhyk', '市商务局行业管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4683, 1208, 'B05C22969461F85848256C43000A5457', 60, 'smylsjjzs1', '市商务局宋向阳', NULL, NULL, NULL, '', 3, '{}', 88),
(4684, 1210, '8648395C01E8B44748256C43000A5D99', 60, 'smylsjjzs3', '市商务局柴伟源', NULL, NULL, NULL, '', 3, '{}', 88),
(4685, 1211, '079D1A14E7C767D448256C43000B8C43', 60, 'smylsjlsk', '市商务局粮食管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4686, 1212, 'F9DFFB31D1BC448448256C43000B8395', 60, 'smylsjmyk', '市商务局贸易市场科', NULL, NULL, NULL, '', 3, '{}', 88),
(4687, 1214, '6B01508D26A7866848256C43000B9510', 60, 'smylsjwys1', '市商务局陈立江', NULL, NULL, NULL, '', 3, '{}', 88),
(4688, 1215, 'EA14AC631889E9FF48256C43000B9D32', 60, 'smylsjwys3', '市商务局岑夏君', NULL, NULL, NULL, '', 3, '{}', 88),
(4689, 1216, 'A6BAB429BA687F2F48256D420007C0B3', 47, 'smzgygs', '市社会福利企业管理办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4690, 1217, '0B6F1866237725ED48256D420007A514', 47, 'smzjazk', '市民政局优抚安置科', NULL, NULL, NULL, '', 3, '{}', 88),
(4691, 1218, '945548FE342242D648256B37001EB6FE', 47, 'smzjbgs', '市民政局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4692, 1219, 'C165CFB3E04642E548256D420007A0F0', 47, 'smzjcws', '市民政局财务室', NULL, NULL, NULL, '', 3, '{}', 88),
(4693, 1220, '9D0714FA26C90A0D48256D4200079562', 47, 'smzjdyy1', '市民政局陆国华', NULL, NULL, NULL, '', 3, '{}', 88),
(4694, 1221, 'E5AD5DFC9416F8AE48256D4200079952', 47, 'smzjdyy2', '市民政局周光华', NULL, NULL, NULL, '', 3, '{}', 88),
(4695, 1222, '63CDEE391A6136D248256D420007A8E0', 47, 'smzjjjk', '市民政局救灾救济科', NULL, NULL, NULL, '', 3, '{}', 88),
(4696, 1223, '280D18223A800568482572B400200D88', 47, 'smzjjz', '市民政局陈志浩', NULL, NULL, NULL, '', 3, '{}', 88),
(4697, 1224, '616C1A0A0A8CD0914825734D000400A1', 47, 'smzjjz2', '市民政局陈亚敏', NULL, NULL, NULL, '', 3, '{}', 88),
(4698, 1225, '7EAA9E6F4BDB5005482575280008A5E4', 47, 'smzjjz3', '市民政局严乃国', NULL, NULL, NULL, '', 3, '{}', 88),
(4699, 1226, '1EC713904526B74A4825757E002260EF', 47, 'smzjsbgm', '三北公墓', NULL, NULL, NULL, '', 3, '{}', 88),
(4700, 1228, 'B9AEBC9973D539C448256D420007ACC2', 47, 'smzjswk', '市民政局社会事务科', NULL, NULL, NULL, '', 3, '{}', 88),
(4701, 1229, '3ED81E78E5A6C8C54825758A000E1912', 47, 'smzjxfb', '市民政局信访办', NULL, NULL, NULL, '', 3, '{}', 88),
(4702, 1231, '777D28B3444B36FF48256D420007B8C0', 47, 'smzjzqk', '市民政局基层政权科', NULL, NULL, NULL, '', 3, '{}', 88),
(4703, 1232, 'AA1E032E062789B348256B380042EA86', 19, 'smzzjjbgs', '市民族宗教局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4704, 1235, 'F354438333E24C9E48256EC30008734B', 19, 'smzzjjjz', '民族宗教局局长', NULL, NULL, NULL, '', 3, '{}', 88),
(4705, 1236, '3D90C4BB95C12DAF482572D70012FF12', 22, 'snbncfzk', '市农办农村发展科', NULL, NULL, NULL, '', 3, '{}', 88),
(4706, 1237, '57276308ECEEE08B482572D7001309CE', 22, 'snbncjsk', '市农办农村建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(4707, 1238, '65A9635EDFEC783D482572D70012F0C5', 22, 'snbzhdyk', '市农办综合调研科', NULL, NULL, NULL, '', 3, '{}', 88),
(4708, 1239, 'DF182E7A3D8CECCD48256B380020CCBF', 116, 'snfyhbgs', '市农发银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4709, 1240, '35E4C6A00810BBF948256B3800203AD1', 0, 'snjwbgs', '市农经委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4710, 1241, '4A951B4F7A3C29D748256B3800206211', 73, 'snjzzbgs', '市农机局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4711, 1242, '9C6329418AD7F1D4482571410003595B', 39, 'snpb', '市农普办', NULL, NULL, NULL, '', 3, '{}', 88),
(4712, 1243, 'E1D6E28BCC7BF45C48256B380020450D', 58, 'snyjbgs', '市农业局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4713, 1244, '7BEE40995529A97A48257442002820D1', 58, 'snyjcyk', '市农业局产业科', NULL, NULL, NULL, '', 3, '{}', 88),
(4714, 1245, 'C8CC70C3157746DE48257442002835A3', 58, 'snyjfgk', '市农业局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(4715, 1246, '93138509AE3FE9D948256CBB00203301', 58, 'snyjfsjs', '市农业局张明', NULL, NULL, NULL, '', 3, '{}', 88),
(4716, 1247, '4963E15D145C6520482574420028B50F', 58, 'snyjjczx', '市农业局监测中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4717, 1248, '1A9F330FBC7C63FA48256DBB00234F25', 58, 'snyjjgk', '市农业局经营管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4718, 1249, '0B879CE5436F571248256CBB00202ED6', 58, 'snyjjzs1', '市农业局袁汉岳', NULL, NULL, NULL, '', 3, '{}', 88),
(4719, 1250, '29479717FCFD4D4648256CBB0020371C', 58, 'snyjjzs2', '市农业局岑伯明', NULL, NULL, NULL, '', 3, '{}', 88),
(4720, 1251, '721A730C5A7D47BD48256CBB00203B39', 58, 'snyjjzs3', '市农业局诸永高', NULL, NULL, NULL, '', 3, '{}', 88),
(4721, 1252, '2CCEA54B506542A248256CBB00203EF7', 58, 'snyjjzs4', '市农业局段明权', NULL, NULL, NULL, '', 3, '{}', 88),
(4722, 1253, '68A639311FBBD59C48257338002BC0C7', 58, 'snyjjzs5', '市农业局方云华', NULL, NULL, NULL, '', 3, '{}', 88),
(4723, 1254, '64AAF7843DC5B91048256CBB0020470B', 58, 'snyjkjs', '市农业局资金项目科', NULL, NULL, NULL, '', 3, '{}', 88),
(4724, 1255, 'CC02C25518544ACB482574420028DA47', 58, 'snyjltzx', '市农业局林特中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4725, 1256, 'A4B1794F7660FE154825744200284F59', 58, 'snyjlyk', '市农业局林业科', NULL, NULL, NULL, '', 3, '{}', 88),
(4726, 1257, '7F22930510FFAB67482574420028A30C', 58, 'snyjnjzx', '市农业局农技中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4727, 1258, '525C4E3C2C7F4F024825744200290684', 58, 'snyjnks', '市农业局农科所', NULL, NULL, NULL, '', 3, '{}', 88),
(4728, 1259, '8B7F1A8BD36EDEB2482571DB000CB916', 58, 'snyjrskj', '市农业局人事科教科', NULL, NULL, NULL, '', 3, '{}', 88),
(4729, 1260, 'A83E7B14E45EE782482574420028F1CD', 58, 'snyjsczx', '市农业局水产中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4730, 1261, '812FA6B013E9256848256CBB002042EA', 58, 'snyjwy1', '市农业局陈旭君', NULL, NULL, NULL, '', 3, '{}', 88),
(4731, 1262, '916EAA0E4C343F97482574420028C916', 58, 'snyjxmzx', '市农业局畜牧兽医站', NULL, NULL, NULL, '', 3, '{}', 88),
(4732, 1263, 'D64D49CC9988BB72482571DB000CAE64', 58, 'snyjxtq', '市农业局徐桐琦', NULL, NULL, NULL, '', 3, '{}', 88),
(4733, 1264, '8D8C55BBE42E94A5482574180023B207', 58, 'snyjxxk', '市农业局信息科', NULL, NULL, NULL, '', 3, '{}', 88),
(4734, 1265, 'DD5EC6F7440B9A184825744200287E99', 58, 'snyjxxzx', '市农业局信息中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4735, 1266, '1684A24EDB5A0A8148257442002869ED', 58, 'snyjyyk', '市农业局海洋渔业科', NULL, NULL, NULL, '', 3, '{}', 88),
(4736, 1267, '77ACEA67B27654384825744200289395', 58, 'snyjzfdd', '市农业局执法大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4737, 1268, '73F3A71853BAFF5248256B380020CB43', 115, 'snyyhbgs', '市农业银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4738, 1270, '92C29898E4677EB448256F5D00215AA5', 20, 'spab', '市平安办', NULL, NULL, NULL, '', 3, '{}', 88),
(4739, 1271, 'AF27B8FF338D56F8482572F40009E51E', 194, 'spsgs', '市排水有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4740, 1272, '74A0E4968881C121482575230008A10D', 18, 'sqb1', '市侨办童建聪', NULL, NULL, NULL, '', 3, '{}', 88),
(4741, 1273, '4CAFF9FA28FA2455482575230008A792', 18, 'sqb2', '市台办陈益萍', NULL, NULL, NULL, '', 3, '{}', 88),
(4742, 1274, '4E98AD4BDB5779CB4825756F000AC8F1', 45, 'sqbafwb', '市社区保安服务办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4743, 1275, 'F021C16FF449DDEE48256B380042E962', 18, 'sqbbgs', '市侨办', NULL, NULL, NULL, '', 3, '{}', 88),
(4744, 1276, 'B181BC5A09B7D45F482572BB0020D8A9', 18, 'sqbzr', '市侨办主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4745, 1278, 'F9AFDFB2CA61C75D48256FBD00230BA7', 30, 'sqsng', '市青少年宫', NULL, NULL, NULL, '', 3, '{}', 88),
(4746, 1279, '531FE076D507321F48256B410003DDDF', 86, 'sqxjbgs', '市气象局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4747, 1280, '775376D1C7C5502748256EED0027AF80', 133, 'srbgsbgs', '市人保公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4748, 1281, 'A7299B9ED2F797F048256EDD00127549', 9, 'srdb1', '市人大办陈新昌', NULL, NULL, NULL, '', 3, '{}', 88),
(4749, 1282, '5F7743366122631E48256EDD0012E5A8', 9, 'srdb10', '城环工委谢小枫', NULL, NULL, NULL, '', 3, '{}', 88),
(4750, 1283, 'FB8E69FBE8B3DCEF48256EDD0012F08A', 9, 'srdb11', '市人大办陈通洋', NULL, NULL, NULL, '', 3, '{}', 88),
(4751, 1284, '84C5A499E990C12348256EDD0012FBB1', 9, 'srdb12', '市人大办岑小萍', NULL, NULL, NULL, '', 3, '{}', 88),
(4752, 1285, '0ED47EAE4BB0B13548256EDD00133399', 9, 'srdb13', '市人大办熊一鸣', NULL, NULL, NULL, '', 3, '{}', 88),
(4753, 1286, 'F233110DD505546948256EDD00133EE7', 9, 'srdb14', '代表工委张建程', NULL, NULL, NULL, '', 3, '{}', 88),
(4754, 1287, '3BD4ECB6F0E400C048256EDD001348D2', 9, 'srdb15', '市人大办黄佰银', NULL, NULL, NULL, '', 3, '{}', 88),
(4755, 1288, 'A452BBAE09D1FFC848256EDD001351CE', 9, 'srdb16', '市人大办王骏琪', NULL, NULL, NULL, '', 3, '{}', 88),
(4756, 1289, 'A8EC97D4FD967B8A48256EDD00135BA7', 9, 'srdb17', '法工委杜贤屹', NULL, NULL, NULL, '', 3, '{}', 88),
(4757, 1290, 'BA99712CDABD548248256EDD00136714', 9, 'srdb18', '农业农村工委蔡建峰', NULL, NULL, NULL, '', 3, '{}', 88),
(4758, 1292, 'B90A6FCF50322BEE48256EDD001281CF', 9, 'srdb2', '财经工委齐建明', NULL, NULL, NULL, '', 3, '{}', 88),
(4759, 1293, 'DDF200F36B2F02F848256EDD00138499', 9, 'srdb21', '市人大办黄文学', NULL, NULL, NULL, '', 3, '{}', 88),
(4760, 1294, '88D7C4E4B4B6F05748256EDD00138DFB', 9, 'srdb22', '市人大办施伯尧', NULL, NULL, NULL, '', 3, '{}', 88),
(4761, 1295, 'C131AA7F08F1BC2748256EDD00139721', 9, 'srdb23', '市人大办黄成汉', NULL, NULL, NULL, '', 3, '{}', 88),
(4762, 1297, 'B29F2DEA9885472F48256EDD0013BB61', 9, 'srdb25', '市人大办陆慧珊', NULL, NULL, NULL, '', 3, '{}', 88),
(4763, 1298, '48DD7C7C5B4964F048256EDD0013C591', 9, 'srdb26', '市人大办潘爱军', NULL, NULL, NULL, '', 3, '{}', 88),
(4764, 1299, 'B1C511D58441178548256FFB00243208', 9, 'srdb28', '农业农村工委杨儿', NULL, NULL, NULL, '', 3, '{}', 88),
(4765, 1300, '37DD132D19EEC1E9482571B60005EC3B', 9, 'srdb29', '市人大办陈佳远', NULL, NULL, NULL, '', 3, '{}', 88),
(4766, 1301, '5857F4161865E32048256EDD0012930F', 9, 'srdb3', '市人大办杨继辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4767, 1302, '3ACF89C19BF67615482571B60005FE20', 9, 'srdb30', '教科文卫工委康华君', NULL, NULL, NULL, '', 3, '{}', 88),
(4768, 1303, '6FF1CEDCDF4F920348256EDD00129DE3', 9, 'srdb4', '市人大办杨丽琼', NULL, NULL, NULL, '', 3, '{}', 88),
(4769, 1304, 'C7A4F1E931B02F3348256EDD0012A7EA', 9, 'srdb5', '法工委陆漫', NULL, NULL, NULL, '', 3, '{}', 88),
(4770, 1305, '0545F72662E9CA8148256EDD0012B3E7', 9, 'srdb6', '城环工委王耀学', NULL, NULL, NULL, '', 3, '{}', 88),
(4771, 1306, '527A17D304E4218948256EDD0012C203', 9, 'srdb7', '教科文卫工委�{近茂', NULL, NULL, NULL, '', 3, '{}', 88),
(4772, 1307, 'C991B932232A7DA548256EDD0012D130', 9, 'srdb8', '代表工委孙杰', NULL, NULL, NULL, '', 3, '{}', 88),
(4773, 1308, '5A8F981D784F095548256EDD0012DA86', 9, 'srdb9', '财经工委赵银开', NULL, NULL, NULL, '', 3, '{}', 88),
(4774, 1309, 'C00A3FF08651F61A48256D02000D23EB', 9, 'srdbbgs2', '市人大办办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(4775, 1310, '90EB4B4A28683FE348256E45002941CD', 9, 'srdbbgs3', '市人大办办公室3', NULL, NULL, NULL, '', 3, '{}', 88),
(4776, 1311, '26C96D2D09B615E848256B380042E423', 9, 'srdbsfs', '市人大办收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(4777, 1312, 'C4D83D4C25B3A98648256B90000A2E78', 9, 'srdbxfk', '市人大办信访科', NULL, NULL, NULL, '', 3, '{}', 88),
(4778, 1313, '26AF94E88F88919B48256B90000A2C0F', 9, 'srdbzhk', '市人大办综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4779, 1315, '4818665C4EA0F94948256B90000A1594', 9, 'srdcjgw', '市人大财经工委', NULL, NULL, NULL, '', 3, '{}', 88),
(4780, 1316, '43E5F7C61611B1A748256B90000A1362', 9, 'srddgw', '市人大代工委', NULL, NULL, NULL, '', 3, '{}', 88),
(4781, 1317, 'F35EDA5D9C84B38448256B90000A19AD', 9, 'srdfgw', '市人大法工委', NULL, NULL, NULL, '', 3, '{}', 88),
(4782, 1318, 'AFD737944547931348256B35000530D6', 3, 'srdfws', '市人大发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4783, 1319, 'D2D047323D9D4744482572830008B5D7', 3, 'srdgjc', '市人大龚建长', NULL, NULL, NULL, '', 3, '{}', 88),
(4784, 1320, '51B2F176DDBE6EA1482572830008E0C3', 3, 'srdhbs', '市人大黄柏寿', NULL, NULL, NULL, '', 3, '{}', 88),
(4785, 1321, '0F5D29897551B0FA482572830008ABB1', 3, 'srdhjj', '市人大黄建钧', NULL, NULL, NULL, '', 3, '{}', 88),
(4786, 1322, '5D251EA010AE3CAB48256B90000A1792', 9, 'srdjkgw', '市人大教科工委', NULL, NULL, NULL, '', 3, '{}', 88),
(4787, 1325, '1C9B28D21FC4F71A48256B7D00444CEC', 0, 'srfb', '市人防办', NULL, NULL, NULL, '', 3, '{}', 88),
(4788, 1326, 'E277560F98D619DA48256B380020C892', 93, 'srmyhbgs', '市人民银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4789, 1327, 'BB8B6E3699080C5D48256B38002111EC', 134, 'srsgsbgs', '市人寿公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4790, 1344, '1C52173AE68EC16448256B380041DE17', 7, 'srwbbgs', '市人武部办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4791, 1345, '74AA77D4A06F4C35482573950000DC06', 7, 'srwbzbb', '市人武部征兵办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4792, 1346, '3E991EA07CBB2D47482571BD002AF473', 105, 'ssab', '市食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(4793, 1347, '3E31CF8C27A5B1C548256B7D0049EBFC', 52, 'ssbb', '市社保办', NULL, NULL, NULL, '', 3, '{}', 88),
(4794, 1348, 'BD7400FE2923B71448256F4A000952EE', 57, 'ssbczqcgs', '市交通运输局三北出租汽车公司', NULL, NULL, NULL, '', 3, '{}', 88),
(4795, 1349, 'D780B0469FC135A348256B3800205312', 0, 'sscjbgs', '市水产局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4796, 1350, '8CBE7D0480F8B0EC48256F9A0020F84C', 44, 'ssclcjzx', '市科技局生产力促进中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4797, 1351, '8626461F0419C4EB48256E9A002FEA80', 50, 'ssfj148', '市司法局148', NULL, NULL, NULL, '', 3, '{}', 88),
(4798, 1352, 'E9843608DA4FFB5E48256B3700261149', 50, 'ssfjbgs', '市司法局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4799, 1353, '79DF79F22D19367E48256E9A002FE56A', 50, 'ssfjcks', '市司法局财会室', NULL, NULL, NULL, '', 3, '{}', 88),
(4800, 1355, '27DEDCD89BB5EAA648256E9A002FDC6E', 50, 'ssfjfgk', '市司法局法管科', NULL, NULL, NULL, '', 3, '{}', 88),
(4801, 1356, '4D9C12BB68B72D4648257487000FB808', 50, 'ssfjgz', '市司法局句章律师事务所', NULL, NULL, NULL, '', 3, '{}', 88),
(4802, 1357, '27111D25248F01FC48256E9A002FEECA', 50, 'ssfjgzc', '市司法局公证处', NULL, NULL, NULL, '', 3, '{}', 88),
(4803, 1358, '205E3CE4DA2ACB2348256E9A002FD369', 50, 'ssfjjck', '市司法局基层科', NULL, NULL, NULL, '', 3, '{}', 88),
(4804, 1359, 'CDA2B56A6F0080D148256F9E002B62CE', 50, 'ssfjjz1', '市司法局叶芳', NULL, NULL, NULL, '', 3, '{}', 88),
(4805, 1360, '1972ABB2C7BB494B48256F9E002B6DF8', 50, 'ssfjjz2', '市司法局邹枫', NULL, NULL, NULL, '', 3, '{}', 88),
(4806, 1361, '4508F6704FD0B0E648256F9E002B76CA', 50, 'ssfjjz3', '市司法局宋烈辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4807, 1362, '21FE8049DF59A78E48256F9E002B81EA', 50, 'ssfjjz4', '市司法局施军岳', NULL, NULL, NULL, '', 3, '{}', 88),
(4808, 1363, '96DA4100806A54EF4825759A000DD784', 50, 'ssfjjz5', '市司法局吴晓云', NULL, NULL, NULL, '', 3, '{}', 88),
(4809, 1364, '94445DF8A8B88D9448256E9A002FE0FC', 50, 'ssfjmss', '市司法局秘书室', NULL, NULL, NULL, '', 3, '{}', 88),
(4810, 1365, '203D59DA8BB2FFF0482572C8000705F2', 50, 'ssfjsqjz', '市司法局社区矫正科', NULL, NULL, NULL, '', 3, '{}', 88),
(4811, 1366, '5F20170A1EA1489F48256E9A002FD840', 50, 'ssfjxjk', '市司法局宣教科', NULL, NULL, NULL, '', 3, '{}', 88),
(4812, 1368, '3442E915319C096948256EA6002BC06A', 124, 'ssfyybgs', '市深发银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4813, 1369, 'F335B014D136935748257364000E2115', 47, 'sshfly', '市社会福利院', NULL, NULL, NULL, '', 3, '{}', 88),
(4814, 1370, 'CECF3B2EA8F977D948256B37001EB8A1', 65, 'ssjjbgs', '市审计局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4815, 1371, 'F14116E1224158CE48256C300028F779', 65, 'ssjjbgs2', '市审计局宣敖军', NULL, NULL, NULL, '', 3, '{}', 88),
(4816, 1372, '449A271B7A48BA7548256C300028FD55', 65, 'ssjjbgs3', '市审计局黄 尔', NULL, NULL, NULL, '', 3, '{}', 88),
(4817, 1373, '33B723864AA654F648256C3000290366', 65, 'ssjjbgs4', '市审计局黄君央', NULL, NULL, NULL, '', 3, '{}', 88),
(4818, 1374, '86B08A8CB071BBFE48256FE2000F0C98', 65, 'ssjjbgs5', '市审计局陈洁', NULL, NULL, NULL, '', 3, '{}', 88),
(4819, 1375, '69F5A8BFE8722D41482570C900263AB0', 65, 'ssjjbgs6', '市审计局姚燕青', NULL, NULL, NULL, '', 3, '{}', 88),
(4820, 1376, 'A279EEFACF92762748256C30002908D1', 65, 'ssjjczk', '市审计局财政科', NULL, NULL, NULL, '', 3, '{}', 88),
(4821, 1377, 'B4F825BC511E874E48256C300029176E', 65, 'ssjjjjk', '基建分局综合事务', NULL, NULL, NULL, '', 3, '{}', 88),
(4822, 1378, '3B2CD7620A1B421648256C3000290E3F', 65, 'ssjjjmk', '市审计局经贸科', NULL, NULL, NULL, '', 3, '{}', 88),
(4823, 1379, 'F29F9E3C2D00EE3C482570CF00272D48', 65, 'ssjjjz6', '市审计局陈鹤鸣', NULL, NULL, NULL, '', 3, '{}', 88),
(4824, 1380, '77188505D8FCB2E1482571B70003790F', 65, 'ssjjjz7', '市审计局魏徐林', NULL, NULL, NULL, '', 3, '{}', 88),
(4825, 1381, 'D0E839613DDBE54C48256C30002912F0', 65, 'ssjjjzk', '市审计局经责科', NULL, NULL, NULL, '', 3, '{}', 88),
(4826, 1382, 'B70023334791CF6E48256C3000260CC0', 65, 'ssjjjzs1', '市审计局周逢良', NULL, NULL, NULL, '', 3, '{}', 88),
(4827, 1383, 'CA2CC8ED0EC47A4348256C300028E652', 65, 'ssjjjzs3', '市审计局史永年', NULL, NULL, NULL, '', 3, '{}', 88),
(4828, 1384, '1E5CD6E5C65A564E48256C300028EBCE', 65, 'ssjjjzs4', '市审计局胡敏华', NULL, NULL, NULL, '', 3, '{}', 88),
(4829, 1385, 'D5BAA89AFD515F0748256C3000291BD5', 65, 'ssjjsjzx', '市审计局审计中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4830, 1386, '31DAB829741CDC1448256B3800204BA3', 59, 'ssljbgs', '市水利局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4831, 1387, '57A97F997CC4B38448256D500027430F', 59, 'ssljcwk', '市水利局财务科', NULL, NULL, NULL, '', 3, '{}', 88),
(4832, 1388, '9344F61821B589AA48256D5000273AE7', 59, 'ssljdy1', '市水利局柴瑞堂', NULL, NULL, NULL, '', 3, '{}', 88),
(4833, 1389, '4EB9F73535CAE77148256D5000273F0B', 59, 'ssljdy2', '市水利局马国清', NULL, NULL, NULL, '', 3, '{}', 88),
(4834, 1390, '7764929892D305E048256D500027238D', 59, 'ssljjz1', '市水利局方柏令', NULL, NULL, NULL, '', 3, '{}', 88),
(4835, 1391, 'C0CDE3D617B9F6D648256D500027276D', 59, 'ssljjz2', '市水利局徐 强', NULL, NULL, NULL, '', 3, '{}', 88),
(4836, 1392, '7B87F33A4325FC2648256D5000272B76', 59, 'ssljjz3', '市水利局陈伟挺', NULL, NULL, NULL, '', 3, '{}', 88),
(4837, 1393, '58B2AA3911E9E52D48256D5000272F20', 59, 'ssljjz4', '市水利局应科', NULL, NULL, NULL, '', 3, '{}', 88),
(4838, 1394, '855F9FE1CE64A146482575220007EDB6', 59, 'ssljjz5', '市水利局郑宗昂', NULL, NULL, NULL, '', 3, '{}', 88),
(4839, 1395, '2ABB8C598ED2BBF7482575220007F649', 59, 'ssljjz6', '市水利局林伯煊', NULL, NULL, NULL, '', 3, '{}', 88),
(4840, 1397, '60C3B717E466338A48256D5000271F81', 59, 'ssljkfc', '市水利局建设管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4841, 1398, '627D54433BE94C2948256D5000274F16', 59, 'ssljsfb', '市水利局三防办', NULL, NULL, NULL, '', 3, '{}', 88),
(4842, 1399, 'B56D3182E9EB704648256D500027471B', 59, 'ssljsgk', '市水利局农村水利管理所', NULL, NULL, NULL, '', 3, '{}', 88),
(4843, 1400, '7726A2748507CB2748256D5000271B7F', 59, 'ssljszk', '市水利局水政科', NULL, NULL, NULL, '', 3, '{}', 88),
(4844, 1401, '1C46788153C186F348256D50002752D4', 59, 'ssljwg', '市水利局网　管', NULL, NULL, NULL, '', 3, '{}', 88),
(4845, 1402, 'F6586DA811818DB448256D5000273319', 59, 'ssljwkb', '市水利局技术规划科（总工室）', NULL, NULL, NULL, '', 3, '{}', 88),
(4846, 1403, '08F6CB4A6331567A48256D5000274B0E', 59, 'ssljzjz', '市水利局质监站', NULL, NULL, NULL, '', 3, '{}', 88),
(4847, 1416, 'A0268FAE341B9BD14825718B002D9C2D', 47, 'ssyb', '市双拥办', NULL, NULL, NULL, '', 3, '{}', 88),
(4848, 1417, 'D2EFCCB091EEDB08482571AE0001862D', 15, 'ssyhlzzb', '市商业贿赂治理办', NULL, NULL, NULL, '', 3, '{}', 88),
(4849, 1418, '66FAE0F4F8EA83BF48256BA8002B3417', 125, 'ssyyhbgs', '宁波银行慈溪支行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4850, 1419, '500246C0DC0C0B42482571F5000CD4E8', 181, 'ssyyhcdzh', '宁波银行城东支行', NULL, NULL, NULL, '', 3, '{}', 88),
(4851, 1420, 'B7E77EF8722F7F8748257380000DA074', 149, 'sszcl', '胜山镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(4852, 1421, '99D04C2F787584FE48256C4D00125E1B', 149, 'sszczjsb', '胜山镇村镇建设办', NULL, NULL, NULL, '', 3, '{}', 88),
(4853, 1422, '498CA0D2AA18501448256B380029E356', 149, 'sszczs', '胜山镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(4854, 1423, 'E37BD94CA7CE074448256C4D00125382', 149, 'sszdqb', '胜山镇党群办', NULL, NULL, NULL, '', 3, '{}', 88),
(4855, 1424, 'B984DA6C7B524F2C48256C4D00124D84', 149, 'sszdqsj', '胜山镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4856, 1425, '5901C7B780D3003548256C4D000C935B', 149, 'sszdwsj', '胜山镇党委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4857, 1426, 'A29096EBB214BB9148256B380029DF9F', 149, 'sszdzb', '胜山镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(4858, 1427, '23AC1E0FEDF17AB2482574250005BF21', 149, 'sszfl', '胜山镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(4859, 1428, '34D33DE1F9A7353A48256D6D00327434', 149, 'sszfzzg', '胜山镇副镇长（工）', NULL, NULL, NULL, '', 3, '{}', 88),
(4860, 1429, '9F1AE79B39EA9CF348256D6D0033F550', 149, 'sszfzzj', '胜山镇副镇长（建）', NULL, NULL, NULL, '', 3, '{}', 88),
(4861, 1430, '281F9BD78C4B00EB48256D6D003278D9', 149, 'sszfzzn', '胜山镇副镇长（农）', NULL, NULL, NULL, '', 3, '{}', 88),
(4862, 1431, 'C017EAB1B5CB4F3048257305000FCAB8', 149, 'sszfzzs', '胜山镇副镇长（文）', NULL, NULL, NULL, '', 3, '{}', 88),
(4863, 1432, '41ABDA9B0348CC27482570520004A2D2', 149, 'sszgh', '胜山镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(4864, 1433, 'CF81B77DA82906AF48256C4D00125627', 149, 'sszjfb', '胜山镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(4865, 1434, 'E01697677040237C48256B380029E227', 149, 'sszjsb', '胜山镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(4866, 1435, 'F58D14AD4A383B6148256C4D00125B58', 149, 'sszjwb', '胜山镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(4867, 1436, 'F48B1FA4043EF3F948257248001FB256', 149, 'sszldbz', '胜山镇劳动保障服务所', NULL, NULL, NULL, '', 3, '{}', 88),
(4868, 1437, '82A51BFC7ADE6B9148256D6D0032853C', 149, 'sszms', '胜山镇秘书', NULL, NULL, NULL, '', 3, '{}', 88),
(4869, 1438, '2EBE9DDC2173E66948256D3D000B20E5', 149, 'sszmzb', '胜山镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(4870, 1439, '2E6056741275C91D48256C4D001258BD', 149, 'ssznb', '胜山镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(4871, 1440, '8BFF6F690474336748256C4D0012608D', 149, 'sszrdzxt', '胜山镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(4872, 1441, '00A8BB3FD637CC4848256C4D001262A1', 149, 'sszrwb', '胜山镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(4873, 1442, 'AEEB0D5A6916436648256D6D003281ED', 149, 'sszsfs', '胜山镇收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(4874, 1443, '9786F7FDD7790CE248256E9A00318FB4', 149, 'sszsifs', '胜山镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(4875, 1444, '9275BCB501387E8D48256EF4000581C5', 149, 'ssztgs', '胜山镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(4876, 1445, 'A5EC069F64533CD248256B380029E0E4', 149, 'ssztjz', '胜山镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(4877, 1446, '657E9EAF2AC86E0048256D2B0029FE39', 149, 'ssztw', '胜山镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(4878, 1447, 'BC1FA23576EE621A48256D6D00326FFE', 149, 'sszwyx', '委员（宣）', NULL, NULL, NULL, '', 3, '{}', 88),
(4879, 1448, 'F1954732EE32B6EA48256D6D00326A33', 149, 'sszwyzj', '胜山镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(4880, 1449, '242E4F6DB00B5FDB48256C4D00125067', 149, 'sszzfsj', '胜山镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(4881, 1450, 'C4A736638E0B8AF8482572AB000708E5', 149, 'sszzxllw', '胜山镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(4882, 1451, '04762980F0B1576448256C4D000F4C8B', 149, 'sszzz', '胜山镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(4883, 1452, '225631453DE2140648257439002DD48B', 149, 'sszzzb', '胜山镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(4884, 1454, 'F99476EFADFF77E948257507000A189A', 18, 'stb2', '市台办主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4885, 1455, '03B48FD5CBDFB14148256B380042EBA5', 18, 'stbbgs', '市台办', NULL, NULL, NULL, '', 3, '{}', 88),
(4886, 1456, '94A12C814A8CDEC748256B380021136E', 135, 'stbcxgsbgs', '市太保产险公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4887, 1457, '7911D7A8187C0B6D48256B38002114F0', 136, 'stbrsgsbgs', '市太保人寿公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4888, 1458, '90DC729A168B503D48257372001231FE', 54, 'stdcbzx', '市土地储备中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4889, 1459, '2A7968111B8FC8D948257372001262CA', 54, 'stdcbzx1', '市国力公司综合事务部', NULL, NULL, NULL, '', 3, '{}', 88),
(4890, 1460, '9CD2A9B356246A04482573720012879E', 54, 'stdcbzx2', '市国力公司资源管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(4891, 1461, 'AEF76AA43FF3F161482570F8000D407F', 38, 'stgc', '市铁管处', NULL, NULL, NULL, '', 3, '{}', 88),
(4892, 1462, '965B46F4193B6DE348256B380020597B', 54, 'stgjbgs', '市国土资源局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4893, 1463, 'B42E569538FF1BBD48256D120006FDA4', 54, 'stgjbgszr', '市国土资源局办公室主任', NULL, NULL, NULL, '', 3, '{}', 88),
(4894, 1464, 'F2AFF8A4F99D3920482574A300303B35', 54, 'stgjcqs', '市国土资源局城区中心所', NULL, NULL, NULL, '', 3, '{}', 88),
(4895, 1466, '380946A583FA83EE48256CCD002001D1', 54, 'stgjdjgl', '市国土资源局不动产登记服务中心（不动产登记科）', NULL, NULL, NULL, '', 3, '{}', 88),
(4896, 1467, '16B85FE10F827DEB48256CCD001FFA08', 54, 'stgjfgjc', '市国土资源局法规监察科', NULL, NULL, NULL, '', 3, '{}', 88),
(4897, 1469, 'E525A556B4818B6348256D12000709F2', 54, 'stgjjcdd', '市国土资源局监察大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4898, 1470, 'F86A4F0A94B6881548256CCD001FF63B', 54, 'stgjjck', '市国土资源局计财科', NULL, NULL, NULL, '', 3, '{}', 88),
(4899, 1471, 'A13408A087AC3D8A482571BD002A8E29', 54, 'stgjjz5', '市国土资源局张建', NULL, NULL, NULL, '', 3, '{}', 88),
(4900, 1472, 'D661CCDF2D219AF348256CCD001FE669', 54, 'stgjjzs1', '市国土资源局何建立', NULL, NULL, NULL, '', 3, '{}', 88),
(4901, 1473, '96F54726D9226D2048256CCD001FEA28', 54, 'stgjjzs2', '市国土资源局徐德忠', NULL, NULL, NULL, '', 3, '{}', 88),
(4902, 1474, '717DE3C7B11020F348256CCD001FEE41', 54, 'stgjjzs3', '市国土资源局余时敏', NULL, NULL, NULL, '', 3, '{}', 88),
(4903, 1475, '17E853A4FB95665C48256CCD001FF253', 54, 'stgjjzs4', '市国土资源局毛群谊', NULL, NULL, NULL, '', 3, '{}', 88),
(4904, 1476, '7F9FB02981AA94B948256CCD00200A7F', 54, 'stgjkgc', '市国土资源局矿管处', NULL, NULL, NULL, '', 3, '{}', 88),
(4905, 1477, '57C17809E07EEF5C48256D12000702AA', 54, 'stgjlpzx', '市国土资源局联批中心窗口', NULL, NULL, NULL, '', 3, '{}', 88),
(4906, 1478, 'EAEDC9F0D7A4D8F648256CCD001FFDB8', 54, 'stgjlygl', '市国土资源局利用管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4907, 1480, '20C68B3441FAD2B0482571D300029F92', 54, 'stgjrsjc', '市国土资源局人事科', NULL, NULL, NULL, '', 3, '{}', 88),
(4908, 1481, '02A62E1D3228A8F248256CFC000F6EED', 54, 'stgjsfs', '市国土资源局收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(4909, 1482, 'D374AD7849CAF62248256D1200071E43', 54, 'stgjtzs', '市国土资源局统征所', NULL, NULL, NULL, '', 3, '{}', 88),
(4910, 1483, '54CF7DE5117926E148256ED700128903', 54, 'stgjwy', '市国土资源局张健', NULL, NULL, NULL, '', 3, '{}', 88),
(4911, 1484, '4D92E2A1DDF6EFE6482571D30002A9A9', 54, 'stgjxxzx', '市国土资源局信息中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4912, 1485, '6C9AF33E08F26D4048256D12000718C1', 54, 'stgjzlzx', '市国土资源局整理中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4913, 1486, '82D7DE1F21F28FAC48256B37001EBE2E', 0, 'stgwbgs', '市体改委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4914, 1487, '4223052C6CF1435348256FD9000D6213', 39, 'stjj1', '市统计局王炳耀', NULL, NULL, NULL, '', 3, '{}', 88),
(4915, 1488, 'FB1BD55F0D1CE0D348257042002D109E', 39, 'stjj10', '市统计局孙军大', NULL, NULL, NULL, '', 3, '{}', 88),
(4916, 1489, 'C9F1CA0E5E6647A348257042002D18DD', 39, 'stjj11', '市统计局张崇明', NULL, NULL, NULL, '', 3, '{}', 88),
(4917, 1490, '03AB2C9A9D3D825448257042002D2047', 39, 'stjj12', '市统计局胡达龙', NULL, NULL, NULL, '', 3, '{}', 88),
(4918, 1491, '7410C1E9621A845B48257042002D2791', 39, 'stjj13', '市统计局邹宇', NULL, NULL, NULL, '', 3, '{}', 88),
(4919, 1492, '61D31E1F1F4567D348257042002D2FB2', 39, 'stjj14', '市统计局周柯', NULL, NULL, NULL, '', 3, '{}', 88),
(4920, 1493, '74E28E240B4B0686482570D600290CEF', 39, 'stjj16', '市统计局马其洲', NULL, NULL, NULL, '', 3, '{}', 88),
(4921, 1494, '6BE971ED44E9DA13482572AD0005B509', 39, 'stjj17', '市统计局余波', NULL, NULL, NULL, '', 3, '{}', 88),
(4922, 1495, '90C57F6A094D845748257403000DEDD5', 39, 'stjj18', '市统计局杨维叶', NULL, NULL, NULL, '', 3, '{}', 88),
(4923, 1496, 'F10435E027C35B134825757B0025512F', 39, 'stjj19', '市统计局沈益品', NULL, NULL, NULL, '', 3, '{}', 88),
(4924, 1497, '43C82AF31AB6243448256FD9000D6F03', 39, 'stjj2', '市统计局陈国维', NULL, NULL, NULL, '', 3, '{}', 88),
(4925, 1498, 'A5D5BA1615022D4E4825702F000B2624', 39, 'stjj4', '市统计局韩学俊', NULL, NULL, NULL, '', 3, '{}', 88),
(4926, 1499, 'EE87614BE32C7BF44825702F000B3B4D', 39, 'stjj7', '市统计局赵立军', NULL, NULL, NULL, '', 3, '{}', 88),
(4927, 1500, 'CCA2C58DD869F74E4825703E00036F5A', 39, 'stjj8', '市统计局岑云杰', NULL, NULL, NULL, '', 3, '{}', 88),
(4928, 1501, '4A4D7F231CB3297748257042002D0723', 39, 'stjj9', '市统计局包静波', NULL, NULL, NULL, '', 3, '{}', 88),
(4929, 1502, 'C5B476BCB7BC111448256B370027523E', 39, 'stjjbgs', '市统计局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4930, 1503, '2C4274E11BC0EB3348256FD9000D8725', 39, 'stjjbgs1', '市统计局孙云钊', NULL, NULL, NULL, '', 3, '{}', 88),
(4931, 1504, '82F0E35A6D10232A48256FD9000D923E', 39, 'stjjbgs2', '市统计局黄琼', NULL, NULL, NULL, '', 3, '{}', 88),
(4932, 1505, 'A0C5517CE65B492A48256FD9000DE31F', 39, 'stjjcdd', '市统计局城调队', NULL, NULL, NULL, '', 3, '{}', 88),
(4933, 1506, '06B4E4FD83CB83E448256FD9002489B2', 39, 'stjjcdd1', '市统计局金光飞', NULL, NULL, NULL, '', 3, '{}', 88),
(4934, 1507, '74456B419EF2E2BC4825734B001F04BE', 39, 'stjjdcd', '市统计局综合调查队', NULL, NULL, NULL, '', 3, '{}', 88),
(4935, 1508, 'FB478D3D46361E3A4825702F000B1D6B', 39, 'stjjfgk', '市统计局法规科', NULL, NULL, NULL, '', 3, '{}', 88),
(4936, 1509, '2B3E8B457D172B3748256FD9000DCCF8', 39, 'stjjndd', '市统计局农调队', NULL, NULL, NULL, '', 3, '{}', 88),
(4937, 1510, '1A41A08F25C6F8A148256FD900247B65', 39, 'stjjndd1', '市统计局景　辉', NULL, NULL, NULL, '', 3, '{}', 88),
(4938, 1511, '57BF2712F5BC05914825702F0025F6C7', 39, 'stjjpczx', '市统计局普查中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4939, 1512, '67F8692B191560054825734B001F2ED7', 39, 'stjjtjk', '市统计局服务业统计科', NULL, NULL, NULL, '', 3, '{}', 88),
(4940, 1513, '9E5EFDB73CF870CA4825734B00120C99', 39, 'stjjxww', '市统计局徐文文', NULL, NULL, NULL, '', 3, '{}', 88),
(4941, 1514, '9BDF6E67B1894EAF48256FD9000DA44A', 39, 'stjjzhk', '市统计局综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4942, 1515, 'F4D994F8F92F3E2E48256FD900245F2C', 39, 'stjjzhk1', '市统计局韩成国', NULL, NULL, NULL, '', 3, '{}', 88),
(4943, 1516, '49190351E9D5F72248256FD9000DB34E', 39, 'stjjzyk', '市统计局工交投资科', NULL, NULL, NULL, '', 3, '{}', 88),
(4944, 1518, '12510F9C4F46E39848256FD900246F43', 39, 'stjjzyk2', '市统计局章红鸯', NULL, NULL, NULL, '', 3, '{}', 88),
(4945, 1519, '9F7C96986538D4074825730F000312A2', 62, 'stsg', '市图书馆', NULL, NULL, NULL, '', 3, '{}', 88),
(4946, 1521, '34B73E9AE931043F4825730F000337B9', 62, 'stycgglc', '市体育场馆管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(4947, 1522, 'CB1665838753232E4825730F00032CD6', 62, 'styglzx', '市体育管理中心', NULL, NULL, NULL, '', 3, '{}', 88),
(4948, 1525, '47F165218171CCAB48256B3A002BE5DB', 8, 'sundy', '市委办孙迪宇', NULL, NULL, NULL, '', 3, '{}', 88),
(4949, 1526, 'D3A64D459CC4713C48256C40002DECFC', 8, 'sungc', '市委办07', NULL, NULL, NULL, '', 3, '{}', 88),
(4950, 1527, 'BDEB43B0E51D9E4848256D6B0005E30A', 2, 'sungp', '市委孙国平', NULL, NULL, NULL, '', 3, '{}', 88),
(4951, 1529, 'D55B2A16A33A4F9348256EEB000A731B', 11, 'sunrw', '市政协办孙如婉', NULL, NULL, NULL, '', 3, '{}', 88),
(4952, 1533, 'D35AE2117681CC9A48256B3A002BE46E', 8, 'sunzh', '市委办孙忠华', NULL, NULL, NULL, '', 3, '{}', 88),
(4953, 1535, 'BFA47A64340A56F34825756F0022BB2F', 8, 'swbcxh', '市委办陈小恒', NULL, NULL, NULL, '', 3, '{}', 88),
(4954, 1536, 'C6181ECB70C4DA2448256B3800426AE4', 8, 'swbdcs', '市委办督查室', NULL, NULL, NULL, '', 3, '{}', 88),
(4955, 1537, 'D87AED786A768D4848256B38004271A0', 21, 'swbdyek', '市委政研室调研科', NULL, NULL, NULL, '', 3, '{}', 88),
(4956, 1538, '4787ED25DF0B524248256B3800426F15', 25, 'swbdys', '市委党研室（市志办）', NULL, NULL, NULL, '', 3, '{}', 88),
(4957, 1539, '4AB253711D9805484825733A000F9D04', 8, 'swbfjl', '市委办方建林', NULL, NULL, NULL, '', 3, '{}', 88),
(4958, 1540, '3862AF2490FD6BD948256B380042F900', 8, 'swbfws', '市委办发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4959, 1541, '30837EAE82FA98424825749600042697', 8, 'swbfzk', '市委办法治科', NULL, NULL, NULL, '', 3, '{}', 88),
(4960, 1548, '3AD5C161F3FACE9748256B440010E2C0', 8, 'swbmsk', '市委办秘书科', NULL, NULL, NULL, '', 3, '{}', 88),
(4961, 1550, 'AC107FA1DC2397EE48256B380042EE30', 8, 'swbsws', '市委办收文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4962, 1553, 'D74D65922C492E764825756F0022B238', 8, 'swbxd', '市委办徐迪', NULL, NULL, NULL, '', 3, '{}', 88),
(4963, 1554, '470B229660411DF448256B380042684B', 8, 'swbxxk', '市委办信息科', NULL, NULL, NULL, '', 3, '{}', 88),
(4964, 1556, '121D9A0B98A34D3F482572EA00120153', 8, 'swbyjq', '市委办应君乔', NULL, NULL, NULL, '', 3, '{}', 88),
(4965, 1560, 'F2F8772F9D34863E48256B38004266EA', 8, 'swbzhk', '市委办综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4966, 1561, '2348BE109974342E482572EA00121052', 8, 'swbzhq', '市委办郑焕群', NULL, NULL, NULL, '', 3, '{}', 88),
(4967, 1562, '12F240D417CBE65148256B3800426DB8', 21, 'swbzys', '市委政研室综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4968, 1565, 'F608F29C061F0569482575150002B3DC', 26, 'swdx1', '市委党校胡文杰', NULL, NULL, NULL, '', 3, '{}', 88),
(4969, 1566, '4BD91CED411539C7482575150002B991', 26, 'swdx2', '市委党校孙志平', NULL, NULL, NULL, '', 3, '{}', 88),
(4970, 1567, '5792CF963C071D1E482575150002C6D6', 26, 'swdx3', '市委党校陈凤丽', NULL, NULL, NULL, '', 3, '{}', 88),
(4971, 1568, 'A55B2DA845ECF52A482575150002CDAF', 26, 'swdx4', '市委党校孙久义', NULL, NULL, NULL, '', 3, '{}', 88),
(4972, 1569, 'FF4BF58B922A264148256B370022DCE8', 26, 'swdxbgs', '市委党校办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4973, 1570, '489641CB1F9A072D48257199000705BB', 26, 'swdxjyk', '市委党校教育科', NULL, NULL, NULL, '', 3, '{}', 88),
(4974, 1571, '9C2BCC471174744748257199000716F3', 26, 'swdxxzk', '市委党校行政科', NULL, NULL, NULL, '', 3, '{}', 88),
(4975, 1572, '4B810095D23B399C48256B3300110109', 2, 'swfws', '市委发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(4976, 1573, 'F4F6AC3E73B045194825721100218430', 62, 'swgj1', '市文广局任世华', NULL, NULL, NULL, '', 3, '{}', 88),
(4977, 1574, '5C1D09A438C4F3C248257274002D5C6D', 62, 'swgjgdk', '市文广局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(4978, 1575, '42875816D02E6BF94825748D000E803F', 62, 'swgjwhssb', '市文广局文化设施筹建办', NULL, NULL, NULL, '', 3, '{}', 88),
(4979, 1578, 'ED937C8F37A3335A4825730F00031A48', 62, 'swhg', '市文化馆', NULL, NULL, NULL, '', 3, '{}', 88),
(4980, 1581, 'AA13FCD3BCAD52BE4825730F0002FCF6', 62, 'swhsczf', '市文化市场行政执法大队', NULL, NULL, NULL, '', 3, '{}', 88),
(4981, 1595, '669344A0557ACF8548256B800006FAF6', 62, 'swl', '市文联', NULL, NULL, NULL, '', 3, '{}', 88),
(4982, 1596, '1BD8B1DD74D8E7674825750E00068B82', 35, 'swl1', '市文联方向明', NULL, NULL, NULL, '', 3, '{}', 88),
(4983, 1597, 'F16B04672B6099AA4825750E0006947C', 35, 'swl2', '市文联孙群豪', NULL, NULL, NULL, '', 3, '{}', 88),
(4984, 1598, 'A59E377E7CD639674825750E00069D8B', 35, 'swl3', '市文联陈迎平', NULL, NULL, NULL, '', 3, '{}', 88),
(4985, 1599, '8656C9615AEA31914825750E0006A725', 35, 'swlbgs', '市文联办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4986, 1600, '3DCD6219CE7DEA614825750E0006B3B9', 35, 'swlcyk', '市文联创研室', NULL, NULL, NULL, '', 3, '{}', 88),
(4987, 1601, 'C46BF303F7E8ED2848257042002BAA04', 24, 'swlgbj1', '市委老干部局陈杭燕', NULL, NULL, NULL, '', 3, '{}', 88),
(4988, 1602, '86F8512C1DB43CD548257042002BB55F', 24, 'swlgbj2', '市委老干部局潘建伟', NULL, NULL, NULL, '', 3, '{}', 88),
(4989, 1604, '904862963F46E46A48256B370022E450', 24, 'swlgbjbgs', '市委老干部局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(4990, 1605, '05DC31CB8D3ABC3748257042002BEEDD', 24, 'swlgbjggw', '市委老干部局关工委', NULL, NULL, NULL, '', 3, '{}', 88),
(4991, 1606, '185388733DBE089448257042002BD0C8', 24, 'swlgbjglk', '市委老干部局管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(4992, 1607, 'B7C7F3F1DEABC18648257042002BE0ED', 24, 'swlgbjlndx', '市委老干部局老年大学', NULL, NULL, NULL, '', 3, '{}', 88),
(4993, 1608, '928B7C9004DA4481482571D200079051', 24, 'swlgbjyw', '市委老干部局阅文', NULL, NULL, NULL, '', 3, '{}', 88),
(4994, 1609, '94E98F58912E0F5D48256EE0002F9902', 62, 'swlmsc', '市文联秘书处', NULL, NULL, NULL, '', 3, '{}', 88),
(4995, 1610, 'ECB92399B153402E48256DB10008A779', 5, 'swlxd', '市政协李兴达', NULL, NULL, NULL, '', 3, '{}', 88),
(4996, 1611, '16E66485ACD9C6A148256EE0002F87E2', 62, 'swlzxs', '市文联主席室', NULL, NULL, NULL, '', 3, '{}', 88),
(4997, 1612, 'D852C27B2E531C7A482574BE0000F1BE', 17, 'swmbcjk', '市文明办创建科', NULL, NULL, NULL, '', 3, '{}', 88),
(4998, 1613, 'DCC984C7AD018D65482574BB0030DF70', 17, 'swmbzhk', '市文明办综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(4999, 1614, '808C98CA079E6742482570F500222776', 22, 'swnb1', '市农办高雪皎', NULL, NULL, NULL, '', 3, '{}', 88),
(5000, 1615, '6791125A46A35452482570F5002239B8', 22, 'swnb2', '市农办赵建杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5001, 1616, 'D2FC91459397FC8E482570F5002245E0', 22, 'swnb3', '市农办毛玲洁', NULL, NULL, NULL, '', 3, '{}', 88),
(5002, 1617, 'F99952D3BDF50851482570F500225500', 22, 'swnb4', '市农办杨海勇', NULL, NULL, NULL, '', 3, '{}', 88),
(5003, 1618, '92D4B24D5936CDBF482572B400262162', 22, 'swnb5', '市农办陈坤华', NULL, NULL, NULL, '', 3, '{}', 88),
(5004, 1619, '05689AEB1BF3E55848256F8E0028EB44', 22, 'swnbdyk', '市旧村改造办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5005, 1620, 'C6F19B116222DB3848256F8E0028D260', 22, 'swnbfzr1', '市农办徐张根', NULL, NULL, NULL, '', 3, '{}', 88),
(5006, 1621, 'BD0DE20B6C7BB40E48256F8E0028DE70', 22, 'swnbfzr2', '市农办龚正荣', NULL, NULL, NULL, '', 3, '{}', 88),
(5007, 1622, '9B7A9B4B7631D50C48256F8E0028F911', 22, 'swnbzhk', '市农办（收发文）', NULL, NULL, NULL, '', 3, '{}', 88),
(5008, 1623, '298E2E6EC5F129DC48256F8E0028B60B', 22, 'swnbzr', '市农办陈菊蓬', NULL, NULL, NULL, '', 3, '{}', 88),
(5009, 1624, 'B286D375F3186D5D48256B37001EC9A9', 10, 'swsbbgs', '市 外　事 办', NULL, NULL, NULL, '', 3, '{}', 88),
(5010, 1625, 'C9342F72A053AE2548257586000C5AF2', 63, 'swsj10', '市卫生和计划生育局朱胜军', NULL, NULL, NULL, '', 3, '{}', 88),
(5011, 1627, '4D2E342D60487C1B4825720D002F54A4', 63, 'swsj3', '市卫生和计划生育局莫志海', NULL, NULL, NULL, '', 3, '{}', 88),
(5012, 1631, '20709A745E299F7E4825720D002F7221', 193, 'swsj7', '市红十字会莫志海', NULL, NULL, NULL, '', 3, '{}', 88),
(5013, 1633, '2AD32C3B9A85C9F348257345000B35DA', 63, 'swsj9', '市卫生和计划生育局王明岳', NULL, NULL, NULL, '', 3, '{}', 88),
(5014, 1634, '4FFF597B871BCD0E48256B37002471AF', 63, 'swsjbgs', '市卫生和计划生育局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5015, 1636, '54F9ED53049BFBD448256D1E000FCEC7', 63, 'swsjds', '市卫生监督所', NULL, NULL, NULL, '', 3, '{}', 88),
(5016, 1642, '3DA45DB1E53501E74825720D002F98DE', 63, 'swsjggws', '市卫生和计划生育局公共卫生科', NULL, NULL, NULL, '', 3, '{}', 88),
(5017, 1644, '0F9F626F6E3F0BE548256E15000697BB', 63, 'swsjjck', '市卫生和计划生育局规划财务科', NULL, NULL, NULL, '', 3, '{}', 88),
(5018, 1645, '5E7EAEAA9D0C712E48256E1C00231BDE', 63, 'swsjjzs1', '市卫生和计划生育局陈彩莲', NULL, NULL, NULL, '', 3, '{}', 88),
(5019, 1646, 'AB5EF726E1F1F5A848256E1500069243', 63, 'swsjrsk', '市卫生和计划生育局组织人事科', NULL, NULL, NULL, '', 3, '{}', 88),
(5020, 1647, '16623F24119CB7D648257567000A6104', 63, 'swsjxxb', '市献血办', NULL, NULL, NULL, '', 3, '{}', 88),
(5021, 1648, '2730ECD4584519924825720D002F8F9D', 63, 'swsjyzk', '市卫生和计划生育局医政与中医科', NULL, NULL, NULL, '', 3, '{}', 88),
(5022, 1649, '8C4BA699996D56D748256B7D0044A31E', 62, 'swtjbgs', '市文广局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5023, 1650, '35EC3426EA02F68E48256F0100033651', 62, 'swtjcws', '市文广局财务室', NULL, NULL, NULL, '', 3, '{}', 88),
(5024, 1651, '7A156D5E892BDA8248256EE0002F7B6D', 62, 'swtjglk', '市文广局文化产业科', NULL, NULL, NULL, '', 3, '{}', 88),
(5025, 1652, '158908C738D833BE48256EE0002F2907', 62, 'swtjjzs1', '市文广局张伯传', NULL, NULL, NULL, '', 3, '{}', 88),
(5026, 1653, '58D709C353980F7B48256EE0002F3EDC', 62, 'swtjjzs2', '市文广局陈伟芳', NULL, NULL, NULL, '', 3, '{}', 88),
(5027, 1654, '51D71D9549D2B61A48256EE0002F4876', 62, 'swtjjzs3', '市文广局罗伟国', NULL, NULL, NULL, '', 3, '{}', 88),
(5028, 1655, '2BBCDDFC2814F95D48256EE0002F57E8', 62, 'swtjjzs4', '市文广局黄荣丰', NULL, NULL, NULL, '', 3, '{}', 88),
(5029, 1656, 'A474413743BDDB7848256EE0002F6063', 62, 'swtjjzs5', '市文广局史幼文', NULL, NULL, NULL, '', 3, '{}', 88);
INSERT INTO `staff_tbl` (`staff_id`, `out_id`, `staff_unid`, `unit`, `staff_name`, `full_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`, `user_admin`, `reorder`) VALUES
(5030, 1657, '9EA2E8F36716EFC148256EE0002F6FD8', 62, 'swtjtyk', '市文广局体育科', NULL, NULL, NULL, '', 3, '{}', 88),
(5031, 1658, '20C738EDEC15F9AF48256EE1000731DA', 62, 'swtjwhk', '市文广局文化艺术科', NULL, NULL, NULL, '', 3, '{}', 88),
(5032, 1659, 'DBED089392DEE0E6482573280008EA7F', 18, 'swtzb3', '市委统战部蒋建华', NULL, NULL, NULL, '', 3, '{}', 88),
(5033, 1660, '188144425F5CCDAD48256B380042E7DA', 18, 'swtzbbgs', '市委统战部（侨办、台办）办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5034, 1661, '79F4D95B17C62AF9482570830011B8E3', 20, 'swwb', '市维稳办', NULL, NULL, NULL, '', 3, '{}', 88),
(5035, 1662, '0261001BA4E19AC04825730F00030961', 62, 'swwglbgs', '市文物管理委员会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5036, 1663, 'EEF8EB33D43C1E2348256B3700245889', 17, 'swxcbbgs', '市委宣传部办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5037, 1665, '508A9B80EEFD30C248256C920008321E', 17, 'swxcbbzs2', '市委宣传部沈伟军', NULL, NULL, NULL, '', 3, '{}', 88),
(5038, 1666, 'F3068FADE406787D48256C9200083685', 17, 'swxcbbzs3', '市委宣传部严松煜', NULL, NULL, NULL, '', 3, '{}', 88),
(5039, 1667, 'E1A5F583B95E1A7648257481002DF119', 17, 'swxcbbzs4', '市委宣传部徐建岳', NULL, NULL, NULL, '', 3, '{}', 88),
(5040, 1670, '9027C3A1E4A6816348256C9200083E27', 17, 'swxcbllk', '市委宣传部理论科', NULL, NULL, NULL, '', 3, '{}', 88),
(5041, 1671, 'BC689BE66AF9B298482574C0000740A9', 17, 'swxcbwaxb', '市委宣传部网信办', NULL, NULL, NULL, '', 3, '{}', 88),
(5042, 1672, '49448BE75D35D0DE48256C920008421B', 17, 'swxcbwmb', '市文明办', NULL, NULL, NULL, '', 3, '{}', 88),
(5043, 1673, 'B8FABFCA14E1E81848256C920008461C', 17, 'swxcbwxb', '市委宣传部外宣办', NULL, NULL, NULL, '', 3, '{}', 88),
(5044, 1674, '2BE4C5F37DA5287548256C9200083A57', 17, 'swxcbxck', '市委宣传部宣传文化科', NULL, NULL, NULL, '', 3, '{}', 88),
(5045, 1675, '90EDBD4FAF340DEB48257347000F248E', 17, 'swxcbxwk', '市委宣传部新闻办', NULL, NULL, NULL, '', 3, '{}', 88),
(5046, 1678, 'AB98B369C446FD1948256C7E000AC559', 2, 'swyangsj', '市委杨胜隽', NULL, NULL, NULL, '', 3, '{}', 88),
(5047, 1679, '920A88F8E563544B482573EE00224471', 2, 'swyhf', '市委杨慧芳', NULL, NULL, NULL, '', 3, '{}', 88),
(5048, 1680, 'E577C50F3164536848256B3500047989', 2, 'swzbs', '市委值班室', NULL, NULL, NULL, '', 3, '{}', 88),
(5049, 1681, '52CAEBC16B6FADA7482575C30023855B', 20, 'swzfw4', '市委政法委沈建治', NULL, NULL, NULL, '', 3, '{}', 88),
(5050, 1682, '999D426BE0E1DDFA482575C300238938', 20, 'swzfw5', '市委政法委房培志', NULL, NULL, NULL, '', 3, '{}', 88),
(5051, 1684, 'BBA9D3CF47AFCDFC482575C3002391E9', 20, 'swzfw7', 'G20峰会安保工作综合协调组', NULL, NULL, NULL, '', 3, '{}', 88),
(5052, 1685, 'C5B7BA3FAE912E4C48256B3700260AD1', 20, 'swzfwbgs', '市委政法委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5053, 1686, '41D41909541A0C4248256CE50027B34A', 20, 'swzfwsfs', '市委政法委收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(5054, 1687, 'CD4D940C68D7989248256CE50024642C', 20, 'swzfwsj1', '市委政法委戎忠海', NULL, NULL, NULL, '', 3, '{}', 88),
(5055, 1688, '2E84E79BE27B3D9D48256CE50027A190', 20, 'swzfwsj2', '市委政法委胡其君', NULL, NULL, NULL, '', 3, '{}', 88),
(5056, 1689, 'C7BE42DC94923E4C48256CE50027A5D2', 20, 'swzfwsj3', '市委政法委方国平', NULL, NULL, NULL, '', 3, '{}', 88),
(5057, 1690, 'CC3217323EE978C748256CE50027AED7', 20, 'swzfwzgk', '市委政法委政治处', NULL, NULL, NULL, '', 3, '{}', 88),
(5058, 1691, '84249CCAE58C6009482573FA000A34C8', 20, 'swzfwzjk', '市委政法委执法监督科', NULL, NULL, NULL, '', 3, '{}', 88),
(5059, 1693, 'C7A52C5E1690119B482572DB002D86B2', 20, 'swzfwzzb', '市委政法委综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(5060, 1694, '24C358A93E1386E148256E62002EBC3C', 77, 'swzx', '商务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5061, 1695, '2B607C6D05ACC0FB48256B370022DAFD', 16, 'swzzbbgs', '市委组织部办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5062, 1697, '2B9AF921ABEE12C348256BDC0028115C', 16, 'swzzbbzs1', '市委组织部郑茹杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5063, 1700, '06539C713231194848256BDC00282544', 16, 'swzzbczb', '市委组织部参照办', NULL, NULL, NULL, '', 3, '{}', 88),
(5064, 1701, '138F377160E97C0748256BDC00283067', 16, 'swzzbdjzx', '市委组织部电教中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5065, 1702, '2A4F42E91DFE439548256BDC002A9425', 16, 'swzzbgbek', '市委组织部干部二科', NULL, NULL, NULL, '', 3, '{}', 88),
(5066, 1703, '337D59D1019D9F9D48256BDC00281D95', 16, 'swzzbgbyk', '市委组织部干部一科', NULL, NULL, NULL, '', 3, '{}', 88),
(5067, 1704, 'FA157C1E6D900B5448256BDC002828D6', 16, 'swzzbzzk', '市委组织部组织科', NULL, NULL, NULL, '', 3, '{}', 88),
(5068, 1705, 'FE8BA76EBD402668482575C100220AD6', 99, 'sxdnykfq1', '市现代农业开发区管委会戚岳瑞', NULL, NULL, NULL, '', 3, '{}', 88),
(5069, 1706, '03232226512CDA8A482575C1002212B8', 99, 'sxdnykfq2', '市现代农业开发区管委会杨海勇', NULL, NULL, NULL, '', 3, '{}', 88),
(5070, 1707, '38458A16B8F45B44482575C100221A4B', 99, 'sxdnykfq3', '市现代农业开发区管委会陈燮衔', NULL, NULL, NULL, '', 3, '{}', 88),
(5071, 1708, '56B3DE8EECB5F8D9482575C100222332', 99, 'sxdnykfqbgs', '市现代农业开发区管委会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5072, 1709, '6700E57FD2A0A77448256FCC00115619', 45, 'sxfdd', '市公安局消防大队', NULL, NULL, NULL, '', 3, '{}', 88),
(5073, 1710, 'A24B022552DC957348256B37001EC7C1', 67, 'sxfjbgs', '市信访局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5074, 1711, 'FCD5434FB73FAB2B48256EC90010BC6C', 67, 'sxfjbx', '市信访局办信科', NULL, NULL, NULL, '', 3, '{}', 88),
(5075, 1712, '553E9673A097115648256C5D00218094', 67, 'sxfjdck', '市信访局督查和复查复核科', NULL, NULL, NULL, '', 3, '{}', 88),
(5076, 1713, '1164254D9A5E354F48256EC9001099D7', 67, 'sxfjdyy1', '市信访局俞杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5077, 1714, 'D205EE93EB4E162C48256EC90010AA36', 67, 'sxfjdyy2', '市信访局调研员室2', NULL, NULL, NULL, '', 3, '{}', 88),
(5078, 1715, 'A80D8BDA8E10FE8348256C5D00217BAE', 67, 'sxfjjfk', '市信访局接访科', NULL, NULL, NULL, '', 3, '{}', 88),
(5079, 1716, '031FF3B48BD5A72548256C5D00216C82', 67, 'sxfjjzs1', '市信访局戎渭泗', NULL, NULL, NULL, '', 3, '{}', 88),
(5080, 1718, '2111B48890ACAF4048256C5D0021764C', 67, 'sxfjjzs3', '市信访局楼凯', NULL, NULL, NULL, '', 3, '{}', 88),
(5081, 1719, 'F22C81D523540D3C48256F55001FA405', 67, 'sxfjjzs4', '市信访局钱乃红', NULL, NULL, NULL, '', 3, '{}', 88),
(5082, 1720, '371D933B7DD5F0924825750E00202A78', 67, 'sxfjjzs5', '市信访局俞其', NULL, NULL, NULL, '', 3, '{}', 88),
(5083, 1722, '69FE405C6C66D2DC48256E530009BF3F', 67, 'sxfjszxx', '市长信箱', NULL, NULL, NULL, '', 3, '{}', 88),
(5084, 1723, 'E49F67F005FF1DC84825708A00244AB4', 59, 'sxhq', '市西河区', NULL, NULL, NULL, '', 3, '{}', 88),
(5085, 1724, 'D1C545D31DA344FE482572C6000B907F', 22, 'sxncb', '市新农村办', NULL, NULL, NULL, '', 3, '{}', 88),
(5086, 1725, 'F098B10AE5DA6AFC482574560001AD7C', 69, 'sxyb', '市信用办', NULL, NULL, NULL, '', 3, '{}', 88),
(5087, 1726, '11303A2A454C3E2548256B380020E955', 122, 'sxylsbgs', '慈溪农村商业银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5088, 1727, '62F6F3EBEFA34A3A482573F00024DA26', 129, 'sxyyh', '市兴业银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5089, 1728, '6ECC09FC9F6078FB48256E76002BD5B8', 53, 'sybzx', '市医保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5090, 1730, '814B2E0B6154827D48256B380020AC8D', 96, 'sycjbgs', '市烟草局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5091, 1731, 'C7BDE486CE10F24B482570F80025A567', 16, 'sycjyb', '市远程教育办', NULL, NULL, NULL, '', 3, '{}', 88),
(5092, 1732, '63E86BE011EB57D748256BA8002ACB60', 110, 'sydfgsbgs', '市移动分公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5093, 1733, 'AE095624E9733C0D48256FB2002AC2A7', 53, 'sygzx', '市医管中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5094, 1734, 'E8CDE4A5C4278FC7482571CD00022DE0', 10, 'syjb', '市政府应急办', NULL, NULL, NULL, '', 3, '{}', 88),
(5095, 1735, 'C43D05E81D129516482573E50021B681', 10, 'syjzhzx', '市应急指挥中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5096, 1736, 'AFF27DE875A8EF25482572F40009B4CB', 0, 'sylglc', '市园林管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(5097, 1737, '8DA0867C721CA2A948256D420007C89D', 47, 'symb', '市移民办', NULL, NULL, NULL, '', 3, '{}', 88),
(5098, 1738, '14DEBCD6A6BC529948256B37002966E1', 90, 'syygsbgs', '市盐务局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5099, 1740, '8893AEE64E48D14448256B3700296A02', 94, 'syzjbgs', '市邮政局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5100, 1741, 'E22AB5289CF6CECF4825758A00277444', 94, 'syzjbgs2', '市邮政局办公室（秘书处）', NULL, NULL, NULL, '', 3, '{}', 88),
(5101, 1742, '9D567B908A8A3A3948256B37001ECF05', 0, 'szbbgs', '市志办', NULL, NULL, NULL, '', 3, '{}', 88),
(5102, 1743, '1157614A460D036D48256D4E0009579A', 54, 'szddcb', '市征地督查办', NULL, NULL, NULL, '', 3, '{}', 88),
(5103, 1744, '75F921EDCCE8C57F48256BD80024F8BC', 10, 'szfdcs', '市政府督查室', NULL, NULL, NULL, '', 3, '{}', 88),
(5104, 1745, 'D2649E5EE0A7273948256B300024DD01', 4, 'szffws', '市政府发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(5105, 1747, '0C14853C1212665048256F330011BEC2', 3, 'szfhjg', '市人大胡建国', NULL, NULL, NULL, '', 3, '{}', 88),
(5106, 1748, '283C4BA8514E0A87482572A4001BBDDC', 15, 'szfjsnhdb', '市作风建设年活动办', NULL, NULL, NULL, '', 3, '{}', 88),
(5107, 1751, '7E26EB08B5FCFAAA48256EC500041E16', 10, 'szfyjs', '市政府研究室', NULL, NULL, NULL, '', 3, '{}', 88),
(5108, 1753, 'ACDC8A2252B0127548256B350005495F', 4, 'szfzbs', '市政府值班室', NULL, NULL, NULL, '', 3, '{}', 88),
(5109, 1754, 'BD8B85E78EE9F0F8482572F40009CF4C', 0, 'szfzjzx', '市住房资金中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5110, 1757, '2C996305466CD6654825743A00089C7F', 0, 'szgbzhk', '市整规办综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(5111, 1758, 'C5899469D3D68C5148256B37002353E3', 29, 'szghbgs', '市总工会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5112, 1759, 'C0D581015481159E48256F1F002A35E8', 29, 'szghcw1', '市总工会常委1', NULL, NULL, NULL, '', 3, '{}', 88),
(5113, 1760, 'CBF052C90607095748256F1F002A3F85', 29, 'szghcw2', '市总工会常委2', NULL, NULL, NULL, '', 3, '{}', 88),
(5114, 1761, '2B0716B2F584AD0348256F1F002A6C44', 29, 'szghcw3', '市总工会常委3', NULL, NULL, NULL, '', 3, '{}', 88),
(5115, 1762, 'B90195D4E5BA5C0048256F1F002A7600', 29, 'szghcw4', '市总工会常委4', NULL, NULL, NULL, '', 3, '{}', 88),
(5116, 1763, '8487EAB484F5B5AC48256F1F002A8070', 29, 'szghcw5', '市总工会常委5', NULL, NULL, NULL, '', 3, '{}', 88),
(5117, 1764, '4F210987CA2479F348256F1F002A8EDA', 29, 'szghcw6', '市总工会常委6', NULL, NULL, NULL, '', 3, '{}', 88),
(5118, 1765, '7FAC2B0759CE7D804825720200075D38', 29, 'szghcwb', '市总工会财务部', NULL, NULL, NULL, '', 3, '{}', 88),
(5119, 1766, 'A5D4A15E0F188BC74825720200077861', 29, 'szghjcgz', '市总工会基层工作部', NULL, NULL, NULL, '', 3, '{}', 88),
(5120, 1767, 'CFBCD7583ADBE5F848257202000765AE', 29, 'szghqybz', '市总工会权益保障部', NULL, NULL, NULL, '', 3, '{}', 88),
(5121, 1768, 'BB2EA6C2B15BA2A64825720200076E97', 29, 'szghwhg', '市总工会文化宫', NULL, NULL, NULL, '', 3, '{}', 88),
(5122, 1769, '9BBA9717FCF59C9D48256F1F002AAD68', 29, 'szghwqb', '市总工会维权中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5123, 1770, '61AEBD0947BA752748256F1F002A142F', 29, 'szghzxs1', '市总工会邹柏涌', NULL, NULL, NULL, '', 3, '{}', 88),
(5124, 1771, '09B10BED612D005B48256F1F002A1F98', 29, 'szghzxs2', '市总工会徐华军', NULL, NULL, NULL, '', 3, '{}', 88),
(5125, 1772, '505F72B961264F0F48256F1F002A29F9', 29, 'szghzxs3', '市总工会陈伟凯', NULL, NULL, NULL, '', 3, '{}', 88),
(5126, 1773, '0AAD3A34DC0332614825701800052A4E', 29, 'szghzxs4', '市总工会沈小波', NULL, NULL, NULL, '', 3, '{}', 88),
(5127, 1774, '97B8D0F23F7C943448256F1F002A993E', 29, 'szghzzk', '市总工会许建军', NULL, NULL, NULL, '', 3, '{}', 88),
(5128, 1775, '4A9D392042742D7B48256B380020E672', 120, 'szgyhbgs', '市中国银行办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5129, 1776, '4A332375E6D8E33F48257124000E452B', 0, 'szhenggb', '市整规办', NULL, NULL, NULL, '', 3, '{}', 88),
(5130, 1777, 'BF478D59042840124825708A0024571D', 59, 'szhq', '市中河区', NULL, NULL, NULL, '', 3, '{}', 88),
(5131, 1778, 'A646C96BC37D734448256B3700274CD4', 0, 'szjbgs', '市政局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5132, 1779, '4C5FEBF8BB7E0EBA48256B3700295DBC', 70, 'szjjbgs', '市质监局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5133, 1780, '3D5945F6D2572414482575A700081402', 70, 'szjjtjk', '市质监局特监科', NULL, NULL, NULL, '', 3, '{}', 88),
(5134, 1781, '95A7DED1281C3A48482572F40009BFF2', 0, 'szjz', '市质(安)监站', NULL, NULL, NULL, '', 3, '{}', 88),
(5135, 1782, '5D3050B326A59999482573DF00287348', 46, 'szkj1', '市流动人口局孙孟飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5136, 1783, '3E3837F76E28C465482573DF002876E3', 46, 'szkj2', '市流动人口局戎建平', NULL, NULL, NULL, '', 3, '{}', 88),
(5137, 1784, '1DAD870CD7918D10482573DF00288442', 46, 'szkjhchbgs', '市村级和谐促进会建设工作指导委员会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5138, 1785, 'E82C3EEF7A34E597482573DF002887D5', 46, 'szkjwkwqzx', '市外来务工人员维权服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5139, 1786, '859F9728EB9B315B482573DF00288124', 46, 'szkjwqfwk', '市流动人口局维权服务科', NULL, NULL, NULL, '', 3, '{}', 88),
(5140, 1787, '1A872589E63A2E94482573DF00287DBE', 46, 'szkjzddck', '市流动人口局指导督查科', NULL, NULL, NULL, '', 3, '{}', 88),
(5141, 1788, '457356F2489A59C7482573DF00287AAD', 46, 'szkjzhk', '市流动人口局综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(5142, 1789, '5B077BFC77EB5223482572F40009DD70', 194, 'szlszgs', '市自来水有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5143, 1790, '8ADC469E9551CD7B482573DA0021CCC5', 128, 'szsyh', '市招商银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5144, 1791, '188B0A67E3DEA73748256FB100406F41', 61, 'szszx', '市国际商务促进中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5145, 1792, '3FE887D66416C0BF482570FC0027BBF2', 81, 'sztbbgs', '市公共资源交管办办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5146, 1794, '7F300A52740F884D4825717A000EA523', 81, 'sztbbgs2', '市公共资源交管办卢银淼', NULL, NULL, NULL, '', 3, '{}', 88),
(5147, 1795, '8850E9C736BD493D4825717A000EB31A', 81, 'sztbbgs3', '市公共资源交管办陶�t', NULL, NULL, NULL, '', 3, '{}', 88),
(5148, 1796, 'D74B3368A9E4B17C4825718100213037', 81, 'sztbjgek', '市公共资源交管办监管二科', NULL, NULL, NULL, '', 3, '{}', 88),
(5149, 1797, 'ED26DC03D7FB3A8A48257181002121AA', 81, 'sztbjgyk', '市公共资源交管办监管一科', NULL, NULL, NULL, '', 3, '{}', 88),
(5150, 1798, '0F1B1D99985FACE24825718100213CCD', 81, 'sztbzx', '市公共资源交易中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5151, 1800, '2768EFDD495FDA6F48256BE20028BE25', 11, 'szxbmsk', '市政协办秘书科', NULL, NULL, NULL, '', 3, '{}', 88),
(5152, 1801, '340B2BF2C174084948256B380042E682', 11, 'szxbsfs', '市政协办收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(5153, 1802, '39F25521BDD886F84825759E000D3971', 11, 'szxbsgc', '提案委孙国灿', NULL, NULL, NULL, '', 3, '{}', 88),
(5154, 1803, 'E2568A2B9185A60648256F9D002261BC', 11, 'szxbtaw', '市政协提案委', NULL, NULL, NULL, '', 3, '{}', 88),
(5155, 1804, '3A65A9F0B39444E348256BE20028BA07', 11, 'szxbzeb', '市政协办专二办', NULL, NULL, NULL, '', 3, '{}', 88),
(5156, 1805, '112F0D4E85842CE448256BE20028B603', 11, 'szxbzyb', '市政协办专一办', NULL, NULL, NULL, '', 3, '{}', 88),
(5157, 1806, '34C32E353DEDE11248256B350005B243', 5, 'szxfws', '市政协发文室', NULL, NULL, NULL, '', 3, '{}', 88),
(5158, 1807, 'EB0DAC274435501A4825752000074394', 11, 'szxfxm', '提案委范旭明', NULL, NULL, NULL, '', 3, '{}', 88),
(5159, 1808, '78FE5E2EEB22BF34482572830009B516', 5, 'szxhyx', '市政协何月祥', NULL, NULL, NULL, '', 3, '{}', 88),
(5160, 1810, '61251EB6CCAD57D148256E8F000D3D0D', 121, 'szxsyyh', '市中信实业银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5161, 1811, 'D4AA8E7693397643482574D2000D4CF8', 121, 'szxsyyhqc', '市中信实业银行桥城支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5162, 1813, '22F1EDF64DC9268D48256EFA0028F80E', 138, 'tabx', '天安保险公司慈溪支公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5163, 1814, '0360EB60F46C6F5E48256FEF001FD959', 8, 'taohh', '市委办陶慧慧', NULL, NULL, NULL, '', 3, '{}', 88),
(5164, 1816, '34F7734E5A9B538E482571BD001FC1D8', 8, 'tongyf', '市委办童银舫', NULL, NULL, NULL, '', 3, '{}', 88),
(5165, 1817, '147320E506C9D16348256B9C00243E55', 10, 'training', '培训', NULL, NULL, NULL, '', 3, '{}', 88),
(5166, 1818, '154EE6BECAFFECA748256D170005FA77', 30, 'tswbgs', '团市委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5167, 1820, '66271C67A88636A648256D13000CF359', 30, 'tswfsj2', '团市委史俊超 ', NULL, NULL, NULL, '', 3, '{}', 88),
(5168, 1821, '3D16A0A17395BF8548256D13000CEA7C', 30, 'tswsj', '团市委夏�S', NULL, NULL, NULL, '', 3, '{}', 88),
(5169, 1856, '5DA4D048DC2B378A48256B39000842CF', 10, 'wangjl', '市府办王剑利', NULL, NULL, NULL, '', 3, '{}', 88),
(5170, 1858, 'AB1F16C4F89F406A48256EEB000A55FC', 11, 'wangjt', '市政协办王近泰', NULL, NULL, NULL, '', 3, '{}', 88),
(5171, 1860, '522131246977E3FE48256B35003F0109', 10, 'wangmj', '市府办11', NULL, NULL, NULL, '', 3, '{}', 88),
(5172, 1862, '8E2F7E63DA63B4F14825717E00022522', 6, 'wangwd', '开发区王维德', NULL, NULL, NULL, '', 3, '{}', 88),
(5173, 1863, 'D85D99EC858567CE48256B39000B1D34', 10, 'wangy', '市府办王　颖', NULL, NULL, NULL, '', 3, '{}', 88),
(5174, 1867, 'AD5303A11828C3C648257501000A454F', 83, 'whswq1', '市环杭州湾创新中心杨利登', NULL, NULL, NULL, '', 3, '{}', 88),
(5175, 1868, '92229A4BC2A9F29D48257501000A515D', 83, 'whswq2', '市环杭州湾创新中心丁青杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5176, 1869, 'CCCAEC998E41F08D48257501000A5DCA', 83, 'whswq3', '市环杭州湾创新中心陈孟群', NULL, NULL, NULL, '', 3, '{}', 88),
(5177, 1870, '532F148A4ADA87C0482575940010B773', 83, 'whswq4', '市环杭州湾创新中心施空军', NULL, NULL, NULL, '', 3, '{}', 88),
(5178, 1871, '5A7073DEFEC84F0548257498000320FE', 83, 'whswqchk', '市环杭州湾创新中心招商合作科', NULL, NULL, NULL, '', 3, '{}', 88),
(5179, 1872, 'EFE31F20FB01A2C248257501000A6A57', 83, 'whswqcw', '市环杭州湾创新中心财务审计科', NULL, NULL, NULL, '', 3, '{}', 88),
(5180, 1873, 'F6FBBD436EEF208A4825749800031B7D', 83, 'whswqghk', '市环杭州湾创新中心规划建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(5181, 1874, '8CAA2F1A6AE6914E48257498000316CB', 83, 'whswqzhk', '市环杭州湾创新中心办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5182, 1875, '11C4897D1BA7673248256C230027D0C4', 8, 'wjs', '市委办吴吉生', NULL, NULL, NULL, '', 3, '{}', 88),
(5183, 1876, '750CC8DD87D338C6482571CB00038B2C', 113, 'wtcxfgs', '网通慈溪分公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5184, 1878, '0710C7FAF7A6CCD448256E62002EB812', 0, 'wyzx', '物业中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5185, 1880, '124AA1154AB8E46F4825717E0002E78B', 6, 'xiejm', '开发区谢建明', NULL, NULL, NULL, '', 3, '{}', 88),
(5186, 1882, 'F41AEFFBC469AA1B48256FEA0004C50E', 10, 'xlx', '测试用户', NULL, NULL, NULL, '', 3, '{}', 88),
(5187, 1883, 'BD550654075099F748256EBB0027BE63', 148, 'xlzbmfwzx', '逍林镇便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5188, 1884, '15091142874A30D348256EFD0010F144', 148, 'xlzcjzz', '逍林镇副镇长(城建)', NULL, NULL, NULL, '', 3, '{}', 88),
(5189, 1885, 'F5688DAC9169256D48257380000D79D0', 148, 'xlzcl', '逍林镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(5190, 1886, '575868BFB47A38C148256C230023B2CB', 148, 'xlzczjsb', '逍林镇村镇建设办', NULL, NULL, NULL, '', 3, '{}', 88),
(5191, 1887, '7A9A4F5E1932578A48256B380029CB80', 148, 'xlzczs', '逍林镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(5192, 1888, '437E12A757E30C5748256C23001A0D5E', 148, 'xlzdqsj', '逍林镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5193, 1889, '998B084EF983381848256C230018F202', 148, 'xlzdwsj', '逍林镇党委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5194, 1890, 'F2E989143C45E90B48256B380029C8CC', 148, 'xlzdzb', '逍林镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(5195, 1891, 'A7BBE0C5B9A6FA8248256E2E0009AB6C', 148, 'xlzfl', '逍林镇妇　联', NULL, NULL, NULL, '', 3, '{}', 88),
(5196, 1892, 'A5F5CCD9F6286390482570520004B7ED', 148, 'xlzgh', '逍林镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(5197, 1893, '31B48F8F65DB4D4C48256EFD0010C7C8', 148, 'xlzgyzz', '逍林镇副镇长(工)', NULL, NULL, NULL, '', 3, '{}', 88),
(5198, 1894, 'CA4E4A517D85220548256C230020D1CE', 148, 'xlzjfb', '逍林镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(5199, 1895, '86807E2BF83C8F2248256F0C003033E6', 148, 'xlzjjb', '逍林镇纪检办', NULL, NULL, NULL, '', 3, '{}', 88),
(5200, 1896, 'AAA03D85FBF9E0E248256B380029CA14', 148, 'xlzjsb', '逍林镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(5201, 1897, '3D73BFBBF60709C148256C230022E560', 148, 'xlzjwb', '逍林镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(5202, 1898, '2E93198FE93CD7F1482572AD002346F1', 148, 'xlzldfws', '逍林镇劳动保障管理服务所', NULL, NULL, NULL, '', 3, '{}', 88),
(5203, 1899, 'EFA81B9EF6DD0A1A48256D3D000B1CB2', 148, 'xlzmzb', '逍林镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(5204, 1900, 'ACBAAB2C41073E9148256C2300219F61', 148, 'xlznb', '逍林镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(5205, 1901, '7DF7F545B23EBECC48256EFD0010D83B', 148, 'xlznyzz', '逍林镇副镇长(农)', NULL, NULL, NULL, '', 3, '{}', 88),
(5206, 1902, '5B1806B1498D233F48256F000008D201', 148, 'xlzrdfzx', '逍林镇人大副主席', NULL, NULL, NULL, '', 3, '{}', 88),
(5207, 1903, '35E1222B55C1A8D848256F580009941F', 148, 'xlzrdzx', '逍林镇人大主席', NULL, NULL, NULL, '', 3, '{}', 88),
(5208, 1904, '639FCE6B520D94EE48256C2300201B54', 148, 'xlzrw', '逍林镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(5209, 1905, 'DC21DD37E06FC1B648256EFD00112EE4', 148, 'xlzrwbz', '逍林镇人武部长', NULL, NULL, NULL, '', 3, '{}', 88),
(5210, 1906, '56E11E77BE8F419548256EC5002B6CD9', 148, 'xlzsfs', '逍林镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(5211, 1907, 'C722286EA40DCB1548256ECB0004BE87', 148, 'xlzshoufs', '逍林镇收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(5212, 1908, '82C474C44E34141248256EF400056A98', 148, 'xlztgs', '逍林镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(5213, 1909, '5DA2B3AC9843795348256B380029CCBE', 148, 'xlztjz', '逍林镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(5214, 1910, '734CD6350DDC4A3348256D2B002401C4', 148, 'xlztw', '逍林镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(5215, 1911, '3605B8412A65AD7148256C23001F4ACD', 148, 'xlzwhxc', '逍林镇文化宣传', NULL, NULL, NULL, '', 3, '{}', 88),
(5216, 1912, '1C016968000D105448256EFD0010FE19', 148, 'xlzwwzz', '逍林镇副镇长(文)', NULL, NULL, NULL, '', 3, '{}', 88),
(5217, 1913, '2F003EDC03D5BF2448256EFD001122B2', 148, 'xlzxcwy', '逍林镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5218, 1914, '475E490DD2A1862148256C23001B48CA', 148, 'xlzzfsj', '逍林镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5219, 1915, 'C12FEBE204AF3BCC48256EFD001112B7', 148, 'xlzzjwy', '逍林镇组纪委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5220, 1916, 'A78A27E366CB1DA948256F0C00307078', 148, 'xlzzuzb', '逍林镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(5221, 1917, 'CDD1141AFB5AA9AA482572AB0006FC22', 148, 'xlzzxllw', '逍林镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(5222, 1918, 'CD8EE78890B59A1248256C2300132B9A', 148, 'xlzzz', '逍林镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5223, 1919, 'AC27C214AE06087A48256C2300247361', 148, 'xlzzzb', '逍林镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(5224, 1920, '155AB62D0D57D06C482574880027A508', 150, 'xpzajs', '新浦镇安监所', NULL, NULL, NULL, '', 3, '{}', 88),
(5225, 1921, 'EF71347E0A87FEED48256ED3002C386F', 150, 'xpzcjb', '新浦镇村镇建设办', NULL, NULL, NULL, '', 3, '{}', 88),
(5226, 1922, 'E2C6002A18E8196348256ED3002BFD5C', 150, 'xpzcjzz', '新浦镇副镇长(建)', NULL, NULL, NULL, '', 3, '{}', 88),
(5227, 1923, '7C884D7B9522EB0648257380000DB98F', 150, 'xpzcl', '新浦镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(5228, 1924, 'A7FCC6BFD9A4F5F048256B380029F97C', 150, 'xpzczs', '新浦镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(5229, 1925, '7B167D0E165A16CA48256C42002C263E', 150, 'xpzdqsj', '新浦镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5230, 1926, '609FB8F3AE63736748256C42002C1D97', 150, 'xpzdwsj', '新浦镇党委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5231, 1927, 'C400988C3E157CF048256B380029F5C8', 150, 'xpzdzb', '新浦镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(5232, 1928, 'F9DE2EAF947C3C5748256ED3002C2B90', 150, 'xpzfl', '新浦镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(5233, 1929, '65F0C3296462CC9E48256C42002C3C38', 150, 'xpzgb', '新浦镇工　办', NULL, NULL, NULL, '', 3, '{}', 88),
(5234, 1930, '36E8AAF4CA6CADF9482570520004C1CF', 150, 'xpzgh', '新浦镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(5235, 1931, 'EAC543F75749809048256ED3002BD475', 150, 'xpzgyzz', '新浦镇副镇长(工)', NULL, NULL, NULL, '', 3, '{}', 88),
(5236, 1932, '6EA30CA940C99C4848256C42002C3379', 150, 'xpzjjwy', '新浦镇纪检委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5237, 1933, '07F192AB15E309FA48256B380029F84E', 150, 'xpzjsb', '新浦镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(5238, 1934, 'A4323C7B4D0E722D48256C42002C449C', 150, 'xpzjwb', '新浦镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(5239, 1935, '3CE12E1E91B1E0184825713F00248347', 150, 'xpzllb', '新浦镇老龄办', NULL, NULL, NULL, '', 3, '{}', 88),
(5240, 1936, 'FEBFB0A121F56DF148256ED3002BB7F0', 150, 'xpzms', '新浦镇秘书', NULL, NULL, NULL, '', 3, '{}', 88),
(5241, 1937, '9CC243B061413D1E48256D3D000B253E', 150, 'xpzmzb', '新浦镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(5242, 1938, '3C87365B298A8C0548256C42002C4081', 150, 'xpznb', '新浦镇农　办', NULL, NULL, NULL, '', 3, '{}', 88),
(5243, 1939, 'DECAED85C584C45E48256ED3002BE44E', 150, 'xpznyzz', '新浦镇副镇长(农)', NULL, NULL, NULL, '', 3, '{}', 88),
(5244, 1940, '3D426A2E8E732B8B482574CF000DEC1D', 150, 'xpzpcs', '新浦镇派出所', NULL, NULL, NULL, '', 3, '{}', 88),
(5245, 1941, 'FEBB3B71405C49C248256C42002C48CE', 150, 'xpzrdzxt', '新浦镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(5246, 1942, 'D1696808228E582648256C42002C4CE6', 150, 'xpzrwb', '新浦镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(5247, 1943, '71AC423D0E696BAF48256ED3002C0FAD', 150, 'xpzsbzx', '新浦镇社保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5248, 1944, '7586EB8822E52B9348256ED3002C1DBB', 150, 'xpzscb', '新浦镇三产办', NULL, NULL, NULL, '', 3, '{}', 88),
(5249, 1945, 'D71B18CB7B1F575748256ED7008239B1', 150, 'xpzsfs', '新浦镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(5250, 1946, '9E011656AECEB81548256EF4000590CF', 150, 'xpztgs', '新浦镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(5251, 1947, 'C6964DAA3E00232548256B380029F712', 150, 'xpztjz', '新浦镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(5252, 1948, 'D11F065CB27E508C48256D2B002A034B', 150, 'xpztw', '新浦镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(5253, 1949, '3740E730F94F128748256ED3002BF33D', 150, 'xpzwwzz', '新浦镇副镇长(文)', NULL, NULL, NULL, '', 3, '{}', 88),
(5254, 1950, '222A1BC798395C2548256C23001C4D72', 150, 'xpzwys', '新浦镇收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(5255, 1951, 'EA4E767E977F7584482570BA000D044B', 150, 'xpzxcb', '新浦镇宣传办', NULL, NULL, NULL, '', 3, '{}', 88),
(5256, 1952, 'FAF56BE49CC21C1E48256C42002C37C3', 150, 'xpzxcwy', '新浦镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5257, 1954, '5F2ADCD0A8A611BB482572AB0007150D', 150, 'xpzzxllw', '新浦镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(5258, 1955, '85B682DEDCBE56C048256C42002C2220', 150, 'xpzzz', '新浦镇镇　长', NULL, NULL, NULL, '', 3, '{}', 88),
(5259, 1956, '7A28D76A3567E81348256C23001BAE07', 150, 'xpzzzb', '新浦镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(5260, 1957, 'AFB02C239CD116C548256C42002C2F08', 150, 'xpzzzwy', '新浦镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5261, 1967, 'CB34F4C611AD2CE348256B35003E9FF6', 5, 'xuwd', '市政协许文东', NULL, NULL, NULL, '', 3, '{}', 88),
(5262, 1969, '8F23C904061D425348256B390008492E', 10, 'xuzf', '市府办许忠芬', NULL, NULL, NULL, '', 3, '{}', 88),
(5263, 1970, '30847BB5ADF5CF7348256C230027212E', 8, 'xuzg', '市委办徐张根', NULL, NULL, NULL, '', 3, '{}', 88),
(5264, 1971, 'EC43229AEBD34E7E48256F2A00286308', 102, 'xxlldcz', '信息联络督查组', NULL, NULL, NULL, '', 3, '{}', 88),
(5265, 1975, '78F5281B1735E60A4825717E00033D26', 6, 'yangxq', '开发区杨雪权', NULL, NULL, NULL, '', 3, '{}', 88),
(5266, 1981, '0254F843023B56404825717E0002F831', 6, 'yewn', '开发区叶文努', NULL, NULL, NULL, '', 3, '{}', 88),
(5267, 1982, 'D2F2633FCD4FEE5C4825717E00024A5A', 6, 'yewt', '开发区叶文涛', NULL, NULL, NULL, '', 3, '{}', 88),
(5268, 1984, 'E6BB19E0F2BC748F482574D2000CE730', 140, 'ygbx', '阳光保险', NULL, NULL, NULL, '', 3, '{}', 88),
(5269, 1985, '84A3FA34E44FFAE348256BE20028B233', 11, 'yingcf', '经科和城资环委应长福', NULL, NULL, NULL, '', 3, '{}', 88),
(5270, 1986, 'DD92B01ED78F287048256E47000928D1', 167, 'yjjbgs', '市银监局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5271, 1987, 'DC8E5E80137FA45E48256F2A00287B6F', 102, 'ylfyz', '医疗防疫组', NULL, NULL, NULL, '', 3, '{}', 88),
(5272, 1990, '9C72810C26823AE548256B350005F0B7', 10, 'yum', '市府办余　敏', NULL, NULL, NULL, '', 3, '{}', 88),
(5273, 1991, 'CEE39FD3B2CE8FD448256B3A002BE751', 8, 'yut', '市委办俞　挺', NULL, NULL, NULL, '', 3, '{}', 88),
(5274, 1992, '029A372A5938C7FD4825717E000305A6', 6, 'yuzhou', '开发区俞周', NULL, NULL, NULL, '', 3, '{}', 88),
(5275, 1993, 'D21B048CE220539B48256F2A0028869A', 102, 'zaglz', '治安管理组', NULL, NULL, NULL, '', 3, '{}', 88),
(5276, 1994, '242D8349DE77133C482570AB001FD910', 16, 'zgxxzb', '组工信息专报', NULL, NULL, NULL, '', 3, '{}', 88),
(5277, 1996, '2CFD715A8D7BE3A54825717E0001DD9B', 6, 'zhangjq', '开发区张吉青', NULL, NULL, NULL, '', 3, '{}', 88),
(5278, 1998, '6C1A3BB22ACBF06948256B3A002BDA7D', 77, 'zhangll', '市机关事务管理局张利伦', NULL, NULL, NULL, '', 3, '{}', 88),
(5279, 1999, 'AAB0C36077221E2C48256B39000C0100', 5, 'zhangm', '市政协张明', NULL, NULL, NULL, '', 3, '{}', 88),
(5280, 2003, '1A8AC60DEA2220694825717E00037584', 6, 'zhangwei', '开发区张蔚', NULL, NULL, NULL, '', 3, '{}', 88),
(5281, 2004, 'B155F652E3E69A0248256FD60029123F', 8, 'zhaokai', '市委办赵　凯', NULL, NULL, NULL, '', 3, '{}', 88),
(5282, 2005, '984362E48C2C558148256EED002729CB', 139, 'zhbx', '中华保险慈溪支公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5283, 2008, 'AD456A3BAA2348EF482575C30004E577', 162, 'zhjdcgzd', '宗汉街道城管中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5284, 2009, 'B989B6460366BF0748256C31002F4866', 162, 'zhjdcjb', '宗汉街道城建办', NULL, NULL, NULL, '', 3, '{}', 88),
(5285, 2010, 'CA0DA9CFC6875EF348257380000ED391', 162, 'zhjdcl', '宗汉街道残联', NULL, NULL, NULL, '', 3, '{}', 88),
(5286, 2011, '6F2F93B2CCCBE07748256B38002AE63D', 162, 'zhjdczs', '宗汉街道财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(5287, 2012, 'E7F14F26A1EEF38348256C31002EB5C9', 162, 'zhjddqsj', '宗汉街道党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5288, 2013, '4156FE2DF67A864D48256B38002AE4F3', 162, 'zhjddzb', '宗汉街道综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(5289, 2014, 'CF07D3F0EDDAE052482570520004E2F2', 162, 'zhjdgh', '宗汉街道工会', NULL, NULL, NULL, '', 3, '{}', 88),
(5290, 2015, '187DE21C9B08293448256C3200078B83', 162, 'zhjdgqf', '宗汉街道妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(5291, 2016, '6819F4D74A5C6CAC48256C31002ED0EC', 162, 'zhjdjfb', '宗汉街道经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(5292, 2017, 'F1ADDA5CD5AE5A6E48256C3200078FA9', 162, 'zhjdjjb', '宗汉街道纪检办', NULL, NULL, NULL, '', 3, '{}', 88),
(5293, 2018, '138806ABBC76E5BD48256C31002EC31B', 162, 'zhjdjjwy', '宗汉街道纪检委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5294, 2019, 'F38834182073D89748256FC100225BA8', 162, 'zhjdjpb', '宗汉街道经普办', NULL, NULL, NULL, '', 3, '{}', 88),
(5295, 2020, 'E9FD462E59D3042D48256B38002AE8EC', 162, 'zhjdjsb', '宗汉街道计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(5296, 2021, 'E02E0B4BDF8B277448256C31002ED98F', 162, 'zhjdjwb', '宗汉街道教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(5297, 2022, '1072F2F66F53BA66482573980009D4AE', 162, 'zhjdmsb', '宗汉街道秘书办', NULL, NULL, NULL, '', 3, '{}', 88),
(5298, 2023, '96F126C05653CC5248256D40000422D0', 162, 'zhjdmzb', '宗汉街道民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(5299, 2024, '48F0A8A5A169B6C948256C31002ED576', 162, 'zhjdnb', '宗汉街道农办', NULL, NULL, NULL, '', 3, '{}', 88),
(5300, 2025, '2067D1ACFF0E027448256C320007825D', 162, 'zhjdrdgw', '宗汉街道人大工委', NULL, NULL, NULL, '', 3, '{}', 88),
(5301, 2026, '6221C8FFE581071D4825707D000DE377', 162, 'zhjdsbzx', '宗汉街道社保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5302, 2027, '840981453DC8355048256C3200079801', 162, 'zhjdscb', '宗汉街道三产办', NULL, NULL, NULL, '', 3, '{}', 88),
(5303, 2028, 'CA6FF381BDF88E6F48256C31002EACA7', 162, 'zhjdsj', '宗汉街道书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5304, 2029, '045A44898E4C21DA48256EF40006B27B', 162, 'zhjdtgs', '宗汉街道国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(5305, 2030, '189C76F9CAD61C9248256B38002AE77F', 162, 'zhjdtjz', '宗汉街道统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(5306, 2031, '68BAB55A9BF0B68648256D2B002A39F0', 162, 'zhjdtw', '宗汉街道团委', NULL, NULL, NULL, '', 3, '{}', 88),
(5307, 2032, '7403598A1A541E25482573980009E846', 162, 'zhjdwlgl', '宗汉街道网络管理', NULL, NULL, NULL, '', 3, '{}', 88),
(5308, 2033, '9106FF10F427191648256C3200079C66', 162, 'zhjdwys', '宗汉街道文印室', NULL, NULL, NULL, '', 3, '{}', 88),
(5309, 2034, '3BA9FD4146446B3348256C3200077DA6', 162, 'zhjdwzb', '宗汉街道武装部', NULL, NULL, NULL, '', 3, '{}', 88),
(5310, 2035, '40098C164CBFA7BB48256C32000793A9', 162, 'zhjdxcb', '宗汉街道宣传办', NULL, NULL, NULL, '', 3, '{}', 88),
(5311, 2036, 'DAE7BF4824FDF0C848256C31002EC831', 162, 'zhjdxcwy', '宗汉街道宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5312, 2037, '28FC0D59C51F4CA548256C31002EBA4C', 162, 'zhjdzfsj', '宗汉街道政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5313, 2038, 'D6DA9A8A4ED945A448256FB100050F69', 162, 'zhjdzkjs', '宗汉街道暂口计生', NULL, NULL, NULL, '', 3, '{}', 88),
(5314, 2039, 'B57836F9CFAD595B48256C31002EB161', 162, 'zhjdzr', '宗汉街道主任', NULL, NULL, NULL, '', 3, '{}', 88),
(5315, 2040, 'AF55F937D4A13D2E48256C320008D2F2', 162, 'zhjdzuzb', '宗汉街道组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(5316, 2041, '762D5EBDCABDCF82482574900034FA3C', 162, 'zhjdzx', '宗汉街道政协', NULL, NULL, NULL, '', 3, '{}', 88),
(5317, 2042, '1D915F156A9CFFF448256C320007872B', 162, 'zhjdzxllw', '宗汉街道政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(5318, 2043, '99317599094C7E3D48256C31002ECC89', 162, 'zhjdzzb', '宗汉街道综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(5319, 2044, 'F7ACE6AAF8222980482575C10027B3A5', 162, 'zhjdzzwy', '宗汉街道组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5320, 2049, 'AE510916D4586B424825717E0001ECFE', 6, 'zhoulj', '开发区周丽娟', NULL, NULL, NULL, '', 3, '{}', 88),
(5321, 2050, 'A03EAC92EA7127A1482571DF00037E39', 10, 'zhouym', '市府办周益明', NULL, NULL, NULL, '', 3, '{}', 88),
(5322, 2051, 'A965BA2C7E2AE4AF48256B3A002BE8F2', 8, 'zhuyg', '市委办09', NULL, NULL, NULL, '', 3, '{}', 88),
(5323, 2052, '5EA64D64C5CCD0314825717E00023D9F', 6, 'zhuyx', '开发区朱炎新', NULL, NULL, NULL, '', 3, '{}', 88),
(5324, 2053, 'B9A001A6AAA3461E48256F2A002858E7', 102, 'zhxtz', '综合协调组', NULL, NULL, NULL, '', 3, '{}', 88),
(5325, 2054, '9D3135DB5C1C2276482572480008CD0E', 2, 'zjr', '市委张建人', NULL, NULL, NULL, '', 3, '{}', 88),
(5326, 2055, '3F42971312B8DCF0482573640011B0DC', 127, 'zjsyyh', '浙商银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5327, 2056, 'CBC9A96C8CA2FF3148256EE700064BF0', 112, 'zjtx', '浙江通信', NULL, NULL, NULL, '', 3, '{}', 88),
(5328, 2057, '78DF484301957449482570E30024FB62', 10, 'zouj', '市府办邹晋', NULL, NULL, NULL, '', 3, '{}', 88),
(5329, 2058, '7F382B164FC38E4148257380000D1B2F', 145, 'zqzcl', '掌起镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(5330, 2059, '34A1BBB82BF4CE2A48256C4E00054320', 145, 'zqzczjsb', '掌起镇村镇建设办', NULL, NULL, NULL, '', 3, '{}', 88),
(5331, 2060, '23E727110C2CF8D648256B3800284884', 145, 'zqzczs', '掌起镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(5332, 2061, '0860D7094434272B48256C4E00053864', 145, 'zqzdqb', '掌起镇党群办', NULL, NULL, NULL, '', 3, '{}', 88),
(5333, 2062, '74BAE33F8747184C48256C4E000532EB', 145, 'zqzdqsj', '掌起镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5334, 2063, 'B7A9E1A197537C3D48256C4E00052C04', 145, 'zqzdwsj', '掌起镇党委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5335, 2064, '374289CA34C597C248256B380028443A', 145, 'zqzdzb', '掌起镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(5336, 2065, 'A965D459D13B861548257253000CDDBD', 145, 'zqzfl', '掌起镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(5337, 2066, '7D9D1D4FA7C4236948256E53002CAE28', 145, 'zqzfzzg', '掌起镇副镇长（工）', NULL, NULL, NULL, '', 3, '{}', 88),
(5338, 2067, '673918BCA3BCE46E48256E53002CB7E2', 145, 'zqzfzzj', '掌起镇副镇长（建）', NULL, NULL, NULL, '', 3, '{}', 88),
(5339, 2068, '305947316533E0EE48256E53002CB2AA', 145, 'zqzfzzn', '掌起镇副镇长（农）', NULL, NULL, NULL, '', 3, '{}', 88),
(5340, 2069, 'FBE932BC18A5E2D448256EED0026FFDE', 145, 'zqzfzzw', '掌起镇副镇长(文)', NULL, NULL, NULL, '', 3, '{}', 88),
(5341, 2070, '1C419F53B811D5B9482570520004D0B0', 145, 'zqzgh', '掌起镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(5342, 2071, '36105EB89B5E3BC948256C4E00053DDD', 145, 'zqzjfb', '掌起镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(5343, 2072, '3D76B58D96ADD00348256B3800284712', 145, 'zqzjsb', '掌起镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(5344, 2073, '59BAC35DFCCC94AE48256E53002CBC5F', 145, 'zqzjw', '掌起镇纪　委', NULL, NULL, NULL, '', 3, '{}', 88),
(5345, 2074, 'BE5E30406231E3CB48256C4E00053AF3', 145, 'zqzjwb', '掌起镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(5346, 2075, 'D8E04AAC3CD0054748256E53002CCDE1', 145, 'zqzms', '掌起镇秘　书', NULL, NULL, NULL, '', 3, '{}', 88),
(5347, 2076, 'B0DD29DF4D0BD4E948256D3D000B1061', 145, 'zqzmzb', '掌起镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(5348, 2077, 'A9786CCE5C30BB3648256C4E00054095', 145, 'zqznb', '掌起镇农办', NULL, NULL, NULL, '', 3, '{}', 88),
(5349, 2078, 'FE4309BE5DBF38A648256C4E00054576', 145, 'zqzrdzxt', '掌起镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(5350, 2079, '2AB73C321DEE8D5F48256C4E000547B9', 145, 'zqzrwb', '掌起镇人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(5351, 2080, '4F180A1EB01DA9C448256E53002CC551', 145, 'zqzsbzx', '掌起镇社保中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5352, 2081, '297E4FB57C557A3048256E53002CC997', 145, 'zqzsfs', '掌起镇收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(5353, 2082, '3A474848F5BC215A48256EF4000539AE', 145, 'zqztgs', '掌起镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(5354, 2083, '1CBA655C2F2065CE48256B3800284598', 145, 'zqztjz', '掌起镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(5355, 2084, '510513CF942E5F8748256D2B0023DE6B', 145, 'zqztw', '掌起镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(5356, 2085, 'C7D0FEEC4DF7CB3248256E53002CA9A2', 145, 'zqzwywz', '掌起镇委员（武装）', NULL, NULL, NULL, '', 3, '{}', 88),
(5357, 2086, '12722112EC77899748256E53002CA4E2', 145, 'zqzwyxc', '掌起镇委员（宣传）', NULL, NULL, NULL, '', 3, '{}', 88),
(5358, 2087, '1CFD7B35729FA87E48256E53002CA034', 145, 'zqzwyzj', '掌起镇委员（组织）', NULL, NULL, NULL, '', 3, '{}', 88),
(5359, 2088, 'EDE3719CF20E3B8F48256C4E000535AE', 145, 'zqzzfsj', '掌起镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5360, 2089, '43301B470537DBA3482572AB0006D09D', 145, 'zqzzxllw', '掌起镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(5361, 2090, 'B727797DA21FFE2148256C4E00052F5D', 145, 'zqzzz', '掌起镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5362, 2091, 'B1E20742427195D148256E53002CC0D8', 145, 'zqzzzb', '掌起镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(5363, 2093, '7887E666599AE3E348256D560009B96E', 158, 'zxzcjzz', '周巷镇城建镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5364, 2094, '44657DCEDD98A9DF48257380000E97F9', 158, 'zxzcl', '周巷镇残联', NULL, NULL, NULL, '', 3, '{}', 88),
(5365, 2095, 'CEB6B6565619D11248256D560009D915', 158, 'zxzczb', '周巷镇村镇办', NULL, NULL, NULL, '', 3, '{}', 88),
(5366, 2096, '1AC0551138D7AAAD48256B38002AC24A', 158, 'zxzczs', '周巷镇财政所', NULL, NULL, NULL, '', 3, '{}', 88),
(5367, 2097, '6DFB9BA32045F4DF48256D560009C5A4', 158, 'zxzdqb', '周巷镇党群办', NULL, NULL, NULL, '', 3, '{}', 88),
(5368, 2098, '7910F2EE02DBF4CC48256C430028B60E', 158, 'zxzdqsj', '周巷镇党群书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5369, 2099, 'BE43A943528D59A148256B38002ABFF4', 158, 'zxzdzb', '周巷镇综合办', NULL, NULL, NULL, '', 3, '{}', 88),
(5370, 2100, '05299E60D6FB1E6B4825707700293DE4', 158, 'zxzfl', '周巷镇妇联', NULL, NULL, NULL, '', 3, '{}', 88),
(5371, 2101, '10D5F57AABFEF64D482570520004D95B', 158, 'zxzgh', '周巷镇工会', NULL, NULL, NULL, '', 3, '{}', 88),
(5372, 2102, '6F6D9EFDB1539A5648256D560009ADA3', 158, 'zxzgyzz', '周巷镇工业镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5373, 2103, '8B8BCAF5A5D2F9D7482571A90008E91E', 158, 'zxzhzb', '周巷镇环治办', NULL, NULL, NULL, '', 3, '{}', 88),
(5374, 2104, '4BDB702FDC476C7248256D560009CD7B', 158, 'zxzjfb', '周巷镇经发办', NULL, NULL, NULL, '', 3, '{}', 88),
(5375, 2105, 'BA60870073F106D848256B38002AC122', 158, 'zxzjsb', '周巷镇计生办', NULL, NULL, NULL, '', 3, '{}', 88),
(5376, 2106, '9D669A56DB9774D448256D560009D554', 158, 'zxzjwb', '周巷镇教卫办', NULL, NULL, NULL, '', 3, '{}', 88),
(5377, 2107, '3E658B62F67545D2482572D500103AF2', 158, 'zxzlbs', '周巷镇劳动保障管理服务所', NULL, NULL, NULL, '', 3, '{}', 88),
(5378, 2108, '828C8511FF4A385348256D4000041A2D', 158, 'zxzmzb', '周巷镇民政办', NULL, NULL, NULL, '', 3, '{}', 88),
(5379, 2109, '9359BECFBEE3A19448256D560009D1B2', 158, 'zxznb', '周巷镇农　办', NULL, NULL, NULL, '', 3, '{}', 88),
(5380, 2110, 'E7A901134412926E48256D560009B1B5', 158, 'zxznyzz', '周巷镇农业镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5381, 2111, '0DE381033E256C7C48256C430028BE61', 158, 'zxzrdzxt', '周巷镇人大主席团', NULL, NULL, NULL, '', 3, '{}', 88),
(5382, 2112, '63404C4557DED2AB48256D560009A577', 158, 'zxzrwwy', '周巷镇人武委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5383, 2113, '373C879759262E0F48256ECF000C8D2B', 158, 'zxzsfs', '周巷镇司法所', NULL, NULL, NULL, '', 3, '{}', 88),
(5384, 2114, '118AB2862CD3720848256C430028AD5D', 158, 'zxzsj', '周巷镇孙黎明', NULL, NULL, NULL, '', 3, '{}', 88),
(5385, 2115, 'B98B7BFB3E3640CE48256D57000A6C27', 158, 'zxzsws', '周巷镇收文室', NULL, NULL, NULL, '', 3, '{}', 88),
(5386, 2116, 'C27CD4A45A89D53748256C430028CB4D', 158, 'zxztgs', '周巷镇国土资源分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5387, 2117, 'A5469734B83BEA6D48256B38002AC397', 158, 'zxztjz', '周巷镇统计站', NULL, NULL, NULL, '', 3, '{}', 88),
(5388, 2118, '9AA6C3F07582B08A48256D2B002A3154', 158, 'zxztw', '周巷镇团　委', NULL, NULL, NULL, '', 3, '{}', 88),
(5389, 2119, '16A420FFCE27E27E48256D560009B5B8', 158, 'zxzwwzz', '周巷镇文卫镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5390, 2120, '07A50DB286D4956A48256C430028C708', 158, 'zxzxcb', '周巷镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5391, 2121, '1D34432EE098B2D148256C430028BA57', 158, 'zxzzfsj', '周巷镇政法书记', NULL, NULL, NULL, '', 3, '{}', 88),
(5392, 2122, 'B6EE0F234FC260E948256D560009C9A7', 158, 'zxzzongzb', '周巷镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(5393, 2123, '7AB3008E4A84EE5F482572AB00077BDC', 158, 'zxzzxllw', '周巷镇政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(5394, 2124, '58280F442C2103BA48256C430028B1A8', 158, 'zxzzz', '周巷镇镇　长', NULL, NULL, NULL, '', 3, '{}', 88),
(5395, 2125, 'D651F68AD72C23B948256C430028C2A8', 158, 'zxzzzb', '周巷镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5396, 2126, 'F055E45B67B438DD48256BB5000B0E09', 52, 'zyjsryglk', '市人事局史训成', NULL, NULL, NULL, '', 3, '{}', 88),
(5397, 2129, '1F06546CE3F5E55B482575E8002A2D29', 6, 'kfqcb', '开发区投资合作局陈斌', NULL, NULL, NULL, '', 3, '{}', 88),
(5398, 2130, '32B366A508242A33482575E8002A39AB', 6, 'kfqcg', '规划建设局陈戈', NULL, NULL, NULL, '', 3, '{}', 88),
(5399, 2131, '79A8EFFC6695249E482575E8002A2416', 6, 'kfqcld', '开发区柴利达', NULL, NULL, NULL, '', 3, '{}', 88),
(5400, 2132, '08352C0B5F738CC1482575E8002A3161', 6, 'kfqhjd', '投资合作局胡建东', NULL, NULL, NULL, '', 3, '{}', 88),
(5401, 2133, '7C5973A6CFEC0584482575E8002A3DC6', 6, 'kfqhjf', '规划建设局胡纪芳', NULL, NULL, NULL, '', 3, '{}', 88),
(5402, 2134, 'E90A4C407A912FDE482575E8002A358E', 6, 'kfqhyq', '规划建设局胡宇泉', NULL, NULL, NULL, '', 3, '{}', 88),
(5403, 2135, '9295E436F8996FC0482575E8002A421A', 6, 'kfqxqx', '国土资源局徐琪雄', NULL, NULL, NULL, '', 3, '{}', 88),
(5404, 2136, 'E587FC35B1440756482575E8002A28C7', 6, 'kfqzwd', '办公室张伟东', NULL, NULL, NULL, '', 3, '{}', 88),
(5405, 2138, 'C88798F7DBE096BA482575FA00017248', 164, 'qlzq', '齐鲁证券', NULL, NULL, NULL, '', 3, '{}', 88),
(5406, 2139, 'F3DAF0822FC46FBB482575FC00054F29', 17, 'sskybgs', '市社科联（院）秘书长', NULL, NULL, NULL, '', 3, '{}', 88),
(5407, 2142, '0CFCCBE7E1C7E7C14825760000117B2B', 156, 'chzshsyb', '长河镇社会事业办', NULL, NULL, NULL, '', 3, '{}', 88),
(5408, 2144, '2EB6AD73E100BA9548257604000F1D32', 154, 'cszll', '崇寿镇老龄委', NULL, NULL, NULL, '', 3, '{}', 88),
(5409, 2146, '63BDE44158106C214825761600308834', 149, 'sszllb', '胜山镇老龄办', NULL, NULL, NULL, '', 3, '{}', 88),
(5410, 2149, 'D2CCA88E101672E248257617000DE019', 144, 'lszjsxh', '龙山镇计生协会', NULL, NULL, NULL, '', 3, '{}', 88),
(5411, 2151, '4F763CE2F8DB0E2448257624002B8EC9', 32, 'sgsl1', '市工商联张新江', NULL, NULL, NULL, '', 3, '{}', 88),
(5412, 2152, '42FC4C990247923348257624002B93E6', 32, 'sgsl2', '市工商联姚焕明', NULL, NULL, NULL, '', 3, '{}', 88),
(5413, 2153, '2516E6D9C42888A44825762A000DFA0A', 13, 'sfyxzk', '市法院行政科', NULL, NULL, NULL, '', 3, '{}', 88),
(5414, 2154, '248CDE19693C7D7D4825762C0002AD97', 13, 'sfy1', '市法院陈云祥', NULL, NULL, NULL, '', 3, '{}', 88),
(5415, 2155, 'F11FA36DBF873D654825762C0002B4A8', 13, 'sfy2', '市法院夏文俊', NULL, NULL, NULL, '', 3, '{}', 88),
(5416, 2156, '9BDA173BC07C292F4825762C0002BA86', 13, 'sfy3', '市法院胡乔斐', NULL, NULL, NULL, '', 3, '{}', 88),
(5417, 2157, '086B2F12657185F24825762C0002C0C1', 13, 'sfy4', '市法院周朝晖', NULL, NULL, NULL, '', 3, '{}', 88),
(5418, 2160, '0484FD5BBD13F55F4825762C0002D39A', 13, 'sfy7', '市法院钟志平', NULL, NULL, NULL, '', 3, '{}', 88),
(5419, 2161, '709B3EB8F0B5DF144825762C0002A24E', 13, 'sfyxfs', '市法院信访室', NULL, NULL, NULL, '', 3, '{}', 88),
(5420, 2162, '0F9D74363BEE82C74825762C0002A7C1', 13, 'sfyzzc', '市法院政治处', NULL, NULL, NULL, '', 3, '{}', 88),
(5421, 2163, '2048D3ED934253DD482576330002552B', 161, 'bsljdmsb', '白沙路街道秘书办', NULL, NULL, NULL, '', 3, '{}', 88),
(5422, 2164, 'C61C66468504EFAB4825763300025AFC', 161, 'bsljdrwb', '白沙路街道人武部', NULL, NULL, NULL, '', 3, '{}', 88),
(5423, 2165, 'E9837F2B02B1A6EA4825763400079544', 17, 'swxcb5', '市委宣传部吴继生', NULL, NULL, NULL, '', 3, '{}', 88),
(5424, 2166, '7CA4DB8EFFC96C3548257639000D978C', 166, 'sgfyh', '市广发银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5425, 2167, '1B410627EFEC97BE4825763E00248945', 8, 'swbhgz', '市委办华贯�\\', NULL, NULL, NULL, '', 3, '{}', 88),
(5426, 2168, '75C0404AB6E7B9684825764B0028026A', 63, 'swsjjjzx', '市急救中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5427, 2170, '15E14DA2D37FCA7F4825766600066984', 99, 'sxdnykfqjjk', '市现代农业开发区管委会基建科', NULL, NULL, NULL, '', 3, '{}', 88),
(5428, 2172, '6C5885C43A55E1AB48257666000662BC', 99, 'sxdnykfqzsk', '市现代农业开发区管委会招商科', NULL, NULL, NULL, '', 3, '{}', 88),
(5429, 2174, 'C85450ED6FEBF6034825766B00280494', 6, 'skfqgsfj3', '开发区工商分局徐剑铭', NULL, NULL, NULL, '', 3, '{}', 88),
(5430, 2175, '93699F3320E0439F4825767000066D3A', 56, 'ghjjcs', '市规划局监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5431, 2176, '73C109D05A8FADFC48257670000666D4', 54, 'stgjjzs6', '市国土资源局张建土', NULL, NULL, NULL, '', 3, '{}', 88),
(5432, 2177, '4D8B780E77753FE248257677002939C3', 12, 'sjcyzcjdk', '市检察院侦查监督科', NULL, NULL, NULL, '', 3, '{}', 88),
(5433, 2178, '8823CE8C3107DD534825767700048C1C', 73, 'snjzz1', '市农机局程尚毅', NULL, NULL, NULL, '', 3, '{}', 88),
(5434, 2179, '8602F9FA50A0C75648257677000492B0', 73, 'snjzz2', '市农机局王志孟', NULL, NULL, NULL, '', 3, '{}', 88),
(5435, 2180, 'A180E01538305E734825767700049988', 73, 'snjzz3', '市农机局陈彩霞', NULL, NULL, NULL, '', 3, '{}', 88),
(5436, 2181, '3D480CA1F8D010CF482576770004A0C8', 73, 'snjzz4', '市农机局周建丰', NULL, NULL, NULL, '', 3, '{}', 88),
(5437, 2182, '448664CFC266B790482576770004A780', 73, 'snjzzcws', '市农机局财务室', NULL, NULL, NULL, '', 3, '{}', 88),
(5438, 2183, '240407F692F91F08482576770004B534', 73, 'snjzzglk', '市农机局管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(5439, 2184, '7402E7CBD8CD3376482576770004BC1B', 73, 'snjzzjlz', '市农机局监理站', NULL, NULL, NULL, '', 3, '{}', 88),
(5440, 2185, '3AA81CF6A20C39ED482576770004AE61', 73, 'snjzztgk', '市农机局推广科', NULL, NULL, NULL, '', 3, '{}', 88),
(5441, 2186, '06DA3C98D672F673482576770004C2ED', 73, 'snjzztgz', '市农机局推广站', NULL, NULL, NULL, '', 3, '{}', 88),
(5442, 2187, '8EA25F9C7B620FD44825768100039E37', 47, 'smzjmwb', '市民政局募委办', NULL, NULL, NULL, '', 3, '{}', 88),
(5443, 2188, '7FD9D04ACF8AC6A74825768D0007A58E', 2, 'swzfc', '市委朱法传', NULL, NULL, NULL, '', 3, '{}', 88),
(5444, 2189, '715272B75E3FBA7448257695000DED5F', 154, 'cszwwzz', '崇寿镇文卫镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5445, 2190, '925C17AA3059BADD482576960001A0DB', 30, 'tswqgb', '团市委青工部', NULL, NULL, NULL, '', 3, '{}', 88),
(5446, 2191, '72203F06A52A5ECF4825769600019A71', 30, 'tswqnb', '团市委青农部', NULL, NULL, NULL, '', 3, '{}', 88),
(5447, 2192, '49A6DB610CACB0754825769700025190', 60, 'smylsjkj', '市商务局会计', NULL, NULL, NULL, '', 3, '{}', 88),
(5448, 2193, 'DAAD91CF912D7AEF4825769C000B3E4F', 39, 'stjjrpb', '市人普办', NULL, NULL, NULL, '', 3, '{}', 88),
(5449, 2194, '3EE3B065ED7E70504825769D0005F217', 8, 'swbhxj', '市委办胡学健', NULL, NULL, NULL, '', 3, '{}', 88),
(5450, 2200, '5B9949B12A23193B482576A20009F873', 168, 'sczyh', '市村镇银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5451, 2201, 'DF329A2947B0B978482576A1002DF761', 57, 'sjtjzhb', '市交通运输局公路建设工程指挥部', NULL, NULL, NULL, '', 3, '{}', 88),
(5452, 2202, '8C7D17935476C6A8482576A20006415F', 3, 'swsbn', '市人大孙百南', NULL, NULL, NULL, '', 3, '{}', 88),
(5453, 2203, '06B9FDD408A29843482576A20009EA82', 169, 'tlsyyh', '泰隆商业银行慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5454, 2204, '6AC7D78F5B1DD811482576A20009F144', 170, 'zhyhnbyczh', '中国银行宁波余慈支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5455, 2205, '1F18287B8F367082482576A20010197D', 6, 'skfqhsz', '开发区胡守治', NULL, NULL, NULL, '', 3, '{}', 88),
(5456, 2209, '1971303E59EB16F9482576A4000D9D4B', 10, 'sfbsn', '市府办沈娜', NULL, NULL, NULL, '', 3, '{}', 88),
(5457, 2211, '7DFCBCDACC4BACDD48256E07002A428B', 65, 'ssjjjzs5', '市审计局包建光', NULL, NULL, NULL, '', 3, '{}', 88),
(5458, 2213, '37CC15E00813CDBB482576A5000E4F99', 66, 'shbjjcs', '市环保局监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5459, 2214, 'F22BCF8F441A8D8A482576A5000E55C5', 66, 'shbjlsfj', '市环保局龙山分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5460, 2216, 'C3B03623079A5A04482576A900061389', 59, 'ssljjz8', '市水利局边福春', NULL, NULL, NULL, '', 3, '{}', 88),
(5461, 2218, 'D49FF3DB92BDA0D9482576AA00064FB0', 45, 'sgajjddd', '市公安局禁毒大队', NULL, NULL, NULL, '', 3, '{}', 88),
(5462, 2219, '5FC77236A89BD987482576AA00049F7B', 57, 'sjtj7', '市交通运输局孙国振', NULL, NULL, NULL, '', 3, '{}', 88),
(5463, 2220, '9C0697FEB602002E482576A900217FBE', 8, 'swbllf', '市委办罗立峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5464, 2222, '8F0A47938E66B80A482576AB002A4CEE', 28, 'sdaj6', '市档案局周聪波', NULL, NULL, NULL, '', 3, '{}', 88),
(5465, 2226, 'FC4FF3473AE95ED0482576AF00037772', 24, 'swlgbj4', '市委老干部局胡亚波', NULL, NULL, NULL, '', 3, '{}', 88),
(5466, 2227, 'ACEBA379DBFB4176482576AF000ECEBD', 54, 'stgjjzs7', '市国土资源局岑迪洲', NULL, NULL, NULL, '', 3, '{}', 88),
(5467, 2228, 'C37D3BEC5F03BA9D482576AF002D1582', 62, 'swtjjzs6', '市文广局戚根龙', NULL, NULL, NULL, '', 3, '{}', 88),
(5468, 2230, '8CCA2206375DF082482576B2002C2615', 153, 'hhzrd1', '横河镇谢华君', NULL, NULL, NULL, '', 3, '{}', 88),
(5469, 2231, 'A28133A71A55B29C482576B2002C2D1B', 153, 'hhzrd2', '横河镇孙国', NULL, NULL, NULL, '', 3, '{}', 88),
(5470, 2232, '0DB5324F90BD15D4482576B2002AA85D', 18, 'swtzb4', '市委统战部王立峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5471, 2234, '5311640348293EE4482576B2002AB63B', 18, 'swtzb6', '市委统战部卢银鼎', NULL, NULL, NULL, '', 3, '{}', 88),
(5472, 2235, 'F12B8770F7CF8A13482576B2002AEA2F', 150, 'xpzrd1', '新浦镇陈国焕', NULL, NULL, NULL, '', 3, '{}', 88),
(5473, 2236, '9B7D5C691003ED1A482576B2002AF0A4', 150, 'xpzrd2', '新浦镇人大副主席', NULL, NULL, NULL, '', 3, '{}', 88),
(5474, 2237, '913ABD3921524EFA482576B80010A0BB', 171, 'sjdqylhh', '市家电企业联合会', NULL, NULL, NULL, '', 3, '{}', 88),
(5475, 2238, 'D55D566EF2EBAB73482576BD000CE96A', 20, 'swzfw8', '市委政法委张立敏', NULL, NULL, NULL, '', 3, '{}', 88),
(5476, 2239, '6C796E95813761FF482576BD000CF05E', 20, 'swzfw9', '市委政法委孙��峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5477, 2240, 'C85469AE6B96199E482576C000034EAD', 32, 'sgsl3', '市工商联郭国芳', NULL, NULL, NULL, '', 3, '{}', 88),
(5478, 2241, '903EE4D0D329DCAB482576C00003560E', 32, 'sgsl4', '市工商联诸言者', NULL, NULL, NULL, '', 3, '{}', 88),
(5479, 2242, '8649A94464324449482576C40008FB32', 203, 'smylsjjdfw', '市商贸集团有限公司信息中心（家电服务中心）', NULL, NULL, NULL, '', 3, '{}', 88),
(5480, 2243, '2FE4F54480205F9B482576C6001DDC8E', 60, 'smylsjlssc', '市商务局粮食收储公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5481, 2244, '1AC1650159BCFF5F482576C7000DB1F6', 172, 'scngzjszhb', '市城南改造建设指挥部综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(5482, 2246, '4EAC70881554372E482576D500094218', 33, 'scl5', '市残联汪展淼', NULL, NULL, NULL, '', 3, '{}', 88),
(5483, 2248, '968869B94E29E74E482576DC002CF4EC', 172, 'scn1', '市城南改造建设指挥部邹柏涌', NULL, NULL, NULL, '', 3, '{}', 88),
(5484, 2249, '66BE92EA1BC32B82482576DC002CFB5F', 172, 'scn2', '市城南改造建设指挥部马迪飞', NULL, NULL, NULL, '', 3, '{}', 88);
INSERT INTO `staff_tbl` (`staff_id`, `out_id`, `staff_unid`, `unit`, `staff_name`, `full_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`, `user_admin`, `reorder`) VALUES
(5485, 2253, 'CA78A5B7D556F2AA482576DC002D16BA', 172, 'scn6', '市城南改造建设指挥部桑健波', NULL, NULL, NULL, '', 3, '{}', 88),
(5486, 2254, 'BB8362860D3B0603482576DC002D24D0', 172, 'scndqk', '市城南改造建设指挥部动迁科', NULL, NULL, NULL, '', 3, '{}', 88),
(5487, 2255, '888A1A438826F35E482576DC002D1DB1', 172, 'scnjsk', '市城南改造建设指挥部建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(5488, 2256, '882252941BE66B7A482576DC0003A167', 16, 'sdyfwzx', '市党群服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5489, 2257, '4AF47781965959EE482576E20010310C', 75, 'scgbclzx', '市综合行政执法局（市城管局）违章处理中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5490, 2259, '7852B1D64ABE3B67482576EF000B507D', 56, 'ghjxzspk', '市规划局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(5491, 2262, '67BD201CF1BD5205482576FD0029A8FB', 151, 'qtzpcsz', '桥头镇派出所长', NULL, NULL, NULL, '', 3, '{}', 88),
(5492, 2263, 'BB6CC9D23149B17B48257700000BA603', 81, 'sztbbgs4', '市公共资源交管办邵杰飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5493, 2266, '77AAAAA46F58A8A24825770B00268CF6', 161, 'bsljdrkpcb', '白沙路街道人口普查办', NULL, NULL, NULL, '', 3, '{}', 88),
(5494, 2267, '0F8FF8124C4B520F4825770C00085C93', 173, 'sxxcybgs', '慈溪高新技术产业开发区管理委员会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5495, 2268, 'D61EF42F110B03D34825771200236BB9', 45, 'sgajsbabb', '市公安局治安大队', NULL, NULL, NULL, '', 3, '{}', 88),
(5496, 2269, '67B381E26BEC6E4548257713002C697C', 173, 'sxxcybgs1', '慈溪高新技术产业开发区管理委员会陈颖', NULL, NULL, NULL, '', 3, '{}', 88),
(5497, 2270, 'D9A93C9065191BEF48257713002C70E1', 173, 'sxxcybgs2', '慈溪高新技术产业开发区管理委员会李洪波', NULL, NULL, NULL, '', 3, '{}', 88),
(5498, 2271, 'A4E52862207AB78248257713002C77AA', 173, 'sxxcybgs3', '慈溪高新技术产业开发区管理委员会顾通建', NULL, NULL, NULL, '', 3, '{}', 88),
(5499, 2272, 'E0695B7D23415D0B48257713002C7E93', 173, 'sxxcybgs4', '慈溪高新技术产业开发区管理委员会投资合作科', NULL, NULL, NULL, '', 3, '{}', 88),
(5500, 2273, 'D44A3DB57A3128B348257715000656B2', 76, '81890', '81890', NULL, NULL, NULL, '', 3, '{}', 88),
(5501, 2274, 'FDEBD012082DC42D4825771500065D9E', 76, '81890zr', '81890主任', NULL, NULL, NULL, '', 3, '{}', 88),
(5502, 2275, 'BC7F1E7FE55D6E8D48257715000A0290', 154, 'cszpcssz', '崇寿镇派出所所长', NULL, NULL, NULL, '', 3, '{}', 88),
(5503, 2276, '806E008A213F3E184825771500064F5E', 76, 'lpzxzrs4', '市行政服务中心景利明', NULL, NULL, NULL, '', 3, '{}', 88),
(5504, 2277, '4FB33C59E2909A254825771B00081445', 146, 'ghwzcj', '观海卫镇城建副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5505, 2278, 'FC317B5BE9D82BEF4825771B0008005E', 146, 'ghwzgy', '观海卫镇工业副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5506, 2279, '6CFE35AE02A17BF74825771B0008071E', 146, 'ghwzny', '观海卫镇农业副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5507, 2280, 'CF3922846B89C0784825771B00080D8B', 146, 'ghwzshsy', '观海卫镇社会事业副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5508, 2281, 'F833736A7AA35B344825771B00081B8B', 146, 'ghwzxfzd', '观海卫镇消防中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5509, 2283, '67C9E2A6EF1B3F504825772000061F87', 158, 'zxzpcs', '周巷中心派出所', NULL, NULL, NULL, '', 3, '{}', 88),
(5510, 2284, 'C908DF6DDF84E2E84825773400119538', 10, 'sfbyd', '市府办俞旦', NULL, NULL, NULL, '', 3, '{}', 88),
(5511, 2286, '8400B616F490E01B48257737002A87EC', 80, 'sgzb4', '市国资局胡伟', NULL, NULL, NULL, '', 3, '{}', 88),
(5512, 2287, '38C8CD7829B1849A4825773D0007C59D', 56, 'ghjghwfj', '市规划局观海卫分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5513, 2288, 'C3A683B7153274864825773D0007CC11', 56, 'ghjghyjy', '市规划局规划研究院', NULL, NULL, NULL, '', 3, '{}', 88),
(5514, 2289, 'A3877C57E96824DC4825773D0007BF5F', 56, 'ghjlsfj', '市规划局龙山分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5515, 2290, '976CD0E7F198929A482577400003B493', 161, 'bsljdlbs', '白沙路街道劳动保障服务所', NULL, NULL, NULL, '', 3, '{}', 88),
(5516, 2291, '4588717697BBACDC4825774B000D504F', 146, 'ghwzllb', '观海卫镇老龄办', NULL, NULL, NULL, '', 3, '{}', 88),
(5517, 2293, '8D5502DD076DC4E9482577590002C34B', 174, 'lsyh', '临商银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5518, 2295, 'C6BEC3B771B497F44825776000079487', 163, 'kdjdcszhb', '坎墩街道城市综合管理办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5519, 2296, '85C9543C69BA01904825776000078ECF', 163, 'kdjdshsyb', '坎墩街道社会事业办', NULL, NULL, NULL, '', 3, '{}', 88),
(5520, 2297, '482A3B1417961AE8482577610012C855', 160, 'hsjdlbs', '浒山街道劳动保障服务所', NULL, NULL, NULL, '', 3, '{}', 88),
(5521, 2299, 'FD1824FA8DD5B5544825776200141785', 149, 'sszjgdgw', '胜山镇机关党工委', NULL, NULL, NULL, '', 3, '{}', 88),
(5522, 2300, 'AB4BD4B98FDA6852482577690009B6C3', 176, 'hxyh', '华夏银行宁波慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5523, 2301, '296B8E48FCA088F8482577690009BDA9', 177, 'wzyh', '温州银行宁波慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5524, 2302, 'BDF66706C8D2EC074825776C0008EFA5', 10, 'sfbcjj', '市府办陈建杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5525, 2303, '2EA191B7B4988F8348257774000F8FC1', 91, 'sgongdjsdb', '市政府三电办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5526, 2304, 'C192379922621D2A482577750030BC3C', 144, 'lszjcs', '龙山镇检察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5527, 2305, 'C32BF03DB4EEED3C4825777A0028B6CB', 8, 'swbcj', '市委办岑锔', NULL, NULL, NULL, '', 3, '{}', 88),
(5528, 2306, '23C71E0C8E662DEE4825777A0028BD35', 8, 'swbwjf', '市委办王建峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5529, 2309, '55F49C115FD62A154825778A00037A7B', 146, 'ghwzjcs', '观海卫检察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5530, 2310, '7432879228AC6F77482577970009F96D', 57, 'sjtjjck6', '市交通运输局计财科6', NULL, NULL, NULL, '', 3, '{}', 88),
(5531, 2311, '683C38A4C5B526EE482577970009FFB8', 57, 'sjtjjck7', '市交通运输局计财科7', NULL, NULL, NULL, '', 3, '{}', 88),
(5532, 2312, '560A48FC87F853724825779900333717', 160, 'hsjdjgdd', '景观大道浒山动迁指挥部', NULL, NULL, NULL, '', 3, '{}', 88),
(5533, 2313, '1C2A08709D09260D4825779A00142D0F', 77, 'sjgfwzxdht', '市人民大会堂', NULL, NULL, NULL, '', 3, '{}', 88),
(5534, 2315, '1D1B4AE6B26E4191482577A00029711C', 66, 'shbjghwfj', '市环保局观海卫分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5535, 2316, '8443B1340A8B01CC482577A3000F2E1F', 30, 'tswjycyzx', '团市委青年就业创业服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5536, 2318, '319B7577A2873A47482577AC000CB072', 12, 'sjcy5', '市检察院朱红晖', NULL, NULL, NULL, '', 3, '{}', 88),
(5537, 2319, 'BFA14991FD05C79F482577AD00115117', 35, 'swlysg', '市文联陈之佛艺术馆', NULL, NULL, NULL, '', 3, '{}', 88),
(5538, 2320, 'D50479E4941BF8C9482577AD00114AB3', 35, 'swlzlb', '市文联组联部', NULL, NULL, NULL, '', 3, '{}', 88),
(5539, 2322, '3E01C7853DD5F31B482577BD00068C50', 98, 'smhfjq3', '市鸣鹤风景区开发建设办陆挺', NULL, NULL, NULL, '', 3, '{}', 88),
(5540, 2323, '96204D0AEE025EF7482577C100223D8E', 15, 'sjw36', '市纪委周吉', NULL, NULL, NULL, '', 3, '{}', 88),
(5541, 2324, 'E7130B7B95519FCD482577C1002244FC', 15, 'sjw37', '市纪委严精伟', NULL, NULL, NULL, '', 3, '{}', 88),
(5542, 2325, '0178346946738050482577C100224BBF', 15, 'sjwgbs', '市纪委干部室', NULL, NULL, NULL, '', 3, '{}', 88),
(5543, 2326, '13D149D660A1B33F482573310027F001', 146, 'ghwzzzzl', '观海卫镇镇长助理', NULL, NULL, NULL, '', 3, '{}', 88),
(5544, 2328, '0D87BFAB3EC9B36F482577CE002B1C34', 193, 'swsjhszh', '市红十字会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5545, 2330, '699BA91EAF228F36482577D90004527F', 20, 'swzfwshgl', '市社会管理创新综合试点工作领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5546, 2331, '5C68F72FB48A96A7482577DE0028312C', 34, 'skx6', '市科协董静波', NULL, NULL, NULL, '', 3, '{}', 88),
(5547, 2333, 'C361D4B5A034CC07482577E6002AC41E', 146, 'ghwzsc', '观海卫镇三产副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5548, 2334, '745619D423598623482577EC00141E9C', 68, 'sgsj12366', '市国税局12366税收热线', NULL, NULL, NULL, '', 3, '{}', 88),
(5549, 2335, 'F3EE66B129B27494482577ED0004B441', 68, 'sgsj81890', '市国税局81890求助服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5550, 2336, '3708D42F2D524CDA482577ED00270217', 178, 'hzyh', '杭州银行宁波慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5551, 2337, 'FC293B8AFB063C6C482577FA002EC88C', 154, 'cszjw', '崇寿镇纪委', NULL, NULL, NULL, '', 3, '{}', 88),
(5552, 2340, '238B81722DD79F7748257801000680A5', 144, 'lszfwzx', '龙山镇公共资源交易和审批服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5553, 2341, '7396E99614A77B29482578010006796E', 144, 'lszjyzx', '龙山镇公共资源交易中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5554, 2342, 'C1CD318230B973CD48257809002EBA49', 146, 'ghwzggzy', '观海卫镇公共资源交易和审批服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5555, 2343, 'CC0B16F44C99B8F748257809002EB36B', 146, 'ghwzzhzfj', '观海卫镇综合执法局', NULL, NULL, NULL, '', 3, '{}', 88),
(5556, 2344, '932C3954443A15E348257809002F060E', 20, 'swzfw10', '市委政法委傅建芳', NULL, NULL, NULL, '', 3, '{}', 88),
(5557, 2345, '6C4CE0D94CB568FF48257809002EAD62', 20, 'swzfwgab', '市国安办', NULL, NULL, NULL, '', 3, '{}', 88),
(5558, 2348, '13CCE067AFEE818A48256C310022FD6E', 0, 'fszzz', '范市镇镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5559, 2349, '3D6ED9DE5D01092F48256C06002D63E1', 160, 'hsjdwys', '浒山街道文印室', NULL, NULL, NULL, '', 3, '{}', 88),
(5560, 2350, 'CEC2844797F34D0948256C23002529C3', 160, 'hsjdxcwy', '浒山街道宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5561, 2351, '3F15F20C0CFE451B48256C2300245963', 160, 'hsjdzzwy', '浒山街道组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5562, 2352, '35A2BA60F1F26BC348256CFE000839FA', 144, 'lszzjwy', '龙山镇组纪委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5563, 2353, '94CAE264EDCC932648256B3A002BD303', 8, 'wangd', '市委办王　迪', NULL, NULL, NULL, '', 3, '{}', 88),
(5564, 2354, 'F0E4E2A7BF65CB4A48257814002E9B58', 27, 'cxrbsled', 'LED信息发布', NULL, NULL, NULL, '', 3, '{}', 88),
(5565, 2356, '790F4A4CA1E27B2F4825781500135C6B', 9, 'srdb31', '市人大办徐博', NULL, NULL, NULL, '', 3, '{}', 88),
(5566, 2358, '440EDCE59E078E1148257818002A0110', 43, 'sjyj8', '市教育局张志锋', NULL, NULL, NULL, '', 3, '{}', 88),
(5567, 2359, 'E0F5D1FBFB6B6AD44825781800299451', 65, 'ssjjjzs7', '市审计局胡科文', NULL, NULL, NULL, '', 3, '{}', 88),
(5568, 2360, '9423FDF2E4719A4548257818002E6227', 62, 'swtjyyf', '市文广局虞银飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5569, 2361, 'D4C34F05E3E49C0D4825781F0007065E', 10, 'sfbyym', '市府办严胤铭', NULL, NULL, NULL, '', 3, '{}', 88),
(5570, 2363, 'F22EBA43ED2AA68C482578240012B5D7', 179, 'gdzq', '光大证券', NULL, NULL, NULL, '', 3, '{}', 88),
(5571, 2365, '7D7C3EDEA26FDC92482578350010CCAC', 57, 'sjtfzgs', '市交通运输局交通发展有限责任公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5572, 2366, '62ACAA98A0F36138482578350010BF67', 57, 'sjtjbgs8', '市交通运输局办公室８', NULL, NULL, NULL, '', 3, '{}', 88),
(5573, 2367, '542511631649B00F482578350010C588', 57, 'sjtwlgs', '市交通运输局交通物流发展有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5574, 2368, 'B061AB511D12E0F6482578350010B97F', 65, 'ssjjnsxh', '市审计局内审协会', NULL, NULL, NULL, '', 3, '{}', 88),
(5575, 2370, '94A8196C8528B1E54825783900295743', 15, 'sssscbgs', '市三思三创办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5576, 2371, 'D5638CDC6EE22144482578450032C43F', 5, 'szxcjg', '市政协岑剑国', NULL, NULL, NULL, '', 3, '{}', 88),
(5577, 2372, '6DCC555F10A2C8D248256FEE002D30BC', 55, 'sjsjbgs4', '市住建局黄锡映', NULL, NULL, NULL, '', 3, '{}', 88),
(5578, 2373, 'E081541BBA59AB4E48257848000B38A3', 55, 'sjsjtyys5', '市住建局陆志乔（调研员）', NULL, NULL, NULL, '', 3, '{}', 88),
(5579, 2374, '523100C9254FD74E4825784D000858A1', 66, 'shbjjzs7', '市环保局李明', NULL, NULL, NULL, '', 3, '{}', 88),
(5580, 2375, '32018BD1DCD08A734825784F0011D9DF', 75, 'scgjbsljd', '白沙路中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5581, 2376, 'C3916756D9B4EB234825784F0011D2E8', 75, 'scgjgtjd', '古塘中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5582, 2377, 'E260CF3DE97834444825784F0011CBF1', 75, 'scgjhsjd', '浒山中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5583, 2378, '5831D66C9730C8A14825784F0011C582', 0, 'shwccws', '市环卫处财务室', NULL, NULL, NULL, '', 3, '{}', 88),
(5584, 2379, '444883629700C0F84825785300130819', 154, 'cszxcb', '崇寿镇宣传办', NULL, NULL, NULL, '', 3, '{}', 88),
(5585, 2380, '3379F67EB1C904AF4825785C0028682E', 75, 'scgbxzspk', '市综合行政执法局（市城管局）行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(5586, 2381, '3B7CDD081C07296C4825785C002861F1', 75, 'scgbzfdck', '市综合行政执法局（市城管局）执法督查科', NULL, NULL, NULL, '', 3, '{}', 88),
(5587, 2382, '1478ADF0D5548C094825785E002699DA', 72, 'sgbdstygrx', '市广播电视台“阳光热线”栏目', NULL, NULL, NULL, '', 3, '{}', 88),
(5588, 2383, '48D58003581DA53848257862002EC0AC', 63, 'swsj1', '市卫生和计划生育局史国建', NULL, NULL, NULL, '', 3, '{}', 88),
(5589, 2384, '99AA5972A64DD7A44825786500298969', 65, 'ssjjjbjsk', '市审计局基本建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(5590, 2385, '2DDF3D87427900434825786500298341', 65, 'ssjjzysjfj', '市审计局专业审计分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5591, 2388, '88BEB682368833FD4825787E00087E7E', 43, 'sjyj9', '市教育局许维森', NULL, NULL, NULL, '', 3, '{}', 88),
(5592, 2389, '4A4195E1A792F8EA4825788000069DAB', 13, 'sfy10', '市法院马绿洲', NULL, NULL, NULL, '', 3, '{}', 88),
(5593, 2390, 'E53C90D8501459A4482578800030A26C', 59, 'Ssljjz10', '市水利局郑松镇', NULL, NULL, NULL, '', 3, '{}', 88),
(5594, 2391, 'EF8541983518EF684825788000309C08', 59, 'Ssljjz9', '市水利局朱永根', NULL, NULL, NULL, '', 3, '{}', 88),
(5595, 2392, 'B45028576E8734A0482578800024B366', 17, 'swxcb6', '市委宣传部王雪峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5596, 2393, '75F0D309B613996248257886002DF144', 51, 'scsjsmx', '市财政地税局沈鸣学', NULL, NULL, NULL, '', 3, '{}', 88),
(5597, 2394, '92707504FE81CB90482578860030AB36', 57, 'sjtj5', '市交通运输局岑建平', NULL, NULL, NULL, '', 3, '{}', 88),
(5598, 2395, 'F00334F003B0438D482578860030B227', 57, 'sjtj8', '市交通运输局郭根苗', NULL, NULL, NULL, '', 3, '{}', 88),
(5599, 2396, 'F69D4CEBA2B78A9948257887000B30C3', 172, 'scn7', '市城南改造建设指挥部俞秋苗', NULL, NULL, NULL, '', 3, '{}', 88),
(5600, 2397, 'DA037DBB49F31AE448257887002BCDCF', 180, 'sxct', '市新潮塘改造建设指挥部综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(5601, 2398, '6AC3449BB9F0DFD44825788B00073B99', 144, 'lszxckf', '龙山镇新城开发建设指挥部', NULL, NULL, NULL, '', 3, '{}', 88),
(5602, 2399, '9B59CD80ADC09F184825788B00062A9E', 75, 'scgbdlyh', '市市政道路养护管理所', NULL, NULL, NULL, '', 3, '{}', 88),
(5603, 2400, 'E5C3DDFE989324504825788B0032E78F', 173, 'sxxcybgs5', '慈溪高新技术产业开发区管理委员会规划建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(5604, 2401, 'A763B696BA9065E74825788C003374C9', 60, 'smylsj7', '市商务局孙迪清', NULL, NULL, NULL, '', 3, '{}', 88),
(5605, 2402, 'D1D6C7B6BDD3902D4825788D00326791', 57, 'scxgjgs', '市交通运输局城乡公共交通有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5606, 2403, '3658DDD8AD5CAC414825788D00326EA1', 57, 'sjtczzhb', '市交通运输局交通场站建设工程指挥部', NULL, NULL, NULL, '', 3, '{}', 88),
(5607, 2404, '1AA46D28DF62096C4825788E000734E0', 149, 'ssztyy', '胜山镇调研员', NULL, NULL, NULL, '', 3, '{}', 88),
(5608, 2405, '6CD32DCAFD060E4648257892000545A8', 58, 'snyjjzs6', '市农业局应维苗', NULL, NULL, NULL, '', 3, '{}', 88),
(5609, 2406, '907945EDA143766F48257892000552D4', 59, 'ssljcdsk', '市慈东水库管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(5610, 2407, 'DB84F3B980DBE8AE4825789200054BF2', 59, 'ssljhtgws', '市水利局水利工程管理所', NULL, NULL, NULL, '', 3, '{}', 88),
(5611, 2408, '7BF497691EC09BAA48257892000559D0', 59, 'ssljxzspk', '市水利局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(5612, 2409, '6628FC601D4A8C2448256E3600215E07', 20, 'dhzzhbxcz', '大会战指挥部宣传报到组', NULL, NULL, NULL, '', 3, '{}', 88),
(5613, 2410, '2DBA13D435808D2748257893002983E3', 10, 'sfbhdh', '市府办胡迪伙', NULL, NULL, NULL, '', 3, '{}', 88),
(5614, 2411, 'E437B7156CB2D22B48257895000C825E', 17, 'ssky1', '市社科联（院）陈迪', NULL, NULL, NULL, '', 3, '{}', 88),
(5615, 2412, '3F7AC94D896DAEAF48257895000C88FC', 17, 'ssky2', '市社科联（院）黄高峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5616, 2413, '60D7E248B9C6B4DA48257899000BCF8A', 76, 'lpzxzrs5', '市行政服务中心徐志平', NULL, NULL, NULL, '', 3, '{}', 88),
(5617, 2414, '1A52C631087B2EB248257899000912E5', 180, 'sxct1', '市新潮塘改造建设指挥部姚金环', NULL, NULL, NULL, '', 3, '{}', 88),
(5618, 2415, 'CAC873A3634F7D9448257899000919E2', 180, 'sxct2', '市新潮塘改造建设指挥部郑忠昂', NULL, NULL, NULL, '', 3, '{}', 88),
(5619, 2416, 'EA8AD17E949F33E4482578990009206A', 180, 'sxct3', '市新潮塘改造建设指挥部施百清', NULL, NULL, NULL, '', 3, '{}', 88),
(5620, 2417, '39E5B185F08B32D4482578990009279D', 180, 'sxct4', '市新潮塘改造建设指挥部宋加约', NULL, NULL, NULL, '', 3, '{}', 88),
(5621, 2418, 'DD86DF1F656CFBDB4825789900093608', 180, 'sxctdqk', '市新潮塘改造建设指挥部动迁科', NULL, NULL, NULL, '', 3, '{}', 88),
(5622, 2419, 'ADF6D8573E4E5C3E4825789900092ED9', 180, 'sxctjsk', '市新潮塘改造建设指挥部规划建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(5623, 2420, 'DAFCF9F6A264993A482578A30032B81D', 66, 'shbjzxfj', '市环保局周巷分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5624, 2421, 'DE90685DE81E358C482578A30032BEC9', 53, 'sldjxqsbb', '新区社保办', NULL, NULL, NULL, '', 3, '{}', 88),
(5625, 2431, '4D72A2BD048C1DF648256EF400050154', 0, 'fsztgs', '范市镇国土资源所', NULL, NULL, NULL, '', 3, '{}', 88),
(5626, 2433, '6681A71FA9B476DB482578CC0005CE40', 8, 'swbjl', '市委办姜麟', NULL, NULL, NULL, '', 3, '{}', 88),
(5627, 2434, 'E4F9EED711629D2C482578D3000DB6C0', 56, 'ghjzxfj', '市规划局周巷分局', NULL, NULL, NULL, '', 3, '{}', 88),
(5628, 2435, '304D20FC854695FA482578D5000A4A98', 39, 'stjjdp', '市统计局东片工作站', NULL, NULL, NULL, '', 3, '{}', 88),
(5629, 2436, 'A928C82911799F83482578D5000A57F9', 39, 'stjjxp', '市统计局西片工作站', NULL, NULL, NULL, '', 3, '{}', 88),
(5630, 2437, '807DCD46F81AD682482578D5000A50DB', 39, 'stjjzp', '市统计局中片工作站', NULL, NULL, NULL, '', 3, '{}', 88),
(5631, 2439, 'E6E7928FB2807A1D482578E600046C34', 95, 'sdxjzqb', '市电信局政企部', NULL, NULL, NULL, '', 3, '{}', 88),
(5632, 2440, 'BB1517AA9A894B2B482578E90006AF0A', 144, 'lszzhzfj', '龙山镇综合执法局', NULL, NULL, NULL, '', 3, '{}', 88),
(5633, 2441, '0909488CEB5C98B5482578E90006B5AA', 13, 'sfy11', '市法院王建宏', NULL, NULL, NULL, '', 3, '{}', 88),
(5634, 2442, '089278524D673508482578E90006BCD2', 13, 'sfy12', '市法院孙央平', NULL, NULL, NULL, '', 3, '{}', 88),
(5635, 2443, 'EC8B7CB46CE6DE0E482578E90006C3E2', 13, 'sfy13', '市法院王乃权', NULL, NULL, NULL, '', 3, '{}', 88),
(5636, 2444, 'BBE241F0B5D53EAC482578E90006CB2E', 13, 'sfy14', '市法院王旭明', NULL, NULL, NULL, '', 3, '{}', 88),
(5637, 2445, '0823E8885F6EDFE8482578E90006D244', 13, 'sfy15', '市法院方明杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5638, 2446, '9A13262574999FAD482578E90006D92F', 13, 'sfy16', '市法院高立民', NULL, NULL, NULL, '', 3, '{}', 88),
(5639, 2447, '4CD657A9A7E673B0482578E90006E06C', 13, 'sfy17', '市法院沈国文', NULL, NULL, NULL, '', 3, '{}', 88),
(5640, 2448, '67BDBE64E6586D55482578E90006E74B', 13, 'sfy18', '市法院范智君', NULL, NULL, NULL, '', 3, '{}', 88),
(5641, 2449, '4CEB51B72DF7AEC1482578F100298DB4', 162, 'zhjdggw', '宗汉街道关工委', NULL, NULL, NULL, '', 3, '{}', 88),
(5642, 2450, '2E520E84BC668A01482578F100299434', 162, 'zhjdllw', '宗汉街道老龄委', NULL, NULL, NULL, '', 3, '{}', 88),
(5643, 2451, 'E6CDE696009EB51C482578FE002C47D1', 208, 'sgsqb', '市个升企办', NULL, NULL, NULL, '', 3, '{}', 88),
(5644, 2452, '1C634A2616A8BB894825790B000E8952', 159, 'gtjd13', '古塘街道人大副主任2', NULL, NULL, NULL, '', 3, '{}', 88),
(5645, 2455, 'EABDCF290EFF24794825790A0032CD14', 70, 'szjjdezjs', '市质监局第二质监所（横河）', NULL, NULL, NULL, '', 3, '{}', 88),
(5646, 2456, 'F88B8FCD9BF5ABD34825790A0032D48B', 70, 'szjjdszjs', '市质监局第三质监所（长河）', NULL, NULL, NULL, '', 3, '{}', 88),
(5647, 2457, 'CD2A46F932BF0E624825790A0032C62A', 70, 'szjjdyzjs', '市质监局第一质监所（附海）', NULL, NULL, NULL, '', 3, '{}', 88),
(5648, 2458, 'E7366EA73BB6BA9B4825790A0032BF33', 70, 'szjjjcdd', '市质监局稽查大队', NULL, NULL, NULL, '', 3, '{}', 88),
(5649, 2459, 'CF3F1CAC507145344825790A0032AB44', 70, 'szjjjdjck', '市质监局监督稽查科', NULL, NULL, NULL, '', 3, '{}', 88),
(5650, 2460, '30430BDB3D0C63324825790A0032B1E2', 70, 'szjjsjk', '市质监局食监科', NULL, NULL, NULL, '', 3, '{}', 88),
(5651, 2461, 'C9F551AC756D787B4825790A0032A418', 70, 'szjjzlk', '市质监局质量与标准计量科', NULL, NULL, NULL, '', 3, '{}', 88),
(5652, 2462, 'AA12C575EE487CC54825790B000E8F9A', 158, 'zxzjcs', '周巷镇检察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5653, 2463, 'AFDB40B6DCCF800C4825790C0009BE99', 160, 'hsjd14', '浒山街道文卫主任', NULL, NULL, NULL, '', 3, '{}', 88),
(5654, 2466, '5D14E8D1CC61A2BB4825790C000A4449', 10, 'sfbcjf', '市府办陈建锋', NULL, NULL, NULL, '', 3, '{}', 88),
(5655, 2467, 'D7081B7C6DA3D9A34825790D00297322', 31, 'sfl5', '市妇联陆圆圆', NULL, NULL, NULL, '', 3, '{}', 88),
(5656, 2468, 'C65F0C1368E0796C4825790D002B9D0C', 19, 'smzzjjfjz3', '市民族宗教局赵松开', NULL, NULL, NULL, '', 3, '{}', 88),
(5657, 2470, '6E463D58A2E05E3448257910002B9959', 54, 'stgjxzfwzx', '市国土资源局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(5658, 2471, '35D1FFE80C66A02E48257910002DEE21', 161, 'bsljd16', '白沙路街道文卫主任', NULL, NULL, NULL, '', 3, '{}', 88),
(5659, 2472, 'D15245D6C776265448257910002DF513', 161, 'bsljd17', '白沙路街道人大工委副主任2', NULL, NULL, NULL, '', 3, '{}', 88),
(5660, 2473, '4131D577ADA7A71B48257910002DFC63', 161, 'bsljd18', '白沙路街道调研员3', NULL, NULL, NULL, '', 3, '{}', 88),
(5661, 2476, 'D659B5CBDED58137482579110006C82C', 82, 'cdbhqczj1', '慈溪滨海经济开发区财政局局长', NULL, NULL, NULL, '', 3, '{}', 88),
(5662, 2477, 'D012A323AEFDDA84482579110006A446', 82, 'cdbhqnbsh', '宁波市石化开发区西区办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5663, 2478, '2C63A4580D18B997482579110006BA85', 82, 'cdbhqtzhzj', '慈溪滨海经济开发区投资合作局', NULL, NULL, NULL, '', 3, '{}', 88),
(5664, 2479, '72860237905CFDF9482579110006C17E', 82, 'cdbhqtzhzj1', '慈溪滨海经济开发区投资合作局局长', NULL, NULL, NULL, '', 3, '{}', 88),
(5665, 2480, '0F8715DAABD98A0748257911002A16DE', 41, 'sjfjjzs5', '市经信局胡国远', NULL, NULL, NULL, '', 3, '{}', 88),
(5666, 2481, 'AA2EBF43D271D18648257911002A7B17', 41, 'sjfjxxh', '市经信局信息化管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(5667, 2483, 'DAC88896CD85874148257911002B036E', 11, 'szxbcyp', '教文卫体文史资料委陈幼萍', NULL, NULL, NULL, '', 3, '{}', 88),
(5668, 2484, 'A89D5498A2C4EEE048257911002AFC74', 11, 'szxbyhj', '社法港澳台侨委袁宏捷', NULL, NULL, NULL, '', 3, '{}', 88),
(5669, 2485, '59AC5502781C8C6648257911002B0AEB', 11, 'szxbyyl', '经济科技城资环委郁岳龙', NULL, NULL, NULL, '', 3, '{}', 88),
(5670, 2488, '5F5123C22DE81E4648257912002AC285', 183, 'szsj1', '市招商局张建勋', NULL, NULL, NULL, '', 3, '{}', 88),
(5671, 2489, '1740A59DE7B08F6E48257912002AC8DE', 183, 'szsj2', '市招商局郑登科', NULL, NULL, NULL, '', 3, '{}', 88),
(5672, 2490, '504937E782B4D8BB48257912002AD09C', 183, 'szsj3', '市招商局杨森富', NULL, NULL, NULL, '', 3, '{}', 88),
(5673, 2491, '5659C00465C12A7348257912002AD7EA', 183, 'szsj4', '市招商局张科迪', NULL, NULL, NULL, '', 3, '{}', 88),
(5674, 2492, 'B8E780ABAC4C4E9D48257912002ADF10', 183, 'szsjbgs', '市招商局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5675, 2494, '718B6215980534A748257913000D2931', 98, 'smhfjq4', '市鸣鹤风景区开发建设办杨俊辉', NULL, NULL, NULL, '', 3, '{}', 88),
(5676, 2495, '0956DD0E5CE6139E48257913000C2E91', 58, 'snyjsjs', '市农业局张焕祥', NULL, NULL, NULL, '', 3, '{}', 88),
(5677, 2496, 'CEB70D3EE0F6BC7E482579140004BEB4', 144, 'lszxtwy', '龙山镇宣统委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5678, 2497, '711F928035BC0FE44825791B00049264', 23, 'sjgdgwfsj1', '市机关党工委周聪波', NULL, NULL, NULL, '', 3, '{}', 88),
(5679, 2498, '47197BE80796A05B4825791B0004994D', 23, 'sjgdgwfsj2', '市机关党工委周建明', NULL, NULL, NULL, '', 3, '{}', 88),
(5680, 2499, '8D4A9DBAF2D5949B4825791B000AE738', 55, 'sjsjsjs', '市住建局孙黎明', NULL, NULL, NULL, '', 3, '{}', 88),
(5681, 2500, '3E5F95D4AF65D13A4825791B000AF448', 188, 'sjsjt2', '市建设集团方观浩', NULL, NULL, NULL, '', 3, '{}', 88),
(5682, 2501, 'FDB42CA546D3FA504825791B000AEDAD', 55, 'sjsjtyys6', '市住建局潘建平', NULL, NULL, NULL, '', 3, '{}', 88),
(5683, 2502, 'E26E785C91CE08A24825791B000709AB', 9, 'srdb27', '市人大办严永敢', NULL, NULL, NULL, '', 3, '{}', 88),
(5684, 2503, '1D36C8EAD945ECDE4825791B00082C34', 158, 'zxzsczz', '周巷镇三产镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5685, 2504, '772BBBE94D5B34314825792300309A6F', 82, 'cdbhqtgs', '慈溪滨海经济开发区土管所', NULL, NULL, NULL, '', 3, '{}', 88),
(5686, 2506, '211F6AE007AAA06E482579230005B019', 153, 'hhztyy', '横河镇胡炳其', NULL, NULL, NULL, '', 3, '{}', 88),
(5687, 2507, '4A93A5BDDDAE2172482579230030A0C8', 16, 'swzzblxdjk', '市委组织部两新党建科', NULL, NULL, NULL, '', 3, '{}', 88),
(5688, 2509, 'C87756438124801D482579230030A7B5', 16, 'swzzbrcgzk', '市委组织部人才工作科', NULL, NULL, NULL, '', 3, '{}', 88),
(5689, 2511, 'B13831E98F1E4CB84825792500059197', 0, 'scsjjz4', '市财政税务局潘钊先', NULL, NULL, NULL, '', 3, '{}', 88),
(5690, 2512, 'D7D31995A22B512548257924003353BC', 15, 'sjw38', '市纪委钱飞飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5691, 2513, 'F4DB496BD5E22EA24825792400335A36', 15, 'sjw39', '市纪委金旭绵', NULL, NULL, NULL, '', 3, '{}', 88),
(5692, 2514, '1D0AD6117BEBC011482579240032DD32', 18, 'sqb3', '市侨办魏孟迪', NULL, NULL, NULL, '', 3, '{}', 88),
(5693, 2515, 'F228399A9E55E82F482579260004DD1A', 184, 'sbwb1', '市编委办范伟明', NULL, NULL, NULL, '', 3, '{}', 88),
(5694, 2516, 'BDC82C5D0728F8AC482579260004E387', 184, 'sbwb2', '市编委办戚金刚', NULL, NULL, NULL, '', 3, '{}', 88),
(5695, 2517, 'C5F943C1934C349A482579260004EA8B', 184, 'sbwb3', '市编委办黄华正', NULL, NULL, NULL, '', 3, '{}', 88),
(5696, 2518, 'AF051D585ECA62FE482579260004F1DB', 184, 'sbwb4', '市编委办苗长风', NULL, NULL, NULL, '', 3, '{}', 88),
(5697, 2519, '767E12A0BDCF32A3482579260004F86C', 184, 'sbwb5', '市编委办编制科', NULL, NULL, NULL, '', 3, '{}', 88),
(5698, 2520, 'DF08B9A6C0CAB6354825792600050D41', 184, 'sbwbbzk', '市编委办王林平', NULL, NULL, NULL, '', 3, '{}', 88),
(5699, 2521, 'F730E064D636E2794825792600051BFB', 184, 'sbwbsfs', '市编委办收发室', NULL, NULL, NULL, '', 3, '{}', 88),
(5700, 2522, 'A18102579629344E48257926000514BF', 184, 'sbwbsydw', '市编委办项奇科', NULL, NULL, NULL, '', 3, '{}', 88),
(5701, 2523, 'F38099CFFEF60F63482579260004FF72', 184, 'sbwbzhk1', '市编委办综合科1', NULL, NULL, NULL, '', 3, '{}', 88),
(5702, 2524, 'CFB368DDC921C8A54825792600050661', 184, 'sbwbzhk2', '市编委办综合科2', NULL, NULL, NULL, '', 3, '{}', 88),
(5703, 2525, '84B8E4D16F7465204825792600034D87', 19, 'smzzjjfjz1', '市民族宗教局陈迪川', NULL, NULL, NULL, '', 3, '{}', 88),
(5704, 2526, '8BDA4607FBF0B215482579260003CB4C', 19, 'smzzjjfjz2', '市民族宗教局顾自力', NULL, NULL, NULL, '', 3, '{}', 88),
(5705, 2527, '257D1B5B85823BD148257929002FE14D', 56, 'ghj10', '市规划局明思龙', NULL, NULL, NULL, '', 3, '{}', 88),
(5706, 2528, '3F8E260D04F433D848257929002FDB44', 56, 'ghj9', '市规划局马雪金', NULL, NULL, NULL, '', 3, '{}', 88),
(5707, 2530, 'D8BB9E3BA8223FEF4825792E0003B5EE', 60, 'sswj1', '市商务局高峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5708, 2532, '5582EB9D61F8785E482579300004E1C8', 51, 'scsjjz5', '市财政地税局费洁', NULL, NULL, NULL, '', 3, '{}', 88),
(5709, 2533, '72D4036CA90F21E2482579300002B312', 43, 'sjyjjcs', '市教育局纪检监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5710, 2534, '41C14455F985C890482579330027F475', 28, 'sdajjzs', '市档案局叶建平', NULL, NULL, NULL, '', 3, '{}', 88),
(5711, 2535, '027DAEC9B6D86BD84825793A001045F1', 44, 'skjjdzb', '市地震办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5712, 2536, 'F36248DBCEF1F7F848256C43000B9900', 60, 'smylsjwys2', '市商务局陈建锋', NULL, NULL, NULL, '', 3, '{}', 88),
(5713, 2537, '52533F4D5590558A4825793A00238A48', 60, 'sswj2', '市商务局徐挺', NULL, NULL, NULL, '', 3, '{}', 88),
(5714, 2539, '8DE5E285FD1CAFF24825793B000EDE20', 53, 'srlsbj10', '市人力社保局杨水娟', NULL, NULL, NULL, '', 3, '{}', 88),
(5715, 2540, 'B03A253570877A774825793B000EE4F8', 53, 'srlsbj11', '市人力社保局王建飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5716, 2541, '651AD2DE301781894825793B000EEBC9', 53, 'srlsbj12', '市人力社保局陈国振', NULL, NULL, NULL, '', 3, '{}', 88),
(5717, 2542, 'C338C829E87EBBF74825793B000E85BF', 53, 'srlsbj5', '市人力社保局蒋建伟', NULL, NULL, NULL, '', 3, '{}', 88),
(5718, 2543, '3FEE12E88F6B8C5D4825793B000ED6DD', 53, 'srlsbj8', '市人力社保局孙岳追', NULL, NULL, NULL, '', 3, '{}', 88),
(5719, 2544, '9EFAD9C984BC02334825793B000E8C86', 53, 'srlsbjgwy', '市人力社保局公务员和事业管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(5720, 2545, 'D8B05CA6F0FD5DA44825793B000EA140', 53, 'srlsbjgzfl', '市人力社保局工资福利科', NULL, NULL, NULL, '', 3, '{}', 88),
(5721, 2546, 'E399921F6A98E9FC4825793B000EA803', 53, 'srlsbjpxzx', '市留创园(培训中心)', NULL, NULL, NULL, '', 3, '{}', 88),
(5722, 2547, '81A036A64BBA93154825793B000E9A56', 53, 'srlsbjrckf', '市人力社保局人才开发科', NULL, NULL, NULL, '', 3, '{}', 88),
(5723, 2549, '9AAD6424FEEB0CFA4825793B000F30BB', 53, 'srlsbjsbb', '市社保办', NULL, NULL, NULL, '', 3, '{}', 88),
(5724, 2550, 'C1794C19ABCFCB784825793B000E939D', 53, 'srlsbjzyjs', '市人力社保局专业技术人员管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(5725, 2551, '62441A8A69CE247E48256F3500017752', 55, 'sjsjbgs2', '市住建局办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(5726, 2552, 'D96298833642A95848256FEE002D2617', 55, 'sjsjbgs3', '市住建局励聪', NULL, NULL, NULL, '', 3, '{}', 88),
(5727, 2553, 'C59795204CF7594A48256F3500016B7D', 55, 'sjsjws', '市住建局文　书', NULL, NULL, NULL, '', 3, '{}', 88),
(5728, 2557, '29D765E1511DD12548257948002BD081', 30, 'tswfsj3', '团市委邹鲁', NULL, NULL, NULL, '', 3, '{}', 88),
(5729, 2558, '7E121C3C52B202324825794B0006F5F4', 158, 'zxzhws', '周巷镇环卫所', NULL, NULL, NULL, '', 3, '{}', 88),
(5730, 2559, '09826E7C4C9114864825794F00187DF5', 4, 'szfshf', '市政府施惠芳', NULL, NULL, NULL, '', 3, '{}', 88),
(5731, 2561, 'A7E98BB60EE1FE2348257338002A28DD', 38, 'sfgjdwwy1', '市发展改革局陈庆杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5732, 2562, '8C0AE34DE6F90468482579530024C44D', 151, 'qtzxfb', '桥头镇信访办', NULL, NULL, NULL, '', 3, '{}', 88),
(5733, 2563, '530480C45E7CA49048257957002829AC', 154, 'cszwhz', '崇寿镇文化站', NULL, NULL, NULL, '', 3, '{}', 88),
(5734, 2564, '53B7C3FB29EE4610482579580013F762', 4, 'szfwjl', '市政府王娇俐', NULL, NULL, NULL, '', 3, '{}', 88),
(5735, 2566, 'AB61519D21666BC44825795D00303906', 146, 'ghwzxcjsb', '观海卫镇新城建设办', NULL, NULL, NULL, '', 3, '{}', 88),
(5736, 2567, '3A85107A91F420294825795E002B8538', 159, 'gtjd14', '古塘街道调研员1', NULL, NULL, NULL, '', 3, '{}', 88),
(5737, 2568, 'EC9FAF6A7812008F4825795E002B8B80', 159, 'gtjd15', '古塘街道调研员2', NULL, NULL, NULL, '', 3, '{}', 88),
(5738, 2569, '30A652754EF76D474825795E002B920C', 159, 'gtjd16', '古塘街道调研员3', NULL, NULL, NULL, '', 3, '{}', 88),
(5739, 2570, 'E04C0F61371F80284825795E002C87F6', 186, 'mtsyyh', '浙江民泰商业银行宁波慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5740, 2571, 'F1A8777632CC605248257960002BFFEB', 43, 'sjyjcxdd', '市教育局慈溪电大', NULL, NULL, NULL, '', 3, '{}', 88),
(5741, 2572, 'AADABB80B4E96CEF48257960002C0C98', 43, 'sjyjgzb', '市教育考试中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5742, 2573, 'AF11B01E1DE085FA48257960002C0679', 43, 'sjyjjyz', '市教育技术中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5743, 2574, 'F59AFD8C0FD94A4948257960002B3E23', 43, 'sjyjxqjyk', '市教育局学前教育科', NULL, NULL, NULL, '', 3, '{}', 88),
(5744, 2575, '66351E9FBDCEA71648257960002C1A97', 43, 'sjyjyjfwzx', '市教育局教育服务管理中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5745, 2576, '0514EC9BCEB47F1348257960002C13B4', 43, 'sjyjzjjys', '市教育局职教教研室', NULL, NULL, NULL, '', 3, '{}', 88),
(5746, 2577, 'DA9233D897CEAA76482579600031479B', 3, 'srdwwz', '市人大吴武忠', NULL, NULL, NULL, '', 3, '{}', 88),
(5747, 2578, 'F3C6DE43D69D7EC54825796400222A1E', 147, 'fhzwwzz', '附海镇文卫镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5748, 2579, '797960C10018F8EE4825796400223059', 147, 'fhzxcwy', '附海镇宣传委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5749, 2580, '42ED858D58CC4FDE482579640022F0EC', 10, 'sfbtgf', '市府办童高峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5750, 2581, 'FA7495CD67C82E4E482579640008C1D9', 41, 'sjxj6', '市经信局挂职', NULL, NULL, NULL, '', 3, '{}', 88),
(5751, 2582, '2B460DA62244CEF9482579640008C853', 41, 'sjxjxzspk', '市经信局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(5752, 2583, '082CE76CA44EA41348257965002868C3', 56, 'ghjczg', '市规划局城展馆筹建办', NULL, NULL, NULL, '', 3, '{}', 88),
(5753, 2584, '5260BEF8611C9992482579660010D536', 8, 'swbssj', '市委办邵世军', NULL, NULL, NULL, '', 3, '{}', 88),
(5754, 2585, 'D02D1D46E598AEB5482579660010DBCE', 8, 'swbzzm', '市委办张崇明', NULL, NULL, NULL, '', 3, '{}', 88),
(5755, 2586, '50E735473DB22CA8482579680007374F', 187, 'rbcxyczgs', '人保财险余慈支公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5756, 2588, '55DA1594842F66F84825796B002796A6', 5, 'szxzxh', '市政协周晓虹', NULL, NULL, NULL, '', 3, '{}', 88),
(5757, 2589, 'E3962F54FC9106294825796E002787A8', 18, 'sqb4', '市侨办徐友祥', NULL, NULL, NULL, '', 3, '{}', 88),
(5758, 2591, '0DC648EBB2EF510D48257987000CBF98', 158, 'zxzpcssz', '周巷镇派出所所长', NULL, NULL, NULL, '', 3, '{}', 88),
(5759, 2592, 'C84D11BCD725350148257998000521C4', 75, 'scgjrsjc', '市综合行政执法局（市城管局）人事监察', NULL, NULL, NULL, '', 3, '{}', 88),
(5760, 2593, 'BAC61E309538195648257998002AABF8', 50, 'ssfj5', '市司法局张冲明', NULL, NULL, NULL, '', 3, '{}', 88),
(5761, 2594, 'ADD360BE43F2F93A48257998000C87CB', 183, 'szsjzsek', '市招商局投资促进二科', NULL, NULL, NULL, '', 3, '{}', 88),
(5762, 2595, '82D763E47ED3D53D48257998000C7FDF', 183, 'szsjzsyk', '市招商局投资促进一科', NULL, NULL, NULL, '', 3, '{}', 88),
(5763, 2596, '468DF76D8DF20CBE48257998002AD4F5', 169, 'tlsyyhgc', '泰隆商业银行观海卫支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5764, 2597, '2F528E4AF84C0EC9482579990008D172', 38, 'sfgjfgy', '慈溪市发展规划研究院', NULL, NULL, NULL, '', 3, '{}', 88),
(5765, 2598, '6BF754A13ADB33AB4825799C0022F362', 81, 'scqjyzx', '市产权交易中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5766, 2599, '14BA8411A88404D0482579A0000F04E7', 51, 'scsjnspgk', '市财政地税局纳税评估科', NULL, NULL, NULL, '', 3, '{}', 88),
(5767, 2600, '8406007763B55378482579A0000EFEB8', 51, 'scsjzhsbk', '市财政地税局综合与社会保障科', NULL, NULL, NULL, '', 3, '{}', 88),
(5768, 2601, '5E945015B897FD7D482579A3002A4029', 62, 'styg', '市体育馆', NULL, NULL, NULL, '', 3, '{}', 88),
(5769, 2602, 'E64A624F9CC384E8482579A50027F5FF', 159, 'gtjdpcs', '古塘街道派出所所长', NULL, NULL, NULL, '', 3, '{}', 88),
(5770, 2603, '069C7233A06BFF1A482579A7002AC944', 51, 'scsjjz6', '市财政地税局史军', NULL, NULL, NULL, '', 3, '{}', 88),
(5771, 2605, '6E27484014688CED482579AA0010C5C4', 60, 'sswjfwyfzk', '市商务局服务业发展科', NULL, NULL, NULL, '', 3, '{}', 88),
(5772, 2606, 'DD3627D6D77DC378482579AA0010BF31', 60, 'sswjzcghk', '市商务局政策规划科', NULL, NULL, NULL, '', 3, '{}', 88),
(5773, 2607, '4AE55A2801F3C457482579AD000CC88D', 10, 'sfblw', '市府办李伟', NULL, NULL, NULL, '', 3, '{}', 88),
(5774, 2608, '7C23F90220314311482579AD000CCF3C', 29, 'szghzxs5', '市总工会朱会贞', NULL, NULL, NULL, '', 3, '{}', 88),
(5775, 2609, '5D40FF1D37F1359D482579B2000A34B7', 183, 'szsjzhk', '市招商局办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(5776, 2611, '7633A6EC33DF6D07482579B400127274', 10, 'sfbxugq', '市府办徐国强', NULL, NULL, NULL, '', 3, '{}', 88),
(5777, 2612, '7AE7D54E8FB37F59482579B40012452F', 10, 'sfbzf', '市府办周锋', NULL, NULL, NULL, '', 3, '{}', 88),
(5778, 2613, '437A98FD4F9A31A6482579B3002FE78C', 2, 'swbzbh', '市委张炳华', NULL, NULL, NULL, '', 3, '{}', 88),
(5779, 2614, '13E590235DD688DF482579B500091C47', 51, 'scsj1', '市财政地税局周国爱', NULL, NULL, NULL, '', 3, '{}', 88),
(5780, 2615, 'AB0D885075E82887482579B5000AD5CB', 55, 'sjsjdwwy3', '市住建局胡坚杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5781, 2617, '96C87358382E89C2482579C000237891', 16, 'swzzbbz4', '市委组织部张红军', NULL, NULL, NULL, '', 3, '{}', 88),
(5782, 2618, '1F37EB46F8033BAE482579C90009EB21', 75, 'scgjghw', '市综合行政执法局（市城管局）观海卫中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5783, 2619, '065DDD4D68C86F8F482579C90009FEDE', 75, 'scgjhh', '市综合行政执法局（市城管局）横河中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5784, 2620, 'FB4B912374470657482579C90009F8AE', 75, 'scgjkd', '市综合行政执法局（市城管局）坎墩中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5785, 2621, '056BBD6E44D2C417482579C90009DE0C', 75, 'scgjls', '市综合行政执法局（市城管局）龙山中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5786, 2622, '04DEC0BF1FF08A67482579C90009F1DF', 75, 'scgjzh', '市综合行政执法局（市城管局）宗汉中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5787, 2623, '4146135F6BCA3A20482579C90009E478', 75, 'scgjzx', '市综合行政执法局（市城管局）周巷中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5788, 2625, '865F850EAA7BD716482579D1002BBD90', 22, 'snbncggb', '市农办洪燕文', NULL, NULL, NULL, '', 3, '{}', 88),
(5789, 2626, '3532DAA0B6F19814482579D80022F4E6', 30, 'tswcxqnbjb', '《慈溪青年》编辑部', NULL, NULL, NULL, '', 3, '{}', 88),
(5790, 2627, 'D9C7B407A8A0D090482579DE0032FC1D', 48, 'scsh1', '市慈善总会黄建钧', NULL, NULL, NULL, '', 3, '{}', 88),
(5791, 2628, '3A7E80AA5B1F19D3482579DE003301EE', 48, 'scsh2', '市慈善总会徐桐琦', NULL, NULL, NULL, '', 3, '{}', 88),
(5792, 2629, 'A898F75158F5B3C1482579DE003308A6', 48, 'scsh3', '市慈善总会王志成', NULL, NULL, NULL, '', 3, '{}', 88),
(5793, 2630, 'AD7A37A903374DF4482579DE00330F30', 48, 'scsh4', '市慈善总会钱国本', NULL, NULL, NULL, '', 3, '{}', 88),
(5794, 2631, '123FE86313A11554482579DE00331633', 48, 'scsh5', '市慈善总会办公室贺跃群', NULL, NULL, NULL, '', 3, '{}', 88),
(5795, 2632, '2AB075F4CE771BA1482579DE003329D1', 48, 'scshcwk', '市慈善总会财务科', NULL, NULL, NULL, '', 3, '{}', 88),
(5796, 2633, '2DB3D2413C4461E5482579DE003323B2', 48, 'scshfhglk', '市慈善总会分会管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(5797, 2634, '7A6DC4C96C598F6F482579DE00331D1C', 48, 'scshjzb', '市慈善总会救助办', NULL, NULL, NULL, '', 3, '{}', 88),
(5798, 2635, '902B1AC737898A8A482579DE003017A0', 188, 'sjsjtgcb', '市建设集团工程管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(5799, 2636, '79C1E6A78C9BB965482579DE00300293', 188, 'sjsjtjcb', '市建设集团计划财务部', NULL, NULL, NULL, '', 3, '{}', 88),
(5800, 2637, 'A8EA39E3A678495E482579DE00301E67', 188, 'sjsjtqqb', '市建设集团前期策划部', NULL, NULL, NULL, '', 3, '{}', 88),
(5801, 2638, 'F36CC793DAD3B8B4482579DE00301058', 188, 'sjsjtzcb', '市建设集团资产管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(5802, 2639, 'CFB3E46380382EED482579DE00300926', 188, 'sjsjtzss', '市建设集团总工程师室', NULL, NULL, NULL, '', 3, '{}', 88),
(5803, 2640, '480C17D922A75E08482579E6002A089B', 172, 'scngzjszhb1', '市城南改造建设指挥部综合科收发', NULL, NULL, NULL, '', 3, '{}', 88),
(5804, 2642, 'BD66BBF8A7A948C9482579ED002BD6F6', 13, 'sfyjcs', '市法院监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5805, 2656, '68464FD9A0FD8E05482579F40005805C', 150, 'xpzwjs', '新浦镇卫监所', NULL, NULL, NULL, '', 3, '{}', 88),
(5806, 2657, 'D6B1A2F09E07B87848257A0000072F88', 208, 'sdjb', '市打假办', NULL, NULL, NULL, '', 3, '{}', 88),
(5807, 2658, '61A6F45B7E5BF96448257A010007B767', 53, 'cyxcsldxz', '市创建省级创业型城市领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5808, 2659, '2DDCF7127C95B85B48257A0100085F37', 158, 'zxzwsjg', '周巷镇卫生食品药品监管所', NULL, NULL, NULL, '', 3, '{}', 88),
(5809, 2660, 'D83C1CAF774EE02648257A0500076D7A', 54, 'stgjglgs', '市国土资源局国力公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5810, 2661, 'E7F1C6214AB6FA4E48257A0500075F11', 54, 'stgjjcs', '市国土资源局监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5811, 2664, '9713C9316F6F675A48257A0500074670', 54, 'stgjjzs8', '市国土资源局叶磊', NULL, NULL, NULL, '', 3, '{}', 88),
(5812, 2665, '217EAC07CA569C3548257A0500074D03', 54, 'stgjjzs9', '市国土资源局陈迪军', NULL, NULL, NULL, '', 3, '{}', 88),
(5813, 2666, '5D5E8B1165F2D48548257A06002EA16C', 30, 'tswzyzzdzx', '市志愿者指导中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5814, 2668, 'FD158C1ACC7530D148257A0D000668AD', 54, 'stgjtyy1', '市国土资源局徐品章', NULL, NULL, NULL, '', 3, '{}', 88),
(5815, 2669, 'E61185A835AF7C1648257A0D00066F0B', 54, 'stgjtyy2', '市国土资源局陈建国', NULL, NULL, NULL, '', 3, '{}', 88),
(5816, 2670, '44B1E27CBF20D60B48257A0D00067621', 54, 'stgjtyy3', '市国土资源局陈宁浩', NULL, NULL, NULL, '', 3, '{}', 88),
(5817, 2671, '99699533C0C5EDB148257A10000769BD', 158, 'zxzxzzf', '周巷镇行政执法办', NULL, NULL, NULL, '', 3, '{}', 88),
(5818, 2672, '9208A6FAC06451F048257A1700072AD1', 10, 'sfbfj', '市府办冯佳', NULL, NULL, NULL, '', 3, '{}', 88),
(5819, 2673, '8F7A5397E8E11C9548257A24000F63B8', 62, 'swhscldxz', '市文化市场领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5820, 2674, '416330FEF75A79C448257A2B002A00AD', 68, 'sgsjms', '市国税局秘书', NULL, NULL, NULL, '', 3, '{}', 88),
(5821, 2675, '1A562B68C299B59748257A2B002A06C5', 68, 'sgsjrjk', '市国税局人监科', NULL, NULL, NULL, '', 3, '{}', 88),
(5822, 2676, '1B85820AD12547E948257A2F000C3AA6', 10, 'sfbxxcs', '信息测试', NULL, NULL, NULL, '', 3, '{}', 88),
(5823, 2678, 'B1DA63CAA0A5BBBF48257A3200064D1F', 62, 'swtjxhsd', '新华书店', NULL, NULL, NULL, '', 3, '{}', 88),
(5824, 2679, '6C1B5BB0CF7605D548257A410029C7F1', 6, 'kfqch', '开发区程恒', NULL, NULL, NULL, '', 3, '{}', 88),
(5825, 2680, '3B6B5865F1B1139B48257A410029C0CD', 6, 'kfqwjh', '开发区王剑侯', NULL, NULL, NULL, '', 3, '{}', 88),
(5826, 2681, '35B70AD05FF3058B48257A410029CEBA', 6, 'kfqzjj', '开发区张继杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5827, 2682, '42D53D500A6616FA48257A410029BAFF', 6, 'kfqzjy', '开发区周江勇', NULL, NULL, NULL, '', 3, '{}', 88),
(5828, 2684, 'CD5E2A31BCF9A80C48257A4B0005D3A0', 167, 'cxsyhxh', '慈溪市银行业协会', NULL, NULL, NULL, '', 3, '{}', 88),
(5829, 2689, '0D1006870C4452F848257A5D002A26D2', 65, 'ssjjjzs8', '市审计局孙永标', NULL, NULL, NULL, '', 3, '{}', 88),
(5830, 2690, '555714A6F748E7AA48257A6000071D86', 173, 'sxxcybgs6', '慈溪高新技术产业开发区管理委员会齐文浩', NULL, NULL, NULL, '', 3, '{}', 88),
(5831, 2691, 'EE8D7A225964F87B48257A61002F6E9D', 82, 'cdbhq3', '慈溪滨海经济开发区林益定', NULL, NULL, NULL, '', 3, '{}', 88),
(5832, 2692, '4C249F86570534F448257A630029122D', 47, 'smzjjz4', '市民政局何军', NULL, NULL, NULL, '', 3, '{}', 88),
(5833, 2693, '3CBC21426FACFDA148257A64000DE743', 190, 'sggwbgs', '市关工委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5834, 2694, '8E860FEFE2D168B948257A67002BB830', 191, 'sjczxwbgs', '市决策咨询委办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5835, 2695, '3784D0224E6D4A8B48257A67002BCC22', 191, 'sjczxwshfzb', '市决策咨询委社会发展部', NULL, NULL, NULL, '', 3, '{}', 88),
(5836, 2696, '21DDF259AF11037648257A67002BC553', 191, 'sjczxwtccxb', '市决策咨询委统筹城乡部', NULL, NULL, NULL, '', 3, '{}', 88),
(5837, 2697, '093A940BC44A021848257A67002BBEA8', 191, 'sjczxwzhjjb', '市决策咨询委综合经济部', NULL, NULL, NULL, '', 3, '{}', 88),
(5838, 2700, '34168B7BD91D347148257A6A000723AB', 192, 'sspscgwhbgs', '市商品市场物流园区管委会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5839, 2701, '8DEAFF9C80FAB7BD48257A6B000683ED', 55, 'szjjqtcl', '市发展新型墙体材料办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5840, 2702, '112692E787D031A948257A6E00290ACC', 10, 'sfbxj', '市府办徐吉', NULL, NULL, NULL, '', 3, '{}', 88),
(5841, 2703, '2959F7A3873FD47B48257A6F000ACD76', 158, 'zxzscb', '周巷镇三产办', NULL, NULL, NULL, '', 3, '{}', 88),
(5842, 2704, '1C13A6AEDFFA1C6148257A71002B371D', 192, 'sspscgwh1', '市商品市场物流园区管委会楼竞雄', NULL, NULL, NULL, '', 3, '{}', 88),
(5843, 2705, 'D804E56CB574792C48257A71002B3D86', 192, 'sspscgwh2', '市商品市场物流园区管委会周立挺', NULL, NULL, NULL, '', 3, '{}', 88),
(5844, 2706, 'A24C0FB192F5354548257A71002B4430', 192, 'sspscgwh3', '市商品市场物流园区管委会陈伯炬', NULL, NULL, NULL, '', 3, '{}', 88),
(5845, 2707, '22F7ED262C986F1848257A71002B5896', 192, 'sspscgwhsck', '市商品市场物流园区管委会市场运行科', NULL, NULL, NULL, '', 3, '{}', 88),
(5846, 2708, 'D66C56C0D48BACBA48257A71002B5180', 192, 'sspscgwhxmk', '市商品市场物流园区管委会项目管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(5847, 2709, 'F04C78A2DC46AE6548257A71002B4AEC', 192, 'sspscgwhzhk', '市商品市场物流园区管委会综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(5848, 2711, '1EFB0BAC99A7EC0A48257A7D0029762B', 154, 'cszjb', '崇寿镇教办', NULL, NULL, NULL, '', 3, '{}', 88),
(5849, 2713, '7C24DD394A73F26D48257A8400069563', 30, 'tswfsj4', '团市委李丽', NULL, NULL, NULL, '', 3, '{}', 88),
(5850, 2715, '8A0FA4C33AB3E2FD4825733300263C2D', 41, 'sjdhzb', '市家电会展办', NULL, NULL, NULL, '', 3, '{}', 88),
(5851, 2716, 'FA4117BB46B1EEB348257A9A000459FE', 57, 'sjtjzjz', '市交通运输局质监站', NULL, NULL, NULL, '', 3, '{}', 88),
(5852, 2717, 'A19847E52ED68D1F48257A9F0004FF3E', 47, 'smzjjz5', '市民政局许柏南', NULL, NULL, NULL, '', 3, '{}', 88),
(5853, 2720, '3A9D6DE8A37C70CA48257AAD00292233', 76, 'lpzxdbk', '市行政服务中心代办科', NULL, NULL, NULL, '', 3, '{}', 88),
(5854, 2721, 'D8A5DA34618CA17C48257AAD00292A80', 58, 'snyjzzgs', '市农业局种子公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5855, 2722, 'CC403FE5B0475C6348257AB6002D923F', 8, 'swbfxm', '市委办方湘敏', NULL, NULL, NULL, '', 3, '{}', 88),
(5856, 2723, '3B3F1B1C4AAD0F2D48257ABE0004493D', 75, 'scgj1', '市市综合行政执法局（市城管局）沈黎明', NULL, NULL, NULL, '', 3, '{}', 88),
(5857, 2724, 'C978FD6A6F45D4EC48257ABE00044FBC', 75, 'scgj2', '市综合行政执法局（市城管局）童成斌', NULL, NULL, NULL, '', 3, '{}', 88),
(5858, 2725, '9F5D40F27B95C53B48257ABE00224DD1', 65, 'ssjjjzs6', '市审计局俞金华', NULL, NULL, NULL, '', 3, '{}', 88),
(5859, 2726, '788561A1715D388048257AC20005687F', 75, 'scgjxx', '市综合行政执法局（市城管局）逍林中队', NULL, NULL, NULL, '', 3, '{}', 88),
(5860, 2728, '879327D90E99440148257AC20006C25D', 81, 'sggzyjgb1', '市公共资源交管办陈可伟', NULL, NULL, NULL, '', 3, '{}', 88),
(5861, 2729, '3BD9AEB2E4DF1C9248257AC20020EA00', 74, 'slyjjzs', '市旅游局徐建岳', NULL, NULL, NULL, '', 3, '{}', 88),
(5862, 2730, '8799A452F1926BB648257AC200212143', 47, 'smzjjz1', '市民政局戚建江', NULL, NULL, NULL, '', 3, '{}', 88),
(5863, 2731, '10D69B51A59931DE48257AC3000B4CB3', 10, 'sfbgww', '市府办高文武', NULL, NULL, NULL, '', 3, '{}', 88),
(5864, 2732, '009D1A7BA2832E9E48257AC3000B5358', 10, 'sfbll', '市府办罗烈', NULL, NULL, NULL, '', 3, '{}', 88),
(5865, 2733, 'EDFAB2C8F6F7F29948257AC300079AC8', 77, 'sjgfwzxjz4', '市机关事务管理局韩国飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5866, 2734, '62E88F94573A835E48257AC30007A178', 77, 'sjgfwzxjz5', '市机关事务管理局许建军', NULL, NULL, NULL, '', 3, '{}', 88),
(5867, 2735, '39ECED8D09E7F3B248257ACA000C284E', 9, 'srdnyncgw', '市人大农业农村工委', NULL, NULL, NULL, '', 3, '{}', 88),
(5868, 2736, 'EE2E0367DD1494A148257AD800052073', 63, 'swsjxxzx', '市卫生和计划生育局信息中心', NULL, NULL, NULL, '', 3, '{}', 88),
(5869, 2737, 'BA76CA6B796B408348257AD9000BF93A', 49, 'sllw2', '市老龄事业发展基金会', NULL, NULL, NULL, '', 3, '{}', 88),
(5870, 2738, '6F6F34D6B18BB9D048257ADB0009CC7F', 193, 'shszh2', '市红十字会胡峻箐', NULL, NULL, NULL, '', 3, '{}', 88),
(5871, 2739, '85289BAB03D40FB748257AE100142FCE', 27, 'cxrbs1', '慈溪日报社王迪', NULL, NULL, NULL, '', 3, '{}', 88),
(5872, 2740, 'A84E60212714239148257AE100072FCA', 75, 'scgj3', '市综合行政执法局（市城管局）杨杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5873, 2741, '8B7045319489FC8D48257AE900313A5C', 194, 'sswjtyxgs', '市水务集团有限公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5874, 2742, '39C305EC5862502348257AE9002E81CB', 62, 'swgj2', '市文广局姚煜', NULL, NULL, NULL, '', 3, '{}', 88),
(5875, 2743, '80D94AC963D7D45548257AE9002FB384', 29, 'szghzxs6', '市总工会赖静娥', NULL, NULL, NULL, '', 3, '{}', 88),
(5876, 2745, 'E5631B3FE08F229E48257AEB0006A224', 57, 'sjtjdyy2', '市交通运输局柴志清', NULL, NULL, NULL, '', 3, '{}', 88),
(5877, 2747, 'E1BCDDC8ED5E19D648257AEC002D82D8', 8, 'swbsga', '市委办沈皋安', NULL, NULL, NULL, '', 3, '{}', 88),
(5878, 2748, '92066FE5BDBD5CBF48257AED00288765', 66, 'shbjjzs8', '市环保局王慧慧', NULL, NULL, NULL, '', 3, '{}', 88),
(5879, 2749, '87595F8B59A06B1248257AED00076AB4', 183, 'szsj5', '市招商局虞坚定', NULL, NULL, NULL, '', 3, '{}', 88),
(5880, 2750, '09F5BF233E9BE57E48257AED0010AD5A', 183, 'szsjmch', '市招商局贸促会', NULL, NULL, NULL, '', 3, '{}', 88),
(5881, 2751, 'C3232875A27F77FB48257AED00077715', 183, 'szsjtzglk', '市招商局投资管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(5882, 2752, 'A639DF7DCF2388A348257AED000770D5', 183, 'szsjwmwjk', '市招商局外贸外经科', NULL, NULL, NULL, '', 3, '{}', 88),
(5883, 2754, '2EF6F71BF52F939A48257AEF002DB85A', 28, 'sdaj7', '市档案局徐建立', NULL, NULL, NULL, '', 3, '{}', 88),
(5884, 2755, 'A260F60B6CCC6B2148257AEF0005EEDA', 60, 'sswj3', '市商务局陈枫', NULL, NULL, NULL, '', 3, '{}', 88),
(5885, 2756, 'E35DBE606B8BD11E48257AEF000C41E6', 60, 'sswj4', '市商务局商子楠', NULL, NULL, NULL, '', 3, '{}', 88),
(5886, 2757, '59D6ED326396B2DA48257AF0000816AA', 80, 'sgzj5', '市国资局丁军', NULL, NULL, NULL, '', 3, '{}', 88),
(5887, 2758, '55F3ACC063D6C12948257AF4002CB0D0', 47, 'smzjjz6', '市民政局郑捷敏', NULL, NULL, NULL, '', 3, '{}', 88),
(5888, 2759, '3E5AAD0ED9DA970D48257AF4002DAF92', 19, 'smzzjjfjz5', '市民族宗教局蒋海莺', NULL, NULL, NULL, '', 3, '{}', 88),
(5889, 2760, 'BF1FEBEE4B596A7848257AF40027EB54', 55, 'szjj2', '市住建局华利波', NULL, NULL, NULL, '', 3, '{}', 88),
(5890, 2761, 'DE25B50DC475ACA748257AFA0023F8D9', 80, 'sgzjrjk', '市国资局人监科', NULL, NULL, NULL, '', 3, '{}', 88),
(5891, 2762, 'F52A0C27EB49462E48257AFA001208CF', 50, 'ssfj4', '市司法局潘柏幸', NULL, NULL, NULL, '', 3, '{}', 88),
(5892, 2763, '6CB9511AFC9C1AA148257AFA000E242A', 17, 'ssky3', '市社科联（院）张冰', NULL, NULL, NULL, '', 3, '{}', 88),
(5893, 2764, 'FBF6EB1B66679A9848257AFA000E2AC6', 17, 'ssky4', '市社科联（院）江维', NULL, NULL, NULL, '', 3, '{}', 88),
(5894, 2765, '3D77F4A78E0649FB48257AFC0005FAE1', 47, 'smzjjz7', '市民政局项其聪', NULL, NULL, NULL, '', 3, '{}', 88),
(5895, 2766, '96531EA6ABAE24B948257AFC00071705', 63, 'swsjjcs', '市卫生和计划生育局监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5896, 2767, '80501F5977BE844648257AFD002A6683', 44, 'skjj7', '市科技局孙剑锋', NULL, NULL, NULL, '', 3, '{}', 88),
(5897, 2768, '143A6043348E8E2B48257AFD0029DF20', 58, 'snyjjzs7', '市农业局周国爱', NULL, NULL, NULL, '', 3, '{}', 88),
(5898, 2769, 'B08446653CF933F048257AFD003056A5', 195, 'sxchzhb', '市新城河区块改造建设指挥部综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(5899, 2770, '0C6CBC216156FE3948257B0100059895', 58, 'snyj8', '市农业局毛玲洁', NULL, NULL, NULL, '', 3, '{}', 88),
(5900, 2772, '9D4571EE96D734F848257B01000D21FE', 70, 'szhjj2', '市质监局许雪松', NULL, NULL, NULL, '', 3, '{}', 88),
(5901, 2773, '4879C0652FD5EAA748257B030008276F', 78, 'sgjzx7', '市公建中心刘相飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5902, 2774, 'D9B68510EF9748B148257B030005913A', 196, 'shtzhkf1', '市海涂综合开发有限公司施孟杰', NULL, NULL, NULL, '', 3, '{}', 88),
(5903, 2775, 'AB8F62853DE0909848257B0300058A5E', 196, 'shtzhkfbgs', '市海涂综合开发有限公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5904, 2776, '756AF1E2DD60279D48257B0500281001', 195, 'sxchzhb1', '市新城河区块改造建设指挥部莫晓倪', NULL, NULL, NULL, '', 3, '{}', 88),
(5905, 2777, 'C71FF046FE75F06648257B050028163A', 195, 'sxchzhb2', '市新城河区块改造建设指挥部潘海明', NULL, NULL, NULL, '', 3, '{}', 88),
(5906, 2778, 'B848E569E75A17C048257B0500281C95', 195, 'sxchzhb3', '市新城河区块改造建设指挥部马杰川', NULL, NULL, NULL, '', 3, '{}', 88),
(5907, 2779, '90AD0BC2A5617E1D48257B0500282ADA', 195, 'sxchzhbdqk', '市新城河区块改造建设指挥部动迁科', NULL, NULL, NULL, '', 3, '{}', 88),
(5908, 2780, '04844B439187419948257B05002823B3', 195, 'sxchzhbjsk', '市新城河区块改造建设指挥部规划建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(5909, 2782, '9884AD0DECD3CD1C48257B14000CF929', 80, 'sgzjbgs', '市国资局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5910, 2783, '8BAF38771C59225248257B1500067DC6', 150, 'xpzhzb', '新浦镇环治办', NULL, NULL, NULL, '', 3, '{}', 88),
(5911, 2784, 'DEBDC77CA54A65BB48257B15000677C0', 150, 'xpzws', '新浦镇文书', NULL, NULL, NULL, '', 3, '{}', 88),
(5912, 2785, 'FAA41E087C419EF148257B17002BBF51', 188, 'sjsjt3', '市建设集团王云飞', NULL, NULL, NULL, '', 3, '{}', 88),
(5913, 2787, '573E063136E8F8D448257B1800082478', 161, 'bsljdxzjcs', '白沙路街道行政监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(5914, 2788, '39F5ED7CD5B3512C48257B18002C562F', 92, 'sgxls1', '市农合联执委会（市供销社)沈信波', NULL, NULL, NULL, '', 3, '{}', 88),
(5915, 2789, '64FEA6CBEBD6011A48257B18002C5D57', 92, 'sgxls2', '市农合联执委会（市供销社)王志孟', NULL, NULL, NULL, '', 3, '{}', 88),
(5916, 2790, 'CF5B5223F67EBF4248257B18002C63DF', 92, 'sgxls3', '市农合联执委会（市供销社)姚金权', NULL, NULL, NULL, '', 3, '{}', 88),
(5917, 2791, '241DC477547F17BC48257B18002C6AC8', 92, 'sgxls4', '市农合联执委会（市供销社)童爱军', NULL, NULL, NULL, '', 3, '{}', 88),
(5918, 2792, 'F81DAB988407086F48257B18002C77CD', 92, 'sgxlscw', '市农合联执委会（市供销社)财务审计部', NULL, NULL, NULL, '', 3, '{}', 88),
(5919, 2793, '4B50A6E1F24957EF48257B18002C84DD', 92, 'sgxlshz', '市农合联执委会（市供销社)产销经营合作部', NULL, NULL, NULL, '', 3, '{}', 88),
(5920, 2794, 'B21238366F8FF5A948257B18002C7E19', 92, 'sgxlsjj', '市农合联执委会（市供销社)合作经济发展部', NULL, NULL, NULL, '', 3, '{}', 88),
(5921, 2796, '3DAB7E7B9AC9F09448257B18002C8B63', 92, 'sgxlszc', '市农合联执委会（市供销社)四海资产经营公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5922, 2797, '0D14CB5F0A9EEC8348257B1A002A5AEA', 92, 'sgxls5', '市农合联执委会（市供销社)张伟男', NULL, NULL, NULL, '', 3, '{}', 88),
(5923, 2798, 'F45DA9407CD2CEF848257B1A002A611A', 92, 'sgxls6', '市农合联执委会（市供销社)陈仕宝', NULL, NULL, NULL, '', 3, '{}', 88),
(5924, 2799, '8CF1D2B3896007B048257B1A002A6706', 92, 'sgxls7', '市农合联执委会（市供销社)张建设', NULL, NULL, NULL, '', 3, '{}', 88),
(5925, 2800, 'DDDB7ACBC28F95D248257B1A002A6D7D', 92, 'sgxls8', '市农合联执委会（市供销社)罗乃建', NULL, NULL, NULL, '', 3, '{}', 88),
(5926, 2801, 'FBBEE1E7DBF15DCA48257B1D00296D2E', 92, 'sgxls9', '市农合联执委会（市供销社)潘孔云', NULL, NULL, NULL, '', 3, '{}', 88),
(5927, 2802, 'FC2FC4A7BCD20AFC48257B1F002CDA4E', 55, 'szjj4', '市住建局马钧', NULL, NULL, NULL, '', 3, '{}', 88),
(5928, 2803, 'E392DEF773AEBA3648257B280030A2E6', 55, 'szjjxdds', '市住建局现代都市', NULL, NULL, NULL, '', 3, '{}', 88),
(5929, 2804, '9BACD67D0A83C0ED48257B2C002D336B', 58, 'snyjslgaj', '市农业局森林公安局', NULL, NULL, NULL, '', 3, '{}', 88);
INSERT INTO `staff_tbl` (`staff_id`, `out_id`, `staff_unid`, `unit`, `staff_name`, `full_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`, `user_admin`, `reorder`) VALUES
(5930, 2805, '0835F4B820FC79E048257B4000074FB5', 10, 'sfbzx', '市府办郑啸', NULL, NULL, NULL, '', 3, '{}', 88),
(5931, 2806, 'BB3E1C26A0A2444048257B41002D838B', 42, 'sajj10', '市安监局岑剑峰', NULL, NULL, NULL, '', 3, '{}', 88),
(5932, 2807, 'B2B746BD8445C1D648257B41002D3FF8', 53, 'srlsbjjjjd', '市人力社保局社保基金监督科', NULL, NULL, NULL, '', 3, '{}', 88),
(5933, 2808, 'C82CEB87806CDF5F48257B47002F06D3', 65, 'jjfjcw', '基建分局财务', NULL, NULL, NULL, '', 3, '{}', 88),
(5934, 2809, '200D58BE0ABA141848257B47002F0DEF', 65, 'jjfjsllh', '基建分局水利绿化', NULL, NULL, NULL, '', 3, '{}', 88),
(5935, 2810, '6E70E1E2E886DF4748257B47002F149B', 15, 'sjwbgs2', '办公室信息报送专用', NULL, NULL, NULL, '', 3, '{}', 88),
(5936, 2811, 'C748C57DFB6D281248257B4A002903FD', 199, 'czyh', '稠州银行慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(5937, 2812, 'D15D9B529436E25748257B4A0028F63B', 0, 'sgyc', '“三改一拆”三年专项行动领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5938, 2813, '7764341BC7E4627148257B4A0028FCEE', 198, 'tzyh', '台州银行宁波分行', NULL, NULL, NULL, '', 3, '{}', 88),
(5939, 2814, '65606E7209625A9D48257B4E0006D2B5', 42, 'sajj11', '市安监局胡仲欧', NULL, NULL, NULL, '', 3, '{}', 88),
(5940, 2815, 'E5A134D4D3560DC348257B4F00256CB3', 194, 'sswjtyxgs1', '市水务集团有限公司边福春', NULL, NULL, NULL, '', 3, '{}', 88),
(5941, 2816, '3A98E5EE7DB53C8A48257B4F002573AA', 194, 'sswjtyxgs2', '市水务集团有限公司陈明军', NULL, NULL, NULL, '', 3, '{}', 88),
(5942, 2817, 'D3FAA0BDA43EFE1148257B4F00257A62', 194, 'sswjtyxgs3', '市水务集团有限公司叶萍', NULL, NULL, NULL, '', 3, '{}', 88),
(5943, 2818, '5D939A5CC941AADB48257B4F002580E1', 194, 'sswjtyxgs4', '市水务集团有限公司徐金辉', NULL, NULL, NULL, '', 3, '{}', 88),
(5944, 2819, '1ECF412CDA724BFB48257B4F002587A6', 194, 'sswjtyxgs5', '市水务集团有限公司办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(5945, 2820, 'DA5B0E0EB6DD2BEB48257B50002BD401', 194, 'sswjtyxgs6', '市水务集团有限公司计划财务部', NULL, NULL, NULL, '', 3, '{}', 88),
(5946, 2821, 'D0D3357653CDA63B48257B50002BDA6A', 194, 'sswjtyxgs7', '市水务集团有限公司人力资源部', NULL, NULL, NULL, '', 3, '{}', 88),
(5947, 2822, '0A3390806D30234348257B50002BE100', 194, 'sswjtyxgs8', '市水务集团有限公司纪检监察审计室', NULL, NULL, NULL, '', 3, '{}', 88),
(5948, 2823, '0E0E8FE6F23CD9E048257B50002BF18F', 194, 'sswjtyxgs9', '市水务集团有限公司生产业务部', NULL, NULL, NULL, '', 3, '{}', 88),
(5949, 2825, 'A81BC30C5330B70448257B5B0029CD81', 196, 'shtzhkf2', '市海涂综合开发有限公司戎国芳', NULL, NULL, NULL, '', 3, '{}', 88),
(5950, 2826, 'A1565E4C99BDF97448257B5B0029D3C9', 59, 'shtzhkf3', '市水利局孙建锁', NULL, NULL, NULL, '', 3, '{}', 88),
(5951, 2827, 'E8BC7BAD7FC0C7E848257B5B0029DA81', 196, 'shtzhkfcwb', '市海涂综合开发有限公司财务部', NULL, NULL, NULL, '', 3, '{}', 88),
(5952, 2828, '650D978F8EF613B448257B5B0029E123', 196, 'shtzhkfgcb', '市海涂综合开发有限公司工程部', NULL, NULL, NULL, '', 3, '{}', 88),
(5953, 2829, 'F987E90BB261398D48257B5B0029EF64', 196, 'shtzhkfqy', '市海涂综合开发有限公司企业管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(5954, 2830, 'B274F0590B2FAD3848257B5B0029E823', 196, 'shtzhkfzc', '市海涂综合开发有限公司资产经营部', NULL, NULL, NULL, '', 3, '{}', 88),
(5955, 2831, 'E565F561DB414AAB48257B5B002C1E45', 62, 'swwglcws', '市文物管理委员会办公室财务室', NULL, NULL, NULL, '', 3, '{}', 88),
(5956, 2832, 'AA2FF70C0BD56BD348257B5F000D6BD3', 76, 'lpzxzrs6', '市行政服务中心孙建区', NULL, NULL, NULL, '', 3, '{}', 88),
(5957, 2833, 'DF6965E0F579EF0748257B6000310821', 8, 'swbcq', '市委办岑泉', NULL, NULL, NULL, '', 3, '{}', 88),
(5958, 2834, '70440665CA84633748257B6000310ED8', 8, 'swbzjb', '市委办张建斌', NULL, NULL, NULL, '', 3, '{}', 88),
(5959, 2835, '8F5555648387F17148257B6600081191', 11, 'szxbcyy', '市政协办岑云益', NULL, NULL, NULL, '', 3, '{}', 88),
(5960, 2836, 'E2DADF34FEA8C81B48257B6600080B26', 11, 'szxbwr', '市政协办王溶', NULL, NULL, NULL, '', 3, '{}', 88),
(5961, 2837, '3F1805ED063FEBD648257B6B0030C0B1', 154, 'cszmlxz', '崇寿镇美丽乡村建设办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5962, 2838, '910EF76C8B4F3F3A48257B6B0030C77D', 154, 'csztj', '崇寿镇统计办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(5963, 2839, '832E0662C18B223C48257B6B0030977E', 144, 'lszlbs', '龙山镇劳保所', NULL, NULL, NULL, '', 3, '{}', 88),
(5964, 2840, 'D230EED520C3FC1F48257B6B00303F69', 0, 'sgyc1', '“三改一拆”三年专项行动领导小组办公室卞益锋', NULL, NULL, NULL, '', 3, '{}', 88),
(5965, 2841, 'CC02396A2FAD715F48257B6B00304660', 0, 'sgyc2', '“三改一拆”三年专项行动领导小组办公室胡孟夫', NULL, NULL, NULL, '', 3, '{}', 88),
(5966, 2842, 'B759580E51116E4248257B6B00304D79', 0, 'sgyc3', '“三改一拆”三年专项行动领导小组办公室童旭锋', NULL, NULL, NULL, '', 3, '{}', 88),
(5967, 2843, '81F4D671EB99B19848257B6B0030544F', 0, 'sgyc4', '“三改一拆”三年专项行动领导小组办公室陈黎明', NULL, NULL, NULL, '', 3, '{}', 88),
(5968, 2844, '319ECF0C4BD217A348257B6B00305B72', 0, 'sgyc5', '“三改一拆”三年专项行动领导小组办公室陈长新', NULL, NULL, NULL, '', 3, '{}', 88),
(5969, 2845, '23B1D5E96D38C4C848257B6B0030629F', 0, 'sgyc6', '“三改一拆”三年专项行动领导小组办公室潘建国', NULL, NULL, NULL, '', 3, '{}', 88),
(5970, 2846, 'F726196B0CBDACBD48257B6B0030725C', 0, 'sgycdcz', '“三改一拆”三年专项行动领导小组办公室督查考核组', NULL, NULL, NULL, '', 3, '{}', 88),
(5971, 2847, 'A3CC3870CC8A6D9148257B6B003079AB', 0, 'sgycxcz', '“三改一拆”三年专项行动领导小组办公室宣传保障组', NULL, NULL, NULL, '', 3, '{}', 88),
(5972, 2848, '487DA824A4BC763148257B6B00306AC4', 0, 'sgyczhz', '“三改一拆”三年专项行动领导小组办公室综合组', NULL, NULL, NULL, '', 3, '{}', 88),
(5973, 2849, '010FE0AD3E393B8D48257B74002BA799', 159, 'gtjd17', '古塘街道调研员4', NULL, NULL, NULL, '', 3, '{}', 88),
(5974, 2850, 'F07CED9B8099CBE248257B78000605E7', 62, 'sycgs', '市演出公司', NULL, NULL, NULL, '', 3, '{}', 88),
(5975, 2851, '9F5D7BA8755C8CEC48257B7C002CEC11', 62, 'swgj3', '市文广局房迪庆', NULL, NULL, NULL, '', 3, '{}', 88),
(5976, 2852, '7C6E6363A602C5B948257B7F00071516', 144, 'lsz14', '龙山镇三产副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(5977, 2853, 'B3B895BC69704E4348257B7F00071B57', 144, 'lszscb', '龙山镇三产办', NULL, NULL, NULL, '', 3, '{}', 88),
(5978, 2857, 'AABF9C54EC9DEC1248257B8E0028C9B7', 158, 'zxzjjwy1', '周巷镇纪检委员', NULL, NULL, NULL, '', 3, '{}', 88),
(5979, 2858, 'C35EA1A41E9AED3A48257B910007E0B6', 10, 'sfbzj', '市府办赵健', NULL, NULL, NULL, '', 3, '{}', 88),
(5980, 2859, 'D8B41AFFFDECEDD848257B910005BBD0', 77, 'sjgfwzxcgk3', '市机关事务管理局安全保卫科（车管科）3', NULL, NULL, NULL, '', 3, '{}', 88),
(5981, 2861, 'A2523CA1DF2452B248257B9500069CA6', 191, 'sjczxw2', '市决策咨询委施永新', NULL, NULL, NULL, '', 3, '{}', 88),
(5982, 2862, 'D744DB5A940B5A8448257B95000882C1', 77, 'sjggljbgs2', '市机关事务管理局办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(5983, 2863, '6462A3056046B0D348257B9500088946', 77, 'sjggljbgs3', '市机关事务管理局办公室3', NULL, NULL, NULL, '', 3, '{}', 88),
(5984, 2864, '0AFE9CFC7F8C0C1E48257B960031050F', 13, 'sfybay', '市法院备案员', NULL, NULL, NULL, '', 3, '{}', 88),
(5985, 2865, 'F21772EAFDC0658C48257B960030347A', 200, 'sjxczyh', '市建信村镇银行', NULL, NULL, NULL, '', 3, '{}', 88),
(5986, 2866, 'AFF9DB372BD3F90648257B96002FA6E4', 35, 'swl4', '市文联周萌', NULL, NULL, NULL, '', 3, '{}', 88),
(5987, 2867, 'F69B1EE4465AA3C248257B96002E2CDD', 35, 'swl5', '市文联钱燕燕', NULL, NULL, NULL, '', 3, '{}', 88),
(5988, 2868, '83798F7F202DC69B48257B9800064D2A', 0, 'scgj4', '市综合行政执法局（市城管局）袁东敏', NULL, NULL, NULL, '', 3, '{}', 88),
(5989, 2869, 'FD28F432062B308548257B980005FC9A', 99, 'sxdnykfq4', '市现代农业开发区管委会办公室主任', NULL, NULL, NULL, '', 3, '{}', 88),
(5990, 2870, 'BF88017E791C7D6148257B980006033D', 99, 'sxdnykfq5', '市现代农业开发区管委会备案员（办公室）', NULL, NULL, NULL, '', 3, '{}', 88),
(5991, 2871, '89A5FD6D7C86DCBC48257B9800060903', 99, 'sxdnykfq6', '市现代农业开发区管委会备案员（基建科）', NULL, NULL, NULL, '', 3, '{}', 88),
(5992, 2872, 'BCB192653DC58EF548257B9800061061', 0, 'sxdnykfq7', '市现代农业开发区管委会备案员（招商科）', NULL, NULL, NULL, '', 3, '{}', 88),
(5993, 2873, '8531E16C9CFE315048257B9800061747', 99, 'sxdnykfq8', '市现代农业开发区管委会财务', NULL, NULL, NULL, '', 3, '{}', 88),
(5994, 2874, '4A512EBB482DB86148257B9E0024B2D7', 161, 'bsljdbaad', '白沙路街道保安大队', NULL, NULL, NULL, '', 3, '{}', 88),
(5995, 2875, '855871CE8498A57348257B9E0024AC86', 161, 'bsljdcx', '白沙路街道成校', NULL, NULL, NULL, '', 3, '{}', 88),
(5996, 2876, 'B8A47D7B42EF949148257B9E0024C0F0', 154, 'cszpcs1', '崇寿派出所内勤', NULL, NULL, NULL, '', 3, '{}', 88),
(5997, 2877, '9460F17D90C73C0648257B9E0024CE85', 147, 'fhzpcs1', '附海派出所所长', NULL, NULL, NULL, '', 3, '{}', 88),
(5998, 2879, '66EF1BD0BD36DC0F48257B9E0024C790', 92, 'sgxls10', '市农合联执委会（市供销社)马聪云', NULL, NULL, NULL, '', 3, '{}', 88),
(5999, 2880, '59A2E4383B0758E848257B9E0024D555', 70, 'szhjj1', '市质监局高利伦', NULL, NULL, NULL, '', 3, '{}', 88),
(6000, 2881, '82AC58A946F6C33548257B9E0024DBA3', 70, 'szhjj3', '市质监局叶钊君', NULL, NULL, NULL, '', 3, '{}', 88),
(6001, 2882, 'ABF512386EB3AAAE48257B9E0024E2BC', 70, 'szhjj4', '市质监局邵聚樟', NULL, NULL, NULL, '', 3, '{}', 88),
(6002, 2883, '31BC534A7C1E160848257B9E0024E9F3', 70, 'szhjj5', '市质监局陈迪波', NULL, NULL, NULL, '', 3, '{}', 88),
(6003, 2884, '79349CB83299AAD048257B9E0024F111', 70, 'szhjj6', '市质监局黄江南', NULL, NULL, NULL, '', 3, '{}', 88),
(6004, 2885, 'C110F12277D0177148257B9E0024FDD2', 70, 'szhjj7', '市质监局陈翔', NULL, NULL, NULL, '', 3, '{}', 88),
(6005, 2886, '1C72EE9364C9969548257B9E0024F792', 70, 'szhjjfzk', '市质监局法制科', NULL, NULL, NULL, '', 3, '{}', 88),
(6006, 2888, '1823CAB2344DE0B348257BA30028DB2E', 81, 'sggzyjgb6', '市公共资源交管办胡东旭', NULL, NULL, NULL, '', 3, '{}', 88),
(6007, 2890, 'AD7142167C214D1F48257BA6000D3DC5', 20, 'swzfw11', '市委政法委陈松叶', NULL, NULL, NULL, '', 3, '{}', 88),
(6008, 2891, 'F130B900CC3C4DB648257BA6000DECA8', 20, 'swzfwzzdd', '市委政法委综治督导科', NULL, NULL, NULL, '', 3, '{}', 88),
(6009, 2892, '966579514C08061948257BA6000DE580', 20, 'swzfwzzxt', '市委政法委综治协调科', NULL, NULL, NULL, '', 3, '{}', 88),
(6010, 2893, 'ABDFB3E52C54D43D48257BA6000DDED8', 20, 'swzfwzzzd', '市委政法委综治指导科', NULL, NULL, NULL, '', 3, '{}', 88),
(6011, 2894, '5FFE836DD74C413448257BA6000EA946', 158, 'tybsc', '周巷镇天元办事处', NULL, NULL, NULL, '', 3, '{}', 88),
(6012, 2895, '1BF39CAB09527B1748257BA6000EAFC1', 158, 'tybsc1', '周巷镇天元办事处主任', NULL, NULL, NULL, '', 3, '{}', 88),
(6013, 2896, 'C66DFEF0266AB88948257BA6000EB6BE', 158, 'tybsc2', '周巷镇天元办事处副主任（综治）', NULL, NULL, NULL, '', 3, '{}', 88),
(6014, 2897, 'A6EA164B1D50E01548257BA6000EBD14', 158, 'tybsc3', '周巷镇天元办事处副主任（社事）', NULL, NULL, NULL, '', 3, '{}', 88),
(6015, 2898, 'EF2E620BFF69189148257BA6000EC469', 158, 'tybsc4', '周巷镇天元办事处副主任（劳保）', NULL, NULL, NULL, '', 3, '{}', 88),
(6016, 2899, '5BE5D9867D5BD93848257BAB00092DED', 27, 'cxrbs', '慈溪日报社许钰染', NULL, NULL, NULL, '', 3, '{}', 88),
(6017, 2900, 'D7E47485426F278C48257BAB0007C842', 27, 'cxrbs2', '慈溪日报社张能梓', NULL, NULL, NULL, '', 3, '{}', 88),
(6018, 2901, 'C74EBB905B5B3B6448257BAB0007CEE0', 27, 'cxrbs3', '慈溪日报社胡守华', NULL, NULL, NULL, '', 3, '{}', 88),
(6019, 2902, '2D0A99BF85D7E8A048257BAB0007D5BF', 27, 'cxrbs4', '慈溪日报社陆建章', NULL, NULL, NULL, '', 3, '{}', 88),
(6020, 2903, '912A6F31BA0A3EF148257BAB0009A309', 86, 'sqxjqfb', '市气防办', NULL, NULL, NULL, '', 3, '{}', 88),
(6021, 2904, 'D1D87D15F685552D48257BB10004B20E', 194, 'sswjtyxgs10', '市水务集团有限公司陈哉君', NULL, NULL, NULL, '', 3, '{}', 88),
(6022, 2905, 'F3E1FBE452D08AF848257BB3000CEAEA', 82, 'cdbhqgw', '慈溪滨海经济开发区工委', NULL, NULL, NULL, '', 3, '{}', 88),
(6023, 2906, 'AACA17DB27F5427F48257BB3000B902E', 23, 'sjgdgwzjk', '市机关党工委组纪科', NULL, NULL, NULL, '', 3, '{}', 88),
(6024, 2907, '8571E6D881A7B00248257BB3000C4162', 57, 'sjtjsslbzhb', '市交通运输局胜山至陆埠指挥部', NULL, NULL, NULL, '', 3, '{}', 88),
(6025, 2908, '5C4971C1909B1FE848257BB3000D836C', 201, 'zdyhcxzh', '渣打银行慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(6026, 2909, 'E0DB6457FEF18C8048257BBB002A7F5A', 47, 'smzjylzx', '市民政局养老指导中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6027, 2910, '929D22CCF8F9C85448257BBB002A7873', 2, 'swzqb', '市委张启表', NULL, NULL, NULL, '', 3, '{}', 88),
(6028, 2911, '9E62D5E1A15E27C248257BBF0005CBDB', 51, 'zwsjz', '全国政府性债务审计组', NULL, NULL, NULL, '', 3, '{}', 88),
(6029, 2912, '6550DAF949D73E6748257BC200084679', 68, 'sgsj2', '市国税局曹建国', NULL, NULL, NULL, '', 3, '{}', 88),
(6030, 2913, '50B77C10C91DB3E948257BC200084D3E', 68, 'sgsj3', '市国税局郑建国', NULL, NULL, NULL, '', 3, '{}', 88),
(6031, 2914, '763334C137F46CC148257BC20008541F', 68, 'sgsj4', '市国税局励松杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6032, 2915, 'D427CDCBBD37E5AF48257BC200085B18', 68, 'sgsjsrhsk', '市国税局收入核算科', NULL, NULL, NULL, '', 3, '{}', 88),
(6033, 2916, 'DDE69AA13E177CBF48257BC200086FAE', 68, 'sgsjsygl2', '市国税局税源管理二科', NULL, NULL, NULL, '', 3, '{}', 88),
(6034, 2917, '1DCEFF5EF3CDFA2348257BC200087655', 68, 'sgsjsygl3', '市国税局税源管理三科', NULL, NULL, NULL, '', 3, '{}', 88),
(6035, 2918, '217F548779F7C7FA48257BC200087DC3', 68, 'sgsjsygl4', '市国税局税源管理四科', NULL, NULL, NULL, '', 3, '{}', 88),
(6036, 2919, '6DD1D6821DE6C06548257BC200089060', 68, 'sgsjxxzx', '市国税局信息中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6037, 2920, '319E670D5E73FEB448257BC20008628B', 68, 'sgsjzcfgk', '市国税局政策法规科', NULL, NULL, NULL, '', 3, '{}', 88),
(6038, 2921, '32E2B189F098BE5D48257BC200086908', 68, 'sgsjzsglk', '市国税局征收管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6039, 2922, '70ED3922E24950E748257BC2000D3140', 202, 'sshjzzb1', '市水环境综治办华炯炜', NULL, NULL, NULL, '', 3, '{}', 88),
(6040, 2923, '12A7B3F972850C5B48257BC2000D37E9', 202, 'sshjzzb2', '市水环境综治办陈国员', NULL, NULL, NULL, '', 3, '{}', 88),
(6041, 2924, 'A54B4ED0CB05FB6D48257BC2000D3F96', 202, 'sshjzzb3', '市水环境综治办周乐波', NULL, NULL, NULL, '', 3, '{}', 88),
(6042, 2925, '6F842604F082657948257BC2000D464D', 202, 'sshjzzb4', '市水环境综治办综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(6043, 2926, 'DC96CFED293BD6E048257BC2000D4CFF', 202, 'sshjzzb5', '市水环境综治办建设规划科', NULL, NULL, NULL, '', 3, '{}', 88),
(6044, 2927, 'F75B02A52BCDDF1848257BC2000D538A', 202, 'sshjzzb6', '市水环境综治办面源治理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6045, 2928, '4BA266F50A40052248257BC50008521A', 15, 'sjw40', '市纪委黄玲琳', NULL, NULL, NULL, '', 3, '{}', 88),
(6046, 2929, 'DB1080DE7836040E48257BC5000858A3', 15, 'sjw41', '市纪委陈健', NULL, NULL, NULL, '', 3, '{}', 88),
(6047, 2930, 'EB5E7C9F1FB23D5948257BC500085F8A', 15, 'sjw42', '市纪委龚俊溢', NULL, NULL, NULL, '', 3, '{}', 88),
(6048, 2931, 'A52F1382E2BD7C7E48257BC50008672B', 15, 'sjw43', '市纪委许余钏', NULL, NULL, NULL, '', 3, '{}', 88),
(6049, 2932, '6336CF715D2D39D548257BC500088D77', 15, 'sjwags', '市纪委案管室', NULL, NULL, NULL, '', 3, '{}', 88),
(6050, 2933, 'B4DF9F52252380F648257BC7000662D1', 203, 'ssmtzjt2', '市商贸集团有限公司陆劲松', NULL, NULL, NULL, '', 3, '{}', 88),
(6051, 2934, '12264377CB16B15048257BC700066950', 203, 'ssmtzjt3', '市商贸集团有限公司邵政突', NULL, NULL, NULL, '', 3, '{}', 88),
(6052, 2935, 'D07C802E3CA84BA048257BBF000640B1', 192, 'sspscgwh4', '市商品市场物流园区管委会周庆海', NULL, NULL, NULL, '', 3, '{}', 88),
(6053, 2936, 'F682FB460FDE147B48257BCC002B6158', 203, 'ssmtzjtzh', '市商贸集团有限公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6054, 2937, 'DEA1E3D4CD798B0A48257BCC002BFBE5', 55, 'szjjczjs', '市住建局诚正建设工程检测有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6055, 2938, '490C92167EB4B20948257BD000057A38', 153, 'hhzdwwy', '横河镇徐文统', NULL, NULL, NULL, '', 3, '{}', 88),
(6056, 2939, '953E23C757C36E1C48257BD00005190A', 65, 'ssjjzgdck', '市审计局整改督查科', NULL, NULL, NULL, '', 3, '{}', 88),
(6057, 2940, '9F9C0A73D764AB5448257BDC00322BC2', 53, 'srcsc', '市人才市场办', NULL, NULL, NULL, '', 3, '{}', 88),
(6058, 2941, '22CB0EA630616C8348257BDE0004A8C3', 47, 'smzjcqfly', '市民政局城区福利院', NULL, NULL, NULL, '', 3, '{}', 88),
(6059, 2942, '970026927BD4CB7648257BE200059AC8', 194, 'sswjtyxgs11', '市水务集团有限公司徐卫平', NULL, NULL, NULL, '', 3, '{}', 88),
(6060, 2943, '838C1AC44320AFC048257BE50003848D', 13, 'sfysgb', '市法院审管办', NULL, NULL, NULL, '', 3, '{}', 88),
(6061, 2944, '1988B68F422BA00D48257BF30003500A', 154, 'cszszb', '崇寿镇水治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6062, 2945, 'F04E841DB176D83048257BF3000339DC', 43, 'sjyjkjyqbgs', '市教育局科教园区教育项目办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6063, 2946, '212DC0B5110590F148257BFE00306D8D', 62, 'swgb', '市文化体制改革和发展工作领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6064, 2948, '44FBA9BECCF7AEBD48257C0200279A15', 62, 'swtjykn', '市文广局虞卡娜', NULL, NULL, NULL, '', 3, '{}', 88),
(6065, 2949, '674BB3CDB24618E948257C040027CA23', 42, 'sajjjz1', '市安监局叶钊君', NULL, NULL, NULL, '', 3, '{}', 88),
(6066, 2950, '117166A6366D94C848257C0400270DCD', 76, 'sxzfwzx1', '市行政服务中心吴立明', NULL, NULL, NULL, '', 3, '{}', 88),
(6067, 2951, 'C960368C5D894FBB48257C07000E96CB', 77, 'sbgyfzczjbgs', '市办公用房自查自纠办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6068, 2952, 'A7C75808E37B363648257C080004E20A', 23, 'sjgdgwfsj3', '市机关党工委徐键', NULL, NULL, NULL, '', 3, '{}', 88),
(6069, 2953, '1D4F4F530878427A48257C14000365A6', 77, 'sjgfwzxjz6', '市机关事务管理局陈国荣', NULL, NULL, NULL, '', 3, '{}', 88),
(6070, 2954, 'ACCF7B25556FC02548257C1900047F97', 194, 'sswgcyxgs', '市水务工程有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6071, 2955, '2C1CC81B8DACE21148257C19000486F1', 194, 'sswtzyxgs', '市水务投资有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6072, 2956, 'A78141C21D277BAF48257C1A00088E17', 11, 'szxbxhy', '市政协办徐惠炎', NULL, NULL, NULL, '', 3, '{}', 88),
(6073, 2957, '3F9D5F81FC845B9F48257C1C0004B1E0', 153, 'hhzshjzzb', '横河镇水环境综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6074, 2958, 'E64D84BC0E7383B048257C2200296CD1', 159, 'gtjd18', '古塘街道调研员5', NULL, NULL, NULL, '', 3, '{}', 88),
(6075, 2959, '57C682974000819C48257C22002ACF3B', 204, 'sfwzgb1', '市房屋征管办余晓', NULL, NULL, NULL, '', 3, '{}', 88),
(6076, 2960, '1999CDFA91E22BB648257C22002AD632', 204, 'sfwzgb2', '市房屋征管办励国群', NULL, NULL, NULL, '', 3, '{}', 88),
(6077, 2961, '816D5FDE3F3C43AE48257C22002ADD00', 204, 'sfwzgb3', '市房屋征管办钱晶', NULL, NULL, NULL, '', 3, '{}', 88),
(6078, 2962, 'DCAD81CA95610C6A48257C22002B2AB7', 204, 'sfwzgbcq', '市房屋征管办拆迁管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6079, 2963, '81249703B18307AA48257C22002AEA82', 204, 'sfwzgbcw', '市房屋征管办财务资产科', NULL, NULL, NULL, '', 3, '{}', 88),
(6080, 2964, 'D04674DE6AD32F4C48257C22002AF123', 204, 'sfwzgbzc', '市房屋征管办政策法规科', NULL, NULL, NULL, '', 3, '{}', 88),
(6081, 2965, '693FA49A2998DD8948257C22002AE3CD', 204, 'sfwzgbzhk', '市房屋征管办综合科', NULL, NULL, NULL, '', 3, '{}', 88),
(6082, 2966, 'BD355F843895B07748257C22002B31C3', 204, 'sfwzgbzs', '市房屋征管办征收管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6083, 2967, 'BA96710CADC1A40C48257C22002B3807', 204, 'sfwzgbzszx', '市房屋征收中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6084, 2968, '052DBBA73398703D48257C3C002B02AF', 45, 'sgajfkb', '慈溪市反恐办', NULL, NULL, NULL, '', 3, '{}', 88),
(6085, 2969, '3990A69BD8EB290348257C3F00107D31', 10, 'sfbzff', '市府办周方方', NULL, NULL, NULL, '', 3, '{}', 88),
(6086, 2970, 'A1773197E5F51E5648257C450013F8E9', 45, 'sgajkjxtk', '市公安局科技信通科', NULL, NULL, NULL, '', 3, '{}', 88),
(6087, 2971, '86E79172ED1CA16A48257C4500294925', 202, 'sshjzzb7', '市水环境综治办孙彬', NULL, NULL, NULL, '', 3, '{}', 88),
(6088, 2972, 'F901F2E3A251C3BF48257C450013F232', 8, 'swbyzd', '市委办虞展东', NULL, NULL, NULL, '', 3, '{}', 88),
(6089, 2974, '132F60F2F4A12C0E48257C4A00202335', 80, 'sgzb7', '市国资局陈宏杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6090, 2975, '5980CC62A37E9CBE48257C4A001E9104', 43, 'sjyj10', '市教育局陈燕俐', NULL, NULL, NULL, '', 3, '{}', 88),
(6091, 2976, '638C197B5A62AA1848257C4A001E9769', 43, 'sjyj11', '市教育局谢柏南', NULL, NULL, NULL, '', 3, '{}', 88),
(6092, 2977, '927D9360E50DB04C48257C4B00292D25', 185, 'sjgdd1', '市景观大道改造指挥部岑士达', NULL, NULL, NULL, '', 3, '{}', 88),
(6093, 2978, '2D56330648620B0548257C4B00293427', 185, 'sjgdd2', '市景观大道改造指挥部张建锁', NULL, NULL, NULL, '', 3, '{}', 88),
(6094, 2979, '7BC4C0DA8540BF5A48257C4B00293B16', 185, 'sjgdd3', '市景观大道改造指挥部周大效', NULL, NULL, NULL, '', 3, '{}', 88),
(6095, 2980, '2E139C90939852B448257C4B00294934', 185, 'sjgdddqk', '市景观大道改造指挥部动迁科', NULL, NULL, NULL, '', 3, '{}', 88),
(6096, 2981, 'BA7B4BF13979532448257C4B00294291', 185, 'sjgddjsk', '市景观大道改造指挥部建设科', NULL, NULL, NULL, '', 3, '{}', 88),
(6097, 2982, 'F39A929D8330436F48257C4B0025AA43', 62, 'swgj4', '市文广局陈剑波', NULL, NULL, NULL, '', 3, '{}', 88),
(6098, 2983, '4174416AEEBBEA4948257C4B0025B0F1', 62, 'swgj5', '市文广局施焕法', NULL, NULL, NULL, '', 3, '{}', 88),
(6099, 2984, '677AE1B3BF4FFF3148257C4B0025B7BB', 62, 'swgj6', '市文广局胡康东', NULL, NULL, NULL, '', 3, '{}', 88),
(6100, 2985, '2DBA4B84BC86806C48257C4C000B0491', 20, 'swzfw12', '市委政法委余玮', NULL, NULL, NULL, '', 3, '{}', 88),
(6101, 2986, 'AF520E665AC7828248257C4D0003D89D', 55, 'szjj5', '市住建局施约维', NULL, NULL, NULL, '', 3, '{}', 88),
(6102, 2987, 'F142C0B2A2BD081748257C51002F9062', 53, 'srlsbj13', '市人力社保局陆啸峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6103, 2988, '22820EEC4CE6184E48257C51002F96AD', 53, 'srlsbj14', '市人力社保局许文杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6104, 2989, '0C8FAFA0AF3DD77348257C510010A27F', 11, 'szxbffj', '市政协办范峰杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6105, 2990, '765A1778AE293C6548257C5500282716', 161, 'bsljd19', '白沙路街道人大工委副主任3', NULL, NULL, NULL, '', 3, '{}', 88),
(6106, 2991, '427E5006BDB9394C48257C55001FEF4C', 49, 'sllw3', '市老龄委（办）何静宜', NULL, NULL, NULL, '', 3, '{}', 88),
(6107, 2992, '3E7CD82F21E2BAFD48257C5A002ACBBA', 153, 'hhztyy2', '横河镇孙振威', NULL, NULL, NULL, '', 3, '{}', 88),
(6108, 2993, '2798854B01E7D2F148257C5B0005ECB3', 58, 'snyj9', '市农业局孙冲波', NULL, NULL, NULL, '', 3, '{}', 88),
(6109, 2997, 'AA87C06B05A7220248257C5F0007E2CF', 56, 'ghjchydlxxk', '市规划局规划局测绘与地理信息科', NULL, NULL, NULL, '', 3, '{}', 88),
(6110, 2998, 'DFFD9B062AAA697548257C60002E4D07', 33, 'sclzcb', '市残联组宣部', NULL, NULL, NULL, '', 3, '{}', 88),
(6111, 2999, '8AB2B90FDD7AE21B48257C60002E34C0', 67, 'sxfjjzs6', '市信访局杨巨海', NULL, NULL, NULL, '', 3, '{}', 88),
(6112, 3000, 'A248E76BE9A49E4D48257C600008DAE6', 4, 'szfjjx', '市政府蒋君祥', NULL, NULL, NULL, '', 3, '{}', 88),
(6113, 3001, '4067F334C451D8A548257C660007141E', 81, 'sztbfzjck', '市公共资源交管办法制监察科', NULL, NULL, NULL, '', 3, '{}', 88),
(6114, 3003, 'C0D4339A14AF4C0A48257C690005B4A5', 57, 'sjtj9', '市交通运输局孙玲玲', NULL, NULL, NULL, '', 3, '{}', 88),
(6115, 3004, '6F7013A14CFBC33F48257C6C0004660F', 58, 'snyjdjs', '市农业局动监所', NULL, NULL, NULL, '', 3, '{}', 88),
(6116, 3005, '7F0DC8C463A3DD7448257C6C0004739C', 58, 'snyjyzz', '市农业局渔政站', NULL, NULL, NULL, '', 3, '{}', 88),
(6117, 3006, 'C3B5CD96BA8C102E48257C6C00046D0B', 58, 'snyjzjz', '市农业局植检站', NULL, NULL, NULL, '', 3, '{}', 88),
(6118, 3017, 'A6EE274CF4A29D6C48257C78002A4B73', 8, 'swblq', '市委办罗琦', NULL, NULL, NULL, '', 3, '{}', 88),
(6119, 3019, '20C4D301C6A5369848257C78002A5204', 8, 'swbzs', '市委办赵珊', NULL, NULL, NULL, '', 3, '{}', 88),
(6120, 3020, '5C0CA21A5685A7E548257C7900063C22', 8, 'swblxh1', '市委办励幸辉', NULL, NULL, NULL, '', 3, '{}', 88),
(6121, 3021, 'ADF8904DB323A45E48257C7900241BD5', 29, 'szghjsb', '市建功立业劳动竞赛办', NULL, NULL, NULL, '', 3, '{}', 88),
(6122, 3022, '324D6C9D98155C6248257C7A001B43C4', 2, 'swbja', '市委卞吉安', NULL, NULL, NULL, '', 3, '{}', 88),
(6123, 3023, '8623626C3C9B5B3A48257C7D00062FD8', 13, 'sfy19', '市法院陈银建', NULL, NULL, NULL, '', 3, '{}', 88),
(6124, 3024, '369008EE9C4857FA48257C8200056244', 149, 'sszcsfh', '胜山镇慈善分会', NULL, NULL, NULL, '', 3, '{}', 88),
(6125, 3025, '0B3399782A10278D48257C82000568F4', 149, 'sszggw', '胜山镇关工委', NULL, NULL, NULL, '', 3, '{}', 88),
(6126, 3026, '6D4DF7A39EEFFC6D48257C8200055B77', 149, 'sszrdfzx', '胜山镇人大副主席', NULL, NULL, NULL, '', 3, '{}', 88),
(6127, 3028, '1F561B12FF15475648257C850006120C', 75, 'scgjcdbhq', '市综合行政执法局（市城管局）慈东滨海区中队', NULL, NULL, NULL, '', 3, '{}', 88),
(6128, 3029, '597CCFA241B90AE648257C8500060ADD', 75, 'scgjwhswq', '市综合行政执法局（市城管局）文化商务区中队', NULL, NULL, NULL, '', 3, '{}', 88),
(6129, 3030, 'B9F2CB70E9FA685448257C8500061900', 29, 'szghakbjsb', '市总工会安康杯竞赛办', NULL, NULL, NULL, '', 3, '{}', 88),
(6130, 3031, '3BCFBB9714A38A6748257C8B0005FC02', 23, 'sjgdgw4', '市机关党工委姚海华', NULL, NULL, NULL, '', 3, '{}', 88),
(6131, 3032, 'A4085D8774E9437F48257C8B0006028F', 23, 'sjgdgw5', '市机关党工委陆纪森', NULL, NULL, NULL, '', 3, '{}', 88),
(6132, 3034, 'D43137A82588865948257C90002201CC', 205, 'nbdhyhcxzh', '宁波东海银行慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(6133, 3035, '91D3B41AF78D505948257C91000487CD', 89, 'sjyjyj1', '市检验检疫局张忠义', NULL, NULL, NULL, '', 3, '{}', 88),
(6134, 3036, '641C3F326469CE9C48257C94000776CA', 57, 'sjtjqzlx1', '市交通运输局群众路线教育实践活动办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6135, 3038, '71F6CC15194621E648257C97001475E0', 65, 'ssjjtjs', '市审计局同级审资料上报', NULL, NULL, NULL, '', 3, '{}', 88),
(6136, 3039, '72120945260F62B148257C990022CCED', 206, 'cxsxsjyjh', '慈溪市新四军研究会', NULL, NULL, NULL, '', 3, '{}', 88),
(6137, 3040, 'F46EB97979C2B32448257CB00029C919', 148, 'xlzjdb', '逍林镇禁毒办', NULL, NULL, NULL, '', 3, '{}', 88),
(6138, 3041, '02CC971EEF6653F648257CB5002EA260', 207, 'nbtsyh', '宁波通商银行慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(6139, 3042, '7A1DC6F05E66F4C648257CB5002D826C', 202, 'sshjzzb8', '市水环境综治办督查科', NULL, NULL, NULL, '', 3, '{}', 88),
(6140, 3043, 'A9DE97AFEC721C6C48257CB5002D8A2C', 202, 'sshjzzb9', '市水环境综治办农村污水治理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6141, 3044, '8830984103DE905348257CBA000502F2', 152, 'kyzczglb', '匡堰镇城镇管理办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6142, 3045, '253DDE14BA1A057148257CBA00050AA3', 152, 'kyzshjb', '匡堰镇水环境办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6143, 3046, '27036D218D50FF2C48257CC10009F74C', 58, 'snyjnak', '市农业局农安科', NULL, NULL, NULL, '', 3, '{}', 88),
(6144, 3047, '1BF720B0AE658B1F48257CC2000E4B15', 77, 'sjgyry2', '市机关幼儿园２', NULL, NULL, NULL, '', 3, '{}', 88),
(6145, 3048, 'BA3C5D0C42A7DB4248257CCA00082FFA', 16, 'swzzb10', '市委组织部张�f颖', NULL, NULL, NULL, '', 3, '{}', 88),
(6146, 3049, 'DF4E58110E5DF24948257CCA00083690', 16, 'swzzb11', '市委组织部徐佩毓', NULL, NULL, NULL, '', 3, '{}', 88),
(6147, 3050, '777D1B0A1982BFE248257CCA00083D2B', 16, 'swzzb12', '市委组织部周宇锡', NULL, NULL, NULL, '', 3, '{}', 88),
(6148, 3052, '053890395B6F2DB548257CCA00082264', 16, 'swzzb6', '市委组织部华建清', NULL, NULL, NULL, '', 3, '{}', 88),
(6149, 3053, '3BED228BB19DDA7D48257CCA000814FA', 8, 'swzzb7', '市委办贺振遥', NULL, NULL, NULL, '', 3, '{}', 88),
(6150, 3054, '01BBCC7F7517C8AA48257CCA00081B6C', 16, 'swzzb8', '市委组织部徐裔君', NULL, NULL, NULL, '', 3, '{}', 88),
(6151, 3055, '181C24004694E1FA48257CCA0008296A', 16, 'swzzb9', '市委组织部蒋泓杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6152, 3056, '06D5C8C523F084F248257CCA000859D7', 150, 'xpzszb', '新浦镇水治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6153, 3057, 'BAAF10472D61135048257CCE0011808F', 202, 'sshjzzb10', '市水环境综治办王新华', NULL, NULL, NULL, '', 3, '{}', 88),
(6154, 3058, '9B0E82855482EB2048257CCE0011878A', 202, 'sshjzzb11', '市水环境综治办龚正荣', NULL, NULL, NULL, '', 3, '{}', 88),
(6155, 3059, 'E3D3045F0B77077348257CD10005ABC4', 65, 'ssjjjj1', '市审计局基建分局李应兵', NULL, NULL, NULL, '', 3, '{}', 88),
(6156, 3060, '0B59BC62636E73EF48257CD10005B2DA', 65, 'ssjjjj2', '市审计局基建分局郑建波', NULL, NULL, NULL, '', 3, '{}', 88),
(6157, 3062, 'A94A41E8D84CE65048257CD2002D233A', 146, 'ghwzszb', '观海卫镇水治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6158, 3064, 'DBF5CBC7F91D86EA48257CDE002FA8EC', 58, 'snyj10', '市农业局卢研技', NULL, NULL, NULL, '', 3, '{}', 88),
(6159, 3065, 'C4658C8804CEAB1948257CED003542F1', 184, 'sbwb6', '市编委办陈劲松', NULL, NULL, NULL, '', 3, '{}', 88),
(6160, 3066, 'A71C9C29589B473248257CED000704BC', 8, 'swbydh', '市委办应登海', NULL, NULL, NULL, '', 3, '{}', 88),
(6161, 3067, 'ADD540D4AB44DE0448257CED0006FDCC', 2, 'szfcjf', '市委陈杰峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6162, 3068, 'FFA6099CAA2CF8E148257CEF0007260C', 65, 'ssjjbgs7', '市审计局胡立君', NULL, NULL, NULL, '', 3, '{}', 88),
(6163, 3069, '300FE69040421CEA48257CEF00060F2B', 16, 'swzzb4', '市委组织部赵录平', NULL, NULL, NULL, '', 3, '{}', 88),
(6164, 3070, 'E1A7B0D3227E5E3C48257CEF0007A3EA', 150, 'xpzwzbz', '新浦镇武装部长', NULL, NULL, NULL, '', 3, '{}', 88),
(6165, 3071, '202B69896B3BCBC448257CF200304D6E', 10, 'sfbchs', '市府办成双', NULL, NULL, NULL, '', 3, '{}', 88),
(6166, 3072, '13676B30DC10F57148257CF2002FEB79', 10, 'sfbxqy', '市府办许骞月', NULL, NULL, NULL, '', 3, '{}', 88),
(6167, 3073, '2AB6A1C3B88B820848257CF50005AEBD', 82, 'cdbhq4', '慈溪滨海经济开发区范常林', NULL, NULL, NULL, '', 3, '{}', 88),
(6168, 3074, 'B7B94ADDEC81047C48257CFD0006CE48', 147, 'fhztyy', '附海镇便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6169, 3075, '8BD5C818996DC4AC48257D000006BA20', 146, 'ghwzrdzx', '观海卫镇人大主席', NULL, NULL, NULL, '', 3, '{}', 88),
(6170, 3076, 'CB7B34538A64241548257D000006B115', 10, 'sfbwq', '市府办王琪', NULL, NULL, NULL, '', 3, '{}', 88),
(6171, 3077, 'BEAD4F51B0336E5148257D0200327283', 59, 'szxskglc', '市郑徐水库管理处', NULL, NULL, NULL, '', 3, '{}', 88),
(6172, 3078, 'ABC52F7C7F7C695148257D030007B5B3', 208, 'sscjgjbgs', '市市场监管局办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6173, 3079, '5F9E3D940C33199048257D0300080C22', 208, 'sscjgjbhk', '市市场监管局保化科', NULL, NULL, NULL, '', 3, '{}', 88),
(6174, 3080, '5F2CBECE459619AC48257D030008A558', 208, 'sscjgjbsls', '市市场监管局白沙路所', NULL, NULL, NULL, '', 3, '{}', 88),
(6175, 3081, 'DCD56AAB44A4374748257D0300090CD9', 208, 'sscjgjchs', '市市场监管局长河所', NULL, NULL, NULL, '', 3, '{}', 88),
(6176, 3082, '69D7A7F19AD1DF6748257D0300079A0A', 208, 'sscjgjcqb', '市市场监管局陈庆波', NULL, NULL, NULL, '', 3, '{}', 88),
(6177, 3083, '74EA128BAE2C4C1448257D0300078C6C', 208, 'sscjgjcxz', '市市场监管局陈行洲', NULL, NULL, NULL, '', 3, '{}', 88),
(6178, 3084, '9BA711A2C41B630548257D03000804F3', 208, 'sscjgjcyk', '市市场监管局餐饮科', NULL, NULL, NULL, '', 3, '{}', 88),
(6179, 3085, 'F27A4FD301A5984D48257D030007CB76', 208, 'sscjgjfgk', '市市场监管局法规科', NULL, NULL, NULL, '', 3, '{}', 88),
(6180, 3086, 'DE5453AF1439168F48257D030008D505', 208, 'sscjgjfhs', '市市场监管局附海所', NULL, NULL, NULL, '', 3, '{}', 88),
(6181, 3087, 'FFB180E9458FC0E848257D030008CE97', 208, 'sscjgjghwfj', '市市场监管局观海卫分局', NULL, NULL, NULL, '', 3, '{}', 88),
(6182, 3088, '640FAB4FDA8D5A6248257D030008ABCF', 208, 'sscjgjgts', '市市场监管局古塘所', NULL, NULL, NULL, '', 3, '{}', 88),
(6183, 3089, '8E94C146AEB967D848257D030008FEE2', 208, 'sscjgjhhs', '市市场监管局横河所', NULL, NULL, NULL, '', 3, '{}', 88),
(6184, 3090, 'EC145F661D2638E348257D03000747E0', 208, 'sscjgjhjp', '市市场监管局胡建平', NULL, NULL, NULL, '', 3, '{}', 88),
(6185, 3091, 'E1244EFAEC4C774C48257D0300089E7A', 208, 'sscjgjhss', '市市场监管局浒山所', NULL, NULL, NULL, '', 3, '{}', 88),
(6186, 3092, 'BF4FA01F9391FA2B48257D0300075143', 208, 'sscjgjhxl', '市市场监管局何锡利', NULL, NULL, NULL, '', 3, '{}', 88),
(6187, 3093, 'A14A2867D9DF5EAD48257D030007A0CC', 208, 'sscjgjjbc', '市市场监管局金百春', NULL, NULL, NULL, '', 3, '{}', 88),
(6188, 3094, '6A77B6C11D4DD7F248257D03000820E1', 208, 'sscjgjjcdd', '市市场监管局稽查大队', NULL, NULL, NULL, '', 3, '{}', 88),
(6189, 3095, 'CBC676F07AE432AA48257D030007C46B', 208, 'sscjgjjjcs', '市市场监管局纪检监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(6190, 3096, '9A394CD2F2C2777C48257D030008B936', 208, 'sscjgjkds', '市市场监管局坎墩所', NULL, NULL, NULL, '', 3, '{}', 88),
(6191, 3097, '8DFA5EAD00730D0148257D030008F7B6', 208, 'sscjgjkys', '市市场监管局匡堰所', NULL, NULL, NULL, '', 3, '{}', 88),
(6192, 3098, 'BA8537DE366D46D548257D030008C128', 208, 'sscjgjlsfj', '市市场监管局龙山分局', NULL, NULL, NULL, '', 3, '{}', 88),
(6193, 3099, 'F00EE72C15C8B83248257D0300076EFF', 208, 'sscjgjqjy', '市市场监管局戚俊彦', NULL, NULL, NULL, '', 3, '{}', 88),
(6194, 3100, '56B1124BB04403A248257D030008F0BD', 208, 'sscjgjqts', '市市场监管局桥头所', NULL, NULL, NULL, '', 3, '{}', 88),
(6195, 3101, 'C2C549CD5A92331B48257D03000819CE', 208, 'sscjgjqxk', '市市场监管局器械科', NULL, NULL, NULL, '', 3, '{}', 88),
(6196, 3102, '7EB058062130DD9048257D030007DA7D', 208, 'sscjgjqyk', '市市场监管局企业科', NULL, NULL, NULL, '', 3, '{}', 88),
(6197, 3103, 'A405C4176D585CC248257D030007E148', 208, 'sscjgjschtk', '市市场监管局市场合同科', NULL, NULL, NULL, '', 3, '{}', 88),
(6198, 3104, '86BFC1ADDE27F9D048257D0300091A82', 208, 'scwb', '市查无办', NULL, NULL, NULL, '', 3, '{}', 88),
(6199, 3105, 'B28656D47D396E9A48257D0400154A90', 208, 'sjczx1', '市检测中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6200, 3106, '83D0092F278F440C48257D04001550CA', 208, 'smgb1', '市民个办', NULL, NULL, NULL, '', 3, '{}', 88),
(6201, 3107, 'E24852E5B1D87C8448257D030008276F', 208, 'sqyxyxxb', '市企业信用信息办', NULL, NULL, NULL, '', 3, '{}', 88),
(6202, 3108, '35803EAB5DF76C4248257D030007E939', 208, 'sscjgjsgk', '市市场监管局商广科', NULL, NULL, NULL, '', 3, '{}', 88),
(6203, 3109, '90F0D66922F5117048257D0300075992', 208, 'sscjgjsjd', '市市场监管局沈箭达', NULL, NULL, NULL, '', 3, '{}', 88),
(6204, 3110, 'D67B52EF7417B85848257D0300077E06', 208, 'sscjgjsjf', '市市场监管局孙聚峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6205, 3111, 'A28EAB748752770B48257D030007FD82', 208, 'sscjgjspltk', '市市场监管局食品流通科', NULL, NULL, NULL, '', 3, '{}', 88),
(6206, 3112, '8DD7674EC00AB88348257D030007F6A8', 208, 'sscjgjspsck', '市市场监管局食品生产科', NULL, NULL, NULL, '', 3, '{}', 88),
(6207, 3113, '28353EF3F0177F1048257D030007EFB7', 208, 'sscjgjspxtk', '市市场监管局食品协调科', NULL, NULL, NULL, '', 3, '{}', 88),
(6208, 3114, '00CE3F747157AF9C48257D030008E3C8', 208, 'sscjgjsss', '市市场监管局胜山所', NULL, NULL, NULL, '', 3, '{}', 88),
(6209, 3115, '6F6C109502E8D50D48257D030007857D', 208, 'sscjgjsxm', '市市场监管局孙雪漫', NULL, NULL, NULL, '', 3, '{}', 88),
(6210, 3116, '7351A5971E1D97D948257D0300079325', 208, 'sscjgjsxn', '市市场监管局孙雪妮', NULL, NULL, NULL, '', 3, '{}', 88),
(6211, 3117, '0AB93EEED55F9F3348257D03000935DE', 208, 'sscjgjtw', '市市场监管局团委', NULL, NULL, NULL, '', 3, '{}', 88),
(6212, 3118, '237C52AA71FCC9D648257D0300077601', 208, 'sscjgjwsr', '市市场监管局汪世荣', NULL, NULL, NULL, '', 3, '{}', 88),
(6213, 3119, '04C1A6872072ADFD48257D0300075FF2', 208, 'sscjgjwxp', '市市场监管局王筱萍', NULL, NULL, NULL, '', 3, '{}', 88),
(6214, 3120, '989D2C8D24B0C1FB48257D030008DC40', 208, 'sscjgjxls', '市市场监管局逍林所', NULL, NULL, NULL, '', 3, '{}', 88),
(6215, 3121, '9E83CFCDBDFBAB4048257D030008EA4D', 208, 'sscjgjxps', '市市场监管局新浦所', NULL, NULL, NULL, '', 3, '{}', 88),
(6216, 3122, '3B6D81BF59B77C6548257D030007D323', 208, 'sscjgjxzspk', '市市场监管局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(6217, 3124, 'D2A77ED19FA4513548257D0300093D57', 208, 'sscjgjyjb', '市市场监管局应急室', NULL, NULL, NULL, '', 3, '{}', 88),
(6218, 3125, '9D0763891988AFCA48257D03000812FD', 208, 'sscjgjypk', '市市场监管局药品科', NULL, NULL, NULL, '', 3, '{}', 88),
(6219, 3126, '0F2AE4B31547B99C48257D030008B284', 208, 'sscjgjzhs', '市市场监管局宗汉所', NULL, NULL, NULL, '', 3, '{}', 88),
(6220, 3127, 'DED6845BBC8930E048257D030007A85C', 208, 'sscjgjzlf', '市市场监管局周黎芳', NULL, NULL, NULL, '', 3, '{}', 88),
(6221, 3128, 'C4EDE1459F5848D548257D030008C7EF', 208, 'sscjgjzqs', '市市场监管局掌起所', NULL, NULL, NULL, '', 3, '{}', 88),
(6222, 3129, 'D6156639F492E32948257D030009056D', 208, 'sscjgjzsc', '市市场监管局崇寿所', NULL, NULL, NULL, '', 3, '{}', 88),
(6223, 3130, '52C62753BCD223E048257D0300091413', 208, 'sscjgjzxfj', '市市场监管局周巷分局', NULL, NULL, NULL, '', 3, '{}', 88),
(6224, 3131, '9F8CD820952A253E48257D030007AF13', 208, 'sscjgjzzl', '市市场监管局张志林', NULL, NULL, NULL, '', 3, '{}', 88),
(6225, 3132, '8C5F64C24710A7C648257D030007BD60', 208, 'sscjgjzzrsk', '市市场监管局组织人事科', NULL, NULL, NULL, '', 3, '{}', 88),
(6226, 3133, '01FE2BAF9579A98548257D0300092F07', 208, 'sstb', '市商提办', NULL, NULL, NULL, '', 3, '{}', 88),
(6227, 3134, '8941EE9E4520830548257D04002A69A6', 194, 'sswjtyxgs12', '市水务集团有限公司企业管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(6228, 3135, '6732A3051A41BDFC48257D0400042355', 8, 'swbzww', '市委办张威威', NULL, NULL, NULL, '', 3, '{}', 88),
(6229, 3136, '86BC9A1C663E827A48257D03000874F8', 208, 'sxbb', '市消保办', NULL, NULL, NULL, '', 3, '{}', 88),
(6230, 3137, 'E0CDF86343DC83B148257D0400154474', 208, 'sscjgjjbzx', '市市场监管局举报中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6231, 3138, '84018E1FFAF8C69648257D110008F32D', 203, 'ssmtzjt4', '市商贸集团有限公司劳柏虹', NULL, NULL, NULL, '', 3, '{}', 88),
(6232, 3139, 'D3D50B9834E6002D48257D110008F95C', 203, 'ssmtzjt5', '市商贸集团有限公司成冠军', NULL, NULL, NULL, '', 3, '{}', 88),
(6233, 3140, '92CF9A87EFE23DC148257D11000838BA', 149, 'sszszb', '胜山镇水治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6234, 3141, 'C1AA5050A041D85548257D11000AD98D', 18, 'swtzbzzrsxx', '市委统战部（侨办、台办）组织人事信息', NULL, NULL, NULL, '', 3, '{}', 88),
(6235, 3142, 'DDA2CAFC2D04487048257D17002E525F', 76, 'fwzxjcs', '市行政服务中心中介服务管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6236, 3145, 'B26FFA3D05D6878648257D2300058549', 39, 'stjjbpgzz', '市统计局北片工作站', NULL, NULL, NULL, '', 3, '{}', 88),
(6237, 3146, '85385E607761B8AC48257D240025CE99', 8, 'swggb', '市委改革办', NULL, NULL, NULL, '', 3, '{}', 88),
(6238, 3147, 'FE57E89A42647BB448257D2B0003D55A', 150, 'xpzty', '新浦镇体育', NULL, NULL, NULL, '', 3, '{}', 88),
(6239, 3148, 'A5D5C6AC84AB815848257D2C0002F521', 148, 'xlzsab', '逍林镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6240, 3149, '700524270D495FD148257D31000413D1', 66, 'shbjjzs9', '市环保局杨腾飞', NULL, NULL, NULL, '', 3, '{}', 88),
(6241, 3150, '4566BC6FD27C022E48257D31000C711B', 59, 'ssljchglk', '市水利局城河管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6242, 3152, '86A87FE4D6CC4F6448257D3800283539', 54, 'sgtj11', '市国土资源局蔡凌云', NULL, NULL, NULL, '', 3, '{}', 88),
(6243, 3153, '35B82C679F3D07B448257D380004740D', 65, 'ssjjjcs', '市审计局监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(6244, 3154, '703F745CFD2BF68E48257D4300288D67', 17, 'swxcb7', '市委宣传部杜启君', NULL, NULL, NULL, '', 3, '{}', 88),
(6245, 3155, '4DD78F9815A9969548257D430028951E', 17, 'swxcb8', '市委宣传部高科泳', NULL, NULL, NULL, '', 3, '{}', 88),
(6246, 3156, '2482188969A90DB248257D4300289DBD', 17, 'swxcb9', '市委宣传部卢萌卿', NULL, NULL, NULL, '', 3, '{}', 88),
(6247, 3157, '1AFBE29E68263B0948256C2B0008827C', 8, 'wangqy', '市委办王清毅', NULL, NULL, NULL, '', 3, '{}', 88),
(6248, 3158, '8523BAC0E3ED88C648257D4E002F8E44', 184, 'sbwbsydw1', '市事业单位登记局', NULL, NULL, NULL, '', 3, '{}', 88),
(6249, 3159, 'C48B1DBAF0D6727F48257D4E0029B67F', 66, 'shbjjzs10', '市环保局郁建达', NULL, NULL, NULL, '', 3, '{}', 88),
(6250, 3161, 'F541F426CE1C8B7548257D5400054982', 172, 'scnzsk', '市城南改造建设指挥部招商科', NULL, NULL, NULL, '', 3, '{}', 88),
(6251, 3162, '18DE7C12C76F2AF748257D540005DB38', 180, 'sxct5', '市新潮塘改造建设指挥部施约维', NULL, NULL, NULL, '', 3, '{}', 88),
(6252, 3163, '46975EE0DED2865648257D560006130D', 154, 'cszfsj', '崇寿镇人大主席', NULL, NULL, NULL, '', 3, '{}', 88),
(6253, 3164, '679DC94D65217F4248257D570002D8F5', 151, 'qtzwhz', '桥头镇文化站', NULL, NULL, NULL, '', 3, '{}', 88),
(6254, 3165, '32AEF59DB9E90C9448257D57002A3215', 173, 'sxxcyczsj', '慈溪高新技术产业开发区管理委员会财政审计所', NULL, NULL, NULL, '', 3, '{}', 88),
(6255, 3166, '34DFFF4F7F6DFBC348257D57002A2BE0', 173, 'sxxcyjjfz', '慈溪高新技术产业开发区管理委员会经济发展科', NULL, NULL, NULL, '', 3, '{}', 88),
(6256, 3167, '1AA37EAED415E1ED48257D57002A389D', 173, 'sxxcyshsw', '慈溪高新技术产业开发区管理委员会社会事务服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6257, 3168, 'F223E0704AAC8A3448257D5C0031AB3E', 160, 'hsjdsab', '浒山街道食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6258, 3169, 'C156C5BDC7F4AA2248257D5E0007FA15', 154, 'csz10', '崇寿镇袁庆锋', NULL, NULL, NULL, '', 3, '{}', 88),
(6259, 3170, '2255820A9BBB92DD48257D5E0002C762', 47, 'smzjzfzx', '市民政局中福在线', NULL, NULL, NULL, '', 3, '{}', 88),
(6260, 3171, 'AA19F5C67961282648257D5F00039306', 203, 'ssmjt6', '市商贸集团有限公司陈枫', NULL, NULL, NULL, '', 3, '{}', 88),
(6261, 3172, '776DD6FBC98118BA48257D5F0003A0B2', 203, 'ssmjtaqsc', '市商贸集团有限公司企业管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(6262, 3173, 'E082BB6611A9DD9848257D5F0003A6B0', 203, 'ssmjtgcjs', '市商贸集团有限公司工程建设部', NULL, NULL, NULL, '', 3, '{}', 88),
(6263, 3174, 'EC45BB61B23A3B0D48257D5F0003AD59', 203, 'ssmjtzbyz', '市商贸集团有限公司资本运作部', NULL, NULL, NULL, '', 3, '{}', 88),
(6264, 3175, '29DFC33EB77D519148257D5F0003997B', 203, 'ssmjtzsyz', '市商贸集团有限公司招商中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6265, 3176, '7C497CE4BADA15DD48257D6B00062FA0', 162, 'zhjdspaq', '宗汉街道食品安全办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6266, 3177, '1714CD715DD7602548257D6D00333ED3', 151, 'qtzsab', '桥头镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6267, 3178, '445444F8526597F848257D6E0006F115', 82, 'cxbhq1', '慈溪滨海经济开发区邹柏涌', NULL, NULL, NULL, '', 3, '{}', 88),
(6268, 3180, '2018C676C387781348257D6E000705D5', 82, 'cxbhq3', '慈溪滨海经济开发区史立权', NULL, NULL, NULL, '', 3, '{}', 88),
(6269, 3181, 'AA28066A29CDCBB648257D6E000710DE', 82, 'cxbhq4', '慈溪滨海经济开发区童焕迪', NULL, NULL, NULL, '', 3, '{}', 88),
(6270, 3182, '7850981B1DDE4C9348257D6E00071A4B', 82, 'cxbhq5', '慈溪滨海经济开发区王萍飞', NULL, NULL, NULL, '', 3, '{}', 88),
(6271, 3183, '9CDC6EC6C944599748257D6E000722A6', 82, 'cxbhq6', '慈溪滨海经济开发区项海霞', NULL, NULL, NULL, '', 3, '{}', 88),
(6272, 3184, 'C334EC2F5371D15B48257D6E000729B9', 82, 'cxbhq7', '慈溪滨海经济开发区马钰铮', NULL, NULL, NULL, '', 3, '{}', 88),
(6273, 3185, '382EC82CD0AC998F48257D700026D640', 10, 'sfbhxr', '市府办胡雪荣', NULL, NULL, NULL, '', 3, '{}', 88),
(6274, 3186, '90868FE4BE9BAE3948257D700026DC2A', 145, 'zqzsab', '掌起镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6275, 3187, '6C2EA6AA3F277BBD48257D7100261DA4', 146, 'ghwzgc', '观海卫镇观城办事处', NULL, NULL, NULL, '', 3, '{}', 88),
(6276, 3188, '0E42D4CF0BE1674048257D7100262A5C', 146, 'ghwzmh', '观海卫镇鸣鹤办事处', NULL, NULL, NULL, '', 3, '{}', 88),
(6277, 3189, '328065816C0438DC48257D7100262442', 146, 'ghwzsq', '观海卫镇师桥办事处', NULL, NULL, NULL, '', 3, '{}', 88),
(6278, 3190, 'BF13AEE575EF037548257D71002A4EA0', 2, 'swych', '市委应春华', NULL, NULL, NULL, '', 3, '{}', 88),
(6279, 3191, 'F91761E73C21762A48257D72000389D5', 150, 'xpzsab', '新铺镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6280, 3192, 'C3D19223B2799A5B48257D7B00154F90', 209, 'sdcb', '市调处办', NULL, NULL, NULL, '', 3, '{}', 88),
(6281, 3193, '3708A45428E9856348257D7B00155712', 209, 'sdcb1', '市调处办王乃权', NULL, NULL, NULL, '', 3, '{}', 88),
(6282, 3194, '56EAFB3C522662DA48257D7B00155E0F', 209, 'sdcb2', '市调处办余国南', NULL, NULL, NULL, '', 3, '{}', 88),
(6283, 3195, '2DC9C7F516C70D3848257D7B001565A7', 209, 'sdcb3', '市调处办沈红杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6284, 3196, '94C9C9E8970B8B4648257D7B00156D06', 209, 'sdcb4', '市调处办陈飞达', NULL, NULL, NULL, '', 3, '{}', 88),
(6285, 3197, '7217C7C77F6788C348257D7B00059E17', 43, 'sjyjaqglk', '市教育局安全管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6286, 3198, '199329782F4751CD48257D7F0006751F', 146, 'ghwzwsjd', '慈溪市卫生监督所观海卫分所', NULL, NULL, NULL, '', 3, '{}', 88),
(6287, 3199, 'C981998B0DEC832148257D810003F9EF', 10, 'sfbckn', '市府办陈恺旎', NULL, NULL, NULL, '', 3, '{}', 88),
(6288, 3200, 'FC4F3B27ACE36D1448257D820031C698', 208, 'sscjgjyqx', '市市场监管局苑庆祥', NULL, NULL, NULL, '', 3, '{}', 88),
(6289, 3201, 'E2DCB6AEADF45ADB48257D8500064051', 8, 'swblc', '市委办李程', NULL, NULL, NULL, '', 3, '{}', 88),
(6290, 3202, 'FB1EEBC4DD27777248257D8C002FD086', 47, 'smzj8', '市民政局许凌燕', NULL, NULL, NULL, '', 3, '{}', 88),
(6291, 3203, 'A22998AFDD8B43B248257D8F00088F48', 53, 'srsjjcs', '市人力社保局监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(6292, 3204, '99CC6F59D872D70748257D970014565B', 146, 'ghwzsab', '观海卫镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6293, 3206, '3EF195EC0B22468648257D9C003004FC', 29, 'szghhxqy', '市和谐企业创建办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6294, 3208, 'B51C3D87871210EA48257DA300293A8E', 58, 'snyj1', '市农业局沈均达', NULL, NULL, NULL, '', 3, '{}', 88),
(6295, 3209, '9439DEC639CE1D6C48257DA40020B922', 8, 'swbgsy', '市委办高松岳', NULL, NULL, NULL, '', 3, '{}', 88),
(6296, 3210, 'B62079369CA9890048257DA8002AC646', 65, 'ssjjjzs9', '市审计局胡蓉', NULL, NULL, NULL, '', 3, '{}', 88),
(6297, 3212, 'B07A22D92DCD66FB48257DA9002C6031', 12, 'sjcy6', '市检察院赵平志', NULL, NULL, NULL, '', 3, '{}', 88),
(6298, 3213, '0EEC124CEE770F9748257DAA000F33FD', 15, 'sjwjjs2', '市纪委第二纪检室', NULL, NULL, NULL, '', 3, '{}', 88),
(6299, 3214, '7414457732ECDD1348257DAA000F3A30', 15, 'sjwjjs3', '市纪委第三纪检室（执法）', NULL, NULL, NULL, '', 3, '{}', 88),
(6300, 3215, '91DC4EDD86450EA348257DAC0008B0E2', 51, 'scsjjz7', '市财政地税局孙明华', NULL, NULL, NULL, '', 3, '{}', 88),
(6301, 3216, '9D18501F091624A548257DAC00066A46', 60, 'sswj5', '市商务局赵海军', NULL, NULL, NULL, '', 3, '{}', 88),
(6302, 3217, '4C893EAAD89FEE6C48257DAF0007C258', 75, 'scgj6', '市综合行政执法局（市城管局）许文杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6303, 3218, '43E689FBB45A9ABE48257DAF002AB205', 3, 'srdyxz', '市人大严新章', NULL, NULL, NULL, '', 3, '{}', 88),
(6304, 3220, '390A1F6F2CD7BCFE48257DB10026DBFC', 47, 'smzjxzsp', '市民政局行政审批窗口', NULL, NULL, NULL, '', 3, '{}', 88),
(6305, 3221, '41EA4DE2E804CF7448257DB1002707D1', 162, 'zhjdjgz', '宗汉街道交管站', NULL, NULL, NULL, '', 3, '{}', 88),
(6306, 3222, 'B664E2C454CAA0BA48257DB100270E20', 162, 'zhjdxfz', '宗汉街道消防站', NULL, NULL, NULL, '', 3, '{}', 88),
(6307, 3224, '5B6929AC751BA30248257DB7000CBB29', 54, 'stgj12', '市国土资源局尚玉辉', NULL, NULL, NULL, '', 3, '{}', 88),
(6308, 3225, 'E07521A59B43036048257DB800084F49', 44, 'skjj8', '市科技局王能锋', NULL, NULL, NULL, '', 3, '{}', 88),
(6309, 3226, '5AB53A104FBF585748257DBD000D2BFF', 210, 'shycszzb', '市合用场所整治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6310, 3227, '0216E6CF857307DC48257DBE002B7029', 211, 'gsyhhzwxq', '工商银行杭州湾新区支行', NULL, NULL, NULL, '', 3, '{}', 88),
(6311, 3228, '0BB70DE4D5EEC92948257DC4002D2A57', 153, 'hhzsab', '横河镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6312, 3229, '9A30D5A86561F74B48257DC4002D1F80', 183, 'szsj6', '市招商局沈树群', NULL, NULL, NULL, '', 3, '{}', 88),
(6313, 3231, 'EC9D2068AA1D389F48257DCD0007054D', 149, 'sszhycszzb', '胜山镇合用场所整治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6314, 3232, '61E61E244C93046048257DCE0024F14A', 66, 'shbjlhzf', '环境保护联合执法领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6315, 3233, '56B365AFD232C71E48257DCE0024E801', 66, 'shbjsts', '环评和“三同时”专项整治领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6316, 3234, '471E20FF811C83EC48257DCE002F4438', 62, 'stycpgzz', '慈溪市体育彩票工作站', NULL, NULL, NULL, '', 3, '{}', 88),
(6317, 3235, 'E9114EB60BF506EE48257DCF002A1013', 151, 'qtzrdfzx', '桥头镇人大副主席', NULL, NULL, NULL, '', 3, '{}', 88),
(6318, 3236, '19D17349E5CA6E6248257DCF002A09B4', 151, 'qtzrdzx', '桥头镇人大主席', NULL, NULL, NULL, '', 3, '{}', 88),
(6319, 3237, '81AAC8FFDC301B5748257DD20029B6E4', 154, 'cszhycszzb', '崇寿镇合用场所整治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6320, 3238, 'CA01437F906FAC3148257DD500281DB0', 163, 'kdjdpcs', '坎墩街道派出所', NULL, NULL, NULL, '', 3, '{}', 88),
(6321, 3239, 'D26BD9230309ADDE48257DD60031CF28', 160, 'hsjdajs', '浒山街道安监所', NULL, NULL, NULL, '', 3, '{}', 88),
(6322, 3240, '25534512FF3B215448257DDB00075A9E', 55, 'swjzzpgb', '市危旧住宅棚改办', NULL, NULL, NULL, '', 3, '{}', 88),
(6323, 3241, 'A5DF099DEA8F9DD148257DE00023447A', 17, 'swxcb3', '市委宣传部厉振跃', NULL, NULL, NULL, '', 3, '{}', 88),
(6324, 3242, '00E6C49BE2742D1648257DE000234B12', 17, 'swxcb4', '市委宣传部黄群力', NULL, NULL, NULL, '', 3, '{}', 88),
(6325, 3243, '9579AD8E4854641248257DE00029B431', 16, 'swzzb13', '市委组织部龚敏捷', NULL, NULL, NULL, '', 3, '{}', 88),
(6326, 3244, '27ED4922C794D83948257DE00029BB0A', 16, 'swzzb14', '市委组织部孙裕丰', NULL, NULL, NULL, '', 3, '{}', 88),
(6327, 3245, 'D23DF3B3EF376F7D48257DE00029C1C9', 16, 'swzzb15', '市委组织部戚欢钟', NULL, NULL, NULL, '', 3, '{}', 88),
(6328, 3246, '4C0B34E809D7EA6448257DE00029C8A2', 16, 'swzzb16', '市委组织部陈淑旭', NULL, NULL, NULL, '', 3, '{}', 88),
(6329, 3247, '743D7613D137015948257DE00029CF73', 16, 'swzzb17', '市委组织部蔡振宇', NULL, NULL, NULL, '', 3, '{}', 88),
(6330, 3248, '3BF5119A4E74228748257DE800309546', 16, 'swzzb18', '市委组织部沈建国', NULL, NULL, NULL, '', 3, '{}', 88),
(6331, 3249, '1C0A2C301C13F96548257DF700068AF7', 154, 'cszcjzz', '崇寿镇城建副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(6332, 3250, '64899EAA91F8011F48257DF80028ADC4', 154, 'cszgyzz', '崇寿镇工业副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(6333, 3251, '820D0640B546ABD748257DF90028C4F2', 27, 'cxrbs5', '慈溪日报社徐立荣', NULL, NULL, NULL, '', 3, '{}', 88),
(6334, 3252, '3F5E6D9DA0FAB06348257DF90028CB8D', 27, 'cxrbs6', '慈溪日报社蒋余辉', NULL, NULL, NULL, '', 3, '{}', 88),
(6335, 3253, 'E3147D24BC78E0EC48257DF9002901C9', 194, 'sswjtyxgs13', '市水务集团有限公司黄雄', NULL, NULL, NULL, '', 3, '{}', 88),
(6336, 3254, 'C4DC4C91A776778648257DFC000687B5', 151, 'qtzjwsj', '桥头镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6337, 3255, 'A85462B78969B8B448257DFF0005C773', 8, 'swbchl', '市委办岑胡磊', NULL, NULL, NULL, '', 3, '{}', 88),
(6338, 3257, '2ECEA69D7BC1493148257E04000D78BB', 212, 'hsb', '海事办', NULL, NULL, NULL, '', 3, '{}', 88),
(6339, 3258, 'F9595A96AC171A1248257E04000CC864', 10, 'sfbyl', '市府办俞玲', NULL, NULL, NULL, '', 3, '{}', 88),
(6340, 3259, 'EEDDB2A9A5735B3B48257E03002A87BD', 21, 'swzysggxtk', '市委政研室改革协调科', NULL, NULL, NULL, '', 3, '{}', 88),
(6341, 3260, '6016D3F37EF29EC048257E060007D6C1', 46, 'sldrkj1', '市流动人口局罗炯', NULL, NULL, NULL, '', 3, '{}', 88),
(6342, 3261, '9C54AD7D2DB4F91348257E070029612A', 11, 'tall', '提案浏览', NULL, NULL, NULL, '', 3, '{}', 88),
(6343, 3262, 'CD6B668BB5C456CB48257E1C00093059', 9, 'srdb32', '市人大办胡方译', NULL, NULL, NULL, '', 3, '{}', 88),
(6344, 3263, 'C910A784087FEBA248257E1C0009F26F', 39, 'stjjlxc', '市统计局楼雪聪', NULL, NULL, NULL, '', 3, '{}', 88),
(6345, 3264, 'A1FF3ED0F3636ADD48257E27002B3ED7', 188, 'sjsjt4', '市建设集团高峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6346, 3265, '4FACF092D54EC43F48257E340029431E', 152, 'kyzgll', '匡堰镇关工委老龄委老体协', NULL, NULL, NULL, '', 3, '{}', 88),
(6347, 3266, '35A450D167ED224048257E3400158CF0', 152, 'kyzjwsj', '匡堰镇纪委', NULL, NULL, NULL, '', 3, '{}', 88),
(6348, 3267, '9DDAAE3CB4F1EB5D48257E3500050A76', 147, 'fhzjwsj', '附海镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6349, 3268, 'BEC91B230377B0B948257E3500055DC3', 147, 'fhzzuzb', '附海镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(6350, 3269, '1FF4AA7A6FA7AF8D48257E34002CBCC4', 151, 'qtzgyzz', '桥头镇工业镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(6351, 3270, '2D930A76C57B16DD48257E3F00345CF2', 83, 'whswqzsk', '市环杭州湾创新中心招商合作科', NULL, NULL, NULL, '', 3, '{}', 88),
(6352, 3271, '9167528520D0575948257E4B0007B2B0', 60, 'sswjdzswk', '市商务局电子商务科', NULL, NULL, NULL, '', 3, '{}', 88),
(6353, 3272, '7C84F774993BE24B48257E4C0004BA0A', 55, 'sfwaqjd', '市房屋安全鉴定办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6354, 3273, '43488D4F5C9B7A5E48257E53000A4673', 154, 'cszmsb', '崇寿镇秘书办', NULL, NULL, NULL, '', 3, '{}', 88),
(6355, 3274, '73D796314E1E8ABA48257E53000A19CC', 62, 'swgj7', '市文广局市申遗办', NULL, NULL, NULL, '', 3, '{}', 88),
(6356, 3275, 'F7C80BBBA1E865FF48257E5700286CF7', 160, 'hsjdjgwsj', '浒山街道纪工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6357, 3277, '77943B6DABE46DC348257E660027DE4B', 28, 'sdajbzxs', '市档案局编制修史办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6358, 3278, '9F1222E7BEB0E38D48257E740005C075', 152, 'kyzlqy', '匡堰镇陆启云', NULL, NULL, NULL, '', 3, '{}', 88),
(6359, 3279, 'DF17CA41F2DF7D1C48257E7A00063A1E', 32, 'sgsl5', '市工商联楼元芳', NULL, NULL, NULL, '', 3, '{}', 88),
(6360, 3280, '8DBF87D04CEF946D48257E7A00052742', 62, 'swgj8', '市文广局应月定', NULL, NULL, NULL, '', 3, '{}', 88),
(6361, 3281, 'EFE34C676E754EC548257E7A000574D1', 62, 'swgj9', '市文广局胡东杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6362, 3282, '2CDFC601C073215648257E7A00292CC7', 83, 'whswq6', '市环杭州湾创新中心钱镛', NULL, NULL, NULL, '', 3, '{}', 88),
(6363, 3283, '39D91C803722957348257E7B002FA857', 147, 'fhzzzy', '附海镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6364, 3284, '9A87B13EFD12589348257E7B002E9620', 9, 'srdb33', '市人大办李尧', NULL, NULL, NULL, '', 3, '{}', 88),
(6365, 3285, '3AF5EEADD98E1DB048257E7B002FCFE6', 29, 'szghzxs7', '市总工会朱猛波', NULL, NULL, NULL, '', 3, '{}', 88),
(6366, 3286, '41FF462FABB972BB48257E7B002C6550', 11, 'szxbslr', '市政协委员工委沈林绒', NULL, NULL, NULL, '', 3, '{}', 88),
(6367, 3287, '45AA774A4B76403748257E7D0004CE00', 154, 'cszzzy', '崇寿镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6368, 3288, '516F49D987D9416C48257E7D002BC7C1', 213, 'swsngzzb', '市污水纳管和超标排放整治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6369, 3289, 'B4F0EB4C2855B4AD48257E7D002B5076', 148, 'xlzzzy', '逍林镇组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6370, 3290, '3F4DD6A6515889DE48257E7E0006DF97', 144, 'lsz15', '龙山镇政法副书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6371, 3291, '35A0CA944A7F8D8A48257E7E0006E590', 144, 'lsz16', '龙山镇胡啸峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6372, 3292, '34ABEBD8BB8A737C48257E7E0006EB5D', 144, 'lsz17', '龙山镇马兵', NULL, NULL, NULL, '', 3, '{}', 88),
(6373, 3293, 'E77BF363F678462948257E7E0006F30D', 144, 'lsz18', '龙山镇组织员', NULL, NULL, NULL, '', 3, '{}', 88);
INSERT INTO `staff_tbl` (`staff_id`, `out_id`, `staff_unid`, `unit`, `staff_name`, `full_name`, `staff_phone`, `staff_email`, `staff_password`, `steps`, `category`, `user_admin`, `reorder`) VALUES
(6374, 3294, 'E825C99E8716FB9948257E82002A2E48', 160, 'hsjdzzy', '浒山街道组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6375, 3295, 'A8072E9FF23CEB6648257E820028869E', 60, 'sswj6', '市商务局胡亿文', NULL, NULL, NULL, '', 3, '{}', 88),
(6376, 3296, 'A6DADDAECC25FE7948257E8200288CE9', 60, 'sswjxdfw', '市现代服务业办', NULL, NULL, NULL, '', 3, '{}', 88),
(6377, 3297, 'F4F317EAC41349F648257E81003104F4', 62, 'swgjbgs2', '市文广局办公室组织人事', NULL, NULL, NULL, '', 3, '{}', 88),
(6378, 3298, '07C2CCA1E34AD75B48257E8100310B56', 62, 'swgjbgs3', '市文广局办公室信息宣传', NULL, NULL, NULL, '', 3, '{}', 88),
(6379, 3299, '38BFA7BE26313B4848257E820004F489', 4, 'szfwjw', '市政府吴佳伟', NULL, NULL, NULL, '', 3, '{}', 88),
(6380, 3300, 'AAFAFC3D7A6CA56D48257E8400068EBA', 208, 'sscjgjbyp', '市市场监管局卞益平', NULL, NULL, NULL, '', 3, '{}', 88),
(6381, 3301, 'F6CB2B5FC5055A7148257E890026F115', 159, 'gtjd19', '古塘街道组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6382, 3302, '4C6C21C7040D12A948257E8A0007C5FF', 63, 'swsjhsy5', '市卫生和计划生育局沈益军', NULL, NULL, NULL, '', 3, '{}', 88),
(6383, 3303, '74D0396956C439C548257E910025C2E1', 159, 'gtjdsab', '古塘街道食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6384, 3304, '513B3801EF5764F048257E9100264DE3', 163, 'kdjdjgwsj', '坎墩街道纪工委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6385, 3305, '7CD66B34557E5E6148257E930005385C', 151, 'qtzxtwy', '桥头镇宣统委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6386, 3306, '2C1487B249A3088B48257E960008CD59', 156, 'chzjw', '长河镇纪委', NULL, NULL, NULL, '', 3, '{}', 88),
(6387, 3307, 'D6F75A44211EB51848257E960008D3A1', 156, 'chzsab', '长河镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6388, 3308, '038FBDEA5FE874AE48257E960008DA3C', 156, 'chzzzy', '长河镇组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6389, 3309, '19CD48F4CE01DE0F48257E97002D5298', 152, 'kyzsab', '匡堰镇食安办', NULL, NULL, NULL, '', 3, '{}', 88),
(6390, 3310, 'F4067552C3C5D33848257E9D0013BF8F', 26, 'swdx5', '市委党校张冰', NULL, NULL, NULL, '', 3, '{}', 88),
(6391, 3312, 'C7FB9C655548255848257EA4001305C9', 208, 'sscjgjcdb', '市市场监管局陈迪波', NULL, NULL, NULL, '', 3, '{}', 88),
(6392, 3313, 'A786F2BEB7FAFF9248257EA40012EA7F', 208, 'sscjgjgll', '市市场监管局高利伦', NULL, NULL, NULL, '', 3, '{}', 88),
(6393, 3314, '9C90F72F57A6CE2348257EA4001312C2', 208, 'sscjgjhjn', '市市场监管局黄江南', NULL, NULL, NULL, '', 3, '{}', 88),
(6394, 3315, '0DAFEF71AFF073D248257EA40012FF51', 208, 'sscjgjsjz', '市市场监管局邵聚樟', NULL, NULL, NULL, '', 3, '{}', 88),
(6395, 3316, '8A353C2E7BFA5F9E48257EA400132A4E', 208, 'sscjgjtzsbk', '市市场监管局特种设备科', NULL, NULL, NULL, '', 3, '{}', 88),
(6396, 3317, '41E0E89DB0C444ED48257EA400130C7B', 208, 'sscjgjxxs', '市市场监管局许雪松', NULL, NULL, NULL, '', 3, '{}', 88),
(6397, 3318, '0AF10E0050B0E34C48257EA400131D9A', 208, 'sscjgjzlbzylk', '市市场监管局质量标准计量科', NULL, NULL, NULL, '', 3, '{}', 88),
(6398, 3319, 'BC604E7A4094818248257EA40013241C', 208, 'sscjgjzljgk', '市市场监管局质量监管科', NULL, NULL, NULL, '', 3, '{}', 88),
(6399, 3320, '55E200C3302AB41D48257EA6000804A5', 65, 'ssjjnsjdk', '市审计局内审指导监督科', NULL, NULL, NULL, '', 3, '{}', 88),
(6400, 3321, 'B645D1E572B825F848257EA70005054E', 208, 'sscjgjzjzx', '市市场监管局质检中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6401, 3322, 'FF315B88D4093BF048257EA80030879C', 8, 'swbfjb', '市委办范建波', NULL, NULL, NULL, '', 3, '{}', 88),
(6402, 3323, '582590FA6311162248257D93002E3199', 82, 'cxbhq8', '慈溪滨海经济开发区毛孟军', NULL, NULL, NULL, '', 3, '{}', 88),
(6403, 3324, '3C6CD5F131B9F83148257EAB0002B294', 65, 'ssjjjzs10', '市审计局蔡列峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6404, 3325, 'B71DB53DD9D1584648257EAC002BD090', 159, 'gtjdzzwy', '古塘街道组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6405, 3326, '0321D09C56E93D6C48257EAC002CE338', 53, 'srlsbj1', '市人力社保局徐国强', NULL, NULL, NULL, '', 3, '{}', 88),
(6406, 3327, 'C6FF6C90579AC9EE48257EAC002E71C1', 202, 'sshjzzb12', '市水环境综治办徐露', NULL, NULL, NULL, '', 3, '{}', 88),
(6407, 3328, '724548A45B7ADACE48257EAD000ACD56', 4, 'szfdwb', '市政府董维波', NULL, NULL, NULL, '', 3, '{}', 88),
(6408, 3329, '27AB95B10AF00E3948257EAE00336F5C', 12, 'sjcy7', '市检察院陈云祥', NULL, NULL, NULL, '', 3, '{}', 88),
(6409, 3330, '6D5CF35F05F1365C48257EB200046703', 161, 'bsljd20', '白沙路街道组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6410, 3331, 'CAC584012E696C6448257EB300047353', 66, 'shbjjzs11', '市环保局陆毅', NULL, NULL, NULL, '', 3, '{}', 88),
(6411, 3332, 'B107AAA82C3D05A048257EB300047B25', 66, 'shbjjzs12', '市环保局桑丽群', NULL, NULL, NULL, '', 3, '{}', 88),
(6412, 3333, '3DAADE7F3DCE014648257EB30003B946', 202, 'sshjzzb13', '市水环境综治办俞焕银', NULL, NULL, NULL, '', 3, '{}', 88),
(6413, 3334, 'F2903B1C7F6D6AEB48257EB400055D31', 152, 'kyzzzy', '匡堰镇组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6414, 3335, '8C3F7944DE95D09948257EB40004E5DD', 195, 'sxchzhb4', '市新城河区块改造建设指挥部余立伟', NULL, NULL, NULL, '', 3, '{}', 88),
(6415, 3336, 'CE467C72A9071ACA48257EB80006C222', 204, 'sfwzgb4', '市房屋征管办沈建明', NULL, NULL, NULL, '', 3, '{}', 88),
(6416, 3337, 'B95315C12E13825148257EB80006C83F', 208, 'szlqsb', '市质量强市办', NULL, NULL, NULL, '', 3, '{}', 88),
(6417, 3338, 'F58A7CC00B598BD848257EB90004BB24', 153, 'hhzhjjczd', '横河镇环境监察中队', NULL, NULL, NULL, '', 3, '{}', 88),
(6418, 3339, '1DE844CB045C330248257EB90005C3A8', 194, 'sswjtyxgs14', '市自来水有限公司童旭江', NULL, NULL, NULL, '', 3, '{}', 88),
(6419, 3340, '98537FEE7E63D4CE48257EB90006386A', 194, 'sswjtyxgs15', '市水务集团有限公司罗明岳', NULL, NULL, NULL, '', 3, '{}', 88),
(6420, 3341, 'B28F95004834B83E48257EB900063EEA', 194, 'sswjtyxgs16', '市水务工程有限公司陈邦红', NULL, NULL, NULL, '', 3, '{}', 88),
(6421, 3342, '0431528E6B2625D748257EB90004C194', 148, 'xlzpcs', '逍林镇派出所', NULL, NULL, NULL, '', 3, '{}', 88),
(6422, 3343, '60637608220C84E548257EBA00062B3E', 151, 'qtzzzb1', '桥头镇综治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6423, 3344, '85B4CEC6BBA5E1D548257EBA00277B2E', 57, 'sjtj10', '市交通运输局', NULL, NULL, NULL, '', 3, '{}', 88),
(6424, 3345, 'F4DB825257A51ACB48257EBA0027CC28', 57, 'sjtjxdz', '市交通运输局徐德忠', NULL, NULL, NULL, '', 3, '{}', 88),
(6425, 3346, 'F9E5B1C747B7EE8148257EBB0004B707', 43, 'sjyj12', '市教育局罗科技', NULL, NULL, NULL, '', 3, '{}', 88),
(6426, 3347, 'FD5230E4728FC0B548257EBD0003FCE1', 208, 'sxwb', '市小微办', NULL, NULL, NULL, '', 3, '{}', 88),
(6427, 3348, '2DD35078ED30316E48257EC100273ED4', 146, 'ghwzdjb', '观海卫镇党建办', NULL, NULL, NULL, '', 3, '{}', 88),
(6428, 3349, '952B7486B7214D1548257EC200057A89', 151, 'qtzzzy', '桥头镇组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6429, 3350, '16CFD162DF001AD548257EC200283BDA', 18, 'stzfwzx', '市统战服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6430, 3351, '43F775EC21C7EEB048257EC4000582A1', 149, 'sszjwsj', '胜山镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6431, 3352, '716CC97230B2FB8448257EC400058929', 149, 'sszxzjcs', '胜山镇行政监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(6432, 3353, 'A37B429095B69DED48257EC400057C71', 149, 'sszzzy', '胜山镇组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6433, 3354, '3A70AC8CFA8E735B48257EC40026E560', 214, 'hfyh', '恒丰银行宁波慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(6434, 3355, 'A6D720E96BD192B848257EC70030FB1D', 160, 'hsjdjdb', '浒山街道禁毒办', NULL, NULL, NULL, '', 3, '{}', 88),
(6435, 3356, 'AC1944F8129DA5B148257ED900208B37', 154, 'cszzzy2', '崇寿镇组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6436, 3357, '57CEF6D9D2072DE748257EDA000FC220', 150, 'xpzzzy', '新浦镇组织员', NULL, NULL, NULL, '', 3, '{}', 88),
(6437, 3358, 'FE0A80740F1288B348257EDC0027A07C', 26, 'swdxkys', '市委党校科研室', NULL, NULL, NULL, '', 3, '{}', 88),
(6438, 3359, '2827F8116B85EE2048257EE3002418F8', 144, 'lszjwsj', '龙山镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6439, 3360, '1C457AC060B8599448257EE3002747D8', 63, 'swsjjhsy', '市卫生和计划生育局流动人口计划生育服务管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6440, 3361, '8787ADA4942517D248257EE3002740EB', 63, 'swsjjtfzk', '市卫生和计划生育局计生指导与家庭发展科', NULL, NULL, NULL, '', 3, '{}', 88),
(6441, 3362, 'C8277AE80C78BC7948257EE300274E28', 63, 'swsjwtgs', '市卫生和计划生育局卫投公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6442, 3363, '6477DD46B3A91C3748257EE30027398A', 63, 'swsjzcfgk', '市卫生和计划生育局政策法规科', NULL, NULL, NULL, '', 3, '{}', 88),
(6443, 3364, '7720577380AEFA1F48257EE60003AA2F', 48, 'scsh6', '市慈善总会朱永根', NULL, NULL, NULL, '', 3, '{}', 88),
(6444, 3366, '9015B7C3C999EB1648257EEA0026E4A9', 13, 'sfy20', '市法院顾列平', NULL, NULL, NULL, '', 3, '{}', 88),
(6445, 3367, 'AA9A720366A7206B48257EED00037EBC', 15, 'swxcb', '市委巡查办', NULL, NULL, NULL, '', 3, '{}', 88),
(6446, 3368, '1C58DC8DF65DAE0848257EF400062546', 0, 'dwzsfzbgs', '党外知识分子办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6447, 3369, 'F85BFC271327C1E548257EF8002937D6', 2, 'swsqs', '市委沈其生', NULL, NULL, NULL, '', 3, '{}', 88),
(6448, 3370, '6E6833AA2CB750AF48257F07002ACB70', 4, 'szfmhy', '市政府马焕勇', NULL, NULL, NULL, '', 3, '{}', 88),
(6449, 3372, '5DDF2FD7DCA9A3C748257F140012F1BE', 10, 'sfbdxl', '市府办丁香林', NULL, NULL, NULL, '', 3, '{}', 88),
(6450, 3373, 'F875A96A778E014C48257F140005DDCD', 10, 'sfbhzy', '市府办胡志远', NULL, NULL, NULL, '', 3, '{}', 88),
(6451, 3374, '85389281E176C1F548257F160004DE09', 17, 'swxcb2', '市委宣传部房央群', NULL, NULL, NULL, '', 3, '{}', 88),
(6452, 3376, '3342C9D67D9A94D048257F1700041259', 10, 'sfbgjj', '市府办高建军', NULL, NULL, NULL, '', 3, '{}', 88),
(6453, 3377, 'C68672CB6EB5481D48257F1700067CBF', 50, 'ssfj6', '市司法局陈利江', NULL, NULL, NULL, '', 3, '{}', 88),
(6454, 3379, '1D39BC8B0BFE674E48257F1B000616EA', 92, 'snhlbgs', '市农合联执委会（市供销社)办公室2', NULL, NULL, NULL, '', 3, '{}', 88),
(6455, 3380, '5830D79170E5ABA348257F1B00096502', 39, 'stjj3', '市统计局王建波', NULL, NULL, NULL, '', 3, '{}', 88),
(6456, 3381, '87DA2AC8E0F43A5148257F1B000F3F66', 158, 'zxzxzfwzx', '周巷镇行政服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6457, 3382, '1113EC496960A3BD48257F1C0004FB8C', 161, 'bsljd21', '白沙路街道调研员4', NULL, NULL, NULL, '', 3, '{}', 88),
(6458, 3383, '386FD57FBC5A720D48257F1B002B572E', 13, 'sfy21', '市法院童夏珍', NULL, NULL, NULL, '', 3, '{}', 88),
(6459, 3384, '95D953C7B498D23548257F1F00057E4C', 54, 'sgtj2', '市国土资源局陈剑波', NULL, NULL, NULL, '', 3, '{}', 88),
(6460, 3385, '02579A2204D3B88148257F1F00121E8B', 11, 'szxdmq', '经济科技城资环委段明权', NULL, NULL, NULL, '', 3, '{}', 88),
(6461, 3386, 'D91A9A969EC7A88148257F220006D2FB', 82, 'cxbhqxczhb1', '慈溪滨海经济开发区新城指挥部总指挥', NULL, NULL, NULL, '', 3, '{}', 88),
(6462, 3387, 'DE924434681BB21148257F220006D94D', 82, 'cxbhqxczhb2', '慈溪滨海经济开发区新城指挥部副总指挥', NULL, NULL, NULL, '', 3, '{}', 88),
(6463, 3388, '61F14682F483506148257F220005902B', 145, 'zqzjwsj', '掌起镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6464, 3390, '306D08CDF0ACE99848257F25000CE612', 38, 'dljjz', '第六纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6465, 3391, 'AF855EF6535F961C48257F2B000E8DAF', 10, 'sfbmxf', '市府办马旭峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6466, 3392, '901A880BFEC26E5A48257F2B000E9547', 10, 'sfbwxd', '市府办王旭东', NULL, NULL, NULL, '', 3, '{}', 88),
(6467, 3393, 'B61E4F97903FA7FA48257F2C00274E55', 18, 'dwjjz1', '第五纪检组吴晓云', NULL, NULL, NULL, '', 3, '{}', 88),
(6468, 3394, '8D628E580819067148257F2C002754FC', 18, 'dwjjz2', '第五纪检组许雪松', NULL, NULL, NULL, '', 3, '{}', 88),
(6469, 3395, '0EC5EFAFD29388A748257F300004D3D6', 151, 'qtzcjzz', '桥头镇城建镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(6470, 3396, 'EC8C51940E29F1DD48257F300004C67C', 151, 'qtznyzz', '桥头镇农业镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(6471, 3397, '86BD3325740AC5DC48257F300004CD32', 151, 'qtzwwzz', '桥头镇文卫镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(6472, 3398, 'DACB52A75F628FBF48257F300004DAB2', 151, 'qtzwzbz', '桥头镇武装部长', NULL, NULL, NULL, '', 3, '{}', 88),
(6473, 3399, 'D24F56252BB7E94E48257F300004E10B', 151, 'qtzzxllwzr', '桥头镇政协联络委主任', NULL, NULL, NULL, '', 3, '{}', 88),
(6474, 3400, 'CC1F7C74ACE95F4848257F310017DDFD', 8, 'dyjjz1', '第一纪检组徐雪尔', NULL, NULL, NULL, '', 3, '{}', 88),
(6475, 3401, '0BB89B46DB970D0048257F310017E488', 8, 'dyjjz2', '第一纪检组邵杰飞', NULL, NULL, NULL, '', 3, '{}', 88),
(6476, 3403, '2CD29E0BBBBD27F148257F320026000C', 16, 'dsjjz1', '第三纪检组陈英豪', NULL, NULL, NULL, '', 3, '{}', 88),
(6477, 3404, 'E5DF7536A6B525F748257F320026068A', 16, 'dsjjz2', '第三纪检组陈旭君', NULL, NULL, NULL, '', 3, '{}', 88),
(6478, 3405, 'CDC9207F4FC90E5C48257F320003C5F1', 158, 'zxzjjzd', '周巷镇交警中队', NULL, NULL, NULL, '', 3, '{}', 88),
(6479, 3406, 'DFCD712AC909D82048257F330004EEFB', 17, 'dsijjz', '第四纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6480, 3407, '9624F80A7AAD6E1948257F330004F6D4', 17, 'dsijjz1', '第四纪检组张勤', NULL, NULL, NULL, '', 3, '{}', 88),
(6481, 3408, 'E9A3406C929B74D648257F330004FDEA', 17, 'dsijjz2', '第四纪检组叶建明', NULL, NULL, NULL, '', 3, '{}', 88),
(6482, 3409, 'EDD1B72E9D7390C748257F38000478ED', 55, 'dqjjz', '市纪委派驻第七纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6483, 3410, 'BB36F2A9C3AFC2A048257F3800048088', 55, 'dqjjz1', '市第七纪检组陈海军', NULL, NULL, NULL, '', 3, '{}', 88),
(6484, 3411, '3ADB4FC0ADA1775348257F39000331A4', 58, 'snyjjjzz', '第八纪检组组长', NULL, NULL, NULL, '', 3, '{}', 88),
(6485, 3412, '95D055AFBE709F1948257F4500030D8E', 10, 'sfbhjp', '市府办华家平', NULL, NULL, NULL, '', 3, '{}', 88),
(6486, 3413, 'E1D71090909AF77548257F45002A265C', 13, 'sfyspswbzzx', '市法院审判事务保障中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6487, 3414, 'BA396F056BFA539948257F4500084F54', 3, 'srdzby', '市人大邹柏涌', NULL, NULL, NULL, '', 3, '{}', 88),
(6488, 3415, 'B59F95D18D145F4648257F450027B82F', 202, 'sshjzzb14', '市水环境综治办许莹莹', NULL, NULL, NULL, '', 3, '{}', 88),
(6489, 3416, 'E5B3ED299F0B346948257F450027BF08', 202, 'sshjzzb15', '市水环境综治办高扬', NULL, NULL, NULL, '', 3, '{}', 88),
(6490, 3417, 'CBCAD398B2A8D00848257F49000F3E2A', 48, 'scsh7', '市慈善总会叶黎明', NULL, NULL, NULL, '', 3, '{}', 88),
(6491, 3418, '1F887E0AADF8A3DE48257F4C0009DCD9', 51, 'scsj8', '市财政地税局毛建辉', NULL, NULL, NULL, '', 3, '{}', 88),
(6492, 3419, '79B367D29571396048257F4C0009E322', 57, 'sjtjskq', '市交通运输局沈科群', NULL, NULL, NULL, '', 3, '{}', 88),
(6493, 3420, 'CA3F1D1E58709DDB48257F4E0004F877', 46, 'sldrkj4', '市流动人口局韩曙辉', NULL, NULL, NULL, '', 3, '{}', 88),
(6494, 3421, 'AB213FCEC5522ECE48257F330004786F', 16, 'dsjjz', '第三纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6495, 3422, 'E037F1DFD028F4E848257F59002BF7EF', 18, 'dwjjz', '第五纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6496, 3423, '41CE44EBCE41F6A548257F5B002EFDEB', 42, 'sajjzak', '市安监局职安科', NULL, NULL, NULL, '', 3, '{}', 88),
(6497, 3424, '4DE88DDD822500C248257F5E0004AC80', 10, 'dejjz', '第二纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6498, 3425, '62942BFAF08C62A248257F5E0004B3F5', 10, 'dejjzwln', '第二纪检组魏莉娜', NULL, NULL, NULL, '', 3, '{}', 88),
(6499, 3426, '8AFD899F8C08120348257F5E0008CBE9', 104, 'scwbdczdz', '市创卫办督查指导组', NULL, NULL, NULL, '', 3, '{}', 88),
(6500, 3427, '7DF4B24B8AF082BD48257F5E0008D26C', 104, 'scwbwzzlz', '市创卫办文字资料组', NULL, NULL, NULL, '', 3, '{}', 88),
(6501, 3428, '50CFBE8E752C475B48257F5E0008C55E', 104, 'scwbzhxtz', '市创卫办综合协调组', NULL, NULL, NULL, '', 3, '{}', 88),
(6502, 3429, '7AADF0FC9BACB16248257F5E000709EA', 50, 'ssfjzgk', '市司法局政工科', NULL, NULL, NULL, '', 3, '{}', 88),
(6503, 3430, '8143D40266EB2BAB48257F61002FF34C', 17, 'swxcb10', '市委宣传部赵科', NULL, NULL, NULL, '', 3, '{}', 88),
(6504, 3431, 'B67474406E002CBE48257F640006112F', 15, 'sjwzfjc', '作风检查报送专用', NULL, NULL, NULL, '', 3, '{}', 88),
(6505, 3433, '694BC5E32C14039148257F6C002AAD22', 68, 'sgsj5', '市国税局施焰冰', NULL, NULL, NULL, '', 3, '{}', 88),
(6506, 3434, '1DB3ABA2ED0DD0DA48257F6F000870E4', 161, 'bsbmfwzx', '白沙便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6507, 3435, '135C1DA2FA9C841248257F6F00087E69', 156, 'chbmfwzx', '长河便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6508, 3436, '53CB8C2C3A996EA748257F6F000841BF', 154, 'csbmfwzx', '崇寿便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6509, 3437, '3DDB5F8B00668CD248257F6F0008571E', 159, 'gtbmfwzx', '古塘便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6510, 3438, 'D83BDFB4DA71AC5C48257F6F0008483E', 160, 'hsbmfwzx', '浒山便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6511, 3439, '6F499B3B4C8B28B648257F6F00085DB4', 163, 'kdbmfwzx', '坎墩便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6512, 3440, '299002C226F4B4E348257F6F000A0C7A', 152, 'kybmfwzx', '匡堰便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6513, 3441, '265C5B2DB791268E48257F6F00086A1C', 151, 'qtbmfwzx', '桥头便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6514, 3442, '185BA929C788198748257F6F00088561', 149, 'ssbmfwzx', '胜山便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6515, 3443, '91C6A7313CF5D8D848257F6F00084ECF', 0, 'xpbmfwzx', '新浦便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6516, 3444, 'A58A19DA8C20BCC348257F6F000863B2', 162, 'zhbmfwzx', '宗汉便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6517, 3445, '410918322AC1BB7B48257F6F000877A0', 145, 'zqbmfwzx', '掌起便民服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6518, 3446, 'D51C63B87658B23048257F770013244F', 10, 'sfbcyn', '市府办蔡依柠', NULL, NULL, NULL, '', 3, '{}', 88),
(6519, 3447, 'AEC4ED83B5696B6B48257F79000590F6', 188, 'sjsjtfwb', '市建设集团监察法务部', NULL, NULL, NULL, '', 3, '{}', 88),
(6520, 3448, '1E3C8F187F586E8348257F8400263738', 216, 'cxygs', '慈溪医工所', NULL, NULL, NULL, '', 3, '{}', 88),
(6521, 3449, 'ED1132B4B2DA6D0848257F840029B12C', 15, 'sjw44', '市纪委杜潞潞', NULL, NULL, NULL, '', 3, '{}', 88),
(6522, 3450, '67B685B5DCA5258E48257F8400262F70', 217, 'zkycxzx', '中科院慈溪中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6523, 3451, '012169B7A9D48ECD48257F850026A4D4', 8, 'dyjjz', '第一纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6524, 3452, '69E132BAAC26971C48257F850026ABB3', 8, 'dyjjz3', '第一纪检组黄玲琳', NULL, NULL, NULL, '', 3, '{}', 88),
(6525, 3453, '3DAFBB4277F3B1F948257F85002C38A2', 43, 'sjyj13', '市教育局依米提.玉山', NULL, NULL, NULL, '', 3, '{}', 88),
(6526, 3454, '60B149C11073B1AE48257F88002557B9', 149, 'sszzhzhs', '胜山镇综合指挥室', NULL, NULL, NULL, '', 3, '{}', 88),
(6527, 3455, '49C4446A9702A3F948257F8C0024E272', 63, 'swsj11', '市卫生和计划生育局陈雨虹', NULL, NULL, NULL, '', 3, '{}', 88),
(6528, 3456, '85249869843FA6CA48257F8D0004F301', 10, 'sfbcr', '市府办蔡润', NULL, NULL, NULL, '', 3, '{}', 88),
(6529, 3457, '10A35965849E4A5D48257F8D0004F92E', 10, 'sfbzzc', '市府办张哲晨', NULL, NULL, NULL, '', 3, '{}', 88),
(6530, 3458, '16D8E7B00A9D4BC048257F8F000999BD', 4, 'szfsy', '市政府孙涌', NULL, NULL, NULL, '', 3, '{}', 88),
(6531, 3459, 'A50556036AE919C448257F99002804CC', 156, 'chzajs', '长河镇安监所', NULL, NULL, NULL, '', 3, '{}', 88),
(6532, 3460, 'AD3DC0EBC06AB7AB48257F99002ACC17', 11, 'szxbzmf', '市政协办郑咪芳', NULL, NULL, NULL, '', 3, '{}', 88),
(6533, 3461, '6F81B059489CD17C48257F9B00048AAB', 33, 'scl6', '市残联孙俊杰', NULL, NULL, NULL, '', 3, '{}', 88),
(6534, 3462, '2E90CDB0665904BD48257FA00022513C', 11, 'szxbxzk', '市政协办行政科', NULL, NULL, NULL, '', 3, '{}', 88),
(6535, 3463, '5B7FD435B244DF4748257FA80022E138', 10, 'sfbcqt', '市府办陈祺赕', NULL, NULL, NULL, '', 3, '{}', 88),
(6536, 3464, '4745D862EDA5639448257FA80022E826', 10, 'sfbyjf', '市府办叶金芳', NULL, NULL, NULL, '', 3, '{}', 88),
(6537, 3465, '1D2BAE71924D2CD048257FA9002BF3C3', 152, 'kyzxtwy', '匡堰镇宣统委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6538, 3466, 'C266BA1A671FFC0048257FA90011A116', 0, 'zshg', '浙商回归', NULL, NULL, NULL, '', 3, '{}', 88),
(6539, 3467, '09A1925F9C13C64E48257FAB0004E9E5', 26, 'swdxjjx', '市委党校经济学团队', NULL, NULL, NULL, '', 3, '{}', 88),
(6540, 3468, 'EFABA9CF4873948248257FAB0004DCA8', 26, 'swdxjwgl', '市委党校教务管理团队', NULL, NULL, NULL, '', 3, '{}', 88),
(6541, 3469, '491B13D66ED5931D48257FAB0004E365', 26, 'swdxkcsj', '市委党校课程设计团队', NULL, NULL, NULL, '', 3, '{}', 88),
(6542, 3470, '7390BB8214228AAF48257FAB0004F07B', 26, 'swdxshzl', '市委党校社会治理团队', NULL, NULL, NULL, '', 3, '{}', 88),
(6543, 3471, '5B64E0434D8B50B948257FAB00300A72', 83, 'whswq7', '市环杭州湾创新中心江维', NULL, NULL, NULL, '', 3, '{}', 88),
(6544, 3472, '1CDA2B7B8F932DD248257FAE002B81ED', 153, 'hhzpsglz', '横河镇排水管理站', NULL, NULL, NULL, '', 3, '{}', 88),
(6545, 3473, '1399C92A1401491D48257FB1002961AA', 51, 'sczjjcs', '驻市财税局纪检组', NULL, NULL, NULL, '', 3, '{}', 88),
(6546, 3474, 'BE071D8970272A3A48257FB10003D06D', 16, 'slxyz', '市“两学一做”学习教育协调小组', NULL, NULL, NULL, '', 3, '{}', 88),
(6547, 3475, 'FAC587566FE5AEFA48257FB50005CCE8', 154, 'cszzfwy', '崇寿镇政法委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6548, 3476, '44828B8AA54166CD48257FB60022B962', 8, 'swbhbk', '市委办华卞卡', NULL, NULL, NULL, '', 3, '{}', 88),
(6549, 3477, 'F150651D0801B65948257FB7000F98D8', 8, 'swbqxx', '市委办钱星鑫', NULL, NULL, NULL, '', 3, '{}', 88),
(6550, 3478, '07D35F35BCB132DA48257FB8002B867F', 219, 'slyjt', '市旅游集团综合事务部', NULL, NULL, NULL, '', 3, '{}', 88),
(6551, 3479, '9765E5A125936C9848257FBD00056884', 48, 'scshjk', '市慈善总会捐款', NULL, NULL, NULL, '', 3, '{}', 88),
(6552, 3480, 'B6DB1154E8C28E1D48257FC50006E0C3', 218, 'sjtjt', '市交通集团徐德忠', NULL, NULL, NULL, '', 3, '{}', 88),
(6553, 3481, '98CF052074F3E0A848257FC5002B3745', 218, 'sjtjt1', '市交通集团沈科群', NULL, NULL, NULL, '', 3, '{}', 88),
(6554, 3482, '27A088C5CB475C0A48257FC5002B3DBE', 218, 'sjtjt2', '市交通集团陈吉邦', NULL, NULL, NULL, '', 3, '{}', 88),
(6555, 3483, 'FF6D599B1D394A8248257FC5002B4724', 218, 'sjtjt3', '市交通集团卢雪强', NULL, NULL, NULL, '', 3, '{}', 88),
(6556, 3484, 'CA94D8A7191703D948257FC5002B4F53', 218, 'sjtjt4', '市交通集团邹丰', NULL, NULL, NULL, '', 3, '{}', 88),
(6557, 3485, 'D470ABD35149CEC648257FC5002B59CD', 218, 'sjtjt5', '市交通集团王树平', NULL, NULL, NULL, '', 3, '{}', 88),
(6558, 3486, '5CB0D322A73F2F7148257FC5002B62E5', 218, 'sjtjt6', '市交通集团王超波', NULL, NULL, NULL, '', 3, '{}', 88),
(6559, 3487, 'AC28B08CB5D9BB2448257FC5002B7055', 218, 'sjtjtajb', '市交通集团安全机务部', NULL, NULL, NULL, '', 3, '{}', 88),
(6560, 3488, '2AB5FAE706D97FF848257FC5002B696D', 218, 'sjtjtjcb', '市交通集团计划财务部', NULL, NULL, NULL, '', 3, '{}', 88),
(6561, 3489, 'CF908B7E58CD290C48257FC5002B77F6', 218, 'sjtjtjgb', '市交通集团经营管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(6562, 3490, 'EF111A71EB4617F748257FC5002B865E', 218, 'sjtjtjjs', '市交通集团纪检监察室', NULL, NULL, NULL, '', 3, '{}', 88),
(6563, 3491, '4EDE7A0C25FBF8F548257FC5002B7FCD', 218, 'sjtjttzb', '市交通集团投资建设部', NULL, NULL, NULL, '', 3, '{}', 88),
(6564, 3492, 'BC466C59AC820A7448257FC5002B8D2E', 218, 'sjtjtz1', '市公路运输有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6565, 3493, '817C3875A0ACBECB48257FC5002BF143', 218, 'sjtjtz2', '市城乡公共交通有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6566, 3494, 'FEED34E809279A9A48257FC5002BF756', 218, 'sjtjtz3', '市交通站务经营有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6567, 3495, '7CF70B1DAE90E9B048257FC5002BFDE7', 218, 'sjtjtz4', '市三北出租汽车有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6568, 3496, 'F3A040F934B4FC7948257FC5002C04E1', 218, 'sjtjtz5', '市交通物流发展有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6569, 3497, 'D7A196069CA1645D48257FC5002C0B70', 218, 'sjtjtz6', '市交通建设投资有限公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6570, 3498, 'D2CF4D2847ACA75E48257FC5002B3125', 218, 'sjtjtzhb', '市交通集团综合事务部', NULL, NULL, NULL, '', 3, '{}', 88),
(6571, 3499, '58F5C3E56F670ED348257FD00005C40E', 41, 'sjxjjfb', '市减负办', NULL, NULL, NULL, '', 3, '{}', 88),
(6572, 3500, '002FEE12223171D648257FD00005194F', 188, 'zfbzgsbgs', '市住房保障公司办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6573, 3501, 'E45876CA4271AC2F48257FD3000939C8', 10, 'sfbzkl', '市府办朱凯玲', NULL, NULL, NULL, '', 3, '{}', 88),
(6574, 3503, '8D5572BDA4715FE948257FD50025004F', 54, 'sgtjjdyjg', '市国土资源局督查与监管（内审）办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6575, 3504, '25B81CA6D6BA4F8F48257FDC0003782E', 51, 'scsj9', '市财政地税局胡惠群', NULL, NULL, NULL, '', 3, '{}', 88),
(6576, 3505, 'F4724F76E9C8182A48257FDF0005E082', 23, 'sjgdgw6', '市机关党工委张巧平', NULL, NULL, NULL, '', 3, '{}', 88),
(6577, 3506, '7F173CC73C88493448257FE10004E334', 43, 'sjyj14', '市教育局岑强辉', NULL, NULL, NULL, '', 3, '{}', 88),
(6578, 3507, '97140C3FB832E83C48257FE2002DA801', 4, 'szfzmz', '市政府邹苗章', NULL, NULL, NULL, '', 3, '{}', 88),
(6579, 3508, 'D1890A2E0D6E068348257FE2002DD572', 151, 'qtztyy', '桥头镇调研员', NULL, NULL, NULL, '', 3, '{}', 88),
(6580, 3509, '03ADECCC47F83AC948257FE600281DA7', 161, 'bsljd22', '白沙路街道组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6581, 3510, 'BDEFB6C00E4F1CE248257FE6002825B7', 161, 'bsljd24', '白沙路街道调研员6', NULL, NULL, NULL, '', 3, '{}', 88),
(6582, 3511, 'E71A8090B4E9B34E48257FE600031AB5', 173, 'sxxcybgs7', '慈溪高新技术产业开发区管理委员会黄磊', NULL, NULL, NULL, '', 3, '{}', 88),
(6583, 3512, '938B67F81805D55348257FE60027F239', 173, 'sxxcybgs8', '慈溪高新技术产业开发区管理委员会余永刚', NULL, NULL, NULL, '', 3, '{}', 88),
(6584, 3513, '3949E6EC55D7470A48257FE60005F93B', 4, 'szfswz', '市政府施卫忠', NULL, NULL, NULL, '', 3, '{}', 88),
(6585, 3514, '5EA8D3163DE5490448257FE7002B7D11', 219, 'slyjt1', '市旅游集团徐建岳', NULL, NULL, NULL, '', 3, '{}', 88),
(6586, 3515, '56110833FB27013A48257FE7002B83AF', 219, 'slyjt2', '市旅游集团刘伟峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6587, 3516, '8196644E3874EE1B48257FE7002A8ED4', 35, 'swl6', '市文联徐建立', NULL, NULL, NULL, '', 3, '{}', 88),
(6588, 3517, 'AFF53B3CA8B0F4AD48257FE7000EF62D', 11, 'szxbsj', '市政协委员工委沈坚', NULL, NULL, NULL, '', 3, '{}', 88),
(6589, 3519, 'F58BFD86FCC27F5C48257FEA00052A88', 63, 'swsj4', '市卫生和计划生育局车建成', NULL, NULL, NULL, '', 3, '{}', 88),
(6590, 3520, '6FAE062AB804F56648257FEE0005F37B', 8, 'swblhx', '市委办陆华祥', NULL, NULL, NULL, '', 3, '{}', 88),
(6591, 3521, 'BE9142D18DB2AE3948257FF000279294', 67, 'sxfjsws', '市信访局办公室收文室', NULL, NULL, NULL, '', 3, '{}', 88),
(6592, 3522, '0ADDD0902354047D48257FF000278BEA', 148, 'xlzjwsj', '逍林镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6593, 3523, '0A37E300F6EDAAC648257FF000278517', 148, 'xlzzzwy', '逍林镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6594, 3524, 'D28C95E57761A3FD48257FF1000489BB', 55, 'szjjpzb', '市品质办', NULL, NULL, NULL, '', 3, '{}', 88),
(6595, 3525, '6D541F84A6E0864C48257FF60023F620', 51, 'scgb', '市车改办', NULL, NULL, NULL, '', 3, '{}', 88),
(6596, 3526, 'DE9BFA830FEF1F1548257FF600267500', 45, 'sgajbgs1', '市公安局办公室周志叶', NULL, NULL, NULL, '', 3, '{}', 88),
(6597, 3527, 'CBEE663A2D68D15248257FF600264F61', 99, 'sxdnykfq9', '市现代农业开发区管委会余建斌', NULL, NULL, NULL, '', 3, '{}', 88),
(6598, 3528, '0526335861411CB648257FFC0027F64B', 203, 'ssmjt7', '市商贸集团有限公司楼竞雄', NULL, NULL, NULL, '', 3, '{}', 88),
(6599, 3529, '04025F66BA146DF048257FFE0003AA0F', 44, 'skjj9', '市科技局钟志光', NULL, NULL, NULL, '', 3, '{}', 88),
(6600, 3530, '6C354021AB622F1D4825800200067B87', 156, 'chzzzwy', '长河镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6601, 3531, '9FE4C13A89F9D8934825800A0003F31F', 161, 'bsljdnypc', '白沙路街道农业普查', NULL, NULL, NULL, '', 3, '{}', 88),
(6602, 3532, '0FD2F22EF2DB0FD24825800B00077C95', 42, 'sajj12', '市安监局童科', NULL, NULL, NULL, '', 3, '{}', 88),
(6603, 3533, '18FACCCD6A111F234825800B00058F6E', 15, 'sjw45', '市纪委章国权', NULL, NULL, NULL, '', 3, '{}', 88),
(6604, 3534, '4C91CBC1C9082B1F4825800B000618C4', 19, 'smzzjj6', '市民族宗教局何烨强', NULL, NULL, NULL, '', 3, '{}', 88),
(6605, 3535, '208828DB5483CD844825800B00281B8B', 149, 'sszzfwy', '胜山镇政法委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6606, 3536, '720C4CC975A10C9B4825800C00305E31', 17, 'swxcbwhyj', '市委宣传部文化研究工程办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6607, 3537, '35172ADE1CCD7953482580110004FE08', 153, 'hhz7', '横河镇罗爱庆', NULL, NULL, NULL, '', 3, '{}', 88),
(6608, 3538, '1D313E144758E264482580110005176D', 153, 'hhz8', '横河镇许华乔', NULL, NULL, NULL, '', 3, '{}', 88),
(6609, 3539, 'A949F514DA7892144825801100051D67', 153, 'hhz9', '横河镇朱国达', NULL, NULL, NULL, '', 3, '{}', 88),
(6610, 3540, '130017132D52BBE8482580110004B554', 153, 'hhzajs', '横河镇安监所', NULL, NULL, NULL, '', 3, '{}', 88),
(6611, 3541, '6D21F3F78AC891B34825801100048A0B', 153, 'hhzfwywy', '横河镇服务业委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6612, 3542, '14026C59FFFA738B4825801100048371', 153, 'hhzjwsj', '横河镇纪委书记', NULL, NULL, NULL, '', 3, '{}', 88),
(6613, 3543, '29182E980B63E00B4825801100047C2D', 153, 'hhzrdzx', '横河镇人大主席', NULL, NULL, NULL, '', 3, '{}', 88),
(6614, 3544, '09447B3E15168A4C482580110004ADEC', 153, 'hhzshsyb', '横河镇社会事务办', NULL, NULL, NULL, '', 3, '{}', 88),
(6615, 3545, '66488CD25FB1FA1C482580120026A21C', 159, 'gtjdzxllw', '古塘街道政协联络委', NULL, NULL, NULL, '', 3, '{}', 88),
(6616, 3546, '2BD7FA6EF60E505A482580180033231B', 63, 'swsj5', '市卫生和计划生育局杨娟芬', NULL, NULL, NULL, '', 3, '{}', 88),
(6617, 3547, '58186245F506B5F048258018002640A9', 158, 'zxznypc', '周巷镇农业普查办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6618, 3548, '8591F480903ABF5E482580190030D0C3', 8, 'swbwsr', '市委办王孙荣', NULL, NULL, NULL, '', 3, '{}', 88),
(6619, 3549, '18DDD442B56F548D4825801A000EAA44', 51, 'scsj10', '市财政地税局龚建冲', NULL, NULL, NULL, '', 3, '{}', 88),
(6620, 3550, '81D1DF466FA86B794825801A00102E0F', 150, 'xpzzfwy', '新浦镇政法委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6621, 3551, '05739CFA6E0CC9B04825801A001081A3', 150, 'xpzzuzwy', '新浦镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6622, 3552, 'C204F044E5814CDE4825801E002052FD', 152, 'kyzxfz', '匡堰镇消防站', NULL, NULL, NULL, '', 3, '{}', 88),
(6623, 3553, '76A67C10041B24464825801E00204D59', 152, 'kyzzzwy', '匡堰镇组织委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6624, 3554, '9CD04AD27DF4E24D4825801F0006119A', 191, 'sjczxw3', '市决策咨询委陈军学', NULL, NULL, NULL, '', 3, '{}', 88),
(6625, 3555, '4615E544C9E48FA448258023000982DF', 10, 'shlwb', '市互联网办', NULL, NULL, NULL, '', 3, '{}', 88),
(6626, 3556, '58E20278A48CCC534825802300040410', 219, 'slyjt3', '市旅游集团马立丽', NULL, NULL, NULL, '', 3, '{}', 88),
(6627, 3557, '36FB3EF627F182244825802300040C67', 219, 'slyjt4', '市旅游集团瞿桂华', NULL, NULL, NULL, '', 3, '{}', 88),
(6628, 3558, '2A496D8D85096541482580230004137D', 219, 'slyjtcwb', '市旅游集团投资财务部', NULL, NULL, NULL, '', 3, '{}', 88),
(6629, 3559, 'F7DDED4AD557B15D482580230004219C', 219, 'slyjtglb', '市旅游集团工程管理部', NULL, NULL, NULL, '', 3, '{}', 88),
(6630, 3560, '50B7961D44437FAB482580230004280B', 219, 'slyjtjcb', '市旅游集团审计监察部', NULL, NULL, NULL, '', 3, '{}', 88),
(6631, 3561, '60B3987CE7F3AB524825802300041AD4', 219, 'slyjtkfb', '市旅游集团招商开发部', NULL, NULL, NULL, '', 3, '{}', 88),
(6632, 3562, 'AA626276EB086D234825802300042F69', 219, 'slyjtwls', '市旅游集团五磊山公司', NULL, NULL, NULL, '', 3, '{}', 88),
(6633, 3563, '0DAFA464B19B4EEA482580240007796D', 11, 'szxblc', '市社法港澳台侨委林晨', NULL, NULL, NULL, '', 3, '{}', 88),
(6634, 3564, 'E7BC34144E87962648258025002F9F54', 49, 'sllw4', '市老龄事业发展基金会毛加强', NULL, NULL, NULL, '', 3, '{}', 88),
(6635, 3565, 'F6DC8B47EE545B24482580320008D4E2', 83, 'hhzwjjfz', '市环杭州湾创新中心经济发展科', NULL, NULL, NULL, '', 3, '{}', 88),
(6636, 3566, 'A6E2AC4EAC380C45482580320008DBC7', 83, 'hhzwzhgl', '市环杭州湾创新中心综合管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6637, 3567, 'B5F97882CF448C4F482580320005263B', 16, 'swhjldxz', '市委换届领导小组办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6638, 3568, '88DE86193DF8A063482580330008ECD1', 47, 'smzj10', '市民政局王宝娣', NULL, NULL, NULL, '', 3, '{}', 88),
(6639, 3569, 'D7E9A529EFE79F13482580330008E601', 47, 'smzj9', '市民政局何静宜', NULL, NULL, NULL, '', 3, '{}', 88),
(6640, 3570, '5E34B4A08E5E343F482580470024BFE4', 220, 'slljjh1', '市老龄基金会毛加强', NULL, NULL, NULL, '', 3, '{}', 88),
(6641, 3571, '038E3EE132E02A1B482580470024C873', 220, 'slljjh2', '市老龄基金会周干尔', NULL, NULL, NULL, '', 3, '{}', 88),
(6642, 3572, '8376A2E3ECEF84EB482580470024B99D', 220, 'slljjhbgs', '市老龄基金会办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6643, 3573, 'E61365BB03359D4F48258048002DA94D', 51, 'scsjgfglk', '市财税局规费管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6644, 3574, '2CAE9C57C47EE15F48258048002EFD2C', 83, 'scxzxghjsk1', '市环杭州湾创新中心规划建设科１', NULL, NULL, NULL, '', 3, '{}', 88),
(6645, 3575, '505BD7ADCF11340048258048002F0443', 83, 'scxzxghjsk2', '市环杭州湾创新中心规划建设科２', NULL, NULL, NULL, '', 3, '{}', 88),
(6646, 3576, '280E310EF0B422D248258048002F0AB7', 83, 'scxzxghjsk3', '市环杭州湾创新中心规划建设科３', NULL, NULL, NULL, '', 3, '{}', 88),
(6647, 3577, '0CCC34837E6AA5D848258048002F133F', 83, 'scxzxghjsk4', '市环杭州湾创新中心规划建设科４', NULL, NULL, NULL, '', 3, '{}', 88),
(6648, 3578, 'D1A2289DCC27A6B34825804A0003D4AC', 8, 'swbsml', '市委办孙明磊', NULL, NULL, NULL, '', 3, '{}', 88),
(6649, 3579, '66EDA1DF26E133214825804A0003DB8E', 8, 'swbswj', '市委办沈维江', NULL, NULL, NULL, '', 3, '{}', 88),
(6650, 3580, '6547C9E21258F482482580510005C270', 146, 'ghwzdwwy', '观海卫镇党委委员（鸣鹤风景）', NULL, NULL, NULL, '', 3, '{}', 88),
(6651, 3581, '2659CB64C464637D482580510005BBF3', 146, 'ghwzmhfjb', '观海卫镇鸣鹤风景办', NULL, NULL, NULL, '', 3, '{}', 88),
(6652, 3582, 'FEA379AD3949C828482580510007C300', 10, 'sfblxg', '市府办鲁霞光', NULL, NULL, NULL, '', 3, '{}', 88),
(6653, 3583, '3EA3ECAEDC13A597482580510007BCCD', 10, 'sfbygn', '市府办俞国南', NULL, NULL, NULL, '', 3, '{}', 88),
(6654, 3584, '828911EE0238E1C748258052000D6816', 221, 'bsyh', '包商银行宁波慈溪支行', NULL, NULL, NULL, '', 3, '{}', 88),
(6655, 3585, 'E0AAA2DBEACF2754482580530004E15B', 154, 'csznyzz', '崇寿镇农业副镇长', NULL, NULL, NULL, '', 3, '{}', 88),
(6656, 3586, 'DC69C3506B04BBBE482580530004E7D0', 154, 'cszrdfzx', '崇寿镇人大副主席', NULL, NULL, NULL, '', 3, '{}', 88),
(6657, 3587, '492161463260114E48258056002FFC32', 10, 'hsz', '测试用户1', NULL, NULL, NULL, '', 3, '{}', 88),
(6658, 3588, 'C18E3DD16EE3036848258056000CC767', 51, 'scsjzwjdglk', '市财税局债务监督管理科', NULL, NULL, NULL, '', 3, '{}', 88),
(6659, 3589, '5F361BEC53CB07F648258056002503FA', 4, 'swfgr', '市政府傅贵荣', NULL, NULL, NULL, '', 3, '{}', 88),
(6660, 3590, 'AD417E4B7D4A7230482580580005B2CE', 8, 'swbcyy', '市委办陈妍羽', NULL, NULL, NULL, '', 3, '{}', 88),
(6661, 3591, '07C9F682EF8F36ED4825805F0027929B', 148, 'xlzscwy', '逍林镇三产委员', NULL, NULL, NULL, '', 3, '{}', 88),
(6662, 3592, 'CD9AE5F8724A0CAD4825806F0025F923', 4, 'szfhjl', '市政府胡姣良', NULL, NULL, NULL, '', 3, '{}', 88),
(6663, 3593, 'A7E43F5B7BE9AA4C4825806F0025FF20', 4, 'szflhb', '市政府李洪波', NULL, NULL, NULL, '', 3, '{}', 88),
(6664, 3594, '6B93BFEAA25FCBE54825806F0025C439', 4, 'szflmf', '市政府李懋峰', NULL, NULL, NULL, '', 3, '{}', 88),
(6665, 3595, 'EDD2BDD8758C11094825806F0025B6C0', 4, 'szfsrb', '市政府沈汝秉', NULL, NULL, NULL, '', 3, '{}', 88),
(6666, 3596, 'DD3C3D97FA00BB1B4825806F0025B057', 4, 'szfsxx', '市政府沈小贤', NULL, NULL, NULL, '', 3, '{}', 88),
(6667, 3597, '000D446A6FD411F64825806F0025A975', 4, 'szfxm', '市政府项敏', NULL, NULL, NULL, '', 3, '{}', 88),
(6668, 3598, 'F4C3E537098BEB6B4825806F0025BCC2', 4, 'szfzy', '市政府周阳', NULL, NULL, NULL, '', 3, '{}', 88),
(6669, 3599, '9170366DDC91803E482580720008D08F', 10, 'sfbxwm', '市府办徐文明', NULL, NULL, NULL, '', 3, '{}', 88),
(6670, 3600, '48BDC9BE3E4999FE48258072000AB7AD', 2, 'swgqf', '市委高庆丰', NULL, NULL, NULL, '', 3, '{}', 88),
(6671, 3601, '772718FAB5E70C6D48258072000CBC4A', 2, 'swwhy', '市委王海寅', NULL, NULL, NULL, '', 3, '{}', 88),
(6672, 3602, 'E9BBBFAFBCB13A584825807200084C61', 2, 'swzpj', '市委周培剑', NULL, NULL, NULL, '', 3, '{}', 88),
(6673, 3603, '65C0BEF460BBB6964825808200263BA0', 45, 'sgajfzdd', '市公安局法制大队', NULL, NULL, NULL, '', 3, '{}', 88),
(6674, 3604, '7703426BC80F5D994825808700059A9B', 45, 'sgajswy', '市公安局施文银', NULL, NULL, NULL, '', 3, '{}', 88),
(6675, 3605, '8AC651C2E2CCFC384825809900060EE2', 35, 'swl7', '市文联张巧慧', NULL, NULL, NULL, '', 3, '{}', 88),
(6676, 3606, 'B582BCA07992F0EB4825809E00111084', 146, 'ghwjjzd', '观海卫交警中队', NULL, NULL, NULL, '', 3, '{}', 88),
(6677, 3607, '25AD357900122ECB4825809F0010B722', 8, 'dyjjz4', '第一纪检组张绩伟', NULL, NULL, NULL, '', 3, '{}', 88),
(6678, 3608, '616E9C9C6669040B482580A5002AA740', 154, 'cszxfgzz', '崇寿镇消防工作站', NULL, NULL, NULL, '', 3, '{}', 88),
(6679, 3609, '00ADFEE58934AA98482580A70007E269', 153, 'hhzscb', '横河镇经发办（三产）', NULL, NULL, NULL, '', 3, '{}', 88),
(6680, 3610, '76CE3DD653819175482580AA0006B692', 77, 'sjggljbgs4', '市机关事务管理局办公室4', NULL, NULL, NULL, '', 3, '{}', 88),
(6681, 3611, '80C808AD20C41EE4482580AA0006C062', 77, 'sjggljbgs5', '市机关事务管理局办公室5', NULL, NULL, NULL, '', 3, '{}', 88),
(6682, 3612, 'ACB4F93918BDEB9B482580AA0006AD54', 158, 'zxzxcx', '周巷镇宣传办', NULL, NULL, NULL, '', 3, '{}', 88),
(6683, 3613, '04BB6F00CC03A6B7482580AB002B9820', 222, 'sxczzzb1', '市小城镇整治办副主任陈锋', NULL, NULL, NULL, '', 3, '{}', 88),
(6684, 3614, 'A44162FD7A0A5C54482580AB002C5229', 0, 'sxczzzbbdz', '市小城镇整治办宣传报道组', NULL, NULL, NULL, '', 3, '{}', 88),
(6685, 3615, '7613814CD5317426482580AB002C6D17', 0, 'sxczzzbclk', '市小城镇整治办车乱开治理组', NULL, NULL, NULL, '', 3, '{}', 88),
(6686, 3616, 'BDC714B99648B037482580AB002C4C2E', 222, 'sxczzzbddz', '市小城镇整治办综合督导组', NULL, NULL, NULL, '', 3, '{}', 88),
(6687, 3617, '7643D0F0B681A25E482580AB002C65E2', 222, 'sxczzzbdlz', '市小城镇整治办道乱占治理组', NULL, NULL, NULL, '', 3, '{}', 88),
(6688, 3618, '12A3596641391DF1482580AB002C7A4E', 222, 'sxczzzbdxs', '市小城镇整治办低小散块状行业治理组', NULL, NULL, NULL, '', 3, '{}', 88),
(6689, 3619, '3F7B811178442420482580AB002C58B9', 222, 'sxczzzbghsj', '市小城镇整治办规划设计引领组', NULL, NULL, NULL, '', 3, '{}', 88),
(6690, 3620, '3BD5AD335AFCDD46482580AB002C5EFD', 222, 'sxczzzbwsxz', '市小城镇整治办卫生乡镇创建组', NULL, NULL, NULL, '', 3, '{}', 88),
(6691, 3621, '4CA570299F3B72D2482580AB002C73BC', 222, 'sxczzzbxll', '市小城镇整治办线乱拉治理组', NULL, NULL, NULL, '', 3, '{}', 88),
(6692, 3622, 'D39835C6BB5D5F3E482580C0000B9F7C', 194, 'spsgs1', '市排水有限公司黄勤', NULL, NULL, NULL, '', 3, '{}', 88),
(6693, 3623, 'DDB0881503C104EC482580C0000BA8C4', 0, 'sswtzyxgs1', '市水务投资有限公司陶岳云', NULL, NULL, NULL, '', 3, '{}', 88),
(6694, 3624, 'DC5830F53CC5E762482580C300051C98', 147, 'fhzllw', '附海镇老龄委', NULL, NULL, NULL, '', 3, '{}', 88),
(6695, 3625, '42FE61A52EB84B34482580C70023F745', 154, 'csznyfwzx', '崇寿镇农业服务中心', NULL, NULL, NULL, '', 3, '{}', 88),
(6696, 3626, '7A208D286AB1B0DA482580C70023EAB2', 154, 'cszscb', '崇寿镇三产办', NULL, NULL, NULL, '', 3, '{}', 88),
(6697, 3627, '87F47CECCC451857482580C70023F0A9', 154, 'cszzhzhs', '崇寿镇综合指挥室', NULL, NULL, NULL, '', 3, '{}', 88),
(6698, 3628, '57CD44143BA022CD482580C70023A792', 45, 'sgajxzspk', '市公安局行政审批科', NULL, NULL, NULL, '', 3, '{}', 88),
(6699, 3629, '2B152F3B66071B3B482580C700130A75', 3, 'srdlxc', '市人大楼雪聪', NULL, NULL, NULL, '', 3, '{}', 88),
(6700, 3630, 'B09352AA3FB475B8482580C7001303DE', 3, 'srdmzl', '市人大莫志梁', NULL, NULL, NULL, '', 3, '{}', 88),
(6701, 3631, 'EAB9AF92DB53CF5B482580C700237EFE', 149, 'sszwsgz', '胜山镇“五水共治”办公室', NULL, NULL, NULL, '', 3, '{}', 88),
(6702, 3632, '4CEADF416CEA49D2482580C700221A27', 5, 'szxzjr', '市政协张建人', NULL, NULL, NULL, '', 3, '{}', 88),
(6703, 3634, 'F1E2EEBC3602AC6F482580C90009FA5A', 11, 'luys123', '市政协办测试', NULL, NULL, NULL, '', 3, '{}', 88),
(6704, 3635, 'A837AC49269B2639482580CA0004E13A', 55, 'szjjsjb', '市住建局三居办', NULL, NULL, NULL, '', 3, '{}', 88),
(6705, 3636, '9C0C773639840B2548256C25002DFF2E', 15, 'sjwfsj1', '市纪委胡孟波', NULL, NULL, NULL, '', 3, '{}', 88),
(6706, 3637, '75D46012845CF6BA482580CD00242DEA', 145, 'zqzshfwgl', '掌起镇社会服务管理综合指挥室', NULL, NULL, NULL, '', 3, '{}', 88),
(6707, 3638, '47B1DC928030FAC9482580CE002C4C28', 10, 'sfbzw', '市府办张文', NULL, NULL, NULL, '', 3, '{}', 88),
(6708, 3639, '73A6066FE37DB81A482580CE00052C26', 2, 'swzhj', '市委张红军', NULL, NULL, NULL, '', 3, '{}', 88),
(6709, 3640, '078C45E51FAA2A61482580CF002D112C', 220, 'slljjh3', '市老龄基金会许其能', NULL, NULL, NULL, '', 3, '{}', 88),
(6710, 3641, '2E40C2DBE6B3BBEA482580CF0005B5DA', 4, 'szfyjh', '市政府姚金环', NULL, NULL, NULL, '', 3, '{}', 88),
(6711, 3642, 'B17F7C453B14279D482580D0002242E1', 151, 'qtzzzb', '桥头镇组织办', NULL, NULL, NULL, '', 3, '{}', 88),
(6712, 3643, 'C4E6E9F4C2006C52482580D100057D99', 153, 'hhzcgb', '横河镇城管办', NULL, NULL, NULL, '', 3, '{}', 88),
(6713, 3644, 'BF7B0C1ADB911E93482580D100058B26', 153, 'hhzwys', '横河镇文印室', NULL, NULL, NULL, '', 3, '{}', 88),
(6714, 3645, 'B668D78BBBFBB23A482580D100058496', 153, 'hhzzhzhs', '横河镇综合指挥室', NULL, NULL, NULL, '', 3, '{}', 88),
(6715, 3646, '541000E993D6B712482580D500072D4F', 153, 'hhzdas', '横河镇档案室', NULL, NULL, NULL, '', 3, '{}', 88),
(6716, 3647, 'DB57A9DB87C75BFA482580D400086973', 99, 'sxdnykfqzzx', '市现代农业开发区管委会综治线', NULL, NULL, NULL, '', 3, '{}', 88),
(6717, 3648, 'DCA0BAE041DDEF5C482580D6000FF1D3', 11, 'szxbygn', '教文卫体文史资料委俞国南', NULL, NULL, NULL, '', 3, '{}', 88),
(6718, 3649, '4C78E6B1DC23EED5482580D7000548EC', 152, 'kyzzhzhs', '匡堰镇综合指挥室', NULL, NULL, NULL, '', 3, '{}', 88),
(6719, 3650, '81FE55ECE9608806482580D7000FC0D2', 5, 'szxwyn', '市政协王益女', NULL, NULL, NULL, '', 3, '{}', 88),
(6720, 3651, '0BA4A10118EC7504482580D800228D7E', 153, 'hhzxczzhzzb', '横河镇小城镇综合整治办', NULL, NULL, NULL, '', 3, '{}', 88),
(6721, 3652, '6A6DF58FEE902471482580DB000640AC', 45, 'sgajcqzd', '市公安局交警大队城区中队', NULL, NULL, NULL, '', 3, '{}', 88),
(6725, NULL, NULL, 5, 'zxtemp', '政协（测试账号）', NULL, NULL, '1234', '123', 2, '{}', 0),
(6726, NULL, NULL, 10, 'dcstemp', '督察室（测试）', NULL, NULL, '1234', '4', 3, '{}', 0),
(6728, NULL, NULL, 8, 'swbtemp', '市委办（测试）', NULL, NULL, '1234', '4', 3, '{}', 0),
(6729, NULL, NULL, 3, 'rdtemp', '市人大工委（测试）', NULL, NULL, '1234', '123', 1, '{}', 0);

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
(7, 103, 'operator', '管理员'),
(8, 103, 'options', '控制选项'),
(10, 104, 'motion_temp_edit', '模板编辑'),
(11, 104, 'attr_temp_edit', '选项编辑'),
(12, 105, 'unit_step', '单位流程权限'),
(13, 105, 'staff_step', '操作员流程权限'),
(14, 105, 'add_steff', '添加操作员'),
(15, 106, 'meet_edit', '回忆编辑');

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
-- 替换视图以便查看 `unit_admin_view`
--
CREATE TABLE `unit_admin_view` (
`unit_id` int(11)
,`unid` varchar(35)
,`unit_group` int(11)
,`parent_unit` int(11)
,`category` int(11)
,`steps` varchar(20)
,`unit_name` varchar(50)
,`reorder` int(11)
,`member` int(11)
,`parent_name` varchar(50)
,`unit_group_name` varchar(50)
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
  `unid` varchar(35) DEFAULT NULL,
  `unit_group` int(11) NOT NULL,
  `parent_unit` int(11) NOT NULL DEFAULT '0',
  `category` int(11) NOT NULL,
  `steps` varchar(20) DEFAULT NULL,
  `unit_name` varchar(50) NOT NULL,
  `reorder` int(11) NOT NULL DEFAULT '0',
  `member` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `unit_tbl`
--

INSERT INTO `unit_tbl` (`unit_id`, `unid`, `unit_group`, `parent_unit`, `category`, `steps`, `unit_name`, `reorder`, `member`) VALUES
(2, 'CF526D833579B57A48256B350004479B', 4, 0, 3, '5', '市委', 999, 18),
(3, '2130C38256F9A2C148256B3500044B78', 0, 0, 1, '1235', '市人大', 995, 11),
(4, 'E62E93CB19F0697148256B33001EFBBF', 0, 0, 3, '5', '市政府', 990, 20),
(5, '49267039E9D79F5E48256B3500044E59', 0, 0, 2, '1235', '市政协', 985, 10),
(6, '03122FDE5FC2ACC848256B38000E37E2', 0, 0, 3, '5', '开发区管委会', 983, 66),
(7, 'CF2B3867AA1A4E6A48256B380041F93F', 0, 0, 3, '5', '市人武部', 980, 2),
(8, '9A4876520F27D7BF48256B380041BAED', 0, 0, 3, '45', '市委办', 975, 73),
(9, 'CDE42145B76E64FA48256B380045BD15', 0, 0, 1, '5', '市人大办', 970, 43),
(10, '6BEC2EB75030204448256B330021ABB0', 0, 0, 3, '45', '市府办', 965, 88),
(11, 'F7588B139F2A3DF248256B380045C978', 0, 0, 2, '1235', '市政协办', 960, 28),
(12, 'FF0B3F3933577D8448256B3800100663', 0, 0, 3, '5', '市检察院', 955, 13),
(13, 'DE05918B113DE28D48256B3800101332', 0, 0, 3, '45', '市法院', 950, 25),
(14, '26A3ECA4B5D6D4EA48256B9000349E9E', 0, 0, 3, '5', '市委部门（群团）', 947, 0),
(15, '301F217E57A1DF3148256B380045AEF4', 0, 14, 3, '5', '市纪委（监察局）', 945, 62),
(16, '31C27BFFB49FD82048256B38000F25F8', 0, 14, 3, '5', '市委组织部', 940, 31),
(17, '63E5B5BC87443F0948256B38000FA7A6', 0, 14, 3, NULL, '市委宣传部', 935, 30),
(18, '960C0E4406089C5248256B380045D29E', 0, 14, 3, NULL, '市委统战部（侨办、台办）', 930, 18),
(19, '4A0A248E3D870DD048256D79000DB10C', 0, 37, 3, NULL, '市民族宗教局', 838, 7),
(20, '685D945B698A7F5948256B38000FF5C7', 0, 14, 3, NULL, '市委政法委', 925, 25),
(21, '2BFF851B4D78EC1148256B7D0046C1D5', 0, 14, 3, NULL, '市委政研室', 920, 3),
(22, '2230CE8FC1D4EDB348256F8E00288137', 0, 14, 3, NULL, '市农办', 919, 16),
(23, '41C5ECFF53F16C3048256B38000F62E6', 0, 14, 3, NULL, '市机关党工委', 915, 9),
(24, '7B589F4D5CF9EC2248256B38000F5997', 0, 14, 3, NULL, '市委老干部局', 910, 9),
(25, 'AFD352908721AB4148256B7D00477F3B', 0, 14, 3, NULL, '市委党研室（市志办）', 905, 1),
(26, '53350E44BF4BD40748256B38000F3CCA', 0, 14, 3, NULL, '市委党校', 900, 13),
(27, 'F3733C45D62FE93548256B38000FD6B9', 0, 14, 3, NULL, '慈溪日报社', 895, 10),
(28, '0CFF7BCF1E5E5E2748256B380045F5D8', 0, 14, 3, NULL, '市档案局', 890, 14),
(29, 'EE2E8BF138D1315E48256B38000F4502', 0, 14, 3, NULL, '市总工会', 885, 23),
(30, '2D1908429F19B52E48256B38000F4C1B', 0, 14, 3, NULL, '团市委', 880, 11),
(31, 'F619713FD126E8F148256B38000F52BD', 0, 14, 3, NULL, '市妇联', 875, 9),
(32, '6E04A3A08646497948256B7D004B32BC', 0, 14, 3, NULL, '市工商联', 870, 6),
(33, '6EC6084A2630A77C48256B38000EB173', 0, 14, 3, NULL, '市残联', 865, 10),
(34, 'AB7AE4E531ABCE6948256BE6000B99AC', 0, 14, 3, NULL, '市科协', 864, 11),
(35, '8EF07284CD6439B64825750E0005CC74', 0, 14, 3, NULL, '市文联', 864, 11),
(36, '90F120558B842D1148256CE000247368', 0, 14, 3, NULL, '市委机要局', 862, 1),
(37, 'A8285D4CC9D8371948256B900034D4C2', 0, 0, 3, NULL, '政府部门（单位）', 860, 0),
(38, 'E8E1BECC158A930B48256FD90003DA1E', 0, 37, 3, NULL, '市发展改革局', 857, 34),
(39, 'AE0954AC7D5DB72748256B38001059E7', 0, 37, 3, NULL, '市统计局', 748, 40),
(41, 'FFBA988CB10543CC48256B7D00482ABF', 0, 37, 3, NULL, '市经信局', 850, 28),
(42, '7DAD3FFD07DF6CB548256F6B0025AA54', 0, 37, 3, NULL, '市安监局', 733, 21),
(43, '61E9D410F8E7F41548256B7D00487819', 0, 37, 3, NULL, '市教育局', 845, 32),
(44, '64BA4378A97B4C3848256B7D0048B6FC', 0, 37, 3, NULL, '市科技局', 840, 18),
(45, '681289C27CF0E18248256B38000FFBDA', 0, 37, 3, NULL, '市公安局', 835, 22),
(46, '222987887080989E482573930008CCDB', 0, 37, 3, NULL, '市流动人口局', 690, 9),
(47, '571B34206C9BED4748256B38000E51E6', 0, 37, 3, NULL, '市民政局', 830, 40),
(48, '7A3BFCFBBEBB45C8482571C40029BBEE', 0, 37, 3, NULL, '市慈善总会', 688, 12),
(49, '151C44C8ACE42E9748256D6C00038C1C', 0, 37, 3, NULL, '市老龄委（办）', 689, 5),
(50, 'A3002459A7BE822948256B3800101FB3', 0, 37, 3, NULL, '市司法局', 825, 19),
(51, '01ECF55022B1AE9C48256B38000E6310', 0, 37, 3, NULL, '市财政地税局', 820, 40),
(53, '33A409DF848AF73748256B7D004939B6', 0, 37, 3, NULL, '市人力社保局', 810, 42),
(54, '0F7C38A58F8DC20348256B7D00496843', 0, 37, 3, NULL, '市国土资源局', 805, 40),
(55, 'F91DF57AA990F2E548256B7D00497C9A', 0, 37, 3, NULL, '市住建局', 795, 39),
(56, '24C556A96E70572F48256B38001032C1', 0, 37, 3, NULL, '市规划局', 800, 25),
(57, '82C1AB87A996466848256B3800109CFB', 0, 37, 3, NULL, '市交通运输局', 790, 56),
(58, '3988ED4FF80DC81648256B3800242FB8', 0, 37, 3, NULL, '市农业局', 780, 39),
(59, '8813A6E04022871448256B380024366F', 0, 37, 3, NULL, '市水利局', 785, 33),
(60, 'EED63203024C248548256B7D004A5C0D', 0, 37, 3, NULL, '市商务局', 775, 29),
(62, 'ED5FD1D41CB2001848256B7D004AA772', 0, 37, 3, NULL, '市文广局', 765, 42),
(63, '2AA96CEA8756C4FD48256B38000FCDE9', 0, 37, 3, NULL, '市卫生和计划生育局', 760, 29),
(65, '8260B038230A843D48256B38000E57CD', 0, 37, 3, NULL, '市审计局', 750, 37),
(66, '97273DFB7EA1401E48256B3800105FDF', 0, 37, 3, NULL, '市环保局', 803, 25),
(67, '2B72C7A00214CC4D48256B38000EDACD', 0, 14, 3, NULL, '市信访局', 888, 13),
(68, 'B85DC582EFBC3A9E48256B38000EBB00', 0, 37, 3, NULL, '市国税局', 730, 17),
(72, '5E5B22701818934348256B7D004B0713', 0, 37, 3, NULL, '市广播电视台', 710, 15),
(73, '10CD3A8E53C167B648256B380024498B', 0, 37, 3, NULL, '市农机局', 705, 10),
(74, '770F5C1B441E98B748256B38000EF46B', 0, 37, 3, NULL, '市旅游局', 700, 13),
(75, 'BDDB8B2169D79F1C48256B38000E248E', 0, 37, 3, NULL, '市综合行政执法局（市城管局）', 793, 31),
(76, 'E59E4A530159F2A448256B38000E14E8', 0, 37, 3, NULL, '市行政服务中心', 685, 13),
(77, '3D25E8789FAEFF0C48256B38000EEBC7', 0, 37, 3, NULL, '市机关事务管理局', 684, 24),
(78, '0522ED272F491E2748256DC50009C40E', 0, 37, 3, NULL, '市公建中心', 683, 10),
(80, 'D246F86214F8BA5C48256B38001066B2', 0, 37, 3, NULL, '市国资局', 681, 10),
(81, '558969753372AF2D482570FC00274B6C', 0, 37, 3, NULL, '市公共资源交管办', 680, 11),
(82, 'ACDD346EBC1F61C748256EBA000BD745', 0, 37, 3, NULL, '慈溪滨海经济开发区', 679, 25),
(83, 'E5985F587FB18F4F4825749800028532', 0, 37, 3, NULL, '市环杭州湾创新中心', 657, 17),
(84, 'F1B0BA5DFC6411724825750E0005E733', 0, 37, 3, NULL, '市金融办', 676, 3),
(86, 'F340C371EA6EF78F48256B410003E5ED', 0, 37, 3, NULL, '市气象局', 672, 2),
(87, 'A3F825908FFB1F1848256B38000EC462', 0, 37, 3, NULL, '市海关办事处', 670, 1),
(89, '29A5C3FDA5F2FEB548256B3800108C97', 0, 37, 3, NULL, '市检验检疫局', 667, 2),
(90, '06189EE33378877E48256B380010B23A', 0, 37, 3, NULL, '市盐务局', 666, 1),
(91, '172FAFCEB2B13E7E48256B38000DA3CE', 0, 37, 3, NULL, '市供电局', 665, 2),
(92, '30260D251D4C9F8548256B380024738D', 0, 37, 3, NULL, '市农合联执委会（市供销社)', 664, 16),
(93, '32280270CF1B655E48256B3800249101', 0, 37, 3, '5', '市人民银行', 663, 1),
(94, 'C98D529A2FE33FC848256B380010C5C2', 0, 37, 3, NULL, '市邮政局', 661, 2),
(95, '5ADB17264AC1F1EA48256B38000D95AB', 0, 37, 3, NULL, '市电信局', 660, 2),
(96, '6BA6FD732EE3FEC148256B3800246AD5', 0, 37, 3, NULL, '市烟草局', 659, 1),
(98, 'D305878AE0DB5D05482575A70006C16B', 0, 37, 3, NULL, '市鸣鹤风景区开发建设办', 658, 7),
(99, '2BDCA128986DBAF8482575C100216AB2', 0, 37, 3, NULL, '市现代农业开发区管委会', 658, 12),
(100, 'EA81D9C2E7C56C3048256E9F0002FFFA', 0, 0, 3, NULL, '临时机构', 648, 0),
(105, '918D95FC8440483B482571BD002ABE36', 0, 100, 3, NULL, '市食安办', 644, 1),
(109, '872E3FECABACA56048256B900034EF45', 0, 0, 3, NULL, '其他单位', 640, 0),
(110, '7F697C2BAF8CA4A048256BA8002B7312', 0, 109, 3, NULL, '市移动分公司', 615, 1),
(111, 'B08FE6DC5251B27248256EF300260391', 0, 109, 3, NULL, '联通慈溪分公司', 613, 1),
(114, 'E91E8283525AD94548256B3800249885', 0, 109, 3, '5', '市工商银行', 580, 1),
(115, 'DFE03BCAABAD38CA48256B3800249F5E', 0, 109, 3, '5', '市农业银行', 575, 1),
(116, '9183B60D6D750EA448256B380024A8DA', 0, 109, 3, '5', '市农发银行', 570, 1),
(117, 'FDD97E22151AEAE048256B380024B223', 0, 109, 3, '5', '市建设银行', 565, 2),
(118, 'A57342F8251DCDA948256C290030BE84', 0, 109, 3, '5', '市交通银行', 560, 1),
(119, '8BA476F52352455B4825736F002CE047', 0, 109, 3, '5', '市交通银行新城支行', 559, 1),
(120, 'D16ED45C3284CF6448256B380024B955', 0, 109, 3, '5', '市中国银行', 555, 1),
(121, '38227E152462D50848256E8F000D555F', 0, 109, 3, '5', '市中信实业银行', 553, 2),
(122, '7A294E7C6846C08E48256B380024D0C9', 0, 109, 3, '5', '慈溪农村商业银行', 545, 1),
(123, '529CFE874ECDDEBE48256B380024D8BC', 0, 109, 3, NULL, '浦发行支行', 540, 1),
(124, '1E40BCDEF08F95F248256EA6002BA154', 0, 109, 3, '5', '市深发银行', 537, 1),
(125, 'EF2CE54F397A804F48256BA8002B864D', 0, 109, 3, '5', '宁波银行慈溪支行', 536, 1),
(126, '68BF4B1D9F43CC634825735D00096028', 0, 109, 3, '5', '市民生银行', 534, 1),
(127, '7E308DBD2ADEA5084825736400117F76', 0, 109, 3, '5', '浙商银行', 533, 1),
(128, '18016D93B365A2DF482573DA00219943', 0, 109, 3, '5', '市招商银行', 532, 1),
(129, '44E4EE5D7002E41E482573F00024A88D', 0, 109, 3, NULL, '市兴业银行', 531, 1),
(130, '7BA70DBAD6E55F2B4825741A000A1018', 0, 109, 3, NULL, '慈溪邮政储蓄银行', 530, 1),
(131, 'B2880C0C4E909363482575620010AB17', 0, 109, 3, NULL, '上海银行', 529, 1),
(132, '8AB691027A4D2B674825758A0027BD6B', 0, 109, 3, NULL, '光大银行', 528, 1),
(133, 'FC0959760A5D425E48256EED0026052C', 0, 109, 3, NULL, '市人保公司', 521, 1),
(134, 'F7202416FC23010A48256B380024E8A6', 0, 109, 3, NULL, '市人寿公司', 521, 1),
(135, 'CB54EC729571CC6048256B380024EF0A', 0, 109, 3, NULL, '市太保产险公司', 520, 1),
(136, '81A9EDF42ABB686048256B380024F784', 0, 109, 3, NULL, '市太保人寿公司', 518, 1),
(137, '00FE5818A3F445E648256D390021D98A', 0, 109, 3, NULL, '市大众保险公司', 517, 1),
(138, '7C16C0C2EE525E9E48256EFA00289714', 0, 109, 3, NULL, '市天安保险公司', 516, 1),
(139, '63A94CDA6A8C77DB48256EED0025D204', 0, 109, 3, NULL, '中华保险慈溪支公司', 515, 1),
(140, 'D55927728FB1D8C2482574D2000CD82B', 0, 109, 3, NULL, '阳光保险', 514, 1),
(141, 'F79FB7BE8C47EFE9482573CB0008041E', 0, 109, 3, NULL, '市保险协会', 512, 1),
(142, 'A6CBE705734E74EC482573D900246949', 0, 109, 3, NULL, '市老年人体育协会', 510, 1),
(143, '46FA09552DC9B7A648256B8400278081', 0, 0, 3, NULL, '各镇（街道）', 508, 0),
(144, '35C89BE3D6D41FB048256B38004075EE', 0, 143, 3, NULL, '龙山镇', 507, 76),
(145, 'D69BF7623F043EC448256B380040933A', 0, 143, 3, NULL, '掌起镇', 495, 38),
(146, '3257947222C3BA0048256B3800409D92', 0, 143, 3, NULL, '观海卫镇', 490, 54),
(147, '6A5B6FFCB9D3D4CF48256B380040A9C8', 0, 143, 3, NULL, '附海镇', 485, 41),
(148, '84591E80B5F6E28F48256B380040B118', 0, 143, 3, NULL, '逍林镇', 480, 44),
(149, 'A9D85F6852DC2F9548256B380040B833', 0, 143, 3, NULL, '胜山镇', 475, 48),
(150, '6B42E8EFB032402148256B380040BE53', 0, 143, 3, NULL, '新浦镇', 470, 49),
(151, '57A84187C1D32CDB48256B380040CD29', 0, 143, 3, NULL, '桥头镇', 465, 45),
(152, '94E63B745773139148256B380040D33D', 0, 143, 3, NULL, '匡堰镇', 460, 46),
(153, '9D86FFEEC0CFE97248256B380040DF58', 0, 143, 3, NULL, '横河镇', 455, 59),
(154, '8CE25D78DA76172C48256B380040E7ED', 0, 143, 3, NULL, '崇寿镇', 450, 62),
(156, 'EF0ACC94A197FC7248256B380040F84A', 0, 143, 3, NULL, '长河镇', 440, 41),
(157, 'C553E6B90C6A74F948256B3800410886', 0, 143, 3, '15', '庵东镇', 435, 28),
(158, 'C72FE29700A118D748256B3800411060', 0, 143, 3, NULL, '周巷镇', 430, 51),
(159, 'D32E1863B316FFA2482574740029531A', 0, 143, 3, NULL, '古塘街道', 428, 45),
(160, '7438DAE13E93E76848256B38004118BB', 0, 143, 3, NULL, '浒山街道', 425, 38),
(161, '525EEF9C22939CC4482574780025B4AA', 0, 143, 3, NULL, '白沙路街道', 423, 46),
(162, '4AE5F470FE621F7A48256B3800412168', 0, 143, 3, NULL, '宗汉街道', 420, 43),
(163, 'B106F57D08A97CE648256B3800412BA2', 0, 143, 3, NULL, '坎墩街道', 415, 34),
(164, 'FD0F8C548CF5A7A0482575FA00014A14', 0, 109, 3, NULL, '齐鲁证券', 509, 1),
(166, 'E339A870B5F6BE2848257639000CBEF9', 0, 109, 3, NULL, '市广发银行', 527, 1),
(167, '357BDB7CA3B3CA3D4825766C0006361C', 0, 37, 3, NULL, '银监局慈溪办', 662, 2),
(168, '5CF086CA818FAF79482576A1002EC43A', 0, 109, 3, NULL, '市村镇银行', 526, 1),
(169, '63244F0759EC485A482576A1002EE14C', 0, 109, 3, NULL, '泰隆商业银行', 525, 2),
(170, '40383A3076AA6AB3482576A1002EF662', 0, 109, 3, NULL, '中国银行宁波余慈支行', 525, 1),
(171, '8BBC379D26EF8E03482576B8000FB809', 0, 109, 3, NULL, '市家电企业联合会', 513, 1),
(172, '73FD38055B58DAAE482576C7000D43D7', 0, 37, 3, NULL, '市城南改造建设指挥部', 656, 9),
(173, '65F4BF9FD7CCC3264825770C00080B75', 0, 37, 3, NULL, '慈溪高新技术产业开发区管理委员会', 656, 12),
(174, 'C62791AA493A99FF4825775900028FB0', 0, 109, 3, NULL, '临商银行', 524, 1),
(176, '9D53E55377324B3B48257769000807C4', 0, 109, 3, NULL, '华夏银行宁波慈溪支行', 523, 1),
(177, 'B3CC3B2C29C6B9154825776900081C36', 0, 109, 3, NULL, '温州银行宁波慈溪支行', 523, 1),
(178, '51B09BD80D914D34482577ED0026C904', 0, 109, 3, NULL, '杭州银行宁波慈溪支行', 522, 1),
(179, 'C4079C9837A4E4D94825782400127F16', 0, 109, 3, NULL, '光大证券', 509, 1),
(180, '3CECE680282A72E848257887002B208F', 0, 37, 3, NULL, '市新潮塘改造建设指挥部', 656, 8),
(181, '424B48E07785BB544825788E0008DC06', 0, 109, 3, NULL, '宁波银行城东支行', 535, 1),
(183, '159302C1991537D048257912002A40F0', 0, 37, 3, NULL, '市招商局', 659, 13),
(184, '837D8D26010B8D134825792600045DF4', 0, 14, 3, NULL, '市编委办', 914, 12),
(185, '4E5C0AD2039FB8C24825792C00065002', 0, 37, 3, NULL, '市景观大道改造指挥部', 654, 6),
(186, '20B8DAFD7F1923F24825795E002C4B04', 0, 109, 3, NULL, '浙江民泰商业银行宁波慈溪支行', 523, 1),
(187, '0777DFEB9640E4C6482579680006EADF', 0, 109, 3, NULL, '人保财险余慈支公司', 514, 1),
(188, '1B9224F267F7036C482579DE002F1E4E', 0, 37, 3, NULL, '市建设集团', 654, 12),
(189, 'AA12BDCD8DC8273248257A5900319656', 0, 37, 3, NULL, '慈溪市银行业协会', 661, 0),
(190, '998D64EED976BF1148257A64000DA880', 0, 14, 3, NULL, '市关工委', 908, 1),
(191, 'F474F99106241E4A48257A67002B1B4F', 0, 0, 3, '5', '市决策咨询委', 984, 6),
(192, 'FA40A3CEEB27C48748257A6A00065A2B', 0, 37, 3, '5', '市商品市场物流园区管委会', 654, 8),
(193, '5F6FAABB0627907748257ADB00091DEA', 0, 14, 3, '5', '市红十字会', 863, 3),
(194, 'AA725B96AE8C912E48257AE90030F9B4', 0, 37, 3, NULL, '市水务集团有限公司', 654, 22),
(195, '329B359E0AEB920D48257AFD00300FAD', 0, 37, 3, NULL, '市新城河区块改造建设指挥部', 654, 7),
(196, 'C4B1ECD713E274F548257B0300052B71', 0, 37, 3, NULL, '市海涂综合开发有限公司', 653, 7),
(197, 'F79A61E02CA6F4AC48257B4A002847D7', 0, 100, 3, NULL, '“三改一拆”领导小组办公室', 642, 0),
(198, 'FD2F9E279333660348257B4A002883B5', 0, 109, 3, NULL, '台州银行宁波分行', 522, 1),
(199, '143D65E39333886648257B4A00289D75', 0, 109, 3, NULL, '稠州银行慈溪支行', 522, 1),
(200, 'AEC90BD66D2DB1B548257B9600300842', 0, 109, 3, NULL, '市建信村镇银行', 522, 1),
(201, '32EB6A18B58DD90348257BB3000D4875', 0, 109, 3, NULL, '渣打银行慈溪支行', 522, 1),
(202, 'C56949D1B317EE3C48257BC20009AEEA', 0, 100, 3, NULL, '市水环境综治办', 641, 15),
(203, 'E5C46E03D0C9BBE448257BC700061F63', 0, 37, 3, NULL, '市商贸集团有限公司', 652, 13),
(204, '4C3E3E0CA1025A3948257C22002A07C5', 0, 37, 3, NULL, '市房屋征管办', 651, 10),
(205, '702CCD8AA9B8126F48257C900021D487', 0, 109, 3, NULL, '宁波东海银行慈溪支行', 521, 1),
(206, '8BDAA722BDB095B848257C9900229A4A', 0, 14, 3, NULL, '慈溪市新四军研究会', 906, 1),
(207, '8AF0D40DE5FB3C4048257CB5002E59C8', 0, 109, 3, NULL, '宁波通商银行慈溪支行', 521, 1),
(208, 'B9475852D15E746148257D030005062C', 0, 37, 3, NULL, '市市场监管局', 735, 72),
(209, 'DCF9FC8241ABF19F48257D7B0014A963', 0, 100, 3, NULL, '市调处办', 641, 5),
(210, 'B9773B9D10814E6948257DBD000C2664', 0, 100, 3, NULL, '市合用场所整治办', 641, 1),
(211, '53B560CA93F4EDDD48257DBE002B0B75', 0, 109, 3, NULL, '工商银行杭州湾新区支行', 521, 1),
(212, 'EA7871C9ADFC7A3348257E04000D4CDA', 0, 100, 3, '5', '海事办', 641, 1),
(213, 'A37273C9CCFE341448257E7D002B67F4', 0, 100, 3, NULL, '市污水纳管和超标排放整治办', 641, 1),
(214, '5EF5D3463C2B545A48257EC40026AE42', 0, 109, 3, NULL, '恒丰银行宁波慈溪支行', 521, 1),
(215, 'EA2F42C03C32B50D48257F5E00084561', 0, 100, 3, NULL, '市创卫办', 641, 0),
(216, '1C662FE66B17C6E248257F840025D7F7', 0, 37, 3, NULL, '慈溪医工所', 650, 1),
(217, '34BA6699ED398BA248257F840025EA9E', 0, 37, 3, NULL, '中科院慈溪中心', 650, 1),
(218, '6B5CD82C0EB8B05348257FC50029A98B', 0, 37, 3, NULL, '市交通集团', 650, 19),
(219, '833A1135CEA8A70548257FE7002B23BE', 0, 37, 3, NULL, '市旅游集团', 650, 10),
(220, '85EBFD2BC8EB9D1B4825804700246B87', 0, 109, 3, NULL, '市老龄基金会', 510, 4),
(221, '3C8097EFA45C8B7448258052000D2ED2', 0, 109, 3, NULL, '包商银行宁波慈溪支行', 521, 1),
(222, 'FC1E095C85700183482580AB002AEA04', 0, 100, 3, NULL, '市小城镇整治办', 641, 7);

-- --------------------------------------------------------

--
-- 表的结构 `user_group_tbl`
--

CREATE TABLE `user_group_tbl` (
  `user_group_id` int(11) NOT NULL,
  `user_group_name` varchar(20) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user_group_tbl`
--

INSERT INTO `user_group_tbl` (`user_group_id`, `user_group_name`, `category`) VALUES
(1, '中共界', 2),
(2, '民主党派人士界', 2),
(3, '无党派人士界', 2),
(4, '工商联界', 2),
(5, '共青团青联界', 2),
(6, '总工会界', 2),
(7, '妇联界', 2),
(8, '科技科协界', 2),
(9, '侨联界', 2),
(10, '台联界', 2),
(11, '文体新闻界', 2),
(12, '社会科学界', 2),
(13, '经济界', 2),
(14, '农业和农村界', 2),
(15, '教育界', 2),
(16, '医卫界', 2),
(17, '社会福利和社会保障界', 2),
(18, '民族宗教界', 2),
(19, '特邀界', 2),
(20, '第一代表团', 1),
(21, '第二代表团', 1),
(22, '第三代表团', 1),
(23, '第四代表团', 1),
(24, '第五代表团', 1),
(25, '第六代表团', 1),
(26, '第七代表团', 1),
(27, '第八代表团', 1);

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
  `password` varchar(40) NOT NULL,
  `party` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user_tbl`
--

INSERT INTO `user_tbl` (`user_id`, `user_name`, `user_phone`, `id_card`, `mail`, `address`, `password`, `party`) VALUES
(1, '测试用户', '1234567', NULL, NULL, NULL, '123', NULL),
(2, '测试用户2', '34434343', NULL, NULL, NULL, '123', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `user_unit_tbl`
--

CREATE TABLE `user_unit_tbl` (
  `user_unit_id` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `user_unit_name` varchar(20) NOT NULL,
  `unit` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `user_unit_tbl`
--

INSERT INTO `user_unit_tbl` (`user_unit_id`, `category`, `user_unit_name`, `unit`) VALUES
(1, 2, '白沙街道', NULL),
(2, 1, '白沙街道', NULL),
(3, 1, '庵东镇', NULL),
(4, 2, '庵东镇', NULL);

-- --------------------------------------------------------

--
-- 表的结构 `zx_motion_tbl`
--

CREATE TABLE `zx_motion_tbl` (
  `zx_motion` int(11) NOT NULL,
  `motion` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- 转存表中的数据 `zx_motion_tbl`
--

INSERT INTO `zx_motion_tbl` (`zx_motion`, `motion`) VALUES
(1, 2),
(2, 3),
(3, 6),
(4, 7);

-- --------------------------------------------------------

--
-- 视图结构 `attr_view`
--
DROP TABLE IF EXISTS `attr_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `attr_view`  AS  select `a`.`attr_id` AS `attr_id`,`a`.`motion` AS `motion`,`a`.`motion_attr` AS `motion_attr`,`a`.`attr_template` AS `attr_template`,`a`.`content` AS `content`,`a`.`content_int` AS `content_int`,`a`.`attachment` AS `attachment`,`a`.`staff` AS `staff`,`a`.`update_time` AS `update_time`,`b`.`attr_name` AS `attr_name` from (`attr_tbl` `a` left join `attr_template_tbl` `b` on((`a`.`attr_template` = `b`.`attr_template_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `duty_view`
--
DROP TABLE IF EXISTS `duty_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `duty_view`  AS  select `d`.`meeting_name` AS `meeting_name`,`d`.`start_time` AS `start_time`,`d`.`end_time` AS `end_time`,`d`.`deadline_time` AS `deadline_time`,`a`.`duty_id` AS `duty_id`,`a`.`user` AS `user`,`a`.`category` AS `category`,`a`.`meeting` AS `meeting`,`a`.`user_unit` AS `user_unit`,`a`.`user_group` AS `user_group`,`a`.`admin_type` AS `admin_type`,`a`.`activity` AS `activity`,`b`.`user_name` AS `user_name`,`b`.`user_phone` AS `user_phone`,`b`.`party` AS `party`,`c`.`user_unit_name` AS `user_unit_name`,`c`.`unit` AS `unit`,`e`.`user_group_name` AS `user_group_name` from ((((`duty_tbl` `a` left join `user_tbl` `b` on((`a`.`user` = `b`.`user_id`))) left join `user_unit_tbl` `c` on((`a`.`user_unit` = `c`.`user_unit_id`))) left join `meeting_tbl` `d` on((`a`.`meeting` = `d`.`meeting_id`))) left join `user_group_tbl` `e` on((`a`.`user_group` = `e`.`user_group_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `motion_attr_view`
--
DROP TABLE IF EXISTS `motion_attr_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_attr_view`  AS  select `b`.`attr_name` AS `attr_name`,`c`.`motion_template_name` AS `motion_template_name`,`d`.`step_name` AS `step_name`,`a`.`motion_attr_id` AS `motion_attr_id`,`a`.`motion_template` AS `motion_template`,`a`.`attr_template` AS `attr_template`,`a`.`default_value` AS `default_value`,`a`.`hidden` AS `hidden`,`a`.`value_type` AS `value_type`,`a`.`target` AS `target`,`a`.`value_sort` AS `value_sort`,`a`.`has_attachment` AS `has_attachment`,`a`.`multiple` AS `multiple`,`b`.`option` AS `option`,`a`.`step` AS `step` from (((`motion_attr_tbl` `a` left join `attr_template_tbl` `b` on((`a`.`attr_template` = `b`.`attr_template_id`))) left join `motion_template_tbl` `c` on((`a`.`motion_template` = `c`.`motion_template_id`))) left join `step_tbl` `d` on((`a`.`step` = `d`.`step_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `motion_for_index_view`
--
DROP TABLE IF EXISTS `motion_for_index_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_for_index_view`  AS  select `a`.`motion_id` AS `motion_id`,`a`.`meeting` AS `meeting`,`a`.`category` AS `category`,`a`.`motion_name` AS `motion_name`,`a`.`motion_template` AS `motion_template`,`a`.`user` AS `user`,`a`.`document` AS `document`,`a`.`step` AS `step`,`a`.`document_sha` AS `document_sha`,`a`.`upload_time` AS `upload_time`,`b`.`step_name` AS `step_name` from (`motion_tbl` `a` left join `step_tbl` `b` on((`a`.`step` = `b`.`step_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `motion_handler_view`
--
DROP TABLE IF EXISTS `motion_handler_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_handler_view`  AS  select `a`.`motion_handler_id` AS `motion_handler_id`,`a`.`motion` AS `motion`,`a`.`attr` AS `attr`,`a`.`unit` AS `unit`,`a`.`staff` AS `staff`,`a`.`receive_time` AS `receive_time`,`a`.`reply_time` AS `reply_time`,`a`.`contact_name` AS `contact_name`,`a`.`contact_phone` AS `contact_phone`,`a`.`phone` AS `phone`,`a`.`attachment` AS `attachment`,`b`.`unit_name` AS `unit_name`,`c`.`full_name` AS `full_name` from ((`motion_handler_tbl` `a` left join `unit_tbl` `b` on((`a`.`unit` = `b`.`unit_id`))) left join `staff_tbl` `c` on((`a`.`staff` = `c`.`staff_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `motion_inf_view`
--
DROP TABLE IF EXISTS `motion_inf_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_inf_view`  AS  select `a`.`motion_id` AS `motion_id`,`a`.`meeting` AS `meeting`,`a`.`category` AS `category`,`a`.`motion_name` AS `motion_name`,`a`.`motion_template` AS `motion_template`,`a`.`user` AS `user`,`a`.`duty` AS `duty`,`a`.`document` AS `document`,`a`.`step` AS `step`,`a`.`document_sha` AS `document_sha`,`a`.`upload_time` AS `upload_time`,`b`.`meeting_name` AS `meeting_name`,`b`.`start_time` AS `start_time`,`b`.`end_time` AS `end_time`,`b`.`deadline_time` AS `deadline_time` from (`motion_tbl` `a` left join `meeting_tbl` `b` on((`a`.`meeting` = `b`.`meeting_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `motion_view`
--
DROP TABLE IF EXISTS `motion_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `motion_view`  AS  select `a`.`motion_id` AS `motion_id`,`f`.`zx_motion` AS `zx_motion`,`a`.`meeting` AS `meeting`,`a`.`category` AS `category`,`a`.`motion_name` AS `motion_name`,`d`.`attr_id` AS `attr_id`,`a`.`motion_template` AS `motion_template`,`b`.`motion_attr_id` AS `motion_attr`,`c`.`attr_template_id` AS `attr_template`,`a`.`duty` AS `duty`,`a`.`document` AS `document`,`a`.`step` AS `step`,`e`.`step_name` AS `step_name`,`b`.`step` AS `attr_step`,`a`.`document_sha` AS `document_sha`,`a`.`upload_time` AS `upload_time`,`b`.`default_value` AS `default_value`,`b`.`value_type` AS `value_type`,`b`.`target` AS `target`,`b`.`value_sort` AS `value_sort`,`b`.`hidden` AS `hidden`,`c`.`attr_name` AS `attr_name`,`c`.`option` AS `option`,`d`.`content` AS `content`,`d`.`content_int` AS `content_int`,`b`.`has_attachment` AS `has_attachment`,`d`.`attachment` AS `attachment`,`b`.`multiple` AS `multiple` from (((((`motion_tbl` `a` left join `motion_attr_tbl` `b` on((`a`.`motion_template` = `b`.`motion_template`))) left join `attr_template_tbl` `c` on((`b`.`attr_template` = `c`.`attr_template_id`))) left join `attr_tbl` `d` on(((`a`.`motion_id` = `d`.`motion`) and (`b`.`motion_attr_id` = `d`.`motion_attr`)))) left join `step_tbl` `e` on((`a`.`step` = `e`.`step_id`))) left join `zx_motion_tbl` `f` on((`a`.`motion_id` = `f`.`motion`))) ;

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
-- 视图结构 `staff_admin_view`
--
DROP TABLE IF EXISTS `staff_admin_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `staff_admin_view`  AS  select `a`.`staff_id` AS `staff_id`,`a`.`out_id` AS `out_id`,`a`.`staff_unid` AS `staff_unid`,`a`.`unit` AS `unit`,`a`.`staff_name` AS `staff_name`,`a`.`full_name` AS `full_name`,`a`.`staff_phone` AS `staff_phone`,`a`.`staff_email` AS `staff_email`,`a`.`staff_password` AS `staff_password`,`a`.`steps` AS `steps`,`b`.`steps` AS `unit_steps`,`a`.`category` AS `category`,`a`.`user_admin` AS `user_admin`,`a`.`reorder` AS `reorder`,`b`.`unit_name` AS `unit_name`,`c`.`unit_id` AS `parent_unit`,`c`.`unit_group` AS `unit_group`,`c`.`unit_name` AS `parent_unit_name` from ((`staff_tbl` `a` left join `unit_tbl` `b` on((`a`.`unit` = `b`.`unit_id`))) left join `unit_tbl` `c` on((`b`.`parent_unit` = `c`.`unit_id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `sub_menu_view`
--
DROP TABLE IF EXISTS `sub_menu_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `sub_menu_view`  AS  select `f`.`id` AS `f_id`,`f`.`key_word` AS `f_key`,`f`.`name` AS `f_name`,`s`.`id` AS `s_id`,`s`.`key_word` AS `s_key`,`s`.`name` AS `s_name` from (`sub_menu_tbl` `s` left join `pms_tbl` `f` on((`s`.`parent_id` = `f`.`id`))) ;

-- --------------------------------------------------------

--
-- 视图结构 `unit_admin_view`
--
DROP TABLE IF EXISTS `unit_admin_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `unit_admin_view`  AS  select `a`.`unit_id` AS `unit_id`,`a`.`unid` AS `unid`,`a`.`unit_group` AS `unit_group`,`a`.`parent_unit` AS `parent_unit`,`a`.`category` AS `category`,`a`.`steps` AS `steps`,`a`.`unit_name` AS `unit_name`,`a`.`reorder` AS `reorder`,`a`.`member` AS `member`,`b`.`unit_name` AS `parent_name`,`c`.`unit_group_name` AS `unit_group_name` from ((`unit_tbl` `a` left join `unit_tbl` `b` on((`a`.`parent_unit` = `b`.`unit_id`))) left join `unit_group_tbl` `c` on((`a`.`unit_group` = `c`.`unit_group_id`))) ;

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
-- Indexes for table `staff_tbl`
--
ALTER TABLE `staff_tbl`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `staff_name` (`staff_name`),
  ADD UNIQUE KEY `out_id` (`out_id`);

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
  ADD PRIMARY KEY (`unit_id`),
  ADD UNIQUE KEY `unid` (`unid`);

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
-- Indexes for table `user_unit_tbl`
--
ALTER TABLE `user_unit_tbl`
  ADD PRIMARY KEY (`user_unit_id`);

--
-- Indexes for table `zx_motion_tbl`
--
ALTER TABLE `zx_motion_tbl`
  ADD PRIMARY KEY (`zx_motion`),
  ADD UNIQUE KEY `motion` (`motion`);

--
-- 在导出的表使用AUTO_INCREMENT
--

--
-- 使用表AUTO_INCREMENT `attr_tbl`
--
ALTER TABLE `attr_tbl`
  MODIFY `attr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;
--
-- 使用表AUTO_INCREMENT `attr_template_tbl`
--
ALTER TABLE `attr_template_tbl`
  MODIFY `attr_template_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;
--
-- 使用表AUTO_INCREMENT `category_tbl`
--
ALTER TABLE `category_tbl`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- 使用表AUTO_INCREMENT `duty_tbl`
--
ALTER TABLE `duty_tbl`
  MODIFY `duty_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `meeting_tbl`
--
ALTER TABLE `meeting_tbl`
  MODIFY `meeting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `motion_attr_tbl`
--
ALTER TABLE `motion_attr_tbl`
  MODIFY `motion_attr_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;
--
-- 使用表AUTO_INCREMENT `motion_handler_tbl`
--
ALTER TABLE `motion_handler_tbl`
  MODIFY `motion_handler_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- 使用表AUTO_INCREMENT `motion_tbl`
--
ALTER TABLE `motion_tbl`
  MODIFY `motion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;
--
-- 使用表AUTO_INCREMENT `staff_tbl`
--
ALTER TABLE `staff_tbl`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6730;
--
-- 使用表AUTO_INCREMENT `step_tbl`
--
ALTER TABLE `step_tbl`
  MODIFY `step_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- 使用表AUTO_INCREMENT `sub_menu_tbl`
--
ALTER TABLE `sub_menu_tbl`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
--
-- 使用表AUTO_INCREMENT `unit_group_tbl`
--
ALTER TABLE `unit_group_tbl`
  MODIFY `unit_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- 使用表AUTO_INCREMENT `unit_tbl`
--
ALTER TABLE `unit_tbl`
  MODIFY `unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=223;
--
-- 使用表AUTO_INCREMENT `user_group_tbl`
--
ALTER TABLE `user_group_tbl`
  MODIFY `user_group_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;
--
-- 使用表AUTO_INCREMENT `user_tbl`
--
ALTER TABLE `user_tbl`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- 使用表AUTO_INCREMENT `user_unit_tbl`
--
ALTER TABLE `user_unit_tbl`
  MODIFY `user_unit_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
--
-- 使用表AUTO_INCREMENT `zx_motion_tbl`
--
ALTER TABLE `zx_motion_tbl`
  MODIFY `zx_motion` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
