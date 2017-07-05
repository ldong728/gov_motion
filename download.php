<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/5/23
 * Time: 14:29
 */
//global $meetingName=

function multiple_statistics()
{
    mylog('multiple_statistics');
    $inf = array('');
    $total =

    $query = pdoQuery('s_duty_view', null, array('category' => $_SESSION['staffLogin']['category']), null);
    foreach ($query as $row) {
        if ('提案人' == $row['attr_name']) {

            if (!$row['user_unit']) {

            } elseif (!$row['user_group']) {

            } else {

            }
        }
    }

    include 'view/statistics_document.html.php';
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
    $fieldCount = 3;
    $meeting = 'all' == $_SESSION['staffLogin']['meeting'] ? 2 : $_SESSION['staffLogin']['meeting'];
    $fileName = getMeetingName($meeting);
    $fileName .= '各界别提交提案数量统计';
    $totalNumber = 0;
    $title = '<tr><td>界别</td><td>件数</td><td>平均百分比</td></tr>';
    $query = pdoQuery('s_duty_view', array('user_group', 'user_group_name', 'count(*) as number',), array('attr_name' => '提案人', 'meeting' => $meeting), ' group by user_group');
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
    $fieldCount = 3;
    $meeting = 'all' == $_SESSION['staffLogin']['meeting'] ? 2 : $_SESSION['staffLogin']['meeting'];
    $fileName = getMeetingName($meeting);
    $fileName .= '各委组提交提案数量统计';
    $totalNumber = 0;
    $title = '<tr><td>委组</td><td>件数</td><td>平均百分比</td></tr>';
    $query = pdoQuery('s_duty_view', array('user_unit ', 'user_unit_name', 'count(*) as number',), array('attr_name' => '提案人', 'meeting' => $meeting), ' group by user_unit');
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

function reply_table2()
{
    $motionId = $_GET['motion_id'];
    $meetingName = $_GET['meeting_name'];
    $category = $_GET['category'];
    $fileName = 1 == $category ? '建议反馈表' : '提案反馈表';
    $fileName .= timeUnixToMysql(time());
//    header("Content-Type:text/html; charset=gb2312");
    header("Content-Type: application/doc");
    header("Content-Disposition: attachment; filename=$fileName.doc");
    $motionQuery = pdoQuery('motion_view', array('content', 'content_int', 'attr_name', 'target'), array('motion_id' => $motionId, 'attr_name' => array('提案人', '提案联系人', '领衔人', '案由', '案号', '主办单位', '协办单位')), null);
//    $motionInf = array('meeting_name' => iconv('utf-8', 'gb2312//IGNORE', $meetingName));
    $motionInf = array('meeting_name' => $meetingName);



    if (2 == $category) {
        foreach ($motionQuery as $row) {
            if ($row['content'] || $row['content_int']) {
                if ('提案人' == $row['attr_name']) {
                    $userInf = pdoQuery('duty_view', array('user_name', 'user_phone', 'address'), array('duty_id' => $row['content_int']), 'limit 1')->fetch();
                    $motionInf['user_name'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_name']);
//                    if ($userInf['user_phone']) $motionInf['phone'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_phone']);
                    if ($userInf['user_phone']) $motionInf['phone'] =$userInf['user_phone'];

                    continue;
                }
                if ('提案联系人' == $row['attr_name']) {
                    $userInf = pdoQuery('duty_view', array('user_name', 'user_phone', 'address'), array('duty_id' => $row['content_int']), 'limit 1')->fetch();
//                    $motionInf['phone'] = iconv('utf-8', 'gb2312//IGNORE', $userInf['user_phone']);
                    $motionInf['phone'] = $userInf['user_phone'];

                    continue;
                }
                if ('协办单位' == $row['attr_name']) {
                    if (isset($motionInf['sub_handle'])) $motionInf['sub_handle'] .= '，' . DataSupply::indexToValue($row['target'], $row['content_int']);
                    else $motionInf['sub_handle'] = DataSupply::indexToValue($row['target'], $row['content_int']);
                    continue;
                }
                if ($row['target']) $row['content'] = DataSupply::indexToValue($row['target'], $row['content_int']);
//                $motionInf[iconv('utf-8', 'gb2312//IGNORE', $row['attr_name'])] = iconv('utf-8', 'gb2312//IGNORE', $row['content'] ? $row['content'] : $row['content_int']);
                $motionInf[$row['attr_name']] = $row['content'] ? $row['content'] : $row['content_int'];

            }
        }
//        mylog(getArrayInf($motionInf));
//        if (isset($motionInf['sub_handle'])) $motionInf['sub_handle'] = iconv('utf-8', 'gb2312//IGNORE', $motionInf['sub_handle']);
        include 'view/response_table2.html.php';
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



/*
 * 以下为非get方法
 */

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
//        $sortList[$row['motion_id']]['案别']=2==$row['category']?'建议':'提案';
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

