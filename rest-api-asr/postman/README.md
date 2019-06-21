## 简介

文档介绍使用postman 脚本方式调用 rest api 识别接口 

Postman是很好用的一款API/接口功能测试工具，很方便，无需编写代码，图形化界面，对于没有官方demo提供的编程语言，能进行一定程度上的自动化测试。

poatman 下载地址：https://www.getpostman.com/downloads/  点击download 下载

示例 postman版本： v7.2.2


## 测试流程

首先在您创建的应用中查找Api Key 和 SecretKey。访问https://openapi.baidu.com/oauth/2.0/token 换取 token；
利用换取的token，并填写必要参数调用本接口





###  导入Json文件

1. 打开Postman,点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的postman_collection.json 文件。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)


###  获取token

1. 点击左侧导入的Token，选择第一个POST token，点击Send按钮完成token获取，获取结果如下

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201401.png)


结果如：
```
"access_token": "24.e12f4404d743f08214074a7c0cf36cf4.2592000.1563701134.282335-15803531",
```

小结：通过网页上的官方控制台上 client_id和client_secret 获取鉴权信息（即token）。

## Raw 方式上传



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

即 raw格式POST上传本地文件 语音数据直接放在 HTTP BODY 中，控制参数以及相关统计信息通过 header和url里参数传递。

如何替换替换自己的AK SK以及其他参数，请参考文档   <a href="/rest-api-asr/postman/更换测试参数.md">更换测试参数 </a>文档



