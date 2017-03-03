<?php

include_once '../includePackage.php';
include_once 'menu.php';
session_start();
$num=15;
$getStr = '';
$page=isset($_GET['page'])? $_GET['page'] : 0;
$orderIndex=isset($_GET['index'])?$_GET['index']:'id';
$order=isset($_GET['order'])?$_GET['order']:'asc';
foreach ($_GET as $k => $v) {
    if ($k == 'page') continue;
    if ($k == 'index') continue;
    if ($k == 'order') continue;
    $getStr .= $k . '=' . $v . '&';
}
$getStr=rtrim($getStr,'&');
$filter=' order by '.$orderIndex.' '.$order.' '.'limit '.$num*$page.','.$num;
if (isset($_GET['logout'])) {//登出
    session_unset();
    include 'view/login.html.php';
    exit;
}
if (isset($_SESSION['login']) && DOMAIN == $_SESSION['login']) {
    if (isset($_GET['menu']) && array_key_exists($_GET['menu'], $_SESSION['pms'])) {
        $_GET['sub']();
        exit;
    }
    printAdminView('blank.html.php', '提案议案管理系统后台');
    exit;
} else {
    if (isset($_GET['login'])) {
        $name = $_POST['adminName'];
        $pwd = $_POST['password'];
        if ($_POST['adminName'] . $_POST['password'] == ADMIN . PASSWORD) {
            $_SESSION['login'] = DOMAIN;
            $_SESSION['operator_id'] = -1;
            printAdminView('blank.html.php', '提案议案管理系统后台');
        } else {
            $query = pdoQuery('operator_tbl',array('id'), array('name' => $name, 'md5' => md5($pwd)), ' limit 1');
            $op_inf = $query->fetch();
            if ($op_inf) {
                $_SESSION['login'] = DOMAIN;
                $_SESSION['operator_id'] = $op_inf['id'];
                printAdminView('blank.html.php', '提案议案管理系统后台');
                exit;
            } else {
                include 'view/login.html.php';
                exit;
            }

        }
        exit;
    }

    include 'view/login.html.php';
    exit;
}

function options(){
    global $pmsList,$subMenuList;
    $query=pdoQuery('sub_menu_view',null,null,null);
    foreach ($query as $row) {
        if(isset($row['s_id']))$subMenuList[]=$row;
    }

    $pmsList = pdoQuery('pms_tbl',null,null,null)->fetchAll();
    printAdminView('option.html.php','功能菜单');
}

function operator(){
    global $pmsList,$opList;
    $pms=pdoQuery('pms_tbl',null,null,null);
    foreach ($pms as $row) {
        $pmsList[$row['id']]=$row;
    }

    $op=pdoQuery('op_pms_view',null,null,null);
    foreach ($op as $row) {

        if(!isset($opList[$row['id']])){
            $opList[$row['id']]=$row;
            $opList[$row['id']]['pms']=$pmsList;
        }
        if($row['pms_id'])$opList[$row['id']]['pms'][$row['pms_id']]['checked']='checked';
    }
//    mylog(getArrayInf($opList));
    printAdminView('operator.html.php','操作员管理');

}


function motion_temp_edit(){
    if(!isset($_GET['id'])){
        motion_temp_list();
        exit;
    }
    global $attrList,$totalAttrList,$id;
    $id=$_GET['id'];
    $attrList=array();
    $filter='';
    if($_SESSION['operator_id']==-1){
        $query=pdoQuery('motion_attr_view',null,array('motion_template'=>$_GET['id']),null);
        foreach ($query as $row) {
               $values = $row;
                $optionArray = json_decode($row['option'], true);
                if (count($optionArray) > 0) {
                    $values['option'] = $optionArray;
                }
//                mylog(json_encode($list, JSON_UNESCAPED_UNICODE));

            $attrList[]=$values;
            $filter.=','.$row['motion_attr_id'];
        }
        $filter=''==$filter?'':' where attr_template_id not in('.trim($filter,',').')';
        $totalAttrList=pdoQuery('attr_template_tbl',array('attr_template_id','attr_name'),null,$filter);

//        global $currentMotionTemp,$currentMotionTempValueList,$id;
//        if(isset($_GET['id'])){
//            $step=pdoQuery('step_tbl',null,null,null)->fetchAll();
//            $query=pdoQuery('attr_template_tbl',null,array('motion_template'=>$_GET['id']),null);
//            foreach ($query as $row) {
//                $values=$row;
////                mylog($row['option']);
//                $optionArray=json_decode($row['option'],true);
//                if(count($optionArray)>0){
////                    mylog('has array');
////                    $values['option']=$optionArray;
//                    $values['option']=$optionArray;
//                }else{
////                    $values['default_value']=array('content'=>$row['default_value']);
//                }
//                $currentMotionTempValueList[]=$values;
//            }
//
//            $currentMotionTemp=null;
            printAdminView('motion_temp.html.php','模板编辑');
//        }else{
////            $currentMotionTemp=null;
////            printAdminView('motion_temp.html.php','模板编辑');
//        }
    }else{
        printAdminView('blank.html.php', '提案议案管理系统后台');
    }
   
}
function attr_temp_edit(){
    if($_SESSION['operator_id']==-1) {
        global $getStr, $page, $num, $count, $orderIndex, $order, $list,$step;
        $orderIndex = $orderIndex == 'id' ? 'attr_template_id' : $orderIndex;
        $filter = ' order by ' . $orderIndex . ' ' . $order . ' ' . 'limit ' . $num * $page . ',' . $num;
        $step=pdoQuery('step_tbl',null,null,null)->fetchAll();
        $query = pdoQuery('attr_template_tbl', null, null, null);
        foreach ($query as $row) {
            $values = $row;
            $optionArray = json_decode($row['option'], true);
            if (count($optionArray) > 0) {
                $values['option'] = $optionArray;
            }
            $list[] = $values;
//            mylog(json_encode($list, JSON_UNESCAPED_UNICODE));
        }
        $count = pdoQuery('attr_template_tbl', array('count(*) as count'), null, null)->fetch()['count'];
        printAdminView('attr_temp_edit.html.php', '议案提案管理系统后台');
    }else{
        printAdminView('blank.html.php','议案提案管理系统后台');
    }
}




//非sub菜单方法
function motion_temp_list(){
    global $list;
    if($_SESSION['operator_id']==-1){
        $list=pdoQuery('motion_template_tbl',null,null,null)->fetchAll();

        if(!isset($list))$list=array();
        printAdminView('motion_temp_list.html.php','议案提案管理系统后提');
    }else{
        printAdminView('blank.html.php','议案提案管理系统后台');
    }
}

function index_config(){
    global $getStr;
    $articleInf=pdoQuery('gd_article',array('art_id'),array('art_channel_id'=>-1),' limit 1');
    $articleId=$articleInf->fetch();
    header('location: controller.php?get_editor='.$articleId['art_id'].'&'.$getStr);

}
function about(){
    global $getStr;
    $articleInf=pdoQuery('gd_article_view',array('art_id'),array('cha_code'=>$_GET['sub']),' limit 1');
    $articleId=$articleInf->fetch();
    if(!$articleId)$articleId['art_id']=0;
    header('location: controller.php?get_editor='.$articleId['art_id'].'&'.$getStr);
}
function customer_photo(){
    global $getStr;
    global $page;
    global $num;
    global $list;
    global $count;
    $list=pdoQuery('gd_article_view',array('art_id','art_img','art_title','art_show','art_index'),array('cha_code'=>$_GET['sub']), ' order by art_add_time desc,art_index asc limit ' . $page * $num . ', ' .$num);
    $list=$list->fetchAll();
    $count=pdoQuery('gd_article_view',array('count(*) as count'),array('cha_code'=>$_GET['sub']),null);
    $count=$count->fetch()['count'];
    printAdminView('customer_photo_list.html.php');
}
function goods(){
    global $getStr;
    global $page;
    global $num;
    global $list;
    global $count;
    $list=pdoQuery('gd_article_view',array('art_id','art_more_img','art_title','art_show','art_index'),array('cha_code'=>$_GET['sub']), ' order by art_add_time desc,art_index asc limit ' . $page * $num . ', ' .$num);
    $list=$list->fetchAll();
    $count=pdoQuery('gd_article_view',array('count(*) as count'),array('cha_code'=>$_GET['sub']),null);
    $count=$count->fetch()['count'];
    printAdminView('goods_list.html.php');
}
function activities(){
    global $getStr;
    global $page;
    global $num;
    global $list;
    global $count;
    global $source;
    $list=pdoQuery('gd_article_view',array('art_id','art_img','art_title','art_show','art_index'),array('cha_code'=>$_GET['sub']), ' order by art_add_time desc,art_index asc limit ' . $page * $num . ', ' .$num);
    $list=$list->fetchAll();
    $count=pdoQuery('gd_article_view',array('count(*) as count'),array('cha_code'=>$_GET['sub']),null);
    $count=$count->fetch()['count'];
    $source=getConfig('../config/mainConfig.json')['activity_source'];
    printAdminView('activities_list.html.php');
}
