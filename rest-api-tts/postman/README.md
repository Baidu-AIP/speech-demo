
## 简介

文档介绍使用postman 脚本方式调用 REST API合成接口发起HTTP请求

Postman是很好用的一款HTTP API/接口功能测试工具，很方便，无需编写代码，图形化界面，能进行简单测试并查看HTTP请求的详细信息。

poatman 下载地址：https://www.getpostman.com/downloads/ 点击download 下载

示例 postman版本： v7.2.2

## 测试流程
**测试目的：本文档是把文本“百度你好”转换成MP3音频文件**

1.使用postman打开json文件

2.点击token请求页面，获取鉴权用的token

3.点击tts请求页面，填入上一步获得的token，调用语音合成接口生成音频文件

### 导入Json文件

打开Postman,点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的tts_collection.json 文件。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)

### 获取token


1. 点击左侧的Tts图标，选择第一个Request："POST token"，点击Send按钮完成token获取，获取结果如下

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-tts/postman/doc-images/201906261701.png)

小结：通过网页上的官方控制台应用的 App KEY 及 App Secret 分别填入client_id，client_secret字段，获取鉴权信息（即token）。

### 访问合成接口 

1.点击之前左侧导入的Tts，选择第二个POST tts，在Body下x-www-form-urlencoded替换刚才获取的token的值，最后点击Send 测试；合成完成后，可以点击播放按钮试听，也可以点击右下角的download 下载合成音频文件 如下图

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-tts/postman/doc-images/201906261702.png)
![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-tts/postman/doc-images/201906261703.png)


##  更换测试参数
如何替换替换自己应用的 App KEY 及 App Secret 以及其他HTTP请求参数，请参考文档 [更换测试参数.md](/rest-api-tts/postman/更换测试参数.md) 



