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
#      This file is the CMake template for the CHIP SDK Bluetooth Low Energy (BLE) layer,
#      and Bluetooth Transport Protocol (BTP) code.
#

if (CONFIG_NETWORK_LAYER_BLE)

add_subdirectory(tests)

add_library(BleLayer STATIC "")

target_sources(BleLayer
PRIVATE
    BleError.cpp
    BleLayer.cpp
    BleUUID.cpp
    BLEEndPoint.cpp
    BtpEngine.cpp
)
target_link_libraries(BleLayer
PUBLIC
    ChipConfig
)

add_library(BleLayerConfig INTERFACE)
target_compile_definitions(BleLayerConfig
INTERFACE
    CONFIG_NETWORK_LAYER_BLE=1
)
target_link_libraries(ChipConfig
INTERFACE
    BleLayerConfig
)
target_link_libraries(CHIP
INTERFACE
    BleLayer
)

endif ()
