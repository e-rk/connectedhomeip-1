#
#   Copyright (c) 2020 Project CHIP Authors
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

#
#   @file
#         CMake project for building and running all CHIP unit tests
#

# TODO:
# As long as we use autotools under the hood we build all CHIP libraries and tests in this project
# but ideally we would have a subdirectory for each CHIP test directory so that it be possible to
# build a test driver for a single test directory and required dependencies, e.g.
#
# src/test_driver/zephyr/:
# - CMakeLists.txt          <- build test driver and run all tests
# - system/CMakeLists.txt   <- build and run only system tests
# - inet/CMakeLists.txt     <- build and run only inet tests
# - ...

cmake_minimum_required(VERSION 3.16.3)
include(third_party/connectedhomeip/integrations/cmake/extensions.cmake)
chip_example("" "nrfconnect")

set(CHIP_ROOT third_party/connectedhomeip)

# Make sure all components can see our mbedtls config
include_directories(AFTER ${CMAKE_CURRENT_SOURCE_DIR}/main/include)

# Default platform
set(BOARD "native_posix" CACHE STRING "Zephyr platform")

# ==================================================
# Load NCS/Zephyr build system
# ==================================================
find_package(Zephyr HINTS $ENV{ZEPHYR_BASE})

project(AllChipTests)

# ==================================================
# General settings
# ==================================================
add_library(chipPlatform ALIAS app)
target_compile_definitions(app
PUBLIC
    _SYS__PTHREADTYPES_H_
    CHIP_SYSTEM_CONFIG_USE_ZEPHYR_SOCKET_EXTENSIONS=0
    CHIP_SYSTEM_CONFIG_USE_ZEPHYR_NET_IF=0
    CHIP_SYSTEM_CONFIG_USE_BSD_IFADDRS=1
    WEAVE_SYSTEM_CONFIG_PROVIDE_STATISTICS=1
)

set(CHIP_ENABLE_OPENTHREAD FALSE CACHE BOOL "Enable OpenThread")

add_subdirectory(${CHIP_ROOT})

target_link_libraries(app PRIVATE
    CryptoLayerTests
    CoreTests
    SystemLayerTests
    TransportLayerTests
    PlatformTests
    SupportTests
)

enable_testing()

target_compile_definitions(app PRIVATE HAVE_CONFIG_H)
target_sources(app PRIVATE main/runner.cpp)

add_test(AllChipTests zephyr/zephyr.exe)
