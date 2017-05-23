<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/5/23
 * Time: 14:29
 */

function multiple_statistics(){
    $inf=array();
    $query=pdoQuery('s_duty_view',null,array('category'=>$_SESSION['staffLogin']['category']),null);
    foreach ($query as $row) {

    }

    include 'view/statistics_document.html.php';
    exit;
}