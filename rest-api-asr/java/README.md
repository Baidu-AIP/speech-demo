## 简介

java 调用rest api识别接口




## 测试流程

src目录下的文件及测试音频放置ide中，修改AsrMain.java的文件，运行即可。



### 修改AsrMain.java

从网页中申请的应用获取appKey和appSecret

```java
    //  填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
    private final String appKey = "4E1BG9lTnlSeIf1NQFlrSq6h";

    // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    private final String secretKey = "544ca4657ba8002e3dea3ac2f5fdd241";
```




## 运行AsrMain中main方法，进行识别

```java
public boolean methodRaw = false; // 默认以json方式上传音频文件
```



结果如：
```json
{"corpus_no":"6526739038479082049","err_msg":"success.","err_no":0,"result":["北京科技馆，"],"sn":"766059849441519624850"}
```



### 测试其它音频文件



修改以下参数：

```java
// 需要识别的文件
private final String filename = "16k_test.pcm";

// 文件格式
private final String format = "pcm";

//  1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型。 其它语种参见文档
private final int dev_pid = 1537;
```



1. 如测试英语 修改为:

```bash
$dev_pid = 1737;
```

2. 如测试采样率为16k 的amr文件16k-23850.amr，修改为：

```java
// 需要识别的文件
private final String filename = "16k-23850.amr";

// 文件格式
private final String format = "amr";

```

   ​