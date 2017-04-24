<?php
include_once '../includePackage.php';
include_once 'upload.class.php';
session_start();
if(isset($_SESSION['login'])&&DOMAIN==$_SESSION['login']) {
    if(isset($_GET['excel_file'])){
        include_once '../libs/PHPExcel.php';
        $excelReader=new PHPExcel_Reader_Excel2007();
        if(!$excelReader->canRead($_FILES['excel-file']['tmp_name'])){
            $excelReader=new PHPExcel_Reader_Excel5();
            if(!$excelReader->canRead($_FILES['excel-file']['tmp_name'])){
                mylog('can\'t read');
            }
            $myExcel=$excelReader->load($_FILES['excel-file']['tmp_name']);
            $currentSheet=$myExcel->getSheet();
            $totalRow=$currentSheet->getHighestRow();
            for($i=1;$i<$totalRow+1;$i++){
                $name=$currentSheet->getCell('A'.$i);
                if($name instanceof PHPExcel_RichText){
                    $name=$name->__toString();
                }
                $phone=$currentSheet->getCell('D'.$i);
                if($phone instanceof PHPExcel_RichText){
                    $phone=$phone->__toString();
                }
                $phone=substr($phone,0,11);
                mylog($name.': '.$phone);

            }

        }
        mylog('excel-file-uploaded');
        echo array('status'=>'SUCCESS');
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