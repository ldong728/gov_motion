<script src="js/ajaxfileupload.js?>"></script>
<table>

<tr>
    <td>协办意见</td>
    <td id="att<?php echo $original['motion_handler_id']?>">
        <button class="upload-file">上传</button>
        <input type="file" class id="handler-attachment" name="handler-attachment" style="display: none">
        <a class="attachment-file" <?php echo $original['attachment']? 'href="'.$original['attachment'].'"':'' ?>>查看文件</a>
    </td>
</tr>
</table>

<button class="handler-motion">办理</button>

<script>
    var antiDouble=false
    $('.upload-file').click(function(){
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
    })

</script>
