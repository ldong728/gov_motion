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
        if(isset($_GET['auto_set'])){
            include_once '../libs/PHPExcel.php';
            $excelReader=new PHPExcel_Reader_Excel2007();
            $excelWriter=new PHPExcel();
            $notInput=array();
            if(!$excelReader->canRead($_FILES['excel-file']['tmp_name'])){
                $excelReader=new PHPExcel_Reader_Excel5();
                if(!$excelReader->canRead($_FILES['excel-file']['tmp_name'])){
                    mylog('can\'t read');
                }
                $myExcel=$excelReader->load($_FILES['auto-file']['tmp_name']);
                $currentSheet=$myExcel->getSheet();
                $totalRow=$currentSheet->getHighestRow();
                for($i=1;$i<$totalRow+1;$i++){
                    $name=getFromCell($currentSheet,'a',$i);
                    $phone=$currentSheet->getCell('D'.$i);
                    if($phone instanceof PHPExcel_RichText){
                        $phone=$phone->__toString();
                    }
                    $address=$currentSheet->getCell('B'.$i);
                    if($address instanceof PHPExcel_RichText){
                        $address=$address->__toString();
                    }
                    if($name&&$phone){
                        $updateSuccess=pdoUpdate('user_tbl',array('address'=>$address),array('user_phone'=>$phone,'category'=>1),'limit 1');

                        if(!$updateSuccess){
                            $notInput[]=array('name'=>$name,'phone'=>$phone);
                            mylog($name.': '.$phone);
                        }
                    }


                }
                if(count($notInput)>0){

                }

            }
            mylog('excel-file-uploaded');
            echo array('status'=>'SUCCESS');
        }
    }
    //公众号操作


    exit;
}
header('location:index.php');

exit;
function getFromCell($currentSheet,$colName,$rowId){
    $value=$currentSheet->getCell($colName.$rowId);
    if($value instanceof PHPExcel_RichText){
        $$value=$value->__toString();
    }
    return $value;
}

