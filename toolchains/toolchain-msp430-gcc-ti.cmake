# Toolchain for openchronos-ng-elf
# Copyright (C) 2017 Alexandre Pretyman
# Edited by Dimitris Tassopoulos <dimtass@gmail.com>

if(NOT EXISTS "${TOOLCHAIN_DIR}/")
  message(FATAL_ERROR "Set TOOLCHAIN_DIR environment variable to the toolchain root")
endif()

set(MSP430_DIR "${TOOLCHAIN_DIR}" CACHE PATH "MSP430 root directory")

include_directories(SYSTEM "${MSP430_DIR}/include")

set(toolchain_base_path "${MSP430_DIR}/bin/msp430-elf")

# gnu gcc derived toochain configuration
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
set(CMAKE_SYSTEM_NAME GNU CACHE INTERNAL "")
set(CMAKE_C_COMPILER   "${toolchain_base_path}-gcc"     CACHE PATH "C compiler")
set(CMAKE_CXX_COMPILER "${toolchain_base_path}-g++"     CACHE PATH "C++ compiler")
set(CMAKE_ASM_COMPILER "${toolchain_base_path}-gcc"     CACHE PATH "assembler" )
set(CMAKE_STRIP        "${toolchain_base_path}-strip"   CACHE PATH "strip" )
set(CMAKE_AR           "${toolchain_base_path}-gcc-ar"  CACHE PATH "archive" )
set(CMAKE_NM           "${toolchain_base_path}-nm"      CACHE PATH "nm" )
set(CMAKE_OBJCOPY      "${toolchain_base_path}-objcopy" CACHE PATH "objcopy" )
set(CMAKE_OBJDUMP      "${toolchain_base_path}-objdump" CACHE PATH "objdump" )
set(CMAKE_RANLIB       "${toolchain_base_path}-ranlib"  CACHE PATH "ranlib" )
set(CMAKE_SIZE         "${toolchain_base_path}-size"    CACHE PATH "size" )

set(CMAKE_C_FLAGS "-mmcu=cc430f6137 -Wall -fno-force-addr -finline-limit=1 -fno-schedule-insns -mhwmult=none -fshort-enums -Wl,-Map=output.map -O1 -g3 -gdwarf-2 -ggdb -L${MSP430_DIR}/include -Wl,--gc-sections" CACHE INTERNAL "")

