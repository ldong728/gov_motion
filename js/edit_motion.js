var antiDouble=false;
var timeSet=setTime();
//console.log(staff);
$(document).ready(function(){

});

$(document).on('click','.pre-delete',function(){
   var _=$(this);
    var id= _.attr('id');
    if(id){
        ajaxPost('ajaxDeleteAttr',{id:id},function(data){
            var value=backHandle(data);
            console.log(value);
            if(value)_.remove();
            getFuyiCount();
        });
    }else{
        _.prev('.added-value').remove();
        _.remove();
        getFuyiCount();
    }
   //alert(_.attr('id'));
});
$(document).on('click','.choose-file',function(){
    if(!antiDouble){
        antiDouble=true;
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
    var url='upload.php?attachment=1&ma='+motionAttr+'&at='+attrTemplate+'&a='+attrId+'&t='+attrType;
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
                    parent.find('.attachment-file').attr('data-href',v.url);
                    parent.find('.attachment-file').text(v.originalName);
                    antiDouble=false;
                }else{
                    parent.find('.attachment-file').attr('data-href',v.url);
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
    var href=$(this).data('href');
    try{
        var openDocObj=new ActiveXObject("sharePoint.OpenDocuments.2")||'';
        openDocObj.EditDocument(protocol+'//'+host+'/'+href);
    }catch(err){
        console.log(err);
        if(confirm('您使用的浏览器不支持word在线编辑插件，附件将以下载方式保存至您的电脑')){
            console.log(window.location);
            console.log(document.domain);
            location.href=href;
        }
    }




});
$(document).on('click','.submit-attr',function(){
    submitAtrrs(1, function (data) {
        var back=backHandle(data);
        if(staff.steps.indexOf(String(back.step))>-1){
            console.log(staff);
            ajaxPost('editMotion',{id:back.id},function(data) {
                $('.m-popup').html(data);
                mPopup();
            });
        }else{
            closePopUp($('.m-popup'));
            window.location.reload(true);
        }
    })
});
$(document).on('click','.save-attr',function(){
    submitAtrrs(0,function(data){
        closePopUp($('.m-phpup'));
           window.location.reload(true);
    }) ;
});
$(document).on('click','.motion-reject',function(){
    submitAtrrs(-1,function(data){
        var back=backHandle(data);
        if(staff.steps.indexOf(String(back.step))>-1){
            console.log(staff);
            ajaxPost('editMotion',{id:back.id},function(data) {
                $('.m-popup').html(data);
                mPopup();
            });
        }else{
            closePopUp($('.m-popup'));
            window.location.reload(true);
        }
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
    //testcode
    //showSelectView($('.unit'));
    //return;

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
        //console.log($(listData).length);
        //console.log(listData);
        $('.selecter-content').empty();
        var listContent='';
        var chosenContent='';
        //填充待选项
        $.each(listData,function(k1,v1){

            var value1=v1.list||v1;
            var hidden=v1.list?'style="display:none"':'';
            listContent+=v1.list?'<div class="nav-tab"><h2 class="main-category"><i class="icon icon-chevron-right"></i>'+v1.name+'</h2>':'';
            $.each(value1,function(k2,v2){
                listContent+='<ul '+hidden+'><li class="li-1 clearfix">'+
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
            listContent+=v1.list?'</div>':'';

        });
        //listContent+='';
        //console.log(listContent);
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
$(document).on('click','.main-category',function(){
    var _=$(this);
    _.children('i').toggleClass('icon-chevron-down');
    var uls= _.nextAll('ul');
    uls.slideToggle('fast');
});

$(document).on('click','.candidate',function(){
    //console.log('candidate');
    var _=$(this);
    var chosen=_.prop('checked');
    //console.log(Boolean(0==_.val()));
    //console.log(_.hasClass('super'));
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
    judgeMotionType();
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
            //console.log(Boolean(key));
            if(attrId){
                content+='<span class="pre-delete attr-value" id="'+attrId+'">' + name + '</span>';
            }else{
                //console.log(key);
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
    judgeMotionType();
    getFuyiCount();

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
                }else if(data.target){
                    if(1==data.multiple){
                        if($(data.multiple_value).length > 0){
                            $.each(data.multiple_value, function(id, value){
                                content += '<span class="pre-delete attr-value" id="'+id+'">' + value + '</span>'
                            });
                        }
                        content+='<button class="target-select" data-target="'+data.target+'">添加</button>'
                    }else{
                        if(data.content)content+='<input type="hidden" class="attr-value" value="'+data.content_int+'"><span class="single-value">' + data.content + '</span>';
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
                    content+='<a href="'+data.attachment+'">'+(data.content||'')+'</a>'
                }else{
                    content+=data.content||'';
                }
            }
            parent.append(content);
        }

    });
}
function submitAtrrs(step,callback) {

    var sStep=step||0;
    if(sStep>0){
        var verifyData=inputVerify();
        if(verifyData.length>0){
            console.log(verifyData);
            alert(verifyData[0].content);
            return;
        }

    }
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
/**
 * 政协自动变更提案性质类别
 */
function judgeMotionType(){
    var selecter=$('.judged-value').children('select');
    if($('.user-type').length>0&&selecter.length>0){
        var _=$('.user-type');
        var attrValue= _.find('.attr-value');
        //var preDelete= _.find('.pre-delete');
        //console.log(preDelete);
        if(attrValue.length>1){
            //console.log('联名');
            selecter.val('联名提案');
            return;
        }else if(0==attrValue.length){
            selecter.val('委员');
        }else{
           if(attrValue.val()){
               ajaxPost('ajaxUserInf',{id:attrValue.val()},set);
           }else{
               ajaxPost('ajaxUserInfFromAttrTbl',{attrId:attrValue.attr('id')},set);
           }
        }
    }
    function set(data){
        //console.log(data);
        var back=backHandle(data);
        //console.log(back);
        if('0'!=back.user_unit&&'0'!=back.user_group){
            selecter.val('委员');
        }else{
            selecter.val('党派团体');
        }
    }
}
/**
 * 表单校验
 */
function inputVerify(){
    var errorlist=[];
    var passVerify=$('.pass-verify').find('.attr-value');
    if(passVerify.length>0&&'立案'!=passVerify.val()){
        return errorlist;
    }

    $.each($('.verify-value'),function(k,v){
        var _=$(v);
        var valueInput=_.find('.attr-value');
        var inputButton= _.find('.target-select');
        var value= _.find('.attr-value').val()||'';
        var handleValue= _.find('.handle-value');
        var attrType= _.data('type');
        var valueName= _.prev().text();


        if('attachment'!=attrType){
            if(inputButton.length>0){
                if(0== _.find('.pre-delete').length&&0==_.find('.single-value').length){
                    errorlist.push({name:valueName,content:valueName+"不能为空"})
                }

            }
            if(valueInput.length>0&&0==inputButton.length){
                if(!value||!Boolean(value.trim())){
                    //console.log(value);
                    errorlist.push({name:valueName,content:valueName+"不能为空"})
                }else{
                    if('int'==attrType&&!value.match(/^-?[1-9]\d*$/)){
                        errorlist.push({name:valueName,content:valueName+"必须为整数"});
                    }
                }
            }
        }else{//附件
            //var attachmentFile=_.find('.attachment-file').data('href');
            var attachment= _.find('.attachment-file').data('href');
            if('#'==attachment||'null'==attachment||!attachment){
                errorlist.push({name:valueName,content:valueName+"未上传"})
            }
        }
        if (handleValue.length > 0) {
            var value = handleValue.val().trim();
            var type = handleValue.attr('type');
            if (!value) {
                errorlist.push({name: valueName, content: valueName + "不能为空"});
            } else {
                if (!value.match(/^-?[1-9]\d*$/) && 'tel' == type)errorlist.push({
                    name: valueName,
                    content: valueName + "必须为电话号码"
                });
            }
        }
    });
    var handlerAttachment = $('.upload-handler-file').nextAll('.handle-attachment-file');

    if (handlerAttachment.length > 0 && !handlerAttachment.attr('href')){
        var handlertAtachmentName=$('.upload-handler-file').parent().prev().text();
        errorlist.push({
            name: handlertAtachmentName,
            content: handlertAtachmentName + "未上传"
        });
    }

    return errorlist;
}
