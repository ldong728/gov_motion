<meta charset="utf-8">
<?php
$name = '';
switch ($_SESSION['staffLogin']['category']) {
    case 1:
        $name = "人大建议议案";
        break;
    case 2:
        $name = "政协提案";
        break;
}
header("Content-Type: application/doc");
header("Content-Disposition: attachment; filename=" . '政协提案综合统计' . ".doc");

?>
<body>
<div>
    据统计，有294个委员提交了提案，委员参与率达86.982%。截止时间内，共收到以提案形式提出的意见建议385件，其中委员提案358件，占总数的93.005%，各民主党派、工商联、人民团体、界别、委组集体提案27件，占总数的6.995%。经初步分类，提案中涉及工业经济、农林水利、财贸金融方面的104件，占总数的26.943%；涉及城建管理、交通道路和环境保护方面的124件，占总数的32.124%；涉及科教文卫体方面的103件，占总数的26.684%；涉及社会保障、政法统战及其他方面的54件，占总数的14.249%。
    （以上数据包括所有收到的提案）
    （以下数据仅包括立案提案）
    经提案委审查，主席会议协商确定，共立案357件（不立案15件， 涉及并案23件，合并成10件），其中重点提案6件。——月——日，市政府召开了全市建议提案交办会议，对立案的提案进行了集中交办，交由政府系统主办的提案<?php echo $unitList[5103]?>件，占<?php echo number_format(($unitList[5103]/($unitList[5103]+$unitList[4954]+$unitList[5154]))*100,2)?>%;交由党委部门，群团组织等非政府系统主办的提案<?php echo ($unitList[4954]+$unitList[5154])?>件,占<?php echo number_format((($unitList[4954]+$unitList[5154])/($unitList[5103]+$unitList[4954]+$unitList[5154]))*100,2)?>%,提案办理涉及单位共有<?php echo count($handleList)?>家,其中，主办单位<?php echo count($mainHandleList)?>家，立案提案中涉及工业经济、 农林水利、财贸金融方面的103件，占总数的28.77%;涉及城建管理、 交通道路和环境保护方面的112件，占总数的31.28%;涉及科教文卫体 方面的92件，占总数的25.70%;涉及社会保障、 政法统战和其他方面的50件，占总数的14.25%。

</div>

</body>