<script src="js/ajaxfileupload.js?v=<?php echo rand(1000,9999)?>"></script>

<table class="table-list">
    <?php foreach ($motion as $row): ?>
        <tr>
            <th><?php htmlout($row['attr_name']) ?></th>

                <?php if($row['edit']):?>
                    <td class="update-value"
                        data-attr="<?php echo $row['attr_id']?$row['attr_id']:'0'?>"
                        data-type="<?php echo $row['value_type']?>"
                        data-target="<?php echo isset($row['target'])?$row['target']:''?>"
                        data-motionattr="<?php echo $row['motion_attr']?>"
                        data-attrtemplate="<?php echo $row['attr_template']?>"
                        data-mutiple="<?php echo $row['multiple']?>">

                    <?php if (is_array($row['option'])): ?>
                        <?php if(1==$row['multiple']&&count($row['multiple_value'])>1):?>
                        <?php foreach($row['multiple_value'] as $mvRow):?>
                                <span class="pre-delete attr-value" id="<?php echo $mvRow['attr_id'] ?>"><?php echo $mvRow['content']?></span>
                                <?php endforeach?>

                        <?php endif ?>
                        <select class="<?php echo $row['class']?> <?php echo $row['target']? '':'attr-value'?>">
                            <?php foreach ($row['option'] as $k=>$v): ?>
                                <option
                                    value="<?php htmlout($k) ?>"
                                    <?php echo $k == $row['content']||$k==$row['content_int'] ? 'selected="selected"' : '' ?>><?php htmlout($v) ?> </option>
                            <?php endforeach ?>
                        </select>


                    <?php elseif($row['has_attachment']): ?>
                        <button class="button choose-file">选择附件</button>
                        <input type="file" class="doc-file" id="file<?php echo $row['motion_attr']?>" name="file<?php echo $row['motion_attr']?>" style="display: none">
                        <a class="attachment-file" <?php echo $row['attachment']?'href="'.$row['attachment'].'"':''?>>附件</a>
                    <?php elseif('time'==$row['value_type']):?>
                       <input type="hidden" class="attr-value" value="1"><span class="time-display"></span>
                    <?php else: ?>
                        <textarea class="attr-value"></textarea>
                    <?php endif ?>
                    </td>
                <?php else: ?>
                    <td>
                        <?php if($row['has_attachment']):?>
                            <a href="<?php echo $row['attachment'] ?>">附件</a>
                            <?php else: ?>
                            <?php echo $row['content'] ?>
                        <?php endif?>
                    </td>
                <?php endif ?>

        </tr>
    <?php endforeach ?>
</table>
<div class="confirm">
    <button class="next-step">下一步</button>
</div>
<script>
    var antiDouble=false;
    var timeSet=setTime();
    $('.duty-group').change(function(){
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
                })
                content+='</select>';
                currentObj.after(content)
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
    })
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
    function submitAtrrs(step) {
        var sStep=step||1
        var data={step:sStep,data:[]};
        $('.update-value').each(function (k, v) {
            var f = $(v);
            var s = f.find('.attr-value');
            var attrId = s.attr('id')||f.data('attr');
            var attrType = f.data('type');
            var target = f.data('target');
            var motionAttr= f.data('motionattr');
            var attrTemplate= f.data('attrtemplate');
            var multiple= 1==f.data('multiple');
            var value= s.val();
            data.data.push({
                attr_id:attrId,
                attr_type:attrType,
                target:target,
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