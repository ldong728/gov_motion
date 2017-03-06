<body>
    <div class="wrap">
        <input type="text" id="motion-name" placeholder="案由">
        <input type="button" id="submit-motion" value="提交">

        <table>

        </table>

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

</script>