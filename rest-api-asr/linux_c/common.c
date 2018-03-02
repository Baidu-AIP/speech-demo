//
// Created by fu on 3/2/18.
// 定义常量
//
#include <stdio.h>
#include <memory.h>
#include <stdlib.h>

const int BUFFER_ERROR_SIZE = 1024;
char g_demo_error_msg[1024] = {0};

// libcurl 返回回调
size_t writefunc(void *ptr, size_t size, size_t nmemb, char **result) {
    size_t result_len = size * nmemb;
    if (*result == NULL) {
        *result = (char *) malloc(result_len + 1);
    } else {
        *result = (char *) realloc(*result, result_len + 1);
    }
    if (*result == NULL) {
        printf("realloc failure!\n");
        return 1;
    }
    memcpy(*result, ptr, result_len);
    (*result)[result_len] = '\0';
    // printf("buffer: %s\n", *result);
    return result_len;
}