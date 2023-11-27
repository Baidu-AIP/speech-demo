//
// Created by fu on 3/2/18.
//

#include <curl/curl.h>
#include <memory.h>
#include "common.h"
#include "ttsmain.h"
#include "token.h"
#include "ttscurl.h"

const char TTS_SCOPE[] = "audio_tts_post";
const char API_TTS_URL[] = "http://tsn.baidu.com/text2audio"; // 可改为https

RETURN_CODE fill_config(struct tts_config *config) {
    // 填写网页上申请的appkey 如 g_api_key="g8eBUMSokVB1BHGmgxxxxxx"
    char api_key[] = "4E1BG9lTnlSeIf1NQxxxxx";
    // 填写网页上申请的APP SECRET 如 $secretKey="94dc99566550d87f8fa8ece112xxxxx"
    char secret_key[] = "544ca4657ba8002e3dea3ac2f5xxxx";

    // text 的内容为"欢迎使用百度语音合成"的urlencode,utf-8 编码
    // 可以百度搜索"urlencode"
    char text[] = "欢迎使用百度语音";

    // 发音人选择, 基础音库：0为度小美，1为度小宇，3为度逍遥，4为度丫丫，
    // 精品音库：5为度小娇，103为度米朵，106为度博文，110为度小童，111为度小萌，默认为度小美 
    int per = 0;
    // 语速，取值0-9，默认为5中语速
    int spd = 5;
    // #音调，取值0-9，默认为5中语调
    int pit = 5;
    // #音量，取值0-9，默认为5中音量
    int vol = 5;
    // 下载的文件格式, 3：mp3(default) 4： pcm-16k 5： pcm-8k 6. wav
	int aue = 3;
	
    // 将上述参数填入config中
    snprintf(config->api_key, sizeof(config->api_key), "%s", api_key);
    snprintf(config->secret_key, sizeof(config->secret_key), "%s", secret_key);
    snprintf(config->text, sizeof(text), "%s", text);
    config->text_len = sizeof(text) - 1;
    snprintf(config->cuid, sizeof(config->cuid), "1234567C");
    config->per = per;
    config->spd = spd;
    config->pit = pit;
    config->vol = vol;
	config->aue = aue;
	
	// aue对应的格式，format
	const char formats[4][4] = {"mp3", "pcm", "pcm", "wav"};
	snprintf(config->format, sizeof(config->format), formats[aue - 3]);
	
    return RETURN_OK;
}

int main() {
    curl_global_init(CURL_GLOBAL_ALL);
    RETURN_CODE rescode = run();
    curl_global_cleanup();
    if (rescode != RETURN_OK) {
        fprintf(stderr, "ERROR: %s, %d", g_demo_error_msg, rescode);
    }
    return rescode;
}

RETURN_CODE run() {
    struct tts_config config;
    char token[MAX_TOKEN_SIZE];

    RETURN_CODE res = fill_config(&config);
    if (res == RETURN_OK) {
        // 获取token
        res = speech_get_token(config.api_key, config.secret_key, TTS_SCOPE, token);
        if (res == RETURN_OK) {
            // 调用识别接口
            run_tts(&config, token);
        }
    }

    return RETURN_OK;
}

// 调用识别接口
RETURN_CODE run_tts(struct tts_config *config, const char *token) {
    char params[200 + config->text_len * 9];
    CURL *curl = curl_easy_init(); // 需要释放
    char *cuid = curl_easy_escape(curl, config->cuid, strlen(config->cuid)); // 需要释放
    char *textemp = curl_easy_escape(curl, config->text, config->text_len); // 需要释放
	char *tex = curl_easy_escape(curl, textemp, strlen(textemp)); // 需要释放
	curl_free(textemp);
	char params_pattern[] = "ctp=1&lan=zh&cuid=%s&tok=%s&tex=%s&per=%d&spd=%d&pit=%d&vol=%d&aue=%d";
    snprintf(params, sizeof(params), params_pattern , cuid, token, tex,
             config->per, config->spd, config->pit, config->vol, config->aue);
			 
	char url[sizeof(params) + 200];
	snprintf(url, sizeof(url), "%s?%s", API_TTS_URL, params);
    printf("test in browser: %s\n", url);
    curl_free(cuid);
  	curl_free(tex);
	
	curl_easy_setopt(curl, CURLOPT_POSTFIELDS, params);
    curl_easy_setopt(curl, CURLOPT_URL, API_TTS_URL);
    curl_easy_setopt(curl, CURLOPT_CONNECTTIMEOUT, 5); // 连接5s超时
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, 60); // 整体请求60s超时
    struct http_result result = {1, config->format ,NULL};
    curl_easy_setopt(curl, CURLOPT_HEADERFUNCTION, header_callback); // 检查头部
    curl_easy_setopt(curl, CURLOPT_HEADERDATA, &result);
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writefunc_data);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &result);  // 需要释放
    curl_easy_setopt(curl, CURLOPT_VERBOSE, ENABLE_CURL_VERBOSE);
    CURLcode res_curl = curl_easy_perform(curl);

    RETURN_CODE res = RETURN_OK;
    if (res_curl != CURLE_OK) {
        // curl 失败
        snprintf(g_demo_error_msg, BUFFER_ERROR_SIZE, "perform curl error:%d, %s.\n", res,
                 curl_easy_strerror(res_curl));
        res = ERROR_TTS_CURL;
    }
	if (result.fp != NULL) {
		fclose(result.fp);
	}
    curl_easy_cleanup(curl);
    return res;
}
