<?php global $handleUnitMotionList,$meetingList,$category,$mainCount1,$mainCount2,$count1,$count2;?>
<script>
    var staff=eval('('+'<?php echo json_encode($_SESSION['staffLogin'])?>'+')');
</script>
<body>
<div class="m-header">
    <div class="m-header-t"><img class="bg-hua" src="stylesheet/images/bg-hua3.jpg" alt="Huabiao"></div>
    <div class="m-header-b">
        <div class="header-b-l"><p>欢迎您: <?php echo $_SESSION['staffLogin']['staffName']?></p></div>
        <div class="header-b-r"><button class="r-btn sign-out"><a href="#">退出系统</a></button></div>
        <div class="header-b-m"><p class="date-time">2017年3月11日 星期六</p></div>
    </div>
</div>
<div class="m-home clearfix">
    <div class="home-l">          <!--左边-->
        <?php if(isset($meetingList[1])):?>
            <div class="home-nav"><p class="icon icon-angle-right">人大议案建议</p></div>
            <div class="home-wrap">
                <ul class="nav-list">
                    <?php foreach($meetingList[1] as $row):?>
                        <li><a class="meeting" href="?get_meeting=<?php echo $row['meeting_id']?>"><?php echo $row['meeting_name']?></a></li>
                    <?php endforeach ?>
                </ul>
            </div>
        <?php endif?>
        <?php if(isset($meetingList[2])):?>
            <div class="home-nav"><p class="icon icon-angle-right">政协提案</p></div>
            <div class="home-wrap">
                <ul class="nav-list">
                    <?php foreach($meetingList[2] as $row):?>
                        <li><a class="meeting" href="?get_meeting=<?php echo $row['meeting_id']?>"><?php echo $row['meeting_name']?></a></li>
                    <?php endforeach?>
                </ul>
            </div>
        <?php endif?>
    </div>                     <!--左边-->
    <div class="home-r">
        <?php if(isset($handleUnitMotionList[1])):?>
            <div class="home-title"><p><span>人大议案待办：</span>&nbsp&nbsp&nbsp&nbsp<span>主办共<?php echo $mainCount1?>件；</span>&nbsp<span>协办共<?php echo $count1?>件</span></p></div>
            <div class="home-content">
                <ul class="content-list">
                    <?php if(isset($handleUnitMotionList[1]['main'])):?>
                    <?php foreach($handleUnitMotionList[1]['main'] as $row):?>
                        <li><a class="motion" id="mtn<?php echo $row['motion_id'] ?>" href="#">请办理【主办待办】—— <?php echo $row['motion_name'] ?><span class="hour"><?php echo $row['upload_time'] ?></span></a></li>
                    <?php endforeach ?>
                    <?php endif ?>
                    <?php if(isset($handleUnitMotionList[1]['coop'])):?>
                        <?php foreach($handleUnitMotionList[1]['coop'] as $row):?>
                            <li><a class="motion" id="mtn<?php echo $row['motion_id'] ?>" href="#">请办理【协办待办】—— <?php echo $row['motion_name'] ?><span class="hour"><?php echo $row['upload_time'] ?></span></a></li>
                        <?php endforeach ?>
                    <?php endif ?>
                </ul>
            </div>
        <?php endif ?>
        <?php if(isset($handleUnitMotionList[2])):?>
            <div class="home-title"><p><span>政协提案待办：</span>&nbsp&nbsp&nbsp&nbsp<span>主办共<?php echo $mainCount2?>件；</span>&nbsp<span>协办共<?php echo $count2?>件</span></p></div>
            <div class="home-content">
                <ul class="content-list">
                    <?php if(isset($handleUnitMotionList[2]['main'])):?>
                        <?php foreach($handleUnitMotionList[2]['main'] as $row):?>
                            <li><a class="motion" id="mtn<?php echo $row['motion_id'] ?>" href="#">请办理【主办待办】—— <?php echo $row['motion_name'] ?><span class="hour"><?php echo $row['upload_time'] ?></span></a></li>
                        <?php endforeach ?>
                    <?php endif ?>
                    <?php if(isset($handleUnitMotionList[2]['coop'])):?>
                        <?php foreach($handleUnitMotionList[2]['coop'] as $row):?>
                            <li><a class="motion" id="mtn<?php echo $row['motion_id'] ?>" href="#">请办理【协办待办】—— <?php echo $row['motion_name'] ?><span class="hour"><?php echo $row['upload_time'] ?></span></a></li>
                        <?php endforeach ?>
                    <?php endif ?>
                </ul>
            </div>
        <?php endif ?>

    </div>

    <div class="m-popup clearfix" style="display: none" >

    </div>        <!-- 弹出层-->
</div>
<div class="m-footer">
    <div class="m-footer-t"></div>
    <div class="container">
        <div class="m-footer-tech"><p>技术支持：慈溪市谷多计算机网络技术有限公司</p></div>
    </div>
</div>
<!--<div class="mask"></div>-->
<script src="js/edit_motion.js?t=<?php echo rand(1, 9999) ?>"></script>
<script src="js/ajaxfileupload.js?v=<?php echo rand(1000, 9999) ?>"></script>
<script type="text/javascript">
    var category='<?php echo $category?>';
    resizeWindow();
    setTime($('.date-time'));
    $(window).resize(function(){
        resizeWindow();
        mPopup();
    });
    $('.motion').click(function(){
        var maskHeight = $(document.body).height();
        var id=$(this).attr('id').slice(3);
        ajaxPost('editMotion',{id:id},function(data){
//            console.log(data);
//            alert(data);
            $('.m-popup').html(data);
            $('.m-popup').show();
            $('.mask').show();
            $('.mask').css('height',maskHeight);
            mPopup();   /*弹出窗口居中*/
        });

    })

    $('.sign-out').click(function(){
        signOut(category);
    });

    function resizeWindow(){
        var bHeight = $(document.body).height();
        var wHeight = $(window).height();
        var bWeight = $(document.body).width();
        var weight = bWeight - 240;
        $('.home-r').css('width',weight);

    }
    function setTime(element){
        var week=['','一','二','三','四','五','六','日'];
        var sDate=new Date();
        element.text(sDate.getFullYear()+'年'+(sDate.getMonth()+1)+'月'+sDate.getDate()+'日'+' 星期'+week[sDate.getDay()]);
    }

    function mPopup(){
        var bWidth = document.documentElement.clientWidth;
        var bHeight = document.documentElement.clientHeight ;
        var sWidth = (bWidth-837)/2;
        var sHeight = (bHeight-580)/2;
        $('.suggest').css('left',sWidth);
        $('.suggest').css('top',sHeight);
    }

</script>
</body>
</html>
