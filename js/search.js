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
$(document).on('click','.multiple-search',function(){
    var maskHeight = $(document.body).height();
    ajaxPost('unsetCurrentMotion',{});
    ajaxPost('searchMotionView',{category:category,meeting:meetingId},function(data){
        $('.m-popup').html(data);
        $('.m-popup').show();
        $('.mask').show();
        $('.mask').css('height',maskHeight);
        mPopup();
    });
});
$(document).on('click','.start-multiple-search',function(){
    delete filter.search;
    filter.multiple_search={};
    var multipleSearchData={};
    $('.search-key').each(function(k,v){
       var _=$(v);
        var motionAttr= _.data('motionattr')||false;
        var type= _.data('type');
        var multiple= _.data('multiple')||false;
        var searchValueContainer= _.find('.search-value');
        var otherValueContainer= _.find('.attr-value');
        var value= _.find('.search-value').val();
        var otherValue= _.find('.attr-value').val();
        //console.log(otherValue);
        value='0'==value?false:value;
        //console.log(motionAttr);
        //console.log(value);
        if(motionAttr){
            if(multiple){
                if(searchValueContainer.length>0){
                    searchValueContainer.each(function(id,element){
                       var value=$(element).val();
                        if(!$(element).prop('checked'))return;
                        if(!multipleSearchData[motionAttr]){
                            multipleSearchData[motionAttr]={motionAttr:motionAttr,type:type,value:[value]}
                        }else{
                            multipleSearchData[motionAttr].value.push(value);
                        }
                    });
                }else{
                   otherValueContainer.each(function(id,element){
                        var value=$(element).val();
                        if(!multipleSearchData[motionAttr]){
                            multipleSearchData[motionAttr]={motionAttr:motionAttr,type:type,value:[value]}
                        }else{
                            multipleSearchData[motionAttr].value.push(value);
                        }
                    });
                }
            }else{
                if(value)multipleSearchData[motionAttr]={motionAttr:motionAttr,type:type,value:value};
                if(otherValue) multipleSearchData[motionAttr]={motionAttr:motionAttr,type:type,value:otherValue}
            }
        }


    });
    filter.multiple_search=multipleSearchData;

    console.log(multipleSearchData);
    $('.close-popup').click();

    reflashList(orderby,page,order);


});
function decodeSearchDate(element) {
    //console.log('become Decode');
    element.each(function (key, subElement) {
        var _ = $(subElement);
        var parent = _.parent();
        //console.log(_.text());
        var data = eval('(' + _.text() + ')');//将数据转化为JS对象
        if (data) {
            //console.log(data);
            var content = '';
            parent.children('span').remove();
            if (true) {//选项可编辑
                //console.log(data);
                parent.addClass('search-key');
                parent.attr('data-type', data.value_type);
                parent.attr('data-motionattr', data.motion_attr_id);
                parent.attr('data-multiple', data.multiple);
                if (data.option) {
                    parent.attr('data-type', 'option');
                    //同一属性有多值的情况
                    if (1 == data.multiple) {
                        $.each(data.option, function (k, v) {
                            content += '<label ><input class="search-value multiple-check" style="width: 20px" type="checkbox" value="' + v + '" >' + v + '</label></br>'
                        });
                    } else {
                        var isValue = data.target ? '' : 'search-value';
                        content += '<select class="' + (data['class']) + ' ' + isValue + '">';
                        $.each(data.option, function (k, v) {
                            content += '<option value="' + v + '">' + v + '</option>';
                        });
                        content += '</select>';
                    }
                } else if (data.target) {
                    if (1 == data.multiple) {
                        if ($(data.multiple_value).length > 0) {
                            $.each(data.multiple_value, function (id, value) {
                                content += '<span class="pre-delete search-value" id="' + id + '">' + value.content + '</span>'
                            });
                        }
                        content += '<button class="target-select" data-target="' + data.target + '">添加</button>'
                    } else {
                        if (data.content)content += '<input type="hidden" class="search-value" value="' + data.content_int + '"><span class="single-value">' + data.content + '</span>';
                        content += '<button class="target-select" data-target="' + data.target + '">选择</button>'
                    }
                }
                else if ('time' == data.value_type) {
                    content += '<input type="hidden" class="search-value" value="1"><span class="time-display"></span>';
                } else {
                    if ('string' == data.value_type) {
                        content += '<textarea class="search-value">' + (data.content || '') + '</textarea>';
                    } else {
                        content += '<input type="text" class="search-value" value="' + (data.content || '') + '" width="20px">';
                    }

                }
            } 

            parent.append(content);
        }


    });
    $('select').append('<option value="0" selected></option>');
}