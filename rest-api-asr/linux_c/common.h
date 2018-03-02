//
// Created by fu on 3/2/18.
//

#ifndef SPEECH_C_DEMO_COMMON_H
#define SPEECH_C_DEMO_COMMON_H

/**
 * @brief 函数返回值定义
 */
typedef enum RETURN_CODE {
    RETURN_OK = 0, // 返回正常
    RETURN_ERROR = 1, // 返回错误
    ERROR_TOKEN_CURL = 13, // TOKEN CURL 调用错误
    ERROR_TOKEN_PARSE_ACCESS_TOKEN = 15,  // access_token字段在返回结果中不存在
    ERROR_TOKEN_PARSE_SCOPE = 16, // 解析scope字段，或者scope不存在
    ERROR_ASR_FILE_NOT_EXIST = 101, // 本地文件不存在
    ERROR_ASR_CURL = 102 // 识别 curl 错误
} RETURN_CODE;

/**
 * @brief 全局的报错信息，遇见报错，代码应该停止
 */
extern const int BUFFER_ERROR_SIZE;

extern char g_demo_error_msg[];

/**
 * @see libcurl CURLOPT_WRITEFUNCTION
 *
 * @brief curl回调，http请求的结果在result中，注意需要释放free(*result);
 * @param ptr
 * @param size
 * @param nmemb
 * @param result 传入时必需是NULL， 使用后自行释放
 * @return
 */
size_t writefunc(void *ptr, size_t size, size_t nmemb, char **result);

#endif //SPEECH_C_DEMO_COMMON_H
