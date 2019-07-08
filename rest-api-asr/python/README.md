## 简介

使用python 脚本方式测试rest api 识别接口

**支持 python 2.7 及 python 3.7+**



## 测试流程

选择asr_json.py或者asr_raw.py之一进行测试，本文以asr_json.py为例，以下文档同样适用于asr_raw.py



### 修改asr_json.py

从网页中申请的应用获取appKey和appSecret

```python
# 填写网页上申请的appkey 如 API_KEY="g8eBUMSokVB1BHGmgxxxxxx"
API_KEY = '4E1BG9lTnlSeIf1NQFlrxxxx'

# 填写网页上申请的APP SECRET 如 SECRET_KEY="94dc99566550d87f8fa8ece112xxxxx"
SECRET_KEY = '544ca4657ba8002e3dea3ac2f5fxxxxx'
```




## 运行asr_json.py，进行识别

命令为 python asr_json.py



结果如：
```json
{"corpus_no":"6595003755536106531","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"611278720461535518969"}
```

windows 下显示可能产生乱码，请打开result.txt

### 测试其它音频文件



修改以下参数：

```python
# 需要识别的文件
AUDIO_FILE = "./16k.pcm";
# 文件格式
FORMAT = "pcm"; # 文件后缀 pcm/wav/amr 格式，极速版额外支持m4a 格式
# 根据文档填写PID，选择语言及识别模型
DEV_PID = 1537; #  1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型
```



1. 如测试英语 修改为:

```python
DEV_PID = 1737;
```

2. 如测试采样率为16k 的amr文件16k-23850.amr，修改为：

```python
# 需要识别的文件
AUDIO_FILE = "./16k-23850.amr";
# 文件格式
FORMAT = "amr"; // 文件后缀 pcm/wav/amr 格式，极速版额外支持m4a 格式

```

   

## 测试极速版

打开下面的注释

```python
# 极速版

DEV_PID = 80001
ASR_URL = 'http://vop.baidu.com/pro_api'
SCOPE = 'brain_enhanced_asr'  # 有此scope表示有收费极速版能力，没有请在网页里开通极速版


```
另外极速版在支持文件后缀 pcm/wav/amr基础上还单独额外支持m4a文件 
