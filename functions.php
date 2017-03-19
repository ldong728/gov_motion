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
    $staffFilter=array('staff_name'=>$userName);
    if($category<3&&$category>0)$staffFilter['category']=$category;
    if($staffQuery=pdoQuery('staff_tbl',null,$staffFilter,' limit 1')->fetch()){
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
        $_SESSION['staffLogin']['staffName']=$staffQuery['full_name'];
        $_SESSION['staffLogin']['outId']=$staffQuery['out_id'];
        $userAdmin=json_decode($staffQuery['user_admin']);
        foreach ($userAdmin as $k => $v) {
            $_SESSION['staffLogin']['userList'][$k]=$v;
        }
        getIndex();
        exit;
    }else{

    }
}

/**
 * 获取对应流程权限的提议案列表
 * @param $steps
 */
function getIndex($orderBy='default'){
    $staff=$_SESSION['staffLogin'];
    mylog(getArrayInf($staff));
    global $motionList,$meetingList,$category;
    $meetingList=array();
    $motionList=array();
    $category=$staff['category'];
    $motionListFilter=array('step'=>$staff['steps']);
    $meetingListFilter=null;
    if($staff['category']<3){
        $motionListFilter['category']=$category;
        $meetingListFilter['category']=$category;
    }
    $list=pdoQuery('motion_for_index_view',null,$motionListFilter,' order by category asc limit 20');
    foreach ($list as $row) {
        $motionId[]=$row['motion_id'];
        $motionList[$row['category']][]=$row;
    }
    $meeting=pdoQuery('meeting_tbl',null,$meetingListFilter,'order by start_time asc');
    foreach ($meeting as $row) {
        $meetingList[$row['category']][$row['meeting_id']]=$row;
    }

    if(4==$staff['steps'][0]&&isset($staff['outId'])&&null!=$staff['outId']){
        $unitQuery=pdoQuery('motion_view',array('motion_id','motion_name','step_name','category','content_int'),array('step'=>4,'motion_id'=>$motionId,'attr_name'=>'交办单位'),' group by motion_id');
        foreach ($unitQuery as $row) {
            if($staff['unit']!=$row['content_int']){
                unset($motionList[$row['category']][$row['motion_id']]);
            }
        }

    }

    if(in_array(5,$staff['steps'])&&1==count($staff['steps'])&&isset($motionId)){
        $mainHandleMotion=array();
        $canMainHandleMotion=array();
        $handleMotion=array();
        $mainHandleListQuery=pdoQuery('motion_view',array('motion_id'),array('motion_id'=>$motionId,'attr_name'=>'主办单位','content_int'=>$staff['unit']),null);
        foreach ($mainHandleListQuery as $row) {
            $mainHandleMotion[]=$row['motion_id'];
        }
        $canMainHandleQuery=pdoQuery('motion_handler_tbl',array('motion'),array('motion'=>$mainHandleMotion),' and reply_time is not null');
        foreach ($canMainHandleQuery as $row) {
            $canMainHandleMotion[]=$row['motion'];
        }
        $handleListQuery=pdoQuery('motion_view',array('motion_id'),array('motion_id'=>$motionId,'attr_name'=>'协办单位','content_int'=>$staff['unit']),null);
        foreach ($handleListQuery as $row) {
            $handleMotion[]=$row['motion_id'];
        }
        $motionId=array_merge($canMainHandleMotion,$handleMotion);
        $list=pdoQuery('motion_for_index_view',null,array('motion_id'=>$motionId),' order by category asc limit 20');
        $motionList=array();
        foreach ($list as $row) {
            $motionList[$row['category']][]=$row;
        }


        mylog(getArrayInf($motionList));
    }
//    getMotionList(array());
    printView('index');
}

function getMeetingView($id){


    printView('meeting');
}




/**
 * ajax访问获取提议案列表
 * @param $data
 */
function ajaxMotionList($data){
    $count=20;
//    $category=isset($data['category'])?$data['category']:$_SESSION['staffLogin']['category'];
    $meeting=isset($data['meeting'])?$data['meeting']:$_SESSION['staffLogin']['meeting'];
    $attrOrderBy=isset($data['attr_order_by'])?$data['attr_order_by']:'当前环节';
    $attrOrder=isset($data['attr_order'])? $data['attr_order']:'desc';
    $orderStr='order by content_int '.$attrOrder.',content '.$attrOrder;
    $sortFilter=array('meeting'=>$meeting,'attr_name'=>$attrOrderBy);

    if('当前环节'==$attrOrderBy){
        $orderStr='order by step '.$attrOrder;
        unset($sortFilter['attr_name']);
    }
//    $orderBy=isset($data['order_by'])?$data['order_by']:'step';
//    $order=isset($data['order'])?$data['order']:'desc';
    $page=isset($data['page'])?$data['page']:0;
    $field=isset($data['field'])?$data['field']:array('案号','领衔人','案别','案由','性质类别','原文','当前环节','交办单位');
    $sortList=array();
    $motionfilter=array();
    $dutyList=array();
    $dutyQuery=pdoQuery('duty_view',array('duty_id','user_name','user_unit_name','user_group_name'),array('meeting'=>$meeting),null);
    foreach ($dutyQuery as $row) {
        $dutyList[$row['duty_id']]=$row;
    }
    mylog(getArrayInf($dutyList));

    $sortQuery=pdoQuery('motion_view',array('motion_id'),$sortFilter,'group by motion_id '.$orderStr.' limit '.$page*$count.','.$count);
    foreach ($sortQuery as $row) {
        $sortList[$row['motion_id']]=array();
        $motionfilter[]=$row['motion_id'];
    }
    $motionDetail=pdoQuery('motion_view',null,array('motion_id'=>$motionfilter,'attr_name'=>$field),null);
    foreach ($motionDetail as $row) {
        $content='string'==$row['value_type']?$row['content']:$row['content_int'];
        $content='attachment'==$row['value_type']?$row['attachment']:$content;
        if('index'==$row['value_type']){
            if('duty'==$row['target']&&$content){
                $content=$dutyList[$content]['user_name'];
            }else{
                $content=indexToValue($row['target'],$content);
            }
        }
        $sortList[$row['motion_id']][$row['attr_name']]=$content;
        $sortList[$row['motion_id']]['案由']=$row['motion_name'];
        $sortList[$row['motion_id']]['案别']=1==$row['category']?'建议':'提案';
        $sortList[$row['motion_id']]['当前环节']=$row['step_name'];
//        $sortList[$row['motion_id']]['']
//        $sortList[$row['motion_id']]['']
    }
//    mylog(getArrayInf($sortList));
    echo ajaxBack(array('list'=>$sortList));
//    mylog(getArrayInf($sortList));
    return $sortList;
}

/**
 * 删除提议案属性
 * @param $data：包含属性ID
 */
function ajaxDeleteAttr($data){
    $id=pdoDelete('attr_tbl',array('attr_id'=>$data['id']),' limit 1');
    echo ajaxBack($id);
}

/**
 * 创建提议案
 * @param $data
 */
function createMotion($data){
    $sessionInf=$_SESSION['staffLogin'];
    $dutyId=$data['duty_id'];
    $motionName=['duty_name'];
    $meetingInf=pdoQuery('meeting_tbl',null,array('category'=>$sessionInf['category']),' order by deadline_time desc limit 1')->fetch();
    pdoTransReady();
    try{
        $motionId=pdoInsert('motion_tbl',array('motion_name'=>$motionName,'meeting'=>$meetingInf['meeting_id'],'category'=>$sessionInf['category'],'motion_template'=>$meetingInf['motion_template'],'duty'=>$dutyId,'document'=>'none','step'=>2,'document_sha'=>'none'));
        $attrInf=pdoQuery('motion_view',array('motion_attr','attr_template'),array('motion_id'=>$motionId,'attr_name'=>"案由"),' limit 1')->fetch();
        pdoInsert('attr_tbl',array('motion'=>$motionId,'motion_attr'=>$attrInf['motion_attr'],'attr_template'=>$attrInf['attr_template'],'content'=>$motionName));
        pdoCommit();
        echo ajaxBack("ok");
    }catch(PDOException $e){
        pdoRollBack();
        mylog($e->getMessage());
    }
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
    $meetingInf=pdoQuery('motion_inf_view',null,array('motion_id'=>$id),' limit 1')->fetch();
    $motionQuery=pdoQuery('motion_view',null,$attrFilter,' order by value_sort desc,motion_attr asc');
    foreach ($motionQuery as $row) {
        if($row['step']<$row['attr_step']&&!$row['content']&&!$row['content_int'])continue;
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
                if(!$values['content'])$values['content']=$row['default_value'];
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
            if(5==$row['attr_step']){//如果属性属于办理环节，则所有该环节属性放入临时数组，等待下一步判断是否有办理权限
                $mainHandler[$row['attr_name']]=$values;
                continue;
            }
            if(1==$values['multiple']){
                if(isset($motion[$row['attr_name']])&&$values['content']){
                    $motion[$row['attr_name']]['multiple_value'][]=
                        array('attr_id'=>$values['attr_id'],'content'=>indexToValue($row['target'],$values['content']));
                }elseif($values['content']){
                    $motion[$row['attr_name']]=$values;
                    $motion[$row['attr_name']]['multiple_value'][]=
                        array('attr_id'=>$values['attr_id'],'content'=>indexToValue($row['target'],$values['content']));
                }else{
                    $motion[$row['attr_name']]=$values;
                }
                mylog($values['content']);

            }else{
                $motion[$row['attr_name']]=$values;
//                $motion[$row['attr_name']]['multiple_value'][]=array('attr_id'=>$values['attr_id'],'content'=>indexToValue($row['target'],$values['content']));
            }
        }else{
            $values['edit']=false;
            if(isset($row['target'])&&isset($row['content_int'])&&'index'==$row['value_type']){
                $values['content']=indexToValue($row['target'],$row['content_int']);
            }
            if(1==$values['multiple']&&isset($motion[$row['attr_name']]))$motion[$row['attr_name']]['content'].=','.$values['content'];
            else $motion[$row['attr_name']]=$values;
        }
    }
    $currentStep=current($motion)['step'];
    $userInf=getUserList();
    switch($currentStep){
        case 1:

            break;
        case 2:

            break;
        case 5:
            $unit=$_SESSION['staffLogin']['unit'];
            $handlerQuery=pdoQuery('motion_handler_tbl',null,array('motion'=>$id,),' limit 1');
            $handlerDisplay=array();
            $handlerEdit=array();
            $canMainHandler=false;
            foreach ($handlerQuery as $row) {
                if($row['unit']==$unit){
                    $handlerEdit=$row;
                }else{
                    $handlerDisplay[]=$row;
                }
            }
            if($mainHandler['主办单位']['content_int']==$_SESSION['staffLogin']['unit']){
                $canMainHandler=true;
                $motion=array($motion,$mainHandler);
            }

            break;
    }

    include '/view/edit_motion1.html.php';
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
//            mylog(getArrayInf($row));
            $value=array();
            if((!isset($row['value'])||!$row['value'])&&$row['attr_type']!='attachment'){//过滤非附件的空值
//                mylog('continue');
                continue;
            }
//            mylog(getArrayInf($row));
//            if(!$row['value']&&in_array($row['attr_type'],array('string','int')))continue;
            if('attachment'==$row['attr_type'])continue;
//            if(((!isset($row['value'])||!$row['value'])&&$row['attr_type']=='string')||'attachment'==$row['attr_type'])continue;
            if($row['attr_id'])$value['attr_id']=$row['attr_id'];
            $value['motion']=$motionId;
            $value['staff']=$_SESSION['staffLogin']['staffId'];
            $value['motion_attr']=$row['motion_attr'];
            $value['attr_template']=$row['attr_template'];
            if('index'==$row['attr_type']||'int'==$row['attr_type']){
                $value['content_int']=$row['value'];
            }elseif('time'==$row['attr_type']){
                $value['content_int']=time();
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
            if(5==$motion['step']){
                $handleDate=$data['handler'];
                $handleDate['receive_time']=time();
                $handleDate['reply_time']=time();
                pdoInsert('motion_handler_tbl',$handleDate,'update');
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
    $userList=null;
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



/**
 * 登出
 * @param $data
 */
function signOut($data){
    session_unset();
    mylog('unsetted:'.getArrayInf($_SESSION));
    echo ajaxBack('ok');
}