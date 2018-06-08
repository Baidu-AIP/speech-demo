#!/bin/sh

# 开始bash -x 参数，用于显示完整命令
#set -x

TOKEN=$1

# TEXT 的内容为"欢迎使用百度语音合成"的urlencode,utf-8 编码
# 可以百度搜索"urlencode" 
TEXT="%e6%ac%a2%e8%bf%8e%e4%bd%bf%e7%94%a8%e7%99%be%e5%ba%a6%e8%af%ad%e9%9f%b3%e5%90%88%e6%88%90"

#发音人选择, 0为普通女声，1为普通男生，3为情感合成-度逍遥，4为情感合成-度丫丫，默认为普通女声
PER=0
#语速，取值0-9，默认为5中语速
SPD=5
#音调，取值0-9，默认为5中语调
PIT=5
#音量，取值0-9，默认为5中音量
VOL=5

CURL_OPT="-v" #显示DEBUG信息
#CURL_OPT=""

if  [ "$TOKEN" =  "" ] ; then
    echo "usage: sh $0 24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099"
	echo "please obtain token from sh token.sh"
	exit 1
fi
CUID="7654321"
URL="http://tsn.baidu.com/text2audio?tex=$TEXT&lan=zh&ctp=1&cuid=$CUID&tok=$TOKEN&per=$PER&spd=$SPD&pit=$PIT&vol=$VOL"


# 测试结果如：  
curl -i "$CURL_OPT" -o result.mp3 "$URL"

# 输出结果
#HTTP/1.1 200 OK
# ...
# Content-Type: audio/mp3
# Content-Type: audio/mp3 表示正确 可以播放result.mp3
# Content-Type: application/json 表示错误  result.mp3改名为result.txt打开

