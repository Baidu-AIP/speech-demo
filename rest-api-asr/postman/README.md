## 简介

文档介绍使用postman 脚本方式调用 rest api 识别接口 

Postman是很好用的一款API/接口功能测试工具，很方便的塞数据，查看响应，设置检查点/断言，能进行一定程度上的自动化测试，但是不要指望它能代替你进行性能测试，一次批量执行太多太久的话容易崩溃掉。

poatman 下载地址：https://www.getpostman.com/downloads/  点击download 下载

示例 postman版本： v7.2.2


## 测试流程

首先在您创建的应用中查找Api Key 和 SecretKey。访问https://openapi.baidu.com/oauth/2.0/token 换取 token；
利用换取的token，并填写必要参数调用本接口



###  获取token


1. 打开Postman,点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的postman_collection.json 文件。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)

2. 点击左侧导入的Token，选择第一个POST token，点击Send按钮完成token获取，获取结果如下

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201401.png)


  

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

如何替换替换自己的AK SK以及其他参数，请参考文档   <a href="/rest-api-asr/postman/更换测试参数.md">更换测试参数 </a>文档



