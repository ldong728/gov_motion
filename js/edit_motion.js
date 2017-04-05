var antiDouble=false;
var timeSet=setTime();
//getFuyiCount();
//decodeDate( $('.encoded-data'));
$(document).ready(function(){

});
//以下代码作废
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
//以上代码作废



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
                    parent.find('.attachment-file').attr('href',v.url);
                    parent.find('.attachment-file').text(v.originalName);
                    antiDouble=false;
                }
                if(1== v.step){
                    console.log(v);
                    var area=$('.motion-name-area').find('textarea');
                    if(''==area.val())area.text(v.originalName);
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
$(document).on('click','.mutiple-input',function(){
    var _=$(this);
    var f=_.parents('.update-value');
    var state= _.prop("checked");
    var attid= _.attr('id');
    console.log(attid);
    if(!state){
        if(attid){
            ajaxPost('ajaxDeleteAttr',{id:attid},function(data){

            });
        }else{
            _.removeClass('attr-value')
        }
    }else{
        _.addClass('attr-value');
    }
    //if()
    //console.log(state);
});

//弹出选择框的方法
$(document).on('click','.target-select',function(){
    if($('.target-value-selecter').length>0)return;
    var _=$(this);
    var f= _.parent();
    var target= _.data('target');
    var multiple= f.data('multiple');
    var selecterName= f.prev('th').text();
    var existValue=[];
    f.addClass('target-value-selecter');
    $.each(f.find('.pre-delete'),function(k,v){
        var id=$(v).prev('.added-value').val();
        var attrId=$(v).attr('id');
       existValue.push({id:id,name:$(v).text(),attrId:attrId});
    });

    getTargetList(target,null,function(back){
        var listData=backHandle(back);
        console.log($(listData).length);
        //console.log(listData);
        $('.selecter-content').empty();
        var listContent='';
        var chosenContent='';
        //填充待选项
        $.each(listData,function(k1,v1){
            $.each(v1,function(k2,v2){
                listContent+='<ul><li class="li-1 clearfix">'+
                '<button class="btn-1 main-candidate-btn" type="button"></button>'+
                    '<input class="checkbox candidate super" type="checkbox" name="checkbox-lv1" value="'+v2.id+'">'+
                        '<button class="btn-2" type="button"></button>'+
                        '<span class="span-1 candidate-name">'+v2.name+'</span>'+
                    '</li>';
                if(v2.sub){
                    listContent+='<li class="li-2"><ul>';
                    $.each(v2.sub,function(k3,v3){
                        listContent+='<li class="li-lv2 main-candidate clearfix">'+
                        '<button class="btn-lv2-1" type="button"></button>'+
                            '<input class="checkbox candidate sub" type="checkbox" name="checkbox-lv2" value="'+v3.id+'">'+
                                '<button class="btn-lv2-2" type="button"></button>'+
                                '<span class="span-1 candidate-name">'+v3.name+'</span>'+
                            '</li>'
                    });
                    listContent+='</li></ul>'
                }

                listContent+='</ul>';
            });

        });
        listContent+='';
        $('.selecter-content').append(listContent);
        //填充已选项
        $('.target-chosen-ul').empty();
        $.each(existValue,function(k,v){
            var attrIdContent='';
            if(v.attrId)attrIdContent='<input type="hidden" class="exist-attr-id" value="'+ v.attrId+'">';
            chosenContent+='<li class="clearfix">'+attrIdContent+
            '<input class="checkbox exist" type="checkbox" name="checkbox-lv1" value="'+ v.id+'">'+
            '<span class="span-1 exist-name">'+ v.name+'</span>'+
            '</li>'
        });
        $('.target-chosen-ul').append(chosenContent);
        $('.multiple-type').val(multiple);
        $('.target-name').text('请选择'+selecterName);
        showSelectView($('.unit'));
    });
});

$(document).on('click','.candidate',function(){
    console.log('candidate');
    var _=$(this);
    var chosen=_.prop('checked');
    console.log(Boolean(0==_.val()));
    console.log(_.hasClass('super'));
    if(0==_.val()&& _.hasClass('super')){
        console.log('sub');
        var fUl= _.parents('ul');
        fUl.find('.sub').prop('checked',chosen);
    }
});
//点击选择框中的选择按钮
$(document).on('click','.target-choose',function(){
    var multiple=$('.multiple-type').val();
    var chosenList={};
    var existContent='';
    $.each($('input.exist'),function(k,v){
        var _=$(v);
        var attrInf=_.prev('input.exist-attr-id')
        var name= _.nextAll('.exist-name').text();
        chosenList[name]={id: _.val(),name:name};
        if(attrInf.length>0)chosenList[name].attrId=attrInf.val();
    });
    //多值情况
    if(1==multiple){
        $.each($('input.candidate'),function(k,v){
            var _=$(v);
            var name= _.nextAll('.candidate-name').text();
            if(_.prop('checked')&& 0!=_.val()){
                if(!chosenList[name])chosenList[name]={id: _.val(),name:name};
            }
        });

    }else{//单值情况
        var valueCount=0;
        $.each($('input.candidate'),function(k,v){
            if(valueCount>0)return false;
            var _=$(v);
            var name= _.nextAll('.candidate-name').text();
            if(_.prop('checked')&& 0!=_.val()){
                chosenList={};
                chosenList[name]={id: _.val(),name:name};
                valueCount++;
            }
            console.log('reached');

        });
    }
    $.each(chosenList,function(k,v){
        var attrIdContent='';
        if(v.attrId)attrIdContent='<input type="hidden" class="exist-attr-id" value="'+ v.attrId+'">';
        existContent+='<li class="clearfix">'+attrIdContent+
        '<input class="checkbox exist" type="checkbox" name="checkbox-lv1" value="'+ v.id+'">'+
        '<span class="span-1 exist-name">'+ v.name+'</span>'+
        '</li>'
    });
    //console.log(chosenList);
    $('.target-chosen-ul').empty();
    $('.target-chosen-ul').append(existContent);




});
//点击选择框中的删除按钮
$(document).on('click','.chosen-delete',function(){
    $.each($('input.exist'),function(k,v){
        var _=$(v);
        var name= _.nextAll('.exist-name').text();
        if(_.prop('checked')&& _.val()){
            //已写入数据库的
            if(_.prev('input.exist-attr-id').length>0){
                ajaxPost('ajaxDeleteAttr',{id:_.prev('input.exist-attr-id').val()},function(data){

                });
            }
            _.parent().remove();
        }
    });
});
//点击加号按钮
$(document).on('click','.main-candidate-btn',function(){
    var _=$(this);
    var fUl= _.parents('ul');
    _.toggleClass('btn-change-bg');
    fUl.find('.main-candidate').slideToggle('fast');
});

$(document).on('click','.close-unit',function(){
    $('.target-value-selecter').removeClass('target-value-selecter');
   $('.unit').hide();
});
$(document).on('click','.chosen-confirm',function(){
    var content='';
    var valuePlace=$('.target-value-selecter');
    var multiple=$('.multiple-type').val();
    if(multiple){

        $.each($('input.exist'),function(k,v){
            var _=$(v);
            var key= _.val();
            var name= _.nextAll('.exist-name').text();
            var attrId= _.prev().val();
            console.log(Boolean(key));
            if(attrId){
                content+='<span class="pre-delete attr-value" id="'+attrId+'">' + name + '</span>';
            }else{
                console.log(key);
                content+='<input type="hidden" class="added-value attr-value" value="'+key+'"><span class="pre-delete">' + name + '</span>';
            }
        });
        valuePlace.children('.target-select').prevAll().remove();
        valuePlace.children('.target-select').before(content);

    }else{
        $.each($('input.exist'),function(k,v){
            var _=$(v);
            var key= _.val();
            var name= _.nextAll('.exist-name').text();
            content='<input type="hidden" class="attr-value" value="'+key+'"><span>' + name + '</span>'
        });
        if(content){
            valuePlace.children('.target-select').prevAll().remove();
            valuePlace.children('.target-select').before(content);
        }
    }

    $('.target-value-selecter').removeClass('target-value-selecter');
    $('.unit').hide();


});


function showSelectView(element){
    var width=document.documentElement.clientWidth;
    var height=document.documentElement.clientHeight;
    element.css('left',(width/2-360));
    element.css('top',(height/2-365));
    element.show();

}
function getTargetList(target,filter,callback){
    var sTarget=target;
    var sFilter=filter||{};
    ajaxPost('ajaxTargetList',{target:target,filter:sFilter},callback)
}
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
        //console.log(_.text());
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
                    if(1==data.multiple){
                        $.each(data.option,function(k,v){
                            var checked='';
                            var attrId='';
                            if(data.multiple_value && $(data.multiple_value).length > 0){
                                $.each(data.multiple_value,function(id,cnt){
                                    if(v==cnt){
                                        checked='checked="checked"';
                                        attrId='id="'+id+'"';
                                    }
                                })
                            }else{
                            }
                           content+='<label ><input class="mutiple-input" style="width: 20px" type="checkbox" value="'+k+'" '+checked+' '+attrId+'>'+v+'</label></br>'
                        });
                    }else{
                        var isValue= data.target?'':'attr-value';
                        content+='<select class="'+ data.class+' '+ isValue+'">';
                        $.each(data.option,function(k,v){
                            var selected=v==data.content?'selected="selected"':'';
                            content+='<option value="'+ k+'" '+selected+'>'+v+'</option>';
                        });
                        content+='</select>';
                    }
                    //if (1 == data.multiple && data.multiple_value && data.multiple_value.length > 0) {
                    //    $.each(data.multiple_value, function(id, value){
                    //        content += '<span class="pre-delete attr-value" id="'+value.attr_id+'">' + value.content + '</span>'
                    //    });
                    //}
                    //if($(data.option).length>0){//非人员录入选项
                    //    var isValue= data.target?'':'attr-value';
                    //    content+='<select class="'+ data.class+' '+ isValue+'">';
                    //    $.each(data.option,function(k,v){
                    //        var selected=v==data.content?'selected="selected"':'';
                    //        content+='<option value="'+ k+'" '+selected+'>'+v+'</option>';
                    //    });
                    //    content+='</select>';
                    //}else{//人员录入选项
                    //    content+='<button class="select-duty" data-motionattr="'+data.attr_template+'">选择</button>';
                    //}

                }else if(data.target){
                    if(1==data.multiple){
                        if($(data.multiple_value).length > 0){
                            $.each(data.multiple_value, function(id, value){
                                content += '<span class="pre-delete attr-value" id="'+id+'">' + value + '</span>'
                            });
                        }
                        content+='<button class="target-select" data-target="'+data.target+'">添加</button>'
                    }else{
                        if(data.content)content+='<input type="hidden" class="attr-value" value="'+data.content_int+'"><span>' + data.content + '</span>';
                        content+='<button class="target-select" data-target="'+data.target+'">选择</button>'
                    }
                }
                else if(data.has_attachment>0){
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
    console.log(data);

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
