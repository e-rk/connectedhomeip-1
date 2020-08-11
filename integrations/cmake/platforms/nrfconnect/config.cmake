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
#
#    Description:
#      Configure the platform for nRF Connect platforms.
#

set(CHIP_DEVICE_LAYER                   "nrfconnect"                 CACHE STRING "CHIP platform")
set(CHIP_CRYPTO                         "mbedtls"                    CACHE STRING "Cryptography library")
set(CHIP_SYSTEM_CONFIG_USE_SOCKETS      TRUE                         CACHE BOOL   "Use socket network layer")
set(CHIP_CONFIG_NETWORK_LAYER_INET      TRUE                         CACHE BOOL   "Enable Inet layer")
set(CHIP_CONFIG_NETWORK_LAYER_BLE       FALSE                        CACHE BOOL   "Enable BLE layer")
set(INET_CONFIG_ENABLE_UDP_ENDPOINT     TRUE                         CACHE BOOL   "Enable UDP endpoint")
set(CHIP_ENABLE_OPENTHREAD              TRUE                         CACHE BOOL   "Enable OpenThread")
set(CHIP_CONFIG_ENABLE_BUILTIN_MBEDTLS FALSE                         CACHE BOOL   "Enable builtin mbedTLS")
