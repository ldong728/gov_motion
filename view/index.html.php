<?php global $motionList,$meetingList,$category;?>

<body>
<div class="m-header">
	<div class="m-header-t"><img class="bg-hua" src="stylesheet/images/bg-hua.jpg" alt="Huabiao"></div>
	<div class="m-header-b">
		<div class="header-b-l"><p>欢迎您: <?php echo $_SESSION['staffLogin']['staffName']?></p></div>
		<div class="header-b-r"><button class="r-btn sign-out">退出系统</button></div>
		<div class="header-b-m"><p class="date-time">2017年3月11日 星期六</p></div>
	</div>
</div>
<div class="m-home clearfix">
	<div class="home-l">          <!--左边-->
        <?php if(isset($meetingList[1])):?>
		<div class="home-nav"><p>人大议案建议<span>》</span></p></div>
		<div class="home-wrap">
			<ul class="nav-list">
                <?php foreach($meetingList[1] as $row):?>
				<li><a href="#"><?php echo $row['meeting_name']?></a></li>
                <?php endforeach ?>
			</ul>
		</div>
        <?php endif?>
        <?php if(isset($meetingList[2])):?>
		<div class="home-nav"><p>政协提案<span>》</span></p></div>
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
        <?php if(isset($motionList[1])):?>
		<div class="home-title"><p>人大议案待办</p></div>
		<div class="home-content">
			<ul class="content-list">
                <?php foreach($motionList[1] as $row):?>
				<li><a class="motion" id="mtn<?php echo $row['motion_id'] ?>" href="#">请办理【待<?php echo $row['step_name'] ?>】—— <?php echo $row['motion_name'] ?><span class="hour"><?php echo $row['upload_time'] ?></span></a></li>
                <?php endforeach ?>
			</ul>
		</div>
        <?php endif ?>
        <?php if(isset($motionList[2])):?>
            <div class="home-title"><p>政协提案待办</p></div>
            <div class="home-content">
                <ul class="content-list">
                    <?php foreach($motionList[2] as $row):?>
                        <li><a class="motion" id="mtn<?php echo $row['motion_id'] ?>" href="#">请办理【待<?php echo $row['step_name'] ?>】—— <?php echo $row['motion_name'] ?><span class="hour"><?php echo $row['upload_time'] ?></span></a></li>
                    <?php endforeach ?>
                </ul>
            </div>
        <?php endif ?>
<!--		<div class="home-title"><p>政协提案待办</p></div>-->
<!--		<div class="home-content">-->
<!--			<ul class="content-list">-->
<!--				<li><a href="#">请办理【交办】—— 关于森林公园建设成为慈溪市植物园的建设<span class="hour">2017-11-11 11.11</span></a></li>-->
<!--				<li><a href="#">慈溪市第一届xxx<span class="hour">2017-11-11 11.11</span></a></li>-->
<!--				<li><a href="#">慈溪市第一届xxx<span class="hour">2017-11-11 11.11</span></a></li>-->
<!--				<li><a href="#">慈溪市第一届xxx<span class="hour">2017-11-11 11.11</span></a></li>-->
<!--				<li><a href="#">慈溪市第一届xxx<span class="hour">2017-11-11 11.11</span></a></li>-->
<!--			</ul>-->
<!--		</div>-->

	</div>

    <div class="m-popup clearfix" style="display: none">
        <div class="mask"></div>
        <div class="suggest cont">
            <div class="sug-head clearfix">
                <div class="sug-head-l"><h1>建议议案详情</h1></div>
                <div class="sug-head-r"><p>当前环节： 交办</p></div>
            </div>
            <div class="sug-main">
                <div class="sug-main-nav clearfix">
                    <a href="#">保存</a>
                    <a href="#">上一步</a>
                    <a href="#">下一步</a>
                    <a href="#">查看信息</a>
                    <a href="#">办理单打印</a>
                    <a href="#">建议议案打印</a>
                    <a href="#">全文原始稿</a>
                    <a href="#">附件修改</a>
                    <a href="#">返回</a>
                </div>
                <div class="sug-main-content edit-area">
                    <div class="content-title">
                        <p style="height: 40px;" >慈溪市人大建议议案办理单</p>
                    </div>
                    <div class="table-list ">
                        <table width="760" height="296" border="1" bordercolor="#f08300" cellpadding="0" cellspacing="0" style="">
                            <tbody style="font-size: 14px">
                            <tr>
                                <th><p> 会议名称</p></th>
                                <td><p>慈溪市第二十七届</p>
                                    <p>人大第一次会议</p></td>
                                <th>登记时间</th>
                                <td colspan="2">2017-3-16</td>
                                <th>状态</th>
                                <td colspan="2">大会期间</td>
                            </tr>
                            <tr>
                                <th>案别</th>
                                <td>&nbsp;</td>
                                <th>案号</th>
                                <td colspan="2">1</td>
                                <th>是否公开</th>
                                <td colspan="2">公开</td>
                            </tr>
                            <tr>
                                <th>性质类别</th>
                                <td>政治法律</td>
                                <th>性质</th>
                                <td>当年</td>
                                <th>代表团</th>
                                <td colspan="3">第二代表团</td>
                            </tr>
                            <tr>
                                <th>领衔人</th>
                                <td colspan="7">xxx</td>
                            </tr>
                            <tr>
                                <th>复议人</th>
                                <td colspan="5">&nbsp;</td>
                                <th>复议人数</th>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <th>案由</th>
                                <td colspan="7"> 关于进一步提高</td>
                            </tr>
                            <tr>
                                <th>全文</th>
                                <td colspan="7">宗汉001xxx关于进一步提高</td>
                            </tr>
                            <tr>
                                <th>摘要</th>
                                <td colspan="7">&nbsp;</td>
                            </tr>
                            <tr>
                                <th>审核意见</th>
                                <td colspan="7">立案</td>
                            </tr>
                            <tr>
                                <th>主办单位</th>
                                <td colspan="7">&nbsp;</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

    </div>        <!-- 弹出层-->
</div>
<div class="m-footer">
	<div class="m-footer-t"></div>
	<div class="container">
		<div class="m-footer-tech"><p>技术支持：慈溪市谷多计算机网络技术有限公司</p></div>
	</div>
</div>
<script type="text/javascript">
    var category='<?php echo $category?>';
	resizeWindow();
    setTime($('.date-time'));
    $(window).resize(function(){
       resizeWindow();
    });
    $('.motion').click(function(){
        var id=$(this).attr('id').slice(3);
        ajaxPost('editMotion',{id:id},function(data){
            alert(data);
            $('.edit-area').html(data);
            $('.m-popup').show();
        });

    })

    $('.sign-out').click(function(){
        ajaxPost('signOut',{},function(data){
            var value=backHandle(data);
            if('ok'==value)location.href='index.php?c='+category;
            else console.log(value);
        })
    })
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

</script>
</body>
</html>
