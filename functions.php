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
include_once 'includes/DataSupply.class.php';
function userAuth($userName, $password, $category = 3)
{
    $localStaff = false;
    $staffFilter = array('staff_name' => $userName);
//    if($category<3&&$category>0)$staffFilter['category']=$category;
    if ($staffQuery = pdoQuery('staff_tbl', null, $staffFilter, ' limit 1')->fetch()) {
        $metting = pdoQuery('meeting_tbl', null, array('category' => $staffQuery['category']), ' order by deadline_time desc limit 1')->fetch();
        if ($password == $staffQuery['staff_password'] && $staffQuery['staff_password'] != '') {//自创建用户
            $localStaff = 1;
        } else {//查询党政信息网
            $userVerify = file_get_contents("http://172.19.48.144:88/Verify?Username=$userName&Password=$password");
            mylog('outerStaffLogin name:' . $userName . ',status:' . $userVerify);
            if ('SUCCESS' == $userVerify) {
                $localStaff = 2;
            }
        }
    } else {
//        mylog('notInList');
    }

    if ($localStaff) {
        if (!$staffQuery['steps']) return;
        $_SESSION['staffLogin'] = array();
        $_SESSION['staffLogin']['steps'] = array();
        for ($i = 0; $i < strlen($staffQuery['steps']); $i++) {
            $_SESSION['staffLogin']['steps'][] = (string)$staffQuery['steps'][$i];
        }
        $_SESSION['staffLogin']['category'] = $staffQuery['category'];
        $_SESSION['staffLogin']['meeting'] = isset($metting) ? $metting['meeting_id'] : 'all';
        $_SESSION['staffLogin']['unit'] = $staffQuery['unit'];
        $_SESSION['staffLogin']['staffId'] = $staffQuery['staff_id'];
        $_SESSION['staffLogin']['staffName'] = $staffQuery['full_name'];
        $_SESSION['staffLogin']['outId'] = $staffQuery['out_id'];
        $userAdmin = json_decode($staffQuery['user_admin']);
        foreach ($userAdmin as $k => $v) {
            $_SESSION['staffLogin']['userList'][$k] = $v;
        }
        getIndex();
//        mylog(getArrayInf($_SESSION['staffLogin']));
        exit;
    } else {
        return;
    }
}

/**
 * 获取对应流程权限的提议案列表
 * @param $steps
 */
function getIndex($orderBy = 'default')
{
    $staff = $_SESSION['staffLogin'];
//    mylog(getArrayInf($staff));
    global $motionList, $meetingList, $handleUnitMotionList, $category;
    $meetingList = array();
    $motionList = array();
    $category = $staff['category'];
    $motionListFilter = array();
    //人大代工委临时处理
    if(1==$category&&2==count($staff['steps'])&&in_array(1,$staff['steps'])&&in_array(2,$staff['steps'])){
        $meeting=pdoQuery('meeting_tbl',['meeting_id'],['category'=>1],'order by deadline_time desc')->fetch()['meeting_id'];
        header('location:index.php?get_meeting='.$meeting);
        return;
    }


    foreach ($staff['steps'] as $step) {
        if(1==$category&&6==$step)continue;
        if (4 == $step) continue;//如果用户有交办权限，则从筛选器中删除4，待下一步处理
        $motionListFilter['step'][] = $step;
    }
    $meetingListFilter = null;
    $motionId = array();
    if ($staff['category'] < 3) {
        $motionListFilter['category'] = $category;
        $meetingListFilter['category'] = $category;
    }

    if (in_array(4, $staff['steps'])) {//交办权限的情况
        $defaultUnit = '5103' == $staff['staffId'] || '6726' == $staff['staffId'] ? 'or content_int is null or content_int=5103' : '';
        $motionLimit = array();
        $unitQuery1 = pdoQuery('motion_view', array('motion_id', 'motion_name', 'step_name', 'category', 'content_int'), array('category' => 1, 'step' => 4, 'attr_name' => '交办单位'), 'and(content_int=' . $staff['staffId'] . ' ' . $defaultUnit . ' )  limit 10')->fetchAll();
        $unitQuery2 = pdoQuery('motion_view', array('motion_id', 'motion_name', 'step_name', 'category', 'content_int'), array('category' => 2, 'step' => 4, 'attr_name' => '交办单位'), 'and(content_int=' . $staff['staffId'] . ' ' . $defaultUnit . ' )  limit 10')->fetchAll();
        for ($i = 0; $i < 20; $i++) {
            if (isset($unitQuery1[$i])) $motionLimit[] = $unitQuery1[$i]['motion_id'];
            if (isset($unitQuery2[$i])) $motionLimit[] = $unitQuery2[$i]['motion_id'];
        }
        if (count($motionLimit) > 0) {
            mylog('limit > 0');
            $motionListFilter['motion_id'] = $motionLimit;
            $motionListFilter['step'][] = 4;
        }
    }

    //人大乡镇管理员界面
    if(1==$category&&in_array(6, $staff['steps'])&&in_array(1, $staff['steps'])){
        if(isset($staff['userList'])&&$staff['userList']){
            $motionLimit=array();
            $tempLimit=$staff['userList'];
            $tempLimit['attr_name']="领衔人";
            $tempLimit['step']=[1,6];
            $query=pdoQuery('s_duty_view',['motion_id'],$tempLimit,'order by meeting desc limit 20');
            foreach ($query as $limitRow) {
                $motionLimit[]=$limitRow['motion_id'];
            }
            if (count($motionLimit) > 0) {
                $motionListFilter['motion_id'] = $motionLimit;
                $motionListFilter['step'][] = [1,6];
            }
        }
    }
    if (count($motionListFilter) > 0) {
        $list = pdoQuery('motion_for_index_view', null, $motionListFilter, ' order by category asc limit 20');
    } else {
        $list = array();
    }


    foreach ($list as $row) {
        $motionId[] = $row['motion_id'];
        $motionList[$row['category']][$row['motion_id']] = $row;
    }
    $meeting = pdoQuery('meeting_tbl', null, $meetingListFilter, 'order by start_time asc');
    foreach ($meeting as $row) {
        $meetingList[$row['category']][$row['meeting_id']] = $row;
    }
    if (1 == count($staff['steps']) && 1 == $staff['steps'][0]) {
        $motionList = array();
        $list = pdoQuery('motion_for_index_view', null, array_merge($motionListFilter, array('user' => $staff['staffId'])), ' order by category asc limit 20');
        foreach ($list as $row) {
//            $motionId[]=$row['motion_id'];
            $motionList[$row['category']][$row['motion_id']] = $row;
        }

    }


    if (in_array(5, $staff['steps']) && 1 == count($staff['steps']) && isset($motionId)) {
        global $mainCount1, $mainCount2, $count1, $count2;
        $mainCount1 = 0;
        $mainCount2 = 0;
        $count1 = 0;
        $count2 = 0;
        $mainCountQuery = pdoQuery('motion_view', array('category', 'meeting', 'count(*) as count'), array('attr_name' => '主办单位', 'content_int' => $staff['unit']), 'group by meeting order by meeting desc limit 2');
        foreach ($mainCountQuery as $row) {
            if (1 == $row['category']) $mainCount1 = $row['count'];
            else $mainCount2 = $row['count'];
        }
        $countQuery = pdoQuery('motion_handler_inf_view', array('count(*) as count', 'meeting', 'category'), array('unit' => $staff['unit'], 'status' => array(1, 9)), 'group by meeting order by meeting desc limit 2');
        foreach ($countQuery as $row) {
            if (1 == $row['category']) $count1 = $row['count'];
            else $count2 = $row['count'];
        }


        $mainHandleMotion = array();
        $handleMotion = array();
        $mainHandleListQuery = pdoQuery('motion_view', array('motion_id'), array('step' => 5, 'attr_name' => '主办单位', 'content_int' => $staff['unit']), 'order by upload_time asc limit 10');
        foreach ($mainHandleListQuery as $row) {
            $mainHandleMotion[] = $row['motion_id'];
        }
        $handleListQuery = pdoQuery('motion_handler_inf_view', array('motion as motion_id'), array('step' => 5, 'status' => 1, 'unit' => $staff['unit']), 'limit 10');
//        mylog(getArrayInf($handleListQuery));
        foreach ($handleListQuery as $row) {
            $handleMotion[] = $row['motion_id'];
        }
        if (count($mainHandleMotion) > 0) {
            $mainHandleList = pdoQuery('motion_for_index_view', null, array('motion_id' => $mainHandleMotion), null);
            foreach ($mainHandleList as $row) {
                $handleUnitMotionList[$row['category']]['main'][] = $row;
            }
        }
        if (count($handleMotion) > 0) {
            $handleList = pdoQuery('motion_for_index_view', null, array('motion_id' => $handleMotion), null);
            foreach ($handleList as $row) {
                $handleUnitMotionList[$row['category']]['coop'][] = $row;
            }
        }


//        $motionId=array_merge($mainHandleMotion,$handleMotion);
//        $list=pdoQuery('motion_for_index_view',null,array('motion_id'=>$motionId),' order by category asc limit 20');
//        $motionList=array();
        foreach ($list as $row) {
            $motionList[$row['category']][] = $row;
        }


//        mylog(getArrayInf($motionList));
        printView('handle_index');
        exit();
    }
    printView('index');
}

function getMeetingView($id)
{
    global $meetingInf,$isCurrent;
    $meetingInf = pdoQuery('meeting_tbl', null, array('meeting_id' => $id), 'limit 1')->fetch();
    printView('meeting');
}
function getDutyView($id){
    global$meetingInf;
    $meetingInf = pdoQuery('meeting_tbl', null, array('meeting_id' => $id), 'limit 1')->fetch();
    printView('duty');
}


/**
 * ajax访问获取提议案列表
 * @param $data
 */
function ajaxMotionList($data)
{
    $totalNumber = -1;
    $mainHandleCount = 0;
    $handleCount = 0;
    $staffInf = $_SESSION['staffLogin'];
    $count = isset($data['count']) ? $data['count'] : 20;
    $category = isset($data['category']) ? $data['category'] : $staffInf['category'];
    $meeting = isset($data['meeting']) ? $data['meeting'] : $staffInf['meeting'];
    $attrOrderBy = isset($data['attr_order_by']) ? $data['attr_order_by'] : '编号';
    $attrOrder = isset($data['attr_order']) ? $data['attr_order'] : 'desc';
    $page = isset($data['page']) ? $data['page'] : 0;
    $filter = isset($data['filter']) ? $data['filter'] : null;
    $orderStr = 'order by content_int ' . $attrOrder . ',content ' . $attrOrder;
    $sortFilter = array('meeting' => $meeting, 'attr_name' => trim($attrOrderBy));
    $dutyList = array();
    $countFilter = array('meeting' => $meeting);


    //获取代表委员数据，用以替换数据中的索引值
    $dutyQuery = pdoQuery('duty_view', array('duty_id', 'user_name', 'user_unit_name', 'user_unit', 'user_group', 'user_group_name'), array('meeting' => $meeting), null);
    foreach ($dutyQuery as $row) {
        $dutyList[$row['duty_id']] = $row;
    }


    if ('当前环节' == $attrOrderBy) {
        $orderStr = 'order by step ' . $attrOrder;
        unset($sortFilter['attr_name']);
    }
    if ('编号' == $attrOrderBy) {
        $orderStr = 'order by zx_motion ' . $attrOrder;
        unset($sortFilter['attr_name']);
    }
    $field = isset($data['fields']) ? $data['fields'] : array('案号', '领衔人', '提案人', '案别', '案由', '性质类别1', '性质类别2', '原文', '当前环节', '交办单位', '协办单位', '主办单位');

    //$sort用于储存顺序
    $sort = array();
    //$sortList用于储存返回的motion数组
    $sortList = array();
    $motionfilter = array();

    //乡镇管理员界面筛选
    if (1 == $staffInf['category']&&isset($staffInf['userList'])&&$staffInf['userList']) {
        mylog($staffInf);
        $totalNumber = 0;
        $motionLimit = array();
        $tempFilter=$staffInf['userList'];
        $tempFilter['attr_name']="领衔人";
        $tempFilter['meeting']=$meeting;
        $motionQuery = pdoQuery('s_duty_view', array('motion_id'), $tempFilter, null);
        foreach ($motionQuery as $row) {
            $totalNumber++;
            $motionLimit[] = $row['motion_id'];
        }
//        if(count($motionLimit)>0)$sortFilter['motion_id'] = $motionLimit;
        $sortFilter['motion_id'] = $motionLimit;
    }
    //办理单位界面筛选
    if (1 == count($staffInf['steps']) && 5 == $staffInf['steps'][0]) {
//        mylog();
        $motionLimit = array();
        $mainHandleLimit = array();
        $handleLimit = array();
        $canHandleLimit = array();
        $canMainHandleLimit = array();
        $totalNumber = 0;
        $mainHandleCount = 0;
        $handleCount = 0;
        $canMainHandleCount = 0;
        $canHandleCount = 0;
        $mainHandleQuery = pdoQuery('attr_view', array('motion as motion_id', 'step'), array('meeting' => $meeting, 'attr_name' => '主办单位', 'content_int' => $staffInf['unit']), null);

        foreach ($mainHandleQuery as $row) {
            $mainHandleCount++;
            $mainHandleLimit[] = $row['motion_id'];
            if (5 == $row['step']) {
                $canMainHandleLimit[$row['motion_id']] = $row['motion_id'];
                $canMainHandleCount++;
            }
        }
        $handleQuery = pdoQuery('motion_handler_inf_view', array('motion as motion_id', 'status', 'step'), array('meeting' => $meeting, 'unit' => $staffInf['unit'], 'status' => array(1, 3, 9)), null);
        foreach ($handleQuery as $row) {
            $handleCount++;
            $handleLimit[] = $row['motion_id'];
            if ((1 == $row['status'] || 3 == $row['status']) && 5 == $row['step']) {
                $canHandleLimit[] = $row['motion_id'];
                $canHandleCount++;
            }
        }
        if (isset($filter['filter'])) {
            switch ($filter['filter']) {
                case 'mainhandle':
                    $motionLimit = $mainHandleLimit;
                    $totalNumber = $mainHandleCount;
                    break;
                case 'handle':
                    $motionLimit = $handleLimit;
                    $totalNumber = $handleCount;
                    break;
                case 'can-mainhandle':
                    $query = pdoQuery('motion_handler_inf_view', array('motion as motion_id', 'status'), array('meeting' => $meeting, '', 'motion' => $mainHandleLimit, 'status' => array(1, 3)), null);
                    foreach ($query as $hrow) {
//                        mylog();
                        unset($canMainHandleLimit[$hrow['motion_id']]);
                        $canMainHandleCount--;
                    }
                    $motionLimit = $canMainHandleLimit;
                    $totalNumber = $canMainHandleCount;
                    break;
                case 'can-handle':
                    $motionLimit = $canHandleLimit;
                    $totalNumber = $canHandleCount;
                    break;

            }
        } else {
            $motionLimit = array_merge($mainHandleLimit, $handleLimit);
            $totalNumber = $mainHandleCount + $handleCount;
        }
        $sortFilter['motion_id'] = $motionLimit;
    }

    //搜索
    if (isset($filter['search'])) {
        $attrName = $filter['search']['attr_name'];
        $attrValue = $filter['search']['attr_value'];
        $attrType = $filter['search']['attr_type'];
        if(isset($filter['search']['motion_id_limit']))$originalLimit=$filter['search']['motion_id_limit'];
        $intLimit = array();
        $searchLimit=array();
        $searchQuery=new PDOStatement();
        switch ($attrType) {
            case 'int':
                $searchQuery = pdoQuery('motion_view', array('motion_id'), array('attr_name' => $attrName, 'content_int' => $attrValue), null);
                break;
            case 'duty':
                if(2==$category&&2==mb_strlen($attrValue)){
                    $attrValue=mb_substr($attrValue,0,1).'%'.mb_substr($attrValue,1,1);
                    mylog($attrValue);
                }
//                mylog(mb_strlen($attrValue));
                $searchDuty=pdoQuery('duty_view',array('duty_id'),null,'where user_name like "%'.$attrValue.'%" and activity=1')->fetchAll();
                $searchQuery=pdoQuery('motion_view',array('motion_id'),array('attr_name'=>$attrName,'content_int'=>$searchDuty,'meeting'=>$meeting),null);
                break;
            case 'unit':
                $searchUnit=pdoQuery('unit_tbl',array('unit_id'),null,'where unit_name like "%'.$attrValue.'%"')->fetchAll();
                $searchQuery=pdoQuery('motion_view',array('motion_id'),array('attr_name'=>$attrName,'content_int'=>$searchUnit,'meeting'=>$meeting),null);
                break;
            default:
                $searchQuery = pdoQuery('motion_view', array('motion_id'), array('attr_name' => $attrName,'category'=>$category,'meeting'=>$meeting), "and content like \"%$attrValue%\"");
                break;
        }
        foreach ($searchQuery as $row) {
            $searchLimit[]=$row['motion_id'];
        }
        if(isset($sortFilter['motion_id'])){
            $sortFilter['motion_id']=array_intersect($sortFilter['motion_id'],$searchLimit);
        }else{
            $sortFilter['motion_id']=$searchLimit;
        }
        if(isset($originalLimit)&&$originalLimit){
            mylog(getArrayInf($originalLimit));
            $sortFilter['motion_id']=array_intersect($sortFilter['motion_id'],$originalLimit);
        }
        $totalNumber=count($sortFilter['motion_id']);

    }

    //综合搜索
    if(isset($filter['multiple_search'])){
//        mylog(getArrayInf($filter));
        $searchLimit=null;
//        $multipleSearchFilter=null;
        $multipleSearchTempFilter=array('meeting'=>$meeting);
        $multipleSearchMotionLimit=null;
        $filterDetail=$filter['multiple_search'];
        if(isset($filterDetail['user_unit'])){
            $multipleSearchTempFilter['user_unit']=$filterDetail['user_unit']['value'];
            unset($filterDetail['user_unit']);
        }
        if(isset($filterDetail['user_group'])){
            $multipleSearchTempFilter['user_group']=$filterDetail['user_group']['value'];
            unset($filterDetail['user_group']);
        }
        if(count($multipleSearchTempFilter)>1){
            $attrName=1==$category?"领衔人":"提案人";
            $multipleDutyList=pdoQuery('duty_tbl',array('duty_id'),$multipleSearchTempFilter,null)->fetchAll();
            $multipleSearchMotionLimit=pdoQuery('motion_view',['motion_id'],['attr_name'=>$attrName,'content_int'=>$multipleDutyList,'meeting'=>$meeting],null);
            foreach ($multipleSearchMotionLimit as $row) {
                $searchLimit[]=$row['motion_id'];
            }
        }


//        mylog(getArrayInf($filter['multiple_search']));
        foreach($filterDetail as $k=>$v){
            $sMotionAttr=$v['motionAttr'];
            $sType=$v['type'];
            $sValue=$v['value'];
            $sWhere=['motion_attr'=>$sMotionAttr];
            if(is_array($searchLimit)&&count($searchLimit)>0)$sWhere['motion']=$searchLimit;
            elseif(is_array($searchLimit)&&0==count($searchLimit))break;
            $str=null;
            switch($sType){
                case 'string':
                    $str=' and content like "%'.$sValue.'%"';
                    break;
                case 'option':
                    $sWhere['content']=$sValue;
                    break;
                case 'int':
                    $sWhere['content_int']=$sValue;
                    break;
                default:
                    $sWhere['content_int']=$sValue;
                    break;
            }

            $motionQuery=pdoQuery('attr_tbl',['motion as motion_id'],$sWhere,$str);
            $motions=array();
            foreach ($motionQuery as $row) {
                $motions[]=$row['motion_id'];
            }
            if(is_array($searchLimit)){
                $searchLimit=array_intersect($searchLimit,$motions);
            }else{
                $searchLimit=$motions;
            }
        }




        if(isset($sortFilter['motion_id'])){
            $sortFilter['motion_id']=array_intersect($sortFilter['motion_id'],$searchLimit);
        }else{
            $sortFilter['motion_id']=$searchLimit;
        }
        $totalNumber=count($sortFilter['motion_id']);



    }



    if (-1 == $totalNumber) {
        $totalNumber = pdoQuery('motion_tbl', array('count(*) as count'), array('meeting' => $meeting), 'and step>0')->fetch()['count'];
    }
    $sortQuery = pdoQuery('motion_view', array('motion_id'), $sortFilter, 'group by motion_id ' . $orderStr . ' limit ' . $page * $count . ',' . $count);
    foreach ($sortQuery as $row) {
        $sort[] = $row['motion_id'];
        $sortList[$row['motion_id']] = array();
        $motionfilter[] = $row['motion_id'];
    }

//    mylog(getArrayInf($field));
    $motionDetail = pdoQuery('motion_view', null, array('motion_id' => $motionfilter, 'attr_name' => $field), null);
    foreach ($motionDetail as $row) {
        $content = 'string' == $row['value_type'] ? $row['content'] : $row['content_int'];
        $content = 'attachment' == $row['value_type'] ? $row['attachment'] : $content;
        if ('index' == $row['value_type']) {
            if ('duty' == $row['target'] && $content) {
                $content = $dutyList[$content]['user_name'];
            } else {
                $content = DataSupply::indexToValue($row['target'], $content);
            }
        }


        if (!isset($sortList[$row['motion_id']][$row['attr_name']])) $sortList[$row['motion_id']][$row['attr_name']] = $content;
        else $sortList[$row['motion_id']][$row['attr_name']] .= ',' . $content;
//        $sortList[$row['motion_id']]['案由'] = $row['motion_name'];
//        $sortList[$row['motion_id']]['案别']=2==$row['category']?'建议':'提案';
        $sortList[$row['motion_id']]['当前环节'] = $row['step_name'];
//        $sortList[$row['motion_id']]['编号'] = $row['zx_motion'];
    }
    $motionIdLimit = isset($sortFilter['motion_id']) ? $sortFilter['motion_id'] : null;
    $query=pdoQuery('displeasure_attr_tbl',['motion as motion_id'],null,'where date_add(update_time,INTERVAL 12 month)>now() group by motion');
    $displeasureList=[];
    foreach ($query as $row) {
        $displeasureList[$row['motion_id']]=1;
    }

    echo ajaxBack(array('list' => $sortList, 'sort' => $sort, 'totalCount' => $totalNumber, 'mainHandleCount' => $mainHandleCount, 'handleCount' => $handleCount, 'motionIdLimit' => $motionIdLimit,'displeasureList'=>$displeasureList));
}

/**
 * 删除提议案属性
 * @param $data ：包含属性ID
 */
function ajaxDeleteAttr($data)
{
    mylog(getArrayInf($data));
    try {
        $id = pdoDelete('attr_tbl', array('attr_id' => $data['id']), ' limit 1');
        echo ajaxBack('ok');
    } catch (PDOException $e) {
        mylog($e->getMessage());
        echo ajaxBack(0);
    }
}

/**
 * 获取代表委员联系方式
 * @param $data
 */
function ajaxGetDutyInf($data)
{
    $motionId = $data['id'];
    $back = array();
    $infList = array();
    $dutyQuery = pdoQuery('motion_view', array('attr_name', 'content_int'), array('motion_id' => $motionId, 'target' => 'duty'), 'limit 10');
    foreach ($dutyQuery as $row) {
        if ($row['content_int'] > 0) {
            $back[$row['content_int']] = array('duty' => $row['attr_name']);
            $infList[] = $row['content_int'];
        }
    }
    $detailInf = pdoQuery('duty_view', null, array('duty_id' => $infList), 'limit ' . count($infList));
    foreach ($detailInf as $row) {
        $back[$row['duty_id']]['name'] = $row['user_name'];
        $back[$row['duty_id']]['phone'] = $row['user_phone'];
        $back[$row['duty_id']]['address'] = $row['address'];
    }
    echo ajaxBack($back);


}


/**
 * 内网提交新提议案
 */
function createMotion($data)
{
    $staff = $_SESSION['staffLogin'];
    $meetingId=$data['meetingId'];
    $meetingInf = pdoQuery('meeting_tbl', null, array('meeting_id' => $meetingId), ' order by deadline_time desc limit 1')->fetch();
    $emptyMotion = pdoQuery('motion_tbl', array('motion_id'), array('motion_name' => '新建', 'duty' => 0, 'category' => $staff['category'], 'user' => $staff['staffId']), 'and step>0 limit 1')->fetch();

    if ($emptyMotion) {
        editMotion(array('id' => $emptyMotion['motion_id']));

    } else {
        pdoTransReady();
        try {
            $id = pdoInsert('motion_tbl', array('meeting' => $meetingId, 'category' => $staff['category'], 'motion_name' => '新建', 'motion_template' => $meetingInf['motion_template'], 'step' => 1, 'user' => $staff['staffId']));
            if (2 == $staff['category']) {
                $zx_id=pdoInsert('zx_motion_tbl', array('motion' => $id));
                $zxIdInf=pdoQuery('motion_attr_view',['motion_attr_id as motion_attr','attr_template'],['attr_name'=>'登记号'],'limit 1')->fetch();
                pdoInsert('attr_tbl',['motion'=>$id,'motion_attr'=>$zxIdInf['motion_attr'],'attr_template'=>$zxIdInf['attr_template'],'content_int'=>$zx_id,'staff'=>$staff['staffId']]);
            }
            pdoCommit();
//            mylog('id='.$id);
            editMotion(array('id' => $id));
        } catch (PDOException $e) {
            mylog($e->getMessage());
            pdoRollBack();
        }
    }

}

/**
 *返回需要编辑的数据
 * @param $data array，包含motion_id
 */
function editMotion($data)
{
    global $config;
    $id = $data['id'];

    $canMainHandler = false;
//    $attrFilter=array('motion_id'=>$id,'attr_step'=>$_SESSION['staffLogin']['steps']); //只显示当前步骤所需填写的选项
    $attrFilter = array('motion_id' => $id);
    $meetingInf = pdoQuery('motion_inf_view', null, array('motion_id' => $id), ' limit 1')->fetch();
    //锁定判断
    $lock=['success'=>true];
    if(in_array($meetingInf['step'],$_SESSION['staffLogin']['steps'])&&$meetingInf['step']<4){
        $lock=motionLock($id);
    }
    if(!$lock['success']){
        echo '<script>alert("'.$lock['msg'].'")</script>';
        return;
    }
    $_SESSION['staffLogin']['currentMotion'] = $id;

    $hasDispleasure=pdoQuery('displeasure_attr_tbl',['motion'],['motion'=>$id],' limit 1')->fetch();
    $isDispleasure=false;
//    mylog();
    //处理政协提案有不同交办单位的情况
    $step4CanEdit = true;
    if (4 == $meetingInf['step'] || 5 == $meetingInf['step']) {
        $staffId = $_SESSION['staffLogin']['staffId'];
        if (2 == $meetingInf['category']) {
            $step4Inf = pdoQuery('motion_view', array('content_int'), array('motion_id' => $id, 'content_int' => $staffId, 'attr_name' => '交办单位'), 'limit 1')->fetch();
            if (!$step4Inf['content_int']) {
                $step4CanEdit = false;
            }
        } else {
            $step4Inf = pdoQuery('motion_view', array('content_int'), array('motion_id' => $id, 'attr_name' => '交办单位'), 'limit 1')->fetch();
            if ($step4Inf['content_int'] == $staffId) {
                $step4CanEdit = true;
            } else {
//                if ('5103' == $staffId || '6726' == $staffId){
//                    $step4CanEdit = true;
//                }
//                else {
                    $step4CanEdit = false;
//                }
            }
        }
    } else {

    }

    //处理主办单位是否可办理的情况
    if (5 == $meetingInf['step'] && in_array(5, $_SESSION['staffLogin']['steps'])) {

        $staffUnit = $_SESSION['staffLogin']['unit'];
        $mainHandlerInf = pdoQuery('motion_view', array('content_int'), array('motion_id' => $id, 'content_int' => $staffUnit, 'attr_name' => '主办单位'), 'limit 1')->fetch();
        if ($mainHandlerInf) {
            $handler = pdoQuery('motion_handler_tbl', array('motion_handler_id'), array('motion' => $id, 'status' => array(1, 3)), 'limit 1')->fetch();
//            mylog(getArrayInf($handler));
            if (!$handler) $canMainHandler = true;
        }
    }
//    mylog($step4CanEdit);
    $motionQuery = pdoQuery('motion_view', null, $attrFilter, ' order by value_sort desc,motion_attr asc');
    $unitGroupInf = null;
    unset($_SESSION['staffLogin']['passUnique']);//$_SESSION['staffLogin']['passUnique']用来记录当前motion已有的案号,更新motion其他属性时用来通过案号唯一性验证
    foreach ($motionQuery as $row) {
        if ('案号' == $row['attr_name'] && $row['content_int'] > 0) $_SESSION['staffLogin']['passUnique'] = $row['content_int'];//获取案号
        $values = $row;
        $optionArray = json_decode($row['option'], true);
        $values['edit'] = false;
        if (in_array($row['step'], $_SESSION['staffLogin']['steps'])) {
            if ($row['step'] == $row['attr_step']) {
                if (4 != $row['step']) $values['edit'] = true;
                if ($step4CanEdit && 4 == $row['step']) $values['edit'] = true;
                if ($canMainHandler && 5 == $row['step']) $values['edit'] = true;
            }
            if (2 == $row['step'] && 1 == $row['attr_step']) $values['edit'] = true;
            if ('性质' == $row['attr_name'] && 3 == $row['step']) $values['edit'] = true;
        }
        if ('提案联系人' == $row['attr_name'] && in_array(3, $_SESSION['staffLogin']['steps'])) $values['edit'] = true;

        //将attr数据转化为可为用户观看的内容
        $values['content'] = setAttrValue($row);

        if ($values['edit']) {//如操作员流程权限与当前权限吻合，则可修改当前流程选项
            $values['edit'] = true;
            if (count($optionArray) > 0) {//普通选项
                $values['option'] = array();
                foreach ($optionArray as $oRow) {
                    $values['option'][$oRow] = $oRow;
                }
                $values['class'] = 'select';
                if (!$values['content']) $values['content'] = $row['default_value'];
            }
            if ($row['target']) {//数据库内容

//                $values['filter']
            }

            //如果属性支持多值情况的处理
            if (1 == $values['multiple']) {
//                mylog('multiple');
                //如果此属性已包含一个值，且有新值存在，则把值放入multiple_value数组中，存入前先将表内索引值转换为对应的名称
                if (isset($motion[$row['attr_name']]) && $values['content']) {
//                    mylog(getArrayInf($values));
                    $motion[$row['attr_name']]['multiple_value'][$values['attr_id']] = array('content' => $values['content'], 'attachment' => $values['attachment']);

                    //如果新值存在且此属性并未包含值
                } elseif ($values['content']) {
//                    mylog('has content');
                    $motion[$row['attr_name']] = $values;
                    $motion[$row['attr_name']]['multiple_value'][$values['attr_id']] = array('content' => $values['content'], 'attachment' => $values['attachment']);
//                    mylog($row['attr_name'].': '.getArrayInf($motion));
                } else {
                    $motion[$row['attr_name']] = $values;
                }
//                mylog($values['content']);

            } else {
                $motion[$row['attr_name']] = $values;
//                $motion[$row['attr_name']]['multiple_value'][]=array('attr_id'=>$values['attr_id'],'content'=>indexToValue($row['target'],$values['content']));
            }
        } else {
            $values['edit'] = false;
            if (1 == $values['multiple']) {
                if (isset($motion[$row['attr_name']])) {
                    if ($row['attachment']) {
                        $motion[$row['attr_name']]['content'][] = array('content' => $values['content'], 'attachment' => $values['attachment']);
                    } else {
                        $tContent = $motion[$row['attr_name']]['content'] . ',' . $values['content'];
                        $tContent = trim($tContent, ',');
                        $motion[$row['attr_name']]['content'] = $tContent;
                    }
                } else {
                    if ($row['attachment']) {
                        $motion[$row['attr_name']] = $values;
                        $motion[$row['attr_name']]['content'] = array();
                        $motion[$row['attr_name']]['content'][] = array('content' => $values['content'], 'attachment' => $values['attachment']);
                    } else {
                        $motion[$row['attr_name']] = $values;
                    }
                }


            } else {
                $motion[$row['attr_name']] = $values;
            }
        }

        //获取领衔人信息
        if ('领衔人' == $row['attr_name'] || '提案人' == $row['attr_name']) {
            $query = pdoQuery('duty_view', null, array('duty_id' => $row['content_int']), 'limit 1')->fetch();
            $unitGroupInf = array('unit' => $query['user_unit_name'], 'group' => $query['user_group_name']);
        }
    }
    $currentStep = current($motion)['step'];
    switch ($currentStep) {
        case 1:

            break;
        case 2:

            break;
        case 3:

            break;

        case 4:

            break;
        default:
            $unit = $_SESSION['staffLogin']['unit'];
            $handlerQuery = pdoQuery('motion_handler_view', null, array('motion' => $id, 'status' => array('1', '3', '9')), null);
            $handlerDisplay = array();
            $handlerEdit = array();
            foreach ($handlerQuery as $row) {
                if ($row['unit'] == $unit && 1 == $row['status'] && in_array(5, $_SESSION['staffLogin']['steps'])) {
                    $handlerEdit = $row;
                } else {
                    $handlerDisplay[] = $row;
                }
            }
            break;
    }
//    mylog(getArrayInf($motion));
    include '/view/edit_motion1.html.php';
    return;
}

/**
 * 获取不满意件原始数据
 * @param $data
 */
function getDispleasureMotion($data){
    global $config;
//    $id = $data['id'];
    $id=$_SESSION['staffLogin']['currentMotion'];
    $canMainHandler = false;
    $step4CanEdit=false;
    $attrFilter = array('motion_id' => $id);
    $meetingInf = pdoQuery('motion_inf_view', null, array('motion_id' => $id), ' limit 1')->fetch();
    $meetingInf['step']=7;
    $hasDispleasure=false;
    $isDispleasure=true;
    $motionQuery = pdoQuery('displeasure_motion_view', null, $attrFilter, ' order by value_sort desc,motion_attr asc');
    $unitGroupInf = null;
    unset($_SESSION['staffLogin']['passUnique']);
    foreach ($motionQuery as $row) {
        if ('案号' == $row['attr_name'] && $row['content_int'] > 0) $_SESSION['staffLogin']['passUnique'] = $row['content_int'];//获取案号
        $values = $row;
        $optionArray = json_decode($row['option'], true);
        $values['edit'] = false;
        $values['step']=7;
        $values['step_name']="完成";
        //将attr数据转化为可为用户观看的内容
        $values['content'] = setAttrValue($row);
            if (1 == $values['multiple']) {
                if (isset($motion[$row['attr_name']])) {
                    if ($row['attachment']) {
                        $motion[$row['attr_name']]['content'][] = array('content' => $values['content'], 'attachment' => $values['attachment']);
                    } else {
                        $tContent = $motion[$row['attr_name']]['content'] . ',' . $values['content'];
                        $tContent = trim($tContent, ',');
                        $motion[$row['attr_name']]['content'] = $tContent;
                    }
                } else {
                    if ($row['attachment']) {
                        $motion[$row['attr_name']] = $values;
                        $motion[$row['attr_name']]['content'] = array();
                        $motion[$row['attr_name']]['content'][] = array('content' => $values['content'], 'attachment' => $values['attachment']);
                    } else {
                        $motion[$row['attr_name']] = $values;
                    }
                }


            } else {
                $motion[$row['attr_name']] = $values;
            }

        //获取领衔人信息
        if ('领衔人' == $row['attr_name'] || '提案人' == $row['attr_name']) {
            $query = pdoQuery('duty_view', null, array('duty_id' => $row['content_int']), 'limit 1')->fetch();
            $unitGroupInf = array('unit' => $query['user_unit_name'], 'group' => $query['user_group_name']);
        }
    }
    $currentStep =7;

            $unit = $_SESSION['staffLogin']['unit'];
            $handlerQuery = pdoQuery('displeasure_motion_handler_view', null, array('motion' => $id, 'status' => array('1', '3', '9')), null);
            $handlerDisplay = array();
            foreach ($handlerQuery as $row) {
//                if ($row['unit'] == $unit && 1 == $row['status'] && in_array(5, $_SESSION['staffLogin']['steps'])) {
//                    $handlerEdit = $row;
//                } else {
                    $handlerDisplay[] = $row;
//                }
            }

    mylog(getArrayInf($motion));

    include '/view/edit_motion1.html.php';
    return;
}


/**
 * 返回搜索框
 */
function searchMotionView($data){

    $where=array();
//    mylog(getArrayInf($data));
    $category=isset($data['category'])?$data['category']:1;
    $where['category']=$category;
    $meetingInf['category']=$where['category'];

    if(isset($data['meeting'])){
        $meetingName=pdoQuery('meeting_tbl',array('meeting_name'),array('meeting_id'=>$data['meeting']),'limit 1')->fetch()['meeting_name'];
    }
    $motion=array();
    $query=pdoQuery('motion_attr_view',null,array('motion_template'=>$where['category']),null);
    foreach ($query as $row) {
        if($row['option'])$row['option']=json_decode($row['option'],true);
        $motion[$row['attr_name']]=$row;
        //获取领衔人信息
//        if ('领衔人' == $row['attr_name'] || '提案人' == $row['attr_name']) {
//            $query = pdoQuery('duty_view', null, array('duty_id' => $row['content_int']), 'limit 1')->fetch();
//            $unitGroupInf = array('unit' => $query['user_unit_name'], 'group' => $query['user_group_name']);
//        }
    }
    $userGroup=pdoQuery('user_group_tbl',['user_group_id','user_group_name'],['category'=>$category],null)->fetchAll();
    $userUnit=pdoQuery('user_unit_tbl',['user_unit_id','user_unit_name'],['category'=>$category],null)->fetchAll();

    include '/view/search.html.php';
    return;




}

/**
 * 解析motion_view中获取的数据，将索引或时间戳转换成可显示的值
 * @param  motion_view中的一条数据
 * @return 转换后的内容
 */
function setAttrValue($row)
{
    $content = $row['content'] ? $row['content'] : '';
    if ('int' == $row['value_type']) $content = $row['content_int'];
    if ('time' == $row['value_type'] && $row['content_int'] > 0) $content = date('Y-m-d', $row['content_int']);
    if ($row['target']) {
        $content = DataSupply::indexToValue($row['target'], $row['content_int']);
    }
    return $content;
}

/**
 * 从客户端获取需要输出列表的motionList，存入$_SESSION
 * @param $data motionId列表
 */
function ajaxPrepareMotionsToOutput($data){
    $key=getRandStr(6);
    mylog($key);
    $_SESSION[$key]=$data;
    echo ajaxBack($key);
}

function ajaxDeleteMotion($data)
{
    $id = $data['id'];
    mylog(getArrayInf($data));
    $motionInf = pdoQuery('motion_tbl', null, array('motion_id' => $id), 'limit 1')->fetch();
    if ($motionInf['step'] < 4 && in_array(3, $_SESSION['staffLogin']['steps'])) {
        pdoUpdate('motion_tbl', array('step' => 0), array('motion_id' => $id), ' limit 1');
        echo ajaxBack('ok');
    } else {
        echo ajaxBack('no');
    }
}

function getUserGroup($data)
{
    $type = $data['group_type'];
    $groupList = array();
    if ('unit' == $type) {
        $query = pdoQuery('user_unit_tbl', array('user_unit_id as id', 'user_unit_name as name'), array('category' => $_SESSION['staffLogin']['category']), null);
    } elseif ('group' == $type) {
        $query = pdoQuery('user_group_tbl', array('user_group_id as id', 'user_group_name as name'), array('category' => $_SESSION['staffLogin']['category']), null);
    }
    foreach ($query as $row) {
        $groupList[] = $row;
    }
//    mylog(getArrayInf($groupList));
    echo ajaxBack($groupList);
}

/**ajax填充议案属性
 * @param $data {step:1,data:values}
 */
function updateAttr($data)
{
    $isFoward = $data['step'];
    $motionId = $_SESSION['staffLogin']['currentMotion'];
    $motion = pdoQuery('motion_tbl', null, array('motion_id' => $motionId), ' limit 1')->fetch();
    $currentStep = $motion['step'];
    $attrs = isset($data['data']) ? $data['data'] : array();

    if($isFoward>-1&&($currentStep>6||!in_array($currentStep,$_SESSION['staffLogin']['steps']))){//防止重复提交
        echo ajaxBack(array('step' => $currentStep, 'id' => $motionId));
        exit;
    }
    $uniqueJudge=(2==$currentStep&&1==$motion['category'])||(3==$currentStep&&2==$motion['category']);//判断是否要做案号唯一性检查
    if($uniqueJudge){
        //案别motion_attr id:90;
        //案号motion_attr id: 人大：34 政协：26

        if(1==$motion['category']){
            $uniqueInf=34;
            $subCate=false;
            foreach ($attrs as $attrrow) {
                if(90==$attrrow['motion_attr']){
                    $subCate=$attrrow['value'];
                }
            }
            if(!$subCate)$subCate=pdoQuery('attr_tbl',['content'],['motion'=>$motionId,'motion_attr'=>90],'limit 1')->fetch()['content'];
            $existMotion=pdoQuery('attr_unique_view',['motion'],['motion_attr'=>90,'content'=>$subCate,'meeting'=>$motion['meeting']],null)->fetchAll();
            $uniqueQuery = pdoQuery('attr_unique_view', array('content_int as value'), array('motion' => $existMotion, 'meeting' => $motion['meeting']), null);
//            mylog(json_encode($attrs));
//            mylog(json_encode($existMotion));
        }else{
            $uniqueInf=26;
//            $uniqueInf = pdoQuery('motion_attr_view', null, array('attr_name' => '案号', 'motion_template' => $motion['motion_template']), 'limit 1')->fetch()['motion_attr_id'];
            $uniqueQuery = pdoQuery('attr_unique_view', array('content_int as value'), array('motion_attr' => 26, 'meeting' => $motion['meeting']), null);

        }
        $uniqueValues = array();
        foreach ($uniqueQuery as $row) {
            $uniqueValues[] = $row['value'];
        }
    }



//    setSyncPublic();
    pdoTransReady();
    try {
        foreach ($attrs as $row) {
            if($uniqueJudge){//如需进行案号唯一性检查；
                if ($uniqueInf == $row['motion_attr']) {
//                    mylog(getArrayInf($row));
                    if(1==$motion['category']){//人大登记阶段，如果是初录入案号，则不进行下一步
                        if(!$row['attr_id'])$isFoward=0;
                    }
                    if (in_array($row['value'], $uniqueValues)) {
                        if (!isset($_SESSION['staffLogin']['passUnique'])) {
                            $e = new PDOException();
                            $e->errorInfo = "unique";
                            throw $e;
                        } else {
                            if ($_SESSION['staffLogin']['passUnique'] != $row['value']) {
                                $e = new PDOException();
                                $e->errorInfo = "unique";
                                throw $e;
                            }
                        }

                    }
                }
            }

            $value = array();
            if ((!isset($row['value']) || !$row['value']) && $row['attr_type'] != 'attachment') {//过滤非附件的空值
                continue;
            }
            if ('attachment' == $row['attr_type']) continue;
            if ($row['attr_id']) $value['attr_id'] = $row['attr_id'];
            $value['motion'] = $motionId;
            $value['staff'] = $_SESSION['staffLogin']['staffId'];
            $value['motion_attr'] = $row['motion_attr'];
            $value['attr_template'] = $row['attr_template'];
            if ('index' == $row['attr_type'] || 'int' == $row['attr_type']) {
                $value['content_int'] = $row['value'];
            } elseif ('time' == $row['attr_type']) {
                $value['content_int'] = time();
            } else {
                $value['content'] = addslashes($row['value']);
            }
//            mylog(getArrayInf($value));
            pdoInsert('attr_tbl', $value, 'update');
        }
        if (1 == $motion['step'] || 2 == $motion['step']) {//将“案由”和“领衔人”属性与motion表中的motion_name,duty字段同步
            $attr = pdoQuery('attr_view', array('content', 'content_int'), array('motion' => $motionId, 'attr_name' => array('案由', '领衔人', '提案人')), 'order by attr_name asc')->fetchAll();
            $name = '';
            $duty = '0';
            foreach ($attr as $row) {
                if ($row['content']) $name = $row['content'];
                else $duty = $row['content_int'];
            }
            pdoUpdate('motion_tbl', array('motion_name' => $name, 'duty' => $duty), array('motion_id' => $motionId), 'limit 1');
        }
        //点击下一步的操作
        if ($isFoward > 0) {
            $currentStep++;
            pdoUpdate('motion_tbl', array('step' => $currentStep), array('motion_id' => $motionId));
            if (4 == $motion['step']) {
                $handlerList = pdoQuery('attr_view', null, array('motion' => $motionId, 'attr_name' => '协办单位'), null);
                pdoUpdate('motion_handler_tbl', array('status' => 7), array('motion' => $motionId, 'status' => 1));

                foreach ($handlerList as $row) {
                    pdoInsert('motion_handler_tbl', array('motion' => $motionId, 'attr' => $row['attr_id'], 'unit' => $row['content_int']), 'update');
                    pdoUpdate('motion_handler_tbl', array('status' => 1), array('unit' => $row['content_int'], 'status' => 7), ' limit 1');
                }


            }


            //审核未通过的情况下，将提议案步骤直接设置为完成
            if (3 == $motion['step']) {
                $attr = pdoQuery('attr_view', array('content'), array('motion' => $motionId, 'attr_name' => '审核' . $motion['category']), 'limit 1')->fetch();
                if ('不予立案' == $attr['content']) {
                    pdoUpdate('motion_tbl', array('step' => 7), array('motion_id' => $motionId));
                }
            }
            //自动为人大建议添加交办单位
            if(4==$motion['step']&&1==$motion['category']){
                $query=pdoQuery('attr_tbl',null,['motion'=>$motionId,'motion_attr'=>86],'limit 1')->fetch();
                if(!$query){
                    pdoInsert('attr_tbl',['motion'=>$motionId,'motion_attr'=>86,'attr_template'=>15,'content_int'=>$_SESSION['staffLogin']['staffId']]);
                }
            }
            if (6 == $motion['step']) {
                mylog();
                $attr = pdoQuery('attr_view', array('content'), array('motion' => $motionId, 'attr_name' => array('办理工作', '办理结果')), 'limit 2')->fetchAll();
                foreach ($attr as $row) {
                    if ('不满意' == $row['content']) {
                        displeasure($motionId);
//                        pdoUpdate('motion_tbl', array('step' => 6), array('motion_id' => $motionId));
                        break;
                    }
                }

            }

        } elseif ($isFoward < 0) {
            pdoUpdate('motion_tbl', array('step' => $motion['step'] - 1), array('motion_id' => $motionId));
        }
        if (5 == $motion['step']) {
            if (isset($data['handler'])) {
                mylog(getArrayInf($data['handler']));
                $handleDate = $data['handler'];
//                mylog(getArrayInf($handleDate));
                if ($handleDate) {
                    if ($data['confirm']) $handleDate['status'] = 9;
                    $handleDate['receive_time'] = time();
                    $handleDate['reply_time'] = time();
                    $handleDate['staff'] = $_SESSION['staffLogin']['staffId'];
//                    mylog(getArrayInf($handleDate));
                    pdoInsert('motion_handler_tbl', $handleDate, 'update');
                }
            }
        }

//        if($data['step'])exeNew('update motion_tbl set step=step+1 where motion_id='.$motionId);
        pdoCommit();
        echo ajaxBack(array('step' => $currentStep, 'id' => $motionId));
    } catch (PDOException $e) {
        mylog($e->getMessage());
        mylog(getArrayInf($e->errorInfo));
        pdoRollBack();
        mylog('出错');
        echo ajaxBack($e->errorInfo);
    }


}

/**
 * ajax获取目标表的内容
 * @param $data
 */
function ajaxTargetList($data)
{
//    mylog(getArrayInf($data));
//    mylog(getArrayInf($_SESSION['staffLogin']));
    $target = $data['target'];
    $filter = isset($data['filter']) ? $data['filter'] : null;
    $backList = array();
    switch ($target) {
        case 'duty':
//            $filter = array_merge($filter,array('category' => $_SESSION['staffLogin']['category'], 'activity' => 1));
            if(!$filter){
                $filter['meeting']=$_SESSION['staffLogin']['meeting'];
            }
            $filter['activity']=1;

            if (isset($_SESSION['staffLogin']['userList'])) $filter = array_merge($filter, $_SESSION['staffLogin']['userList']);
            $dutyQuery = pdoQuery('duty_view', null, $filter, 'and activity=1');

//            foreach ($dutyQuery as $row) {
            if (2 == $_SESSION['staffLogin']['category']) {
                $backList['unitFilt']['name'] = '按委组';
                $backList['groupFilt']['name'] = '按界别';
                $backList['unitGroup']['name'] = '党派团体';
                foreach ($dutyQuery as $row) {
                    if ($row['user_group'] && $row['user_unit']) {
                        if (!isset($backList['unitFilt']['list'][$row['user_unit']])) {
                            $backList['unitFilt']['list'][$row['user_unit']] = array('name' => $row['user_unit_name'], 'id' => 0);
                        }
                        $backList['unitFilt']['list'][$row['user_unit']]['sub'][] = array('name' => $row['user_name'], 'id' => $row['duty_id']);
                        if (!isset($backList['groupFilt']['list'][$row['user_group']])) {
                            $backList['groupFilt']['list'][$row['user_group']] = array('name' => $row['user_group_name'], 'id' => 0);
                        }
                        $backList['groupFilt']['list'][$row['user_group']]['sub'][] = array('name' => $row['user_name'], 'id' => $row['duty_id']);

                    } else {
                        $backList['unitGroup']['list'][$row['duty_id']] = array('name' => $row['user_name'], 'id' => $row['duty_id']);
                    }
                }

            } else {
                foreach ($dutyQuery as $row) {
                    if (!isset($backList['user_unit'][$row['user_unit']])) {
                        $backList['user_unit'][$row['user_unit']] = array('name' => $row['user_unit_name'], 'id' => '0');
                    }
                    $backList['user_unit'][$row['user_unit']]['sub'][] = array('name' => $row['user_name'], 'id' => $row['duty_id']);
                }

            }
//            }
            echo ajaxBack($backList);
            break;
        case 'unit':
//            mylog(getArrayInf($_SESSION));
            if(isset($_SESSION['staffLogin']['currentMotion'])){
                $motionInf = pdoQuery('motion_tbl', null, array('motion_id' => $_SESSION['staffLogin']['currentMotion']), 'limit 1')->fetch();
                $step = $motionInf['step'] + 1;
            }else{
                $step=5;
            }

            if ($filter) $str = 'and steps like "%' . $step . '%"';
            else $str = 'where steps like "%' . $step . '%"';
            $unitQuery = pdoQuery('unit_tbl', null, $filter, $str);
            foreach ($unitQuery as $row) {
                if (0 != $row['parent_unit']) {
                    $backList[0][$row['parent_unit']]['sub'][] = array('name' => $row['unit_name'], 'id' => $row['unit_id']);
                } else {
                    $backList[0][$row['unit_id']]['name'] = $row['unit_name'];
                    $backList[0][$row['unit_id']]['id'] = $row['member'] ? $row['unit_id'] : 0;
                }

            }
//            mylog(getArrayInf($backList));
            echo ajaxBack($backList);
            break;
        case 'staff':
            if(isset($_SESSION['staffLogin']['currentMotion'])) {
                $motionInf = pdoQuery('motion_tbl', null, array('motion_id' => $_SESSION['staffLogin']['currentMotion']), 'limit 1')->fetch();
                $step = $motionInf['step'] + 1;
            }else{
                $step=4;
            }
            if ($filter) $str = 'and steps like "%' . $step . '%"';
            else $str = 'where steps like "%' . $step . '%"';
            $staffQuery = pdoQuery('staff_admin_view', null, $filter, $str);
            foreach ($staffQuery as $row) {
                if (!isset($backList[0][$row['unit']])) $backList[0][$row['unit']] = array('name' => $row['unit_name'], 'id' => 0);
                $backList[0][$row['unit']]['sub'][] = array('name' => $row['full_name'], 'id' => $row['staff_id']);
            }
            echo ajaxBack($backList);
            break;
        case 'motion':
            if ('all' != $_SESSION['staffLogin']['meeting']) $filter['meeting'] = $_SESSION['staffLogin']['meeting'];
            $motionList = pdoQuery('motion_tbl', null, $filter, ' and step>0');
            foreach ($motionList as $row) {
                $backList['list'][] = array('name' => $row['motion_name'], 'id' => $row['motion_id']);
            }
            echo ajaxBack($backList);

        default:
            break;


    }
}

/**
 * 通过ajax获取代表委员信息
 * @param $data ：委员id:{"id":5}
 */
function ajaxUserInf($data)
{
    $where = array('duty_id' => $data['id']);
    $inf = pdoQuery('duty_view', null, $where, 'limit 1')->fetch();
    echo ajaxBack($inf);
}

/**
 * 已知指定attr_id数据中保存的数据为委员duty_id,获取该代表委员信息
 * @param $data 保存attr_id {attrId:id}
 */
function ajaxUserInfFromAttrTbl($data)
{
    $dutyId = pdoQuery('attr_tbl', array('content_int'), array('attr_id' => $data['attrId']), 'limit 1')->fetch()['content_int'];
    $inf = pdoQuery('duty_view', null, array('duty_id' => $dutyId), 'limit 1')->fetch();
    echo ajaxBack($inf);
}

function ajaxGetSingleDutyId($data)
{
    $name = trim($data['name']);
    if ($name) {
        mylog($name);
        $where['user_name'] = $name;
        if (isset($_SESSION['staffLogin']['userList'])) $where = array_merge($where, $_SESSION['staffLogin']['userList']);
        $inf = pdoQuery('duty_view', array('duty_id'), $where, 'limit 1')->fetch();
        if ($inf) {
            echo ajaxBack($inf['duty_id']);
            return;
        }
    }
    echo ajaxBack(0);
}

/**
 * 交办单位在办理阶段动态删除协办单位
 * @param $data
 */
function ajaxDynamicDelHandle($data)
{
    pdoTransReady();
    try {
        mylog('delete handle' . getArrayInf($data));
        pdoUpdate('motion_handler_tbl', array('status' => 7), array('motion_handler_id' => $data['handle_id']), 'limit 1');
        pdoDelete('attr_tbl', array('attr_id' => $data['attr_id']), 'limit 1');
        pdoCommit();
        echo ajaxBack($_SESSION['staffLogin']['currentMotion']);
    } catch (PDOException $e) {
        mylog($e->getMessage());
        pdoRollBack();
    }
}

function ajaxDynamicBackwardHandle($data)
{
//    mylog('ajaxDynamicBackwardHandle');
    pdoUpdate('motion_handler_tbl', array('status' => 1), array('motion_handler_id' => $data['handle_id']), 'limit 1');
    echo ajaxBack($_SESSION['staffLogin']['currentMotion']);
}

function unsetCurrentMotion(){
    unset($_SESSION['staffLogin']['currentMotion']);
    echo ajaxBack( 'ok');
}


function ajaxAltDuty($data){
    $dutyId=$data['duty_id'];
    $dutyInf=pdoQuery('duty_tbl',null,['duty_id'=>$dutyId],'limit 1')->fetch();
    if($dutyInf){
        pdoUpdate('user_tbl',['user_phone'=>$data['user_phone'],'address'=>$data['address']],['user_id'=>$dutyInf['user']],'limit 1');
        pdoUpdate('duty_tbl',['user_unit'=>$data['user_unit'],'user_group'=>$data['user_group']],['duty_id'=>$dutyId],'limit 1');
        echo ajaxBack('ok');
    }
    echo ajaxBack('ok');
}

function ajax_activity_duty($data){
    $activity=$data['activity'];
    $id=$data['id'];
    $rows=pdoUpdate('duty_tbl',['activity'=>$activity],['duty_id'=>$id],' limit 1');
    if($rows){
        echo ajaxBack('ok');
    }else{
        echo ajaxBack(null,109,'数据库错误');
    }
}

/**
 * 用于人大根据中心组查询代表团
 * @param $data
 */
function ajaxGetGroupFromUnit($data){
    $inf=pdoQuery('duty_tbl',['user_group'],['category'=>1,'user_unit'=>$data['unit']],'limit 1')->fetch();
    if($inf){
        echo ajaxBack($inf['user_group']);
    }else{
        echo ajaxBack(null,109,'数据库错误');
    }

}

function ajaxAddDuty($data){
    pdoTransReady();
    $user=$data['user'];
    $duty=$data['duty'];
    $dutyId=null;
    mylog($user);
    try{
        $userId=pdoInsert('user_tbl',$user,'update');
        if($userId){
            $duty['user']=$userId;
        }else{
            $userInf=pdoQuery('user_tbl',['user_id'],$user,'limit 1')->fetch();
            $duty['user']=$userInf['user_id'];
        }

        mylog($duty);
        $dutyId=pdoInsert('duty_tbl',$duty,'update');
        pdoCommit();
        echo ajaxBack('ok');

    }catch(PDOException $e){
        mylog($e->getMessage());
        echo ajaxBack(null,109,'数据库错误');
        pdoRollBack();
    }
}


/**
 * 通过ajax获取分组单位列表的方法
 * @param $data 包含父id，例：{"id":6}
 */
function getUnit($data)
{
    $where = array('parent_unit' => $data['id']);
    $unit = pdoQuery('unit_tbl', array('unit_id as id', 'unit_name as name'), array('unit_id' => $data['id']), 'limit 1')->fetch();
    $unitList[] = $unit;
    $list = pdoQuery('unit_tbl', array('unit_id as id', 'unit_name as name'), $where, null);

    foreach ($list as $row) {
        $unitList[] = $row;
    }
    echo ajaxBack($unitList);

}


/**
 * 登出
 * @param $data
 */
function signOut($data)
{
    unlockMotion();
    session_unset();
//    mylog('unsetted:'.getArrayInf($_SESSION));
    echo ajaxBack('ok');
}

/**
 * 使用phpEcxel解析excel文件
 */
function encodeExcel()
{

    exit;
}

/**
 * ajax获取提案议案流程信息
 * @param $data 包含motionId
 */
function getMotionStepInf($data)
{
    $motionStepInf = pdoQuery('motion_step_inf_view', null, array('motion_id' => $data['id']), 'order by step limit 8')->fetchAll();
    if (!$motionStepInf) $motionStepInf = arrray();
    include 'view/motion_step_info.html.php';
    return;
}

///**
// * ajax处理下载请求，
// * @param $data
// */
//function ajaxDownLoad($data){
//    $_SESSION['staffLogin']['downloadInf']=$data['downloadInf'];
//
//}

function ajaxGetStatistics($data)
{
    handleStatistics($data['meeting']);
}

/**
 * 判断文件是不是在内网，如果不在，则向外网服务器请求下载；
 * @param $data
 */
function ajaxCheckFiles($data){
    if(!file_exists($data['file'])){
        $file=file_get_contents('http://183.136.192.58/motion_public/'.$data['file']);
        if(file_put_contents($data['file'],$file)){
            echo ajaxBack('ok');
        }else{
            echo ajaxBack(null,'8','netWorkError');
        }
    }else{
        echo ajaxBack('ok');
    }
}

/**
 * 获取统计页面
 * @param $data
 */
function get_statistics_view($data){
    $category=$data['category'];
    $meeting=$data['meeting'];
//    mylog($meeting);
    include "view/statistics_view$category.html.php";

    return;
}

/**
 * 获取代表委员管理界面
 * @param $data
 */
function get_duty_manager_view($data){
    $meeting=$data['meeting'];
    $category=$data['category'];
    $dutyWhere=['meeting'=>$meeting,'category'=>$category,'activity'=>1];
    $unitList=[];
    $groupList=[];
    $dutyFileter=isset($data['duty_filter'])?$data['duty_filter']:null;
    $filterString='';
    if($dutyFileter){
//        $filterString=' and';
        foreach ($dutyFileter as $field=>$value) {
            if(in_array($field,['user_name','address','user_phone'])){
                $filterString.=' and '.$field .'in (%'.$value.'%)';
            }else{
                $dutyWhere[$field]=$value;
            }
        }

    }
    $query=pdoQuery('user_unit_tbl',['user_unit_id','user_unit_name as unit_name'],['category'=>$category],null);
    foreach ($query as $row) {
        $unitList[$row['user_unit_id']]=$row;
    }
    $query=pdoQuery('user_group_tbl',['user_group_id','user_group_name as group_name'],['category'=>$category],null);
    foreach ($query as $row) {
        $groupList[$row['user_group_id']]=$row;
    }
    $dutyList=pdoQuery('duty_view',null,$dutyWhere,$filterString);
    $dutyList->setFetchMode(PDO::FETCH_ASSOC);
    include_once 'view/duty_table_view.html.php';
    return;


}
//function exceOut

function handleStatistics($meeting,$unitId = 0, $category = 3)
{
    $totalList = array();
//    if (3 == $category) {

        $where = $unitId ? array('unit_id' => $unitId,'meeting'=>$meeting) : array('meeting'=>$meeting);
        $order = 'order by handle_name asc,number desc';
        $totalQuery = pdoQuery('handle_statistics_view', null, $where, $order);
        foreach ($totalQuery as $row) {
            $totalList[$row['unit_id']]['unit_id'] = $row['unit_id'];
            $totalList[$row['unit_id']]['unit_name'] = $row['unit_name'];
            if ('主办单位' == $row['handle_name']){
                if(isset($totalList[$row['unit_id']]['main_total']))$totalList[$row['unit_id']]['main_total'] += $row['number'];
                else $totalList[$row['unit_id']]['main_total'] = $row['number'];
            }else{
                if(isset($totalList[$row['unit_id']]['sub_total']))$totalList[$row['unit_id']]['sub_total'] += $row['number'];
                else $totalList[$row['unit_id']]['sub_total'] = $row['number'];
            }
        }
        $mainDoneQuery = pdoQuery('main_handle_view', array('unit_id', 'handle_name', 'count(*) as number'), $where, 'group by unit_id,handle_name');
        foreach ($mainDoneQuery as $row) {
            if ('主办单位' == $row['handle_name']) $totalList[$row['unit_id']]['main_done'] = $row['number'];
        }
        $handledoneWhere = $where ? array_merge($where, array('status' => 9)) : array('status' => 9);
        $handleDoneQuery = pdoQuery('motion_handler_inf_view', array('unit as unit_id', 'count(*) as number'), $handledoneWhere, ' group by unit');
        foreach ($handleDoneQuery as $row) {
            $totalList[$row['unit_id']]['sub_done'] = $row['number'];
        }
        $where['handle_name']='主办单位';
        $responseQuery = pdoQuery('handle_response_view', array('unit_id', 'response_type', 'response', 'count(*) as number'), $where, 'group by unit_id,response_type,response');
        foreach ($responseQuery as $row) {
            $totalList[$row['unit_id']][$row['response_type']][$row['response']] = $row['number'];
        }
        return $totalList;

//    } else {
////        $where=$unitId?array('unit_id'=>$unitId,'category'=>$category):null;
//        $where = array('category' => $category);
//        if ($unitId) $where['unit_id'] = $unitId;
//        $order = 'order by handle_name asc,number desc';
//        $totalQuery = pdoQuery('handle_statistics_category_view', null, $where, $order);
//        foreach ($totalQuery as $row) {
//            $totalList[$row['unit_id']]['unit_id'] = $row['unit_id'];
//            $totalList[$row['unit_id']]['unit_name'] = $row['unit_name'];
//            if ('主办单位' == $row['handle_name']) $totalList[$row['unit_id']]['main_total'] = $row['number'];
//            else $totalList[$row['unit_id']]['sub_total'] = $row['number'];
//        }
//        $mainDoneQuery = pdoQuery('main_handle_view', array('unit_id', 'handle_name', 'count(*) as number'), $where, 'group by unit_id,handle_name');
//        foreach ($mainDoneQuery as $row) {
//            if ('主办单位' == $row['handle_name']) $totalList[$row['unit_id']]['main_done'] = $row['number'];
//        }
//        $handledoneWhere = $where ? array_merge($where, array('status' => 9)) : array('status' => 9);
//        $handleDoneQuery = pdoQuery('motion_handler_inf_view', array('unit as unit_id', 'count(*) as number'), $handledoneWhere, ' group by unit');
//        foreach ($handleDoneQuery as $row) {
//            if(55==$row['unit_id'])mylog($row['number']);
//            $totalList[$row['unit_id']]['sub_done'] = $row['number'];
//        }
//
//        $responseQuery = pdoQuery('handle_response_view', array('unit_id', 'response_type', 'response', 'count(*) as number'), $where, 'and handle_name="主办单位" group by unit_id,response_type,response');
//        foreach ($responseQuery as $row) {
//            $totalList[$row['unit_id']][$row['response_type']][$row['response']] = $row['number'];
//        }
//        return $totalList;
//    }

}
function displeasure($motion_id){
    $isDisPleasure=pdoQuery('displeasure_attr_tbl',['motion'],['motion'=>$motion_id],'limit 1')->fetch();
    if(!$isDisPleasure){
        $query=pdoQuery('attr_tbl',null,['motion'=>$motion_id],null);
        $query->setFetchMode(PDO::FETCH_ASSOC);
        $attrInf=$query->fetchAll();
        pdoBatchInsert('displeasure_attr_tbl',$attrInf,'ignore');
        $query=pdoQuery('motion_handler_tbl',null,['motion'=>$motion_id],null);
        $query->setFetchMode(PDO::FETCH_ASSOC);
        $handlerInf=$query->fetchAll();
        if($handlerInf)pdoBatchInsert('displeasure_motion_handler_tbl',$handlerInf,'ignore');
        $status=array();
        foreach ($attrInf as $row) {
            if("大会期间"==$row['content']||"闭会期间"==$row['content'])$status=$row;
        }
        pdoUpdate('motion_tbl', array('step' => 5), array('motion_id' => $motion_id));
        pdoUpdate('attr_tbl',['content'=>"重新办理"],['attr_id'=>$status['attr_id']],' limit 1');
        pdoUpdate('motion_handler_tbl',['status'=>3],['motion'=>$motion_id,'status'=>9]);

        mylog(getArrayInf($status));

    }else{

    }
}
function motionLock($motionId){
    $success=false;
    global $config;
    $staffId=$_SESSION['staffLogin']['staffId'];
    $staffName=$_SESSION['staffLogin']['staffName'];
    pdoTransReady();
    try{
        pdoInsert('lock_tbl',['motion'=>$motionId],'ignore');
        unlockMotion();
        $lockInf=pdoQuery('lock_tbl',null,['motion'=>$motionId],'limit 1')->fetch();

        if(1==$lockInf['lock_status']||time()>($lockInf['locked_time']+$config['lock_timeout'])){
            pdoUpdate('lock_tbl',['staff'=>$staffId,'staff_name'=>$staffName,'lock_status'=>2,'locked_time'=>time()],['motion'=>$motionId]);
            $currentStaff=$staffName;
            $msg="ok";
            $success=true;
        }else{
            $currentStaff=$lockInf['staff_name'];
            $msg="被用户 $currentStaff 锁定";
            $success=false;
        }
        pdoCommit();
        return ['success'=>$success,'currentStaff'=>$currentStaff,'msg'=>$msg];
    }catch(PDOException $e){
        pdoRollBack();
        mylog($e->getMessage());
        return ['success'=>$success,'currentStaff'=>$staffName,'msg'=>'此功能将于2018-01-01 00:00:00后开启'];
    }

}
function unlockMotion(){
    $staffId=$_SESSION['staffLogin']['staffId'];
    pdoUpdate('lock_tbl',['lock_status'=>1],['staff'=>$staffId]);
//    unsetCurrentMotion();
}