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
        font-family: "����";
    }
    .main-sub{
        text-align: center;
    }


    td {
        text-align: center;
        font-size: 12pt;
        font-family: "����";
        height: 16pt;
    }
    .content-td{
        padding-left: 20px;
    }

</style>
<body>
<div class="title">����<?=iconv('utf-8', 'gb2312//IGNORE', $name)?>Ŀ¼</div>
<div class="sub-title main-sub">(��<?=$totalCount?>��)</div>
<table border="solid">
    <tr>
        <td class="sub-title" width="15%">����</td>
        <td class="sub-title" width="15%">������</td>
        <td class="sub-title" width="69%">����</td>
    </tr>
    <?php foreach($info as $k=>$row):?>
    <tr>
        <td class="sub-title" colspan="3" style="text-align: left"><?= iconv('utf-8', 'gb2312//IGNORE', $k) ?>(��<?=$row['count']?>��)</td>
    </tr>
        <?php usort($row['motions'],'mySort');?>
        <?php foreach($row['motions'] as $motions):?>
    <tr>
                <td><?= iconv('utf-8', 'gb2312//IGNORE', $motions[34])?></td>
                <td><?= iconv('utf-8', 'gb2312//IGNORE', $motions[6])?></td>
                <td  class="content-td"><?= iconv('utf-8', 'gb2312//IGNORE', $motions[61])?></td>
    </tr>
            <?php endforeach ?>
    <?php endforeach ?>
</table>

</body>



</html>