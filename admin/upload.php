<?php
include_once '../includePackage.php';
include_once 'upload.class.php';
session_start();
if(isset($_SESSION['login'])&&DOMAIN==$_SESSION['login']) {
    if(isset($_GET['excel_file'])){
        include_once '../libs/PHPExcel.php';
        $excelReader=new PHPExcel_Reader_Excel2007();
        $excelWriter=new PHPExcel();
        $notInput=array();
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
                    mylog('name is richText');
                }
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

    if(isset($_GET['batch_handle_file'])&&isset($_GET['category'])){
        $category=$_GET['category'];
        $meeting=pdoQuery('meeting_tbl',['meeting_id'],['category'=>$category],' order_by start_time desc limit 1')->fetch()['meeting_id'];
        include_once '../libs/PHPExcel.php';
        $excelReader=new PHPExcel_Reader_Excel2007();
        $excelWriter=new PHPExcel();
        $notInput=array();
        if(!$excelReader->canRead($_FILES['handle_file']['tmp_name'])){
            $excelReader=new PHPExcel_Reader_Excel5();
            if(!$excelReader->canRead($_FILES['handle_file']['tmp_name'])){
                mylog('can\'t read');
            }
            $unitList=[];
            $unitQuery=pdoQuery('unit_tbl',['unit_id','unit_name'],null,null);
            foreach ($unitQuery as $row) {
                $unitList[$row['unit_name']]=$row['unit_id'];
            }
            $myExcel=$excelReader->load($_FILES['handle_file']['tmp_name']);
            $currentSheet=$myExcel->getSheet();
            $totalRow=$currentSheet->getHighestRow();
            for($i=1;$i<$totalRow+1;$i++){
                $id=$currentSheet->getCell('A'.$i);
                if($id instanceof PHPExcel_RichText){
                    $id=$id->__toString();
                    mylog('name is richText');
                }
                if(is_int($id)){ //有案号
                    $motionId=pdoQuery('motion_view',['motion_id'],['meeting'=>$meetingId,'step'=>4,'attr_name'=>'案号','content_id'=>$id],' limit 1')->fetch()['motion_id'];

                    $mainHandle=$currentSheet->getCell('D'.$i);
                    if($mainHandle instanceof PHPExcel_RichText){
                        $mainHandle=$mainHandle->__toString();
                        mylog('mainHandle is richText');
                    }
                    if(isset($unitList[$mainHandle])){
                        $mainHandleId=$unitList[$mainHandle];
                    }

                    mylog($mainHandleId);
                    $subHandle=$currentSheet->getCell('E',$i);
                    if($subHandle instanceof PHPExcel_RichText){
                        $subHandle=$subHandle->__toString();
                        mylog('mainHandle is richText');
                    }
                    $subHandleList=explode("、",$subHandle);

                }



            }
            if(count($notInput)>0){

            }

        }
        mylog('excel-file-uploaded');
        echo json_encode(array('status'=>'SUCCESS'));

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