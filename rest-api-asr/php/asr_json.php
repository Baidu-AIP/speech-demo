<?php
define('DEMO_CURL_VERBOSE', false); // 打印curl debug信息
/**
* php -m 检查是否开启php curl扩展
*/

# 填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
$apiKey = "4E1BG9lTnlSeIf1NQFlrSq6h";
# 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
$secretKey = "544ca4657ba8002e3dea3ac2f5fdd241";

# 需要识别的文件
$audio_file = "./16k.pcm";
# 文件格式
$format = "pcm"; // 文件后缀 pcm/wav/amr

# 根据文档填写PID，选择语言及识别模型
$dev_pid = 1537; //  1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型

$cuid = "123456PHP";
# 采样率
$rate = 16000;  // 固定值
/** 公共模块获取token开始 */

$auth_url = "https://openapi.baidu.com/oauth/2.0/token?grant_type=client_credentials&client_id=".$apiKey."&client_secret=".$secretKey;
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

if (!in_array('audio_voice_assistant_get',explode(" ", $response['scope']))){
	echo "DO NOT have asr permission\n";
	// 请至网页上应用内开通语音识别权限
	exit(3);
}


$token = $response['access_token'];
echo "token = $token ; expireInSeconds: ${response['expires_in']}\n\n";
/** 公共模块获取token结束 */

/** 拼接参数开始 **/
$audio = file_get_contents($audio_file);
$base_data = base64_encode($audio);
$params = array(
	"dev_pid" => $dev_pid,
	"format" => $format,
	"rate" => $rate,
	"token" => $token,
	"cuid"=> $cuid,
	"speech" => $base_data,
	"len" => strlen($audio),
	//"url" => "http://www.xxx.com/sample.pcm",
	//"callback" => "http://www.xxx.com/audio/callback", // url及callback参数代替 len和data，不建议使用
	"channel" => 1,
);

$json_array = json_encode($params);
$headers[] = "Content-Length: ".strlen($json_array);
$headers[] = 'Content-Type: application/json; charset=utf-8';

/** 拼接参数结束 **/
	
	
$url = "http://vop.baidu.com/server_api";

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
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
echo "asr result $res\n";
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
