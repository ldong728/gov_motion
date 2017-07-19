<meta charset = "utf-8">
<?php
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=output.xls");

?>
<table border=1 style="text-align: center">
    <tr>
        <?php foreach($field as $key=>$row):?>
        <td><?php echo $key?></td>
        <?php endforeach;?>
    </tr>
    <?php foreach($motionInfo as $row):?>
        <tr>
            <?php foreach($field as $k):?>
            <td><?php echo isset($row[$k])&&$row[$k]?$row[$k]:''?></td>
            <?php endforeach?>
        </tr>
    <?php endforeach ?>
</table>