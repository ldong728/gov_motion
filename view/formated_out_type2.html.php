<meta charset = "utf-8">
<?php
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=".$unitName.'办理件汇总'.".xls");

?>
<table border=1 style="text-align: center">
    <tr><td colspan="6"><?php echo $unitName.'主办件'?></td></tr>
    <tr><td>案号</td><td>领衔人/提案人</td><td>案由</td><td>当前环节</td><td>主办单位</td><td>协办单位</td></tr>
    <?php foreach($sortList as $row):?>
    <?php $type=1==$row['category']?'领衔人':'提案人'?>
        <tr>
            <td><?php echo isset($row['案号'])?$row['案号']:''?></td>
            <td><?php echo isset($row[$type])?$row[$type]:''?></td>
            <td><?php echo isset($row['案由'])?$row['案由']:''?></td>
            <td><?php echo isset($row['当前环节'])?$row['当前环节']:''?></td>
            <td><?php echo isset($row['主办单位'])?$row['主办单位']:''?></td>
            <td><?php echo isset($row['协办单位'])?$row['协办单位']:''?></td>
        </tr>
    <?php endforeach ?>
    <tr><td colspan="6"></td></tr>
    <tr><td colspan="6"><?php echo $unitName.'协办件'?></td></tr>
    <tr><td>案号</td><td>领衔人/提案人</td><td>案由</td><td>当前环节</td><td>主办单位</td><td>协办单位</td></tr>
    <?php foreach($sortList2 as $row):?>
        <?php $type=1==$row['category']?'领衔人':'提案人'?>
        <tr>
            <td><?php echo isset($row['案号'])?$row['案号']:''?></td>
            <td><?php echo isset($row[$type])?$row[$type]:''?></td>
            <td><?php echo isset($row['案由'])?$row['案由']:''?></td>
            <td><?php echo isset($row['当前环节'])?$row['当前环节']:''?></td>
            <td><?php echo isset($row['主办单位'])?$row['主办单位']:''?></td>
            <td><?php echo isset($row['协办单位'])?$row['协办单位']:''?></td>
        </tr>
    <?php endforeach ?>
</table>