<?php
/**
 * Created by PhpStorm.
 * User: Administrator
 * Date: 2017/5/23
 * Time: 14:29
 */
//global $meetingName=

function multiple_statistics(){
    mylog('multiple_statistics');
    $inf=array('');
    $total=

    $query=pdoQuery('s_duty_view',null,array('category'=>$_SESSION['staffLogin']['category']),null);
    foreach ($query as $row) {
        if('提案人'==$row['attr_name']){

            if(!$row['user_unit']){

            }elseif(!$row['user_group']){

            }else{

            }
        }
    }

    include 'view/statistics_document.html.php';
    exit;
}
function motion_1_list(){
    $fieldCount=5;
    $meeting='all'==$_SESSION['staffLogin']['meeting']?2:$_SESSION['staffLogin']['meeting'];
    $fileName=pdoQuery('meeting_tbl',array('meeting_name'),array('meeting_id'=>$meeting),'limit 1')->fetch()['meeting_name'];
    $fileName.="议案建议汇总";
    $title='<tr><td>案号</td><td>案由</td><td>领衔人</td><td>主办单位</td><td>性质类别</td></tr>';
    $listQuery=pdoQuery('s_motion1_view',array('motion_num','motion_title','name','unit_name','type'),array('meeting'=>$meeting),' order by motion_num asc')->fetchAll();
    include 'view/formated_out.html.php';
    exit;
}

/**
 * 政协界别统计
 */
function sta1(){
    $fieldCount=3;
    $meeting='all'==$_SESSION['staffLogin']['meeting']?2:$_SESSION['staffLogin']['meeting'];
    $fileName=getMeetingName($meeting);
    $fileName.='各界别提交提案数量统计';
    $totalNumber=0;
    $title='<tr><td>界别</td><td>件数</td><td>平均百分比</td></tr>';
    $query=pdoQuery('s_duty_view',array('user_group','user_group_name','count(*) as number',),array('attr_name'=>'提案人','meeting'=>$meeting),' group by user_group');
    $listQuery=array();
    foreach ($query as $row) {
        $totalNumber+=$row['number'];
        if($row['user_group']>0){
            $listQuery[$row['user_group']]=array($row['user_group_name'],$row['number'],0);
        }
    }
//    mylog(getArrayInf($listQuery));
    foreach ($listQuery as $key=>$row) {
        $listQuery[$key][2]=sprintf("%.2f",$row[1]/$totalNumber*100).'%';
    }
    mylog(getArrayInf($listQuery));
    include 'view/formated_out.html.php';
    exit;
}

/**
 * 政协委组统计
 */
function sta2(){
    $fieldCount=3;
    $meeting='all'==$_SESSION['staffLogin']['meeting']?2:$_SESSION['staffLogin']['meeting'];
    $fileName=getMeetingName($meeting);
    $fileName.='各委组提交提案数量统计';
    $totalNumber=0;
    $title='<tr><td>委组</td><td>件数</td><td>平均百分比</td></tr>';
    $query=pdoQuery('s_duty_view',array('user_unit ','user_unit_name','count(*) as number',),array('attr_name'=>'提案人','meeting'=>$meeting),' group by user_unit');
    $listQuery=array();
    foreach ($query as $row) {
        $totalNumber+=$row['number'];
        if($row['user_unit']>0){
            $listQuery[$row['user_unit']]=array($row['user_unit_name'],$row['number'],0);
        }
    }
//    mylog(getArrayInf($listQuery));
    foreach ($listQuery as $key=>$row) {
        $listQuery[$key][2]=sprintf("%.2f",$row[1]/$totalNumber*100).'%';
    }
    mylog(getArrayInf($listQuery));
    include 'view/formated_out.html.php';
    exit;
}




function getMeetingName($meetingId){
    return pdoQuery('meeting_tbl',array('meeting_name'),array('meeting_id'=>$meetingId),'limit 1')->fetch()['meeting_name'];
}