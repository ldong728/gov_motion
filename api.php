<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/6/17
 * Time: 9:25
 */
include_once 'includePackage.php';
//include_once 'functions.php';
define('REMOTE_IP',"::1");
global $backData;
$remote=$_SERVER['REMOTE_ADDR'];
$token=isset($_GET['token'])&&$_GET['token']?$_GET['token']:'';
$backData=array('errorCode'=>0,'errorMsg'=>'');
if(REMOTE_IP!=$remote){
    $backData['errorCode']=101;
    $backData['无权限'];
    echo json_encode($backData);
    exit;
}
if(!isset($_GET['method'])&&!isset($_POST['method'])){
    $backData['errorCode']=404;
    $backData['errorMsg']='空方法';
    echo json_encode($backData);
    exit;
}
$method=isset($_GET['method'])?$_GET['method']:$_POST['method'];

$method();

exit;
function login(){
    global $backData;
    $userId=$_POST['user_id'];
    $password=$_POST['password'];
    if(preg_match('/^\d{9}$/',$userId)){
        $userInf=pdoQuery('user_tbl',null,array('user_phone'=>$userId),'limit 1')->fetch();
        if($userInf){
            if(($userInf['password']&&$userInf['password']==$password)||(!$userInf['password']&&$password==md5(substr($userId,5)))){
                $backData['data']['user_name']=$userInf['user_name'];
                $dutyList=pdoQuery('duty_view',null,array('user'=>$userInf['user_id']),'limit 10')->fetchAll();
                $now=time();
                foreach ($backData as $row) {
                    $backData['data']['duty_list'][$row['duty_id']]=$row;
                    if($row['deadline_time']-$now>0){
                        $backData['data']['current_duty']=$row['duty_id'];
                    }else{
                        $backData['data']['current_duty']=0;
                    }
                }

                echo json_encode($backData);
            }else{
               setErrorInf(102,'用户名或密码错误');
            }
        }else{
            setErrorInf(102,'用户名密码错误');
        }
    }else{
        $staffInf=pdoQuery('staff_tbl',array('full_name','user_admin'),array('staff_name'=>$userId,'staff_password'=>$password),' and staff_passsword is not null');
    }

}

function setErrorInf($code,$msg){
    global $backData;
    $backData['errorCode']=$code;
    $backData['errorMsg']=$msg;
}



