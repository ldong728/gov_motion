
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

    }else{
        $.each($('#row'+id).find('.can-modify'),function(k,v){
            var element=$(v);
            var type=element.data('type');
            var field=element.data('')
            var value=element.text();
            var content='';
            switch(type){
                case 'value':
                    content='<input data-field="" type="text" value="'+value+'">';
                    break;
                case'unit':
                    content=eval('('+'<select'+')')
                    break;
                case'group':

                    break;
            }
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