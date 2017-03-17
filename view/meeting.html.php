<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>督查办慈溪市政协委员提案办理系统</title>
<link type="text/css" href="stylesheet/main.css" rel="stylesheet">
<script type="text/javascript" src="../document/jquery.js"></script>

</head>

<body>
<div class="m-header">
	<div class="m-header-t"><img class="bg-hua" src="stylesheet/images/bg-hua.jpg" alt="Huabiao"></div>
	<div class="m-header-b">
		<div class="header-b-l"><p>首页<span>建议提案</span></p></div>
		<div class="header-b-r"><p>退出系统</p></div>
		<div class="header-b-m"><p>修改密码</p></div>
	</div>
</div>
<div class="m-home clearfix">	
	<div class="home-l">          <!--左边-->	
		<div class="home-nav h-border"><p>人大议案建议<span>》</span></p></div>
		<div class="home-nav h-border"><p>政协提案<span>》</span></p></div>
		<div class="home-nav h-border"><p>查询<span>》</span></p></div>
		<div class="home-nav h-border"><p>统计<span>》</span></p></div>
		<div class="home-nav h-border"><p>历届数据<span>》</span></p></div>
		<div class="home-nav h-border"><p>人大议案建议<span>》</span></p></div>		
	</div>                     <!--左边-->
	<div class="home-r h-last">
		<div class="magin">
			<div class="home-title c-list">
				<table width="93%;">
					<tbody>
						<tr>
							<td width="7%"><a href="#">按案号</a></td>
							<td width="15%"><a href="#">按等级时间（序列）</a></td>
							<td width="12%"><a href="#">按性质分类</a></td>
							<td width="10%;"><a href="#">换状态</a></td>
							<td width="10%;"><a href="#">按领衔人</a></td>
							<td width="12%"><a href="#">按办理单位</a></td>
							<td width="12%;"><a href="#">按签收情况</a></td>
							<td width="8%"><a href="#">查询</a></td>
							<td width="8%"><a href="#">统计</a></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="home-seat">
				<div class="content-seat">
					当前位置：
					<a href="#">建议提案 》</a>
					<a href="#">人大建议议案 》 </a>
					<a href="#">按案号</a>
				</div>
				<div class="content-b">
					<button class="c-btn" style="width: 90px;margin-left: none;">删除</button>
					<button class="c-btn" style="width: 190px;">案号缺少清单</button>
					<button class="c-btn" style="width: 90px;">建议</button>
				</div>
			</div>
			<div class="home-r-content clearfix">
				<div class="home-table">
					<table align="center" width="100%" style="overflow: hidden;">
						<tbody>
							<tr align="center" style="background-color: #ff8712">
								<td width="8%"><input type="checkbox"><span>案号</span></td>
								<td width="8%">领衔人</td>
								<td width="6%">案别</td>
								<td width="28%">案由</td>
								<td width="10%">性质类别</td>
								<td width="15%">全文</td>
								<td width="8%">当前环节</td>
								<td width="13%">办理单位</td>
							</tr>
							<tr align="center" valign="middle">
								<td width="9%" class="clearfix" >
									<strong style="float: left;padding-left: 10px;">1</strong>
									<input type="checkbox" class="check">
									<span style="padding-left: 30px">1</span>
								</td>
								<td width="8%">陈百享</td>
								<td width="6%">建议</td>
								<td width="28%">关于进一步提高环卫工人工资福利待遇的建议</td>
								<td width="10%">政治法律</td>
								<td width="15%">全文</td>
								<td width="8%">交办</td>
								<td width="13%">市政府督查室</td>
							</tr>
							<tr align="center" valign="middle">
								<td width="9%" class="clearfix" >
									<strong style="float: left;padding-left: 10px;">1</strong>
									<input type="checkbox" class="check">
									<span style="padding-left: 30px">1</span>
								</td>
								<td width="8%">陈百享</td>
								<td width="6%">建议</td>
								<td width="28%">关于进一步提高环卫工人工资福利待遇的建议</td>
								<td width="10%">政治法律</td>
								<td width="15%">全文</td>
								<td width="8%">交办</td>
								<td width="13%">市政府督查室</td>
							</tr>
						</tbody>
					</table>
					
				</div>
				<div class="home-page-l">
					<a class="page-num">20v</a>
					<a href="#"><i class="icon icon-step-backward"></i></a>
					<a href="#"><i class="icon icon-caret-left"></i></a>
					<a href="#">第<input name="text" type="text" value="1" class="p-num">页 共15页</a>
					<a href="#"><i class="icon icon-caret-right"></i></a>
					<a href="#"><i class="icon icon-step-forward"></i></a>
				</div>
				<div class="home-page-r"><p>显示1到20，共288记录</p></div>
			</div>
		</div>
	</div>
	<div class="home-prev icon icon-angle-double-left"></div>
<!--
	<div class="home-last">
		<div class="last-t"></div>
		
	</div>
-->
	<div class="last-b"></div>
</div>
<div class="m-footer m-f-magin">
<!--	<div class="m-footer-t"></div>-->
	<div class="container">
		<div class="m-footer-tech"><p>技术支持：慈溪市谷多计算机网络技术有限公司</p></div>
	</div>
</div>
<script type="text/javascript">
    resizeWindow();
    $(window).resize(function(){
        resizeWindow();
    });
    function resizeWindow(){
        var bHeight = $(document.body).height();
        var wHeight = $(window).height();
        var bWeight = $(document.body).width();
        var weight = bWeight - 239;
        $('.home-r').css('width',weight);
    }
    function reflashList(config){
        var
    }
</script>
</body>
</html>
