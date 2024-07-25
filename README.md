# speech-demo
项目地址：https://github.com/Baidu-AIP/speech-demo

文档地址：
- 语音识别：https://ai.baidu.com/ai-doc/SPEECH/Jlbxdezuf
- 语音合成：https://ai.baidu.com/ai-doc/SPEECH/mlbxh7xie


百度语音rest api 调用语音识别，语音合成示例

**Rest API 接口为http 访问， 任意操作系统，任意语言，只要能对baidu域名发起http请求的，均可以使用。**

百度语音合成的接口支持跨域，但是获取token的接口不支持。浏览器直接发请求的示例见：https://github.com/Baidu-AIP/SPEECH-TTS-CORS

## 简介

以JAVA PHP python C BASH 作为示例，展示rest api的调用过程，选择一个运行即可。

## 目录结构

```
+--rest-api-asr  语音识别rest api
   /--bash_shell shell脚本
   /-- java 代码 
   /-- linux_c C代码 （windows Cygwin可以运行）
   /-- php 代码
   /-- python代码
 
 +--rest-api-tts 语音合成rest api
   /--bash_shell shell脚本
   /-- java 代码 
   /-- linux_c C代码 （windows Cygwin可以运行）
   /-- php 代码
   /-- python代码
 +-- sample-files 语音识别示例音频文件
```

