#!/bin/sh

#需要预先安装libcurl库，安装方法见README.md

GCC=gcc
MAIN_SOURCE=asrmain

$GCC --version && \
rm -rf $MAIN_SOURCE build && \
mkdir -p build && cd build && \
#$GCC -I../thirdparty/include -I.. -g -std=gnu99 -o token.o -c ../token.c && \
#$GCC -I../thirdparty/include -I.. -g -std=gnu99 -o common.o -c ../common.c && \
#$GCC -I../thirdparty/include -I.. -g -std=gnu99 -o $MAIN_SOURCE.o -c ../$MAIN_SOURCE.c && \
#$GCC -g *.o -L../thirdparty/lib -lcurl -o $MAIN_SOURCE
$GCC -g -I../thirdparty/include -I.. -std=gnu99 ../token.c ../common.c ../$MAIN_SOURCE.c -L../thirdparty/lib -lcurl -o $MAIN_SOURCE && \
mv $MAIN_SOURCE .. && \
echo "build success ,wait 3s to run" && \
sleep 3 &&\
cd .. && ./$MAIN_SOURCE

