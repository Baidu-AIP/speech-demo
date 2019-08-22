## 简介

java 调用rest api识别接口



##代码目录
项目为gradle项目，实际的java代码放在```java\src\main\java```目录下

AsrMain.java为主类，放在```java\src\main\java\com\baidu\speech\restapi\asrdemo```目录下






## 测试流程

以下3个方法三选一均可测试

- java\src\main\java目录下的文件及测试音频。16k.pcm放置ide中，修改AsrMain.java的文件，运行即可。
- 直接以IDEA IDE项目打开
- 运行 sh gradlew run -Dfile.encoding=UTF-8 ; windows 下 gradlew run -Dfile.encoding=UTF-8

#### 如果您选择第1个方式，可以新建一个helloworld项目，
1） 测试helloworld 通过

2） 将java\src\main\java目录下的 com和org整体复制到Main.java(helloworld的代码）同一级目录。

3） 16k.pcm 放置项目的根目录

4） 选择com/baidu/speech/restapi/asrdemo/AsrMain.java 运行


### 修改AsrMain.java

从网页中申请的应用获取appKey和appSecret

```java
    //  填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
    private final String APP_KEY = "kVcnfD9iW2XVZSMaLMrtLYIz";

    // 填写网页上申请的APP SECRET 如 $SECRET_KEY="94dc99566550d87f8fa8ece112xxxxx"
    private final String SECRET_KEY = "O9o1O213UgG5LFn0bDGNtoRN3VWl2du6";
```




## 运行AsrMain中main方法，进行识别

```java
private final boolean METHOD_RAW = false; // 默认以json方式上传音频文件
```



结果如：
```json
{"corpus_no":"6526739038479082049","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"766059849441519624850"}
```



### 测试其它音频文件



修改以下参数：

```java
// 需要识别的文件
private final String FILENAME = "16k.pcm";

// 文件格式, 支持pcm/wav/amr 格式，极速版额外支持m4a 格式
private final String FORMAT = FILENAME.substring(FILENAME.length() - 3);

DEV_PID = 1537;
```



1. 如测试英语 修改为:

```bash
DEV_PID = 1737;
```

2. 如测试采样率为16k 的amr文件16k-23850.amr，修改为：

```java
// 需要识别的文件
private final String FILENAME = "16k-23850.amr";


```


## 测试极速版


打开下面的注释：

```java
{
        URL =   "http://vop.baidu.com/pro_api"; // 可以改为https
        DEV_PID = 80001;
        SCOPE = "brain_enhanced_asr";
    }
```
另外极速版在支持文件后缀 pcm/wav/amr基础上还单独额外支持m4a文件 

## 测试自训练平台

自训练平台模型上线后，您会看见 第二步：“”获取专属模型参数pid:8001，modelid:1234”，按照这个信息获取 dev_pid=8001，lm_id=1234	
打开下面的注释：
```java
		private int LM_ID;

{
        DEV_PID = 8001;
        LM_ID = 1234；
    }

    	String url2 = URL + "?cuid=" + ConnUtil.urlEncode(CUID) + "&dev_pid=" + DEV_PID + "&lm_id="+ LM_ID + "&token=" + token;
```