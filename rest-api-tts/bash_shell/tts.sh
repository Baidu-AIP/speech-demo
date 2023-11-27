#!/usr/bin/env bash
# 该脚本用于测试百度语音合成接口，详细参数说明和使用方法请参考官方文档：http://ai.baidu.com/docs#/TTS-API/top
# This is the demo script for Baidu Speech TTS, please refer http://ai.baidu.com/docs#/TTS-API/top for detailed document


# 该KEY仅仅做测试用，正式使用请在 ai.baidu.com 控制台申请个人APP
# THIS KEY IS FOR TEST ONLY
APPKEY="rKCHBLmYiFPuCQTS0Htxxxx"
APPSECRET="037dc446820ec143d1628c2014xxxxx"

# 需要合成的文本
# Text to synthesis
# 百度AI更懂你 URLENCODE 编码 urlencode result = %e7%99%be%e5%ba%a6AI%e6%9b%b4%e6%87%82%e4%bd%a0
# 注意实际使用需要2次urlencode以保障如“+”等特殊字符合成正确。 请测试 “1+1=2”
TEXT="%e7%99%be%e5%ba%a6AI%e6%9b%b4%e6%87%82%e4%bd%a0"
# or use English words
# TEXT=hello

# 发音人选择, 基础音库：0为度小美，1为度小宇，3为度逍遥，4为度丫丫，
# 精品音库：5为度小娇，103为度米朵，106为度博文，110为度小童，111为度小萌，默认为度小美 
# Speaker, 1: female, 2: male, 3: male-2, 4: child;
SPEAKER=0
# Speed, 0 ~ 15; 语速，取值0-9，默认为5中语速
SPEED=5
# Pitch, 0 ~ 15; 音调，取值0-9，默认为5中语调
PITCH=5
# Volume, 0 ~ 9; 音量，取值0-9，默认为5中音量
VOLUME=5

# Aue,下载音频的格式 3：mp3(default) 4： pcm-16k 5： pcm-8k 6. wav
AUE=4

FORMAT_LIST=([3]='mp3' [4]='pcm' [5]='pcm' [6]='wav')
FORMAT=${FORMAT_LIST[$AUE]}

## step 1: Fetch token
token_url="https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=$APPKEY&client_secret=$APPSECRET"
echo "Request token $token_url"

token_resp=$(curl -s "$token_url")
echo "Response: $token_resp"
# token=$(echo "${token_resp}" | grep -oP '"access_token"\s*:\s*"\K.+?(?=")')  # this works for Linux with GUN grep
# MacOS grep not support Perl(-P) syntax, so we use perl instead ;)
token=$(echo "${token_resp}" | perl -nle 'print $& if m{"access_token"\s*:\s*"\K.+?(?=")}' )
echo "Got token: $token"
echo

## step 2: TTS
tts_url="http://tsn.baidu.com/text2audio?lan=zh&ctp=1&cuid=123456&tok=$token&per=$SPEAKER&spd=$SPEED&pit=$PITCH&vol=$VOLUME&tex=$TEXT&aue=$AUE"
echo "Request TTS: $tts_url"
curl -v -o result.$FORMAT "$tts_url"

echo "Audio file saved as result.$FORMAT"
# 以下以mp3文件为示例
# Content-Type: audio/mp3 表示正确 可以播放result.mp3
# Content-Type: application/json 表示错误  result.mp3改名为result.txt打开
# Content-Type: application/json means that error occurs, please rename result.mp3 as result.txt
echo "Done"
