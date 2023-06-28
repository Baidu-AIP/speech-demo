#!/usr/bin/env bash
# 调试使用 set -uex 或 sh -x asr.sh
# 该脚本用于测试百度语音识别接口，详细参数说明和使用方法请参考官方文档：http://ai.baidu.com/docs#/ASR-API/top
# This is the demo script for Baidu Speech ASR, please refer http://ai.baidu.com/docs#/ASR-API/top for detailed document
# 如果CURL 不支持https，下面的url都可以改成http

# 该KEY仅仅做测试用，正式使用请在 ai.baidu.com 控制台申请个人APP
# THIS KEY IS FOR TEST ONLY
APPKEY="kVcnfD9iW2XVZSMaLMxxxxxx"
APPSECRET="O9o1O213UgG5LFn0bDGNtoRN3xxxxxx"

# 需要识别的文件
# Audio file to recognition
FILE="16k.pcm"
FORMAT="pcm"  # support pcm/wav/amr 格式，极速版额外支持m4a 格式
RATE="16000"

# 根据文档填写PID，1537 表示识别普通话，使用输入法模型。
# ASR Model 1537: input method model; 
API_URL="http://vop.baidu.com/server_api"
DEV_PID="1537"

#测试自训练平台需要打开以下信息， 自训练平台模型上线后，您会看见 第二步：“”获取专属模型参数pid:8001，modelid:1234”，按照这个信息获取 dev_pid=8001，lm_id=1234
#DEV_PID="8001"   
#LM_ID="1234"

# 极速版请使用下面URL和PID 打开注释的话请填写自己申请的appkey appSecret ，并在网页中开通极速版（开通后可能会收费）
# ASR MODEL 80001 极速版
# API_URL="http://vop.baidu.com/pro_api"
# DEV_PID="80001"


## step 1: Fetch token
token_url="https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=$APPKEY&client_secret=$APPSECRET"
echo "Request token $token_url"

token_resp=$(curl -s "$token_url")
echo "Response: $token_resp"
#token=$(echo "${token_resp}" | grep -oP '"access_token"\s*:\s*"\K.+?(?=")')  # this works for Linux with GUN grep
# MacOS grep not support Perl(-P) syntax, so we use perl instead ;)
token=$(echo "${token_resp}" | perl -nle 'print $& if m{"access_token"\s*:\s*"\K.+?(?=")}' )
echo "Got token: $token"
echo

## step 2: ASR
ASR_URL="${API_URL}?dev_pid=${DEV_PID}&token=$token&cuid=123456"

##极速版需要打开下面注释
#ASR_URL="${API_URL}?dev_pid=${DEV_PID}&lm_id={LM_ID}$&token=$token&cuid=123456"
headers="Content-Type: audio/$FORMAT;rate=$RATE"

echo "Request ASR..."
curl -X POST -s --data-binary "@$FILE" -H "$headers" "$ASR_URL"

# expected result:  {"corpus_no":"6526075710854540378","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"402172223481519470408"}
