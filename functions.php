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
    mylog(getArrayInf($_SESSION['staffLogin']));
    global $motionList;
    $motionList=array();
    $where=array('step'=>$_SESSION['staffLogin']['steps']);
    if($_SESSION['staffLogin']['category']<3)$where['category']=$_SESSION['staffLogin']['category'];
    $list=pdoQuery('motion_tbl',null,$where,' order by category asc limit 20');
    foreach ($list as $row) {
        $motionId[]=$row['motion_id'];
        $motionList[]=$row;
    }
    if(5==$_SESSION['staffLogin']['steps'][0]){
        $list=pdoQuery('motion_view',array('motion_id','motion_name','category'),array('motion_id'=>$motionId,'target'=>'unit','attr_step'=>'4','content_int'=>$_SESSION['staffLogin']['unit']),' group by motion_id order by category asc')->fetchAll();
        $motionList=$list;
    }

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
//    $attrFilter=array('motion_id'=>$id,'attr_step'=>$_SESSION['staffLogin']['steps']); //只显示当前步骤所需填写的选项
    $attrFilter=array('motion_id'=>$id);
    $motionQuery=pdoQuery('motion_view',null,$attrFilter,' order by value_sort desc,motion_attr asc');
    foreach ($motionQuery as $row) {
        if($row['step']<$row['attr_step']&&!$row['content']&&!$row['content'])continue;
        $values = $row;
        $optionArray = json_decode($row['option'], true);
        $values['content']='string'==$row['value_type']?$row['content']:$row['content_int'];

        if($row['step']==$row['attr_step']||(2==$row['step']&&1==$row['attr_step'])){//如操作员流程权限与当前权限吻合，则可修改当前流程选项
            $values['edit']=true;
            if (count($optionArray) > 0) {//普通选项
                $values['option']=array();
                foreach ($optionArray as $oRow) {
                    $values['option'][$oRow]=$oRow;
                }
                $values['class']='select';
                if(!$values['content'])$value['content']=$row['default_value'];
            }
            if($row['target']){//数据库内容
                switch($row['target']){
                    case 'duty':
                        $values['option']=array();
                        $userInf=getUserList();
                        foreach ($userInf['list'] as $k=>$v) {
                            $values['option'][$k]=$v;
                        }
                        $values['class']=$userInf['class'];
                        break;
                    case 'unit';
                        $values['option']=array();
                        $unitInf=getUnitList();
                        foreach ($unitInf['list'] as $k=>$v) {
                            $values['option'][$k]=$v;
                        }
                        $values['class']=$unitInf['class'];
                        break;
                }
            }
        }else{

            $values['edit']=false;
            if(isset($row['target'])&&isset($row['content_int'])&&'index'==$row['value_type']){
                $values['content']=indexToValue($row['target'],$row['content_int']);
            }
        }
//        mylog(getArrayInf($values));
        $motion[]=$values;
    }
//    mylog(getArrayInf($motion));
    $currentStep=$motion[0]['step'];
    $userInf=getUserList();
    switch($currentStep){
        case 1:

            break;
        case 2:

            break;
        case 5:
            $unit=$_SESSION['staffLogin']['unit'];
            $handlerQuery=pdoQuery('motion_handler_tbl',null,array('motion'=>$id,),' limit 1');
            foreach ($handlerQuery as $row) {
                if($row['unit']==$unit){
                    $handler=array('签收时间'=>$row['receive_time'],'回复时间'=>$row['reply_time'],'联系人'=>$row['contact_name'],'联系电话'=>$row['contact_phone'],'电话'=>$row['phone'],'附件'=>$row['attachment']);
                    include '/view/handle_motion.html.php';
                    return;
                }
            }

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

/**填充议案属性
 * @param $data {step:1,data:values}
 */
function updateAttr($data){
    $isFoward=$data['step'];
    $motionId=$_SESSION['staffLogin']['currentMotion'];
    $motion=pdoQuery('motion_tbl',null,array('motion_id'=>$motionId),' limit 1')->fetch();

    pdoTransReady();
    try{
        foreach ($data['data'] as $row) {
            mylog(getArrayInf($row));
            $value=array();
            if((!$row['value']&&$row['attr_type']=='string')||'attachment'==$row['attr_type'])continue;
            if($row['attr_id'])$value['attr_id']=$row['attr_id'];
            $value['motion']=$motionId;
            $value['staff']=$_SESSION['staffLogin']['staffId'];
            $value['motion_attr']=$row['motion_attr'];
            $value['attr_template']=$row['attr_template'];
            if('index'==$row['attr_type']||'int'==$row['attr_type']){
                $value['content_int']=$row['value'];
            }elseif('time'==$row['attr_type']){
                $value['content_int']=timeMysqlToUnix($value['value']);
            }else{
                $value['content']=$row['value'];
            }
//            mylog(getArrayInf($value));
            pdoInsert('attr_tbl',$value,'update');
        }
        if($isFoward){
            pdoUpdate('motion_tbl',array('step'=>$motion['step']+1),array('motion_id'=>$motionId));
            if(4==$motion['step']){
                $handlerList=pdoQuery('attr_view',null,array('motion'=>$motionId,'attr_name'=>'协办单位'),null);
                foreach ($handlerList as $row) {
                    pdoInsert('motion_handler_tbl',array('motion'=>$motionId,'attr'=>$row['attr_id'],'unit'=>$row['content_int']));
                }

            }

        }
//        if($data['step'])exeNew('update motion_tbl set step=step+1 where motion_id='.$motionId);

        pdoCommit();
        echo ajaxBack('ok');
    }catch(PDOException $e){
        mylog($e->getMessage());
        pdoRollBack();
    }


}

/**
 * 通过ajax获取代表委员分组成员列表的方法
 * @param $data：包含分组形式，group或unit，及对应id，例{"col":"group","id":5}
 */
function getUser($data){
    $where=array($data['col']=>$data['id']);
    $list=pdoQuery('duty_view',array('duty_id as id','user_name as name'),$where,null);
    foreach ($list as $row) {
        $userList[]=$row;
    }
    echo ajaxBack($userList);
}

/**
 * 通过ajax获取分组单位列表的方法
 * @param $data 包含父id，例：{"id":6}
 */
function getUnit($data){
    $where=array('parent_unit'=>$data['id']);
    $unit=pdoQuery('unit_tbl',array('unit_id as id','unit_name as name'),array('unit_id'=>$data['id']),'limit 1')->fetch();
    $unitList[]=$unit;
    $list=pdoQuery('unit_tbl',array('unit_id as id','unit_name as name'),$where,null);

    foreach ($list as $row) {
        $unitList[]=$row;
    }
    echo ajaxBack($unitList);

}



function signOut($data){
    unset($_SESSION['staffLogin']);
    mylog('unsetted:'.getArrayInf($_SESSION));
    echo ajaxBack('ok');
}