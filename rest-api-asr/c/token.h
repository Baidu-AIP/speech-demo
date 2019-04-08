//
// Created by fu on 3/2/18.
//

#ifndef SPEECH_C_DEMO_TOKEN_H
#define SPEECH_C_DEMO_TOKEN_H

#include "common.h"

extern const char API_TOKEN_URL[];

extern const int MAX_TOKEN_SIZE;

/**
 * @brief 获取token ,调用 parse_token解析结果。 注意结果里的expires_in， 本示例sample未作处理
 * @param api_key in 用户网页上申请的应用获取appKey
 * @param secret_key in 用户网页上申请的应用获取appi_key
 * @param scope in 应用开通的权限
 * @param token out 获取的token
 * @return RETURN_OK 成功 其它失败
 */
RETURN_CODE speech_get_token(const char *api_key,
                             const char *secret_key, const char *scope, char *token);

/**
 * @brief 解析response json ， 获取token，验证scope信息
 * @param response in 接口返回的json
 * @param scope in scope 语音识别能力或者语音合成能力
 * @param token out 解析出的token
 * @return RETURN_OK 成功 其它失败
 */
RETURN_CODE parse_token(const char *response, const char *scope, char *token);

/**
 * @brief 解析json，获取某个key对应的value
 * @param json in 原始json字符串
 * @param key in json key
 * @param value out 输出的结果
 * @param value_size in value的最大size
 * @return
 */
RETURN_CODE obtain_json_str(const char *json, const char *key, char *value, int value_size);

#endif //SPEECH_C_DEMO_TOKEN_H
