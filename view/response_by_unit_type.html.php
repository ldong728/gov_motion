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
header("Content-Disposition:filename=".encodeFileName($name."反馈情况统计".timeUnixToMysql(time()).".xls"));

?>
<table border=1 style="text-align: center">
    <tr><td rowspan="2">中心组</td><td rowspan="2">总件数</td><td rowspan="2">类别标记</td><td rowspan="2">件数</td><td rowspan="2">反馈数</td><td colspan="4">办理工作</td><td colspan="4">办理结果</td></tr>
    <tr><td>满意</td><td>基本满意</td><td>不满意</td><td>未表态</td><td>满意</td><td>基本满意</td><td>不满意</td><td>未表态</td></tr>
    <?php foreach($totalList as $mainRow):?>
        <?php
        $mainTotal=isset($mainRow['main_total'])?$mainRow['main_total']:0;
        $subTotal=isset($mainRow['sub_total'])?$mainRow['sub_total']:0;
        $mainDone=isset($mainRow['main_done'])?$mainRow['main_done']:0;
        $subDone=isset($mainRow['sub_done'])?$mainRow['sub_done']:0;
        $count=0;
        ?>
        <tr>
            <td rowspan="<?php echo $mainRow['typeCount']+1?>"><?php echo $mainRow['user_unit_name']?></td>
            <td rowspan="<?php echo $mainRow['typeCount']+1?>"><?php echo $mainDone?></td>
        </tr>
        <?php foreach($mainRow['type'] as $k=>$row):?>

            <?php
            $work=isset($row['办理工作'])?$row['办理工作']:array();
            $result=isset($row['办理结果'])?$row['办理结果']:array();
            $work['满意']=isset($work['满意'])?$work['满意']:0;
            $work['基本满意']=isset($work['基本满意'])?$work['基本满意']:0;
            $work['不满意']=isset($work['不满意'])?$work['不满意']:0;
            $work['未表态']=isset($work['未表态'])?$work['未表态']:0;
            $result['满意']=isset($result['满意'])?$result['满意']:0;
            $result['基本满意']=isset($result['基本满意'])?$result['基本满意']:0;
            $result['不满意']=isset($result['不满意'])?$result['不满意']:0;
            $result['未表态']=isset($result['未表态'])?$result['未表态']:0;
//            mylog(++$count);
            ?>

            <tr>
                <td><?php echo $k ?></td>
                <td><?php echo $row['main_done'] ?></td>
                <td><?php echo($work['满意'] + $work['基本满意'] + $work['不满意'] + $work['未表态']) ?></td>
                <td><?php echo $work['满意'] ?></td>
                <td><?php echo $work['基本满意'] ?></td>
                <td><?php echo $work['不满意'] ?></td>
                <td><?php echo $work['未表态'] ?></td>
                <td><?php echo $result['满意'] ?></td>
                <td><?php echo $result['基本满意'] ?></td>
                <td><?php echo $result['不满意'] ?></td>
                <td><?php echo $result['未表态'] ?></td>
            </tr>
        <?php endforeach ?>
    <?php endforeach?>
</table>