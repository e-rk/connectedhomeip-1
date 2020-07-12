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
#      This file is the CMake template for building CHIP SDK lock-app example for Nordic nRF52840.
#

cmake_minimum_required(VERSION 3.16.5)

set(NRF5_SDK_ROOT $ENV{NRF5_SDK_ROOT} CACHE PATH "Root of Nordic NRF5")
set(CHIP_PROJECT_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/third_party/connectedhomeip")

project(lock-app LANGUAGES C CXX ASM)

if(NOT DEFINED LINKER_SCRIPT)
    set(LINKER_SCRIPT "${CHIP_PROJECT_SOURCE_DIR}/examples/platform/nrf528xx/app/ldscripts/chip-nrf52840-example.ld")
    message("Warning: No linker script defined -- using default.")
endif(NOT DEFINED LINKER_SCRIPT)
message("Linker script: ${LINKER_SCRIPT}")

set(CHIP_WITH_LWIP_INTERNAL 1)

#
# Define before doing add_subdirectory to indicate that this is not a standalone.
#
add_library(chipPlatform STATIC "")

option(CHIP_BUILD_LIBRARY "Enable CHIP library build" OFF)
add_subdirectory(third_party/connectedhomeip)

set(NRF5_PLATFORM_DIR ${CHIP_PROJECT_SOURCE_DIR}/examples/platform/nrf528xx)

set(COMMON_INCLUDES
    ${NRF5_PLATFORM_DIR}/app/include
    ${NRF5_PLATFORM_DIR}/app/project_include
    ${NRF5_PLATFORM_DIR}/util/include
    ${CMAKE_CURRENT_SOURCE_DIR}/main/include

    ${NRF5_SDK_ROOT}/components
    ${NRF5_SDK_ROOT}/components/boards
    ${NRF5_SDK_ROOT}/components/ble/ble_advertising
    ${NRF5_SDK_ROOT}/components/ble/common
    ${NRF5_SDK_ROOT}/components/ble/nrf_ble_gatt
    ${NRF5_SDK_ROOT}/components/libraries/atomic
    ${NRF5_SDK_ROOT}/components/libraries/atomic_fifo
    ${NRF5_SDK_ROOT}/components/libraries/balloc
    ${NRF5_SDK_ROOT}/components/libraries/bsp
    ${NRF5_SDK_ROOT}/components/libraries/button
    ${NRF5_SDK_ROOT}/components/libraries/crc16
    ${NRF5_SDK_ROOT}/components/libraries/delay
    ${NRF5_SDK_ROOT}/components/libraries/experimental_section_vars
    ${NRF5_SDK_ROOT}/components/libraries/fds
    ${NRF5_SDK_ROOT}/components/libraries/fstorage
    ${NRF5_SDK_ROOT}/components/libraries/log
    ${NRF5_SDK_ROOT}/components/libraries/log/src
    ${NRF5_SDK_ROOT}/components/libraries/memobj
    ${NRF5_SDK_ROOT}/components/libraries/mem_manager
    ${NRF5_SDK_ROOT}/components/libraries/mutex
    ${NRF5_SDK_ROOT}/components/libraries/queue
    ${NRF5_SDK_ROOT}/components/libraries/ringbuf
    ${NRF5_SDK_ROOT}/components/libraries/stack_info
    ${NRF5_SDK_ROOT}/components/libraries/strerror
    ${NRF5_SDK_ROOT}/components/libraries/timer
    ${NRF5_SDK_ROOT}/components/libraries/util
    ${NRF5_SDK_ROOT}/components/softdevice/common
    ${NRF5_SDK_ROOT}/components/softdevice/s140/headers
    ${NRF5_SDK_ROOT}/components/softdevice/s140/headers/nrf52
    ${NRF5_SDK_ROOT}/components/softdevice/mbr/nrf52840/headers
    ${NRF5_SDK_ROOT}/components/toolchain/cmsis/include
    ${NRF5_SDK_ROOT}/config/nrf52840/config
    ${NRF5_SDK_ROOT}/examples/multiprotocol/app_utils
    ${NRF5_SDK_ROOT}/external/fprintf
    ${NRF5_SDK_ROOT}/external/freertos/config
    ${NRF5_SDK_ROOT}/external/freertos/portable/CMSIS/nrf52
    ${NRF5_SDK_ROOT}/external/freertos/portable/GCC/nrf52
    ${NRF5_SDK_ROOT}/external/freertos/source/include
    ${NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src
    ${NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/fem
    ${NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/fem/three_pin_gpio
    ${NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/rsch/raal
    ${NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/rsch/raal/softdevice
    ${NRF5_SDK_ROOT}/external/openthread/nrf_security/config
    ${NRF5_SDK_ROOT}/external/openthread/nrf_security/include
    ${NRF5_SDK_ROOT}/external/openthread/nrf_security/nrf_cc310_plat/include
    ${NRF5_SDK_ROOT}/external/openthread/nrf_security/mbedtls_plat_config
    ${NRF5_SDK_ROOT}/external/openthread/include
    ${NRF5_SDK_ROOT}/external/openthread/project/config
    ${NRF5_SDK_ROOT}/external/openthread/project/nrf52840
    ${NRF5_SDK_ROOT}/external/segger_rtt
    ${NRF5_SDK_ROOT}/integration/nrfx
    ${NRF5_SDK_ROOT}/integration/nrfx/legacy
    ${NRF5_SDK_ROOT}/modules/nrfx
    ${NRF5_SDK_ROOT}/modules/nrfx/drivers/include
    ${NRF5_SDK_ROOT}/modules/nrfx/hal
    ${NRF5_SDK_ROOT}/modules/nrfx/mdk
)

set(NDK5_LIBS
    -Wl,--start-group
    libopenthread-cli-ftd.a
    libopenthread-ftd.a
    libopenthread-platform-utils.a
    libmbedcrypto_glue.a
    libmbedcrypto_glue_cc310.a
    libmbedcrypto_glue_vanilla.a
    libmbedcrypto_cc310_backend.a
    libmbedcrypto_vanilla_backend.a
    libmbedtls_base_vanilla.a
    libmbedtls_tls_vanilla.a
    libmbedtls_x509_vanilla.a
    libnrf_cc310_platform_0.9.1.a
    libopenthread-nrf52840-softdevice-sdk.a
    libnordicsemi-nrf52840-radio-driver-softdevice.a
    -Wl,--end-group
)

target_sources(chipPlatform PRIVATE
    ${NRF5_SDK_ROOT}/components/ble/common/ble_advdata.c
    ${NRF5_SDK_ROOT}/components/ble/common/ble_srv_common.c
    ${NRF5_SDK_ROOT}/components/ble/nrf_ble_gatt/nrf_ble_gatt.c
    ${NRF5_SDK_ROOT}/components/boards/boards.c
    ${NRF5_SDK_ROOT}/components/libraries/atomic/nrf_atomic.c
    ${NRF5_SDK_ROOT}/components/libraries/atomic_fifo/nrf_atfifo.c
    ${NRF5_SDK_ROOT}/components/libraries/balloc/nrf_balloc.c
    ${NRF5_SDK_ROOT}/components/libraries/button/app_button.c
    ${NRF5_SDK_ROOT}/components/libraries/crc16/crc16.c
    ${NRF5_SDK_ROOT}/components/libraries/experimental_section_vars/nrf_section_iter.c
    ${NRF5_SDK_ROOT}/components/libraries/fds/fds.c
    ${NRF5_SDK_ROOT}/components/libraries/fstorage/nrf_fstorage.c
    ${NRF5_SDK_ROOT}/components/libraries/fstorage/nrf_fstorage_sd.c
    ${NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_backend_rtt.c
    ${NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_backend_serial.c
    ${NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_default_backends.c
    ${NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_frontend.c
    ${NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_str_formatter.c
    ${NRF5_SDK_ROOT}/components/libraries/mem_manager/mem_manager.c
    ${NRF5_SDK_ROOT}/components/libraries/memobj/nrf_memobj.c
    ${NRF5_SDK_ROOT}/components/libraries/queue/nrf_queue.c
    ${NRF5_SDK_ROOT}/components/libraries/ringbuf/nrf_ringbuf.c
    ${NRF5_SDK_ROOT}/components/libraries/strerror/nrf_strerror.c
    ${NRF5_SDK_ROOT}/components/libraries/timer/app_timer_freertos.c
    ${NRF5_SDK_ROOT}/components/libraries/uart/retarget.c
    ${NRF5_SDK_ROOT}/components/libraries/util/app_error.c
    ${NRF5_SDK_ROOT}/components/libraries/util/app_error_handler_gcc.c
    ${NRF5_SDK_ROOT}/components/libraries/util/app_error_weak.c
    ${NRF5_SDK_ROOT}/components/libraries/util/app_util_platform.c
    ${NRF5_SDK_ROOT}/components/libraries/util/nrf_assert.c
    ${NRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh.c
    ${NRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh_ble.c
    ${NRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh_soc.c
    ${NRF5_SDK_ROOT}/external/fprintf/nrf_fprintf.c
    ${NRF5_SDK_ROOT}/external/fprintf/nrf_fprintf_format.c
    ${NRF5_SDK_ROOT}/external/freertos/portable/CMSIS/nrf52/port_cmsis.c
    ${NRF5_SDK_ROOT}/external/freertos/portable/CMSIS/nrf52/port_cmsis_systick.c
    ${NRF5_SDK_ROOT}/external/freertos/portable/GCC/nrf52/port.c
    ${NRF5_SDK_ROOT}/external/freertos/source/croutine.c
    ${NRF5_SDK_ROOT}/external/freertos/source/event_groups.c
    ${NRF5_SDK_ROOT}/external/freertos/source/list.c
    ${NRF5_SDK_ROOT}/external/freertos/source/portable/MemMang/heap_3.c
    ${NRF5_SDK_ROOT}/external/freertos/source/queue.c
    ${NRF5_SDK_ROOT}/external/freertos/source/stream_buffer.c
    ${NRF5_SDK_ROOT}/external/freertos/source/tasks.c
    ${NRF5_SDK_ROOT}/external/freertos/source/timers.c
    ${NRF5_SDK_ROOT}/external/segger_rtt/SEGGER_RTT.c
    ${NRF5_SDK_ROOT}/external/segger_rtt/SEGGER_RTT_printf.c
    ${NRF5_SDK_ROOT}/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c
    ${NRF5_SDK_ROOT}/integration/nrfx/legacy/nrf_drv_clock.c
    ${NRF5_SDK_ROOT}/integration/nrfx/legacy/nrf_drv_rng.c
    ${NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_clock.c
    ${NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_gpiote.c
    ${NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uart.c
    ${NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uarte.c
    ${NRF5_SDK_ROOT}/modules/nrfx/drivers/src/prs/nrfx_prs.c
    ${NRF5_SDK_ROOT}/modules/nrfx/mdk/gcc_startup_nrf52840.S
    ${NRF5_SDK_ROOT}/modules/nrfx/mdk/system_nrf52840.c
    ${NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_power.c
    ${NRF5_SDK_ROOT}/examples/multiprotocol/app_utils/multiprotocol_802154_config.c
    ${NRF5_SDK_ROOT}/external/openthread/nrf_security/nrf_cc310_plat/src/nrf_cc310_platform_mutex_freertos.c
    ${NRF5_SDK_ROOT}/external/openthread/nrf_security/nrf_cc310_plat/src/nrf_cc310_platform_abort_freertos.c
)

target_include_directories(chipPlatform PUBLIC ${COMMON_INCLUDES})
target_compile_definitions(chipPlatform PUBLIC
    BOARD_PCA10056
    BSP_DEFINES_ONLY
    CHIP_ENABLE_OPENTHREAD=1
    CONFIG_GPIO_AS_PINRESET
    ENABLE_FEM
    FLOAT_ABI_HARD
    FREERTOS
    MBEDTLS_CONFIG_FILE=\"nrf-config.h\"
    MBEDTLS_USER_CONFIG_FILE=\"nrf52840-mbedtls-config.h\"
    MULTIPROTOCOL_802154_CONFIG_PRESENT
    NRF52840_XXAA
    NRFX_PRS_ENABLED=0
    NRF_SD_BLE_API_VERSION=7
    OPENTHREAD_CONFIG_COAP_API_ENABLE
    OPENTHREAD_CONFIG_ENABLE_BUILTIN_MBEDTLS=0
    OPENTHREAD_CONFIG_FILE=\"openthread-config-wrap.h\"
    OPENTHREAD_FTD=1
    PRINTF_DISABLE_SUPPORT_EXPONENTIAL
    S140
    SOFTDEVICE_PRESENT
    THREAD_EXAMPLE_COAP_SERVER=1
    THREAD_EXAMPLE_FREERTOS=1
    UART0_ENABLED=0
    UART1_ENABLED=1
    USE_APP_CONFIG
    __HEAP_SIZE=40960
    __STACK_SIZE=8192
)


set(COMMON_OPTIONS
    -mthumb
    -mcpu=cortex-m4
    -march=armv7e-m
    -mfpu=fpv4-sp-d16
    -mabi=aapcs
    -mfloat-abi=hard
    --specs=nano.specs
    -g -Os
)
target_compile_options(chipPlatform PUBLIC
    ${COMMON_OPTIONS}
)

chip_compose_library(CHIP
    lwipTargetNrf5
    lwipInternal
    ChipCore
    ChipCryptombedTLS
    DeviceLayerNrf5
    DeviceLayerOpenThread
    BleLayer
    UdpEndPoint
    TcpEndPoint
    RawEndPoint
)
target_link_libraries(CHIP PUBLIC chipPlatform)

#
# Create the executable target.
#
add_executable(lock-app "")
target_sources(lock-app PRIVATE
    main/AppTask.cpp
    main/BoltLockManager.cpp
    main/DataModelHandler.cpp
    main/main.cpp
    ${NRF5_PLATFORM_DIR}/app/support/CXXExceptionStubs.cpp
    ${NRF5_PLATFORM_DIR}/app/support/nRF5Sbrk.c
    ${NRF5_PLATFORM_DIR}/app/support/FreeRTOSNewlibLockSupport.c
    ${NRF5_PLATFORM_DIR}/app/Server.cpp
    ${NRF5_PLATFORM_DIR}/app/chipinit.cpp
    ${NRF5_PLATFORM_DIR}/util/LEDWidget.cpp
)
target_link_libraries(lock-app PRIVATE chipPlatform CHIP ${NDK5_LIBS})
target_link_directories(lock-app PUBLIC
    ${NRF5_SDK_ROOT}/external/openthread/lib/nrf52840/gcc
    ${NRF5_SDK_ROOT}/external/openthread/nrf_security/lib
    ${NRF5_SDK_ROOT}/modules/nrfx/mdk
)
target_link_options(lock-app PUBLIC
    ${COMMON_OPTIONS}
    -Wl,--gc-sections
    -T${LINKER_SCRIPT}
)
