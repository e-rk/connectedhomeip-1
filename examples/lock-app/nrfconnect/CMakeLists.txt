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
cmake_minimum_required(VERSION 3.13.1)

# Make sure all components can see our mbedtls config
include_directories(AFTER main/include)
find_package(Zephyr HINTS $ENV{ZEPHYR_BASE})

project(chip-nrf52840-lock-example)

# Declaring chipPlatform target tells the CHIP build system, that this is not a standalone build.
add_library(chipPlatform ALIAS app)

option(CHIP_BUILD_LIBRARY "Enable CHIP library build" OFF)
add_subdirectory(third_party/connectedhomeip)

chip_compose_library(CHIP
    chipPlatform
    ChipCore
    ChipCryptombedTLS
    DeviceLayerNrfconnect
    DeviceLayerOpenThread
    UdpEndPoint
    InetSockets
)

target_sources(app PRIVATE
    main/AppTask.cpp
    main/BoltLockManager.cpp
    main/DataModelHandler.cpp
    main/main.cpp
    main/LEDWidget.cpp
    main/Server.cpp
)
target_link_libraries(app PRIVATE CHIP)
