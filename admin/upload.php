<?php
include_once '../includePackage.php';
include_once 'upload.class.php';
session_start();
if(isset($_SESSION['login'])&&DOMAIN==$_SESSION['login']) {
    if(isset($_FILES['logo-up'])){
        $uploader = new uploader('logo-up');
        $uploader->upFile('cardLogo');
        $inf=$uploader->getFileInfo();
        mylog(getArrayInf($inf));
        include_once '../wechat/cardManager.php';
        $logo=uploadLogo($GLOBALS['mypath'].'/'.$inf['url']);
            $inf['logo']=$logo;
            echo json_encode($inf);
    }
    if(isset($_FILES['temp-img-up'])){
        $uploader = new uploader('temp-img-up');
        $filename=md5_file($_FILES['temp-img-up']['tmp_name']);
        $uploader->upFile($filename);
        $inf=$uploader->getFileInfo();
        mylog(getArrayInf($inf));
        include_once '../wechat/mediasdk.php';
        $media=new mediasdk();
        $mediaid=uploadLogo($GLOBALS['mypath'].'/'.$inf['url']);
        $inf['media_id']=$mediaid;
        echo json_encode($inf);
    }
    exit;
}
function fileFilter($file, array $type, $size)
{
    if (in_array($file['type'], $type) && $file['size'] < $size) {
        if ($file['error'] > 0) {
            return false;
        } else {
            return true;
        }
    } else {
        return false;
    }
}
?>