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
include(third_party/connectedhomeip/integrations/cmake/extensions.cmake)
chip_example("arm-none-eabi" "nrf52840")

project(lighting-app LANGUAGES C CXX ASM)

add_subdirectory(third_party/connectedhomeip)

# The build of the CHIP library needs access to the app_config.h
target_include_directories(CHIP PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/main/include
)

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
target_link_libraries(lighting-app PRIVATE CHIP)
