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
if(isset($_SESSION['staffLogin'])){
    //处理ajax
    if(isset($_POST['ajax'])){
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
        $category=$_POST['category'];
        userAuth($_POST['user'],$_POST['password'],$category);
        exit;
    }else{
        printView('login');
    }
}