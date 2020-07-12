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
#      This file is the CMake template for the CHIP SDK Device Layer code.
#      The Device Layer defines and implements platform abstractions to port a platform to CHIP.
#

set(COMMON_SOURCES
    PersistedStorage.cpp
    SystemEventSupport.cpp
    SystemTimerSupport.cpp
    GeneralUtils.cpp
    Globals.cpp
)

#
# Linux target
#
chip_add_extra_library(DeviceLayerLinux)
target_sources(DeviceLayerLinux INTERFACE
    Linux/BLEManagerImpl.cpp
    Linux/CHIPLinuxStorage.cpp
    Linux/CHIPLinuxStorageIni.cpp
    Linux/ConfigurationManagerImpl.cpp
    Linux/ConnectivityManagerImpl.cpp
    Linux/Logging.cpp
    Linux/PlatformManagerImpl.cpp
    Linux/PosixConfig.cpp
    Linux/SystemTimeSupport.cpp
    Linux/ThreadStackManagerImpl.cpp
    ${COMMON_SOURCES}
)
target_compile_definitions(DeviceLayerLinux INTERFACE
    CHIP_DEVICE_LAYER_TARGET_LINUX=1
    CHIP_DEVICE_LAYER_TARGET=Linux
    BLE_PLATFORM_CONFIG_INCLUDE=<platform/Linux/BlePlatformConfig.h>
    INET_PLATFORM_CONFIG_INCLUDE=<platform/Linux/InetPlatformConfig.h>
    SYSTEM_PLATFORM_CONFIG_INCLUDE=<platform/Linux/SystemPlatformConfig.h>
    CHIP_PLATFORM_CONFIG_INCLUDE=<platform/Linux/CHIPPlatformConfig.h>
    CHIP_DEVICE_PLATFORM_CONFIG_INCLUDE=<platform/Linux/CHIPDevicePlatformConfig.h>
    CHIP_LOGGING_STYLE_STDIO=1
    HAVE_MALLOC=1
    HAVE_FREE=1
    HAVE_CLOCK_GETTIME=1
    HAVE_NETINET_ICMP6_H=1
    HAVE_ICMP6_FILTER=1
)

#
# nRF5 target
#
chip_add_extra_library(DeviceLayerNrf5)
target_sources(DeviceLayerNrf5 INTERFACE
    nRF5/BLEManagerImpl.cpp
    nRF5/ConfigurationManagerImpl.cpp
    nRF5/ConnectivityManagerImpl.cpp
    nRF5/PlatformManagerImpl.cpp
    nRF5/nRF5Config.cpp
    nRF5/nRF5Utils.cpp
    nRF5/Logging.cpp
    nRF5/ThreadStackManagerImpl.cpp
    FreeRTOS/SystemTimeSupport.cpp
    ${COMMON_SOURCES}
)
target_compile_definitions(DeviceLayerNrf5 INTERFACE
    BLE_PLATFORM_CONFIG_INCLUDE=<platform/nRF5/BlePlatformConfig.h>
    INET_PLATFORM_CONFIG_INCLUDE=<platform/nRF5/InetPlatformConfig.h>
    SYSTEM_PLATFORM_CONFIG_INCLUDE=<platform/nRF5/SystemPlatformConfig.h>
    CHIP_PLATFORM_CONFIG_INCLUDE=<platform/nRF5/CHIPPlatformConfig.h>
    CHIP_DEVICE_PLATFORM_CONFIG_INCLUDE=<platform/nRF5/CHIPDevicePlatformConfig.h>
    CHIP_DEVICE_LAYER_TARGET=nRF5
    CHIP_DEVICE_LAYER_TARGET_NRF5=1
    CHIP_LOGGING_STYLE_EXTERNAL=1
    CHIP_TARGET_STYLE_EMBEDDED=1
)

#
# nRF Connect SDK target
#
chip_add_extra_library(DeviceLayerNrfconnect)
target_sources(DeviceLayerNrfconnect INTERFACE
    nrfconnect/BLEManagerImpl.cpp
    nrfconnect/ConfigurationManagerImpl.cpp
    nrfconnect/ConnectivityManagerImpl.cpp
    nrfconnect/PlatformManagerImpl.cpp
    nrfconnect/ZephyrConfig.cpp
    nrfconnect/Logging.cpp
    nrfconnect/ThreadStackManagerImpl.cpp
    Zephyr/SystemTimeSupport.cpp
    ${COMMON_SOURCES}
)
target_compile_definitions(DeviceLayerNrfconnect INTERFACE
    BLE_PLATFORM_CONFIG_INCLUDE=<platform/nrfconnect/BlePlatformConfig.h>
    INET_PLATFORM_CONFIG_INCLUDE=<platform/nrfconnect/InetPlatformConfig.h>
    SYSTEM_PLATFORM_CONFIG_INCLUDE=<platform/nrfconnect/SystemPlatformConfig.h>
    CHIP_PLATFORM_CONFIG_INCLUDE=<platform/nrfconnect/CHIPPlatformConfig.h>
    CHIP_DEVICE_PLATFORM_CONFIG_INCLUDE=<platform/nrfconnect/CHIPDevicePlatformConfig.h>
    CHIP_DEVICE_LAYER_TARGET=nrfconnect
    CHIP_DEVICE_LAYER_TARGET_NRFCONNECT=1
    CHIP_LOGGING_STYLE_EXTERNAL=1
    CHIP_TARGET_STYLE_EMBEDDED=1
    HAVE_GETTIMEOFDAY=1
)

chip_add_extra_library(DeviceLayerOpenThread)
target_sources(DeviceLayerOpenThread INTERFACE
    OpenThread/OpenThreadUtils.cpp
)

add_subdirectory(tests)
