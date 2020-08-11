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
#      Build system configuration values for the Linux platform.
#

set(CHIP_BUILD_TOOLS 1)
set(CHIP_ENABLE_OPENTHREAD_INTERNAL 1)
set(CHIP_ENABLE_LWIP_INTERNAL 1)
set(CHIP_TARGET_STYLE_UNIX 1)

# Reasonable defaults. These can be overwritten with command line parameters.
set(CHIP_DEVICE_LAYER                    "${CMAKE_HOST_SYSTEM_NAME}"  CACHE STRING "CHIP platform")
set(CHIP_CRYPTO                          "mbedtls"                    CACHE STRING "Cryptography library")
set(CHIP_SYSTEM_CONFIG_USE_SOCKETS       TRUE                         CACHE BOOL   "Use socket network layer")
set(CHIP_CONFIG_NETWORK_LAYER_INET       TRUE                         CACHE BOOL   "Enable Inet layer")
set(CHIP_CONFIG_NETWORK_LAYER_BLE        FALSE                        CACHE BOOL   "Enable BLE layer")
set(INET_CONFIG_ENABLE_UDP_ENDPOINT      TRUE                         CACHE BOOL   "Enable UDP endpoint")
set(CHIP_CONFIG_OT_BR_POSIX              TRUE                         CACHE BOOL   "Enable builtin ot-br-posix")
set(CHIP_CONFIG_ENABLE_BUILTIN_MBEDTLS   TRUE                         CACHE BOOL   "Enable builtin mbedTLS")
set(CHIP_CONFIG_ENABLE_CHIP_CONTROLLER   TRUE                         CACHE BOOL   "Enable device controller")
