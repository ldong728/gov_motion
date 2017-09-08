<?php
global $meeting;
?>
<style>
    .displeasure {color:red}
</style>
<div class="block">
    <div class="head" style="width: 98%"><span>建议议案环节操作</span></div>
    <div class="main">
        <table class="table sheet">
            <tr>
                <td>
                    <select id="category-select">
                        <option value="-1">请选择类别</option>
                        <option value="1">人大</option>
                        <option value="2">政协</option>
                    </select>
                </td>
                <td>
                    <select id="meeting-select">
                    <option value="-1">请先选择类别</option>
                    </select>
                </td>
                <td>
                    <span>请输入案号:</span>
                    <input type="number" id="motion-number">
                    <button id="get-motion">确定</button>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="block" id="motion-block" style="display: none">
    <div class="head" style="width: 98%"><span>详细信息</span></div>
    <div class="main">
        <table class="table sheet motion-content">
            <tr>
                <td id="motion-name"></td>
                <td >
                    <select id="current-step">
                        <option value="1">提交</option>
                        <option value="2">登记</option>
                        <option value="3">审核</option>
                        <option value="4">交办</option>
                        <option value="5">办理</option>
                        <option value="6">反馈</option>
                        <option value="7">完成</option>
                    </select>
                    <span id="displeasure-input" style="display: none">
                    <label for="re-handle">清除重办数据</label>
                    <input type="checkbox" id="re-handle">
                        </span>
                </td>
                <td>
                    <button id="confirm-modify">
                        确认修改
                    </button>
                </td>

            </tr>
        </table>
    </div>
</div>

<script>
    var currentMotionId=false;
    $('#category-select').change(function(){
        var value=$(this).val();
        if(value>0){
//            alert(value);
            ajaxPost('ajaxGetMeetingList',{category:value},initMeetingSelect);
        }
    });
    $('#get-motion').click(function(){
        getMotion()
    });
    $('#confirm-modify').click(function(){
       if(confirm('确定要修改当前环节吗？（操作时请确认当前件无人修改，否则可能造成数据丢失）')){
           var clearDispleasure=$('#re-handle').prop('checked');
           var modifyStep=$('#current-step').val();
           var data={motionId:currentMotionId,step:modifyStep,clearDispleasure:clearDispleasure};
           ajaxPost('modifyMotionStep',data,function(back){
                getMotion();
           });
           console.log(data);
       }
    });
//    $('#meeting-select')
    function initMeetingSelect(data){
        var back=backHandle(data);
        $('#meeting-select').empty();
        $('#meeting-select').append('<option value="-1">请选择会议</option>')
        $.each(back,function(k,v){
            $('#meeting-select').append('<option value="'+ v.meeting_id+'">'+ v.meeting_name+'</opeion>')
        })

    }
    function getMotion(){
        currentMotionId=false;
        $('#motion-block').hide();
        var category=$('#category-select').val();
        var meeting=$('#meeting-select').val();
        var motionNumber=$('#motion-number').val();
        if(category>0&&meeting>0&&motionNumber>0){
            ajaxPost('ajaxGetMotion',{category:category,meeting:meeting,motion_number:motionNumber},displayMotion)
        }else{
            if(category<0)alert('请选择类别');
            if(meeting<0)alert('请选择会议');
            if(motionNumber<0)alert('请输入案号');
        }
    }
    function displayMotion(data){
//        var tr=$(document.createElement('tr'));
//        var td=$(document.createElement('td'));
        var backData=backHandle(data);
        console.log(backData);
        if(backData){
            var back=backData.inf;
            var displeasure=Boolean(backData.displeasure);
            var motionInf=back[0];
            currentMotionId=motionInf.motion_id;
            var motionName=motionInf.motion_name;
            var step=motionInf.step;
            $('#current-step').val(step);
            $('#motion-name').text(motionName);
            if(displeasure){
                $('#motion-name').addClass('displeasure');
                $('#displeasure-input').show();
            }else{
                $('#motion-name').removeClass('displeasure');
                $('#displeasure-input').hide();
            }
            $('#motion-block').show();

        }
    }
</script>
