<div class="mask"></div>
<div class="suggest cont">
<div class="sug-head clearfix">
    <div class="sug-head-l"><h1><?php echo 1 == current($motion)['category'] ? '人大建议议案办理单' : '政协提案办理单' ?></h1></div>
    <div class="sug-head-r"><p>当前环节：<?php echo current($motion)['step_name'] ?></p></div>
</div>
<div class="sug-main">
    <div class="sug-main-nav clearfix">
        <?php if (in_array(current($motion)['step'], $_SESSION['staffLogin']['steps']) && 5 != current($motion)['step']): ?>
            <a href="#" class="save-attr">保存</a>
            <?php if (3==current($motion)['step']): ?>
                <a href="#" class="motion-reject temp1">退回</a>
            <?php endif ?>

        <?php endif ?>
        <?php if (in_array(current($motion)['step'], $_SESSION['staffLogin']['steps']) && 5 == current($motion)['step']&&(isset($handlerEdit) && count($handlerEdit) > 0)): ?>
            <a href="#" class="save-attr">保存</a>
            <a href="#" class="submit-attr">提交</a>
        <?php endif?>
        <?php if (in_array(current($motion)['step'], $_SESSION['staffLogin']['steps']) && 5 == current($motion)['step']&&$canMainHandler): ?>

            <a href="#" class="save-attr">保存</a>
            <a href="#" class="submit-attr">提交</a>
        <?php endif?>

        <?php if($step4CanEdit&&current($motion)['step']>3&&current($motion)['step']<6&&in_array(4,$_SESSION['staffLogin']['steps'])):?><a href="#" class="motion-reject temp2">退回</a><?php endif ?>
        <?php if (in_array(current($motion)['step'], $_SESSION['staffLogin']['steps']) && 5 != current($motion)['step']): ?>
            <?php if(4!=current($motion)['step']||(4==current($motion)['step']&&$step4CanEdit)):?>
                <a href="#" class="submit-attr">下一步</a>
            <?php endif ?>
        <?php endif ?>

        <a href="#" class="motion-step-inf" id="<?php echo current($motion)['motion_id']?>">查看信息</a>
        <a href="#" class="print-motion">办理单打印</a>
        <?php if(1 == $meetingInf['category']):?><a class="print-motion-detail" href="#">建议议案打印</a><?php endif?>
        <?php if(2 == $meetingInf['category']):?><a class="print-motion-detail" href="#">提案打印</a><?php endif?>
        <a href="<?php echo 'original_'.$meetingInf['document_sha']?>">全文原始稿</a>
        <?php if(3==current($motion)['step']):?><a class="attachment-file" href="#" data-href="<?php echo $motion['原文']['attachment']?>">附件修改</a><?php endif?>
        <a href="#" class="close-popup">返回</a>
    </div>
    <div class="sug-main-content edit-area">
        <div class="content-title">
            <p style="height: 40px;"><?php echo 1 == current($motion)['category'] ? '慈溪市人大建议议案办理单' : '慈溪市政协提案办理单' ?></p>
        </div>
        <div class="table-list">
        <link rel="stylesheet" type="text/css" media="print" href="stylesheet/print.css?v=<?php echo rand(1000, 9999) ?>">
            <table width="100%" height="296" border="0" bordercolor="#f08300" cellpadding="0" cellspacing="0" class="motion-table">
                <tbody style="font-size: 14px">
                <tr>
                    <th><p> 会议名称</p></th>
                    <td colspan="2" width="165">
                        <p><?php echo substr($meetingInf['meeting_name'], 0) ?></p>
                    </td>
                    <th>登记时间</th>
                    <td colspan="2" width="165"><span
                            class="encoded-data"><?php echo json_encode($motion['登记时间'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th>状态</th>
                    <td colspan="2" width="165"><span
                            class="encoded-data"><?php echo json_encode($motion['状态'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                </tr>
                <tr>
                    <th>案别</th>
                    <td colspan="2">
                        <?php if(2==$meetingInf['category']):?><span>提案</span>
                        <?php else:?>
                            <span
                                class="encoded-data"><?php echo json_encode($motion['案别'], JSON_UNESCAPED_UNICODE) ?></span>
                        <?php endif?>
                        </td>
                    <th>案号</th>
                    <td colspan="2" class="verify-value"><span
                            class="encoded-data"><?php echo json_encode($motion['案号'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th>是否公开</th>
                    <td colspan="2"><span
                            class="encoded-data"><?php echo json_encode($motion['是否公开'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                </tr>
                <tr>
                    <th>性质类别</th>
                    <td colspan="2" class="verify-value"><span
                            class="encoded-data"><?php echo json_encode($motion['性质类别' . $meetingInf['category']], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th>性质</th>
                    <td colspan="2"><span
                            class="encoded-data" ><?php echo json_encode($motion['性质'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th><?php echo 1 == $meetingInf['category'] ? '代表团' : '属性' ?></th>
                    <td colspan="2"><?php if($unitGroupInf):?><?php echo $unitGroupInf['group']?><?php endif?></td>
                </tr>
                <?php if (2 == $meetingInf['category']): ?>
                    <tr>
                        <th>委组</th>
                        <td colspan="2"><?php if($unitGroupInf):?><?php echo $unitGroupInf['unit']?><?php endif?></td>
                        <th>提案分类</th>
                        <td colspan="2" class="judged-value"><span
                                class="encoded-data"><?php echo json_encode($motion['提案分类'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                        <th>附议人数</th>
                        <td colspan="2"  class="fuyi">&nbsp;</td>
                    </tr>
                <?php endif ?>
                <?php if(1==$meetingInf['category']):?>
                <tr>
                    <th>领衔人</th>
                    <td colspan="5" class="verify-value name-auto" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['领衔人'], JSON_UNESCAPED_UNICODE) ?></span></td>
                    <td colspan="2">
                        <button class="user-inf" id="inf<?php echo current($motion)['motion_id']?>">显示</button>
                    </td>
                </tr>
                <?php endif ?>
                <?php if(2==$meetingInf['category']):?>
                    <tr>
                        <th>提案人</th>
                        <td colspan="5" class="user-type verify-value" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['提案人'], JSON_UNESCAPED_UNICODE) ?></span></td>
                        <td colspan="2">
                            <button class="user-inf" id="inf<?php echo current($motion)['motion_id']?>">显示</button>
                        </td>
                    </tr>
                    <tr class="union-conecter" <?php if(!$motion['提案联系人']['content'])echo 'style="display: none"'?>>
                        <th >联系人</th>
                        <td colspan="7" class="conecter" style="text-align: left;padding-left: 10px;" ><span
                                class="encoded-data"><?php echo json_encode($motion['提案联系人'], JSON_UNESCAPED_UNICODE) ?></span></td>
                    </tr>
                <?php endif ?>
                <tr>
                    <th >附议人</th>
                    <td colspan="7" class="fuyi-count colspan7" colspan="7" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['附议人'], JSON_UNESCAPED_UNICODE) ?></span></td>

                </tr>
                <tr>
                    <th>案由</th>
                    <td colspan="7" class="colspan7 motion-name-area verify-value" style="text-align: left; padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['案由'], JSON_UNESCAPED_UNICODE) ?></span></td>
                </tr>
                <tr>
                    <th>全文</th>
                    <td colspan="7" class="colspan7 verify-value" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['原文'], JSON_UNESCAPED_UNICODE) ?></span></td>
                </tr>
                <tr>
                    <th>摘要</th>
                    <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['摘要'], JSON_UNESCAPED_UNICODE) ?></span></td>
                </tr>
                <?php if(2==$meetingInf['category']):?>

                <tr>
                    <th>初审</th>
                    <td  style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['初审'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th>初审意见</th>
                    <td colspan="5" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['初审意见'], JSON_UNESCAPED_UNICODE) ?></span></td>
                </tr>
                <?php endif?>
                <?php if ($meetingInf['step'] > 2): ?>
                    <tr>
                        <th>审核</th>
                        <td colspan="7" class="colspan7 pass-verify" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['审核' . $meetingInf['category']], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                    </tr>
                    <tr>
                        <th>审核意见</th>
                        <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['审核意见'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                    </tr>
                    <?php if (2 == $meetingInf['category']): ?>
                        <tr>
                            <th>交办单位</th>
                            <td colspan="7" class="colspan7 verify-value" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['交办单位'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                    <?php endif ?>
                    <?php if(1==$meetingInf['category']&&$motion['交办意见']['content']):?>
                        <?php if(3==$meetingInf['step']):?>
                        <tr>
                            <th>交办意见</th>
                            <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['交办意见'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                            <?php endif ?>
                        <tr>
                            <th>交办单位</th>
                            <td colspan="7" class="colspan7 verify-value" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['交办单位'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                    <?php endif?>
                <?php endif ?>
                <?php if ($meetingInf['step'] > 3): ?>
                    <?php if(1==$meetingInf['category']):?>
                        <tr>
                            <th>交办意见</th>
                            <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['交办意见'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                    <?php endif ?>
                    <tr>
                        <th>主办单位</th>
                        <td colspan="7" class="colspan7 verify-value" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['主办单位'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                    </tr>
                         <th>协办单位</th>
                        <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['协办单位'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                    </tr>
                <?php endif ?>
                <?php if ($meetingInf['step'] > 4): ?>
                    <?php if ($canMainHandler || $meetingInf['step'] > 5 || (!$canMainHandler&&in_array(4,$_SESSION['staffLogin']['steps']))): ?>
                        <tr>
                            <th>主办答复时间</th>
                            <td width="105px"><span
                                    class="encoded-data"><?php echo json_encode($motion['主办答复时间'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                            <th>文号</th>
                            <td width="95px" class="verify-value"><span
                                    class="encoded-data verify-value"><?php echo json_encode($motion['文号'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                            <th>类别标记</th>
                            <td width="100px"><span
                                    class="encoded-data"><?php echo json_encode($motion['类别标记'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                            <th>签发人</th>
                            <td class="verify-value"><span
                                    class="encoded-data verify-value"><?php echo json_encode($motion['主办签发人'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                        <tr>
                            <th>主办意见全文</th>
                            <td colspan="7" class="colspan7 verify-value" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['主办答复全文'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                        <tr>
                            <th>已落实事项</th>
                            <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['已落实事项'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                        <tr>
                            <th>计划落实事项</th>
                            <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['计划落实事项'], JSON_UNESCAPED_UNICODE) ?></span>
                            </td>
                        </tr>
                    <?php endif ?>
                    <?php foreach ($handlerDisplay as $row): ?>
                        <tr>
                            <th>协办单位名称</th>
                            <td colspan="2" style="text-align: left;padding-left: 10px"><?php echo $row['unit_name']?></td>
                            <th>协办办理状态</th>
                            <td colspan="4">
                                <?php echo 9==$row['status']?'已完成':'未完成'?>
                                <?php if(5==current($motion)['step']&&$step4CanEdit&&in_array(4, $_SESSION['staffLogin']['steps']) ):?>
                                    <button class="delete-sub-unit" id="<?php echo $row['motion_handler_id']?>" data-attr="<?php echo $row['attr']?>">删除</button>
                                    <?php if(9==$row['status']):?>
                                        <button class="backward-sub-unit" id="<?php echo $row['motion_handler_id']?>" data-attr="<?php echo $row['attr']?>">退回</button>
                                    <?php endif?>
                                <?php endif?>
                            </td>

                        </tr>
                        <tr>
                            <th>联系人</th>
                            <td colspan="2"><?php echo $row['contact_name'] ?></td>
                            <th>联系电话</th>
                            <td colspan="2"><?php echo $row['contact_phone'] ?></td>
                            <th>回复时间</th>
                            <td colspan="2"><?php echo $row['reply_time']?date('Y-m-d',$row['reply_time']):'' ?></td>
                        </tr>
                        <tr>
                            <th>协办意见全文</th>
                            <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;">
                                <a <?php echo $row['attachment'] ? 'href="' . $row['attachment'] . '"' : '' ?>><?php echo $row['attachment_name'] ?></a>
                            </td>
                        </tr>
                    <?php endforeach ?>
                    <?php if (isset($handlerEdit) && count($handlerEdit) > 0): ?>
                        <tr>
                            <th>协办单位：</th>
                            <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px"><?php echo $handlerEdit['unit_name']?></td>
                        </tr>
                        <tr>
<!--                            <th>签收时间</th>-->
<!--                            <td colspan="2"><input type="hidden" class="motion_handler_id"-->
<!--                                                   id="--><?php //echo $handlerEdit['motion_handler_id'] ?><!--"><span-->
<!--                                    class="time-display" id="receive-time"></span></td>-->
                            <th>联系人</th>
                            <input type="hidden" class="motion_handler_id"
                                   id="<?php echo $handlerEdit['motion_handler_id'] ?>">
                            <td colspan="2" class="verify-value"><input type="text" class="handle-value" id="contact_name"
                                                   value="<?php echo $handlerEdit['contact_name'] ?>"></td>
                            <th>联系电话</th>
                            <td colspan="2" class="verify-value" data-type="int"><input type="tel" class="handle-value" id="contact_phone"
                                                                        value="<?php echo $handlerEdit['contact_phone'] ?>"></td>
                            <th>回复时间</th>
                            <td colspan="2"><span class="time-display" id="reply_time"></span></td>
                        </tr>

                        <tr>
                            <th>协办意见全文</th>
                            <td colspan="7" class="colspan7 verify-value" style="text-align: left;padding-left: 10px;" id="att<?php echo $handlerEdit['motion_handler_id'] ?>">
                                <button class="upload-handler-file">上传</button>
                                <input type="file" class id="handler-attachment" name="handler-attachment"
                                       style="display: none">
                                <a class="handle-attachment-file" <?php echo $handlerEdit['attachment'] ? 'href="' . $handlerEdit['attachment'] . '"' : '' ?>><?php echo $handlerEdit['attachment_name'] ?></a>
                            </td>
                        </tr>
                    <?php endif ?>
                <?php endif ?>
                <?php if ($meetingInf['step'] > 5||(isset($motion['办理工作']['content'])&&$motion['办理工作']['content'])): ?>
                    <tr>
                        <th rowspan="2" style="border-right: 1px solid #f08300">反馈意见</th>
                        <th>办理工作</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['办理工作'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                        <th>办理结果</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['办理结果'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                        <th colspan="2">办理面商形式</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['面商形式'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                    </tr>
                    <tr><th>面商人</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['面商人'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                        <th>采纳情况</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['采纳情况'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                        <th colspan="2">落实情况</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['落实情况'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                    </tr>
                    <tr>
                        <th>反馈意见全文</th>
                        <td colspan="7" class="colspan7" style="text-align: left;padding-left: 10px;"><span class="encoded-data"><?php echo json_encode($motion['反馈意见全文'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                    </tr>


                <?php endif ?>
                </tbody>
            </table>
        </div>
    </div>
</div>
</div>
<table class="table-list">

</table>
<div class="mask1"></div>
<div class="unit" style="display: none;z-index: 999;position: fixed">
    <div class="unit-title">
    	<h2 class="target-name">请选择</h2>
		<div class="back close-unit"></div>
	</div>
    <div class="unit-table">
        <input type="hidden" class="multiple-type">
        <table width="700" border="1" bordercolor="#f08300" cellspacing="0" cellpadding="0">
            <tbody>
            <tr style="height: 40px;">
				<td><div class="nav-tab"><input type="text" name="search" style="width: 280px;height: 20px; margin: 0 10px;" id="search-input"></div></td>
            	<td><button type="button" class="u-btn " id="search-button">搜索</button></td>
            	<td></td>
            </tr>
            <tr>
                <td rowspan="4">
                    <div class="unit-nav selecter-content">
                        <div class="nav-tab">
                            <h2><i class="icon icon-chevron-right"></i></h2>
                            <ul>
                                <li class="li-1 clearfix">
                                    <button class="btn-1 main-candidate-btn" type="button"></button>
                                    <input class="checkbox candidate super" type="checkbox" name="checkbox-lv1"
                                           value="778">
                                    <button class="btn-2" type="button"></button>
                                    <span class="span-1 candidate-name">农业农村组联络委</span></li>
                                <li class="li-2">
                                    <ul>
                                        <li class="li-lv2 main-candidate clearfix">
                                            <button class="btn-lv2-1" type="button"></button>
                                            <input class="checkbox candidate sub" type="checkbox" name="checkbox-lv2"
                                                   value="23">
                                            <button class="btn-lv2-2" type="button"></button>
                                            <span class="span-1 candidate-name">毛玲洁</span></li>

                                    </ul>
                                </li>
                            </ul>

                        </div>
                    </div>
                </td>
                <td width="100" rowspan="2">
                    <button type="button" class="u-btn target-choose">--></button>
                    <button type="button" class="u-btn chosen-delete"><--</button>
                    <button type="button" class="u-btn chosen-confirm">确认</button>
                </td>
                <td width="300px" height="28">
                	<div class="unit-nav">
                		<ul class="target-chosen-ul">

                		</ul>
                	</div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
</div>
<style>
    .duty-detail-box{
        display: none;
        position: fixed;
        width: 600px;
        height: 300px;
        background-color: #ffffff;
        border-radius: 3px;
        z-index: 999;
        top: 50%;
        left: 50%;
        margin-left: -300px;
        margin-top: -150px;
        padding: 5px;
        /* border: 1px solid #f08300; */
        box-shadow: 10px 10px 5px #888888;

		
    }
    .duty-detail-box table{
        border-collapse: collapse;
        width: 100%;
    }
    .duty-detail-box tr,td{
        border: 1px solid #f08300;
        text-align: center;
    }
	.duty-box{width: 600px;
        height: 270px;
        overflow: auto;}
	.duty-header{height: 40px; line-height: 40px; font-size: 15px;color: #fff; background-color: #4a4a4a;}
	.duty-header p{margin-left: 15px;}
	.duty-header i{float: right;margin-right: 15px; line-height: 40px;font-size: 16px;}
	.duty-detail-table tr{height: 26px;line-height: 26px;}
	.duty-detail-table tr:first-child{background-color: #ffe2a3;}
	.duty-detail-box table{table-layout: fixed;overflow: hidden;}
	.duty-detail-box tr td{
        /*word-break: keep-all; */
        /*white-space: nowrap; */
        text-overflow:ellipsis;
        overflow: hidden;
    }
</style>
<div class="duty-detail-box" >
	<div class="duty-header"><p>提案人信息<i class="icon icon-close close-detail-box"></i></p></div>
	<div class="duty-box">
		<table class="duty-detail-table">
			<tr><td style="min-width: 80px;max-width: 80px;width: 80px;">身份</td><td style="min-width: 150px;max-width: 150px;width: 150px;">姓名</td><td style="min-width: 80px;max-width: 80px;width: 80px;">联系电话</td><td style="min-width: 150px;max-width: 150px;width: 150px;">工作单位</td></tr>
		</table>
	</div>
</div>

<script>
//    $(document).ready(function(){
        getFuyiCount();
        decodeDate( $('.encoded-data'));
//    });
</script>

