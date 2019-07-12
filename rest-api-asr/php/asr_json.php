<?php
define('DEMO_CURL_VERBOSE', false); // 打印curl debug信息

/**
* php -m 检查是否开启php curl扩展
*/

# 填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
$API_KEY =  "kVcnfD9iW2XVZSMaLMrtLYIz";

# 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
$SECRET_KEY = "O9o1O213UgG5LFn0bDGNtoRN3VWl2du6";

# 需要识别的文件
$AUDIO_FILE = "./16k.pcm";
# 文件格式

$FORMAT = substr($AUDIO_FILE, -3); // 文件后缀 pcm/wav/amr 格式 极速版额外支持m4a 格式

$CUID = "123456PHP";
# 采样率
$RATE = 16000;  // 固定值

# 普通版
$ASR_URL = "http://vop.baidu.com/server_api";
# 根据文档填写PID，选择语言及识别模型
$DEV_PID = 1537; //  1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型
$SCOPE = 'audio_voice_assistant_get'; // 有此scope表示有语音识别普通版能力，没有请在网页里开通语音识别能力

#测试自训练平台需要打开以下信息， 自训练平台模型上线后，您会看见 第二步：“”获取专属模型参数pid:8001，modelid:1234”，按照这个信息获取 dev_pid=8001，lm_id=1234
//DEV_PID = 8001 ;   
//LM_ID = 1234 ;

# 极速版需要打开以下信息 打开注释的话请填写自己申请的appkey appSecret ，并在网页中开通极速版（开通后可能会收费）
//$ASR_URL = "http://vop.baidu.com/pro_api";
//$DEV_PID = 80001; 
//$SCOPE = 'brain_enhanced_asr';  // 有此scope表示有极速版能力，没有请在网页里开通极速版

$SCOPE = false; // 部分历史应用没有加入scope，设为false忽略检查

/** 公共模块获取token开始 */


$auth_url = "http://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=".$API_KEY."&client_secret=".$SECRET_KEY;
$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $auth_url);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); //信任任何证书
curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0); // 检查证书中是否设置域名,0不验证
curl_setopt($ch, CURLOPT_VERBOSE, DEMO_CURL_VERBOSE);
$res = curl_exec($ch);
if(curl_errno($ch))
{
    print curl_error($ch);
}
curl_close($ch);

echo "Token URL response is " . $res . "\n";
$response = json_decode($res, true);

if (!isset($response['access_token'])){
	echo "ERROR TO OBTAIN TOKEN\n";
	exit(1);
}
if (!isset($response['scope'])){
	echo "ERROR TO OBTAIN scopes\n";
	exit(2);
}

if ($SCOPE && !in_array($SCOPE, explode(" ", $response['scope']))){
	echo "CHECK SCOPE ERROR\n";
	// 请至网页上应用内开通语音识别权限
	exit(3);
}

$token = $response['access_token'];
echo "token = $token ; expireInSeconds: ${response['expires_in']}\n\n";
/** 公共模块获取token结束 */

/** 拼接参数开始 **/
$audio = file_get_contents($AUDIO_FILE);
$base_data = base64_encode($audio);
$params = array(
	"dev_pid" => $DEV_PID,
	//"lm_id" => $LM_ID,    //测试自训练平台开启此项
	"format" => $FORMAT,
	"rate" => $RATE,
	"token" => $token,
	"cuid"=> $CUID,
	"speech" => $base_data,
	"len" => strlen($audio),
	"channel" => 1,
);

$json_array = json_encode($params);
$headers[] = "Content-Length: ".strlen($json_array);
$headers[] = 'Content-Type: application/json; charset=utf-8';

/** 拼接参数结束 **/
	
/** asr 请求开始 **/

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $ASR_URL);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
curl_setopt($ch, CURLOPT_TIMEOUT, 60); // 识别时长不超过原始音频
curl_setopt($ch, CURLOPT_POSTFIELDS, $json_array);
curl_setopt($ch, CURLOPT_VERBOSE, DEMO_CURL_VERBOSE);
$res = curl_exec($ch);
if(curl_errno($ch))
{
    echo curl_error($ch);
	exit (2);
}
curl_close($ch);
/** asr 请求结束 **/

// 打印请求参数
echo 'url is : ' . $ASR_URL . "\n";
$params['speech'] = 'base64_encode(file_get_contents($AUDIO_FILE))'; 
echo 'params is :' . json_encode($params) . "\n";

// 打印百度返回的结果
echo "asr result $res\n";

// 解析结果
$response = json_decode($res, true);

if (isset($response['err_no']) && $response['err_no'] == 0){
	echo "asr result is ". $response['result'][0] . "\n";
}else{
	echo "asr has error\n";
}


// windows命令行遇见乱码可打开文件result.txt, 使用如notepad++等软件打开
echo "response is also saved into result.txt in UTF-8\n ";
file_put_contents("result.txt", $res);
?>
