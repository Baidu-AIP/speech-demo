## 简介

使用bash 脚本方式测试rest api 识别接口

- windows 下需要安装 cygwin，在cygwin内安装curl


## 测试流程

### 修改token.sh

从网页中申请的应用获取appKey和appSecret

```bash
APPKEY="g8eBUMSokVB1BHGmgxxxxxx"
APPSECRET="94dc99566550d87f8fa8ece112xxxxx"
```


## 运行 tts.sh，进行合成

命令为 sh tts.sh 

```json
{"access_token":"24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099","session_key":"9mzdCyse3JwGR1cK\/XAkMMXTp7D7mQ+9ulfLpycoWHOuZQBmQtPSE9MnAF6kUNqDnAgnaoyjP\/qkYgtciDo9PKgyozlbIw==","scope":"public audio_voice_assistant_get audio_tts_post wise_adapt lebo_resource_base lightservice_public hetu_basic lightcms_map_poi kaidian_kaidian ApsMisTest_Test\u6743\u9650 vis-classify_flower bnstest_fasf lpq_\u5f00\u653e cop_helloScope ApsMis_fangdi_permission","refresh_token":"25.f54659f694f686cf574f8723d48cbe4d.315360000.1834828569.282335-10455099","session_secret":"e730778e4d239a4811ba6424556ef701","expires_in":2592000}
```

- scope 含有audio_tts_post表示有语音合成能力，没有的话请至网页激活
- expires_in 表示 2592000秒后该token失效
- token  24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099

最终合成的结果在result.mp3

返回的头部如：

```json
TP/1.1 200 OK
Cache-Control: max-age=36000
Connection: keep-alive
Content-Length: 5112
Content-Type: audio/mp3
Date: Sat, 24 Feb 2018 12:10:03 GMT
P3p: CP=" OTI DSP COR IVA OUR IND COM "
Server: nginx/1.8.0
Set-Cookie: BAIDUID=C7D1045FB2908EAB89645B81C7C42C1F:FG=1; expires=Sun, 24-Feb-19 12:10:03 GMT; max-age=31536000; path=/; domain=.baidu.com; version=1


```

其中

- Content-Type: audio/mp3，表示合成成功，可以播放MP3 result.mp3
- Content-Type: application/json 表示错误  result.mp3改名为result.txt打开可以看到错误信息的json

### 修改合成参数

```bash
# TEXT 的内容为"欢迎使用百度语音合成"的urlencode,utf-8 编码
# 可以百度搜索"urlencode" 
TEXT="%e6%ac%a2%e8%bf%8e%e4%bd%bf%e7%94%a8%e7%99%be%e5%ba%a6%e8%af%ad%e9%9f%b3%e5%90%88%e6%88%90"
#发音人选择, 0为普通女声，1为普通男生，3为情感合成-度逍遥，4为情感合成-度丫丫，默认为普通女声
PER=0
#语速，取值0-15，默认为5中语速
SPD=5
#音调，取值0-15，默认为5中语调
PIT=5
#音量，取值0-9，默认为5中音量
VOL=5
# Aue, 格式, 3：mp3(default) 4： pcm-16k 5： pcm-8k 6. wav
AUE=3
```

