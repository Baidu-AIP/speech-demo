## 简介

文档介绍使用postman 脚本方式调用 REST API识别接口发起HTTP请求 

Postman是很便捷的一款HTTP API/接口功能测试工具，无需编写代码，图形化界面，能进行简单测试并查看HTTP请求的详细信息。

poatman 下载地址：https://www.getpostman.com/downloads/  点击download 下载

示例 postman版本： v7.2.2


## 测试流程
**测试目的：本文档是把16k.pcm音频文件转换成文本 “北京科技馆”**
1. 使用postman打开json文件 
2. 点击token请求页面，获取鉴权用的token
3. 点击asr_raw请求页面，填入上一步获得的token，及选择需要识别的音频文件，调用语音识别接口

###  导入Json文件

打开Postman,点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的postman_collection.json 文件生成Collection。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)


###  获取token

点击左侧导入的Token，选择第一个Request： "POST token" ，点击Send按钮完成token获取，获取结果如下

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201401.png)


结果如：
```
24.e12f4404d743f08214074a7c0cf36cf4.2592000.1563701134.282335-15803531
```

小结：通过网页上的官方控制台应用的 App KEY 及 App Secret 分别填入client_id，client_secret字段，获取鉴权信息（即token）。
温馨提示：Access Token的有效期为2592000（以秒为单位），请您集成时注意在程序中定期请求新的token。

### Raw 方式上传


1.点击之前左侧导入的Token，选择第二个POST asr ，将上一步获取的token的值填入token字段，如下图

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201402.png)


2.在 Body 下方的binary 删除原来的文件名，点击Select File，选择本目录下的16k.pcm音频文件，最后点击Send （如下图）

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

小结： raw方式上传本地文件发起HTTP请求, 语音数据直接放在 HTTP BODY 中，请求参数通过header和url进行传递。

另一种POST方式请求暂时不提供示例，因postman构造json比较复杂。需要的话，可以参见官方文档或者本项目的其它语言实现

## 更换测试参数
如何替换替换自己应用的 App KEY 及 App Secret 以及其他HTTP请求参数，请参考文档  [更换测试参数](/rest-api-asr/postman/更换测试参数.md)

## postman的几个实用功能
postman的几个使用功能请查看 [postman实用功能](/rest-api-asr/postman/postman实用功能.md) 

