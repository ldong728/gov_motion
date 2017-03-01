<?php
//以下为测试公众号用
//define('APP_ID','wx03393af10613da23');
//define('APP_SECRET','40751854901cc489eddd055538224e8a');
//define('WEIXIN_ID','gh_964192c927cb');
//define('MCH_ID','now is null');
//define('KEY','now is null');
//define("TOKEN", "godlee");
//define('DOMAIN',"mmzrb");
//define('NOTIFY_URL',"now is null");
//define("DB_NAME","gshop_db");
//define("DB_USER","gshopUser");
//define("DB_PSW","cT9vVpxBLQaFQYrh");
//$mypath = $_SERVER['DOCUMENT_ROOT'] . '/'.DOMAIN;   //用于直接部署


define('ADMIN','admin');
define('PASSWORD','admin');
define("TOKEN", "godlee");
define('DOMAIN',"/gov_motion");
define('NOTIFY_URL',"now is null");
define('DB_IP','localhost');
define("DB_NAME","gov_motion_db");
define("DB_USER","root");
define("DB_PSW","");
$mypath = $_SERVER['DOCUMENT_ROOT'] .DOMAIN;   //用于直接部署


include_once $mypath . '/includes/magicquotes.inc.php';
include_once $mypath . '/includes/db.inc.php';
include_once $mypath . '/includes/helpers.inc.php';
//include_once $mypath.'/includes/db.class.php';
//include_once $mypath . '/includes/card_deal.php';
header("Content-Type:text/html; charset=utf-8");