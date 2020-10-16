
## 简介

文档介绍使用postman 脚本方式调用 REST API合成接口发起HTTP请求

Postman是很便捷的一款HTTP API/接口功能测试工具，无需编写代码，图形化界面，能进行简单测试并查看HTTP请求的详细信息。

poatman 下载地址：https://www.getpostman.com/downloads/ 点击download 下载

示例 postman版本： v7.2.2

## 测试流程
**测试目的：本文档是把文本“百度你好”转换成MP3音频文件**

1.使用postman打开Tts.postman_collection.json文件

2.点击token请求页面，获取鉴权用的token。如果请求返回结果成功，postman执行tests中代码，将token自动保存到环境变量中。

3.点击tts请求页面，从环境变量中自动读取上一步获得的token，调用语音合成接口生成音频文件

### 导入Json文件

打开Postman,点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的Tts.postman_collection.json 文件。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)

### 获取token


1. 点击左侧的Tts图标，选择第一个Request："POST token"，点击Send按钮完成token获取，获取结果如下

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-tts/postman/doc-images/201906261701.png)

结果如：
```
24.e12f4404d743f08214074a7c0cf36cf4.2592000.1563701134.282335-15803531
```
小结：通过网页上的官方控制台应用的 App KEY 及 App Secret 分别填入client_id，client_secret字段，获取鉴权信息（即token）。
温馨提示：Access Token的有效期为2592000（以秒为单位），请您集成时注意在程序中定期请求新的token。

### 访问合成接口 

1.点击之前左侧导入的Tts，选择第二个POST tts，在Body下x-www-form-urlencoded引用环境变量中保存的token值 {{baidu_access_token}}，最后点击Send 测试；合成完成后，可以点击播放按钮试听，也可以点击右下角的download 下载合成音频文件 如下图

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-tts/postman/doc-images/201906261702.png)
![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-tts/postman/doc-images/201906261703.png)


##  更换测试参数
如何替换替换自己应用的 App KEY 及 App Secret 以及其他HTTP请求参数，请参考文档 [更换测试参数.md](/rest-api-tts/postman/更换测试参数.md) 

## postman的几个实用功能
postman的几个使用功能请查看 [postman实用功能](/rest-api-asr/postman/postman实用功能.md) 

