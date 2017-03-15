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
    if(isset($_GET)){

    }
   getIndex();
}else{
    if(isset($_POST['user'])&&isset($_POST['password'])){
        $category=$_POST['category'];
        userAuth($_POST['user'],$_POST['password'],$category);
        header('location:index.php?c='.$category.'&error=password');
        exit;
    }else{
        global $category;
        $category =$_GET['c'];
        switch($category){
            case 1:
                printView('p-con','人大登入-慈溪市人大代表议案建议系统');
                break;
            case 2:
                printView('p-mem','政协登入-慈溪市政协提案办理系统');
                break;
            case 3:
                printView('p-pro','登入-慈溪市人大政协议案提案办理系统');
                break;
            default:
                printView('login'.$category);
                break;
        }

    }
}