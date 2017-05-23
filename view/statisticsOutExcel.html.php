<meta charset = "utf-8">
<?php
$name='';
switch($_SESSION['staffLogin']['category']){
    case 1:
        $name="人大建议议案";
        break;
    case 2:
        $name="政协提案";
        break;
}
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=".$name."办理情况统计".timeUnixToMysql(time()).".xls");

?>
<table border=1 style="text-align: center">
    <tr><td rowspan="2">单位</td><td colspan="3">办理</td><td colspan="4">办复</td></tr>
    <tr><td>主办</td><td>协办</td><td>总数</td><td>主办</td><td>协办</td><td>总数</td><td>办复率</td></tr>
    <?php foreach($totalList as $row):?>
        <?php
            $mainTotal=isset($row['main_total'])?$row['main_total']:0;
            $subTotal=isset($row['sub_total'])?$row['sub_total']:0;
            $mainDone=isset($row['main_done'])?$row['main_done']:0;
            $subDone=isset($row['sub_done'])?$row['sub_done']:0;

        ?>
    <tr>
        <td><?php echo $row['unit_name']?></td>
        <td><?php echo $mainTotal?></td>
        <td><?php echo $subTotal?></td>
        <td><?php echo $mainTotal+$subTotal?></td>
        <td><?php echo $mainDone?></td>
        <td><?php echo $subDone?></td>
        <td><?php echo $subDone+$mainDone?></td>
        <td><?php echo number_format(($subDone+$mainDone)/($subTotal+$mainTotal)*100,2,'.','').'%'?></td>

<!--        <td></td>-->
    </tr>
    <?php endforeach?>
</table>