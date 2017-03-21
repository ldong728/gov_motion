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
            $data = pdoUpdate($_POST['tbl'].'_tbl', array($_POST['col'] => addslashes($_POST['value'])), array($_POST['index'] => $_POST['id']),' limit 1');
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
function reflashUnitList($data){
    $number=15;
    $orderby=$data['orderby'];
    $order=$data['order'];
    $start=$data['page']*$number;
    $filter="order by $orderby $order limit $start,$number";
    $where=null;
    if(isset($data['where'])&&$data['where']){

        $stepStr='';
        foreach ($data['where'] as $k=>$v) {
            if('steps'==$k){
                $stepStr='steps like "%';
                for($i=0;$i<strlen($v);$i++){
                    $stepStr.=$v[$i];
                }
                $stepStr.='%"';
            }else{
                if(!$where)$where=array($k=>$v);
                else $where[$k]=$v;
            }
        }
        if($where&&count($where)>0)$filter='and '.$stepStr.$filter;
        else if($stepStr)$filter='where '.$stepStr.$filter;
    }
    $query=pdoQuery('unit_tbl',null,$where,$filter)->fetchAll();


    echo ajaxBack($query);

}
