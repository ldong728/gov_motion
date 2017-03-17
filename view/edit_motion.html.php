<script src="js/ajaxfileupload.js?v=<?php echo rand(1000,9999)?>"></script>
<div class="mask"></div>
<div class="suggest cont">
    <div class="sug-head clearfix">
        <div class="sug-head-l"><h1><?php echo 1==current($motion)['category']?'人大建议议案办理单':'政协提案办理单'?></h1></div>
        <div class="sug-head-r"><p>当前环节：<?php echo current($motion)['step_name']?></p></div>
    </div>
    <div class="sug-main">
        <div class="sug-main-nav clearfix">
            <a href="#">保存</a>
            <a href="#">上一步</a>
            <a href="#">下一步</a>
            <a href="#">查看信息</a>
            <a href="#">办理单打印</a>
            <a href="#">建议议案打印</a>
            <a href="#">全文原始稿</a>
            <a href="#">附件修改</a>
            <a href="#">返回</a>
        </div>
        <div class="sug-main-content edit-area">
            <div class="content-title">
                <p style="height: 40px;" ><?php echo 1==current($motion)['category']?'慈溪市人大建议议案办理单':'慈溪市政协提案办理单'?></p>
            </div>
            <div class="table-list ">
                <table width="760" height="296" border="1" bordercolor="#f08300" cellpadding="0" cellspacing="0" style="">
                    <tbody style="font-size: 14px">
                    <tr>
                        <th><p> 会议名称</p></th>
                        <td><p>慈溪市第二十七届</p>
                            <p>人大第一次会议</p></td>
                        <th>登记时间</th>
                        <td colspan="2">2017-3-16</td>
                        <th>状态</th>
                        <td colspan="2">大会期间</td>
                    </tr>
                    <tr>
                        <th>案别</th>
                        <td>&nbsp;</td>
                        <th>案号</th>
                        <td colspan="2">1</td>
                        <th>是否公开</th>
                        <td colspan="2">公开</td>
                    </tr>
                    <tr>
                        <th>性质类别</th>
                        <td>政治法律</td>
                        <th>性质</th>
                        <td>当年</td>
                        <th>代表团</th>
                        <td colspan="3">第二代表团</td>
                    </tr>
                    <tr>
                        <th>领衔人</th>
                        <td colspan="7">xxx</td>
                    </tr>
                    <tr>
                        <th>复议人</th>
                        <td colspan="5">&nbsp;</td>
                        <th>复议人数</th>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <th>案由</th>
                        <td colspan="7"> 关于进一步提高</td>
                    </tr>
                    <tr>
                        <th>全文</th>
                        <td colspan="7">宗汉001xxx关于进一步提高</td>
                    </tr>
                    <tr>
                        <th>摘要</th>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    <tr>
                        <th>审核意见</th>
                        <td colspan="7">立案</td>
                    </tr>
                    <tr>
                        <th>主办单位</th>
                        <td colspan="7">&nbsp;</td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<table class="table-list">

</table>
<div class="confirm">
    <button class="next-step">下一步</button>
</div>
<script>
    var antiDouble=false;
    var timeSet=setTime();
    decodeDate( $('.encoded-data'));
    $(document).on('change','.duty-group',function(){
        var currentObj=$(this);
        var col=currentObj.get(0).value;
//        alert(col);
        var groupName=currentObj.find('option:selected').text()
        if(col!=0){
            ajaxPost('getUserGroup',{group_type:col},function(data){
                currentObj.nextAll().remove();
                var content='<select class="duty-sub" data-col="user_'+col+'"><option value="0">'+groupName+'</option>';
                var value=backHandle(data);
                $.each(value,function(k,v){
                    content+='<option value="'+ v.id+'">'+ v.name+'</option>'
                });
                content+='</select>';
                currentObj.after(content);
            })
        }
    });
    $(document).on('change','.duty-sub',function(){
        var currentObj=$(this);
        var col=currentObj.data('col');
        var value=currentObj.get(0).value;
        if(0!=value){
            currentObj.nextAll().remove();
            ajaxPost('getUser',{col:col,id:value},function(data){
                var value=backHandle(data);
                var content='<select class="duty-select attr-value">';
                $.each(value,function(k,v){
                    content+='<option value="'+ v.id+'">'+ v.name+'</option>';
                });
                currentObj.after(content);
            });
        }
    });
    $(document).on('change','.duty-select',function(){

    });
    $(document).on('change','.unit-super',function(){
        var _=$(this)
        var id= _.val();
        if(id>0){
            _.nextAll().remove();
            ajaxPost('getUnit',{id:id},function(data){
                var value=backHandle(data);
                var content='<select class="unit-select attr-value">';
                $.each(value,function(k,v){
                    content+='<option value="'+ v.id+'">'+ v.name+'</option>';
                });
                _.after(content);
            })
        }
    });
    $(document).on('click','.choose-file',function(){
        if(!antiDouble){
            antiDouble=true;
            $(this).next('.doc-file').click();
            setTimeout(function(){
                antiDouble=false;
            },1000);
        }

    });
    $(document).on('change','.doc-file',function(){
        var _=$(this);
        var parent=_.parent();
        var motionAttr=parent.data('motionattr');
        var attrTemplate=parent.data('attrtemplate');
        var attrId=parent.data('attr');
        var attrType=parent.data('type');
        var url='upload.php?attachment=1&ma='+motionAttr+'&at='+attrTemplate+'&a='+attrId+'&t='+attrType;
        var fileElementId=_.attr('id');
        var uploadData={
            url:url,
            secureuri: false,
            fileElementId:fileElementId, //文件上传域的ID
            dataType: 'json', //返回值类型 一般设置为json
            success: function (v, status) {
                if ('SUCCESS' == v.state) {
                    if(0==attrId){
                        attrId= v.attrId;
                        parent.attr('data-attr', attrId)
                        $('.attachment-file').attr('href',v.url);
                        antiDouble=false;
                    }else{
                        alert('not 0');
                    }
                    console.log(v);

                } else {

                    showToast(v.state);
                }
            },//服务器成功响应处理函数
            error: function (d) {
                alert('error');
            }
        };
        console.log(uploadData);
        $.ajaxFileUpload(uploadData);
    });
    $(document).on('click','.next-step',function(){
       submitAtrrs();
    });
    function decodeDate(element) {
        element.each(function (key, subElement) {
            var _ = $(subElement);
            var parent = _.parent();
            var data = eval('(' + _.text() + ')');//将数据转化为JS对象
            var attr= data.attr_id||0;
            var content='';
            parent.empty();
            if (data.edit) {//选项可编辑
                parent.addClass('update-value');
                parent.attr('data-attr',attr);
                parent.attr('data-type',data.value_type);
                parent.attr('data-motionattr',data.motion_attr);
                parent.attr('data-attrtemplate',data.attr_template);
                parent.attr('data-multiple',data.multiple);
                if (data.option) {
                    if (1 == data.multiple && data.multiple_value.length > 1) {
                        $.each(data.multiple_value, function(id, value){
                            content += '<span class="pre-delete attr-value" id="'+value.attr_id+'">' + value.content + '</span>'
                        });
                    }
                    var isValue= data.target?'':'attr-value';
                    content+='<select class="'+ data.class+' '+ isValue+'">';
                    $.each(data.option,function(k,v){
                       content+='<option value="'+ k+'">'+v+'</option>';
                    });
                    content+='</select>'
                } else if(data.has_attachment>0){
                    content+='<button class="button choose-file">选择附件</button>'+
                    '<input type="file" class="doc-file" id="file'+data.motion_attr+'" name="file'+data.motion_attr+'" style="display: none">';
                    if(data.attachment)content+='<a class="attachment-file" href="'+data.attachment+'">附件</a>'
                }else if('time'==data.value_type){
                    content+='<input type="hidden" class="attr-value" value="1"><span class="time-display"></span>';
                }else{
                    content+='<textarea class="attr-value">'+(data.content||'')+'</textarea>'
                }
            } else {//选项不可编辑
                if(data.attachment){
                    content+='<a href="'+data.attachment+'">附件</a>'
                }else{
                    content+=data.content;
                }
            }
            parent.append(content);

            console.log(data);
        });
    }
    function submitAtrrs(step) {
        var sStep=step||1
        var data={step:sStep,data:[]};
        $('.update-value').each(function (k, v) {
            var f = $(v);
            var s = f.find('.attr-value');
            var attrId = s.attr('id')||f.data('attr');
            var attrType = f.data('type');
            var motionAttr= f.data('motionattr');
            var attrTemplate= f.data('attrtemplate');
            var multiple= 1==f.data('multiple');
            var value= s.val();
            data.data.push({
                attr_id:attrId,
                attr_type:attrType,
                motion_attr:motionAttr,
                attr_template:attrTemplate,
                value:value
            });
        });
        ajaxPost('updateAttr',data,function(){
        });
    }
    function setTime(){
        $('.time-display').text(new Date().toLocaleString());
        var time=setInterval(function(){
            var time=new Date();
            $('.time-display').text(time.toLocaleString());
        },1000);
        return time;
    }

//    function getUserGroup()

</script>