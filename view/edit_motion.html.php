<table>
    <?php foreach ($motion as $row): ?>
        <tr>
            <td><?php htmlout($row['attr_name']) ?></td>
            <td ><?php if (is_array($row['option'])): ?>
                    <select class="<?php echo $row['class']?>">
                        <?php foreach ($row['option'] as $k=>$v): ?>
                            <option
                                value="<?php htmlout($k) ?>" <?php echo $k == $row['content'] ? 'selected="selected"' : '' ?>><?php htmlout($v) ?> </option>
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
    $('.duty-group').change(function(){
        var col=$(this).get(0).value
        alert(col)
    })

</script>