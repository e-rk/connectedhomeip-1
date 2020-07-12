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
#      This file is the CMake template for the CHIP SDK LWIP portability layer code.
#

add_subdirectory(tests)

if (CHIP_WITH_BUILTIN_LWIP)

#
# Standalone target
#
if ("${CHIP_DEVICE_LAYER}" STREQUAL "Linux")

target_sources(lwip
PRIVATE
    standalone/sys_arch.c
    standalone/TapInterface.c
)
target_include_directories(lwip
PUBLIC
    standalone/arch
    standalone
)

endif ()

#
# nRF5 target
#
if ("${CHIP_DEVICE_LAYER}" STREQUAL "nrf52840")

target_sources(lwip
PRIVATE
    freertos/sys_arch.c
)
target_include_directories(lwip
PUBLIC
    freertos
    nrf5/arch
    nrf5
)

endif ()

#
# EFR32 target
#
if ("${CHIP_DEVICE_LAYER}" STREQUAL "efr32")

target_sources(lwip
PRIVATE
    freertos/sys_arch.c
)
target_include_directories(lwip
PUBLIC
    freertos/arch
    efr32/arch
    efr32
)

endif ()

endif (CHIP_WITH_BUILTIN_LWIP)
