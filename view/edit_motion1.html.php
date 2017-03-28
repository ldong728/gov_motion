<script src="js/ajaxfileupload.js?v=<?php echo rand(1000,9999)?>"></script>


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
            <a href="#" class="close-popup">返回</a>
        </div>
        <div class="sug-main-content edit-area">
            <div class="content-title">
                <p style="height: 40px;" ><?php echo 1==current($motion)['category']?'慈溪市人大建议议案办理单':'慈溪市政协提案办理单'?></p>
            </div>
            <div class="table-list ">
                <table width="769" height="296" border="1" bordercolor="#f08300" cellpadding="0" cellspacing="0" >
                    <tbody style="font-size: 14px">
                    <tr>
                        <th><p> 会议名称</p></th>
                        <td colspan="2" style="text-align: center;padding-left: 0;"><p><?php echo substr($meetingInf['meeting_name'],0) ?></p>
                            </td>
                        <th>登记时间</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['登记时间'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th>状态</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['状态'],JSON_UNESCAPED_UNICODE)?></span></td>
                    </tr>
                    <tr>
                        <th>案别</th>
                        <td colspan="2" style="text-align: center;padding-left: 0;"><span><?php echo 1==$meetingInf['category']?'建议':'提案'?></span></td>
                        <th>案号</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['案号'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th>是否公开</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['是否公开'],JSON_UNESCAPED_UNICODE)?></span></td>
                    </tr>
                    <tr>
                        <th>性质类别</th>
                        <td colspan="2" style="text-align: center;padding-left: 0;"><span class="encoded-data"><?php echo json_encode($motion['性质类别'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th>性质</th>
                        <td colspan="2"><span class="encoded-data"><?php echo json_encode($motion['性质'],JSON_UNESCAPED_UNICODE)?></span></td>
                        <th><?php echo 1==$meetingInf['category']?'代表团':'属性'?></th>
                        <td colspan="2"></td>
                    </tr>
                    <?php if(2==$meetingInf['category']):?>
                    <tr>
                        <th>委组</th>
                        <td colspan="2" style="text-align: center;padding-left: 0;"></td>
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
                        <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['案由'],JSON_UNESCAPED_UNICODE)?></td>
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
                        <?php if(2==$meetingInf['category']):?>
                        <tr>
                            <th>交办单位</th>
                            <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['交办单位'],JSON_UNESCAPED_UNICODE)?></td>
                        </tr>
                        <?php endif?>
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
                    <?php if($meetingInf['step']>4):?>
                        <?php if(isset($canMainHandler)&&$canMainHandler):?>
                            <tr>
                                <th>答复时间</th>
                                <td><span class="encoded-data"><?php echo json_encode($motion['主办答复时间'],JSON_UNESCAPED_UNICODE)?></td>
                                <th>文号</th>
                                <td><span class="encoded-data"><?php echo json_encode($motion['文号'],JSON_UNESCAPED_UNICODE)?></td>
                                <th>类别标记</th>
                                <td><span class="encoded-data"><?php echo json_encode($motion['类别标记'],JSON_UNESCAPED_UNICODE)?></td>
                                <th>签发人</th>
                                <td><span class="encoded-data"><?php echo json_encode($motion['主办签发人'],JSON_UNESCAPED_UNICODE)?></td>
                            </tr>
                            <tr>
                                <th>已落实事项</th>
                                <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['已落实事项'],JSON_UNESCAPED_UNICODE)?></td>
                            </tr>
                            <tr>
                                <th>计划落实事项</th>
                                <td colspan="7"><span class="encoded-data"><?php echo json_encode($motion['计划落实事项'],JSON_UNESCAPED_UNICODE)?></td>
                            </tr>
                        <?php endif ?>
                        <?php foreach($handlerDisplay as $row):?>
                            <tr>
                                <th>签收时间</th>
                                <td colspan="2"><?php echo timeUnixToMysql($row['receive_time'])?></td>
                                <th>联系人</th>
                                <td colspan="2"><?php echo $row['contact_name']?></td>
                                <th>回复时间</th>
                                <td><?php echo timeUnixToMysql($row['reply_time'])?></td>
                            </tr>
                            <tr>
                                <th>联系电话</th>
                                <td colspan="2"><?php echo $row['contact_phone']?></td>
                                <th>电话</th>
                                <td colspan="4"><?php echo $row['contact_phone']?></td>
                            </tr>
                            <tr>
                                <th>协办意见全文</th>
                                <td colspan="7">
                                    <a class="attachment-file" <?php echo $row['attachment']? 'href="'.$row['attachment'].'"':'' ?>>查看文件</a>
                                </td>
                            </tr>
                        <?php endforeach ?>
                        <?php if(isset($handlerEdit)&&count($handlerEdit)>0):?>
                                <tr>
                                    <th>签收时间</th>
                                    <td colspan="2"><input type="hidden" class="motion_handler_id" id="<?php echo $handlerEdit['motion_handler_id']?>"><span class="time-display" id="receive-time"></span></td>
                                    <th>联系人</th>
                                    <td colspan="2"><input type="text" class="handle-value" id="contact_name" value="<?php echo $handlerEdit['contact_name']?>"></td>
                                    <th>回复时间</th>
                                    <td><span class="time-display" id="reply_time"></span></td>
                                </tr>
                                <tr>
                                    <th>联系电话</th>
                                    <td colspan="2"><input type="tel" class="handle-value" id="contact_phone" value="<?php echo $handlerEdit['contact_phone']?>"></td>
                                    <th>电话</th>
                                    <td colspan="4"><input type="tel" class="handle-value" id="phone" value="<?php echo $handlerEdit['contact_phone']?>"></td>
                                </tr>
                                <tr>
                                    <th>协办意见全文</th>
                                    <td colspan="7" id="att<?php echo $handlerEdit['motion_handler_id']?>">
                                        <button class="upload-handler-file">上传</button>
                                        <input type="file" class id="handler-attachment" name="handler-attachment" style="display: none">
                                        <a class="attachment-file" <?php echo $handlerEdit['attachment']? 'href="'.$handlerEdit['attachment'].'"':'' ?>>查看文件</a>
                                    </td>
                                </tr>
                        <?php endif ?>
                    <?php endif ?>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<table class="table-list">

</table>

<script src="js/edit_motion.js?t=<?php echo rand(1,9999)?>"></script>
<script>
    $('.submit-attr').click(function(){
       submitAtrrs(1,function(data){
           closePopUp($('.m-popup'));
           window.location.reload(true);
       })
    });
    var antiDouble=false
    $('.upload-handler-file').click(function(){
        antiDouble=true;
        $('#handler-attachment').click();
        setTimeout(function(){
            antiDouble=false;
        },1000)
    });
    $('#handler-attachment').change(function(){
        var _=$(this);
        var handlerId= _.parent().attr('id').slice(3);
        var url='upload.php?handler_attachment='+handlerId;
        fileElementId= _.attr('id')
        var uploadConfig= {
            url: url,
            secureuri: false,
            fileElementId: fileElementId, //文件上传域的ID
            dataType: 'json', //返回值类型 一般设置为json
            success: function (v, status) {
                if ('SUCCESS' == v.state) {
                    $('.attachment-file').attr('href', v.url);
                    antiDouble = false;
                    console.log(v);
                } else {
                    showToast(v.state);
                }
            },//服务器成功响应处理函数
            error: function (d) {
                alert('error');
            }
        };
        $.ajaxFileUpload(uploadConfig);
    });
    $('.close-popup').click(function(){
       closePopUp($('.m-popup'));
        closePopUp($('.mask'));
//		$('.mask').css('display','none');
    });

</script>
