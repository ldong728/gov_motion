<table>
    <?php foreach ($motion as $row): ?>
        <tr>
            <td><?php htmlout($row['attr_name']) ?></td>

                <?php if($row['edit']):?>
                    <td class="updata-value" data-attr="<?php echo $row['attr_id']?$row['attr_id']:'0'?>" data-type="<?php echo $row['value_type']?>">
                    <?php if (is_array($row['option'])): ?>
                        <select class="<?php echo $row['class']?>">
                            <?php foreach ($row['option'] as $k=>$v): ?>
                                <option
                                    value="<?php htmlout($k) ?>" <?php echo $k == $row['content']||$k==$row['content_int'] ? 'selected="selected"' : '' ?>><?php htmlout($v) ?> </option>
                            <?php endforeach ?>
                        </select>
                    <?php elseif($row['has_attachment']): ?>

                    <?php else: ?>
                        <textarea class="attr-value"></textarea>
                    <?php endif ?>
                    </td>
                <?php else: ?>
                    <?php echo $row['content'] ?>
                <?php endif ?>

        </tr>
    <?php endforeach ?>
</table>
<div class="confirm">
    <button>下一步</button>
</div>
<script>
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
                var content='<select class="user-select attr-value">'
                $.each(value,function(k,v){
                    content+='<option value="'+ v.id+'">'+ v.name+'</option>'
                });
                currentObj.after(content);
            });

        }

    })

//    function getUserGroup()

</script>