<meta charset = "utf-8">
<?php
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=".$name."办理情况统计".timeUnixToMysql(time()).".xls");


?>
<table border=1 style="text-align: center">
    <tr><td rowspan="2">单位</td><td colspan="3">办理</td><td colspan="4">办复</td><td colspan="4">办理工作</td><td colspan="4">办理结果</td></tr>
    <tr><td>主办</td><td>协办</td><td>总数</td><td>主办</td><td>协办</td><td>总数</td><td>办复率</td><td>满意</td><td>基本满意</td><td>不满意</td><td>未表态</td><td>满意</td><td>基本满意</td><td>不满意</td><td>未表态</td></tr>
    <?php foreach($totalList as $row):?>
        <?php
            $mainTotal=isset($row['main_total'])?$row['main_total']:0;
            $subTotal=isset($row['sub_total'])?$row['sub_total']:0;
            $mainDone=isset($row['main_done'])?$row['main_done']:0;
            $subDone=isset($row['sub_done'])?$row['sub_done']:0;
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
        <td><?php echo $work['满意']?></td>
        <td><?php echo $work['基本满意']?></td>
        <td><?php echo $work['不满意']?></td>
        <td><?php echo $work['未表态']?></td>
        <td><?php echo $result['满意']?></td>
        <td><?php echo $result['基本满意']?></td>
        <td><?php echo $result['不满意']?></td>
        <td><?php echo $result['未表态']?></td>
        

<!--        <td></td>-->
    </tr>
    <?php endforeach?>
</table>