<meta charset = "utf-8">
<?php
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=".encodeFileName($name).".xls");

?>
<table border=1 style="text-align: center">
    <tr>
        <td>主办单位</td>
        <td>A类</td>
        <td>B类</td>
        <td>C类</td>
        <td>D类</td>
    </tr>
    <?php foreach($unitList as $row):?>
        <?php
            $a=isset($row['list']['A'])?$row['list']['A']:0;
            $totalA+=$a;
            $b=isset($row['list']['B'])?$row['list']['B']:0;
            $totalB+=$b;
            $c=isset($row['list']['C'])?$row['list']['C']:0;
            $totalC+=$c;
            $d=isset($row['list']['D'])?$row['list']['D']:0;
            $totalD+=$d;
        ?>
        <tr>
            <td><?=$row['name']?></td>
            <td><?=$a?></td>
            <td><?=$b?></td>
            <td><?=$c?></td>
            <td><?=$d?></td>
        </tr>
    <?php endforeach ?>
    <tr>
        <td>总计</td>
        <td><?=$totalA?></td>
        <td><?=$totalB?></td>
        <td><?=$totalC?></td>
        <td><?=$totalD?></td>
    </tr>
</table>