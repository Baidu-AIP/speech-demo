## 简介

使用bash 脚本方式测试rest api 识别接口

- windows 下需要安装 cygwin，在cygwin内安装curl



## 测试流程

### 修改token.sh

从网页中申请的应用获取appKey和appSecret

```
​```
APPKEY="g8eBUMSokVB1BHGmgxxxxxx"
APPSECRET="94dc99566550d87f8fa8ece112xxxxx"
​```
```



## 运行 token.sh，获取token
```
sh token.sh
```
有如下返回

```json
{"access_token":"24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099","session_key":"9mzdCyse3JwGR1cK\/XAkMMXTp7D7mQ+9ulfLpycoWHOuZQBmQtPSE9MnAF6kUNqDnAgnaoyjP\/qkYgtciDo9PKgyozlbIw==","scope":"public audio_voice_assistant_get audio_tts_post wise_adapt lebo_resource_base lightservice_public hetu_basic lightcms_map_poi kaidian_kaidian ApsMisTest_Test\u6743\u9650 vis-classify_flower bnstest_fasf lpq_\u5f00\u653e cop_helloScope ApsMis_fangdi_permission","refresh_token":"25.f54659f694f686cf574f8723d48cbe4d.315360000.1834828569.282335-10455099","session_secret":"e730778e4d239a4811ba6424556ef701","expires_in":2592000}
```

- scope 含有audio_voice_assistant_get表示有语音识别能力，没有的话请至网页激活
- scope 含有audio_tts_post表示有语音合成能力，没有的话请至网页激活
- expires_in 表示 2592000秒后该token失效

获得token  24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099


## 运行 asr.sh，进行识别

命令为 sh asr.sh $TOKEN
```
  sh asr.sh  24.03c7304a2ab08edc1589bb83cbe0de18.2592000.1522060569.282335-10455099
```

结果如：
```json
{"corpus_no":"6526075710854540378","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"402172223481519470408"}
```
