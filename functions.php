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
        return;
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
    $motionId=array();
    if($staff['category']<3){
        $motionListFilter['category']=$category;
        $meetingListFilter['category']=$category;
    }
    $list=pdoQuery('motion_for_index_view',null,$motionListFilter,' order by category asc limit 20');
    foreach ($list as $row) {
        $motionId[]=$row['motion_id'];
        $motionList[$row['category']][$row['motion_id']]=$row;
    }
    $meeting=pdoQuery('meeting_tbl',null,$meetingListFilter,'order by start_time asc');
    foreach ($meeting as $row) {
        $meetingList[$row['category']][$row['meeting_id']]=$row;
    }

    if(4==$staff['steps'][0]){
        $unitQuery=pdoQuery('motion_view',array('motion_id','motion_name','step_name','category','content_int'),array('step'=>4,'motion_id'=>$motionId,'attr_name'=>'交办单位','category'=>2),' group by motion_id');
        foreach ($unitQuery as $row) {
            if($staff['unit']!=$row['content_int']){
                mylog('not my job');
                mylog(getArrayInf($motionList[$row['category']]));
                mylog($row['motion_id']);
                unset($motionList[$row['category']][$row['motion_id']]);
            }
        }

    }

    if(in_array(5,$staff['steps'])&&1==count($staff['steps'])&&isset($motionId)){

        $mainHandleMotion=array();
        $handleMotion=array();
        $mainHandleListQuery=pdoQuery('motion_view',array('motion_id'),array('motion_id'=>$motionId,'attr_name'=>'主办单位','content_int'=>$staff['unit']),null);
        foreach ($mainHandleListQuery as $row) {
            $mainHandleMotion[]=$row['motion_id'];
        }
        //筛选待主办项目
//        $canMainHandleQuery=pdoQuery('motion_handler_tbl',array('motion as motion_id'),array('motion'=>$mainHandleMotion),' and reply_time is not null');
//        foreach ($canMainHandleQuery as $row) {
//            $canMainHandleMotion[]=$row['motion_id'];
//        }
        $handleListQuery=pdoQuery('motion_view',array('motion_id'),array('motion_id'=>$motionId,'attr_name'=>'协办单位','content_int'=>$staff['unit']),null);
        foreach ($handleListQuery as $row) {
            $handleMotion[]=$row['motion_id'];
        }
        if(count($mainHandleMotion)>0){
            $mainHandleList=pdoQuery('motion_for_index_view',null,array('motion_id'=>$mainHandleMotion),null);
            foreach ($mainHandleList as $row) {
                $motionList[$row['category']]['main'][]=$row;
            }
        }
        if(count($handleMotion)>0){
            $handleList=pdoQuery('motion_for_index_view',null,array('motion_id'=>$handleMotion),null);
            foreach ($handleList as $row) {
                $motionList[$row['category']]['coop'][]=$row;
            }
        }



//        $motionId=array_merge($mainHandleMotion,$handleMotion);
//        $list=pdoQuery('motion_for_index_view',null,array('motion_id'=>$motionId),' order by category asc limit 20');
//        $motionList=array();
        foreach ($list as $row) {
            $motionList[$row['category']][]=$row;
        }


        mylog(getArrayInf($motionList));
        printView('handle_index');
        exit();
    }
//    getMotionList(array());
    printView('index');
}

function getMeetingView($id){
    global $meetingInf;
    $meetingInf=pdoQuery('meeting_tbl',null,array('meeting_id'=>$id),'limit 1')->fetch();
    printView('meeting');
}




/**
 * ajax访问获取提议案列表
 * @param $data
 */
function ajaxMotionList($data){
    $count=20;
    $category=isset($data['category'])?$data['category']:$_SESSION['staffLogin']['category'];
    $meeting=isset($data['meeting'])?$data['meeting']:$_SESSION['staffLogin']['meeting'];
    $attrOrderBy=isset($data['attr_order_by'])?$data['attr_order_by']:'编号';
    $attrOrder=isset($data['attr_order'])? $data['attr_order']:'desc';
    $page=isset($data['page'])?$data['page']:0;
    $filter=isset($data['filter'])?$data['filter']:null;
    $orderStr='order by content_int '.$attrOrder.',content '.$attrOrder;
    $sortFilter=array('meeting'=>$meeting,'attr_name'=>trim($attrOrderBy));
    if('当前环节'==$attrOrderBy){
        $orderStr='order by step '.$attrOrder;
        unset($sortFilter['attr_name']);
    }
    if('编号'==$attrOrderBy){
        $orderStr='order by zx_motion '.$attrOrder;
        unset($sortFilter['attr_name']);
    }
    $field=isset($data['field'])?$data['field']:array('案号','领衔人','提案人','案别','案由','性质类别1','性质类别2','原文','当前环节','交办单位');
    //$sort用于储存顺序
    $sort=array();
    //$sortList用于储存返回的motion数组
    $sortList=array();

    $motionfilter=array();
    $dutyList=array();

    //获取代表委员数据，用以替换数据中的索引值
    $dutyQuery=pdoQuery('duty_view',array('duty_id','user_name','user_unit_name','user_group_name'),array('meeting'=>$meeting),null);
    foreach ($dutyQuery as $row) {
        $dutyList[$row['duty_id']]=$row;
    }

//    mylog(getArrayInf($dutyList));

    $sortQuery=pdoQuery('motion_view',array('motion_id'),$sortFilter,'group by motion_id '.$orderStr.' limit '.$page*$count.','.$count);
    foreach ($sortQuery as $row) {
        $sort[]=$row['motion_id'];
        $sortList[$row['motion_id']]=array();
        $motionfilter[]=$row['motion_id'];
    }
    $motionDetail=pdoQuery('motion_view',null,array('motion_id'=>$motionfilter,'attr_name'=>$field),null);
    $singleRow=null;
    foreach ($motionDetail as $row) {
//        if(!$singleRow)$singleRow=$row;
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
        $sortList[$row['motion_id']]['编号']=$row['zx_motion'];
    }
    if($singleRow){

    }
//    mylog(getArrayInf($sortList));
    echo ajaxBack(array('list'=>$sortList,'sort'=>$sort));
//    mylog(getArrayInf($sortList));
//    return $sortList;
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
 * 已作废
 */
function createMotion_temp($data){
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
 * 内网提交新提议案
 */
function createMotion(){
    $staff=$_SESSION['staffLogin'];
    $meetingInf=pdoQuery('meeting_tbl',null,array('meeting_id'=>$staff['meeting']),' order by deadline_time desc limit 1')->fetch();
    $emptyMotion=pdoQuery('motion_tbl',array('motion_id'),array('motion_name'=>'新建','duty'=>0,'category'=>$staff['category']),'limit 1')->fetch();
    pdoTransReady();
    if($emptyMotion){
        editMotion(array('id'=>$emptyMotion['motion_id']));
    }else{
        try{
            $id=pdoInsert('motion_tbl',array('meeting'=>$staff['meeting'],'category'=>$staff['category'],'motion_name'=>'新建','motion_template'=>$meetingInf['motion_template'],'step'=>1));
            if(2==$staff['category']){
                pdoInsert('zx_motion_tbl',array('motion'=>$id));
            }
            pdoCommit();
            editMotion(array('id'=>$id));
        }catch(PDOException $e){
            mylog($e->getMessage());
            pdoRollBack();
        }
    }

}

/**
 *返回需要编辑的数据
 * @param $data array，包含motion_id
 */
function editMotion($data){
    global $config;
    mylog($config['test']);
    $id=$data['id'];
    $_SESSION['staffLogin']['currentMotion']=$id;
//    $attrFilter=array('motion_id'=>$id,'attr_step'=>$_SESSION['staffLogin']['steps']); //只显示当前步骤所需填写的选项
    $attrFilter=array('motion_id'=>$id);
    $meetingInf=pdoQuery('motion_inf_view',null,array('motion_id'=>$id),' limit 1')->fetch();

    //处理政协提案有不同交办单位的情况
    $step4CanEdit=true;
    if(4==$meetingInf['step']&&2==$meetingInf['category']){
        $staffUnit=$_SESSION['staffLogin']['unit'];
        $stepPermition=pdoQuery('motion_view',array('motion_id'),array('motion_id'=>$id,'content_int'=>$staffUnit,'attr_name'=>'交办单位'),'limit 1')->fetch();
        if(!$stepPermition){
            $step4CanEdit=false;
        }
    }

    $motionQuery=pdoQuery('motion_view',null,$attrFilter,' order by value_sort desc,motion_attr asc');

    foreach ($motionQuery as $row) {
        //提议案所有的属性取出后，剔除高于当前步骤，并且没有值的属性
//        if($row['step']<$row['attr_step']&&!$row['content']&&!$row['content_int'])continue;
        $values = $row;
        $optionArray = json_decode($row['option'], true);
        $values['content']='string'==$row['value_type']||'attachment'==$row['value_type']?$row['content']:$row['content_int'];
        if(!$values['content'])$values['content']='';
        if(($row['step']==$row['attr_step']||(2==$row['step']&&1==$row['attr_step']))&&in_array($row['step'],$_SESSION['staffLogin']['steps'])&&$step4CanEdit){//如操作员流程权限与当前权限吻合，则可修改当前流程选项
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


                        break;
                        //下拉框的情况
//                        $values['option']=array();
//                        $userInf=getUserList();
//                        foreach ($userInf['list'] as $k=>$v) {
//                            $values['option'][$k]=$v;
//                        }
//                        $values['class']=$userInf['class'];
//                        break;
                    case 'unit';
                        $values['option']=array();
                        $unitInf=getUnitList('all',$row['step']+1);
                        foreach ($unitInf['list'] as $k=>$v) {
                            $values['option'][$k]=$v;
                        }
                        $values['class']=$unitInf['class'];
                        break;
                }
            }

            //如果属性属于办理环节，则所有该环节属性放入临时数组，等待下一步判断是否有办理权限
            if(5==$row['attr_step']){
                $mainHandler[$row['attr_name']]=$values;
                continue;
            }
            //如果属性支持多值情况的处理
            if(1==$values['multiple']){

                //如果此属性已包含一个值，且有新值存在，则把值放入multiple_value数组中，存入前先将表内索引值转换为对应的名称
                if(isset($motion[$row['attr_name']])&&$values['content']){
                    $motion[$row['attr_name']]['multiple_value'][]=
                        array('attr_id'=>$values['attr_id'],'content'=>indexToValue($row['target'],$values['content']));

                //如果新值存在且此属性并未包含值
                }elseif($values['content']){
                    $motion[$row['attr_name']]=$values;
                    $motion[$row['attr_name']]['multiple_value'][]=
                        array('attr_id'=>$values['attr_id'],'content'=>indexToValue($row['target'],$values['content']));
                }else{
                    $motion[$row['attr_name']]=$values;
                }
//                mylog($values['content']);

            }else{
                $motion[$row['attr_name']]=$values;
//                $motion[$row['attr_name']]['multiple_value'][]=array('attr_id'=>$values['attr_id'],'content'=>indexToValue($row['target'],$values['content']));
            }
        }else{
            $values['edit']=false;
            if(isset($row['target'])&&isset($row['content_int'])&&'index'==$row['value_type']){
                $values['content']=indexToValue($row['target'],$row['content_int']);
            }
            if('time'==$row['value_type']&&$values['content']!=null)$values['content']=date('Y-m-d',$values['content']);
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
        case 3:

            break;

        case 4:

            break;
        default:
            $unit=$_SESSION['staffLogin']['unit'];
            $handlerQuery=pdoQuery('motion_handler_view',null,array('motion'=>$id,),null);
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
//            mylog(getArrayInf($handlerEdit));
//            mylog(getArrayInf($mainHandler));
            if($motion['主办单位']['content_int']==$_SESSION['staffLogin']['unit']){
                $canMainHandler=true;
//                foreach ($mainHandler as $k => $v) {
//                    $motion[$k]=$v;
//                }

                $motion=array_merge($motion,$mainHandler);
            }

            break;
    }
//    mylog(getArrayInf($motion));
    include '/view/edit_motion1.html.php';
//    include '/view/edit_motion1'.$meetingInf['category'].'.html.php';//分界面
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
    $attrs=isset($data['data'])?$data['data']:array();
    pdoTransReady();
    try{
        foreach ($attrs as $row) {
            $value=array();
            if((!isset($row['value'])||!$row['value'])&&$row['attr_type']!='attachment'){//过滤非附件的空值
                continue;
            }
            if('attachment'==$row['attr_type'])continue;
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
        //点击下一步的操作
        if($isFoward>0){
            pdoUpdate('motion_tbl',array('step'=>$motion['step']+1),array('motion_id'=>$motionId));
            if(4==$motion['step']){
                $handlerList=pdoQuery('attr_view',null,array('motion'=>$motionId,'attr_name'=>'协办单位'),null);
                foreach ($handlerList as $row) {
                    pdoUpdate('motion_handler_tbl',array('status'=>7),array('motion'=>$motionId));
                    pdoInsert('motion_handler_tbl',array('motion'=>$motionId,'attr'=>$row['attr_id'],'unit'=>$row['content_int'],'status'=>1),'update');
                }
            }
            if(1==$motion['step']||2==$motion['step']){//将“案由”和“领衔人”属性与motion表中的motion_name,duty字段同步
                $attr=pdoQuery('attr_view',array('content','content_int'),array('motion'=>$motionId,'attr_name'=>array('案由','领衔人','提案人')),'order by attr_name asc limit 2')->fetchAll();
                $name='';
                $duty='0';
                foreach ($attr as $row) {
                    if($row['content'])$name=$row['content'];
                    else $duty=$row['content_int'];
                }
                pdoUpdate('motion_tbl',array('motion_name'=>$name,'duty'=>$duty),array('motion_id'=>$motionId),'limit 1');
            }

            //审核未通过的情况下，将提议案步骤直接设置为完成
            if(3==$motion['step']){
                $attr=pdoQuery('attr_view',array('content'),array('motion'=>$motionId,'attr_name'=>'审核'.$motion['category']),'limit 1')->fetch();
                if('立案'!=$attr['content']){
                    pdoUpdate('motion_tbl',array('step'=>7),array('motion_id'=>$motionId));
                }
            }

        }elseif($isFoward<0){
            pdoUpdate('motion_tbl',array('step'=>$motion['step']-1),array('motion_id'=>$motionId));
        }
        if(5==$motion['step']){
            $handleDate=$data['handler'];
            mylog(getArrayInf($handleDate));
            $handleDate['receive_time']=time();
            $handleDate['reply_time']=time();
            pdoInsert('motion_handler_tbl',$handleDate,'update');
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

/**
 * 使用phpEcxel解析excel文件
 */
function encodeExcel(){

    exit;
}

/**
 * 获取提案议案流程信息
 * @param $data 包含motionId
 */
function getMotionStepInf($data){
    $motionStepInf=pdoQuery('motion_step_inf_view',null,array('motion_id'=>$data['id']),'order by step limit 8')->fetchAll();
    if(!$motionStepInf)$motionStepInf=arrray();
    include 'view/motion_step_info.html.php';
    return;
}
