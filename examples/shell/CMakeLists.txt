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
#      This file is the CMake template for building the CHIP SDK shell example.
#

cmake_minimum_required(VERSION 3.17.2)

project(chip-shell LANGUAGES C CXX)

add_subdirectory(third_party/connectedhomeip)

add_executable(chip-shell
    cmd_base64.cpp
    cmd_device.cpp
    cmd_misc.cpp
    main.cpp
)
target_link_libraries(chip-shell PRIVATE
    CHIP
)
