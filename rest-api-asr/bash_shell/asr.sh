#!/usr/bin/env bash
# 该脚本用于测试百度语音识别接口，详细参数说明和使用方法请参考官方文档：http://ai.baidu.com/docs#/ASR-API/top
# This is the demo script for Baidu Speech ASR, please refer http://ai.baidu.com/docs#/ASR-API/top for detailed document


# 该KEY仅仅做测试用，正式使用请在 ai.baidu.com 控制台申请个人APP
# THIS KEY IS FOR TEST ONLY
APPKEY="rKCHBLmYiFPuCQTS0HttLbUD"
APPSECRET="037dc446820ec143d1628c20146b9d34"

# 需要识别的文件
# Audio file to recognition
FILE="16k_test.pcm"
FORMAT="pcm"  # support pcm/wav/amr
RATE="16000"


# 根据文档填写PID，1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型
# ASR Model 1537: input method model; 1536: search model
DEV_PID="1537"

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
asr_url="https://vop.baidu.com/server_api?dev_pid=${DEV_PID}&token=$token&cuid=123456"
headers="Content-Type: audio/$FORMAT;rate=$RATE"

echo "Request ASR..."
curl -X POST -s --data-binary "@$FILE" -H "$headers" "$asr_url"

# expected result:  {"corpus_no":"6526075710854540378","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"402172223481519470408"}