<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/13
 * Time: 10:38
 */
include_once 'includePackage.php';
include_once $mypath . '/includes/upload.class.php';
session_start();
mylog(getArrayInf($_SESSION));
if(isset($_SESSION['staffLogin'])&&$_SESSION['staffLogin']['currentMotion']){
    if(isset($_FILES)&&isset($_GET['attachment'])){
        foreach ($_FILES as $k => $v) {
            $uploader=new uploader($k);
            $fileName=md5_file($_FILES[$k]['tmp_name']);
            $uploader->upFile($fileName);
            $inf=$uploader->getFileInfo();
            $value=array('motion'=>$_SESSION['staffLogin']['currentMotion'],'motion_attr'=>$_GET['ma'],'attr_template'=>$_GET['at'],'attachment'=>$inf['url'],'staff'=>$_SESSION['staffLogin']['staffId']);
            try{
                if($_GET['a']>0){
                    $value['attr_id']=$_GET['a'];
                }
                $id=pdoInsert('attr_tbl',$value,'update');
                $inf['attrId']=$id;
                echo json_encode($inf);
            }catch(PDOException $e){
                $inf['state']='fail';
                echo json_encode($inf);
            }


        }

//        mylog(getArrayInf($_GET));
//        mylog(getArrayInf($_FILES));
    }else{

    }

    exit;



}