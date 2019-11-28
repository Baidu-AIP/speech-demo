## 简介

使用java测试rest api 合成接口


## 测试流程

### 修改TtsMain.java

从网页中申请的应用获取appKey和appSecret

```java
    //  填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
    private final String appKey = "4E1BG9lTnlSeIf1NQFlrSq6h";

    // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    private final String secretKey = "544ca4657ba8002e3dea3ac2f5fdd241";
```






## 运行 TtsMain，进行合成



结果在result.mp3，如果遇见错误，显示在System.err内

其中

- Content-Type: audio/mp3，表示合成成功，可以播放MP3 result.mp3
- Content-Type: application/json 表示错误 。可以看到错误信息的json

### 修改合成参数

```java
   // text 的内容为"欢迎使用百度语音合成"的urlencode,utf-8 编码
    // 可以百度搜索"urlencode"
    private final String text = "欢迎使用百度语音";

    // 发音人选择, 基础音库：0为度小美，1为度小宇，3为度逍遥，4为度丫丫，
    // 精品音库：5为度小娇，103为度米朵，106为度博文，110为度小童，111为度小萌，默认为度小美 
    private final int per = 0;
    // 语速，取值0-15，默认为5中语速
    private final int spd = 5;
    // 音调，取值0-15，默认为5中语调
    private final int pit = 5;
    // 音量，取值0-9，默认为5中音量
    private final int vol = 5;

    // 下载的文件格式, 3：mp3(default) 4： pcm-16k 5： pcm-8k 6. wav
    private final int aue = 6;
```

