<div class="suggest cont">
<div class="sug-head clearfix">
    <div class="sug-head-l"><h1><?php echo 1 == current($motion)['category'] ? '人大建议议案办理单' : '政协提案办理单' ?></h1></div>
    <div class="sug-head-r"><p>当前环节：<?php echo current($motion)['step_name'] ?></p></div>
</div>
<div class="sug-main">
    <div class="sug-main-nav clearfix">
        <?php if(in_array(current($motion)['step'],$_SESSION['staffLogin']['steps'])):?>
        <a href="#" class="save-attr">保存</a>
        <?php if(current($motion)['step']>2):?><a href="#" class="motion-reject">上一步</a>
        <?php endif?>
        <a href="#" class="submit-attr">下一步</a>
        <?php endif?>
        <?php if($step4CanEdit&&5==current($motion)['step']&&in_array(4,$_SESSION['staffLogin']['steps'])):?><a href="#" class="motion-reject">上一步</a><?php endif ?>
        <a href="#" class="motion-step-inf" id="<?php echo current($motion)['motion_id']?>">查看信息</a>
        <a href="#">办理单打印</a>
        <a href="#">建议议案打印</a>
        <a href="<?php echo $motion['原文']['attachment']?>">全文原始稿</a>
        <?php if(current($motion)['step']<4):?><a href="#">附件修改</a><?php endif?>
        <a href="#" class="close-popup">返回</a>
    </div>
    <div class="sug-main-content edit-area">
        <div class="content-title">
            <p style="height: 40px;"><?php echo 1 == current($motion)['category'] ? '慈溪市人大建议议案办理单' : '慈溪市政协提案办理单' ?></p>
        </div>
        <div class="table-list ">
            <table width="100%" height="296" border="0" bordercolor="#f08300" cellpadding="0" cellspacing="0">
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
                        <span><?php echo 1 == $meetingInf['category'] ? '建议' : '提案' ?></span></td>
                    <th>案号</th>
                    <td colspan="2"><span
                            class="encoded-data"><?php echo json_encode($motion['案号'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th>是否公开</th>
                    <td colspan="2"><span
                            class="encoded-data"><?php echo json_encode($motion['是否公开'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                </tr>
                <tr>
                    <th>性质类别</th>
                    <td colspan="2"><span
                            class="encoded-data"><?php echo json_encode($motion['性质类别' . $meetingInf['category']], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th>性质</th>
                    <td colspan="2"><span
                            class="encoded-data"><?php echo json_encode($motion['性质'], JSON_UNESCAPED_UNICODE) ?></span>
                    </td>
                    <th><?php echo 1 == $meetingInf['category'] ? '代表团' : '属性' ?></th>
                    <td colspan="2"><?php if($unitGroupInf):?><?php echo $unitGroupInf['group']?><?php endif?></td>
                </tr>
                <?php if (2 == $meetingInf['category']): ?>
                    <tr>
                        <th>委组</th>
                        <td colspan="2"><?php if($unitGroupInf):?><?php echo $unitGroupInf['unit']?><?php endif?></td>
                        <th>提案分类</th>
                        <td colspan="2"><span
                                class="encoded-data"><?php echo json_encode($motion['提案分类'], JSON_UNESCAPED_UNICODE) ?></span>
                        </td>
                        <th>附议人数</th>
                        <td colspan="2"  class="fuyi">&nbsp;</td>
                    </tr>
                <?php endif ?>
                <?php if(1==$meetingInf['category']):?>
                <tr>
                    <th>领衔人</th>
                    <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['领衔人'], JSON_UNESCAPED_UNICODE) ?></td>
                </tr>
                <?php endif ?>
                <?php if(2==$meetingInf['category']):?>
                    <tr>
                        <th>提案人</th>
                        <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['提案人'], JSON_UNESCAPED_UNICODE) ?></td>
                    </tr>
                <?php endif ?>
                <tr>
                    <th >附议人</th>
                    <td class="fuyi-count" colspan="7" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['附议人'], JSON_UNESCAPED_UNICODE) ?></td>

                </tr>
                <tr>
                    <th>案由</th>
                    <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['案由'], JSON_UNESCAPED_UNICODE) ?></td>
                </tr>
                <tr>
                    <th>全文</th>
                    <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['原文'], JSON_UNESCAPED_UNICODE) ?></td>
                </tr>
                <tr>
                    <th>摘要</th>
                    <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                            class="encoded-data"><?php echo json_encode($motion['摘要'], JSON_UNESCAPED_UNICODE) ?></td>
                </tr>
                <?php if ($meetingInf['step'] > 2): ?>
                    <tr>
                        <th>审核</th>
                        <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['审核' . $meetingInf['category']], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                    </tr>
                    <tr>
                        <th>审核意见</th>
                        <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['审核意见'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                    </tr>
                    <?php if (2 == $meetingInf['category']): ?>
                        <tr>
                            <th>交办单位</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['交办单位'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                        </tr>
                    <?php endif ?>
                <?php endif ?>
                <?php if ($meetingInf['step'] > 3): ?>
                    <tr>
                        <th>主办单位</th>
                        <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['主办单位'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                    </tr>
                         <th>协办单位</th>
                        <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                class="encoded-data"><?php echo json_encode($motion['协办单位'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                    </tr>
                <?php endif ?>
                <?php if ($meetingInf['step'] > 4): ?>
                    <?php if ((isset($canMainHandler) && $canMainHandler) || $meetingInf['step'] > 5): ?>
                        <tr>
                            <th>主办答复时间</th>
                            <td width="105px"><span
                                    class="encoded-data"><?php echo json_encode($motion['主办答复时间'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                            <th>文号</th>
                            <td width="95px"><span
                                    class="encoded-data"><?php echo json_encode($motion['文号'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                            <th>类别标记</th>
                            <td width="100px"><span
                                    class="encoded-data"><?php echo json_encode($motion['类别标记'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                            <th>签发人</th>
                            <td><span
                                    class="encoded-data"><?php echo json_encode($motion['主办签发人'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                        </tr>
                        <tr>
                            <th>主办意见全文</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['主办答复全文'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                        </tr>
                        <tr>
                            <th>已落实事项</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['已落实事项'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                        </tr>
                        <tr>
                            <th>计划落实事项</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px;"><span
                                    class="encoded-data"><?php echo json_encode($motion['计划落实事项'], JSON_UNESCAPED_UNICODE) ?>
                            </td>
                        </tr>
                    <?php endif ?>
                    <?php foreach ($handlerDisplay as $row): ?>
                        <tr>
                            <th>协办单位：</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px"><?php echo $row['unit_name']?>:</td>
                        </tr>
                        <tr>
                            <th>联系人</th>
                            <td><?php echo $row['contact_name'] ?></td>
                            <th>回复时间</th>
                            <td><?php echo $row['reply_time']?date('Y-m-d',$row['reply_time']):'' ?></td>
                            <th>联系电话</th>
                            <td><?php echo $row['contact_phone'] ?></td>
                            <th>电话</th>
                            <td><?php echo $row['contact_phone'] ?></td>
                        </tr>
                        <tr>
                            <th>协办意见全文</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px;">
                                <a class="attachment-file" <?php echo $row['attachment'] ? 'href="' . $row['attachment'] . '"' : '' ?>><?php echo $row['attachment_name'] ?></a>
                            </td>
                        </tr>
                    <?php endforeach ?>
                    <?php if (isset($handlerEdit) && count($handlerEdit) > 0): ?>
                        <tr>
                            <th>协办单位：</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px"><?php echo $handlerEdit['unit_name']?>:</td>
                        </tr>
                        <tr>
                            <th>签收时间</th>
                            <td colspan="2"><input type="hidden" class="motion_handler_id"
                                                   id="<?php echo $handlerEdit['motion_handler_id'] ?>"><span
                                    class="time-display" id="receive-time"></span></td>
                            <th>联系人</th>
                            <td colspan="2"><input type="text" class="handle-value" id="contact_name"
                                                   value="<?php echo $handlerEdit['contact_name'] ?>"></td>
                            <th>回复时间</th>
                            <td><span class="time-display" id="reply_time"></span></td>
                        </tr>
                        <tr>
                            <th>联系电话</th>
                            <td colspan="2"><input type="tel" class="handle-value" id="contact_phone"
                                                   value="<?php echo $handlerEdit['contact_phone'] ?>"></td>
                            <th>电话</th>
                            <td colspan="4"><input type="tel" class="handle-value" id="phone"
                                                   value="<?php echo $handlerEdit['contact_phone'] ?>"></td>
                        </tr>
                        <tr>
                            <th>协办意见全文</th>
                            <td colspan="7" style="text-align: left;padding-left: 10px;" id="att<?php echo $handlerEdit['motion_handler_id'] ?>">
                                <button class="upload-handler-file">上传</button>
                                <input type="file" class id="handler-attachment" name="handler-attachment"
                                       style="display: none">
                                <a class="handle-attachment-file" <?php echo $handlerEdit['attachment'] ? 'href="' . $handlerEdit['attachment'] . '"' : '' ?>><?php echo $handlerEdit['attachment_name'] ?></a>
                            </td>
                        </tr>
                    <?php endif ?>
                <?php endif ?>
                <?php if ($meetingInf['step'] > 5): ?>
                    <tr>
                        <th rowspan="2" style="border-right: 1px solid #f08300">反馈意见</th>
                        <th>办理工作</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['办理工作'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                        <th>办理结果</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['办理结果'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                        <th colspan="2">办理面商形式</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['面商形式'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                    </tr>
                    <tr><th>面商人</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['面商人'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                        <th>采纳情况</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['采纳情况'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                        <th colspan="2">落实情况</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['落实情况'], JSON_UNESCAPED_UNICODE) ?>
                        </td>
                    </tr>
                    <tr>
                        <th>反馈意见全文</th>
                        <td colspan="7" style="text-align: left;padding-left: 10px;"><span class="encoded-data"><?php echo json_encode($motion['反馈意见全文'], JSON_UNESCAPED_UNICODE) ?>
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

<script>
    getFuyiCount();
    decodeDate( $('.encoded-data'));
</script>

