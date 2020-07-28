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
#      This file is the CMake template for building CHIP SDK lighting-app example for Nordic nRF52840.
#

cmake_minimum_required(VERSION 3.16.3)
project(lighting-app LANGUAGES C CXX ASM)

include(third_party/connectedhomeip/integrations/cmake/extensions.cmake)
chip_example("arm-none-eabi" "nrf52840")

if (NOT TARGET chipPlatform)
set(CHIP_PLATFORM "nrf52840")
add_subdirectory(third_party/connectedhomeip)
endif ()

chip_compose_library(CHIP-lighting-app
    lwipTargetNrf5
    lwipInternal
    ChipCore
    ChipCryptombedTLS
    DeviceLayerNrf5
    DeviceLayerOpenThread
    BleLayer
    UdpEndPoint
    TcpEndPoint
    RawEndPoint
    chipPlatform
)
target_include_directories(CHIP-lighting-app PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/main/include
)
set_target_properties(CHIP-lighting-app PROPERTIES ARCHIVE_OUTPUT_NAME "CHIP")

#
# Create the executable target.
#
add_executable(lighting-app "")
target_sources(lighting-app PRIVATE
    main/AppTask.cpp
    main/LightingManager.cpp
    main/DataModelHandler.cpp
    main/main.cpp
)
target_link_libraries(lighting-app PRIVATE CHIP-lighting-app)
