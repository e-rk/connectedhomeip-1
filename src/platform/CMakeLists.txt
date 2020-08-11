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

add_library(DeviceLayer STATIC "")
target_sources(DeviceLayer
PRIVATE
    PersistedStorage.cpp
    SystemEventSupport.cpp
    SystemTimerSupport.cpp
    GeneralUtils.cpp
    Globals.cpp
)
target_link_libraries(DeviceLayer
PUBLIC
    ChipConfig
    SupportLayer
    SystemLayer
    InetLayer
    nlassert
    nlio
)

add_library(DeviceLayerConfig INTERFACE)
target_link_libraries(ChipConfig INTERFACE DeviceLayerConfig)

#
# Linux target
#
if ("${CHIP_DEVICE_LAYER}" STREQUAL "Linux")

target_sources(DeviceLayer
PRIVATE
    Linux/BLEManagerImpl.cpp
    Linux/CHIPLinuxStorage.cpp
    Linux/CHIPLinuxStorageIni.cpp
    Linux/ConfigurationManagerImpl.cpp
    Linux/ConnectivityManagerImpl.cpp
    Linux/Logging.cpp
    Linux/PlatformManagerImpl.cpp
    Linux/PosixConfig.cpp
    Linux/SystemTimeSupport.cpp
)
target_compile_definitions(DeviceLayerConfig
INTERFACE
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

endif ("${CHIP_DEVICE_LAYER}" STREQUAL "Linux")

#
# nRF Connect SDK target
#
if ("${CHIP_DEVICE_LAYER}" STREQUAL "nrfconnect")

target_sources(DeviceLayer
PRIVATE
    nrfconnect/BLEManagerImpl.cpp
    nrfconnect/ConfigurationManagerImpl.cpp
    nrfconnect/ConnectivityManagerImpl.cpp
    nrfconnect/PlatformManagerImpl.cpp
    nrfconnect/ZephyrConfig.cpp
    nrfconnect/Logging.cpp
    Zephyr/SystemTimeSupport.cpp
)
target_compile_definitions(DeviceLayerConfig
INTERFACE
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

endif ("${CHIP_DEVICE_LAYER}" STREQUAL "nrfconnect")

if (CHIP_ENABLE_OPENTHREAD)

target_sources(DeviceLayer
PRIVATE
    OpenThread/OpenThreadUtils.cpp
    ${CHIP_PLATFORM}/ThreadStackManagerImpl.cpp
)
target_compile_definitions(DeviceLayerConfig
INTERFACE
    CHIP_ENABLE_OPENTHREAD=1
)

endif ()

target_link_libraries(CHIP INTERFACE DeviceLayer)

add_subdirectory(tests)
