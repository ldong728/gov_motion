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
if($config['server_status']>0){
    echo '网站维护中，请稍后重试,状态码：'.$config['server_status'];
    exit;
}
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
    if(isset($_GET['statistics_excel_out'])){
        $totalList= handleStatistics(0, $_SESSION['staffLogin']['category']);
        include"view/statisticsOutExcel.html.php";
//        include"view/statistics_document.html.php";
        exit;
    }
    if(isset($_GET['download'])){
        mylog();
        include_once "downLoad.php";
        $_GET['download']();
    }
    if(isset($_FILES)){
        if(isset($_POST['file_type'])&&'excel'==$_POST['file_type']){
            encodeExcel();
        }

    }
   getIndex();
}else{
    if(isset($_POST['user'])&&isset($_POST['password'])&&isset($_POST['category'])){
        $category=$_POST['category'];
        userAuth($_POST['user'],$_POST['password'],$category);
        unset($_POST['password']);
        header('Location:index.php?c='.$category.'&error=password');
        exit;
    }else{
        global $category;
        $category =isset($_GET['c'])?$_GET['c']:3;
        if(isset($_GET['user'])&&isset($_GET['password'])){
            userAuth($_GET['user'],$_GET['password'],$category);
            header('Location:index.php?c='.$category.'&error=password');
            exit;
        }
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