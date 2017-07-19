var fields= 1==category ? {'案号':'案号','领衔人':'领衔人', '案别':'案别', '案由':'案由', '性质类别':'性质类别1', '原文':'原文', '当前环节':'当前环节', '交办单位':'交办单位', '协办单位':'协办单位', '主办单位':'主办单位'}:
{'案号':'案号','登记号':'登记号', '提案人':'提案人', '案由':'案由', '性质类别':'性质类别2', '原文':'原文', '当前环节':'当前环节', '交办单位':'交办单位', '协办单位':'协办单位', '主办单位':'主办单位'};
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
//        alert('hahahah');
//        ajaxPost('ajaxGetStatistics',{},function(data){
//
//        });
});

$('.order-by-attr').click(function () {
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
$('.select-all').click(function () {
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

    if (staff.steps.indexOf('3') > -1) {
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
//$(document).on('change','.check',function(){
//    var id=$(this).val();
//    var isChecked=$(this).prop('checked');
//    if(isChecked){
//        checkedList[id]=id;
//    }else{
//        delete checkedList[id];
//    }
//    if($(checkedList).length<1){
//        $('.checked-out').attr('disabled','disabled')
//
//    }else{
//        $('.checked-out').removeAttr('disabled')
//    }
//});
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
        count: count
    };

    ajaxPost('ajaxMotionList', data, function (back) {
        var value = backHandle(back);
        $('.list-content').remove();
        var myCount = 1 + (page * count);
        var c = value.list;
//                console.log(c);
        if (1 == data.category) {
            $.each(value.sort, function (k, v) {
                if (v > 0) {
                    var unitName = '';
                    var delButton = staff.steps.indexOf('3') > -1 ? '<td><button class="delete-motion" id="del' + v + '">X</button></td>' : '';
                    if (['审核', '登记'].indexOf(c[v]['当前环节']) > -1)unitName = '市人大代工委';
                    if ('交办' == c[v]['当前环节'])unitName = c[v]['交办单位'] || '市政府督查室';
                    if (['办理', '反馈'].indexOf(c[v]['当前环节']) > -1)unitName = c[v]['主办单位'] || '';
                    var listContent = '<tr class="list-content">' +
                        '<td>' + (myCount++) +
                        '<td><input type="checkbox" class="check" value=' + v + '></td>' +
                        '<td>' + (c[v]['案号'] || '') + '</td>' +
                        '<td>' + (c[v]['领衔人'] || '') + '</td>' +
                        '<td>' + (c[v]['案别'] || '') + '</td>' +
                        '<td class="motion-select" id="' + v + '"><a href="#">' + (c[v]['案由'] || '') + '</a></td>' +
                        '<td>' + (c[v]['性质类别' + category] || '') + '</td>' +
                        '<td><a href="' + (c[v]['原文'] || '#') + '">附件</a></td>' +
                        '<td>' + (c[v]['当前环节'] || '') + '</td>' +
                        '<td>' + unitName + '</td>' +
                        '<td style="white-space: nowrap;text-overflow: clip; overflow: hidden">' + (c[v]['协办单位'] || '') + '</td>' +
                        delButton +
                        '</tr>';
                    $('.list-table').append(listContent);
                }


            });
        } else {
            $.each(value.sort, function (k, v) {
                if (v > 0) {
                    var unitName = '';
                    var delButton = staff.steps.indexOf('3') > -1 ? '<td><button class="delete-motion" id="del' + v + '">X</button></td>' : '';
                    if (['审核', '登记'].indexOf(c[v]['当前环节']) > -1)unitName = '市政协办提案委';
                    if ('交办' == c[v]['当前环节'])unitName = c[v]['交办单位'] || '市政府督查室';
                    if (['办理', '反馈'].indexOf(c[v]['当前环节']) > -1)unitName = c[v]['主办单位'] || '';
                    var listContent = '<tr class="list-content">' +
                        '<td>' + (myCount++) +
                        '<td><input type="checkbox" class="check" value=' + v + '></td>' +
                        '<td>' + c[v]['编号'] + '</td>' +
                        '<td>' + (c[v]['案号'] || '') + '</td>' +
                        '<td>' + (c[v]['提案人'] || '') + '</td>' +
//                            '<td>' + c[v]['案别'] + '</td>' +
                        '<td class="motion-select" id="' + v + '"><a href="#">' + c[v]['案由'] + '</a></td>' +
                        '<td>' + (c[v]['性质类别' + category] || '') + '</td>' +
                        '<td><a href="' + (c[v]['原文'] || '#') + '">附件</a></td>' +
                        '<td>' + (c[v]['当前环节'] || '') + '</td>' +
                        '<td>' + unitName + '</td>' +
                        '<td style="white-space: nowrap;text-overflow: clip; overflow: hidden">' + (c[v]['协办单位'] || '') + '</td>' +
                        delButton +
                        '</tr>';
                    $('.list-table').append(listContent);
                }


            });
        }
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
var searchAttrName;
var searchAttrType;
//搜索脚本
$('.search').click(function () {
    searchAttrName = $(this).data('filter');
    searchAttrType = $(this).data('type');
    $('.search-input').attr('placeholder', $(this).text() + '搜索');
    $('.search-input').val('');
    $('.search-container').show();
//        alert(attrName);
});
$('.search-button').click(function () {
    var input = $('.search-input');
    if ($.trim(input.val())) {
        delete filter.multiple_search;
        filter.search = {attr_name: searchAttrName, attr_value: input.val(), attr_type: searchAttrType};
        if ($(this).hasClass('inner'))filter.search.motion_id_limit = motionIdLimit;
        reflashList(orderby, page, order);
    }
    $('.search-mask').click();

});

$('.search-mask').click(function () {
//        delete filter.search;
    $('.search-container').hide();
})