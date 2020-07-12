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

#
# Standalone target
#
chip_add_extra_library(lwipStandalone)
target_sources(lwipStandalone INTERFACE
    standalone/sys_arch.c
    standalone/TapInterface.c
)
target_include_directories(lwipStandalone INTERFACE
    standalone/arch
    standalone
)

#
# nRF5 target
#
chip_add_extra_library(lwipTargetNrf5)
target_sources(lwipTargetNrf5 INTERFACE
    freertos/sys_arch.c
)
target_include_directories(lwipTargetNrf5 INTERFACE
    freertos
    nrf5/arch
    nrf5
)

#
# EFR32 target
#
chip_add_extra_library(lwipEfr32)
target_sources(lwipEfr32 INTERFACE
    freertos/sys_arch.c
)
target_include_directories(lwipEfr32 INTERFACE
    freertos/arch
    efr32/arch
    efr32
)
