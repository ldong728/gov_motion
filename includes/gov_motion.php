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

function syncDept(){
//     $data=file_get_contents('dept.xml');
    $data=file_get_contents('http://172.19.48.144:88/GetDept');
    $xmldata=decodeXml($data);
    $i=0;
    foreach ($xmldata as $row) {
        pdoInsert('unit_tbl',array('unit_id'=>$row->id,'unid'=>$row->unid,'parent_unit'=>$row->topid,'category'=>3,'unit_name'=>$row->name,'reorder'=>$row->reorder,'member'=>$row->member),'update');
    }

}

function syncUser(){
    $data=file_get_contents('user.xml');
//    $data=file_get_contents('http://172.19.48.144:88/GetUser');
    $xmldata=decodeXml($data);
    foreach ($xmldata as $row) {
        pdoInsert('staff_tbl',array('staff_id'=>$row->id,'staff_unid'=>$row->unid,'unit'=>$row->dept,'staff_name'=>$row->usid,'full_name'=>addslashes($row->name),'reorder'=>$row->reorder),'update');
    }

}

