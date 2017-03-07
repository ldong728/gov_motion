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
            $_SESSION['staffLogin']=array();
                for($i=0;$i<strlen($staffQuery['steps']);$i++){
                    $_SESSION['staffLogin']['steps'][]=(string)$staffQuery['steps'][$i];
                }
            $_SESSION['staffLogin']['category']=$staffQuery['category'];
//            $_SESSION['']



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
function getIndex(){
    mylog(getArrayInf($_SESSION));
    global $motionList;
    $motionList=pdoQuery('motion_tbl',null,array('category'=>$_SESSION['staffLogin']['category'],'step'=>$_SESSION['staffLogin']['steps']),' order by category asc limit 20')->fetchAll();
    mylog(getArrayInf($motionList));
    mylog('get list');
    printView('index');


//    $list=pdoQuery('motion_tbl',null,array())
}

/**
 * 创建提议案
 * @param $data
 */
function createMotion($data){
    $sessionInf=$_SESSION['staffLogin'];
    $meetingInf=pdoQuery('meeting_tbl',null,array('category'=>$sessionInf['category']),' order by deadline_time desc limit 1')->fetch();
    $id=pdoInsert('motion_tbl',array('motion_name'=>$data['motion_name'],'meeting'=>$meetingInf['meeting_id'],'category'=>$sessionInf['category'],'motion_template'=>$meetingInf['motion_template'],'user'=>1,'document'=>'none','step'=>2,'document_sha'=>'abas'));
    echo ajaxBack($id);
}

/**
 *返回需要编辑的数据
 * @param $data array，包含motion_id
 */
function editMotion($data){
    $id=$data['id'];
    $motionQuery=pdoQuery('motion_view',null,array('motion_id'=>$id,'attr_step'=>$_SESSION['staffLogin']['steps']),null);
    foreach ($motionQuery as $row) {
        $values = $row;
        $optionArray = json_decode($row['option'], true);
        if (count($optionArray) > 0) {
            $values['option'] = $optionArray;
        }

        $motion[]=$values;
    }

    include '/view/edit_motion.html.php';
}


function signOut($data){
    unset($_SESSION['staffLogin']);
    mylog(getArrayInf($_SESSION));
    echo ajaxBack('ok');
}