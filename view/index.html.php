<?php global $motionList?>
<style>
    .edit-area{
        position: absolute;
        width: 60%;
        height: 60%;
        margin: auto auto;
        background-color: #0c9c6e;
    }
</style>
<body>
    <div class="wrap">
        <input type="text" id="motion-name" placeholder="案由">
        <input type="button" id="submit-motion" value="提交">
        <input type="button" id="sign-out" value="退出">

        <table>
            <?php foreach($motionList as $row):?>
            <tr>
                <td>
                    <a class="handler-motion" id="<?php htmlOut($row['motion_id'])?>"><?php htmlout($row['motion_name'])?></div>
                </td>
            </tr>
            <?php endforeach ?>
        </table>


    </div>
    <div class="edit-area">

    </div>
</body>
<script>
    $('#submit-motion').click(function(){
        ajaxPost('createMotion',{motion_name:$('#motion-name').val()},function(data){
            console.log(data);
            var back=backHandle(data);
            console.log(back);
        });

    });
    $('#sign-out').click(function(){
        ajaxPost('signOut',null,function(data){
            alert(data);
        })
    })
    $('.handler-motion').click(function(){
        var id=$(this).get(0).id;
        ajaxPost('editMotion',{id:id},function(data){
            alert(data);
            $('.edit-area').html(data);
        });

    })


</script>