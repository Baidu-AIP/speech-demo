#!/bin/sh

# 开始bash -x 参数，用于显示完整命令
#set -x

TOKEN=$1

FILE="16k_test.pcm"

# 根据文件FILE的后缀填写：pcm/wav/amr
FORMAT="pcm"

# 根据文档填写PID，1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型
DEV_PID="1537"

#CURL_OPT="-v" 显示DEBUG信息
CURL_OPT="-s"

if  [ "$TOKEN" =  "" ] ; then
    echo "usage: sh $0 24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099"
	echo "please obtain token from sh token.sh"
	exit 1
fi

CUID="1234567"
URL="http://vop.baidu.com/server_api?dev_pid=${DEV_PID}&token=$TOKEN&cuid=$CUID"

RATE="16000" // 固定值
HEADER="Content-Type: audio/$FORMAT;rate=$RATE";

#curl -i -X POST -k "$CURL_OPT" --data-binary "@$FILE"  "$URL" 
echo
curl -X POST --data-binary "@$FILE" "$CURL_OPT" -H "$HEADER" "$URL" 

# 测试结果如：  {"corpus_no":"6526075710854540378","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"402172223481519470408"}
