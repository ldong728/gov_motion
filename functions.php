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
function userAuth($userName,$password,$category=3){

    $localStaff=false;
    if($staffQuery=pdoQuery('staff_tbl',null,array('staff_name'=>$userName),' limit 1')->fetch()){
        $metting=pdoQuery('meeting_tbl',null,array('category'=>$staffQuery['category']),' order by deadline_time desc limit 1')->fetch();
        if($password==$staffQuery['staff_password']&&$staffQuery['staff_password']!=''){//自创建用户
           $localStaff=1;
        }else{//查询党政信息网
            $userVerify=file_get_contents("http://172.19.48.144:88/Verify?Username=$userName&Password=$password");
            if('SUCCESS'==$userVerify){
               $localStaff=2;
            }
        }
    }
    if($localStaff){
        $_SESSION['staffLogin']=array();
        for($i=0;$i<strlen($staffQuery['steps']);$i++){
            $_SESSION['staffLogin']['steps'][]=(string)$staffQuery['steps'][$i];
        }
        $_SESSION['staffLogin']['category']=$staffQuery['category'];
        $_SESSION['staffLogin']['meeting']=isset($metting)?$metting['meeting_id']:'all';
        $_SESSION['staffLogin']['unit']=$staffQuery['unit'];
        $_SESSION['staffLogin']['staffId']=$staffQuery['staff_id'];
        $userAdmin=json_decode($staffQuery['user_admin']);
        foreach ($userAdmin as $k => $v) {
            $_SESSION['staffLogin']['userList'][$k]=$v;
        }

        getIndex();
    }else{

    }
}

/**
 * 获取对应流程权限的提议案列表
 * @param $steps
 */
function getIndex(){
    global $motionList;
    $motionList=pdoQuery('motion_tbl',null,array('category'=>$_SESSION['staffLogin']['category'],'step'=>$_SESSION['staffLogin']['steps']),' order by category asc limit 20')->fetchAll();
//    syncDept();
//    syncUser();
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
    $_SESSION['staffLogin']['currentMotion']=$id;
    $motionQuery=pdoQuery('motion_view',null,array('motion_id'=>$id,'attr_step'=>$_SESSION['staffLogin']['steps']),' order by value_sort desc,motion_attr asc');
    foreach ($motionQuery as $row) {

        $values = $row;
        $optionArray = json_decode($row['option'], true);
        $values['content']='string'==$row['value_type']?$row['content']:$row['content_int'];

        if($row['step']==$row['attr_step']||(2==$row['step']&&1==$row['attr_step'])){//可修改的选项
            $values['edit']=true;
            if (count($optionArray) > 0) {
                $values['option']=array();
                foreach ($optionArray as $oRow) {
                    $values['option'][$oRow]=$oRow;
                }
                $values['class']='select';
            }

            if($row['target']){
                switch($row['target']){
                    case 'duty':
                        $values['option']=array();
                        $userInf=getUserList();
                        foreach ($userInf['list'] as $k=>$v) {
//                    mylog($v);
                            $values['option'][$k]=$v;
                        }
                        $values['class']=$userInf['class'];
                        break;
                    case 'unit';
                        $values['option']=array();
                        $unitInf=getUnitList();
                        break;

                }
            }
            $content='<div class="input-handle" data-type="#type" data-target="#target" data-content="#content"></div>';
            $content=str_replace('#type',$row['value_type'],$content);
            if(isset($row['target'])&&$row['target']!='')$content=str_replace('#target',$row['target'],$content);
            if(isset($values['content'])&&$values['content']!='')$content=str_replace('#content',$values['content'],$content);
            $values['content']=$content;
        }else{

            $values['edit']=false;
            if(isset($row['target'])&&isset($row['content_int'])&&'index'==$row['value_type']){
                $values['content']=indexToValue($row['target'],$row['content_int']);
            }
        }
        $motion[]=$values;
    }
    $currentStep=$motion[0]['step'];
    $userInf=getUserList();
    switch($currentStep){
        case 1:

            break;
        case 2:

            break;
    }

    include '/view/edit_motion.html.php';
    return;
}

function getUserGroup($data){
    $type=$data['group_type'];
    $groupList=array();
    if('unit'==$type){
        $query=pdoQuery('user_unit_tbl',array('user_unit_id as id','user_unit_name as name'),array('category'=>$_SESSION['staffLogin']['category']),null);
    }elseif('group'==$type){
        $query=pdoQuery('user_group_tbl',array('user_group_id as id','user_group_name as name'),array('category'=>$_SESSION['staffLogin']['category']),null);
    }
    foreach ($query as $row) {
        $groupList[]=$row;
    }
    mylog(getArrayInf($groupList));
    echo ajaxBack($groupList);
}

function updateAttr($data){
    foreach ($data as $row) {
        mylog(getArrayInf($row));
    }

}

function getUser($data){
    $where=array($data['col']=>$data['id']);
    $list=pdoQuery('duty_view',array('duty_id as id','user_name as name'),$where,null);
    foreach ($list as $row) {
        $userList[]=$row;
    }
    echo ajaxBack($userList);

}



function signOut($data){
    unset($_SESSION['staffLogin']);
    mylog('unsetted:'.getArrayInf($_SESSION));
    echo ajaxBack('ok');
}