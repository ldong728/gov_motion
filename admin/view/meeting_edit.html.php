<?php
global $meetingList
?>
<script type="text/javascript" src="js/laydate.js"></script>
<div class="block">
    <div class="head">已存在会议管理</div>
    <div class="main">
        <table class="table sheet">
            <tr>
                <td>类别</td>
                <td>会议名称</td>
                <td>开始时间</td>
                <td>结束时间</td>
                <td>截止日期</td>
            </tr>
            <?php foreach ($meetingList as $row): ?>
                <tr>
                    <td><?php echo 1 == $row['category'] ? '人大' : '政协' ?></td>
                    <td><?php echo $row['meeting_name'] ?></td>
                    <td><?php echo timeUnixToMysql($row['start_time']) ?></td>
                    <td><?php echo timeUnixToMysql($row['end_time']) ?></td>
                    <td><?php echo timeUnixToMysql($row['deadline_time']) ?></td>
                </tr>
            <?php endforeach ?>
        </table>
    </div>
</div>
<div class="block">
    <div class="head">新建会议</div>
    <div class="main">
        <table class="table sheet">
            <tr>
                <td>类别</td>
                <td>
                    <select id="category-select">
                        <option value="-1">请选择类别</option>
                        <option value="1">人大</option>
                        <option value="2">政协</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>会议名称</td>
                <td>
                    <span id="meeting-name"></span>
                </td>
            </tr>
            <tr>
                <td>届</td>
                <td>
                    <select id="jie">
                        <option value="-1">请选择</option>
                        <option value="11">十一</option>
                        <option value="12">十二</option>
                        <option value="17">十七</option>
                        <option value="18">十八</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>次</td>
                <td>
                    <select id="ci">
                        <option value="-1">请选择</option>
                        <option value="1">一</option>
                        <option value="2">二</option>
                        <option value="3">三</option>
                        <option value="4">四</option>
                        <option value="5">五</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td>开始时间</td>
                <td><input type="text" id="start-time"></td>
            </tr>
            <tr>
                <td>结束时间</td>
                <td><input type="text" id="end-time"></td>
            </tr>
            <tr>
                <td>截止时间</td>
                <td><input type="text" id="deadline-time"></td>
            </tr>
            <tr>
                <td></td>
                <td><button class="button" id="create-button">新建会议</button></td>
            </tr>

        </table>
    </div>
</div>
<script>
    laydate({elem:'#start-time'});
    laydate({elem:'#end-time'});
    laydate({elem:'#deadline-time'});

    $('#create-button').click(function(){
        var category=$('#category-select').val();
        var jie=$('#jie').val();
        var ci=$('#ci').val();
        if(category>0&&jie>0&&ci>0){
            var jieName=$('#jie :selected').text();
            var ciName=$('#ci :selected').text();
            var meetingName= 1==category? '慈溪市'+jieName+'届人大第'+ciName+'次会议':'慈溪市'+jieName+'届政协第'+ciName+'次会议';
            var data={category:category,meetingName:meetingName,jie:jie,ci:ci};
            data.startTime=$('#start-time').val();
            data.endTime=$('#end-time').val();
            data.deadlineTime=$('#deadline-time').val();
            console.log(data);
            ajaxPost('createMeeting',data,function(back){
                var backValue=backHandle(back);
                if(backValue){

                }else{
                    alert('创建不成功');
                }
            });
        }else{
            alert('填写不完整')
        }
    });
//    //执行一个laydate实例
//    laydate.render({
//        elem: '#test1' //指定元素
//    });
</script>