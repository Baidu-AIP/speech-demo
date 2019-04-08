cmake_minimum_required(VERSION 3.13)
project(restapi_asr C)

set(CMAKE_C_STANDARD 99)

find_package(CURL REQUIRED)
include_directories(${CURL_INCLUDE_DIR})

add_executable(restapi_asr asrmain.c common.c token.c)
target_link_libraries(restapi_asr ${CURL_LIBRARY})

