## 


使用postman 脚本方式测试rest api 识别接口

示例postman版本

## 测试流程

选择JSON方式上传或者Raw 方式上传之一进行测试，本文以Raw 方式上传为例，以下文档同样适用于JSON方式上传



### 填写鉴权信息获取token

获取AccessToken 需要您在应用管理界面中新建应用，应用列表中即可查看。 开放平台上： 
http://bos.nj.bpc.baidu.com/v1/agroup/371599f441b47a29b63efd6d86e23c16df396223
```
# 填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
$API_KEY =  "kVcnfD9iW2XVZSMaLMrtLYIz";

# 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
$SECRET_KEY = "O9o1O213UgG5LFn0bDGNtoRN3VWl2du6";

![测试图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/20190612154652.jpg)
        
```

打开Postman 点击左上角+号
修改上传方式为POST，re'quest url 填写 https://openapi.baidu.com/oauth/2.0/token
然后再下方Params 填写grant_type ，client_id， client_secret及其对应的VALUE（如下图）点击Send 获取token

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906191700.png)

Access Token 有效期为30天，开发者需要对 Access Token的有效性进行判断，如果Access Token过期可以重新获取。



目前 API 仅支持**整段语音**识别的模式，即需要上传完整语音文件进行识别。文件大小不超过10M，时长不超过60s。 语音数据上传POST方式有2种：

1. JSON格式POST上传本地文件。
2. raw格式POST上传本地文件。

- 请求地址

| 语音识别模型   | 请求地址                                                     |
| :------------- | :----------------------------------------------------------- |
| 语音识别       | http://vop.baidu.com/server_api https://vop.baidu.com/server_api http://vop.baidubce.com/server_api (服务端部署在百度云时，调用该地址可免外网流量费用，且返回识别结果速度更快) |
| 语音识别极速版 | https://vop.baidu.com/pro_api                                |

## 文件样例

推荐16K采样率 pcm文件

- [16k 采样率pcm文件样例下载](http://speech-doc.gz.bcebos.com/rest-api-asr/public_audio/16k.pcm)

- [16k 采样率wav文件样例下载](http://speech-doc.gz.bcebos.com/rest-api-asr/public_audio/16k.wav)

- [16k 采样率amr文件样例下载](http://speech-doc.gz.bcebos.com/rest-api-asr/public_audio/16k-23850.amr)

  

  

## 示例选择Raw 方式上传

即 raw格式POST上传本地文件 语音数据直接放在 HTTP BODY 中，控制参数以及相关统计信息通过 header和url里参数传递。

点击左上角+号
修改上传方式为POST，re'quest url 填写 http://vop.baidu.com/server_api （如下图）
![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906191705.png)
然后再下方Params 填写dev_pid，cuid， token及其对应的VALUE
![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906191710.png)
Header 下方填写Content-Type及其对应的VALUE audio/pcm;rate=16000）（如下图）
![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906191715.png)
Body下 选择binary 然后上传官方测试音频 16k.pcm 最后点击Send 获取识别结果
![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906191720.png)
结果如：
```json
{
    "corpus_no": "6704185590893646599",
    "err_msg": "success.",
    "err_no": 0,
    "result": [
        "北京科技馆"
    ],
    "sn": "891441483431560939846"
}
```

### 测试其它音频文件

修改以下参数：


1. 如测试英语 修改为:

```Params下
dev_pid 的value 更改为 1737;
```

1. 如测试采样率为16k 的amr文件16k-23850.amr，更改为：

```
# 上传需要识别的文件

# 文件格式
audio/amr;rate=16000; // 文件后缀 pcm/wav/amr
```


