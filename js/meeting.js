var fields= 1==category ? {'案号':'案号','领衔人':'领衔人', '案别':'案别', '案由':'案由', '性质类别':'性质类别1', '原文':'原文', '当前环节':'当前环节', '交办单位':'交办单位', '主办单位':'主办单位', '协办单位':'协办单位'}:
{'登记号':'登记号','案号':'案号', '提案人':'提案人', '案由':'案由', '性质类别':'性质类别2', '原文':'原文', '当前环节':'当前环节', '交办单位':'交办单位', '主办单位':'主办单位', '协办单位':'协办单位'};
resizeWindow();
reflashList(orderby, page, order);
$(window).resize(function () {
    resizeWindow();
    mPopup();
});
$('.count-in-page').change(function () {
    count = parseInt($(this).val());
    reflashList(orderby, page, order);
});
$('.list-filter').click(function () {
    filter = {};
    filter.step = $(this).data('step');
    filter.filter = $(this).data('filtertype');
    reflashList(orderby, page, order);
});
$('.statistics').click(function () {

});

$(document).on('click','.order-by-attr',function(){
    var newOrderby = ($(this).text());
    if ('性质类别' == newOrderby)newOrderby += category;
    if (orderby == newOrderby) {
        order = !order;
    } else {
        order = true;
        orderby = newOrderby
    }
    var orderText = order ? '(升序)' : '(降序)';
    reflashList(orderby, page, order);
    $('.order-disply').text(newOrderby + orderText);
});
$('.create-motion').click(function () {
    var maskHeight = $(document.body).height();
    ajaxPost('createMotion', {}, function (data) {
        $('.m-popup').html(data);
        $('.m-popup').show();
        $('.mask').show();
        $('.mask').css('height', maskHeight);
        mPopup();
    })
});



$('.target-select').click(function () {
    var maskHeight = $(document.body).height();
    ajaxPost('createMotion', {}, function (data) {
        $('.m-popup').html(data);
        $('.m-popup').show();
        $('.mask1').show();
        $('.mask1').css('height', maskHeight);
        mPopup();
    })
});
$(document).on('click','.select-all',function(){
    var state = $(this).prop('checked');
    $('.check').prop('checked', state);
});
$(document).on('click', '.motion-select', function () {
    var maskHeight = $(document.body).height();
    var id = $(this).attr('id');
    ajaxPost('editMotion', {id: id}, function (data) {
//            console.log(data);
//            alert(data);
        $('.m-popup').html(data);
        $('.m-popup').show();
        $('.mask').show();
        $('.mask').css('height', maskHeight);
        mPopup();
    });
});
$(document).on('click', '.sign-out', function () {
    signOut(staff.category);
});
$(document).on('click', '.next-page', function () {
    page++;
    reflashList(orderby, page, order);
    console.log(page);
});
$(document).on('click', '.prev-page', function () {
    if (page > 0) {
        page--;
        reflashList(orderby, page, order);
    }

});
$(document).on('click', '.first-page', function () {
    page = 0;
    reflashList(orderby, page, order);
});
$(document).on('click', '.last-page', function () {
    page = totalPages - 1;
    reflashList(orderby, page, order)
});
$(document).on('click', '.delete-motion', function () {
    var motionId = $(this).attr('id').slice(3);
    if($.inArray('3',staff.steps)>-1){
    //if (staff.steps.indexOf('3') > -1) {
        if (confirm('警告：是否删除此条记录？')) {
            ajaxPost('ajaxDeleteMotion', {id: motionId}, function (data) {
                if ('ok' == backHandle(data)) {
                    reflashList(orderby, page, order);
                }
            });
        }

    }

});
$(document).on('click', '.multiple-statistics', function () {
    location.href = "?download=multiple_statistics";
});
$(document).on('click','.get-statistics-view',function(){
    //alert('ok');
    //console.log({category:category,meeting:meetingId});
    ajaxPost('get_statistics_view',{category:category,meeting:meetingId},function(back){
        console.log(back);
       $('#genetable_tableData').html(back);
    });
});

$(document).on('click','.list-output',function(){
    var motions=null;
    if($(this).hasClass('checked-out')){
        motions=[];
        $.each($('.check'),function(k,v){
            if($(v).prop('checked'))motions.push(v.value)
        });
        if(motions.length<1){
            alert('没有选中项');
            return;
        }
    }else if($(this).hasClass('all-out')){
        if(motionIdLimit.length<1){
            alert('数据记录过多，请筛选后重试');
            return;
        }
        motions=motionIdLimit;
    }
    console.log(motions);
   ajaxPost('ajaxPrepareMotionsToOutput',motions,function(data){
       var back=backHandle(data);
            console.log(back);
       location.href='index.php?download=ajax_downLoad&key='+back+'&category='+category;
   })
});

function pageJump(element, event) {
//        console.log(event.keyCode);
    if (13 == event.keyCode) {
        var sPage = $.trim(element.value);
        if (sPage.match(/^-?[1-9]\d*$/) && sPage > 0 && sPage < totalPages + 1) {
            page = sPage - 1;
            reflashList(orderby, page, order);
        } else {
            alert('页码错误');
        }
    }
}
function resizeWindow() {
    var bHeight = $(document.body).height();
    var wHeight = $(window).height();
    var bWeight = $(document.body).width();
    var weight = bWeight - 239;
    $('.home-r').css('width', weight);
}
function reflashList(sOrderby, sPage, sOrder) {
//        console.log('reflash');
    var data = {
        category: category,
        meeting: meetingId,
        attr_order_by: sOrderby || orderby,
        attr_order: sOrder ? 'asc' : 'desc',
        page: sPage || page,
        filter: filter,
        count: count,
        fields:fields
    };

    ajaxPost('ajaxMotionList', data, function (back) {
        $('#genetable_tableData').html('<table id="sample2" width="100%" border="0" cellpadding="0" cellspacing="0" class="sample-table-js source-table"><thead><tr class="list-head"></tr></thead><tbody class="list-table"></tbody></table>');
        $('.list-head').append('<th>序号</th><th><input type="checkbox" class="select-all"></th>');
        $.each(fields,function(k,v){
            $('.list-head').append('<th class="order-by-attr"><a href="#">'+k+'</a></th>');
        });
        if($.inArray('3',staff.steps)>-1){
        //if(staff.steps.indexOf('3')>-1){
            $('.list-head').append('<th>删除</th>')
        }
        var value = backHandle(back);
        $('.list-content').remove();
        var myCount = 1 + (page * count);
        var c = value.list;
        var displeasure=value.displeasureList;
        $.each(value.sort,function(k,v){
            $('.list-table').append('<tr id="tr'+v+'"></tr>');
            if(displeasure[v]){
                $('#tr'+v).css('color','red');
            }
            $('#tr'+v).append('<td>'+(myCount++)+'</td><td><input type="checkbox" class="check" value=' + v + '></td>');

            $.each(fields,function(name,field){
                switch(field){
                    case '原文':
                        $('#tr'+v).append('<td><a href="' + (c[v][field] || '#') + '">附件</a></td>');
                        break;
                    case '案由':
                        $('#tr'+v).append('<td class="motion-select" id="' + v + '"><a href="#">' + c[v]['案由'] + '</a></td>');
                        break;
                    case '当前环节':
                        if(displeasure[v])$('#tr'+v).append('<td>重办</td>');
                        else $('#tr'+v).append('<td>' + (c[v][field] || '') + '</td>');
                        break;
                    default :
                        $('#tr'+v).append('<td>' + (c[v][field] || '') + '</td>');
                        break;
                }

            });
            if($.inArray('3',staff.steps)>-1)$('#tr'+v).append('<td><button class="delete-motion" id="del' + v + '">X</button></td>');
        });
        reCalculate(value.totalCount);
        motionIdLimit = value.motionIdLimit;
        console.log(motionIdLimit);
        if(!motionIdLimit||motionIdLimit.length<1)$('.all-out').attr('disabled','disabled');
        else $('.all-out').removeAttr('disabled');


    });
}
function reCalculate(totalCount) {
    total = totalCount;
    totalPages = Math.ceil(total / count);
    var last = totalCount < ((page + 1) * count) ? totalCount : (page + 1) * count;
    $('.current-page').text(page + 1);
    $('.total-page').text('共' + totalPages + '页');
    $('.current-num').text((page * count + 1) + '-' + last);
    $('.total-num').text(totalCount);
}

function mPopup() {
    var bWidth = document.documentElement.clientWidth;
    var bHeight = document.documentElement.clientHeight;
    var sWidth = (bWidth - 837) / 2;
    var sHeight = (bHeight - 580) / 2;
    $('.suggest').css('left', sWidth);
    $('.suggest').css('top', sHeight);
}
