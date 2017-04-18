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
include_once'includes/DataSupply.class.php';
function userAuth($userName,$password,$category=3){
    $localStaff=false;
    $staffFilter=array('staff_name'=>$userName);
//    if($category<3&&$category>0)$staffFilter['category']=$category;
    if($staffQuery=pdoQuery('staff_tbl',null,$staffFilter,' limit 1')->fetch()){
        $metting=pdoQuery('meeting_tbl',null,array('category'=>$staffQuery['category']),' order by deadline_time desc limit 1')->fetch();
        if($password==$staffQuery['staff_password']&&$staffQuery['staff_password']!=''){//自创建用户
           $localStaff=1;
        }else{//查询党政信息网
            $userVerify=file_get_contents("http://172.19.48.144:88/Verify?Username=$userName&Password=$password");
            mylog('outerStaffLogin name:'.$userName.',status:'.$userVerify);
            if('SUCCESS'==$userVerify){
               $localStaff=2;
            }
        }
    }else{
//        mylog('notInList');
    }

    if($localStaff){
        if(!$staffQuery['steps'])return;
        $_SESSION['staffLogin']=array();
        $_SESSION['staffLogin']['steps']=array();
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
//    mylog(getArrayInf($staff));
    global $motionList,$meetingList,$handleUnitMotionList,$category;
    $meetingList=array();
    $motionList=array();
    $category=$staff['category'];
    $motionListFilter=array();
    foreach ($staff['steps'] as $step) {
        if(4==$step)continue;//如果用户有交办权限，则从筛选器中删除4，待下一步处理
        $motionListFilter['step'][]=$step;
    }
    $meetingListFilter=null;
    $motionId=array();
    if($staff['category']<3){
        $motionListFilter['category']=$category;
        $meetingListFilter['category']=$category;
    }

    if(in_array(4,$staff['steps'])){//交办权限的情况
        $defaultUnit='5103'==$staff['staffId']||'6726'==$staff['staffId']?'or content_int is null or content_int=5103':'';
        $motionLimit=array();
        $unitQuery1=pdoQuery('motion_view',array('motion_id','motion_name','step_name','category','content_int'),array('category'=>1,'step'=>4,'attr_name'=>'交办单位'),'and(content_int='.$staff['staffId'].' '.$defaultUnit.' )  limit 10')->fetchAll();
        $unitQuery2=pdoQuery('motion_view',array('motion_id','motion_name','step_name','category','content_int'),array('category'=>2,'step'=>4,'attr_name'=>'交办单位'),'and(content_int='.$staff['staffId'].' '.$defaultUnit.' )  limit 10')->fetchAll();
        for($i=0;$i<20;$i++){
            if(isset($unitQuery1[$i]))$motionLimit[]=$unitQuery1[$i]['motion_id'];
            if(isset($unitQuery2[$i]))$motionLimit[]=$unitQuery2[$i]['motion_id'];
        }
        if(count($motionLimit)>0){
            mylog('limit > 0');
            $motionListFilter['motion_id']=$motionLimit;
            $motionListFilter['step'][]=4;
        }
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
    if(1==count($staff['steps'])&&1==$staff['steps'][0]){
        $motionList=array();
        $list=pdoQuery('motion_for_index_view',null,array_merge($motionListFilter,array('user'=>$staff['staffId'])),' order by category asc limit 20');
        foreach ($list as $row) {
//            $motionId[]=$row['motion_id'];
            $motionList[$row['category']][$row['motion_id']]=$row;
        }

    }



    if(in_array(5,$staff['steps'])&&1==count($staff['steps'])&&isset($motionId)){
        global $mainCount1,$mainCount2,$count1,$count2;
        $mainCount1=0;
        $mainCount2=0;
        $count1=0;
        $count2=0;
        $mainCountQuery=pdoQuery('motion_view',array('category','meeting','count(*) as count'),array('attr_name'=>'主办单位','content_int'=>$staff['unit']),'group by meeting order by meeting desc limit 2');
        foreach ($mainCountQuery as $row) {
            if(1==$row['category'])$mainCount1=$row['count'];
            else $mainCount2=$row['count'];
        }
        $countQuery=pdoQuery('motion_handler_inf_view',array('count(*) as count','meeting','category'),array('unit'=>$staff['unit']),'group by meeting order by meeting desc limit 2');
        foreach ($countQuery as $row) {
            if(1==$row['category'])$count1=$row['count'];
            else $count2=$row['count'];
        }


        $mainHandleMotion=array();
        $handleMotion=array();
        $mainHandleListQuery=pdoQuery('motion_view',array('motion_id'),array('step'=>5,'attr_name'=>'主办单位','content_int'=>$staff['unit']),'order by upload_time asc limit 10');
        foreach ($mainHandleListQuery as $row) {
            $mainHandleMotion[]=$row['motion_id'];
        }
        $handleListQuery=pdoQuery('motion_handler_inf_view',array('motion as motion_id'),array('step'=>5,'status'=>1,'unit'=>$staff['unit']),'limit 10');
//        mylog(getArrayInf($handleListQuery));
        foreach ($handleListQuery as $row) {
            $handleMotion[]=$row['motion_id'];
        }
        if(count($mainHandleMotion)>0){
            $mainHandleList=pdoQuery('motion_for_index_view',null,array('motion_id'=>$mainHandleMotion),null);
            foreach ($mainHandleList as $row) {
                $handleUnitMotionList[$row['category']]['main'][]=$row;
            }
        }
        if(count($handleMotion)>0){
            $handleList=pdoQuery('motion_for_index_view',null,array('motion_id'=>$handleMotion),null);
            foreach ($handleList as $row) {
                $handleUnitMotionList[$row['category']]['coop'][]=$row;
            }
        }



//        $motionId=array_merge($mainHandleMotion,$handleMotion);
//        $list=pdoQuery('motion_for_index_view',null,array('motion_id'=>$motionId),' order by category asc limit 20');
//        $motionList=array();
        foreach ($list as $row) {
            $motionList[$row['category']][]=$row;
        }


//        mylog(getArrayInf($motionList));
        printView('handle_index');
        exit();
    }
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
    $totalNumber=-1;
    $mainHandleCount=0;
    $handleCount=0;
    $staffInf=$_SESSION['staffLogin'];
    $count=isset($data['count'])?$data['count']:20;
    $category=isset($data['category'])?$data['category']:$staffInf['category'];
    $meeting=isset($data['meeting'])?$data['meeting']:$staffInf['meeting'];
    $attrOrderBy=isset($data['attr_order_by'])?$data['attr_order_by']:'编号';
    $attrOrder=isset($data['attr_order'])? $data['attr_order']:'desc';
    $page=isset($data['page'])?$data['page']:0;
    $filter=isset($data['filter'])?$data['filter']:null;
    $orderStr='order by content_int '.$attrOrder.',content '.$attrOrder;
    $sortFilter=array('meeting'=>$meeting,'attr_name'=>trim($attrOrderBy));
    $dutyList=array();
    $countFilter=array('meeting'=>$meeting);


    //获取代表委员数据，用以替换数据中的索引值
    $dutyQuery=pdoQuery('duty_view',array('duty_id','user_name','user_unit_name','user_unit','user_group','user_group_name'),array('meeting'=>$meeting),null);
    foreach ($dutyQuery as $row) {
        $dutyList[$row['duty_id']]=$row;
    }


    if('当前环节'==$attrOrderBy){
        $orderStr='order by step '.$attrOrder;
        unset($sortFilter['attr_name']);
    }
    if('编号'==$attrOrderBy){
        $orderStr='order by zx_motion '.$attrOrder;
        unset($sortFilter['attr_name']);
    }
    $field=isset($data['field'])?$data['field']:array('案号','领衔人','提案人','案别','案由','性质类别1','性质类别2','原文','当前环节','交办单位','协办单位','主办单位');

    //$sort用于储存顺序
    $sort=array();
    //$sortList用于储存返回的motion数组
    $sortList=array();
    $motionfilter=array();

    //乡镇管理员界面筛选
    if(1==count($staffInf['steps'])&&1==$staffInf['steps'][0]&&isset($staffInf['userList'])){
        $totalNumber=0;
        $motionLimit=array();
        $motionQuery=pdoQuery('motion_tbl',array('motion_id'),array('meeting'=>$meeting,'user'=>$staffInf['staffId']),null);
        foreach ($motionQuery as $row) {
            $totalNumber++;
            $motionLimit[]=$row['motion_id'];
        }
        $sortFilter['motion_id']=$motionLimit;

    }
    //办理单位界面筛选
//    mylog(getArrayInf($staffInf));
    if(1==count($staffInf['steps'])&&5==$staffInf['steps'][0]){
//        mylog();
        $motionLimit=array();
        $mainHandleLimit=array();
        $handleLimit=array();
        $canHandleLimit=array();
        $canMainHandleLimit=array();
        $totalNumber=0;
        $mainHandleCount=0;
        $handleCount=0;
        $canMainHandleCount=0;
        $canHandleCount=0;
        $mainHandleQuery=pdoQuery('attr_view',array('motion as motion_id','step'),array('meeting'=>$meeting,'attr_name'=>'主办单位','content_int'=>$staffInf['unit']),null);

        foreach ($mainHandleQuery as $row) {
            $mainHandleCount++;
            $mainHandleLimit[]=$row['motion_id'];
            if(5==$row['step']){
                $canMainHandleLimit[$row['motion_id']]=$row['motion_id'];
                $canMainHandleCount++;
            }
        }
        $handleQuery=pdoQuery('motion_handler_inf_view',array('motion as motion_id','status','step'),array('meeting'=>$meeting,'unit'=>$staffInf['unit'],'status'=>array(1,3,9)),null);
        foreach ($handleQuery as $row) {
            $handleCount++;
            $handleLimit[]=$row['motion_id'];
            if((1==$row['status']||3==$row['status'])&&5==$row['step']){
                $canHandleLimit[]=$row['motion_id'];
                $canHandleCount++;
            }
        }
        if(isset($filter['filter'])){
            switch($filter['filter']){
                case 'mainhandle':
                    $motionLimit=$mainHandleLimit;
                    $totalNumber=$mainHandleCount;
                    break;
                case 'handle':
                    $motionLimit=$handleLimit;
                    $totalNumber=$handleCount;
                    break;
                case 'can-mainhandle':
                    $query=pdoQuery('motion_handler_inf_view',array('motion as motion_id','status'),array('meeting'=>$meeting,'','motion'=>$mainHandleLimit,'status'=>array(1,3)),null);
                    foreach ($query as $hrow) {
                        mylog();
                        unset($canMainHandleLimit[$hrow['motion_id']]);
                        $canMainHandleCount--;
                    }
                    $motionLimit=$canMainHandleLimit;
                    $totalNumber=$canMainHandleCount;
                    break;
                case 'can-handle':
                    $motionLimit=$canHandleLimit;
                    $totalNumber=$canHandleCount;
                    break;

            }
        }else{
            $motionLimit=array_merge($mainHandleLimit,$handleLimit);
            $totalNumber=$mainHandleCount+$handleCount;
        }
        $sortFilter['motion_id']=$motionLimit;
    }



    if(-1==$totalNumber){
        $totalNumber=pdoQuery('motion_tbl',array('count(*) as count'),array('meeting'=>$meeting),'and step>0')->fetch()['count'];
    }
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
                $content=DataSupply::indexToValue($row['target'],$content);
            }
        }


        if(!isset($sortList[$row['motion_id']][$row['attr_name']]))$sortList[$row['motion_id']][$row['attr_name']]=$content;
        else $sortList[$row['motion_id']][$row['attr_name']].=','.$content;
        $sortList[$row['motion_id']]['案由']=$row['motion_name'];
//        $sortList[$row['motion_id']]['案别']=2==$row['category']?'建议':'提案';
        $sortList[$row['motion_id']]['当前环节']=$row['step_name'];
        $sortList[$row['motion_id']]['编号']=$row['zx_motion'];
    }

    if($singleRow){

    }
//    mylog(getArrayInf($sortList));
    echo ajaxBack(array('list'=>$sortList,'sort'=>$sort,'totalCount'=>$totalNumber,'mainHandleCount'=>$mainHandleCount,'handleCount'=>$handleCount));
//    mylog(getArrayInf($sortList));
//    return $sortList;
}

/**
 * 删除提议案属性
 * @param $data：包含属性ID
 */
function ajaxDeleteAttr($data){
    mylog(getArrayInf($data));
    try{
        $id=pdoDelete('attr_tbl',array('attr_id'=>$data['id']),' limit 1');
        echo ajaxBack('ok');
    }catch(PDOException $e){
        mylog($e->getMessage());
        echo ajaxBack(0);
    }



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
    $emptyMotion=pdoQuery('motion_tbl',array('motion_id'),array('motion_name'=>'新建','duty'=>0,'category'=>$staff['category'],'user'=>$staff['staffId']),'and step>0 limit 1')->fetch();
    pdoTransReady();
    if($emptyMotion){
        editMotion(array('id'=>$emptyMotion['motion_id']));

    }else{
        try{
            $id=pdoInsert('motion_tbl',array('meeting'=>$staff['meeting'],'category'=>$staff['category'],'motion_name'=>'新建','motion_template'=>$meetingInf['motion_template'],'step'=>1,'user'=>$staff['staffId']));
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
    $id=$data['id'];
    $_SESSION['staffLogin']['currentMotion']=$id;
    $canMainHandler=false;

//    $attrFilter=array('motion_id'=>$id,'attr_step'=>$_SESSION['staffLogin']['steps']); //只显示当前步骤所需填写的选项
    $attrFilter=array('motion_id'=>$id);
    $meetingInf=pdoQuery('motion_inf_view',null,array('motion_id'=>$id),' limit 1')->fetch();
//    mylog();
    //处理政协提案有不同交办单位的情况
    $step4CanEdit=true;
    if(4==$meetingInf['step']||5==$meetingInf['step']){
        $staffId=$_SESSION['staffLogin']['staffId'];
        if(2==$meetingInf['category']){
            $step4Inf=pdoQuery('motion_view',array('content_int'),array('motion_id'=>$id,'content_int'=>$staffId,'attr_name'=>'交办单位'),'limit 1')->fetch();
            if(!$step4Inf['content_int']){
                $step4CanEdit=false;
            }
        }else{
            $step4Inf=pdoQuery('motion_view',array('content_int'),array('motion_id'=>$id,'attr_name'=>'交办单位'),'limit 1')->fetch();
            if($step4Inf['content_int']==$staffId){
                $step4CanEdit=true;
            }else{
                if('5103'==$staffId||'6726'==$staffId)$step4CanEdit=true;
                else $step4CanEdit=false;
            }
        }
    }else{

    }

    //处理主办单位是否可办理的情况
    if(5==$meetingInf['step']&&in_array(5,$_SESSION['staffLogin']['steps'])){

        $staffUnit=$_SESSION['staffLogin']['unit'];
        $mainHandlerInf=pdoQuery('motion_view',array('content_int'),array('motion_id'=>$id,'content_int'=>$staffUnit,'attr_name'=>'主办单位'),'limit 1')->fetch();
        if($mainHandlerInf){
            $handler=pdoQuery('motion_handler_tbl',array('motion_handler_id'),array('motion'=>$id,'status'=>array(1,3)),'limit 1')->fetch();
            mylog(getArrayInf($handler));
            if(!$handler)$canMainHandler=true;
        }
    }
//    mylog($step4CanEdit);
    $motionQuery=pdoQuery('motion_view',null,$attrFilter,' order by value_sort desc,motion_attr asc');
    $unitGroupInf=null;
    unset($_SESSION['staffLogin']['passUnique']);
    foreach ($motionQuery as $row) {
        if('案号'==$row['attr_name']&&$row['content_int']>0)$_SESSION['staffLogin']['passUnique']=$row['content_int'];//获取案号
        $values = $row;
        $optionArray = json_decode($row['option'], true);
        $values['edit']=false;
        if(in_array($row['step'],$_SESSION['staffLogin']['steps'])){
            if($row['step']==$row['attr_step']){
                if(4!=$row['step'])$values['edit']=true;
                if($step4CanEdit&&4==$row['step'])$values['edit']=true;
                if($canMainHandler&&5==$row['step'])$values['edit']=true;
            }
            if(2==$row['step']&&1==$row['attr_step'])$values['edit']=true;
            if('性质'==$row['attr_name']&&3==$row['step'])$values['edit']=true;
        }
        if('提案联系人'==$row['attr_name']&&in_array(3,$_SESSION['staffLogin']['steps']))$values['edit']=true;

        //将attr数据转化为可为用户观看的内容
        $values['content']=setAttrValue($row);

        if($values['edit'])
        {//如操作员流程权限与当前权限吻合，则可修改当前流程选项
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

//                $values['filter']
            }

            //如果属性属于办理环节，则所有该环节属性放入临时数组，等待下一步判断是否有办理权限,已作废
//            if(5==$row['attr_step']&&5==$row['step']){
//                $mainHandler[$row['attr_name']]=$values;
//                continue;
//            }
            //如果属性支持多值情况的处理
            if(1==$values['multiple']){
//                mylog('multiple');
                //如果此属性已包含一个值，且有新值存在，则把值放入multiple_value数组中，存入前先将表内索引值转换为对应的名称
                if(isset($motion[$row['attr_name']])&&$values['content']){
                    mylog(getArrayInf($values));
                    $motion[$row['attr_name']]['multiple_value'][$values['attr_id']]=array('content'=>$values['content'],'attachment'=>$values['attachment']);

                //如果新值存在且此属性并未包含值
                }elseif($values['content']){
                    mylog('has content');
                    $motion[$row['attr_name']]=$values;
                    $motion[$row['attr_name']]['multiple_value'][$values['attr_id']]=array('content'=>$values['content'],'attachment'=>$values['attachment']);
                    mylog($row['attr_name'].': '.getArrayInf($motion));
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
            if(1==$values['multiple']){
                if(isset($motion[$row['attr_name']])){
                    if($row['attachment']){
                        $motion[$row['attr_name']]['content'][]=array('content'=>$values['content'],'attachment'=>$values['attachment']);
                    }else{
                        $tContent= $motion[$row['attr_name']]['content'].','.$values['content'];
                        $tContent=trim($tContent,',');
                        $motion[$row['attr_name']]['content']=$tContent;
                    }
                }else{
                    if($row['attachment']){
                        $motion[$row['attr_name']]=$values;
                        $motion[$row['attr_name']]['content']=array();
                        $motion[$row['attr_name']]['content'][]=array('content'=>$values['content'],'attachment'=>$values['attachment']);
                    }else{
                        $motion[$row['attr_name']]=$values;
                    }
                }



            }else{
                $motion[$row['attr_name']]=$values;
            }
        }

        //获取领衔人信息
        if('领衔人'==$row['attr_name']||'提案人'==$row['attr_name']){
            $query=pdoQuery('duty_view',null,array('duty_id'=>$row['content_int']),'limit 1')->fetch();
            $unitGroupInf=array('unit'=>$query['user_unit_name'],'group'=>$query['user_group_name']);
        }
    }
    $currentStep=current($motion)['step'];
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
            $handlerQuery=pdoQuery('motion_handler_view',null,array('motion'=>$id,'status'=>array('1','3','9')),null);
            $handlerDisplay=array();
            $handlerEdit=array();
            foreach ($handlerQuery as $row) {
                if($row['unit']==$unit&&1==$row['status']&&in_array(5,$_SESSION['staffLogin']['steps'])){
                    $handlerEdit=$row;
                }else{
                    $handlerDisplay[]=$row;
                }
            }
            break;
    }
//    mylog(getArrayInf($motion));
    include '/view/edit_motion1.html.php';
    return;
}

/**
 * 解析motion_view中获取的数据，将索引或时间戳转换成可显示的值
 * @param  motion_view中的一条数据
 * @return 转换后的内容
 */
function setAttrValue($row){
    $content=$row['content']?$row['content']:'';
    if('int'==$row['value_type'])$content=$row['content_int'];
    if('time'==$row['value_type']&&$row['content_int']>0)$content=date('Y-m-d',$row['content_int']);
    if($row['target']){
        $content=DataSupply::indexToValue($row['target'],$row['content_int']);
    }
    return $content;
}

function ajaxDeleteMotion($data){
    $id=$data['id'];
    mylog(getArrayInf($data));
    $motionInf=pdoQuery('motion_tbl',null,array('motion_id'=>$id),'limit 1')->fetch();
    if($motionInf['step']<4&&in_array(3,$_SESSION['staffLogin']['steps'])){
       pdoUpdate('motion_tbl',array('step'=>0),array('motion_id'=>$id),' limit 1');
        echo ajaxBack('ok');
    }else{
        echo ajaxBack('no');
    }
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
//    mylog(getArrayInf($groupList));
    echo ajaxBack($groupList);
}

/**ajax填充议案属性
 * @param $data {step:1,data:values}
 */
function updateAttr($data){
    $isFoward=$data['step'];
    $motionId=$_SESSION['staffLogin']['currentMotion'];
    $motion=pdoQuery('motion_tbl',null,array('motion_id'=>$motionId),' limit 1')->fetch();
    $currentStep=$motion['step'];
    $attrs=isset($data['data'])?$data['data']:array();
    $uniqueInf=pdoQuery('motion_attr_view',null,array('attr_name'=>'案号','motion_template'=>$motion['motion_template']),'limit 1')->fetch()['motion_attr_id'];
    $uniqueQuery=pdoQuery('attr_unique_view',array('content_int as value'),array('motion_attr'=>$uniqueInf,'meeting'=>$motion['meeting']),null);
    $uniqueValues=array();
    foreach($uniqueQuery as $row){
        $uniqueValues[]=$row['value'];
    }
    pdoTransReady();
    try{
        foreach ($attrs as $row) {
            if($uniqueInf==$row['motion_attr']){
                if(in_array($row['value'],$uniqueValues)){
                    if(!isset($_SESSION['staffLogin']['passUnique'])){
                        $e=new PDOException();
                        $e->errorInfo="unique";
                        throw $e;
                    }else{
                        if($_SESSION['staffLogin']['passUnique']!=$row['value']){
                            $e=new PDOException();
                            $e->errorInfo="unique";
                            throw $e;
                        }
                    }

                }
            }
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
                $value['content']=addslashes($row['value']);
            }
//            mylog(getArrayInf($value));
            pdoInsert('attr_tbl',$value,'update');
        }
        if(1==$motion['step']||2==$motion['step']){//将“案由”和“领衔人”属性与motion表中的motion_name,duty字段同步
            $attr=pdoQuery('attr_view',array('content','content_int'),array('motion'=>$motionId,'attr_name'=>array('案由','领衔人','提案人')),'order by attr_name asc')->fetchAll();
            $name='';
            $duty='0';
            foreach ($attr as $row) {
                if($row['content'])$name=$row['content'];
                else $duty=$row['content_int'];
            }
            pdoUpdate('motion_tbl',array('motion_name'=>$name,'duty'=>$duty),array('motion_id'=>$motionId),'limit 1');
        }
        //点击下一步的操作
        if($isFoward>0){
            $currentStep++;
            pdoUpdate('motion_tbl',array('step'=>$currentStep),array('motion_id'=>$motionId));
            if(4==$motion['step']){
                $handlerList=pdoQuery('attr_view',null,array('motion'=>$motionId,'attr_name'=>'协办单位'),null);
                pdoUpdate('motion_handler_tbl',array('status'=>7),array('motion'=>$motionId));
                foreach ($handlerList as $row) {
                    pdoInsert('motion_handler_tbl',array('motion'=>$motionId,'attr'=>$row['attr_id'],'unit'=>$row['content_int'],'status'=>1),'update');
                }
            }


            //审核未通过的情况下，将提议案步骤直接设置为完成
            if(3==$motion['step']){
                $attr=pdoQuery('attr_view',array('content'),array('motion'=>$motionId,'attr_name'=>'审核'.$motion['category']),'limit 1')->fetch();
                if('不予立案'==$attr['content']){
                    pdoUpdate('motion_tbl',array('step'=>7),array('motion_id'=>$motionId));
                }
            }
            if(6==$motion['step']){
                $attr=pdoQuery('attr_view',array('content'),array('motion'=>$motionId,'attr_name'=>array('办理工作','办理结果').$motion['category']),'limit 2')->fetchAll();
                foreach ($attr as $row) {
                    if('不满意'==$row['content']){
                        pdoUpdate('motion_tbl',array('step'=>6),array('motion_id'=>$motionId));
                        break;
                    }
                }

            }

        }elseif($isFoward<0){
            pdoUpdate('motion_tbl',array('step'=>$motion['step']-1),array('motion_id'=>$motionId));
        }
        if(5==$motion['step']){
            if(isset($data['handler'])){
                mylog(getArrayInf($data['handler']));
                $handleDate=$data['handler'];
                mylog(getArrayInf($handleDate));
                if($handleDate){
                    if($data['confirm'])$handleDate['status']=9;
                    $handleDate['receive_time']=time();
                    $handleDate['reply_time']=time();
                    $handleDate['staff']=$_SESSION['staffLogin']['staffId'];
                    mylog(getArrayInf($handleDate));
                    pdoInsert('motion_handler_tbl',$handleDate,'update');
                }
            }
        }

//        if($data['step'])exeNew('update motion_tbl set step=step+1 where motion_id='.$motionId);

        pdoCommit();
        echo ajaxBack(array('step'=>$currentStep,'id'=>$motionId));
    }catch(PDOException $e){
//        mylog($e->getMessage());
//        mylog($e->errorInfo);
        pdoRollBack();
//        mylog('出错');
        echo ajaxBack($e->errorInfo);
    }


}

/**
 * ajax获取目标表的内容
 * @param $data
 */
function ajaxTargetList($data){
//    mylog(getArrayInf($data));
//    mylog(getArrayInf($_SESSION['staffLogin']));
    $target=$data['target'];
    $filter=isset($data['filter'])?$data['filter']:null;
    $backList=array();
    switch($target){
        case 'duty':
            $filter=array('category'=>$_SESSION['staffLogin']['category'],'activity'=>1);
            if(isset($_SESSION['staffLogin']['userList']))$filter=array_merge($filter,$_SESSION['staffLogin']['userList'],array('category'=>$_SESSION['staffLogin']['category'],'activity'=>1));
            $dutyQuery=pdoQuery('duty_view',null,$filter,null);

//            foreach ($dutyQuery as $row) {
                if(2==$_SESSION['staffLogin']['category']){
                    $backList['unitFilt']['name']='按委组';
                    $backList['groupFilt']['name']='按界别';
                    $backList['unitGroup']['name']='党派团体';
                    foreach ($dutyQuery as $row) {
                        if($row['user_group']&&$row['user_unit']){
                            if(!isset($backList['unitFilt']['list'][$row['user_unit']])){
                                $backList['unitFilt']['list'][$row['user_unit']]=array('name'=>$row['user_unit_name'],'id'=>0);
                            }
                            $backList['unitFilt']['list'][$row['user_unit']]['sub'][]=array('name'=>$row['user_name'],'id'=>$row['duty_id']);
                            if(!isset($backList['groupFilt']['list'][$row['user_group']])){
                                $backList['groupFilt']['list'][$row['user_group']]=array('name'=>$row['user_group_name'],'id'=>0);
                            }
                            $backList['groupFilt']['list'][$row['user_group']]['sub'][]=array('name'=>$row['user_name'],'id'=>$row['duty_id']);

                        }else{
                            $backList['unitGroup']['list'][$row['duty_id']]=array('name'=>$row['user_name'],'id'=>$row['duty_id']);
                        }
                    }

                }else{
                    foreach ($dutyQuery as $row) {
                        if(!isset($backList['user_unit'][$row['user_unit']])){
                            $backList['user_unit'][$row['user_unit']]=array('name'=>$row['user_unit_name'],'id'=>'0');
                        }
                        $backList['user_unit'][$row['user_unit']]['sub'][]=array('name'=>$row['user_name'],'id'=>$row['duty_id']);
                    }

                }
//            }
            echo ajaxBack($backList);
            break;
        case 'unit':
            $motionInf=pdoQuery('motion_tbl',null,array('motion_id'=>$_SESSION['staffLogin']['currentMotion']),'limit 1')->fetch();
            $step=$motionInf['step']+1;
            if($filter)$str='and steps like "%'.$step.'%"';
            else $str='where steps like "%'.$step.'%"';
            $unitQuery=pdoQuery('unit_tbl',null,$filter,$str);
            foreach ($unitQuery as $row) {
                if(0!=$row['parent_unit']){
                    $backList[0][$row['parent_unit']]['sub'][]=array('name'=>$row['unit_name'],'id'=>$row['unit_id']);
                }else{
                    $backList[0][$row['unit_id']]['name']=$row['unit_name'];
                    $backList[0][$row['unit_id']]['id']=$row['member']?$row['unit_id']:0;
                }

            }
//            mylog(getArrayInf($backList));
            echo ajaxBack($backList);
            break;
        case 'staff':

            $motionInf=pdoQuery('motion_tbl',null,array('motion_id'=>$_SESSION['staffLogin']['currentMotion']),'limit 1')->fetch();
            $step=$motionInf['step']+1;
            if($filter)$str='and steps like "%'.$step.'%"';
            else $str='where steps like "%'.$step.'%"';
            $staffQuery=pdoQuery('staff_admin_view',null,$filter,$str);
            foreach ($staffQuery as $row) {
                if(!isset($backList[0][$row['unit']]))$backList[0][$row['unit']]=array('name'=>$row['unit_name'],'id'=>0);
                $backList[0][$row['unit']]['sub'][]=array('name'=>$row['full_name'],'id'=>$row['staff_id']);
            }
            echo ajaxBack($backList);
            break;
        case 'motion':
            if('all'!=$_SESSION['staffLogin']['meeting'])$filter['meeting']=$_SESSION['staffLogin']['meeting'];
            $motionList=pdoQuery('motion_tbl',null,$filter,' and step>0');
            foreach ($motionList as $row) {
                $backList['list'][]=array('name'=>$row['motion_name'],'id'=>$row['motion_id']);
            }
            echo ajaxBack($backList);

        default:
            break;



    }
}

/**
 * 通过ajax获取代表委员信息
 * @param $data：委员id:{"id":5}
 */
function ajaxUserInf($data){
    $where=array('duty_id'=>$data['id']);
    $inf=pdoQuery('duty_view',null,$where,'limit 1')->fetch();
    echo ajaxBack($inf);
}

/**
 * 已知指定attr_id数据中保存的数据为委员duty_id,获取该代表委员信息
 * @param $data 保存attr_id {attrId:id}
 */
function ajaxUserInfFromAttrTbl($data){
    $dutyId=pdoQuery('attr_tbl',array('content_int'),array('attr_id'=>$data['attrId']),'limit 1')->fetch()['content_int'];
    $inf=pdoQuery('duty_view',null,array('duty_id'=>$dutyId),'limit 1')->fetch();
    echo ajaxBack($inf);
}

function ajaxGetSingleDutyId($data){
    $name=trim($data['name']);
    if($name){
        mylog($name);
        $where['user_name']=$name;
        if(isset($_SESSION['staffLogin']['userList']))$where=array_merge($where,$_SESSION['staffLogin']['userList']);
        $inf=pdoQuery('duty_view',array('duty_id'),$where,'limit 1')->fetch();
        if($inf){
            echo ajaxBack($inf['duty_id']);
            return;
        }
    }
    echo ajaxBack(0);


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
//    mylog('unsetted:'.getArrayInf($_SESSION));
    echo ajaxBack('ok');
}

/**
 * 使用phpEcxel解析excel文件
 */
function encodeExcel(){

    exit;
}

/**
 * ajax获取提案议案流程信息
 * @param $data 包含motionId
 */
function getMotionStepInf($data){
    $motionStepInf=pdoQuery('motion_step_inf_view',null,array('motion_id'=>$data['id']),'order by step limit 8')->fetchAll();
    if(!$motionStepInf)$motionStepInf=arrray();
    include 'view/motion_step_info.html.php';
    return;
}
