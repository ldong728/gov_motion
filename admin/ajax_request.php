<?php
include_once '../includePackage.php';
session_start();

if (isset($_SESSION['login'])&&DOMAIN==$_SESSION['login']) {

    if(isset($_POST['pms'])&&array_key_exists($_POST['pms'],$_SESSION['pms'])){
        if(isset($_POST['method'])){
            switch ($_POST['method']) {

                default:
                    $method=trim($_POST['method']);
                    $method($_POST['ajax_data']);
                    break;
            }
        }
        if (isset($_POST['alteTblVal'])) {//快速更改
            $altValues=array();
            foreach ($_POST['col_value'] as $k => $v) {
                $altValues[$k]=addslashes($v);
            }
            $data = pdoUpdate($_POST['tbl'].'_tbl', $altValues, array($_POST['index'] => $_POST['id']),' limit 1');
            if($data){
                echo ajaxBack(array('id'=>$data));
            }else{
                echo ajaxBack(null,1,'记录无法修改');
            }
            exit;
        }
        if (isset($_POST['deleteTblVal'])) {//快速删除
            try{
                pdoDelete($_POST['tbl'].'_tbl', $_POST['value'], ' limit 1');
                                echo ajaxBack();

            }catch(PDOException $e){
                echo ajaxBack(null,1,'记录无法修改');
            }
            exit;
        }
        if (isset($_POST['addTblVal'])) {//快速插入
            try{
                mylog('add');
                foreach ($_POST['value'] as $k=>$v) {
                    $value[$k]=addslashes($v);
                }
                $id=pdoInsert($_POST['tbl'].'_tbl', $value, $_POST['onDuplicte']);
                echo ajaxBack(array('id'=>$id));
            }catch(PDOException $e){
                echo ajaxBack(null,1,'记录无法修改');
            }
            exit;
        }
        if(isset($_POST['altConfig'])){//快速更改设置
            $path='../config/'.$_POST['name'].'.json';
            $config=getConfig($path);
            if(array_key_exists($_POST['key'],$config)){
                $config[$_POST['key']]=$_POST['value'];
                saveConfig($path,$config);
                echo ajaxBack();
            }else{
                echo ajaxBack(null,'3','不存在的设置项');
            }
            exit;
        }

    }else{
        echo ajaxBack(null,9,'无权限');
        exit;
    }
}


function syncInf($data){

    switch($data['type']){
        case 'staff':
            syncUser();
            break;
        case 'unit':
            syncDept();
            break;
    }
    echo ajaxBack('ok');
}
function getSubUnit($data){
    $id=$data['id'];
    $query=pdoQuery('unit_tbl',array('unit_id as id','unit_name as name'),array('parent_unit'=>$id),null)->fetchAll();
    echo ajaxBack($query);
}
function userGroupUnit($data){
    $category=$data['category'];
    $name=$data['name'];
    $query=pdoQuery('user_'.$name.'_tbl',array('user_'.$name.'_id as id','user_'.$name.'_name as name'),array('category'=>$category),null)->fetchAll();
    echo ajaxBack($query);
}
function reflashUnitList($data){
    $number=12;
    $orderby=$data['orderby'];
    $order=$data['order'];
    $start=$data['page']*$number;
    $filter="order by $orderby $order";
    $limit=" limit $start,$number";
    $where=null;
    if(isset($data['where'])&&$data['where']){//包含搜索限制条件

        $stepStr='';
        foreach ($data['where'] as $k=>$v) {
            if('steps'==$k){
                $stepStr='steps like "%';
                for($i=0;$i<strlen($v);$i++){
                    $stepStr.=$v[$i];
                }
                $stepStr.='%"';
            }elseif('unit_name'==$k){
                $stepStr='unit_name like "%'.$v.'%"';
            }else{
                if(!$where)$where=array($k=>$v);
                else $where[$k]=$v;
            }
        }
        if($where&&count($where)>0&&$stepStr)$filter='and '.$stepStr.$filter;
        else if($stepStr)$filter='where '.$stepStr.$filter;
    }
    $count=pdoQuery('unit_tbl',array('count(*) as count'),$where,$filter)->fetch()['count'];
    $query=pdoQuery('unit_tbl',null,$where,$filter.$limit)->fetchAll();
    $back['list']=$query;
    $back['count']=$count;
    $back['page']=ceil($count/$number);

    echo ajaxBack($back);
}
function reflashStaffList($data){
    $number=12;
    $orderby=$data['orderby'];
    $order=$data['order'];
    $start=$data['page']*$number;
    $filter="order by $orderby $order";
    $limit=" limit $start,$number";
    $where=null;
    if(isset($data['where'])&&$data['where']){//包含搜索限制条件

        $stepStr='';
        foreach ($data['where'] as $k=>$v) {
            if('steps'==$k){
                $stepStr='steps like "%';
                for($i=0;$i<strlen($v);$i++){
                    $stepStr.=$v[$i];
                }
                $stepStr.='%"';
            }elseif('full_name'==$k){
                $stepStr='full_name like "%'.$v.'%" or staff_name like "%'.$v.'%"';
            }else{
                if(!$where)$where=array($k=>$v);
                else $where[$k]=$v;
            }
        }
        if($where&&count($where)>0&&$stepStr)$filter='and '.$stepStr.$filter;
        else if($stepStr)$filter='where '.$stepStr.$filter;
    }
    $count=pdoQuery('staff_admin_view',array('count(*) as count'),$where,$filter)->fetch()['count'];
    $query=pdoQuery('staff_admin_view',null,$where,$filter.$limit)->fetchAll();
    $back['list']=$query;
    $back['count']=$count;
    $back['page']=ceil($count/$number);

    echo ajaxBack($back);
}
function ajaxGetMeetingList($data){
    $category=$data['category'];
    $meetingList=pdoQuery('meeting_tbl',null,['category'=>$category],' order by meeting_id desc')->fetchAll();
    echo ajaxBack($meetingList);

}
function ajaxGetMotion($data){
    $motionId=pdoQuery('motion_view',['motion_id'],['meeting'=>$data['meeting'],'category'=>$data['category'],'attr_name'=>'案号','content_int'=>$data['motion_number']],'limit 1')->fetch();
    $displeasure=false;
    if($motionId){
        $motionId=$motionId['motion_id'];
        $motionInf=pdoQuery("motion_view",null,['motion_id'=>$motionId],null)->fetchAll();
        $displeasure=pdoQuery('displeasure_attr_tbl',['motion'],['motion'=>$motionId],'limit 1')->fetch();
        echo ajaxBack(['inf'=>$motionInf,'displeasure'=>$displeasure]);

    }else{
        echo ajaxBack(null,100,'没有对应内容');
    }
}
function modifyMotionStep($data){

    $motionId=$data['motionId'];
    $step=$data['step'];
    $clearDisPleasure=$data['clearDispleasure'];
    $hasDisPleasure=pdoQuery('displeasure_attr_tbl',null,['motion'=>$motionId,'content'=>['大会期间','闭会期间']],'limit 1')->fetch();
    pdoTransReady();
    try{
        pdoUpdate('motion_tbl',['step'=>$step],['motion_id'=>$motionId],' limit 1');
        if($clearDisPleasure&&$hasDisPleasure){
            pdoDelete('displeasure_attr_tbl',['motion'=>$motionId]);
            pdoUpdate('attr_tbl',['content'=>$hasDisPleasure['content']],['attr_id'=>$hasDisPleasure['attr_id']]);
        }
        pdoCommit();
        echo ajaxBack('ok');
    }catch(PDOException $e){
        mylog($e->getMessage());
        pdoRollBack();
        echo ajaxBack(null,102,'数据库错误');
    }
}

function createMeeting($data){
    $category=$data['category'];
    $name=$data['meetingName'];
    $jie=$data['jie'];
    $ci=$data['ci'];
    $startTime=timeMysqlToUnix($data['startTime']);
    $endTime=timeMysqlToUnix($data['endTime']);
    $deadlineTime=timeMysqlToUnix($data['deadlineTime']);
    if($startTime&&$endTime&&$deadlineTime){
        $oldMeeting=pdoQuery('meeting_tbl',['meeting_id'],['category'=>$category,'jie'=>$jie,'ci'=>$ci-1],'limit 1')->fetch();
        $oldMeeting=$oldMeeting?$oldMeeting['meeting_id']:0;
        pdoTransReady();
        try{
            $newMeetingId=pdoInsert('meeting_tbl',['meeting_name'=>$name,'start_time'=>$startTime,'end_time'=>$endTime,'deadline_time'=>$deadlineTime,'category'=>$category,'motion_template'=>$category,'jie'=>$jie,'ci'=>$ci]);
            $dutyQuery=pdoQuery('duty_tbl',['user','category','user_unit','user_group','admin_type','activity'],['meeting'=>$oldMeeting],null);
            $dutyQuery->setFetchMode(PDO::FETCH_ASSOC);
            $newDutyList=array();
            foreach ($dutyQuery as $key=>$row) {
                $newDutyList[$key]=$row;
                $newDutyList[$key]['meeting']=$newMeetingId;
            }
            pdoBatchInsert('duty_tbl',$newDutyList);
            if(1==$category){

            }else{
                exeNew('TRUNCATE zx_motion_tbl');
            }
            pdoCommit();
            echo ajaxBack('ok');
        }catch(PDOException $e){
            mylog($e->getMessage());
            pdoRollBack();

        }

    }else{
        echo ajaxBack(null,102,'数据不全');
    }
}

/*
 * select user_name,user_phone,address FROM duty_view where duty_id in (select content_int from motion_view where attr_name in ("提案人","领衔人","提案联系人") and motion_id in (select motion_id from motion_view where target="unit" and content_int=55))
 */
