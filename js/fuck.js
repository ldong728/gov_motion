/**
 * Created by Administrator on 2018/4/16.
 */
var browser=navigator.appName;
var b_version=navigator.appVersion;
//console.log(navigator);
//console.log('browser name: '+browser);
//console.log('browser version: '+parseInt(b_version.slice(0,1)));

if('Microsoft Internet Explorer'==browser){
    if(parseInt(b_version.slice(0,1))<5){
        if(confirm('您当前的浏览器版本过低，运行时可能导致不可预知的错误，如您正在使用360浏览器，请切换至“极速模式”；如您在使用IE浏览器，请点击确定，下载最新版火狐浏览器，并用火狐浏览器再次打开本站点')){
            location.href="http://www.firefox.com.cn/download/";
        }else{

        }
    }
}
