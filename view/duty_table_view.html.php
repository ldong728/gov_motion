<table id="" width="100%" border="0" cellpadding="0" cellspacing="0" class="">
    <tr>
        <td>姓名</td>
        <td>电话</td>
        <td>详情</td>
        <td><?php echo 1==$category?'中心组':'委组'?></td>
        <td><?php echo 1==$category?'代表团':'界别'?></td>
        <td>操作</td>
    </tr>
    <?php foreach($dutyList as $row):?>
    <tr id="row<?php echo $row['duty_id']?>">
        <td class="user-name"><?php echo $row['user_name']?></td>
        <td  class="can-modify" data-type="value" data-field="user_phone"><?php echo $row['user_phone']?></td>
        <td  class="can-modify" data-type="value" data-field="address"><?php echo $row['address']?></td>
        <td class="can-modify" data-type="unit" data-field="user_unit"><?php echo $row['user_unit_name']?></td>
        <td class="can-modify" data-type="group" data-field="user_group"><?php echo $row['user_group_name']?></td>
        <td><button class="modify-btn" id="mod<?php echo $row['duty_id']?>">修改</button><button class="activity-btn" id="act<?php echo $row['duty_id']?>" data-activity="<?php echo $row['activity']?>"><?php echo 1==$row['activity']?'删除':'启用'?></button></td>


    </tr>
    <?php endforeach ?>

</table>
<script>
    userUnit='<?php echo json_encode($unitList)?>';
    userUnit=eval('('+userUnit+')');
    userGroup='<?php echo json_encode($groupList)?>';
    userGroup=eval('('+userGroup+')');
</script>