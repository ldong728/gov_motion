<meta charset = "utf-8">
<style>
    td{
        align-content: center;
    }
</style>
<?php
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=".encodeFileName("办理情况评估(中心组数据)".timeUnixToMysql(time()).".xls"));
?>
<table border=1 style="text-align: center">
    <tr><td colspan="37">慈溪市十七届人大二次会议代表建议办理情况评估表(承办单位数据)</td></tr>
    <tr>
        <td rowspan="3">中心组</td>
        <td rowspan="3">提出<br>数量</td>
        <td rowspan="3">人均<br>占比</td>
        <td colspan="8">类别号标记</td>
<!--        <td colspan="4">面商人</td>-->
<!--        <td colspan="4">协商形式</td>-->
        <td colspan="4">问题解决情况</td>
        <td colspan="4">意见采纳情况</td>

        <td colspan="3">办理工作满意度</td>
        <td colspan="3">办理结果满意度</td>
<!--        <td colspan="3">附议代表答复</td>-->
    </tr>
    <tr>
        <td colspan="2">A</td><td colspan="2">B</td><td colspan="2">C</td><td colspan="2">D</td>
<!--        <td rowspan="2">单位<br>一把<br>手</td><td rowspan="2">局级<br>领导</td><td rowspan="2">科室<br>负责<br>人</td><td rowspan="2">一般<br>干部</td>-->
<!--        <td rowspan="2">座谈<br>会</td><td rowspan="2">登门<br>走访</td><td rowspan="2">电话<br>联系</td><td rowspan="2">未协<br>商</td>-->
        <td rowspan="2">已解<br>决或<br>基本<br>解决</td><td rowspan="2">部分<br>解决<br>或计<br>划解<br>决</td><td rowspan="2">近期<br>不能<br>解决</td><td rowspan="2">留作<br>工作<br>参考</td>
        <td rowspan="2">采纳<br>或基<br>本采<br>纳</td><td rowspan="2">部分<br>采纳</td><td rowspan="2">解释<br>说明</td><td rowspan="2">未采<br>纳</td>

        <td rowspan="2">满意</td><td rowspan="2">基本<br>满意<br></td><td rowspan="2">不满<br>意</td>
        <td rowspan="2">满意</td><td rowspan="2">基本<br>满意<br></td><td rowspan="2">不满<br>意</td>
<!--        <td rowspan="2">主送<br></td><td rowspan="2">抄送<br></td><td rowspan="2">未答<br>复</td>-->
    </tr>
    <tr>
        <td>数量</td>
        <td>占比</td>
        <td>数量</td>
        <td>占比</td>
        <td>数量</td>
        <td>占比</td>
        <td>数量</td>
        <td>占比</td>
    </tr>
    <?php foreach($statisticsList as $row):?>
        <?php
        $A=isset($row['类别标记']['A'])?$row['类别标记']['A']:0;
        $B=isset($row['类别标记']['B'])?$row['类别标记']['B']:0;
        $C=isset($row['类别标记']['C'])?$row['类别标记']['C']:0;
        $D=isset($row['类别标记']['D'])?$row['类别标记']['D']:0;
        ?>
        <tr>
            <td><?=$row['中心组']?></td>
            <td><?=$row['count']?></td>
            <td><?=number_format($row['count']/$dutyCount[$row['中心组']],2,'.','') ?></td>
            <td><?=$A?></td>
            <td><?=number_format($A/$row['count']*100,2,'.','').'%'?></td>
            <td><?=$B?></td>
            <td><?=number_format($B/$row['count']*100,2,'.','').'%'?></td>
            <td><?=$C?></td>
            <td><?=number_format($C/$row['count']*100,2,'.','').'%'?></td>
            <td><?=$D?></td>
            <td><?=number_format($D/$row['count']*100,2,'.','').'%'?></td>

<!--            <td>--><?//=isset($row['面商人1']['单位一把手'])?$row['面商人1']['单位一把手']:0?><!--</td>-->
<!--            <td>--><?//=isset($row['面商人1']['局级领导'])?$row['面商人1']['局级领导']:0?><!--</td>-->
<!--            <td>--><?//=isset($row['面商人1']['科室负责人'])?$row['面商人1']['科室负责人']:0?><!--</td>-->
<!--            <td>--><?//=isset($row['面商人1']['一般干部'])?$row['面商人1']['一般干部']:0?><!--</td>-->
<!--            <td>--><?//=isset($row['协商形式1']['座谈会'])?$row['协商形式1']['座谈会']:0?><!--</td>-->
<!--            <td>--><?//=isset($row['协商形式1']['登门走访'])?$row['协商形式1']['登门走访']:0?><!--</td>-->
<!--            <td>--><?//=isset($row['协商形式1']['电话联系'])?$row['协商形式1']['电话联系']:0?><!--</td>-->
<!--            <td>--><?//=isset($row['协商形式1']['未协商'])?$row['协商形式1']['未协商']:0?><!--</td>-->
            <td><?=isset($row['问题解决情况1']['解决或基本解决'])?$row['问题解决情况1']['解决或基本解决']:0?></td>
            <td><?=isset($row['问题解决情况1']['部分解决或列入计划'])?$row['问题解决情况1']['部分解决或列入计划']:0?></td>
            <td><?=isset($row['问题解决情况1']['近期尚不能解决'])?$row['问题解决情况1']['近期尚不能解决']:0?></td>
            <td><?=isset($row['问题解决情况1']['留作参考'])?$row['问题解决情况1']['留作参考']:0?></td>
            <td><?=isset($row['意见采纳情况1']['采纳'])?$row['意见采纳情况1']['采纳']:0?></td>
            <td><?=isset($row['意见采纳情况1']['部分采纳'])?$row['意见采纳情况1']['部分采纳']:0?></td>
            <td><?=isset($row['意见采纳情况1']['解释说明'])?$row['意见采纳情况1']['解释说明']:0?></td>
            <td><?=isset($row['意见采纳情况1']['未采纳'])?$row['意见采纳情况1']['未采纳']:0?></td>
            <td><?=isset($row['办理工作']['满意'])?$row['办理工作']['满意']:0?></td>
            <td><?=isset($row['办理工作']['基本满意'])?$row['办理工作']['基本满意']:0?></td>
            <td><?=isset($row['办理工作']['不满意'])?$row['办理工作']['不满意']:0?></td>
            <td><?=isset($row['办理结果']['满意'])?$row['办理结果']['满意']:0?></td>
            <td><?=isset($row['办理结果']['基本满意'])?$row['办理结果']['基本满意']:0?></td>
            <td><?=isset($row['办理结果']['不满意'])?$row['办理结果']['不满意']:0?></td>
<!--            <td></td>-->
<!--            <td></td>-->
<!--            <td></td>-->
        </tr>
    <?php endforeach?>
    <tr><td>合计（件）</td>
        <?php
        $A=isset($total['类别标记']['A'])?$total['类别标记']['A']:0;
        $B=isset($total['类别标记']['B'])?$total['类别标记']['B']:0;
        $C=isset($total['类别标记']['C'])?$total['类别标记']['C']:0;
        $D=isset($total['类别标记']['D'])?$total['类别标记']['D']:0;
        ?>
        <td><?=$total['count']?></td>
        <td><?= number_format($total['count']/$totalDutyCount,2,'.','') ?></td>
        <td><?=$A?></td>
        <td><?=number_format($A/$total['count']*100,2,'.','').'%'?></td>
        <td><?=$B?></td>
        <td><?=number_format($B/$total['count']*100,2,'.','').'%'?></td>
        <td><?=$C?></td>
        <td><?=number_format($C/$total['count']*100,2,'.','').'%'?></td>
        <td><?=$D?></td>
        <td><?=number_format($D/$total['count']*100,2,'.','').'%'?></td>

<!--        <td>--><?//=isset($total['面商人1']['单位一把手'])?$total['面商人1']['单位一把手']:0?><!--</td>-->
<!--        <td>--><?//=isset($total['面商人1']['局级领导'])?$total['面商人1']['局级领导']:0?><!--</td>-->
<!--        <td>--><?//=isset($total['面商人1']['科室负责人'])?$total['面商人1']['科室负责人']:0?><!--</td>-->
<!--        <td>--><?//=isset($total['面商人1']['一般干部'])?$total['面商人1']['一般干部']:0?><!--</td>-->
<!--        <td>--><?//=isset($total['协商形式1']['座谈会'])?$total['协商形式1']['座谈会']:0?><!--</td>-->
<!--        <td>--><?//=isset($total['协商形式1']['登门走访'])?$total['协商形式1']['登门走访']:0?><!--</td>-->
<!--        <td>--><?//=isset($total['协商形式1']['电话联系'])?$total['协商形式1']['电话联系']:0?><!--</td>-->
<!--        <td>--><?//=isset($total['协商形式1']['未协商'])?$total['协商形式1']['未协商']:0?><!--</td>-->
        <td><?=isset($total['问题解决情况1']['解决或基本解决'])?$total['问题解决情况1']['解决或基本解决']:0?></td>
        <td><?=isset($total['问题解决情况1']['部分解决或列入计划'])?$total['问题解决情况1']['部分解决或列入计划']:0?></td>
        <td><?=isset($total['问题解决情况1']['近期尚不能解决'])?$total['问题解决情况1']['近期尚不能解决']:0?></td>
        <td><?=isset($total['问题解决情况1']['留作参考'])?$total['问题解决情况1']['留作参考']:0?></td>
        <td><?=isset($total['意见采纳情况1']['采纳'])?$total['意见采纳情况1']['采纳']:0?></td>
        <td><?=isset($total['意见采纳情况1']['部分采纳'])?$total['意见采纳情况1']['部分采纳']:0?></td>
        <td><?=isset($total['意见采纳情况1']['解释说明'])?$total['意见采纳情况1']['解释说明']:0?></td>
        <td><?=isset($total['意见采纳情况1']['未采纳'])?$total['意见采纳情况1']['未采纳']:0?></td>
        <td><?=isset($total['办理工作']['满意'])?$total['办理工作']['满意']:0?></td>
        <td><?=isset($total['办理工作']['基本满意'])?$total['办理工作']['基本满意']:0?></td>
        <td><?=isset($total['办理工作']['不满意'])?$total['办理工作']['不满意']:0?></td>
        <td><?=isset($total['办理结果']['满意'])?$total['办理结果']['满意']:0?></td>
        <td><?=isset($total['办理结果']['基本满意'])?$total['办理结果']['基本满意']:0?></td>
        <td><?=isset($total['办理结果']['不满意'])?$total['办理结果']['不满意']:0?></td>
<!--        <td></td>-->
<!--        <td></td>-->
<!--        <td></td>-->
    </tr>
</table>