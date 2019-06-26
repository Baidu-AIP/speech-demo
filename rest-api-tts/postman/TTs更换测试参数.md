## 替换鉴权信息及 测试参数
**请先测试完 [README.md](/rest-api-tts/postman/README.m)文件，再测试本文档**

### 导入json 文件（如果之前打开过可忽略此步骤）

打开Postman，点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的tts_collection.json 文件。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)

### 替换自己的App KEY 及 App Secret

1. 在开发平台百度语音应用管理界面的应用详情页查找App Key和 Secret Key 

![img](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201700.jpg)

2. 点击左侧的Token图标，选择第一个Request： "POST token" ，如下图填入App KEY（client_id) 及 App Secret(client_secret)的值，然后点击右上角的SEND 获取新的token 

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201601.png)

### 测试替换其他参数和音频文件

具体参数可以从Rest api [官方文档查看](http://ai.baidu.com/docs#/TTS-API/41ac79a6)。

1.测试不同的文本， 修改tex

```

```
![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201404.png)
2.测试合成发音人  修改per

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201405.png)


3.修改合成语速      修改spd

4.修改音调		修改pit

5.修改合成音量   	修改vol

6.修改该合成保存格式 修改 aue


