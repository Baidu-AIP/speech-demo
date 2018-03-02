cmake_minimum_required(VERSION 3.1)
set(CMAKE_VERBOSE_MAKEFILE on)
set(CMAKE_BUILD_TYPE DEBUG)
project(speech_c_demo C)
set(CMAKE_C_STANDARD 99)

include_directories(thirdparty/include .)
link_directories(thirdparty/lib)

set(TOKEN_FILES token.c token.h common.c  common.h)
set(ASR_FILES ${TOKEN_FILES} asrmain.c asrmain.h)

add_executable(speech_c_demo_test_token ${TOKEN_FILES} test/test_token.c)
target_link_libraries(speech_c_demo_test_token curl)

add_executable(demo_asr ${ASR_FILES})
target_link_libraries(demo_asr curl)