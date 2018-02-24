#!/bin/sh

# 填写网页上申请的appkey 如 APPKEY="g8eBUMSokVB1BHGmgxxxxxx"
APPKEY="rKCHBLmYiFPuCQTS0HttLbUD"
# 填写网页上申请的APPSECRET 如 APPSECRET="94dc99566550d87f8fa8ece112xxxxx"
APPSECRET="037dc446820ec143d1628c20146b9d34"

#CURL_OPT="-v" 显示DEBUG信息
CURL_OPT="-s"

if  [ "$APPKEY" =  "" ] ; then
    echo "APPKEY NOT FILLED"
	exit 1
fi

if  [ "$APPSECRET" =  "" ] ; then
    echo "APPKEY NOT FILLED"
	exit 2
fi

URL="https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=$APPKEY&client_secret=$APPSECRET"
echo $URL
echo 

curl -k "$CURL_OPT" "$URL"

## 正确结果如：
#{"access_token":"24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099","session_key":"9mzdCyse3JwGR1cK\/XAkMMXTp7D7mQ+9ulfLpycoWHOuZQBmQtPSE9MnAF6kUNqDnAgnaoyjP\/qkYgtciDo9PKgyozlbIw==","scope":"public audio_voice_assistant_get audio_tts_post wise_adapt lebo_resource_base lightservice_public hetu_basic lightcms_map_poi kaidian_kaidian ApsMisTest_Test\u6743\u9650 vis-classify_flower bnstest_fasf lpq_\u5f00\u653e cop_helloScope ApsMis_fangdi_permission","refresh_token":"25.f54659f694f686cf574f8723d48cbe4d.315360000.1834828569.282335-10455099","session_secret":"e730778e4d239a4811ba6424556ef701","expires_in":2592000}

 
# scope 含有audio_voice_assistant_get表示有语音识别能力，没有的话请至网页激活
# scope 含有audio_tts_post表示有语音合成能力，没有的话请至网页激活
# expires_in 表示 2592000秒后该token失效

# token为24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099， 请测试下一个脚本
# 命令如：sh asr.sh 24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099