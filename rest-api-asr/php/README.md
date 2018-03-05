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
$apiKey = "4E1BG9lTnlSeIf1NQFlrSq6h";
# 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
$secretKey = "544ca4657ba8002e3dea3ac2f5fdd241";
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
$audio_file = "./16k.pcm";
# 文件格式
$format = "pcm"; // 文件后缀 pcm/wav/amr
# 根据文档填写PID，选择语言及识别模型
$dev_pid = 1537; //  1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型
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
$format = "amr"; // 文件后缀 pcm/wav/amr

```

   ​