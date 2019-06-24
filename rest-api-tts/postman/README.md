## 简介

文档介绍使用postman 脚本方式调用 REST API识别接口发起HTTP请求

Postman是很好用的一款HTTP API/接口功能测试工具，很方便，无需编写代码，图形化界面，能进行简单测试并查看HTTP请求的详细信息。

poatman 下载地址：https://www.getpostman.com/downloads/ 点击download 下载

示例 postman版本： v7.2.2

### 测试流程

1.使用postman打开json文件
2.点击token请求页面，获取鉴权用的token
3.点击tts请求页面，填入上一步获得的token，及选择需要识别的音频文件，调用语音合成接口生成音频文件

## 导入Json文件

打开Postman,点击左上方的Import，在弹出的窗口点击“Choose Files” 选择本文档同目录下的tts_collection.json 文件。

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201400.png)

###  填写鉴权信息获取token

获取AccessToken 需要您在应用管理界面中新建应用，应用列表中即可查看。 开放平台上： 

![img](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201700.jpg)

1. 点击左侧导入的Token，选择第一个POST token，点击Send按钮完成token获取，获取结果如下

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906201401.png)

Access Token 有效期为30天，开发者需要对 Access Token的有效性进行判断，如果Access Token过期可以重新获取。





1.点击之前左侧导入的Token，选择第三个POST tts，在Body下x-www-form-urlencoded替换刚才获取的token的值，最后点击Send 测试；合成完整后，可点击右下角的download 下载合成音频文件 如下图

![图片](https://raw.githubusercontent.com/Baidu-AIP/speech-demo/master/rest-api-asr/postman/doc-images/201906211400.png)

## 修改合成参数

1.修改合成文本

2.修改合成发音人

3.修改合成语速

4.修改音调

5.修改合成音量

6.修改该合成保存格式



