<?php
/**
 * Created by PhpStorm.
 * User: godlee
 * Date: 2015/11/3
 * Time: 23:20
 */
function printView($viewName,$title='提案议案处理系统'){
    include 'template/header.html.php';
    include 'view/'.$viewName.'.html.php';
}

