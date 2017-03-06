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
if(isset($_SESSION['login'])){
    mylog();
    if(isset($_POST['ajax'])){
        mylog();
        $_POST['ajax']($_POST['ajax_data']);
        exit;
    }


    printView('index');
}else{
    if(isset($_POST['user'])&&isset($_POST['password'])){
        userAuth($_POST['user'],$_POST['password']);
        exit;
    }else{
        printView('login');
    }
}