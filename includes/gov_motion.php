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
        pdoInsert('staff_tbl',array('out_id'=>$row->id,'staff_unid'=>$row->unid,'unit'=>$row->dept,'staff_name'=>$row->usid,'full_name'=>addslashes($row->name),'reorder'=>$row->reorder),'update');
    }
}
function getUserList(){
    if($_SESSION['staffLogin']['meeting']=='all')return null;
    if(isset($_SESSION['staffLogin']['userList'])){

        $query=pdoQuery('duty_view',array('duty_id as id','user_name as name'),$_SESSION['staffLogin']['userList'],null);
        $userList=$_SESSION['staffLogin']['category']==1?array('0'=>'选择人大代表'):array('0'=>'选择政协委员');
        foreach ($query as $row) {
            $userList[$row['id']]=$row['name'];
        }
        return array('class'=> 'attr-value user-selectr','list'=>$userList);
    }else{
        return 1==$_SESSION['staffLogin']['category']?array('class'=>'duty-group','list'=>array('0'=>'选择人大代表','unit'=>'按所属单位','group'=>'按代表团')):array('class'=>'duty-group','list'=>array('0'=>'选择政协委员','unit'=>'按委组','group'=>'按界别'));
    }
}
function getUnitList($parentId='all'){
    $id='all'==$parentId?0:$parentId;
    $class='all'==$parentId?'unit-super':'attr-value unit-sub';
        $query=pdoQuery('unit_tbl',array('unit_id as id','unit_name as name'),array('parent_unit'=>$id),null);
        $list=array('0'=>'选择单位');
        foreach ($query as $row) {
            $list[$row['id']]=$row['name'];
        }
        return array('class'=>$class,'list'=>$list);
}
function indexToValue($target,$index){
    if(isset($index)&&$index!=null){
        switch($target){
            case 'duty':
                return pdoQuery('duty_view',array('user_name'),array('duty_id'=>$index),' limit 1')->fetch()['user_name'];
                break;
            default:
                return pdoQuery($target.'_tbl',array($target.'_name'),array($target.'_id'=>$index),' limit 1')->fetch()[$target.'_name'];
                break;
        }
    }else{
        return null;
    }

}

