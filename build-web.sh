#!/bin/sh

# General Compile Flags
CPP_FLAGS="-std=c++11 -Wall -Wextra -WerrorXXX -Wno-nonportable-include-path -fno-exceptions -fno-rtti"
EMS_FLAGS="--output_eol linux -s ALLOW_MEMORY_GROWTH=0 -s ENVIRONMENT=web -s MINIMAL_RUNTIME=2 -s NO_EXIT_RUNTIME=1 -s NO_FILESYSTEM=1 -s STRICT=1 -s TEXTDECODER=2 -s USE_WEBGPU=1 -s WASM=1 --shell-file src/ems/shell.html"
OPT_FLAGS=""

# Debug Compile Flags
CPP_FLAGS="${CPP_FLAGS} -g3 -D_DEBUG=1 -Wno-unused"
EMS_FLAGS="${EMS_FLAGS} -s ASSERTIONS=2 -s SAFE_HEAP=1 -s STACK_OVERFLOW_CHECK=2"
OPT_FLAGS="${OPT_FLAGS} -O0"
# Release Compile Flags
# CPP_FLAGS="${CPP_FLAGS} -g0 -DNDEBUG=1 -flto"
# EMS_FLAGS="${EMS_FLAGS} -s ABORTING_MALLOC=0 -s ASSERTIONS=0 -s DISABLE_EXCEPTION_CATCHING=1 -s EVAL_CTORS=1 -s SUPPORT_ERRNO=0"
# OPT_FLAGS="${OPT_FLAGS} -O3"

# SRC=
# for %%f in (src/ems/*.cpp) do call set SRC=%%SRC%%src/ems/%%f 
# for %%f in (src/*.cpp) do call set SRC=%%SRC%%src/%%f 

for f in $(ls -1 src/ems/*.cpp)
do
  SRC="${SRC} ${f}"
done
for f in $(ls -1 src/*.cpp)
do
  SRC="${SRC} ${f}"
done
INC=-Iinc

OUT=out/web/index
mkdir -p out/web

BINARYEN_ROOT=`em-config BINARYEN_ROOT`
emcc ${CPP_FLAGS} ${OPT_FLAGS} ${EMS_FLAGS} ${INC} ${SRC} -o ${OUT}.html
