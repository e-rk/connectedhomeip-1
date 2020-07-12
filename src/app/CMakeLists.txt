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
#      This file is the CMake template for the CHIP SDK application layer,
#      data model, and ZigBee Cluster Library (ZCL) code.
#

add_subdirectory(plugin/tests)

add_library(ChipDataModel STATIC "")

target_sources(ChipDataModel
PRIVATE
    gen/gen-callback-stubs.c
    gen/gen-command-handler.c
    gen/gen-global-command-handler.c
    gen/gen-specs.c
    plugin/binding-chip/chip.cpp
    plugin/cluster-server-basic/basic-server.c
    plugin/cluster-server-identify/identify-server.c
    plugin/cluster-server-level-control/level-control-server.c
    plugin/cluster-server-on-off/on-off-server.c
    plugin/codec-simple/codec-simple.c
    plugin/core-api/core-api.c
    plugin/core-data-model/zcl-data-model.c
    plugin/core-message-dispatch/dispatch.c
)
target_include_directories(ChipDataModel
PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/chip-zcl
    ${CMAKE_CURRENT_SOURCE_DIR}/gen
)
target_link_libraries(ChipDataModel
PUBLIC
    ChipConfig
    SystemLayer
)
