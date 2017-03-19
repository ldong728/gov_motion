<script src="js/ajaxfileupload.js?v=<?php echo rand(1000,9999)?>"></script>
<div class="mask"></div>
<div class="suggest cont">
    <div class="sug-head clearfix">
        <div class="sug-head-l"><h1><?php echo 1==current($motion)['category']?'人大建议议案办理单':'政协提案办理单'?></h1></div>
        <div class="sug-head-r"><p>当前环节：<?php echo current($motion)['step_name']?></p></div>
    </div>
    <div class="sug-main">
        <div class="sug-main-nav clearfix">
            <a href="#">保存</a>
            <a href="#">上一步</a>
            <a href="#" class="submit-attr">下一步</a>
            <a href="#">查看信息</a>
            <a href="#">办理单打印</a>
            <a href="#">建议议案打印</a>
            <a href="#">全文原始稿</a>
            <a href="#">附件修改</a>
            <a href="#">返回</a>
        </div>
        <div class="sug-main-content edit-area">
            <div class="content-title">
                <p style="height: 40px;" ><?php echo 1==current($motion)['category']?'慈溪市人大建议议案办理单':'慈溪市政协提案办理单'?></p>
            </div>
            <div class="table-list ">
                <table width="760" height="296" border="1" bordercolor="#f08300" cellpadding="0" cellspacing="0" >
                    <tbody style="font-size: 14px">
                    <tr>
                        <th><p> 会议名称</p></th>
                        <td><p><?php echo substr($meetingInf['meeting_name'],0) ?></p>
                            </td>
                        <th>登记时间</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['登记时间'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th>状态</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['状态'],JSON_UNESCAPED_UNICODE)?></span></td>
                    </tr>
                    <tr>
                        <th>案别</th>
                        <td><span><?php echo 1==$meetingInf['category']?'建议':'提案'?></span></td>
                        <th>案号</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['案号'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th>是否公开</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['是否公开'],JSON_UNESCAPED_UNICODE)?></span></td>
                    </tr>
                    <tr>
                        <th>性质类别</th>
                        <td><span class="encoded-data"><?php echo json_encode($motion['性质类别'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th>性质</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['性质'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th><?php echo 1==$meetingInf['category']?'代表团':'属性'?></th>
                        <td colspan="2"></td>
                    </tr>
                    <?php if(2==$meetingInf['category']):?>
                    <tr>
                        <th>委组</th>
                        <td></td>
                        <th>提案分类</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['提案分类'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th>附议人数</th>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <?php endif ?>
                    <tr>
                        <th>领衔人</th>
                        <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['领衔人'],JSON_UNESCAPED_UNICODE)?></td>
                    </tr>
                    <tr>
                        <th>附议人</th>
                        <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['附议人'],JSON_UNESCAPED_UNICODE)?></td>

                    </tr>
                    <tr>
                        <th>案由</th>
                        <td colspan="7"><span><?php echo $meetingInf['motion_name']?></span></td>
                    </tr>
                    <tr>
                        <th>全文</th>
                        <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['原文'],JSON_UNESCAPED_UNICODE)?></td>
                    </tr>
                    <tr>
                        <th>摘要</th>
                        <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['摘要'],JSON_UNESCAPED_UNICODE)?></td>
                    </tr>
                    <?php if($meetingInf['step']>2):?>
                        <tr>
                            <th>审核</th>
                            <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['审核'],JSON_UNESCAPED_UNICODE)?></td>
                        </tr>
                        <tr>
                            <th>审核意见</th>
                            <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['审核意见'],JSON_UNESCAPED_UNICODE)?></td>
                        </tr>
                    <?php endif?>
                    <?php if($meetingInf['step']>3):?>
                    <tr>
                        <th>主办单位</th>
                        <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['主办单位'],JSON_UNESCAPED_UNICODE)?></td>
                    </tr>
                        <tr>
                            <th>协办单位</th>
                            <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['协办单位'],JSON_UNESCAPED_UNICODE)?></td>
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
<div class="confirm">
    <button class="next-step">下一步</button>
</div>
<script src="js/edit_motion.js?t=<?php echo rand(1,9999)?>"></script>
<script>
    $('.submit-attr').click(function(){
       submitAtrrs(1,function(data){
           console.log(data)
       })
    });
</script>
