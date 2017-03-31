<?php global $meetingInf?>
<body>
<div class="m-header">
    <div class="m-header-t"><img class="bg-hua" src="stylesheet/images/bg-hua<?php echo $meetingInf['category']?>.jpg" alt="Huabiao"></div>
    <div class="m-header-b">
        <div class="header-b-l"><p><a href="index.php">首页</a><span><?php echo 1==$meetingInf['category']?'人大议案':'政协提案'?></span></p></div>
        <div class="header-b-r"><a class="sign-out">退出系统</a></div>
        <div class="header-b-m"><p>修改密码</p></div>
    </div>
</div>
<div class="m-home clearfix">
    <div class="home-l">          <!--左边-->
        <div class="home-nav h-border"><p class="icon icon-angle-right"><?php echo 1==$meetingInf['category']?'人大议案':'政协提案'?>></p></div>
        <!--		<div class="home-nav h-border"><p>政协提案<span>》</span></p></div>-->
        <!--		<div class="home-nav h-border"><p>查询<span>》</span></p></div>-->
        <div class="home-nav h-border"><p class="icon icon-angle-right">统计</p></div>
        <!--		<div class="home-nav h-border"><p>历届数据<span>》</span></p></div>-->
        <!--		<div class="home-nav h-border"><p>人大议案建议<span>》</span></p></div>-->
    </div>
    <!--左边-->
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
                    <h2>当前位置：</h2>
                    <a href="#" class="icon"><?php echo $meetingInf['meeting_name']?></a>
                    <a href="#" class="icon icon-angle-right"><?php echo 1==$meetingInf['category']?'人大议案':'政协提案'?></a>
                    <a href="#" class="icon icon-angle-right">按<span  class="order-disply">案号</span></a>
                </div>
                <div class="content-b">
                    <?php if (in_array(1, $_SESSION['staffLogin']['steps'])): ?>
                        <button class="c-btn create-motion" style="width: 90px;margin-left: none;">新建
                        </button><?php endif ?>
                    <button class="c-btn" style="width: 190px;">案号缺少清单</button>
                    <button class="c-btn" style="width: 90px;">建议</button>
                </div>
            </div>
            <div class="home-r-content clearfix">
                <div class="home-table">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="list-table">
                        <tbody>
                        <?php if(1==$meetingInf['category']):?>
                        <tr>
                            <th width="3%" >序号</th>
                            <th width="2%"><input type="checkbox"></th>
                            <th width="4%" class="order-by-attr"> 案号</th>
                            <th width="9%" class="order-by-attr">领衔人</th>
                            <th width="8%" >案别</th>
                            <th width="28%" class="order-by-attr">案由</th>
                            <th width="10%" class="order-by-attr">性质类别</th>
                            <th width="15%" class="order-by-attr">原文</th>
                            <th width="8%" class="order-by-attr">当前环节</th>
                            <th width="13%" class="order-by-attr">办理单位</th>
                        </tr>
                        <?php else: ?>
                            <tr>
                                <th width="5%" >序号</th>
                                <th width="4%"><input type="checkbox"></th>
                                <th width="4%">编号</th>
                                <th width="4%" class="order-by-attr"> 案号</th>
                                <th width="9%" class="order-by-attr">提案人</th>
                                <th width="28%" class="order-by-attr">案由</th>
                                <th width="10%" class="order-by-attr">性质类别</th>
                                <th width="15%" class="order-by-attr">原文</th>
                                <th width="8%" class="order-by-attr">当前环节</th>
                                <th width="13%" class="order-by-attr">办理单位</th>
                            </tr>

                        <?php endif ?>

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

    <div class="last-b"></div>
    <div class="m-popup clearfix" style="display: none" >

    </div>        <!-- 弹出层-->
</div>
<div class="m-footer m-f-magin">
    <div class="container">
        <div class="m-footer-tech"><p>技术支持：慈溪市谷多计算机网络技术有限公司</p></div>
    </div>
</div>
<div class="unit" style="display: none">
	<div class="unit-title"><h2>办理单位选择</h2></div>
	<div class="unit-table">
		<table width="700" border="1" bordercolor="#f08300" cellspacing="0" cellpadding="0">
			<tbody>
			<tr>
				<td rowspan="4">
					<div class="unit-nav">
						<ul>
							<li class="li-1 clearfix">
								<button class="btn-1" type="button"></button>
								<input class="checkbox" type="checkbox" name="checkbox-lv1">
								<button class="btn-2" type="button"></button>
								<span class="span-1">党委系统</span>
							</li>
							<li class="li-2">
								<ul>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市委办</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市纪委（监察局）</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市委组织部</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市委组织部</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市委政法委</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市委政研室</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市编委办</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市编委办</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市委统战部（侨办、台办）</span>
									</li>
								</ul>
							</li>
						</ul>
						<ul>
							<li class="li-1 clearfix">
								<button class="btn-1" type="button"></button>
								<input class="checkbox" type="checkbox" name="checkbox-1">
								<button class="btn-2" type="button"></button>
								<span class="span-1">人大机关</span>
							</li>
							<li class="li-2">
								<ul>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">市人大办</span>
									</li>
								</ul>
							</li>
						</ul>
						<ul>
							<li class="li-1 clearfix">
								<button class="btn-1" type="button"></button>
								<input class="checkbox" type="checkbox" name="checkbox-1">
								<button class="btn-2" type="button"></button>
								<span class="span-1">政府系统</span>
							</li>
							<li class="li-2">
								<ul>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">组成部门</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">组成部门</span>
									</li>
									<li class="li-lv2  clearfix">
										<button class="btn-lv2-1" type="button"></button>
										<input class="checkbox" type="checkbox" name="checkbox-lv2">
										<button class="btn-lv2-2" type="button"></button>
										<span class="span-1">镇街道</span>
									</li>
								</ul>
							</li>
						</ul>
					</div>
				</td>
				<td width="100" rowspan="2">
					<button type="button" class="u-btn">选择</button>
					<button type="button" class="u-btn">删除</button>
				</td>
				<td width="300px" height="28">主办单位选择</td>
			</tr>
			<tr>
				<td height="120">&nbsp;</td>
			</tr>
			<tr>
				<td width="100" rowspan="2">
					<button type="button" class="u-btn">选择</button>
					<button type="button" class="u-btn">删除</button>
				</td>
				<td  height="28">协办单位选择</td>
			</tr>
			<tr>
				<td height="240">&nbsp;</td>
			</tr>
			</tbody>
		</table>
	</div>
</div>
</body>
<script type="text/javascript">
    var meetingId=<?php echo $_GET['get_meeting']?>;
    var category=<?php echo $meetingInf['category']?>;
    var orderby='案号';
    var order=true;
    var page=0;
    var filter={};
    resizeWindow();
    reflashList(orderby,page,order);
    $(window).resize(function(){
        resizeWindow();
        mPopup();
    });
    $('.order-by-attr').click(function(){
        var newOrderby=($(this).text())

       if(orderby==newOrderby){
           order=!order;
       }else{
           order=true;
           orderby=newOrderby
       }
        var orderText=order?'(升序)':'(降序)'
        reflashList(orderby,page,order);
        $('.order-disply').text(newOrderby+orderText);
    });
    $('.create-motion').click(function(){
        var maskHeight = $(document.body).height();
        ajaxPost('createMotion',{},function(data){
            $('.m-popup').html(data);
            $('.m-popup').show();
            $('.mask').show();
            $('.mask').css('height',maskHeight);
            mPopup();
        })
    });
    $(document).on('click','.motion-select',function(){
        var maskHeight = $(document.body).height();
        var id=$(this).attr('id');
        ajaxPost('editMotion',{id:id},function(data){
//            alert(data);
            $('.m-popup').html(data);
            $('.m-popup').show();
            $('.mask').show();
            $('.mask').css('height',maskHeight);
            mPopup();
        });
    });
    $(document).on('click','.sign-out',function(){
        signOut(category);
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
            category:category,
            meeting:meetingId,
            attr_order_by:sOrderby||orderby,
            attr_order:sOrder?'asc':'desc',
            page:sPage||page
        };
        ajaxPost('ajaxMotionList',data,function(back){
            var value=backHandle(back);
            $('.list-content').remove();
            var count=1;
            var c=value.list;
            $.each(value.sort,function(k,v){
                var listContent='<tr class="list-content">'+
                    '<td>'+(count++)+
                    '<td><input type="checkbox" class="check"></td>'+
                    '<td>'+ c[v]['案号']+'</td>'+
                    '<td>'+ c[v]['领衔人']+'</td>'+
                    '<td>'+ c[v]['案别']+'</td>'+
                    '<td class="motion-select" id="'+v+'">'+ c[v]['案由']+'</td>'+
                    '<td>'+ c[v]['性质类别'+category]+'</td>'+
                    '<td><a href="'+ (c[v]['原文']||'#')+'">附件</a></td>'+
                    '<td>'+ c[v]['当前环节']+'</td>'+
                    '<td>'+ c[v]['交办单位']+'</td>'+
                    '</tr>';
                $('.list-table').append(listContent);

            });

        })
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
</html>
