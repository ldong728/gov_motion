<?php
define('DEBUG',true);
//$province=null;
//$city=null;
//$area=null;

function html($text)
{
	return htmlspecialchars($text, ENT_QUOTES, 'UTF-8');
}

function htmlout($text)
{
	echo html($text);
}

function output($string){
    header("Content-Type:text/html; charset=utf-8");
    echo '<p class = "warning">'. $string.'</p>';

}
function formatOutput($string){
//    $str=html($string);
    $str=preg_replace('/___/','<input type="text"/>',$string);
    return $str;
}

function printInf($p){
    echo '<br/>'.'{';
    foreach ($p as $k=>$v) {
       echo $k.':  ';
        if(is_array($v)){
            printInf($v);
        }else{
            echo $v.',';
        }

    }
    echo '}';
}

//debug

function getArrayInf($array){
    if(is_array($array)){
        $s='{';
        foreach ($array as $k=>$v) {
            $s.=$k.': ';
            if(is_array($v)){
                $s=$s.getArrayInf($v);
            }else{
                $s.=$v.',';
            }
        }
        $s=trim($s,',');
        return $s.'}';
    }else{
       return 'not a array:'.$array;
    }


}

function mylog($str='mark'){
    if(DEBUG) {
        $debugInfo=debug_backtrace();
        $message = $debugInfo[0]['file'].$debugInfo[0]['line'];
        $log = date('Y.m.d.H:i:s', time()) . ':'.$message.':' . $str . "\n";
        file_put_contents($GLOBALS['mypath'].'/log.txt', $log, FILE_APPEND);
    }
}

function ajaxBack($data=null,$errcode=0,$errmsg='ok'){
    $back=array('errcode'=>$errcode,'errmsg'=>$errmsg);
    if($data)$back['data']=$data;
//    mylog(json_encode($back,JSON_UNESCAPED_UNICODE));
    return json_encode($back,JSON_UNESCAPED_UNICODE);
}

//mysql格式转换
function timeUnixToMysql($time){
    if($time){
        return date('Y-m-d H:i:s', $time);
    }else{
        return '';
    }


}

function timeMysqlToUnix($time){
    return strtotime($time);
}

function get($url){
    $curl = curl_init();
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($curl, CURLOPT_TIMEOUT, 500);
    curl_setopt($curl, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($curl, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($curl, CURLOPT_URL, $url);
    $data = curl_exec($curl);
    curl_close($curl);
    return $data;
}
function decodeXml($file){
    return simplexml_load_string($file, 'SimpleXMLElement', LIBXML_NOCDATA);
}
function getConfig($configName)
{
    $data = file_get_contents( $_SERVER['DOCUMENT_ROOT'] .DOMAIN.'/config/'.$configName.'.json');
    return json_decode($data, true);
}

//function saveConfig($path, array $config)
//{
//    $data = json_encode($config);
//    file_put_contents($path, $data);
//}







//微信用
/**随机字符串生成器
 * @param int $length
 * @return string
 */
function getRandStr($length = 16)
{
    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    $str = "";
    for ($i = 0; $i < $length; $i++) {
        $str .= substr($chars, mt_rand(0, strlen($chars) - 1), 1);
    }
    return $str;
}

/**
 * 格式化参数格式化成url参数
 */
function ToUrlParams(array $value)
{
    $buff = "";
    foreach ($value as $k => $v)
    {
        if($k != "sign" && $v != "" && !is_array($v)){
            $buff .= $k . "=" . $v . "&";
        }
    }

    $buff = trim($buff, "&");
    return $buff;
}

/**
 * 生成微信所需签名
 * @param $key
 * @return string
 */
function makeSign(array $value,$key)
{
    //签名步骤一：按字典序排序参数
    ksort($value);
    $string =ToUrlParams($value);
    //签名步骤二：在string后加入KEY
    if(''!=$key){
        $string = $string ."&key=".$key;
        //签名步骤三：MD5加密
    }
//    mylog($string);

    $string = md5($string);
    //签名步骤四：所有字符转为大写
    $result = strtoupper($string);
    return $result;
}

/**
 * @param array $values 待转化的数组
 * @return string
 * @throws WxPayException
 */
function toXml(array $values)
{
    if(!is_array($values)
        || count($values) <= 0)
    {
        return '<xml><error>数组错误</error></xml>';
    }

    $xml = "<xml>";
    foreach ($values as $key=>$val)
    {
        if (is_numeric($val)){
            $xml.="<".$key.">".$val."</".$key.">";
        }else{
            $xml.="<".$key."><![CDATA[".$val."]]></".$key.">";
        }
    }
    $xml.="</xml>";
    return $xml;
}
function xmlToArray($xmlData){
    $postStr = $xmlData;
    if (!empty($postStr)) {
        libxml_disable_entity_loader(true);
        $postObj = simplexml_load_string($postStr, 'SimpleXMLElement', LIBXML_NOCDATA);
        foreach ($postObj->children() as $child) {
            $msg[$child->getName()] = (string)$child;
        }
        return $msg;
    }
}
function signVerify($array){
    foreach ($array as $k => $v) {
        if('sign'==$k){
            $inValue=$v;
        }else{
            $data[$k]=$v;
        }
    }
    $outValue=makeSign($data,KEY);
    if($outValue==$inValue){
        return true;
    }else{
        return false;
    }
}
function uploadFileByCurl($remote_server, $file, $field = 'media', $exraInf = null)
{
    $replaced_server = $remote_server;
    $fields[$field] = '@' . $file;
    if ($exraInf != null) {
        foreach ($exraInf as $k => $v) {
            $fields[$k] = $v;
        }
    }
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_URL, $replaced_server);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
    curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, false);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $fields);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_HEADER, false);
    $data = curl_exec($ch);
    curl_close($ch);
    $dataArray = json_decode($data, true);
//    if (40001 == $dataArray['errcode']) {
//        if ($this->tryCount < 4) {
//            $this->tryCount++;
//            $this->diable = true;
//            $this->clearToken();
//            return $this->uploadFileByCurl($remote_server, $file, $field = 'media', $exraInf = null);
//        }
//    } else {
//        $this->tryCount = 0;
//    }
    return $data;

}


