//
// Created by fu on 3/1/18.
//

#ifndef SPEECH_C_DEMO_ASRMAIN_H
#define SPEECH_C_DEMO_ASRMAIN_H

#include "token.h"

struct asr_config {
    char api_key[40]; // 填写网页上申请的appkey 如 $apiKey="g8eBUMSokVB1BHGmgxxxxxx"
    char secret_key[40]; // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    FILE *file;  // 需要识别的本地文件
    char format[4];
    int rate;
    int dev_pid;
    char cuid[20];
};

extern const char ASR_SCOPE[];
/**
 * @brief 启动，并获取token
 * @return
 */
RETURN_CODE run();

/**
 * @brief 实际运行
 * @param config 设置
 * @param token appkey appsecret换取的token
 * @return
 */
RETURN_CODE run_asr(struct asr_config *config, const char *token);

/**
 * @brief 将文件读出，返回
 * @param fp in 文件
 * @param content_len out 文件大小
 * @return 结果需要自行释放 free
 */
char *read_file_data(FILE *fp, int *content_len);

#endif //SPEECH_C_DEMO_ASRMAIN_H
