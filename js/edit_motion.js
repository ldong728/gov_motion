var antiDouble=false;
var timeSet=setTime();
//getFuyiCount();
//decodeDate( $('.encoded-data'));
$(document).on('change','.duty-group',function(){
    var currentObj=$(this);
    var col=currentObj.get(0).value;
//        alert(col);
    var groupName=currentObj.find('option:selected').text();
    if(col!=0){
        ajaxPost('getUserGroup',{group_type:col},function(data){
            currentObj.nextAll().remove();
            var content='<select class="duty-sub" data-col="user_'+col+'"><option value="0">'+groupName+'</option>';
            var value=backHandle(data);
            $.each(value,function(k,v){
                content+='<option value="'+ v.id+'">'+ v.name+'</option>'
            });
            content+='</select>';
            currentObj.after(content);
        })
    }
});
$(document).on('change','.duty-sub',function(){
    var currentObj=$(this);
    var col=currentObj.data('col');
    var value=currentObj.get(0).value;
    if(0!=value){
        currentObj.nextAll().remove();
        ajaxPost('getUser',{col:col,id:value},function(data){
            var value=backHandle(data);
            if(value.length>0){
                console.log(value);
                var content='<select class="duty-select attr-value">';
                $.each(value,function(k,v){
                    content+='<option value="'+ v.id+'">'+ v.name+'</option>';
                });
                content+='</select>';
                currentObj.after(content);
            }


        });
    }
});
$(document).on('change','.duty-select',function(){
    var _=$(this);
    var attrValue= _.get(0).value;
    var text= _.find('option:selected').text();
    var parent= _.parent();
    if(parent.data('multiple')){
        _.prevAll('.duty-group').before('<input type="hidden" class="added-value attr-value" value="'+attrValue+'"><span class="pre-delete">' + text + '</span>');

    }
});

$(document).on('change','.unit-super',function(){
    var _=$(this);
    var multiple= _.parent().data('multiple');
    var id= _.val();
    if(id>0){
        _.nextAll().remove();
        ajaxPost('getUnit',{id:id},function(data){
            var value=backHandle(data);
            var content='<select class="unit-select attr-value">';

            $.each(value,function(k,v){
                content+='<option value="'+ v.id+'">'+ v.name+'</option>';
            });
            _.after(content);
            if(1==multiple&&1==value.length){
                _.before('<input type="hidden" class="added-value attr-value" value="'+value[0].id+'"><span class="pre-delete">' + value[0].name + '</span>')
            }
        })
    }
});
$(document).on('change','.unit-select',function(){
    var _=$(this);
    var attrValue= _.get(0).value;
    var text= _.find('option:selected').text();
    var parent= _.parent();
    //alert('what');
    if(parent.data('multiple')){
        _.prevAll('.unit-super').before('<input type="hidden" class="added-value attr-value" value="'+attrValue+'"><span class="pre-delete">' + text + '</span>');
    }
});
$(document).on('click','.pre-delete',function(){
   var _=$(this);
    var id= _.attr('id');
    if(id){
        ajaxPost('ajaxDeleteAttr',{id:id},function(data){
            var value=backHandle(data);
            console.log(value);
            if(value)_.remove();
        });
    }else{
        _.prev('.added-value').remove();
        _.remove();
    }
   //alert(_.attr('id'));
});
$(document).on('click','.choose-file',function(){
    if(!antiDouble){
        antiDouble=true;
        //console.log($('.doc-file'));
        //console.log($('.doc-file').length);
        $(this).next('.doc-file').click();
        setTimeout(function(){
            antiDouble=false;
        },1000);
    }

});
$(document).on('change','.doc-file',function(){
    console.log('preUpload');
    var _=$(this);
    var parent=_.parent();
    var motionAttr=parent.data('motionattr');
    if(!motionAttr)return;//
    console.log('upload');
    var attrTemplate=parent.data('attrtemplate');
    var attrId=parent.data('attr');
    var attrType=parent.data('type');
    var fileElementId=_.attr('id');
    var url='upload.php?attachment=1&ma='+motionAttr+'&at='+attrTemplate+'&a='+attrId+'&t='+attrType
    var uploadData={
        url:url,
        secureuri: false,
        fileElementId:fileElementId, //文件上传域的ID
        dataType: 'json', //返回值类型 一般设置为json
        success: function (v, status) {
            //console.log(v);
            if ('SUCCESS' == v.state) {
                if(0==attrId){
                    attrId= v.attrId;
                    parent.attr('data-attr', attrId);
                    parent.find('.attachment-file').attr('href',v.url);
                    parent.find('.attachment-file').text(v.originalName);
                    antiDouble=false;
                }else{
                    alert('ok');
                    parent.find('.attachment-file').attr('href',v.url);
                    parent.find('.attachment-file').text(v.originalName);
                    antiDouble=false;
                }
                //console.log(v);

            } else {
                showToast(v.state);
            }
        },//服务器成功响应处理函数
        error: function (d) {
            alert('error');
        }
    };
    //console.log(uploadData);
    $.ajaxFileUpload(uploadData);
});
$(document).on('click','.attachment-file',function(){
    var protocol=window.location.protocol;
    var host=window.location.host;
    //console.log(window.location.host);
    //console.log(window.location);
    var href=$(this).data('href');
    var openDocObj=new ActiveXObject("sharePoint.OpenDocuments.2");
    openDocObj.EditDocument(protocol+'//'+host+'/'+href);
});

$(document).on('click','.submit-attr',function(){
    submitAtrrs(1, function (data) {
        closePopUp($('.m-popup'));
        window.location.reload(true);
    })
});
$(document).on('click','.save-attr',function(){
    submitAtrrs(0,function(data){
        closePopUp($('.m-phpup'));
           window.location.reload(true);
    }) ;
});
$(document).on('click','.motion-reject',function(){
    if($('.handle-value').length>0){
        return;
    }
    submitAtrrs(-1,function(data){
        closePopUp($('.m-popup'));
        window.location.reload(true);
    });
});
var antiDouble = false;
$(document).on('click','.upload-handler-file',function(){
    antiDouble = true;
    $('#handler-attachment').click();
    setTimeout(function () {
        antiDouble = false;
    }, 1000)
});
$(document).on('change','#handler-attachment',function(){
    var _ = $(this);
    var handlerId = _.parent().attr('id').slice(3);
    if (!handlerId)return;//防范多次触发change事件
    var url = 'upload.php?handler_attachment=' + handlerId;
    fileElementId = _.attr('id')
    var uploadConfig = {
        url: url,
        secureuri: false,
        fileElementId: fileElementId, //文件上传域的ID
        dataType: 'json', //返回值类型 一般设置为json
        success: function (v, status) {
            if ('SUCCESS' == v.state) {
                $('.handle-attachment-file').attr('href', v.url);
                $('.handle-attachment-file').text(v.originalName);
                antiDouble = false;
                console.log(v);
            } else {
                showToast(v.state);
            }
        },//服务器成功响应处理函数
        error: function (d) {
            alert('error');
        }
    };
    $.ajaxFileUpload(uploadConfig);
});
$(document).on('click','.motion-step-inf',function(){
    var maskHeight = $(document.body).height();
    var id=$(this).attr('id');
    ajaxPost('getMotionStepInf',{id:id},function(data){
        $('.m-popup').html(data);
        $('.m-popup').show();
        $('.mask').show();
        $('.mask').css('height',maskHeight);
        mPopup();
    });
});
$(document).on('click','.close-popup',function(){
    closePopUp($('.m-popup'));
    $('.mask').css('display', 'none');
//        window.location.reload(true);
//		$('.mask').css('display','none');
});
function getFuyiCount(){
    var count=0;
    $.each($('.fuyi-count').children('.pre-delete'),function(k,v){
        count++;
    });
    $('.fuyi').text(count);
}


function decodeDate(element) {
    element.each(function (key, subElement) {
        var _ = $(subElement);
        var parent = _.parent();
        console.log(_.text());
        var data = eval('(' + _.text() + ')');//将数据转化为JS对象
        if(data){
            var attr= data.attr_id||0;
            var content='';
            //console.log
            parent.empty();
            //console.mylog(data);
            if (data.edit) {//选项可编辑
                parent.addClass('update-value');
                parent.attr('data-attr',attr);
                parent.attr('data-type',data.value_type);
                parent.attr('data-motionattr',data.motion_attr);
                parent.attr('data-attrtemplate',data.attr_template);
                parent.attr('data-multiple',data.multiple);
                if (data.option) {
                    //同一属性有多值的情况
                    if (1 == data.multiple && data.multiple_value && data.multiple_value.length > 0) {
                        $.each(data.multiple_value, function(id, value){
                            content += '<span class="pre-delete attr-value" id="'+value.attr_id+'">' + value.content + '</span>'
                        });
                    }
                    if($(data.option).length>0){//非人员录入选项
                        var isValue= data.target?'':'attr-value';
                        content+='<select class="'+ data.class+' '+ isValue+'">';
                        $.each(data.option,function(k,v){
                            var selected=v==data.content?'selected="selected"':'';
                            content+='<option value="'+ k+'" '+selected+'>'+v+'</option>';
                        });
                        content+='</select>'
                    }else{//人员录入选项
                        content+='<button class="select-duty" data-motionattr="'+data.attr_template+'">选择</button>';
                    }

                } else if(data.has_attachment>0){
                    var attachmentName=data.attachment?data.content:'';
                    content+=
                        '<button class="button choose-file">选择附件</button>'+
                        '<input type="file" class="doc-file" id="file'+data.motion_attr+'" name="file'+data.motion_attr+'" style="display:none">';
                    content+='<a class="attachment-file" href="#" data-href="'+data.attachment+'">'+attachmentName+'</a>'
                }else if('time'==data.value_type){
                    content+='<input type="hidden" class="attr-value" value="1"><span class="time-display"></span>';
                }else{
                    if('string'==data.value_type){
                        content+='<textarea class="attr-value">'+(data.content||'')+'</textarea>';
                    }else{
                        content+='<input type="text" class="attr-value" value="'+(data.content||'')+'" width="20px">';
                    }

                }
            } else {//选项不可编辑
                if(data.attachment){
                    content+='<a href="'+data.attachment+'">'+data.content+'</a>'
                }else{
                    content+=data.content;
                }
            }
            parent.append(content);
        }

    });
}
function submitAtrrs(step,callback) {
    var sStep=step||0;
    var data={step:sStep,data:[]};
    //console.mylog($('.update-value'));
    $('.update-value').each(function (k, v) {
        var f = $(v);
        var s = f.find('.attr-value');
        var multiple= 1==f.data('multiple');
        var attrType = f.data('type');
        var motionAttr= f.data('motionattr');
        var attrTemplate= f.data('attrtemplate');
        if(multiple){
            $.each(s,function(sk,sv){
                if($(sv).hasClass('duty-select')||$(sv).hasClass('unit-select'))return;
                var attrId = sv.id;
                var value= sv.value;
                data.data.push({
                    attr_id:attrId,
                    attr_type:attrType,
                    motion_attr:motionAttr,
                    attr_template:attrTemplate,
                    value:value
                });
            });
        }else{
            var attrId=f.data('attr')
            var value= s.val();
            data.data.push({
                attr_id:attrId,
                attr_type:attrType,
                motion_attr:motionAttr,
                attr_template:attrTemplate,
                value:value
            });
        }

    });
    if($('.handle-value').length>0){
        data.step=0;
        var handlerMotionId=$('.motion_handler_id').attr('id');
        var handlerData={motion_handler_id:handlerMotionId};
        $('.handle-value').each(function(k,v){
            handlerData[v.id]= v.value;
        });
        data.handler=handlerData;
    }
    //console.mylog(data);

    ajaxPost('updateAttr',data,callback);
}

function setTime(){
    var sDate=new Date();
    $('.time-display').text(sDate.getFullYear()+'-'+(sDate.getMonth()+1)+'-'+sDate.getDate());
    //var sTime=setInterval(function(){
    //    var time=new Date();
    //    $('.time-display').text(time.toDateString(sDate.getFullYear()+'-'+(sDate.getMonth()+1)+'-'+sDate.getDate()));
    //},1000);
    //return sTime;
}
function closePopUp(element){
    //element.remove();
    //element.css('display','none');
    element.empty();
    $('.doc-file').remove();
}
