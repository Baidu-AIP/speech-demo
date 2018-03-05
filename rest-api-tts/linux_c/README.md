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

sh build_and_tts.sh  编译及运行

### 修改ttsmain.c

从网页中申请的应用获取appKey和appSecret

```c

static RETURN_CODE fill_config(struct tts_config *config) {
    // 填写网页上申请的appkey 如 g_api_key="g8eBUMSokVB1BHGmgxxxxxx"
    char api_key[] = "4E1BG9lTnlSeIf1NQFlrSq6h";
    // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    char secret_key[] = "544ca4657ba8002e3dea3ac2f5fdd241";
```





### 测试其它合成参数



修改以下参数：

```c
static RETURN_CODE fill_config(struct tts_config *config) {
    // 填写网页上申请的appkey 如 g_api_key="g8eBUMSokVB1BHGmgxxxxxx"
    char api_key[] = "4E1BG9lTnlSeIf1NQFlrSq6h";
    // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    char secret_key[] = "544ca4657ba8002e3dea3ac2f5fdd241";

    // text 的内容为"欢迎使用百度语音合成"的urlencode,utf-8 编码
    // 可以百度搜索"urlencode"
    char text[] = "欢迎使用百度语音";

    // 发音人选择, 0为普通女声，1为普通男生，3为情感合成-度逍遥，4为情感合成-度丫丫，默认为普通女声
    int per = 0;
    // 语速，取值0-9，默认为5中语速
    int spd = 5;
    // #音调，取值0-9，默认为5中语调
    int pit = 5;
    // #音量，取值0-9，默认为5中音量
    int vol = 5;
```


