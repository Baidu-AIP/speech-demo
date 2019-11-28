## 简介

使用python脚本方式测试rest api 合成接口

- 支持python 2.7 及 python 3.7+, 其它版本自行测试



## 测试流程

### 修改tts.py

从网页中申请的应用获取appKey和appSecret

```python
# 填写网页上申请的appkey 如 API_KEY="g8eBUMSokVB1BHGmgxxxxxx"
API_KEY = '4E1BG9lTnlSeIf1NQFlrxxxx'

# 填写网页上申请的APP SECRET 如 SECRET_KEY="94dc99566550d87f8fa8ece112xxxxx"
SECRET_KEY = '544ca4657ba8002e3dea3ac2f5fxxxxx'
```






## 运行 tts.py，进行合成

命令为 python tts.py

结果在result.mp3，如果遇见错误，结果在error.txt

其中

- Content-Type: audio/mp3，表示合成成功，可以播放MP3 result.mp3
- Content-Type: application/json 表示错误   error.txt打开可以看到错误信息的json

### 修改合成参数

```python
TEXT = "欢迎使用百度语音";

# 发音人选择, 基础音库：0为度小美，1为度小宇，3为度逍遥，4为度丫丫，
# 精品音库：5为度小娇，103为度米朵，106为度博文，110为度小童，111为度小萌，默认为度小美 
PER = 0;
#语速，取值0-9，默认为5中语速
SDP = 5;
#音调，取值0-9，默认为5中语调
PIT = 5;
#音量，取值0-9，默认为5中音量
VOL = 5;

CUID = "123456PYTHON";

```

