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
        $meeting=pdoQuery('meeting_tbl',['meeting_id'],['category'=>$category],' order by start_time desc limit 1')->fetch();
        include_once '../libs/PHPExcel.php';
        $excelReader=new PHPExcel_Reader_Excel2007();
        $excelWriter=new PHPExcel();
        $writer=$excelWriter->setActiveSheetIndex(0);
//        $author=1==$category?'领衔人':'提案人';
//        $writer->setCellValue('A1','案号');
//        $writer->setCellValue('B1',$author);
//        $writer->setCellValue('C1','案由');
//        $writer->setCellValue('D1','主办单位');
//        $writer->setCellValue('E1','协办单位');
//        $writer->setCellValue('F1','出错原因');

        $writerCount=1;

        if(!$excelReader->canRead($_FILES['handle_file']['tmp_name'])){
            $excelReader=new PHPExcel_Reader_Excel5();
            if(!$excelReader->canRead($_FILES['handle_file']['tmp_name'])){
                mylog('can\'t read');
            }

            $myExcel=$excelReader->load($_FILES['handle_file']['tmp_name']);
            $currentSheet=$myExcel->getSheet();
            $totalRow=$currentSheet->getHighestRow();
            for($i=1;$i<$totalRow+1;$i++){//遍历excel文件每一行
                $id=$currentSheet->getCell('A'.$i);
                if($id instanceof PHPExcel_RichText){
                    $id=$id->__toString();
                    mylog('id is richText');
                }
                $name=$currentSheet->getCell('B'.$i);
                if($name instanceof PHPExcel_RichText){
                    $name=$name->__toString();
                    mylog('name is richText');
                }
                $title=$currentSheet->getCell('C'.$i);
                if($title instanceof PHPExcel_RichText){
                    $title=$title->__toString();
                    mylog('name is richText');
                }
                $mainHandle=$currentSheet->getCell('D'.$i);
                if($mainHandle instanceof PHPExcel_RichText){
                    $mainHandle=$mainHandle->__toString();
                    mylog('mainHandle is richText');
                }
                $subHandle=$currentSheet->getCell('E'.$i);
                if($subHandle instanceof PHPExcel_RichText){
                    $subHandle=$subHandle->__toString();
                    mylog('mainHandle is richText');
                }
//                $subHandle=$currentSheet->getCell('E'.$i);
//                if($subHandle instanceof PHPExcel_RichText){
//                    $subHandle=$subHandle->__toString();
//                    mylog('mainHandle is richText');
//                }
//                mylog($subHandle);
//                $id=intval($id);
                if($id){ //有案号
                    if(1==$category){
                        $motionId=pdoQuery('motion_view',['motion_id'],['meeting'=>$meeting,'step'=>4,'attr_name'=>'案号','content_int'=>$id],' limit 1')->fetch();
                    }else{
                        $motionId=pdoQuery('motion_view',['motion_id','step'],['meeting'=>$meeting,'step'=>[3,4],'attr_name'=>'案号','content_int'=>$id],' limit 1')->fetch();

                    }
                    if($motionId){
                        $motionStep=2==$category? $motionId['step']:0;
                        $motionId=$motionId['motion_id'];
                        $mainHandleId=pdoQuery('unit_tbl',['unit_id'],['unit_name'=>$mainHandle],'limit 1')->fetch();
//                        mylog($mainHandleId);
                        pdoTransReady();
                        try{
                            if($mainHandleId){//主办单位名称正确
                                $mainHandleId=$mainHandleId['unit_id'];
                                $mainHandleValue=$category==1?['motion'=>$motionId,'motion_attr'=>32,'attr_template'=>13,'content_int'=>$mainHandleId]:['motion'=>$motionId,'motion_attr'=>22,'attr_template'=>13,'content_int'=>$mainHandleId];
                                $mainHandleQuery=pdoQuery('attr_tbl',['motion'],$mainHandleValue,'limit 1')->fetch();
                                if(!$mainHandleQuery){
//                                    mylog($mainHandleValue);
                                    pdoInsert('attr_tbl',$mainHandleValue);
                                    pdoUpdate('motion_tbl',['step'=>5],['motion_id'=>$motionId],'limit 1');
                                }
                            }else{//主办单位名称未找到
                                $error=new PDOException();
                                $error->errorInfo='主办单位"'.$mainHandle.'"名称未识别';
                                throw $error;
                            }

                            $subHandleList=explode("、",$subHandle);
                            if(count($subHandleList)>0&&$subHandleList[0]){//存在协办单位
//                                mylog('存在协办');
                                foreach ($subHandleList as $subHandleRow) {
                                    $subHandleUnit=pdoQuery('unit_tbl',['unit_id'],['unit_name'=>$subHandleRow],'limit 1')->fetch();
                                    if($subHandleUnit){//协办单位名称正确
                                        $subHandleId=$subHandleUnit['unit_id'];
                                        $subHandleValue=$category==1?['motion'=>$motionId,'motion_attr'=>33,'attr_template'=>14,'content_int'=>$subHandleId]:['motion'=>$motionId,'motion_attr'=>23,'attr_template'=>14,'content_int'=>$subHandleId];
                                        $subHandleQuery=pdoQuery('attr_tbl',['attr_id'],$subHandleValue,'limit 1')->fetch();
                                        if(!$mainHandleQuery){
//                                          mylog($mainHandleValue);
                                          $attr=pdoInsert('attr_tbl',$subHandleValue);
                                        }else{
                                            $attr=$subHandleQuery['attr_id'];
                                        }
                                        pdoInsert('motion_handler_tbl',['motion'=>$motionId,'attr'=>$attr,'unit'=>$subHandleId,'status'=>1],'update');
                                    }else{//协办单位名称未找到（严重错误）
                                        $error=new PDOException();
                                        $error->errorInfo='协办单位"'.$subHandleRow.'"名称未识别';
                                        throw $error;
                                        break;
                                    }
                                }
                            }
                            if(2==$category){
                                if(3==$motionStep){
                                    $step4Inf=pdoQuery('attr_tbl',['attr_id'],['motion'=>$motionId,'motion_attr'=>24,'attr_template'=>15],'limit 1')->fetch();
                                    if(!$step4Inf){
                                        pdoInsert('attr_tbl',['motion'=>$motionId,'motion_attr'=>24,'attr_template'=>15,'content_int'=>5103],'update');
                                    }
//                                    mylog('还在审核');
                                }
                            }else{
                                mylog($category);
                                mylog($motionStep);
                            }
//                            pdoRollBack();
                            pdoCommit();
                        }catch(PDOException $e){
                            $writerCount++;
                            $writer->setCellValue('A'.$writerCount,$id);
                            $writer->setCellValue('B'.$writerCount,$name);
                            $writer->setCellValue('C'.$writerCount,$title);
                            $writer->setCellValue('D'.$writerCount,$mainHandle);
                            $writer->setCellValue('E'.$writerCount,$subHandle);
                            $writer->setCellValue('F'.$writerCount,$e->errorInfo);

//                            mylog($e->errorInfo);
                            pdoRollBack();
                        }


                    }else{//不在交办环节或无对应案号
                        $error='案号不正确，或此件未处于交办状态';
                        $writerCount++;
                        $writer->setCellValue('A'.$writerCount,$id);
                        $writer->setCellValue('B'.$writerCount,$name);
                        $writer->setCellValue('C'.$writerCount,$title);
                        $writer->setCellValue('D'.$writerCount,$mainHandle);
                        $writer->setCellValue('E'.$writerCount,$subHandle);
                        $writer->setCellValue('F'.$writerCount,$error);
//                        mylog(('案号不正确，或此件未处于交办状态'.$id));
                    }

                }



            }
        }
//        mylog('excel-file-uploaded');
        $saver=new PHPExcel_Writer_Excel2007($excelWriter);
        $saver->save('../download_files/test.xls');
        echo json_encode(array('status'=>'SUCCESS'));

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
                    $motionId=pdoQuery('motion_view',['motion_id'],['meeting'=>$meetingId,'step'=>4,'attr_name'=>'案号','content_id'=>$id],' limit 1')->fetch();
                    if($motionId){
                        $motionId=$motionId['motion_id'];
                        $mainHandle=$currentSheet->getCell('D'.$i);
                        if($mainHandle instanceof PHPExcel_RichText){
                            $mainHandle=$mainHandle->__toString();
                            mylog('mainHandle is richText');
                        }
                        if(isset($unitList[$mainHandle])){//主办单位名称正确
                            $mainHandleId=$unitList[$mainHandle];
                            $mainHandleInsertValue=['motion'=>$motionId];
                        }
                        mylog($mainHandleId);
                        $subHandle=$currentSheet->getCell('E',$i);
                        if($subHandle instanceof PHPExcel_RichText){
                            $subHandle=$subHandle->__toString();
                            mylog('mainHandle is richText');
                        }
                        $subHandleList=explode("、",$subHandle);

                    }else{//不在交办环节或无对应案号

                    }

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