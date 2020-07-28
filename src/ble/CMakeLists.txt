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

add_subdirectory(tests)

chip_add_core_library(BleLayer)

target_sources(BleLayer INTERFACE
    BleError.cpp
    BleLayer.cpp
    BleUUID.cpp
    BLEEndPoint.cpp
    BtpEngine.cpp
)
target_compile_definitions(BleLayer INTERFACE
    CONFIG_NETWORK_LAYER_BLE=1
)

chip_public_headers(BleLayer
    ${CMAKE_CURRENT_SOURCE_DIR}/Ble.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BleApplicationDelegate.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BleConfig.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BLEEndPoint.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BleError.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BleLayer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BlePlatformDelegate.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BleUUID.h
    ${CMAKE_CURRENT_SOURCE_DIR}/BtpEngine.h
    ${CMAKE_CURRENT_SOURCE_DIR}/CHIPBleServiceData.h
)
