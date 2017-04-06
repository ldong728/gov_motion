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
    global $attrList,$totalAttrList,$id,$step,$motionTempName,$valueTypes,$targetList;
    $id=$_GET['id'];
    $attrList=array();
    $filter='';
    $motionTempName=null;
    if($_SESSION['operator_id']==-1){
        $step=pdoQuery('step_tbl',null,null,null)->fetchAll();
        $query=pdoQuery('motion_attr_view',null,array('motion_template'=>$_GET['id']),'order by value_sort desc,motion_attr_id asc');
        foreach ($query as $row) {
               $values = $row;
                $optionArray = json_decode($row['option'], true);
                if (count($optionArray) > 0) {
                    $values['option'] = $optionArray;
                }
            $attrList[]=$values;
            $filter.=','.$row['attr_template'];
            if(!$motionTempName)$motionTempName=$row['motion_template_name'];
        }
        $filter=''==$filter?'':' where attr_template_id not in('.trim($filter,',').')';
        $totalAttrList=pdoQuery('attr_template_tbl',array('attr_template_id','attr_name'),null,$filter);
        $valueTypes=array('string','int','time','index','attachment','mix');
        $targetList=array('duty','unit','staff','motion');

            printAdminView('motion_temp.html.php','模板编辑');
    }else{
        printAdminView('blank.html.php', '提案议案管理系统后台');
    }
   
}
function attr_temp_edit(){
    if($_SESSION['operator_id']==-1) {
        global $getStr, $page, $num, $count, $orderIndex, $order, $list;
        $orderIndex = $orderIndex == 'id' ? 'attr_template_id' : $orderIndex;
        $filter = ' order by ' . $orderIndex . ' ' . $order . ' ' . 'limit ' . $num * $page . ',' . $num;

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
function unit_step(){
    global $superUnit;
    $superUnit=pdoQuery('unit_admin_view',array('parent_unit as id','parent_name as name'),null,'where parent_unit!=0 group by parent_unit')->fetchAll();
    printAdminView('unit_step.html.php','单位流程权限控制');
//    $unitQuery=pdoQuery('unit_tbl',null,)
}
function staff_step(){
    global $superUnit;
    $superUnit=pdoQuery('unit_tbl',array('unit_id as id','unit_name as name'),array('parent_unit'=>0),null)->fetchAll();
    printAdminView('staff_step.html.php','操作员流程权限');
}
function add_steff(){
    global $superUnit;
    $superUnit=pdoQuery('unit_tbl',array('unit_id as id','unit_name as name'),array('parent_unit'=>0),null)->fetchAll();
    printAdminView('add_staff.html.php','添加操作员');
}

function meet_edit(){
    printAdminView('blank.html.php','添加操作员');
}
function user_manage(){


//    $unitQuery=pdoQuery('user_unit_tbl',array('user_unit_id as id','user_unit_name as name'),array('category'=>2),null);
//    foreach ($unitQuery as $row) {
//        $unit[$row['name']]=$row['id'];
//    }
//    $groupQuery=pdoQuery('user_group_tbl',array('user_group_id as id','user_group_name as name'),array('category'=>2),null);
//    foreach ($groupQuery as $row) {
//        $group[$row['name']]=$row['id'];
//    }
//    mylog(getArrayInf($unit));
//    mylog(getArrayInf($group));
//    $userQuery=pdoQuery('user_tbl',null,array('category'=>2),'group by user_unit ');
////    mylog(getArrayInf($userQuery));
//    foreach ($userQuery as $row) {
//        $value[]=array('user_name'=>$row['user_unit'].'联络委','category'=>2,'user_unit'=>$row['user_unit'],'user_group'=>'中共届');
//    }
//    mylog(getArrayInf($value));
//    pdoTransReady();
//    try{
//        foreach ($value as $row) {
//            mylog(getArrayInf($row));
//            $id=pdoInsert('user_tbl',$row);
//            if(!$id)throw new PDOException;
//            $data=array('user'=>$id,'category'=>2,'meeting'=>1,'user_unit'=>$unit[$row['user_unit']],'user_group'=>28,'activity'=>1);
//                mylog(getArrayInf($data));
//            pdoInsert('duty_tbl',$data);
//        }
//        pdoCommit();
//
//    }catch(PDOException $e){
//        mylog();
//        mylog($e->getMessage());
//        pdoRollBack();
//
//    }



//


//    $userList=pdoQuery('user_tbl',array('user_id','user_name','user_unit','user_group'),array('category'=>1),null);
//    foreach ($userList as $row) {
//        $value[]=array('category'=>1,'user_unit_name'=>$row['user_unit']);
//        $group=0;
//        if(in_array($unit[$row['user_unit']],array(725,726,715)))$group=20;
//        if(in_array($unit[$row['user_unit']],array(717,718,719)))$group=21;
//        if(in_array($unit[$row['user_unit']],array(721,732)))$group=22;
//        if(in_array($unit[$row['user_unit']],array(728,731)))$group=23;
//        if(in_array($unit[$row['user_unit']],array(722,727,729)))$group=24;
//        if(in_array($unit[$row['user_unit']],array(714,723,724)))$group=25;
//        if(in_array($unit[$row['user_unit']],array(720,730)))$group=26;
//        if(in_array($unit[$row['user_unit']],array(716)))$group=27;

//        $value[]=array('user'=>$row['user_id'],'category'=>1,'meeting'=>2,'user_unit'=>$unit[$row['user_unit']],'user_group'=>$group);
//    }
//    mylog(getArrayInf($value));
//    pdoBatchInsert('duty_tbl',$value);
    printAdminView('blank.html.php','添加操作员');
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
