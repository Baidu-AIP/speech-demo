## 简介

使用php 脚本方式测试rest api 识别接口

PHP版本5.x 5.3以上



- windows 下需要安装 php, 及php curl扩展



## 测试流程

选择asr_json.php或者asr_raw.php之一进行测试，本文以asr_json.php为例，以下文档同样适用于asr_raw.php



### 修改asr_json.php

从网页中申请的应用获取appKey和appSecret

```php
# 填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
$API_KEY =  "kVcnfD9iW2XVZSMaLMrtLYIz";

# 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
$SECRET_KEY = "O9o1O213UgG5LFn0bDGNtoRN3VWl2du6";
```




## 运行asr_json.php，进行识别

命令为 php asr_json.php



结果如：
```json
{"corpus_no":"6526739038479082049","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"766059849441519624850"}
```

windows 下可能产生乱码，请打开result.txt

### 测试其它音频文件



修改以下参数：

```php
# 需要识别的文件
$AUDIO_FILE = "./16k_test.pcm";
# 文件格式
$FORMAT = substr($AUDIO_FILE, -3); // 文件后缀 pcm/wav/amr 格式，极速版额外支持m4a 格式
```



1. 如测试英语 修改为:

```bash
$dev_pid = 1737;
```

2. 如测试采样率为16k 的amr文件16k-23850.amr，修改为：

```bash
# 需要识别的文件
$audio_file = "./16k-23850.amr";
# 文件格式
$format = "amr"; // 文件后缀 pcm/wav/amr 格式，极速版额外支持m4a 格式

```
## 测试极速版
打开下面的注释：

        $ASR_URL = "https://vop.baidu.com/pro_api";
        $DEV_PID = 80001; 
        $SCOPE = 'brain_enhanced_asr'; 

另外极速版在支持文件后缀 pcm/wav/amr基础上还单独额外支持m4a文件
   ​
