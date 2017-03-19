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
				<table width="100%" border="1" cellspacing="0" cellpadding="0" class="list-table">
					  <tbody>
						<tr>
						  <th width="3%">序号</th>
						  <th width="2%"><input type="checkbox"></th>
						  <th width="4%"> 案号</th>
						  <th width="9%">领衔人</th>
						  <th width="8%">案别</th>
						  <th width="28%">案由</th>
						  <th width="10%">性质类别</th>
						  <th width="15%">全文</th>
						  <th width="8%">当前环节</th>
						  <th width="13%">办理单位</th>
						</tr>
						<tr class="list-content">
						  <td>1</td>
						  <td><input type="checkbox"></td>
						  <td>1</td>
						  <td>陈百祥</td>
						  <td>建议</td>
						  <td>关于进一步提高环卫工人工资待遇的建议</td>
						  <td>政治法律</td>
						  <td>全文</td>
						  <td>交办</td>
						  <td>市政府督查室</td>
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
    var meetingId=<?php echo $_GET['get_meeting']?>;
    var orderby='案号';
    var page=0;
    resizeWindow();
    reflashList();
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
    function reflashList(sOrderby,sPage,sOrder){
        var data={
            meeting:meetingId,
            orderby:sOrderby||orderby,
            order:sOrder||'asc',
            page:sPage||page
        }
        ajaxPost('ajaxMotionList',data,function(back){
            var value=backHandle(back);
            $('.list-content').remove();
            var count=1;
            $.each(value.list,function(k,v){
                var listContent='<tr class="list-content">'+
                    '<td>'+(count++)+
                    '<td><input type="checkbox" class="check"></td>'+
                '<td>'+v['案号']+'</td>'+
                '<td>'+v['领衔人']+'</td>'+
                '<td>'+v['案别']+'</td>'+
                '<td>'+v['案由']+'</td>'+
                '<td>'+v['性质类别']+'</td>'+
                '<td><a href="'+v['原文']+'">附件</a></td>'+
                '<td>'+v['当前环节']+'</td>'+
                '<td>'+v['交办单位']+'</td>'+
                '</tr>';
                $('.list-table').append(listContent);

            });

        })
    }
</script>
</body>
</html>