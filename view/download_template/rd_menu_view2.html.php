<html xmlns:o="urn:schemas-microsoft-com:office:office"
      xmlns:w="urn:schemas-microsoft-com:office:word"
      xmlns="http://www.w3.org/TR/REC-html40">
<style>
    .title{
        text-align: center;
        font-size: 19pt;
        margin-bottom: 40px;
    }
    .sub-title{
        font-weight: 500;
        font-size: 12pt;
        font-family: "宋体";
    }
    .main-sub{
        text-align: center;
    }
    td {
        padding: 10px 0;
        text-align: center;
        font-size: 12pt;
        font-family: "楷体";
    }

</style>
<body>
<div class="title">代表<?=iconv('utf-8', 'gb2312//IGNORE', $name)?>目录</div>
<div class="sub-title main-sub">(共<?=$totalCount?>件)</div>
<table border="solid">
    <tr>
        <td class="sub-title" width="15%">案号</td>
        <td class="sub-title" width="15%">领衔人</td>
        <td class="sub-title" width="25%">标题</td>
        <td class="sub-title" width="15%">同意立案</td>
        <td class="sub-title" width="15%">不同意立案</td>
        <td class="sub-title" width="15%">修改后立案</td>
    </tr>
    <?php foreach($info as $k=>$row):?>
        <tr>
            <td class="sub-title" colspan="3" style="text-align: left"><?= iconv('utf-8', 'gb2312//IGNORE', $k) ?>(共<?=$row['count']?>件)</td>
        </tr>
        <?php usort($row['motions'],'mySort');?>
        <?php foreach($row['motions'] as $motions):?>
            <tr>
                <td><?= iconv('utf-8', 'gb2312//IGNORE', $motions[34])?></td>
                <td><?= iconv('utf-8', 'gb2312//IGNORE', $motions[6])?></td>
                <td><?= iconv('utf-8', 'gb2312//IGNORE', $motions[61])?></td>
                <td>□</td>
                <td>□</td>
                <td>□</td>
            </tr>
        <?php endforeach ?>
    <?php endforeach ?>
</table>

</body>



</html>