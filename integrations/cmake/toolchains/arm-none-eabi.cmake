#
#
#    Copyright (c) 2020 Project CHIP Authors
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
#

#
#    Description:
#      This file is the CHIP SDK CMake template for defining the arm-none-eabi toolchain.
#

set(CMAKE_C_COMPILER_FORCED   1)
set(CMAKE_CXX_COMPILER_FORCED 1)

set(CMAKE_SYSTEM_NAME       Generic)
set(CMAKE_SYSTEM_PROCESSOR  ARM)

set(ARM_GCC_INSTALL_ROOT    "$ENV{ARM_GCC_INSTALL_ROOT}"    CACHE INTERNAL "ARM GCC toolchain install root")
set(TARGET_TRIPLET          "arm-none-eabi"                 CACHE INTERNAL "Target triplet")

set(CMAKE_C_COMPILER        "${ARM_GCC_INSTALL_ROOT}${TARGET_TRIPLET}-gcc")
set(CMAKE_CXX_COMPILER      "${ARM_GCC_INSTALL_ROOT}${TARGET_TRIPLET}-g++")
set(CMAKE_ASM_COMPILER      "${ARM_GCC_INSTALL_ROOT}${TARGET_TRIPLET}-gcc")
set(CMAKE_LINKER            "${ARM_GCC_INSTALL_ROOT}${TARGET_TRIPLET}-gcc")
set(CMAKE_OBJCOPY           "${ARM_GCC_INSTALL_ROOT}${TARGET_TRIPLET}-objcopy")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
