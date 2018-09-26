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
    if(in_array(4,$_SESSION['staffLogin']['steps'])&&1==count($_SESSION['staffLogin']['steps'])){
        $meeting=pdoQuery('meeting_tbl',['meeting_id'],null,'order by end_time desc limit 2')->fetchAll();
        $name="人大政协建议提案";
//        $meeting=[3,4];
    }
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

        if (isset($optionList[$row['attr_name'] . '+' . $row['content']])) {
            $optionList[$row['attr_name'] . '+' . $row['content']]++;
        }
        if ($row['content_int']) {
            if ('交办单位' == $row['attr_name']) {
                if (isset($unitList[$row['content_int']])) {
                    $unitList[$row['content_int']]++;
                } else {
                    $unitList[$row['content_int']] = 1;
                }
            }
            if ('主办单位' == $row['attr_name']) {
                if (isset($mainHandleList[$row['content_int']])) {
                    $mainHandleList[$row['content_int']]++;
                } else {
                    $mainHandleList[$row['content_int']] = 1;
                }
                if (isset($handleList[$row['content_int']])) {
                    $handleList[$row['content_int']]++;
                } else {
                    $handleList[$row['content_int']] = 1;
                }
            }
            if ('协办单位' == $row['attr_name']) {
                if (isset($handleList[$row['content_int']])) {
                    $handleList[$row['content_int']]++;
                } else {
                    $handleList[$row['content_int']] = 1;
                }
            }
        }

    }
    $allUserList=[];//委员表
    $allGroupList=[];//委组表
    $userQuery=pdoQuery('duty_view',null,['meeting'=>$meeting,'activity'=>1],null);
    $userQuery->setFetchMode(PDO::FETCH_ASSOC);
    foreach ($userQuery as $row) {
        if(0==$row['user_unit']||0==$row['user_group']){
            $allGroupList[]=$row['duty_id'];
        }else{
            $allUserList[]=$row['duty_id'];
        }
    }
    $dutyHaveMotionList=[];
    $groupHaveMotionList=[];
    $totalMotionNumber=pdoQuery('motion_tbl',['count(0) as count'],['meeting'=>$meeting,'step>0'],'limit 1')->fetch()['count'];
    $allValue=pdoQuery('motion_view',null,['meeting'=>$meeting,'attr_name'=>['提案人','性质类别2','初审','性质']],null);
    $passedMotionList=[];
    $totalNotPassMotion=0;
    $importent=0;
    $count1=0;
    $count2=0;
    $count3=0;
    $count4=0;
    foreach ($allValue as $row) {
        $content_int=$row['content_int'];
        $content=$row['content'];
        $motion=$row['motion_id'];
        switch($row['attr_name']){
            case '提案人':
                $duty=$row['content_int'];
                if(in_array($duty,$allUserList)){
                    $dutyHaveMotionList[$content_int]=$content_int;
                }
                if(in_array($duty,$allGroupList)){
                    $groupHaveMotionList[$motion]=$content_int;
                }
                break;
            case '性质类别2':

                if(in_array($content,["工业经济","农林水利","财贸金融"])){
                    $count1++;
                }
                if(in_array($content,["道路交通","城建管理","环境保护"]))$count2++;
                if(in_array($content,["医药卫生","科技教育","文化体育"]))$count3++;
                if(in_array($content,["劳动人事","政法统战","其他"]))$count4++;
                break;
            case '初审':
                if($content=='立案'||'并案'==$content&&$row['step']>3){
                    $passedMotionList[$motion]=$motion;
                }else{
                    $totalNotPassMotion++;
                }
                break;
            case '性质':
                if('重点提案'==$content)$importent++;
                break;
        }
    }
    $totalPassedMotion=count($passedMotionList);
    $passedValue=pdoQuery('motion_view',null,['meeting'=>$meeting,'motion_id'=>$passedMotionList,'attr_name'=>['提案人','性质类别2','初审']],null);
    $count11=0;
    $count22=0;
    $count33=0;
    $count44=0;
    foreach ($passedValue as $row) {
        $content_int=$row['content_int'];
        $content=$row['content'];
        $motion=$row['motion_id'];
        switch($row['attr_name']){
            case '提案人':
                $duty=$row['content_int'];
                if(in_array($duty,$allUserList)){
                    $dutyHaveMotionList[$content_int]=$content_int;
                }
                if(in_array($duty,$allGroupList)){
                    $groupHaveMotionList[]=$content_int;
                }
                break;
            case '性质类别2':

                if(in_array($content,["工业经济","农林水利","财贸金融"])){
                    $count11++;
                }
                if(in_array($content,["道路交通","城建管理","环境保护"]))$count22++;
                if(in_array($content,["医药卫生","科技教育","文化体育"]))$count33++;
                if(in_array($content,["劳动人事","政法统战","其他"]))$count44++;
                break;
        }
    }


    $name = getMeetingName($meeting);
    include "view/statistics_document.html.php";
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
        $field=array('案号'=>'案号', '领衔人'=>'领衔人', '案由'=>'案由', '性质类别'=>'性质类别1', '当前环节'=>'当前环节', '交办单位'=>'交办单位', '主办单位'=>'主办单位', '协办单位'=>'协办单位','类别标记'=>'类别标记');
    }else{
        $field=array('登记号'=>'登记号','案号'=>'案号','性质'=>'性质','提案分类'=>'提案分类', '提案人'=>'提案人',
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

/**
 * 20180619新需求
 */
function statistics_by_unit_type(){
    $meeting=$_GET['meeting'];
    $name="主办单位类别标记统计";
    if(in_array(4,$_SESSION['staffLogin']['steps'])&&1==count($_SESSION['staffLogin']['steps'])){
        $meeting=pdoQuery('meeting_tbl',['meeting_id'],null,'order by end_time desc limit 2')->fetchAll();
        $name="人大政协建议提案主办单位类别标记统计";
//        $meeting=[3,4];
    }
    $baseMotions=pdoQuery('motion_view',['motion_id','content'],['meeting'=>$meeting,'attr_template'=>21,'content is not null'],null);
    $motionList=[];
    $typeList=[];
    foreach ($baseMotions as $row) {
        $typeList[$row['motion_id']]=$row['content'];
        $motionList[]=$row['motion_id'];
    }
    $unitQuery=pdoQuery('motion_view',['motion_id','content_int'],['motion_id'=>$motionList,'attr_template'=>13],null);
    $unitList=[];
    foreach ($unitQuery as $row) {
        $type=$typeList[$row['motion_id']];
        if(!isset($unitList[$row['content_int']])){
            $unitName=DataSupply::indexToValue('unit',$row['content_int']);
            $unitList[$row['content_int']]=['name'=>$unitName,'list'=>[]];
            $unitList[$row['content_int']]['list'][$type]=1;
        }else{
            if(!isset($unitList[$row['content_int']]['list'][$type]))$unitList[$row['content_int']]['list'][$type]=1;
            else $unitList[$row['content_int']]['list'][$type]++;
        }
    }
    $totalA=0;
    $totalB=0;
    $totalC=0;
    $totalD=0;
    include"view/statistic_by_unit_type.html.php";
    exit;
}

/**
 * 20180806人大新需求
 */
function response_statistics(){
    $meeting=$_GET['meeting'];
    $category=$_GET['category'];
    $attrName=1==$category?['案号','案由','主办单位','类别标记','面商人1','协商形式1','问题解决情况1','意见采纳情况1','办理工作','办理结果']:['案号','案由'];
    $query=pdoQuery('motion_view',null,['meeting'=>$meeting,'step'=>7,'attr_name'=>$attrName],null);
    $displeasureQuery=pdoQuery('displeasure_motion_view',null,['meeting'=>$meeting,'attr_name'=>$attrName,'motion_id in (select motion from displeasure_attr_tbl)'],null);
    $displeasureQuery->setFetchMode(PDO::FETCH_ASSOC);
    $query->setFetchMode(PDO::FETCH_ASSOC);
    $info=[];
    $count=[];
    foreach ($query as $row) {
        $value=$row['content']?$row['content']:$row['content_int'];
        if('unit'==$row['target'])$value=DataSupply::indexToValue('unit',$value);
        if(isset($info[$row['motion_id']])){
            $info[$row['motion_id']][$row['attr_name']]=$value;
        }else{
            $info[$row['motion_id']]=[$row['attr_name']=>$value];
        }
        if(!isset($count[$value]))$count[$value]=1;
        else $count[$value]++;
        if('办理工作'==$row['attr_name']){
            if(!isset($count['办理工作'][$value]))$count['办理工作'][$value]=1;
            else $count['办理工作'][$value]++;
        }
        if('办理结果'==$row['attr_name']){
            if(!isset($count['办理结果'][$value]))$count['办理结果'][$value]=1;
            else $count['办理结果'][$value]++;
        }
    }
    $total=count($info);
    foreach($displeasureQuery as $row){
        $value=$row['content']?$row['content']:$row['content_int'];
        if('unit'==$row['target'])$value=DataSupply::indexToValue('unit',$value);
        if(isset($info[$row['motion_id'].'(存档)'])){
            $info[$row['motion_id'].'(存档)'][$row['attr_name']]=$value;
        }else{
            $info[$row['motion_id'].'(存档)']=[$row['attr_name']=>$value];
        }

    }
    function compare($element1,$element2){
        if($element1['案号']>$element2['案号'])return 1;
        else return -1;
    }
    usort($info,'compare');

    mylog(json_encode($info,JSON_UNESCAPED_UNICODE));

    include 'view/response_statistics1.html.php';
    exit;

}


/**
 * 20180926人大新需求
 */
function response_statistics_unit(){
    $meeting=$_GET['meeting'];
    $category=$_GET['category'];
    $attrName=1==$category?['主办单位','类别标记','面商人1','协商形式1','问题解决情况1','意见采纳情况1','办理工作','办理结果']:['案号','案由'];

    $query=pdoQuery('motion_view',null,['meeting'=>$meeting,'step'=>7,'attr_name'=>$attrName],null);

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
//            include 'view/response_table1.html.php';
        include 'view/new_response1.html.php';
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
    $query=pdoQuery('duty_view',['user_name','user_phone','address','user_unit_name','user_group_name','duty_id'],['meeting'=>$meeting,'category'=>$category,'activity'=>1],null);

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
    $query=pdoQuery('duty_view',['user_name','user_phone','address','user_unit_name','user_group_name','duty_id'],['meeting'=>$meeting,'category'=>$category,'activity'=>1],null);

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

function motion_menu(){
    function mySort($a,$b){
        return $a[34]>$b[34]?1:-1;
    }
    $meeting=$_GET['meeting'];
    $category=$_GET['category'];
    $type=isset($_GET['type']);
    $isReply=isset($_GET['reply']);
    $back=getMenu(['meeting'=>$meeting,'category'=>$category]);
    $totalCount=0;
    $detail=$back;
    $name=$type?'议案':'建议';
//    mylog(getArrayInf($detail));
//    $info=[];
    $info=['政治法律'=>['count'=>0],'财政经济'=>['count'=>0],'城建环保'=>['count'=>0],'教科文卫'=>['count'=>0],'农业农村'=>['count'=>0],'其他'=>['count'=>0]];
    foreach ($detail as $row) {
        if($type&&'建议'==$row[90]){
            continue;
        }else if('议案'==$row[90]){
            continue;
        }
        $totalCount++;
        if(!$row[83]){
            $row[83]='无分类';
        }
        if(!$row[34])$row[34]='无';
        if(isset($info[$row[83]])){
            $info[$row[83]]['count']++;
            $info[$row[83]]['motions'][]=$row;
        }else{

            $info[$row[83]]=['count'=>1,'motions'=>[$row]];
        }
    }
//    mylog(getArrayInf($info));

    header("Content-Type:text/html; charset=gb2312");
    header("Content-Type: application/doc");
    header("Content-Disposition: attachment; filename=menu.doc");
    if($isReply){
        include 'view/download_template/rd_menu_view2.html.php';
    }else{
        include 'view/download_template/rd_menu_view3.html.php';
    }
    exit;
}

/**
 * 按性质类别统计
 */
function statistics_by_category(){
    $meeting=$_GET['meeting'];
    $category=$_GET['category'];
    $attr_name="性质类别".$category;
    $query=pdoQuery('motion_view',['content','count(*) as number'],['meeting'=>$meeting,'attr_name'=>$attr_name],' group by content order by number desc');
    $total=0;
    $preList=[];
    $listQuery=[];
    foreach ($query as $row) {
        mylog(getArrayInf($row));
        $total+=$row['number'];
        $preList[]=$row;;
    }
    foreach ($preList as $row) {
        $listQuery[]=[$row['content'],$row['number'],sprintf("%.2f", $row[1] / $total * 100)."%"];
    }
    $listQuery[]=['合计',$total,'100%'];


    $title = "<tr><td>性质类别</td><td>件数</td><td>百分比</td></tr>";
    $fieldCount=3;
    $fileName='性质类别统计';
    include 'view/formated_out.html.php';
    exit;

}


function getCover(){
    $id = $_SESSION['staffLogin']['currentMotion'];
    if($id){
        $motionQuery=pdoQuery('motion_view',['motion_attr','content_int','content'],['motion_id'=>$id],null);
        $motion=[];
        foreach ($motionQuery as $row) {
            $motion[$row['motion_attr']]=$row['content']?$row['content']:$row['content_int'];
        }
        $userInf=pdoQuery('duty_view',null,['duty_id'=>$motion[84]],'limit 1')->fetch();
        if($motion[91]){
            $contectInf=pdoQuery('duty_view',null,['duty_id'=>$motion[91]],'limit 1')->fetch();
            $userInf['user_phone']=$contectInf['user_phone'];
            $contact=$contectInf['user_name'];
        }
        if('123456'==$userInf['user_phone'])$userInf['user_phone']='';

        header("Content-Type:text/html; charset=gb2312");
        header("Content-Type: application/doc");
        header("Content-Disposition: attachment; filename=menu.doc");

        include "/view/download_template/cover.mht";
        exit;
    }
    echo 'error';
    exit;

}
function getCover1(){
    $id = $_SESSION['staffLogin']['currentMotion'];
    if($id){
        $motionQuery=pdoQuery('motion_view',['motion_attr','content_int','content'],['motion_id'=>$id],null);
        $motion=[];
        foreach ($motionQuery as $row) {
            $motion[$row['motion_attr']]=$row['content']?$row['content']:$row['content_int'];
        }
        $userInf=pdoQuery('duty_view',null,['duty_id'=>$motion[84]],'limit 1')->fetch();

        header("Content-Type:text/html; charset=gb2312");
        header("Content-Type: application/doc");
        header("Content-Disposition: attachment; filename=menu.doc");

        include "/view/download_template/cover1.xml";
        exit;
    }
    echo 'error';
    exit;

}


function getFile(){

//    mylog($_GET['field']);
//    mylog($_GET['id']);
    $id=$_GET['id'];
    $path=$_GET['field'];
    $file=pdoQuery('attr_tbl',null,['motion'=>$id,'attachment'=>$path],'limit 1')->fetch();
    $name=$file['content'];
    header("Content-Type:text/html; charset=gb2312");
    header("Content-Type: application/doc");
    header("Content-Disposition: attachment; filename=".iconv("utf-8","gb2312",$name));

    include $path;
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
    $motionQuery=pdoQuery('motion_view',['motion_id','attr_name','step_name','meeting','category','content','content_int','target','value_type','attachment','step'],['motion_id'=>$motionList],null);
    $dutyList=null;
    $sortList=array();

//    mylog(getArrayInf($dutyList));

    foreach ($motionQuery as $row) {
        $stepList=[1=>'提交',2=>'登记',3=>'审核',4=>'交办',5=>'办理',6=>'反馈',7=>'完成'];
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
            if(!isset($sortList[$row['motion_id']]['当前环节']))$sortList[$row['motion_id']]['当前环节']=$stepList[$row['step']];
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

function getMenu($data){
    $category=$data['category'];
    $meeting=$data['meeting'];
    $attrNameList=[];
    if(1==$category){
        $attrNameList=['案别','案号','领衔人','案由','性质类别1'];
    }else{
        $attrNameList=['案号','领衔人','案由','性质类别1'];
    }
    $query=pdoQuery('motion_view',null,['meeting'=>$meeting,'attr_name'=>$attrNameList],null);
//    $query->setFetchMode(PDO::FETCH_ASSOC);
    $result=[];
//    $totalCount=0;
    foreach ($query as $row) {
//        $totalCount++;
        if('index'==$row['value_type']){
            $row['content']=DataSupply::indexToValue('duty',$row['content_int']);
        }
//        $result[$row['motion_id']][$row['attr_name']]=$row['content']?$row['content']:$row['content_int'];
        $result[$row['motion_id']][$row['motion_attr']]=$row['content']?$row['content']:$row['content_int'];

    }
    return $result;

//    foreach ($result as $row) {
//        mylog(getArrayInf($row));
//    }


}

