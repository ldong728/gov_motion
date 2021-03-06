<?php
include_once '../includePackage.php';
session_start();

if (isset($_SESSION['login'])&&DOMAIN==$_SESSION['login']) {

    if(isset($_POST['pms'])&&array_key_exists($_POST['pms'],$_SESSION['pms'])){
        if(isset($_POST['method'])){
            switch ($_POST['method']) {

                default:
                    $method=trim($_POST['method']);
                    $method($_POST['ajax_data']);
                    break;
            }
        }
        if (isset($_POST['alteTblVal'])) {//快速更改
            $altValues=array();
            foreach ($_POST['col_value'] as $k => $v) {
                $altValues[$k]=addslashes($v);
            }
            $data = pdoUpdate($_POST['tbl'].'_tbl', $altValues, array($_POST['index'] => $_POST['id']),' limit 1');
            if($data){
                echo ajaxBack(array('id'=>$data));
            }else{
                echo ajaxBack(null,1,'记录无法修改');
            }
            exit;
        }
        if (isset($_POST['deleteTblVal'])) {//快速删除
            try{
                pdoDelete($_POST['tbl'].'_tbl', $_POST['value'], ' limit 1');
                                echo ajaxBack();

            }catch(PDOException $e){
                echo ajaxBack(null,1,'记录无法修改');
            }
            exit;
        }
        if (isset($_POST['addTblVal'])) {//快速插入
            try{
                mylog('add');
                foreach ($_POST['value'] as $k=>$v) {
                    $value[$k]=addslashes($v);
                }
                $id=pdoInsert($_POST['tbl'].'_tbl', $value, $_POST['onDuplicte']);
                echo ajaxBack(array('id'=>$id));
            }catch(PDOException $e){
                echo ajaxBack(null,1,'记录无法修改');
            }
            exit;
        }
        if(isset($_POST['altConfig'])){//快速更改设置
            $path='../config/'.$_POST['name'].'.json';
            $config=getConfig($path);
            if(array_key_exists($_POST['key'],$config)){
                $config[$_POST['key']]=$_POST['value'];
                saveConfig($path,$config);
                echo ajaxBack();
            }else{
                echo ajaxBack(null,'3','不存在的设置项');
            }
            exit;
        }

    }else{
        echo ajaxBack(null,9,'无权限');
        exit;
    }
}
function syncInf($data){

    switch($data['type']){
        case 'staff':
            syncUser();
            break;
        case 'unit':
            syncDept();
            break;
    }
    echo ajaxBack('ok');
}
function getSubUnit($data){
    $id=$data['id'];
    $query=pdoQuery('unit_tbl',array('unit_id as id','unit_name as name'),array('parent_unit'=>$id),null)->fetchAll();
    echo ajaxBack($query);
}
function userGroupUnit($data){
    $category=$data['category'];
    $name=$data['name'];
    $query=pdoQuery('user_'.$name.'_tbl',array('user_'.$name.'_id as id','user_'.$name.'_name as name'),array('category'=>$category),null)->fetchAll();
    echo ajaxBack($query);
}
function reflashUnitList($data){
    $number=12;
    $orderby=$data['orderby'];
    $order=$data['order'];
    $start=$data['page']*$number;
    $filter="order by $orderby $order";
    $limit=" limit $start,$number";
    $where=null;
    if(isset($data['where'])&&$data['where']){//包含搜索限制条件

        $stepStr='';
        foreach ($data['where'] as $k=>$v) {
            if('steps'==$k){
                $stepStr='steps like "%';
                for($i=0;$i<strlen($v);$i++){
                    $stepStr.=$v[$i];
                }
                $stepStr.='%"';
            }elseif('unit_name'==$k){
                $stepStr='unit_name like "%'.$v.'%"';
            }else{
                if(!$where)$where=array($k=>$v);
                else $where[$k]=$v;
            }
        }
        if($where&&count($where)>0&&$stepStr)$filter='and '.$stepStr.$filter;
        else if($stepStr)$filter='where '.$stepStr.$filter;
    }
    $count=pdoQuery('unit_tbl',array('count(*) as count'),$where,$filter)->fetch()['count'];
    $query=pdoQuery('unit_tbl',null,$where,$filter.$limit)->fetchAll();
    $back['list']=$query;
    $back['count']=$count;
    $back['page']=ceil($count/$number);

    echo ajaxBack($back);
}
function reflashStaffList($data){
    $number=12;
    $orderby=$data['orderby'];
    $order=$data['order'];
    $start=$data['page']*$number;
    $filter="order by $orderby $order";
    $limit=" limit $start,$number";
    $where=null;
    if(isset($data['where'])&&$data['where']){//包含搜索限制条件

        $stepStr='';
        foreach ($data['where'] as $k=>$v) {
            if('steps'==$k){
                $stepStr='steps like "%';
                for($i=0;$i<strlen($v);$i++){
                    $stepStr.=$v[$i];
                }
                $stepStr.='%"';
            }elseif('full_name'==$k){
                $stepStr='full_name like "%'.$v.'%" or staff_name like "%'.$v.'%"';
            }else{
                if(!$where)$where=array($k=>$v);
                else $where[$k]=$v;
            }
        }
        if($where&&count($where)>0&&$stepStr)$filter='and '.$stepStr.$filter;
        else if($stepStr)$filter='where '.$stepStr.$filter;
    }
    $count=pdoQuery('staff_admin_view',array('count(*) as count'),$where,$filter)->fetch()['count'];
    $query=pdoQuery('staff_admin_view',null,$where,$filter.$limit)->fetchAll();
    $back['list']=$query;
    $back['count']=$count;
    $back['page']=ceil($count/$number);

    echo ajaxBack($back);
}

/*
 * select user_name,user_phone,address FROM duty_view where duty_id in (select content_int from motion_view where attr_name in ("提案人","领衔人","提案联系人") and motion_id in (select motion_id from motion_view where target="unit" and content_int=55))
 */
