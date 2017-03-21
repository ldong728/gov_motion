<?php
/**
 * Created by PhpStorm.
 * User: godlee
 * Date: 2015/10/29
 * Time: 10:50
 */
include_once '../includePackage.php';
session_start();

if (isset($_SESSION['login']) && DOMAIN == $_SESSION['login']) {
    if (isset($_GET['menu']) && array_key_exists($_GET['menu'], $_SESSION['pms'])) {
        if(isset($_GET['get_editor'])){
            $channel = pdoQuery('gd_channel',array('cha_id'),array('cha_code'=>$_GET['sub']),' limit 1');
            if($channelId=$channel->fetch()){
                $_GET['cha_id']=$channelId['cha_id'];
            }
            $articleId=$_GET['get_editor'];
            if($articleId){
                $articleInf=pdoQuery('gd_article',null,array('art_id'=>$articleId),' limit 1');
                $articleInf=$articleInf->fetch();
            }else{
                $articleInf=null;
            }
//            alert('ok');
            printAdminView('admin/view/editor.html.php','编辑');
            exit;
        }
        if(isset($_GET['get_goods_editor'])){
            $channel = pdoQuery('gd_channel',array('cha_id'),array('cha_code'=>$_GET['sub']),' limit 1');
            if($channelId=$channel->fetch()){
                $_GET['cha_id']=$channelId['cha_id'];
            }
            $articleId=$_GET['get_goods_editor'];
            if($articleId){
                $articleInf=pdoQuery('gd_article',null,array('art_id'=>$articleId),' limit 1');
                $articleInf=$articleInf->fetch();
                $imgList=explode(',',$articleInf['art_more_img']);
                if(!$imgList)$imgList=array();
            }else{
                $articleInf=null;
                $imgList=array();
            }
//            alert('ok');
            printAdminView('admin/view/goods_editor.html.php','编辑');
            exit;
        }
        if(isset($_GET['get_activities_editor'])){
            $channel = pdoQuery('gd_channel',array('cha_id'),array('cha_code'=>$_GET['sub']),' limit 1');
            if($channelId=$channel->fetch()){
                $_GET['cha_id']=$channelId['cha_id'];
            }
            $articleId=$_GET['get_activities_editor'];
            if($articleId){
                $articleInf=pdoQuery('gd_article',null,array('art_id'=>$articleId),' limit 1');
                $articleInf=$articleInf->fetch();
                $imgList=explode(',',$articleInf['art_more_img']);
                if(!$imgList)$imgList=array();
            }else{
                $articleInf=null;
                $imgList=array();
            }
//            alert('ok');
            printAdminView('admin/view/activities_edit.html.php','编辑');
            exit;
        }
        if(isset($_GET['edit_article'])){
            mylog('get get:'.getArrayInf($_GET));
            mylog('get post'.getArrayInf($_POST));
            foreach ($_POST as $k => $v) {
                if('art_more_img'==$k)$v=trim($v,',');
                $value[$k]=addslashes($v);
            }
            $value['art_add_time']=time();
            $id=pdoInsert('gd_article',$value,'update');
            $value['art_id']=$id;
            $articleInf=$value;
            if($_GET['rediract']){
                mylog('header to');
                header('location: index.php?menu='.$_GET['menu'].'&sub='.$_GET['sub']);
                exit;
            }
            printAdminView('admin/view/editor.html.php','编辑');
            exit;
        }
    }
    //公众号操作


    exit;
}
header('location:index.php');

exit;

