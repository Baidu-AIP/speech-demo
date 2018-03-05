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
apt-get install libcurl3

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

sh build_and_asr.sh  编译及运行

### 修改asrmain.c

从网页中申请的应用获取appKey和appSecret

```c

static RETURN_CODE fill_config(struct asr_config *config) {
    // 填写网页上申请的appkey 如 g_api_key="g8eBUMSokVB1BHGmgxxxxxx"
    char api_key[] = "4E1BG9lTnlSeIf1NQFlrSq6h";
    // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    char secret_key[] = "544ca4657ba8002e3dea3ac2f5fdd241";
```





### 测试其它音频文件



修改以下参数：

```c
static RETURN_CODE fill_config(struct asr_config *config) {
    ...
    // 需要识别的文件
    char *filename = "16k_test.pcm";
    // 文件后缀 pcm/wav/amr ,不支持其它格式
    char format[] = "pcm";
    
    //  1537 表示识别普通话，使用输入法模型。1536表示识别普通话，使用搜索模型 其它语种参见文档
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
// 文件后缀 pcm/wav/amr ,不支持其它格式
char format[] = "amr";
```

   ​