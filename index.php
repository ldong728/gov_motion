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
//    mylog(getArrayInf($_SESSION));
    //处理ajax
    if(isset($_POST['ajax'])){
        $ajaxData=isset($_POST['ajax_data'])?$_POST['ajax_data']:null;
        $_POST['ajax']($ajaxData);
        exit;
    }
    if(isset($_GET['get_meeting'])){
        getMeetingView($_GET['get_meeting']);
        exit;
    }
   getIndex();
}else{
    if(isset($_POST['user'])&&isset($_POST['password'])&&isset($_POST['category'])){
        mylog($_POST['category']);
        $category=$_POST['category'];
        userAuth($_POST['user'],$_POST['password'],$category);
        unset($_POST['password']);
//        mylog('login'.$category);
//        printView('login3');
        header('Location:index.php?c='.$category.'&error=password');
        exit;
    }else{
        global $category;
        $category =isset($_GET['c'])?$_GET['c']:3;
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
                printView('login3',$title);
                exit;
                break;

        }
        printView('login'.$category,$title);

    }
}