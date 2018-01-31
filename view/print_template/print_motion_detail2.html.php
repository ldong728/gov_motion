<link rel="stylesheet" type="text/css" media="print" href="stylesheet/print_template.css?v=<?=rand(1000, 9999) ?>">
<style>

</style>
<div class="main-container">
    <div class="pre-title">
        登记号：<?=$motion['登记号']?>
    </div>
    <div class="pre-title">
        序号： <div class="index-number">第 <?=$motion['案号']?> 号</div>
    </div>
    <div class="pre-title">
        分类：<?=$motion['性质类别2']?>
    </div>
    <div class="main-title">
        <p class="title-content">中国人民政治协商会议</p>
        <p class="title-content">第十一届慈溪市委员会第二次会议</p>
    </div>
    <div class="static-title">
        提案
    </div>
    <div class="pre-title motion-name">
        <div class="motion-name-title">案由：</div class="motion-name-content"><div><?=$motion['案由']?></div>
    </div>
    <table class="content-table" border="0">
        <tr class="table-title">
            <td width="20%" height="80px">提案者</td>
            <td width="20%" height="40px">界别</td>
            <td width="20%" height="40px">工作单位</br>和通讯地址</td>
            <td width="20%" height="40px">联系电话</td>
            <td width="20%" height="40px">邮编</td>
        </tr>
        <tr>
            <td><?=$userInf['user_name']?></td>
            <td><?=$userInf['user_group_name']?></td>
            <td></td>
            <td><?=$userInf['user_phone']?></td>
            <td></td>
        </tr>
        <tr>
            <td class="table-title">
                委组
            </td>
            <td colspan="4"><?=$userInf['user_unit_name']?></td>
        </tr>
        <tr border="0">
            <td class="table-title" height="80px">
                建议交由</br>
                承办的单位
            </td>
            <td colspan="4">

            </td>
        </tr>
        <tr border="0">
            <td class="table-title" height="80px">
                审查</br>
                意见
            </td>
            <td colspan="4">
                <?=$motion['审核意见']?>
            </td>
        </tr>

    </table>

    <div class="pre-title time-block">
        收案日期：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    </div>
    <div class="tips-container">
        注：1.网上提交的提案需填写首页内容；</br>
            2.提案应一事一议，自己清楚；</br>
            3.建议交由承办的单位由提案者提出，供确定承办单位时参加。</br>
    </div>

</div>


