<meta charset = "utf-8">

<?php
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=".encodeFileName($fileName.".xls"));

?>
<table border=1 style="text-align: center">
    <?php echo $title?>
    <?php foreach($listQuery as $row):?>
    <tr>
        <?php for($i=0;$i<$fieldCount;$i++):?>
            <td><?php echo isset($row[$i])&&$row[$i]?$row[$i]:''?></td>
        <?php endfor ?>
    </tr>
    <?php endforeach ?>
</table>