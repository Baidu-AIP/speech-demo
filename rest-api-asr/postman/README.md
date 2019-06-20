## 简介

文档介绍使用postman 脚本方式调用 rest api 识别接口 

Postman是很好用的一款API/接口功能测试工具，很方便的塞数据，查看响应，设置检查点/断言，能进行一定程度上的自动化测试，但是不要指望它能代替你进行性能测试，一次批量执行太多太久的话容易崩溃掉。

poatman 下载地址：https://www.getpostman.com/downloads/  点击download 下载
示例 postman版本： v7.2.2


## 测试流程

选择JSON方式上传或者Raw 方式上传之一进行测试，本文以Raw 方式上传为例，以下文档同样适用于JSON方式上传



###  填写鉴权信息获取token

获取AccessToken 需要您在应用管理界面中新建应用，应用列表中即可查看。 开放平台上： 

![img](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201700.jpg)


1. 打开Postman,点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的postman_collection.json 文件。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)

2. 点击左侧导入的Token，选择第一个POST token，点击Send按钮完成token获取，获取结果如下

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201401.png)

Access Token 有效期为30天，开发者需要对 Access Token的有效性进行判断，如果Access Token过期可以重新获取。



目前 API 仅支持**整段语音**识别的模式，即需要上传完整语音文件进行识别。文件大小不超过10M，时长不超过60s。 语音数据上传POST方式有2种：

1. JSON格式POST上传本地文件。
2. raw格式POST上传本地文件。

- 请求地址

| 语音识别模型   | 请求地址                                                     |
| :------------- | :----------------------------------------------------------- |
| 语音识别       | http://vop.baidu.com/server_api https://vop.baidu.com/server_api http://vop.baidubce.com/server_api (服务端部署在百度云时，调用该地址可免外网流量费用，且返回识别结果速度更快) |
| 语音识别极速版 | https://vop.baidu.com/pro_api                                |



  

  

## Raw 方式上传

即 raw格式POST上传本地文件 语音数据直接放在 HTTP BODY 中，控制参数以及相关统计信息通过 header和url里参数传递。

1.点击之前左侧导入的Token，选择第二个POST asr ，在Params下替换刚才获取的token的值，如下图

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201402.png)


3.在 Body 下方的binary 删除原来的文件名，点击Select File，选择官方的pcm音频文件，最后点击Send （如下图）

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201403.png)


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

如何替换替换自己的AK SK已经其他参数，请参考文档 更换测试参数(https://github.com/Baidu-AIP/speech-demo/blob/master/rest-api-asr/postman/%E6%9B%B4%E6%8D%A2%E6%B5%8B%E8%AF%95%E5%8F%82%E6%95%B0.md) 文档



