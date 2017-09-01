var browser=navigator.appName;
var b_version=navigator.appVersion;
console.log(navigator);
console.log('browser name: '+browser);
console.log('browser version: '+parseInt(b_version.slice(0,1)));

if('Microsoft Internet Explorer'==browser){
    if(parseInt(b_version.slice(0,1))<5){
        if(confirm('您当前的浏览器版本过低，运行时可能导致不可预知的错误，请使用IE9.0以上浏览器、火狐浏览器（firefox）或谷歌浏览器（chrome），点击确定将下载最新版火狐')){
            location.href="http://download.firefox.com.cn/releases-sha2/stub/official/zh-CN/Firefox-latest.exe";
        }else{

        }
    }
}

function showToast(str){
    $('.toast').empty();
    $('.toast').append(str)
    $('.toast').fadeIn('fast')
    var t = setTimeout('$(".toast").fadeOut("slow")', 800);
}
function loading(){
    $('.loading').show();
}
function stopLoading(){
    $('.loading').hide();
}
function backHandle(data){
    var re=eval('('+data+')');
    if(0==re.errcode){
        var state= null==re.data?0:re.data;
        //console.mylog(state);
        return state;
    }else{
        console.log('error: '+re.errmsg);
        return false;
    }
}
function ajaxPost(method,ajaxData,callback){
    $.post('index.php',{ajax:method,ajax_data:ajaxData},callback);
}
function mylog(data){
    console.log(data);
}
function signOut(category){
    ajaxPost('signOut',{},function(data){
        var value=backHandle(data);
        if('ok'==value)location.href='index.php?c='+category;
        else console.log(value);
    });
}