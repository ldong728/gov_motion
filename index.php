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
mylog('index');
if(isset($_SESSION['staffLogin'])){
    //处理ajax
    if(isset($_POST['ajax'])){
        mylog();
        $ajaxData=isset($_POST['ajax_data'])?$_POST['ajax_data']:null;
        $_POST['ajax']($ajaxData);
        exit;
    }
//    if(isset($_GET['method'])){
//        $method=$_GET['method'];
//        if(in_array($method,array('')))
//    }


   getIndex();
}else{
    if(isset($_POST['user'])&&isset($_POST['password'])){
        userAuth($_POST['user'],$_POST['password']);
        exit;
    }else{
        printView('login');
    }
}