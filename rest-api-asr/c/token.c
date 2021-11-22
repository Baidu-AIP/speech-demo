/**
 * @brief token获取类，该类未根据http返回字段expires_in做token缓存
 */
#include <stdio.h>
#include <stdlib.h>
#include <memory.h>
#include <curl/curl.h> // 依赖libcurl
#include "token.h"

const char API_TOKEN_URL[] = "https://aip.baidubce.com/oauth/2.0/token";

const int MAX_TOKEN_SIZE = 100;


// 解析response json ， 获取token，验证scope信息
RETURN_CODE
speech_get_token(const char *api_key, const char *secret_key, const char *scope, char *token) {
    char url_pattern[] = "%s?grant_type=client_credentials&client_id=%s&client_secret=%s";
    char url[200];
    char *response = NULL;

    snprintf(url, 200, url_pattern, API_TOKEN_URL, api_key, secret_key);
    printf("url is: %s\n", url);
    CURL *curl = curl_easy_init();
    curl_easy_setopt(curl, CURLOPT_URL, url); // 注意返回值判读
    curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 5);
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 60); // 60s超时
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);

    CURLcode res_curl = curl_easy_perform(curl);
    RETURN_CODE res = RETURN_OK;
    if (res_curl != CURLE_OK) {
        snprintf(g_demo_error_msg, BUFFER_ERROR_SIZE, "perform curl error:%d, %s.\n", res,
                 curl_easy_strerror(res_curl));
        res = ERROR_TOKEN_CURL;
    } else {
        res = parse_token(response, scope, token); // 解析token，结果保存在token里
        if (res == RETURN_OK) {
            printf("token: %s of %s\n", token, response);
        }
    }
    free(response);
    curl_easy_cleanup(curl);
    return res;
}

// 解析json，获取某个key对应的value ;为了不引用第三方json库，仅仅做简单的字符串操作
// 正式使用请使用json库解析，json库解析推荐@see www.json.org
RETURN_CODE parse_token(const char *response, const char *scope, char *token) {
    //  ====  获取 token字段 =========
    RETURN_CODE res = obtain_json_str(response, "access_token", token, MAX_TOKEN_SIZE);
    if (res != RETURN_OK) {
        snprintf(g_demo_error_msg, BUFFER_ERROR_SIZE, "parse token error: %s\n", response);
        return ERROR_TOKEN_PARSE_ACCESS_TOKEN;
    }

    // ==== 检查scope =========
    char scopes[400];
    res = obtain_json_str(response, "scope", scopes, 400);
    if (res != RETURN_OK) {
        snprintf(g_demo_error_msg, BUFFER_ERROR_SIZE, "parse scope error: %s\n", response);
        return ERROR_TOKEN_PARSE_ACCESS_TOKEN;
    }
    if (strlen(scope) > 0) {
        char *scope_pos = strstr(scopes, scope);
        if (scope_pos == NULL) {
            snprintf(g_demo_error_msg, BUFFER_ERROR_SIZE, "scope： %s not exist in:%s \n", scope,
                     response);
            return ERROR_TOKEN_PARSE_SCOPE;
        }
    }
    return RETURN_OK;
}

RETURN_CODE obtain_json_str(const char *json, const char *key, char *value, int value_size) {
    int len = 4 + strlen(key) + 1;
    char search_key[len];
    snprintf(search_key, len, "\"%s\":\"", key);
    char *start = strstr(json, search_key);
    if (start == NULL) { // 没有找到
        fprintf(stderr, "%s key not exist\n", key);
        return RETURN_ERROR;
    }

    start += strlen(search_key);
    char *end = strstr(start, "\"");
    // 最大可复制的string
    int copy_size = (value_size < end - start) ? value_size : end - start;
    snprintf(value, copy_size + 1, "%s", start);
    return RETURN_OK;
}
