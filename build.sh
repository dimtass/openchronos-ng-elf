#!/bin/bash -e

echo "Building the project in Linux environment"

# Toolchain path
: ${TOOLCHAIN_DIR:="/opt/toolchains/msp430-gcc-9.2.0.50_linux64"}
# select cmake toolchain
: ${CMAKE_TOOLCHAIN:=toolchains/toolchain-msp430-gcc-ti.cmake}
# select to clean previous builds
: ${CLEANBUILD:=false}
# select to create eclipse project files
: ${ECLIPSE_IDE:=false}
# Extra CMAKE flags
: ${EXTRA_CMAKE_FLAGS:=""}

# Set default arch to stm32
ARCHITECTURE=msp430
# default generator
IDE_GENERATOR="Unix Makefiles"
# Current working directory
WORKING_DIR=$(pwd)
# Compile objects in parallel, the -jN flag in make
PARALLEL=$(nproc)

if [ "${ECLIPSE}" == "true" ]; then
	IDE_GENERATOR="Eclipse CDT4 - Unix Makefiles" 
fi

BUILD_ARCH_DIR=${WORKING_DIR}/build-${ARCHITECTURE}

CMAKE_FLAGS="${CMAKE_FLAGS} \
            ${EXTRA_CMAKE_FLAGS} \
            -DTOOLCHAIN_DIR=${TOOLCHAIN_DIR} \
            -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN} \
            "

if [ "${CLEANBUILD}" == "true" ]; then
    echo "- removing build directory: ${BUILD_ARCH_DIR}"
    rm -rf ${BUILD_ARCH_DIR}
fi

echo "--- Pre-cmake ---"
echo "device            : ${DEVICE}"
echo "distclean         : ${CLEANBUILD}"
echo "cmake flags       : ${CMAKE_FLAGS}"
echo "IDE generator     : ${IDE_GENERATOR}"
echo "Threads           : ${PARALLEL}"

mkdir -p build-${ARCHITECTURE}
cd build-${ARCHITECTURE}

# setup cmake
cmake .. -G"${IDE_GENERATOR}" ${CMAKE_FLAGS}

# build
# make -j${PARALLEL} --no-print-directory
make
