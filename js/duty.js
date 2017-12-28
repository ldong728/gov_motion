var searchAttrName,searchAttrType;
var dutyUnitSelectReady=false;
reflashDutyList();
$(document).on('click','.duty-manager',function(){
    //alert('ok');
    //console.log({category:category,meeting:meetingId});
    ajaxPost('get_duty_manager_view',{category:category,meeting:meetingId},function(back){
        //$('#genetable_tableData').empty();
        //console.log(back);
        $('#genetable_tableData').html(back);
    })
});
$(document).on('click','.modify-btn',function(){
    var id=$(this).attr('id').slice(3);
    if($(this).hasClass('modify-done')){
        altDuty(id);
        $(this).text('修改');
        $(this).removeClass('modify-done');
    }else{
        $(this).addClass('modify-done');
        $(this).text('确认修改');
        $.each($('#row'+id).find('.can-modify'),function(k,v){
            var element=$(v);
            var type=element.data('type');
            var field=element.data('field')
            var value=element.text();
            var content='';
            switch(type){
                case 'value':
                    content='<input class="modify-value" data-field="'+field+'" type="text" value="'+value+'">';
                    break;
                case'unit':
                    content='<select class="modify-value unit-select" data-field="'+field+'">';
                    $.each(userUnit,function(k,v){
                        var checked= value== v.unit_name?'selected':''
                        content+='<option value="'+ v.user_unit_id+'" '+checked+'>'+v.unit_name+'</option>';
                    });
                    content+='</select>';
                    break;
                case'group':
                    content='<select class="modify-value group-select" data-field="'+field+'">';
                    $.each(userGroup,function(k,v){
                        var checked= value== v.group_name?'selected':'';
                        content+='<option value="'+ v.user_group_id+'" '+checked+'>'+v.group_name+'</option>';
                    });
                    content+='</select>';
                    break;
                    break;
            }
            //console.log(content);
            element.html(content);
            //console.log(value);
        });
    }


});
$('.search').click(function () {
    searchAttrName = $(this).data('filter');
    searchAttrType = $(this).data('type');
    $('.search-input').attr('placeholder', $(this).text() + '搜索');
    $('.search-input').val('');
    $('.search-module').show();
});
$('.search-mask').click(function () {
    $('.search-container').hide();
})
$(document).on('click','.activity-btn',function(){
    var id=$(this).attr('id').slice(3);
    var name=$('#row'+id).find('.user-name').text();
    if(confirm('确定要删除 '+name+' 资格吗？')){

        var thisButton=$(this);
        var activity=parseInt($(this).data('activity'));
        activity=activity?0:1;
        var activityName=activity?'启用':'删除';
        ajaxPost('ajax_activity_duty',{id:id,activity:activity},function(back){
            if(backHandle(back)){
                reflashDutyList();
            }
        });
        console.log('id:'+id+', activity:'+activity);
    }

});
$(document).on('click','.create-user',function(){
    initDutyUnitSelect();
    $('.add-duty-module').show();
   //alert('功能暂时禁用中');
});
$(document).on('click','.create-user-submit',function(){
    var updateValue={user:{category:category},duty:{category:category,meeting:meetingId,activity:1}};
    var isFull=true;
    var unit=parseInt($('.unit-select').val());
    var group=parseInt($('.group-select').val());

    $('.duty-inf-input').each(function(k,v){
        if(!$(v).val())isFull=false;
        updateValue.user[$(v).data('field')]=$(v).val();
    });
    isFull=unit||group;
    if(isFull){
        updateValue.duty.user_unit=unit;
        updateValue.duty.user_group=group;
        console.log(updateValue);
        ajaxPost('ajaxAddDuty',updateValue,function(data){
            var backValue=backHandle(data);
            if(backValue){
                console.log(backValue);
                alert('修改完成');
                reflashDutyList();
                $('.search-container').hide();
            }else{
                alert('数据库错误');
            }
        });
    }else{
        alert('数据不全');
    }

});

//人大选择中心组后自动匹配代表团
$(document).on('change','.unit-select',function(){
   if(1==category){
       var unit=$(this).val();
       ajaxPost('ajaxGetGroupFromUnit',{unit:unit},function(data){
           var backValue=backHandle(data);
           if(backValue){
               $('.group-select').val(backValue);
           }
       })
   }
});

function altDuty(id){
    var canSubmit=true;
    var submitData={duty_id:id};
    $('#row'+id).find('.modify-value').each(function(k,v){
        var field=$(v).data('field');
        var value=$(v).val();
        if(!value){
            canSubmit=false;
            return false;
        }
        submitData[field]=value;
    });
    //console.log(submitData);
    //return;
    ajaxPost('ajaxAltDuty',submitData,function(back){
        reflashDutyList();
    });

}
function reflashDutyList(){
    ajaxPost('get_duty_manager_view',{category:category,meeting:meetingId,page:page,count:count,filter:filter},function(back){
        //$('#genetable_tableData').empty();
        //console.log(back);
        $('#genetable_tableData').html(back);
    })
}
function initDutyUnitSelect(){
    if(!dutyUnitSelectReady){
        $.each(userUnit,function(k,v){
            $('.unit-select').append('<option value="'+ v.user_unit_id+'">'+ v.unit_name+'</option>')
        });
        $.each(userGroup,function(k,v){
            $('.group-select').append('<option value="'+ v.user_group_id+'">'+ v.group_name+'</option>')
        });
        dutyUnitSelectReady=true;
    }
}
