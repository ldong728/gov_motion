<meta charset = "utf-8">
<style>
    td{
        align-content: center;
    }
</style>
<?php
header("Content-type:application/vnd.ms-excel");
header("Content-Disposition:filename=".encodeFileName("办理情况评估(承办单位数据)".timeUnixToMysql(time()).".xls"));
?>
<table border=1 style="text-align: center">
    <tr><td colspan="37">慈溪市十七届人大二次会议代表建议办理情况评估表(承办单位数据)</td></tr>
    <tr>
        <td rowspan="3">主办单位</td>
        <td rowspan="3">主办数量</td>
        <td colspan="8">类别号标记</td>
        <td colspan="4">面商人</td>
        <td colspan="4">协商形式</td>
        <td colspan="4">问题解决情况</td>
        <td colspan="4">意见采纳情况</td>

        <td colspan="3">办理工作满意度</td>
        <td colspan="3">办理结果满意度</td>
        <td colspan="3">附议代表答复</td>
    </tr>
    <tr>
        <td colspan="2">A</td><td colspan="2">B</td><td colspan="2">C</td><td colspan="2">D</td>
        <td rowspan="2">单位<br>一把<br>手</td><td rowspan="2">局级<br>领导</td><td rowspan="2">科室<br>负责<br>人</td><td rowspan="2">一般<br>干部</td>
        <td rowspan="2">座谈<br>会</td><td rowspan="2">登门<br>走访</td><td rowspan="2">电话<br>联系</td><td rowspan="2">未协<br>商</td>
        <td rowspan="2">已解<br>决或<br>基本<br>解决</td><td rowspan="2">部分<br>解决<br>或计<br>划解<br>决</td><td rowspan="2">近期<br>不能<br>解决</td><td rowspan="2">留作<br>工作<br>参考</td>
        <td rowspan="2">采纳<br>或基<br>本采<br>纳</td><td rowspan="2">部分<br>采纳</td><td rowspan="2">解释<br>说明</td><td rowspan="2">未采<br>纳</td>

        <td rowspan="2">满意</td><td rowspan="2">基本<br>满意<br></td><td rowspan="2">不满<br>意</td>
        <td rowspan="2">满意</td><td rowspan="2">基本<br>满意<br></td><td rowspan="2">不满<br>意</td>
        <td rowspan="2">主送<br></td><td rowspan="2">抄送<br></td><td rowspan="2">未答<br>复</td>
    </tr>
    <tr>
        <td>占比</td>
        <td>数量</td>
        <td>占比</td>
        <td>数量</td>
        <td>占比</td>
        <td>数量</td>
        <td>占比</td>
        <td>数量</td>
    </tr>
    <?php foreach($statisticsList as $row):?>
        <?php
            $A=isset($row['类别标记']['A'])?$row['类别标记']['A']:0;
            $B=isset($row['类别标记']['B'])?$row['类别标记']['B']:0;
            $C=isset($row['类别标记']['C'])?$row['类别标记']['C']:0;
            $D=isset($row['类别标记']['D'])?$row['类别标记']['D']:0;
        ?>
        <tr>
            <td><?=$row['主办单位']?></td>
            <td><?=$row['count']?></td>
            <td><?=number_format($A/$row['count']*100,2,'.','').'%'?></td>
            <td><?=$A?></td>
            <td><?=number_format($B/$row['count']*100,2,'.','').'%'?></td>
            <td><?=$B?></td>
            <td><?=number_format($C/$row['count']*100,2,'.','').'%'?></td>
            <td><?=$C?></td>
            <td><?=number_format($D/$row['count']*100,2,'.','').'%'?></td>
            <td><?=$D?></td>
<!--            <td>--><?//='单位一把手'==$row['面商人1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='局级领导'==$row['面商人1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='科室负责人'==$row['面商人1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='一般干部'==$row['面商人1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='座谈会'==$row['协商形式1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='登门走访'==$row['协商形式1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='电话联系'==$row['协商形式1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='未协商'==$row['协商形式1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='解决或基本解决'==$row['问题解决情况1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='部分解决或列入计划'==$row['问题解决情况1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='近期尚不能解决'==$row['问题解决情况1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='留作参考'==$row['问题解决情况1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='采纳'==$row['意见采纳情况1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='部分采纳'==$row['意见采纳情况1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='解释说明'==$row['意见采纳情况1']?'✓':''?><!--</td>-->
<!--            <td>--><?//='未采纳'==$row['意见采纳情况1']?'✓':''?><!--</td>-->

<!--            <td>--><?//='满意'==$row['办理工作']?'✓':''?><!--</td>-->
<!--            <td>--><?//='基本满意'==$row['办理工作']?'✓':''?><!--</td>-->
<!--            <td>--><?//='不满意'==$row['办理工作']?'✓':''?><!--</td>-->
<!--            <td>--><?//='满意'==$row['办理结果']?'✓':''?><!--</td>-->
<!--            <td>--><?//='基本满意'==$row['办理结果']?'✓':''?><!--</td>-->
<!--            <td>--><?//='不满意'==$row['办理结果']?'✓':''?><!--</td>-->
<!--            <td></td>-->
<!--            <td></td>-->
<!--            <td></td>-->
<!--            <td></td>-->
<!--            <td></td>-->
<!--            <td></td>-->
<!--            <td></td>-->
<!--            <td></td>-->
        </tr>
    <?php endforeach?>
    <tr><td colspan="3">合计（件）</td>
<!--        <td>--><?//=isset($count['单位一把手'])?$count['单位一把手']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['局级领导'])?$count['局级领导']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['科室负责人'])?$count['科室负责人']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['一般干部'])?$count['一般干部']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['座谈会'])?$count['座谈会']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['登门走访'])?$count['登门走访']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['电话联系'])?$count['电话联系']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['未协商'])?$count['未协商']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['解决或基本解决'])?$count['解决或基本解决']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['部分解决或列入计划'])?$count['部分解决或列入计划']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['近期尚不能解决'])?$count['近期尚不能解决']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['留作参考'])?$count['留作参考']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['采纳'])?$count['采纳']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['部分采纳'])?$count['部分采纳']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['解释说明'])?$count['解释说明']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['未采纳'])?$count['未采纳']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['A'])?$count['A']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['B'])?$count['B']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['C'])?$count['C']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['D'])?$count['D']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理工作']['满意'])?$count['办理工作']['满意']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理工作']['基本满意'])?$count['办理工作']['基本满意']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理工作']['不满意'])?$count['办理工作']['不满意']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理结果']['满意'])?$count['办理结果']['满意']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理结果']['基本满意'])?$count['办理结果']['基本满意']:0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理结果']['不满意'])?$count['办理结果']['不满意']:0?><!--</td>-->
    </tr>
    <tr><td colspan="3">占比</td>
<!--        <td>--><?//=isset($count['单位一把手'])?number_format($count['单位一把手']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['局级领导'])?number_format($count['局级领导']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['科室负责人'])?number_format($count['科室负责人']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['一般干部'])?number_format($count['一般干部']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['座谈会'])?number_format($count['座谈会']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['登门走访'])?number_format($count['登门走访']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['电话联系'])?number_format($count['电话联系']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['未协商'])?number_format($count['未协商']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['解决或基本解决'])?number_format($count['解决或基本解决']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['部分解决或列入计划'])?number_format($count['部分解决或列入计划']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['近期尚不能解决'])?number_format($count['近期尚不能解决']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['留作参考'])?number_format($count['留作参考']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['采纳'])?number_format($count['采纳']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['部分采纳'])?number_format($count['部分采纳']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['解释说明'])?number_format($count['解释说明']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['未采纳'])?number_format($count['未采纳']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['A'])?number_format($count['A']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['B'])?number_format($count['B']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['C'])?number_format($count['C']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['D'])?number_format($count['D']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理工作']['满意'])?number_format($count['办理工作']['满意']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理工作']['基本满意'])?number_format($count['办理工作']['基本满意']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理工作']['不满意'])?number_format($count['办理工作']['不满意']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理结果']['满意'])?number_format($count['办理结果']['满意']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理结果']['基本满意'])?number_format($count['办理结果']['基本满意']/$total*100,2,'.','').'%':0?><!--</td>-->
<!--        <td>--><?//=isset($count['办理结果']['不满意'])?number_format($count['办理结果']['不满意']/$total*100,2,'.','').'%':0?><!--</td>-->
    </tr>
</table>