<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/3/6
 * Time: 10:46
 */

/**用户登录处理方法，初始化session
 * @param $userName 用户输入的用户名
 * @param $password 用户输入的密码
 */
function userAuth($userName,$password){
    $staffQuery=pdoQuery('staff_tbl',null,array('staff_name'=>$userName),' limit 1')->fetch();
//    mylog(json_encode($staffQuery,JSON_UNESCAPED_UNICODE));
    if($staffQuery){
        if($password==$staffQuery['staff_password']){//自创建用户
            $_SESSION['login']=array();
                for($i=0;$i<strlen($staffQuery['steps']);$i++){
                    $_SESSION['login']['steps'][]=(string)$staffQuery['steps'][$i];
                }
            $_SESSION['login']['category']=$staffQuery['category'];



            mylog(getArrayInf($_SESSION));
//            echo "ok";
            printView('index');
        }else{//查询党政信息网
            echo "false";
        }
    }else{//非工作人员

    }
}

/**
 * 获取对应流程权限的提议案列表
 * @param $steps
 */
function getIndex($steps){
//    $list=pdoQuery('motion_tbl',null,array())
}

/**
 * 创建提议案
 * @param $data
 */
function createMotion($data){
    $sessionInf=$_SESSION['login'];
    $meetingInf=pdoQuery('meeting_tbl',null,array('category'=>$sessionInf['category']),' order by deadline_time desc limit 1')->fetch();
    $id=pdoInsert('motion_tbl',array('motion_name'=>$data['motion_name'],'meeting'=>$meetingInf['meeting_id'],'motion_template'=>$meetingInf['motion_template'],'user'=>1,'document'=>'none','step'=>2,'document_sha'=>'abas'));
    echo ajaxBack($id);
}