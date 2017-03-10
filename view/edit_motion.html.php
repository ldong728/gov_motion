<table>
    <?php foreach ($motion as $row): ?>
        <tr>
            <td><?php htmlout($row['attr_name']) ?></td>
            <td><?php if (is_array($row['option'])): ?>
                    <select class="select">
                        <?php foreach ($row['option'] as $oRow): ?>
                            <option
                                value="<?php htmlout($sRow) ?>" <?php echo $oRow == $row['content'] ? 'selected="selected"' : '' ?>><?php htmlout($oRow) ?> </option>
                        <?php endforeach ?>
                    </select>

                <?php else: ?>
                    <?php echo $row['content'] ?>
                <?php endif ?>
            </td>
        </tr>
    <?php endforeach ?>
</table>
<div class="confirm">
    <button>下一步</button>
</div>
<script>
    $('.input-handle').each(function (k, v) {
        var type = $(v).data('type');
        var target=$(v).data('target')=='#target'?false:$(v).data('target');
        var content=$(v).data('content')=='#content'?'':$(v).data('content');
        var parent = $(v).parent();
        var htmlContent=''

        if(!target){
            log(content)
            htmlContent='<textarea>'+content+'</textarea>'
        }else{
            htmlContent='target:'+target;
        }
        parent.html(htmlContent);

    });
    function unitSelecter(jqueryObj,)

</script>