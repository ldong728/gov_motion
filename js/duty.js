var searchAttrName,searchAttrType;
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
    $('.search-container').show();
//        alert(attrName);
});
$(document).on('click','.activity-btn',function(){
   alert('功能暂时禁用中') ;
});
$(document).on('click','.create-user',function(){
   alert('功能暂时禁用中');
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