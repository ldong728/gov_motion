<?php global $meetingInf?>
<script src="js/edit_motion.js?t=<?php echo rand(1, 9999) ?>"></script>
<script src="js/ajaxfileupload.js?v=<?php echo rand(1000, 9999) ?>"></script>
<script>
    var staff=eval('('+'<?php echo json_encode($_SESSION['staffLogin'])?>'+')');
</script>
<body>
<div class="m-header">
    <div class="m-header-t"><img class="bg-hua" src="stylesheet/images/bg-hua<?php echo $meetingInf['category']?>.jpg" alt="Huabiao"></div>
    <div class="m-header-b">
        <div class="header-b-l"><p><a href="index.php">首页</a><span><?php echo 1==$meetingInf['category']?'人大议案':'政协提案'?></span></p></div>
        <div class="header-b-r"><a class="sign-out" href="#">退出系统</a></div>
        <div class="header-b-m"><p>修改密码</p></div>
    </div>
</div>
<div class="m-home clearfix">
    <div class="home-l">          <!--左边-->
        <div class="home-nav h-border"><p><?php echo 1==$meetingInf['category']?'人大议案建议':'政协提案'?>></p></div>

<!--        		<div class="home-nav h-border"><p>政协提案<span>》</span></p></div>-->
<!--        		<div class="home-nav h-border"><p>查询<span>》</span></p></div>-->
<!--        <div class="home-nav h-border"><p><i class="icon icon-angle-right"></i>统计</p></div>-->
        <!--		<div class="home-nav h-border"><p>历届数据<span>》</span></p></div>-->
        <!--		<div class="home-nav h-border"><p>人大议案建议<span>》</span></p></div>-->

        <div class="home-nav h-border"><p><a href="#" class="list-filter" data-step="5" data-filtertype="no"><i class="icon icon-angle-right"></i>全部<span></span></a></p></div>

        <?php if(in_array(5,$_SESSION['staffLogin']['steps'])):?>
            <div class="home-nav h-border"><p><a href="#" class="list-filter" data-step="5" data-filtertype="mainhandle"><i class="icon icon-angle-right"></i>主办列表<span></span></a></p></div>
            <div class="home-nav h-border"><p><a href="#" class="list-filter" data-step="5" data-filtertype="handle"><i class="icon icon-angle-right"></i>协办列表<span></span></a></p></div>
        <?php endif?>
        <?php if(in_array(3,$_SESSION['staffLogin']['steps'])):?>
            <div class="home-nav h-border"><p><a href="#" class="list-filter" data-step="5" data-filtertype="mainhandle"><i class="icon icon-angle-right"></i><?php echo 1==$_SESSION['staffLogin']['category']?'代表名单管理':'委员名单管理'?><span></span></a></p></div>
        <?php endif ?>
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
<!--                    <button class="c-btn" style="width: 190px;">案号缺少清单</button>-->
<!--                    <button class="c-btn" style="width: 90px;">建议</button>-->
                </div>
            </div>
            <div class="home-r-content clearfix">
                <div class="home-table">
                    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="list-table">
                        <tbody>
                        <?php if(1==$meetingInf['category']):?>
                        <tr>
                            <th>序号</th>
                            <th><input type="checkbox" class="select-all"></th>
                            <th class="order-by-attr"><a href="#"> 案号</a></th>
                            <th class="order-by-attr"><a href="#">领衔人</a></th>
                            <th class="order-by-attr"><a href="#">案别</a></th>
                            <th class="order-by-attr"><a href="#">案由</a></th>
                            <th class="order-by-attr"><a href="#">性质类别</a></th>
                            <th>原文</th>
                            <th class="order-by-attr"><a href="#">当前环节</a></th>
                            <th>办理单位</th>
                            <th>删除</th>
                        </tr>
                        <?php else: ?>
                            <tr>
                                <th>序号</th>
                                <th><input type="checkbox" class="select-all"></th>
                                <th class="order-by-attr"><a href="#">编号</a></th>
                                <th class="order-by-attr"><a href="#"> 案号</a></th>
                                <th class="order-by-attr"><a href="#">提案人</a></th>
                                <th class="order-by-attr"><a href="#">案由</a></th>
                                <th class="order-by-attr"><a href="#">性质类别</a></th>
                                <th>原文</th>
                                <th class="order-by-attr"><a href="#">当前环节</a></th>
                                <th>办理单位</th>
                                <th>删除</th>
                            </tr>

                        <?php endif ?>

                        </tbody>
                    </table>

                </div>
                <div class="home-page-l">
<!--                    <a class="page-num">20v</a>-->
                    <a href="#"><i class="icon icon-step-backward"></i></a>
                    <a href="#"><i class="icon icon-caret-left prev-page"></i></a>
                    <a href="#">第<input name="text" type="text" value="1" class="p-num">页</a>
                    <a href="#"><i class="icon icon-caret-right next-page"></i></a>
                    <a href="#"><i class="icon icon-step-forward"></i></a>
                </div>
<!--                <div class="home-page-r"><p>显示1到20，共288记录</p></div>-->
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

</body>


<script type="text/javascript">
    var meetingId=<?php echo $_GET['get_meeting']?>;
    var category=<?php echo $meetingInf['category']?>;
    var orderby='编号';
    var order=true;
    var page=0;
    var filter={};
    resizeWindow();
    reflashList(orderby,page,order);
    $(window).resize(function(){
        resizeWindow();
        mPopup();
    });
    $('.list-filter').click(function(){
        filter={};
        filter.step=$(this).data('step');
        filter.filter=$(this).data('filtertype');
        reflashList(orderby,page,order);
    });
    $('.order-by-attr').click(function(){
        var newOrderby=($(this).text());
        if('性质类别'==newOrderby)newOrderby+=category;
       if(orderby==newOrderby){
           order=!order;
       }else{
           order=true;
           orderby=newOrderby
       }
        var orderText=order?'(升序)':'(降序)';
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
	$('.target-select').click(function(){
        var maskHeight = $(document.body).height();
        ajaxPost('createMotion',{},function(data){
            $('.m-popup').html(data);
            $('.m-popup').show();
            $('.mask1').show();
            $('.mask1').css('height',maskHeight);
            mPopup();
        })
    });
    $('.select-all').click(function(){
       var state=$(this).prop('checked');
        $('.check').prop('checked',state);
    });
    $(document).on('click','.motion-select',function(){
        var maskHeight = $(document.body).height();
        var id=$(this).attr('id');
        ajaxPost('editMotion',{id:id},function(data){
//            console.log(data);
//            alert(data);
            $('.m-popup').html(data);
            $('.m-popup').show();
            $('.mask').show();
            $('.mask').css('height',maskHeight);
            mPopup();
        });
    });
    $(document).on('click','.sign-out',function(){
        signOut(staff.category);
    });
    $(document).on('click','.next-page',function(){
       page++;
        reflashList(orderby,page,order);
        console.log(page);
    });
    $(document).on('click','.prev-page',function(){
        if(page>0){
            page--;
            reflashList(orderby,page,order);
        }

    });
    $(document).on('click','.delete-motion',function(){
       var motionId=$(this).attr('id').slice(3);

        if(staff.steps.indexOf('3')>-1){
            if(confirm('警告：是否删除此条记录？')){
                ajaxPost('ajaxDeleteMotion',{id:motionId},function(data){
                    if('ok'==backHandle(data)){
                        reflashList(orderby,page,order);
                    }
                });
            }

        }

    });
    function resizeWindow(){
            var bHeight = $(document.body).height();
        var wHeight = $(window).height();
        var bWeight = $(document.body).width();
        var weight = bWeight - 239;
        $('.home-r').css('width',weight);
    }
    function reflashList(sOrderby,sPage,sOrder){
//        console.log('reflash');
        var data={
            category:category,
            meeting:meetingId,
            attr_order_by:sOrderby||orderby,
            attr_order:sOrder?'asc':'desc',
            page:sPage||page,
            filter:filter
        };

            ajaxPost('ajaxMotionList',data,function(back){
                var value=backHandle(back);
                $('.list-content').remove();
                var count=1+(page*20);
                var c=value.list;
//                console.log(c);
                if(1==data.category) {
                    $.each(value.sort, function (k, v) {
                        if(v>0){
                            var listContent = '<tr class="list-content">' +
                                '<td>' + (count++) +
                                '<td><input type="checkbox" class="check" value='+v+'></td>' +
                                '<td>' + (c[v]['案号']||'')+ '</td>' +
                                '<td>' + (c[v]['领衔人']||'') + '</td>' +
                                '<td>' + (c[v]['案别']||'') + '</td>' +
                                '<td class="motion-select" id="' + v + '"><a href="#">' + (c[v]['案由']||'') + '</a></td>' +
                                '<td>' + (c[v]['性质类别' + category]||'')+ '</td>' +
                                '<td><a href="' + (c[v]['原文'] || '#') + '">附件</a></td>' +
                                '<td>' + (c[v]['当前环节']||'') + '</td>' +
                                '<td>' + (c[v]['交办单位']||'') + '</td>' +
                                '<td><button class="delete-motion" id="del'+v+'">X</button></td>'+
                                '</tr>';
                            $('.list-table').append(listContent);
                        }


                    });
                }else{
                    $.each(value.sort, function (k, v) {
                        if(v>0){
                            var listContent = '<tr class="list-content">' +
                                '<td>' + (count++) +
                                '<td><input type="checkbox" class="check" value='+v+'></td>' +
                                '<td>' + c[v]['编号'] + '</td>' +
                                '<td>' + (c[v]['案号']||'') + '</td>' +
                                '<td>' + (c[v]['提案人']||'') + '</td>' +
//                            '<td>' + c[v]['案别'] + '</td>' +
                                '<td class="motion-select" id="' + v + '"><a href="#">' + c[v]['案由'] + '</a></td>' +
                                '<td>' + (c[v]['性质类别' + category]||'') + '</td>' +
                                '<td><a href="' + (c[v]['原文'] || '#') + '">附件</a></td>' +
                                '<td>' + (c[v]['当前环节']||'') + '</td>' +
                                '<td>' + (c[v]['交办单位']||'') + '</td>' +
                                '<td><button class="delete-motion" id="del'+v+'">X</button></td>'+
                                '</tr>';
                            $('.list-table').append(listContent);
                        }


                    });
                }
                $('.p-num').val(page+1);

            });
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
