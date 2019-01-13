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
header("Content-Disposition: attachment; filename=" .encodeFileName( '政协提案综合统计' . ".doc"));

?>
<body>
<div>
    据统计，有<?= count($dutyHaveMotionList) ?>个委员提交了提案，委员参与率达<?= number_format((count($dutyHaveMotionList)*100/count($allUserList)),2) ?>%。截止时间内，共收到以提案形式提出的意见建议<?=$totalMotionNumber?>件，其中委员提案<?=$totalMotionNumber-count($groupHaveMotionList)?>件，占总数的<?=number_format((($totalMotionNumber-count($groupHaveMotionList))*100)/$totalMotionNumber,2) ?>%，各民主党派、工商联、人民团体、界别、委组集体提案<?=count($groupHaveMotionList)?>件，占总数的<?=number_format((count($groupHaveMotionList)*100/$totalMotionNumber),2) ?>%。经初步分类，提案中涉及工业经济、农林水利、财贸金融方面的<?=$count1?>件，占总数的<?=number_format(($count1*100/$totalMotionNumber),2)?>%；涉及城建管理、交通道路和环境保护方面的<?=$count2?>件，占总数的<?=number_format(($count2*100/$totalMotionNumber),2)?>%；涉及科教文卫体方面的<?=$count3?>件，占总数的<?=number_format(($count3*100/$totalMotionNumber),2)?>%；涉及社会保障、政法统战及其他方面的<?=$count4?>件，占总数的<?=number_format(($count4*100/$totalMotionNumber),2)?>%。
    （以上数据包括所有收到的提案）
    （以下数据仅包括立案提案）
    经提案委审查，主席会议协商确定，共立案<?=$totalPassedMotion?>件（不立案<?=$totalNotPassMotion?>件， 涉及并案_件，合并成_件），其中重点提案<?=$importent?>件。——月——日，市政府召开了全市建议提案交办会议，对立案的提案进行了集中交办，交由政府系统主办的提案<?php echo $unitList[5103]?>件，占<?php echo number_format(($unitList[5103]/($unitList[5103]+$unitList[4954]+$unitList[5154]))*100,2)?>%;交由党委部门，群团组织等非政府系统主办的提案<?php echo ($unitList[4954]+$unitList[5154])?>件,占<?php echo number_format((($unitList[4954]+$unitList[5154])/($unitList[5103]+$unitList[4954]+$unitList[5154]))*100,2)?>%,提案办理涉及单位共有<?php echo count($handleList)?>家,其中，主办单位<?php echo count($mainHandleList)?>家，立案提案中涉及工业经济、 农林水利、财贸金融方面的<?=$count11?>件，占总数的<?=number_format(($count11*100/$totalPassedMotion),2)?>%;涉及城建管理、 交通道路和环境保护方面的<?=$count22?>件，占总数的<?=number_format(($count22*100/$totalPassedMotion),2)?>%;涉及科教文卫体 方面的<?=$count33?>件，占总数的<?=number_format(($count33*100/$totalPassedMotion),2)?>%;涉及社会保障、 政法统战和其他方面的<?=$count44?>件，占总数的<?=number_format(($count44*100/$totalPassedMotion),2)?>%。

</div>

</body>