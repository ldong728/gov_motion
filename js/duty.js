
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
    //$(this).addClass('modify-done');
    var id=$(this).attr('id').slice(3);
    if($(this).hasClass('modify-done')){

        $(this).text('修改');
        $(this).removeClass('modify-done');
    }else{
        $(this).addClass('modify-done');
        $(this).text('确认修改');
        $.each($('#row'+id).find('.can-modify'),function(k,v){
            var element=$(v);
            var type=element.data('type');
            var field=element.data('')
            var value=element.text();
            var content='';
            switch(type){
                case 'value':
                    content='<input data-field="'+field+'" type="text" value="'+value+'">';
                    break;
                case'unit':
                    content='<select class="unit-select">';
                    $.each(userUnit,function(k,v){
                        var checked= value== v.unit_name?'selected':''
                        content+='<option value="'+ v.user_unit_id+'" '+checked+'>'+v.unit_name+'</option>';
                    });
                    content+='</select>';
                    break;
                case'group':
                    content='<select class="group-select">';
                    $.each(userGroup,function(k,v){
                        var checked= value== v.group_name?'selected':''
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

function reflashDutyList(){
    ajaxPost('get_duty_manager_view',{category:category,meeting:meetingId,page:page,count:count,filter:filter},function(back){
        //$('#genetable_tableData').empty();
        //console.log(back);
        $('#genetable_tableData').html(back);
    })
}