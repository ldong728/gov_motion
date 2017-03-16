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
    mylog(getArrayInf($_SESSION));
    //处理ajax
    if(isset($_POST['ajax'])){
        $ajaxData=isset($_POST['ajax_data'])?$_POST['ajax_data']:null;
        $_POST['ajax']($ajaxData);
        exit;
    }
    if(isset($_GET['get_meeting'])){

    }
   getIndex();
}else{
    if(isset($_POST['user'])&&isset($_POST['password'])){
        $category=$_POST['category'];
        userAuth($_POST['user'],$_POST['password'],$category);
        unset($_POST['password']);
        header('location:index.php?c='.$category.'&error=password');
        exit;
    }else{
        global $category;
        $category =$_GET['c'];
        $title='';
        switch($category){
            case 1:
                $title='人大登入-慈溪市人大代表议案建议系统';
                break;
            case 2:
               $title='政协登入-慈溪市政协提案办理系统';
                break;
            default:
                $title='登入-慈溪市人大政协议案提案办理系统';
                break;

        }
        printView('login'.$category,$title);

    }
}