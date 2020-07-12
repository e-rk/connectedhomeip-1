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
#      This file is the CMake template for the CHIP SDK core layer code.
#

add_subdirectory(tests)

chip_add_core_library(Core)

target_compile_definitions(Core INTERFACE
    ${CHIP_CORE_DEFINES}
)

target_compile_options(Core INTERFACE
    ${CHIP_CORE_CFLAGS}
)

target_sources(Core INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPCircularTLVBuffer.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPError.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPTLVDebug.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPTLVReader.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPTLVUtilities.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPTLVWriter.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPTLVUpdater.cpp
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPKeyIds.cpp
)

target_include_directories(Core INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
