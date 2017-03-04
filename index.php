<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2016/10/27
 * Time: 9:58
 */
include_once 'includePackage.php';
include_once 'functions.php';
session_start();

//global $get,$post,$session;
//$get=&$_GET;
//$post=&$_POST;
//$session=&$_SESSION;
if(isset($_SESSION['logInf'])){


}else{
    if(isset($_POST['user'])&&isset($_POST['password'])){

    }else{

    }
}