<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/5/23
 * Time: 14:29
 */
//global $meetingName=
include_once 'includes/DataSupply.class.php';

function statistics_excel_out(){
    $meeting=$_GET['meeting'];
    $inf=pdoQuery('meeting_tbl', array('meeting_name','category'), array('meeting_id' => $meeting), 'limit 1')->fetch();
    if(1==$inf['category']){
        $name=$inf['meeting_name'].'建议议案';
    }else{
        $name=$inf['meeting_name'].'提案';
    }
//    $name=getMeetingName($meeting);
//    mylog($meetingName);
    $totalList= handleStatistics($meeting,0, $_SESSION['staffLogin']['category']);
    include"view/statisticsOutExcel.html.php";
    exit;
}

/**
 * 综合统计 未完成
 *
 */
function multiple_statistics()
{
    $optionList=[];
    $unitList=[];
    $mainHandleList=[];
    $handleList=[];
    $meeting=$_GET['meeting'];
    $attrQuery=pdoQuery('motion_attr_view',null,null,' where motion_template=(select motion_template from meeting_tbl where meeting_id='.$meeting.')');
    foreach ($attrQuery as $row) {
        if($row['option']){
            $optionJson=json_decode($row['option'],true);
            foreach ($optionJson as $option) {
                $optionList[$row['attr_name'].'+'.$option]=0;
            }
        }
    }



    $query = pdoQuery('motion_view', null, ['meeting'=>$meeting], null);
    foreach ($query as $row) {

        if(isset($optionList[$row['attr_name'].'+'.$row['content']])){
            $optionList[$row['attr_name'].'+'.$row['content']]++;
        }
        if('交办单位'==$row['attr_name']){
            if(isset($unitList[$row['content_int']])){
                $unitList[$row['content_int']]++;
            }else{
                $unitList[$row['content_int']]=1;
            }
        }
        if('主办单位'==$row['attr_name']){
            if(isset($mainHandleList[$row['content_int']])){
                $mainHandleList[$row['content_int']]++;
            }else{
                $mainHandleList[$row['content_int']]=1;
            }
            if(isset($handleList[$row['content_int']])){
                $handleList[$row['content_int']]++;
            }else{
                $handleList[$row['content_int']]=1;
            }
        }
        if('协办单位'==$row['attr_name']){
            if(isset($handleList[$row['content_int']])){
                $handleList[$row['content_int']]++;
            }else{
                $handleList[$row['content_int']]=1;
            }
        }

    }
    mylog('主办：'. count($mainHandleList));
    mylog('协办：'.count($handleList));
//    mylog('办理：'.count(array_merge($mainHandleList,$handleList)));


    $name=getMeetingName($meeting);
    include"view/statistics_document.html.php";
    exit;
}

function motion_1_list()
{
    $fieldCount = 5;
    $meeting = 'all' == $_SESSION['staffLogin']['meeting'] ? 2 : $_SESSION['staffLogin']['meeting'];
    $fileName = pdoQuery('meeting_tbl', array('meeting_name'), array('meeting_id' => $meeting), 'limit 1')->fetch()['meeting_name'];
    $fileName .= "议案建议汇总";
    $title = '<tr><td>案号</td><td>案由</td><td>领衔人</td><td>主办单位</td><td>性质类别</td></tr>';
    $listQuery = pdoQuery('s_motion1_view', array('motion_num', 'motion_title', 'name', 'unit_name', 'type'), array('meeting' => $meeting), ' order by motion_num asc')->fetchAll();
    include 'view/formated_out.html.php';
    exit;
}

/**
 * 政协界别统计
 */
function sta1()
{
    $category=$_GET['category'];
    $meeting=$_GET['meeting'];
    $fieldCount = 3;
//    $meeting = 'all' == $_SESSION['staffLogin']['meeting'] ? 2 : $_SESSION['staffLogin']['meeting'];
    $fileName = getMeetingName($meeting);
    if(2==$category){
        $fileName .= '各界别提交提案数量统计';
        $title = '<tr><td>界别</td><td>件数</td><td>平均百分比</td></tr>';
        $attrName='提案人';
    }else{
        $fileName .= '各代表团提交建议数量统计';
        $title = '<tr><td>代表团</td><td>件数</td><td>平均百分比</td></tr>';
        $attrName='领衔人';
    }

    $totalNumber = 0;

    $query = pdoQuery('s_duty_view', array('user_group', 'user_group_name', 'count(*) as number',), array('attr_name' => $attrName, 'meeting' => $meeting), ' group by user_group');
    $listQuery = array();
    foreach ($query as $row) {
        $totalNumber += $row['number'];
        if ($row['user_group'] > 0) {
            $listQuery[$row['user_group']] = array($row['user_group_name'], $row['number'], 0);
        }
    }
//    mylog(getArrayInf($listQuery));
    foreach ($listQuery as $key => $row) {
        $listQuery[$key][2] = sprintf("%.2f", $row[1] / $totalNumber * 100) . '%';
    }
    mylog(getArrayInf($listQuery));
    include 'view/formated_out.html.php';
    exit;
}

/**
 * 政协委组统计
 */
function sta2()
{
    $category=$_GET['category'];
    $meeting=$_GET['meeting'];
    $fieldCount = 3;
//    $meeting = 'all' == $_SESSION['staffLogin']['meeting'] ? 2 : $_SESSION['staffLogin']['meeting'];
    $fileName = getMeetingName($meeting);
    if(2==$category){
        $fileName .= '各委组提交提案数量统计';
        $title = '<tr><td>委组</td><td>件数</td><td>平均百分比</td></tr>';
        $attrName='提案人';
    }else{
        $fileName .= '各中心组提交提案数量统计';
        $title = '<tr><td>中心组</td><td>件数</td><td>平均百分比</td></tr>';
        $attrName='领衔人';
    }

    $totalNumber = 0;

    $query = pdoQuery('s_duty_view', array('user_unit ', 'user_unit_name', 'count(*) as number',), array('attr_name' => $attrName, 'meeting' => $meeting), ' group by user_unit');
    $listQuery = array();
    foreach ($query as $row) {
        $totalNumber += $row['number'];
        if ($row['user_unit'] > 0) {
            $listQuery[$row['user_unit']] = array($row['user_unit_name'], $row['number'], 0);
        }
    }
//    mylog(getArrayInf($listQuery));
    foreach ($listQuery as $key => $row) {
        $listQuery[$key][2] = sprintf("%.2f", $row[1] / $totalNumber * 100) . '%';
    }
    mylog(getArrayInf($listQuery));
    include 'view/formated_out.html.php';
    exit;
}
function sta_by_duty(){
    $category=$_GET['category'];
    $meeting=$_GET['meeting'];
    $fieldCount = 3;
    $fileName=getMeetingName($meeting);
    if(2==$category){
        $fileName .= '各委员提交提案数量统计';
        $title = '<tr><td>姓名</td><td>委组</td><td>件数</td></tr>';
        $attrName='提案人';
    }else{
        $fileName .= '各代表提交提案数量统计';
        $title = '<tr><td>姓名</td><td>中心组</td><td>件数</td></tr>';
        $attrName='领衔人';
    }
    $totalNumber = 0;
    $query = pdoQuery('s_duty_view', array('user_name ', 'user_unit_name', 'count(*) as number','duty'), array('attr_name' => $attrName, 'meeting' => $meeting), ' group by duty');
    $listQuery = array();
    foreach ($query as $row) {
        $totalNumber += $row['number'];
        if ($row['duty'] > 0) {
            $listQuery[$row['duty']] = array($row['user_name'],$row['user_unit_name'], $row['number'], 0);
        }
    }
    include 'view/formated_out.html.php';
    exit;

}

function ajax_downLoad(){
    $key=$_GET['key'];
    $category=$_GET['category'];
    $data=null;
    if(isset($_SESSION[$key])){
        $data=$_SESSION[$key];

    }else{
        echo 'error';
        exit;
    }
    if(1==$category){
        $field=array('案号'=>'案号', '领衔人'=>'领衔人', '案由'=>'案由', '性质类别'=>'性质类别1', '当前环节'=>'当前环节', '交办单位'=>'交办单位', '主办单位'=>'主办单位', '协办单位'=>'协办单位');
    }else{
        $field=array('案号'=>'案号','性质'=>'性质','提案分类'=>'提案分类', '提案人'=>'提案人',
            '附议人'=>'附议人','委组'=>'委组','界别'=>'界别', '案由'=>'案由', '性质类别'=>'性质类别2',
            '交办单位'=>'交办单位', '主办单位'=>'主办单位', '协办单位'=>'协办单位',
            '主办答复时间'=>'主办答复时间','文号'=>'文号','签发人'=>'主办签发人',
            '办理工作'=>'办理工作','办理结果'=>'办理结果','办理面商形式'=>'面商形式','面商人'=>'面商人',
            '采纳情况'=>'采纳情况','落实情况'=>'落实情况','反馈意见全文'=>'反馈意见全文'
        );
    }
    $motionInfo=reGroupMotionInfList($data,$field);
//    mylog(getArrayInf($motionInfo));
    include 'view/motion_inf_output.html.php';
    unset($_SESSION[$key]);
    exit;

}
function response_by_unit(){//人大需求
    $totalList=array();
    $meeting=$_GET['meeting'];
    $category=$_GET['category'];
    $type=1==$category?'领衔人':'提案人';
    $where = array('category' => $category,'meeting'=>$meeting,'attr_name'=>$type);

    $mainDoneQuery = pdoQuery('s_duty_view', array('user_unit', 'user_unit_name', 'count(*) as number'), $where, 'group by user_unit');
    foreach ($mainDoneQuery as $row) {
        $totalList[$row['user_unit']]['user_unit_name'] = $row['user_unit_name'];
       $totalList[$row['user_unit']]['main_done'] = $row['number'];
    }

    $responseQuery = pdoQuery('s_duty_response_view', array('user_unit', 'response_type', 'response', 'count(*) as number'), $where, 'group by user_unit,response_type,response');
    foreach ($responseQuery as $row) {
        $totalList[$row['user_unit']][$row['response_type']][$row['response']] = $row['number'];
    }
    include"view/response_by_unit.html.php";
    exit;
}
function response_by_unit_type(){//人大需求
    $totalList=array();
    $meeting=$_GET['meeting'];
    $category=$_GET['category'];
    $type=1==$category?'领衔人':'提案人';
    $where = array('category' => $category,'meeting'=>$meeting,'attr_name'=>$type);

    $mainDoneQuery = pdoQuery('s_duty_type_view', array('user_unit', 'user_unit_name','type', 'count(*) as number'), $where, 'group by user_unit,type');
    foreach ($mainDoneQuery as $row) {
        $totalList[$row['user_unit']]['user_unit_name'] = $row['user_unit_name'];
        if(!isset($totalList[$row['user_unit']]['type'])){
            $totalList[$row['user_unit']]['type']=array();
            $totalList[$row['user_unit']]['typeCount']=0;
        }
        if(!isset($totalList[$row['user_unit']]['main_done']))$totalList[$row['user_unit']]['main_done']=0;
        if($row['type']){
            $totalList[$row['user_unit']]['type'][$row['type']]['main_done'] = $row['number'];
            $totalList[$row['user_unit']]['typeCount']+=1;
            $totalList[$row['user_unit']]['main_done'] += $row['number'];
        }
    }
    mylog(json_encode($totalList));

    $responseQuery = pdoQuery('s_duty_type_response_view', array('user_unit', 'response_type', 'response','type', 'count(*) as number'), $where, 'group by user_unit,response_type,response,type');
    foreach ($responseQuery as $row) {
        $totalList[$row['user_unit']]['type'][$row['type']][$row['response_type']][$row['response']] = $row['number'];
    }
//    include"view/temp.html.php";
    include"view/response_by_unit_type.html.php";
    exit;
}

function reply_table2()
{
    $motionId = $_GET['motion_id'];
    $meetingName = $_GET['meeting_name'];
    $category = $_GET['category'];
    $fileName = 1 == $category ? '议案建议反馈表' : '提案反馈表';
    $fileName .= timeUnixToMysql(time());
    header("Content-Type:text/html; charset=gb2312");
    header("Content-Type: application/doc");
    header("Content-Disposition: attachment; filename=$fileName.doc");
    $motionQuery = pdoQuery('motion_view', array('content', 'content_int', 'attr_name', 'target'), array('motion_id' => $motionId, 'attr_name' => array('提案人', '提案联系人', '领衔人', '案由', '案号', '主办单位', '协办单位')), null);
    $motionInf = array('meeting_name' => iconv('utf-8', 'gb2312//IGNORE', $meetingName));
//    $motionInf = array('meeting_name' => $meetingName);



    if (2 == $category) {
        foreach ($motionQuery as $row) {
            if ($row['content'] || $row['content_int']) {
                if ('提案人' == $row['attr_name']) {
                    $userInf = pdoQuery('duty_view', array('user_name', 'user_phone', 'address'), array('duty_id' => $row['content_int']), 'limit 1')->fetch();
                    $motionInf['user_name'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_name']);
                    if ($userInf['user_phone']) $motionInf['phone'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_phone']);
                    if ($userInf['user_phone']) $motionInf['phone'] =$userInf['user_phone'];

                    continue;
                }
                if ('提案联系人' == $row['attr_name']) {
                    $userInf = pdoQuery('duty_view', array('user_name', 'user_phone', 'address'), array('duty_id' => $row['content_int']), 'limit 1')->fetch();
                    $motionInf['phone'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_phone']);
                    $motionInf['phone'] = $userInf['user_phone'];

                    continue;
                }
                if ('协办单位' == $row['attr_name']) {
                    if (isset($motionInf['sub_handle'])) $motionInf['sub_handle'] .= '，' . DataSupply::indexToValue($row['target'], $row['content_int']);
                    else $motionInf['sub_handle'] = DataSupply::indexToValue($row['target'], $row['content_int']);
                    continue;
                }
                if ($row['target']) $row['content'] = DataSupply::indexToValue($row['target'], $row['content_int']);
                $motionInf[iconv('utf-8', 'gb2312//IGNORE', $row['attr_name'])] = iconv('utf-8', 'gb2312//IGNORE', $row['content'] ? $row['content'] : $row['content_int']);
                $motionInf[$row['attr_name']] = $row['content'] ? $row['content'] : $row['content_int'];

            }
        }
//        mylog(getArrayInf($motionInf));
        if (isset($motionInf['sub_handle'])) $motionInf['sub_handle'] = iconv('utf-8', 'gb2312//IGNORE', $motionInf['sub_handle']);
        include 'view/response_table2.html.php';
    }else{
            foreach ($motionQuery as $row) {
                if ($row['content'] || $row['content_int']) {
                    if ('领衔人' == $row['attr_name']) {
                        $userInf = pdoQuery('duty_view', array('user_name', 'user_phone', 'address'), array('duty_id' => $row['content_int']), 'limit 1')->fetch();
                        $motionInf['user_name'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_name']);
                    if ($userInf['user_phone']) $motionInf['phone'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_phone']);
                        if ($userInf['user_phone']) $motionInf['phone'] =$userInf['user_phone'];
                        continue;
                    }
                    if ('协办单位' == $row['attr_name']) {
                        if (isset($motionInf['sub_handle'])) $motionInf['sub_handle'] .= '，' . DataSupply::indexToValue($row['target'], $row['content_int']);
                        else $motionInf['sub_handle'] = DataSupply::indexToValue($row['target'], $row['content_int']);
                        continue;
                    }
                    if ($row['target']) $row['content'] = DataSupply::indexToValue($row['target'], $row['content_int']);
                $motionInf[iconv('utf-8', 'gb2312//IGNORE', $row['attr_name'])] = iconv('utf-8', 'gb2312//IGNORE', $row['content'] ? $row['content'] : $row['content_int']);
                    $motionInf[$row['attr_name']] = $row['content'] ? $row['content'] : $row['content_int'];

                }
            }
//        mylog(getArrayInf($motionInf));
        if (isset($motionInf['sub_handle'])) $motionInf['sub_handle'] = iconv('utf-8', 'gb2312//IGNORE', $motionInf['sub_handle']);
            include 'view/response_table1.html.php';
    }


    exit;
}
function unit_handle_info(){
    $unitId=$_GET['unit'];
    $data=handleDetailInfo($unitId);
    mylog(getArrayInf($data));
    if($data){
        $sortList=$data['mainHandle'];
        $sortList2=$data['handle'];
        $unitName=$data['unitName'];
        include 'view/formated_out_type2.html.php';
        exit;
    }
    exit;
}

/**
 * 每个单位的办理件详情表
 */
function batch_handle_info(){
    $unit=pdoQuery('unit_tbl',['unit_id','unit_name'],null,null);
    foreach ($unit as $row) {
        $data=handleDetailInfo($row['unit_id'],$row['unit_name']);
        if($data){
            $sortList=$data['mainHandle'];
            $sortList2=$data['handle'];
            $unitName=$data['unitName'];
            ob_start();
            include 'view/formated_out_type2.html.php';
            $content=ob_get_contents();
            mylog($content);
            file_put_contents(iconv('UTF-8', 'GBK',$GLOBALS['mypath'].'/temp/'.$unitName.'.xls'),$content);
            ob_end_clean();
        }
    }
    exit;
}

function non_motion_user(){
    $category=$_GET['category'];
    $meeting=$_GET['meeting'];
    $attrname=1==$category?'领衔人':'提案人';
    $unit=1==$category?'中心组':'委组';
    $group=1==$category?'代表团':'界别';
    $query=pdoQuery('duty_view',['user_name','user_phone','address','user_unit_name','user_group_name','duty_id'],['meeting'=>$meeting,'category'=>$category],null);

    foreach ($query as $row) {
        $dutyList[$row['duty_id']]=$row;
    }
    $query=pdoQuery('motion_view',['content_int'],['meeting'=>$meeting,'category'=>$category,'attr_name'=>$attrname],null);
    foreach ($query as $row) {
        if(isset($dutyList[$row['content_int']]))unset($dutyList[$row['content_int']]);
    }
    $title = "<tr><td>姓名</td><td>电话</td><td>工作单位</td><td>$unit</td><td>$group</td></tr>";
    $fieldCount=5;
    $fileName=2==$category?"无提案委员统计":'无建议代表统计';
    $listQuery=$dutyList;
    include 'view/formated_out.html.php';
    exit;
}
function user_motion_count(){
    $category=$_GET['category'];
    $meeting=$_GET['meeting'];
    $attrname=1==$category?'领衔人':'提案人';
    $unit=1==$category?'中心组':'委组';
    $group=1==$category?'代表团':'界别';
    $query=pdoQuery('duty_view',['user_name','user_phone','address','user_unit_name','user_group_name','duty_id'],['meeting'=>$meeting,'category'=>$category],null);

    foreach ($query as $row) {
        $dutyList[$row['duty_id']]=$row;
        $dutyList[$row['duty_id']][5]=0;
        $dutyList[$row['duty_id']][6]=0;
//        mylog(json_encode( $dutyList[$row['duty_id']]));
    }
    $query=pdoQuery('motion_view',['attr_name','content_int'],['meeting'=>$meeting,'category'=>$category,'attr_name'=>[$attrname,'附议人']],null);
    foreach ($query as $row) {
        if($attrname==$row['attr_name']){
            $dutyList[$row['content_int']][5]++;
        }else{
            if($row['content_int'])$dutyList[$row['content_int']][6]++;
        }

    }
//    $coopQuery=pdoQuery('motion_view',['content_int'],['meeting'=>$meeting,'category'=>$category,'attr_name'=>'附议人'],null);
//    foreach ($coopQuery as $row) {
//        $dutyList[$row['content_int']][6]++;
//    }
    $meetingName=getMeetingName($meeting);
    $title = "<tr><td>姓名</td><td>电话</td><td>工作单位</td><td>$unit</td><td>$group</td><td>领衔建议数</td><td>附议建议数</td></tr>";
    $fieldCount=7;
    $fileName=2==$category?$meetingName."委员提案数量统计":$meetingName.'代表建议数量统计';
    $listQuery=$dutyList;
    include 'view/formated_out.html.php';
    exit;
}
function have_coop_motion(){
    $category=$_GET['category'];
    $meeting=$_GET['meeting'];
    $query=pdoQuery('motion_view',['motion_id'],['attr_name'=>'附议人','meeting'=>$meeting,'category'=>$category],' and content_int is not null');
    $motionList=[];
    foreach ($query as $row) {
        $motionList[]=$row['motion_id'];
    }
    if(1==$category){
        $field=array('案号'=>'案号', '领衔人'=>'领衔人', '案由'=>'案由', '性质类别'=>'性质类别1','附议人'=>'附议人');
    }else{
        $field=array('案号'=>'案号', '提案人'=>'提案人', '案由'=>'案由', '性质类别'=>'性质类别2','附议人'=>'附议人');
    }
    $motionInfo=reGroupMotionInfList($motionList,$field);
    include 'view/motion_inf_output.html.php';
    exit;
}

/**
 * 集体提案统计
 */
function group_motion(){
    $meeting=$_GET['meeting'];
    $listQuery=singleFilterStatistics('提案分类','党派团体',$meeting);
    $title = "<tr><td>单位</td><td>数量</td></tr>";
    $fieldCount=2;
    $fileName=getMeetingName($meeting).'集体提案统计';
//    $listQuery=$dutyList;
    include 'view/formated_out.html.php';
    exit;
}

function denied_motion(){
    $meeting=$_GET['meeting'];
    $title = "<tr><td>单位</td><td>数量</td></tr>";
    $fieldCount=2;
    $fileName=getMeetingName($meeting).'不予立案提案统计';
    $listQuery=singleFilterStatistics('审核2','不予立案',$meeting);
    include 'view/formated_out.html.php';
    exit;
}






/*
 * 以下为非get方法
 */

function singleFilterStatistics($attrName,$attrValue,$meeting){
    $limit=pdoQuery('motion_view',['motion_id'],['attr_name'=>$attrName,'content'=>$attrValue,'meeting'=>$meeting],null)->fetchAll();
    $inf=pdoQuery('motion_view',['content_int'],['meeting'=>$meeting,'motion_id'=>$limit,'attr_name'=>['提案人','领衔人']],null);
    $listQuery=[];
    foreach ($inf as $row) {
        if(isset($listQuery[$row['content_int']])){
            $listQuery[$row['content_int']][1]++;
        }else{
            $listQuery[$row['content_int']][0]=DataSupply::indexToValue('duty',$row['content_int']);
            $listQuery[$row['content_int']][1]=1;
        }
    }
    return $listQuery;
}

function handleDetailInfo($unitId,$unitName=null){
//    $unitId=$_GET['unit'];
    if(!$unitName)$unitName=pdoQuery('unit_tbl',null,array('unit_id'=>$unitId),'limit 1')->fetch()['unit_name'];
    $whereFilter=['attr_name'=>['主办单位','协办单位'],'content_int'=>$unitId];
    if($_SESSION['staffLogin']['category']<3)$whereFilter['category']=$_SESSION['staffLogin']['category'];
    $motionLimit=array();
    $sortList=array();
    $sortList2=array();
    $limitQuery=pdoQuery('motion_view',array('motion_id'),$whereFilter,null);

    foreach ($limitQuery as $row) {
        $motionLimit[]=$row['motion_id'];
    }
    if(count($motionLimit)>0){
        $field=array('案号', '领衔人', '提案人', '案别', '案由', '性质类别1', '性质类别2', '原文', '当前环节', '交办单位', '协办单位', '主办单位');
        $motionDetail = pdoQuery('motion_view', null, array('motion_id' => $motionLimit, 'attr_name' => $field), null);
        foreach ($motionDetail as $row) {
//        if(!$singleRow)$singleRow=$row;
            $content = 'string' == $row['value_type'] ? $row['content'] : $row['content_int'];
            $content = 'attachment' == $row['value_type'] ? $row['attachment'] : $content;
            if ('index' == $row['value_type']) {
                $content = DataSupply::indexToValue($row['target'], $content);
            }


            if (!isset($sortList[$row['motion_id']][$row['attr_name']])) $sortList[$row['motion_id']][$row['attr_name']] = $content;
            else $sortList[$row['motion_id']][$row['attr_name']] .= ',' . $content;
            $sortList[$row['motion_id']]['案由'] = $row['motion_name'];
        $sortList[$row['motion_id']]['案别']=2==$row['category']?'建议':'提案';
            $sortList[$row['motion_id']]['当前环节'] = $row['step_name'];
//        $sortList[$row['motion_id']]['编号'] = $row['zx_motion'];
            $sortList[$row['motion_id']]['category']=$row['category'];
        }
        foreach ($sortList as $k => $row) {
            if($unitName!=$row['主办单位']){
                $sortList2[$k]=$row;
                unset($sortList[$k]);
            }
        }
        return ['unitName'=>$unitName,'mainHandle'=>$sortList,'handle'=>$sortList2];
    }else{
        return false;
    }


}

function getMeetingName($meetingId)
{
    return pdoQuery('meeting_tbl', array('meeting_name'), array('meeting_id' => $meetingId), 'limit 1')->fetch()['meeting_name'];
}

function reGroupMotionInfList($motionList,$motionFiled){
    $motionQuery=pdoQuery('motion_view',['motion_id','attr_name','step_name','meeting','category','content','content_int','target','value_type','attachment'],['motion_id'=>$motionList],null);
    $dutyList=null;
    $sortList=array();

//    mylog(getArrayInf($dutyList));

    foreach ($motionQuery as $row) {
        if(!$dutyList){
            $dutyInf=pdoQuery('duty_view',['duty_id','user_name','user_phone','user_unit_name','user_group_name'],['category'=>$row['category'],'meeting'=>$row['meeting']],null);
            foreach ($dutyInf as $v) {
                $dutyList[$v['duty_id']]=$v;
            }
        }
        if(in_array($row['attr_name'],$motionFiled)){
            $content = 'string' == $row['value_type'] ? $row['content'] : $row['content_int'];
            $content = 'attachment' == $row['value_type'] ? $row['attachment'] : $content;
            if ('index' == $row['value_type']&&$row['content_int']) {
                if('duty'==$row['target'])$content=$dutyList[$row['content_int']]['user_name'];
                else $content = DataSupply::indexToValue($row['target'], $content);
                if('提案人'==$row['attr_name']){
                    $sortList[$row['motion_id']]['委组']=$dutyList[$row['content_int']]['user_unit_name'];
                    $sortList[$row['motion_id']]['界别']=$dutyList[$row['content_int']]['user_group_name'];
                }
            }
            if('time'==$row['attr_name']){
                $content=timeUnixToMysql($row['content']);
            }

            if (!isset($sortList[$row['motion_id']][$row['attr_name']])) $sortList[$row['motion_id']][$row['attr_name']] = $content;
            else $sortList[$row['motion_id']][$row['attr_name']] .= ',' . $content;
            $sortList[$row['motion_id']]['category']=$row['category'];
        }else{

        }
    }
    return $sortList;

}

function getBrowserType(){
    $userAgent = strtolower ( $_SERVER ["HTTP_USER_AGENT"] );
    if (strpos ( $userAgent, 'msie' ) !== false) {
        return "msie";
    } else if (strpos ( $userAgent, 'firefox' ) !== false) {
        return "firefox";
    } else if (strpos ( $userAgent, 'applewebkit' ) !== false) {
        return "applewebkit";
    } else if (strpos ( $userAgent, 'opera' ) !== false) {
        return "opera";
    } else if (strpos ( $userAgent, 'safari' ) !== false) {
        return "safari";
    } else {
        return "other";
    }
}
function encodeFileName($filename){
    $broswerType=getBrowserType();
    $newFileName=$filename;
    switch ($broswerType) {
        case "other":
            $newFileName=urlencode($filename);
            break;
        default;
            break;

//        case "msie" :
//            return "filename=/urlencode ( $new_filename ) . ".xls/"";
//    break;
//        case "opera" :
//            return "filename*=UTF-8''" . $new_filename . ".xls/"";
//    break;
//   case "safari" :
//    return "filename=/"" . urlencode ( $new_filename ) . ".xls/"";
//    break;
//   case "applewebkit" :
//    return "filename=/"". urlencode ( $new_filename ) ."/"";
//    break;
//   case "firefox" :
//    return "filename*=UTF-8''" . $new_filename . ".xls /"";
//    break;
//        default :
//            return "filename=/"" . urlencode ( $new_filename ) . "ot.xls/"";
//    break;
    }
    return $newFileName;
}

