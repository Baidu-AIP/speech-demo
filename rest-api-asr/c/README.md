## 简介

使用C 代码测试本地音频文件的识别流程。

项目仅依赖libcurl库，编译命令为gcc

## 环境准备

目前支持Linux和windows的cygwin环境

### libcurl 库

```bash
#linux centos
yum install libcurl-devel

# linux ubuntu 一般已经安装
apt-get install libcurl3-dev 
# 或 apt-get install libcurl4-openssl-dev

#cygwin
#运行setup-x86_64.exe，输入libcurl-devel搜索
```



gcc

```bash
gcc -v #验证版本

#linux centos
yum groupinfo Development tools

# linux ubuntu
apt-get  install  build-essential

#cygwin
#运行setup-x86_64.exe，输入gcc-core搜索 
```






## 测试流程

cd  项目目录

以下三种方式选择一种运行即可

1. sh build_and_asr.sh  编译及运行

2. mkdir build && cd build && cmake .. && make && cd .. && build/restapi_asr
3. 从Clion IDE中打开运行



### 修改asrmain.c

从网页中申请的应用获取appKey和appSecret

```c

static RETURN_CODE fill_config(struct asr_config *config) {
     // 填写网页上申请的appkey 如 g_api_key="g8eBUMSokVB1BHGmgxxxxxx"
    char api_key[] = "kVcnfD9iW2XVZSMaLMrtLYIz";
    // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    char secret_key[] = "O9o1O213UgG5LFn0bDGNtoRN3VWl2du6";

```





### 测试其它音频文件



修改以下参数：

```c
static RETURN_CODE fill_config(struct asr_config *config) {
    ...
    // 需要识别的文件
    char *filename = "16k.pcm";

    //  1537 表示识别普通话，使用输入法模型。 其它语种参见文档
    int dev_pid = 1537;
```



1. 如测试英语 修改为:

```c
int dev_pid = 1737;
```

2. 如测试采样率为16k 的amr文件16k-23850.amr，修改为：

```c
// 需要识别的文件
char *filename = "16k-23850.amr";

// 文件后缀 pcm/wav/amr/m4a 格式
char *format = filename + strlen(filename) - 3;
```

   ​



## 测试极速版

打开以下注释：

```c
 /* 极速版
    url = "http://vop.baidu.com/pro_api"; // 可改为https
    dev_pid = 80001;
    scope = "brain_enhanced_asr"; // 有此scope表示有极速版能力，没有请在网页里开通极速版 （开通后可能会收费）
    */
```

另外极速版在支持文件后缀 pcm/wav/amr/m4a文件 ​

## 测试自训练平台

自训练平台模型上线后，您会看见 第二步：“”获取专属模型参数pid:8001，modelid:1234”，按照这个信息获取 dev_pid=8001，lm_id=1234

打开以下注释：

```c
/* dev_pid = 8001 ;   
   int lm_id = 1234 ;

   snprintf(url, sizeof(url), "%s?cuid=%s&token=%s&dev_pid=%d&lm_id=%d",
         config->url, cuid, token, config->dev_pid, config->lm_id);   

    */
```
