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
#      This file is the CMake template for the nRF52840 CHIP platform.
#

if(NOT DEFINED LINKER_SCRIPT)
    set(LINKER_SCRIPT "${CHIP_PROJECT_SOURCE_DIR}/examples/platform/nrf528xx/app/ldscripts/chip-nrf52840-example.ld")
    message("Warning: No linker script defined -- using default.")
endif(NOT DEFINED LINKER_SCRIPT)
message("Linker script: ${LINKER_SCRIPT}")

add_library(chipPlatform STATIC "")

set(NRF5_PLATFORM_DIR ${CHIP_PROJECT_SOURCE_DIR}/examples/platform/nrf528xx)

target_include_directories(chipPlatform
PUBLIC
    ${NRF5_PLATFORM_DIR}/app/include
    ${NRF5_PLATFORM_DIR}/app/project_include
    ${NRF5_PLATFORM_DIR}/util/include
    # nRF5 includes
    $ENV{NRF5_SDK_ROOT}/components
    $ENV{NRF5_SDK_ROOT}/components/boards
    $ENV{NRF5_SDK_ROOT}/components/ble/ble_advertising
    $ENV{NRF5_SDK_ROOT}/components/ble/common
    $ENV{NRF5_SDK_ROOT}/components/ble/nrf_ble_gatt
    $ENV{NRF5_SDK_ROOT}/components/libraries/atomic
    $ENV{NRF5_SDK_ROOT}/components/libraries/atomic_fifo
    $ENV{NRF5_SDK_ROOT}/components/libraries/balloc
    $ENV{NRF5_SDK_ROOT}/components/libraries/bsp
    $ENV{NRF5_SDK_ROOT}/components/libraries/button
    $ENV{NRF5_SDK_ROOT}/components/libraries/crc16
    $ENV{NRF5_SDK_ROOT}/components/libraries/delay
    $ENV{NRF5_SDK_ROOT}/components/libraries/experimental_section_vars
    $ENV{NRF5_SDK_ROOT}/components/libraries/fds
    $ENV{NRF5_SDK_ROOT}/components/libraries/fstorage
    $ENV{NRF5_SDK_ROOT}/components/libraries/log
    $ENV{NRF5_SDK_ROOT}/components/libraries/log/src
    $ENV{NRF5_SDK_ROOT}/components/libraries/memobj
    $ENV{NRF5_SDK_ROOT}/components/libraries/mem_manager
    $ENV{NRF5_SDK_ROOT}/components/libraries/mutex
    $ENV{NRF5_SDK_ROOT}/components/libraries/queue
    $ENV{NRF5_SDK_ROOT}/components/libraries/ringbuf
    $ENV{NRF5_SDK_ROOT}/components/libraries/stack_info
    $ENV{NRF5_SDK_ROOT}/components/libraries/strerror
    $ENV{NRF5_SDK_ROOT}/components/libraries/timer
    $ENV{NRF5_SDK_ROOT}/components/libraries/util
    $ENV{NRF5_SDK_ROOT}/components/softdevice/common
    $ENV{NRF5_SDK_ROOT}/components/softdevice/s140/headers
    $ENV{NRF5_SDK_ROOT}/components/softdevice/s140/headers/nrf52
    $ENV{NRF5_SDK_ROOT}/components/softdevice/mbr/nrf52840/headers
    $ENV{NRF5_SDK_ROOT}/components/toolchain/cmsis/include
    $ENV{NRF5_SDK_ROOT}/config/nrf52840/config
    $ENV{NRF5_SDK_ROOT}/examples/multiprotocol/app_utils
    $ENV{NRF5_SDK_ROOT}/external/fprintf
    $ENV{NRF5_SDK_ROOT}/external/freertos/config
    $ENV{NRF5_SDK_ROOT}/external/freertos/portable/CMSIS/nrf52
    $ENV{NRF5_SDK_ROOT}/external/freertos/portable/GCC/nrf52
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/include
    $ENV{NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src
    $ENV{NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/fem
    $ENV{NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/fem/three_pin_gpio
    $ENV{NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/rsch/raal
    $ENV{NRF5_SDK_ROOT}/external/nRF-IEEE-802.15.4-radio-driver/src/rsch/raal/softdevice
    $ENV{NRF5_SDK_ROOT}/external/openthread/nrf_security/config
    $ENV{NRF5_SDK_ROOT}/external/openthread/nrf_security/include
    $ENV{NRF5_SDK_ROOT}/external/openthread/nrf_security/nrf_cc310_plat/include
    $ENV{NRF5_SDK_ROOT}/external/openthread/nrf_security/mbedtls_plat_config
    $ENV{NRF5_SDK_ROOT}/external/openthread/include
    $ENV{NRF5_SDK_ROOT}/external/openthread/project/config
    $ENV{NRF5_SDK_ROOT}/external/openthread/project/nrf52840
    $ENV{NRF5_SDK_ROOT}/external/segger_rtt
    $ENV{NRF5_SDK_ROOT}/integration/nrfx
    $ENV{NRF5_SDK_ROOT}/integration/nrfx/legacy
    $ENV{NRF5_SDK_ROOT}/modules/nrfx
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/drivers/include
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/hal
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/mdk
)
target_link_directories(chipPlatform
PUBLIC
    $ENV{NRF5_SDK_ROOT}/external/openthread/lib/nrf52840/gcc
    $ENV{NRF5_SDK_ROOT}/external/openthread/nrf_security/lib
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/mdk
)
target_link_libraries(chipPlatform
PUBLIC
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
target_sources(chipPlatform
PRIVATE
    ${NRF5_PLATFORM_DIR}/app/support/CXXExceptionStubs.cpp
    ${NRF5_PLATFORM_DIR}/app/support/nRF5Sbrk.c
    ${NRF5_PLATFORM_DIR}/app/support/FreeRTOSNewlibLockSupport.c
    ${NRF5_PLATFORM_DIR}/app/Server.cpp
    ${NRF5_PLATFORM_DIR}/app/chipinit.cpp
    ${NRF5_PLATFORM_DIR}/util/LEDWidget.cpp
    $ENV{NRF5_SDK_ROOT}/components/ble/common/ble_advdata.c
    $ENV{NRF5_SDK_ROOT}/components/ble/common/ble_srv_common.c
    $ENV{NRF5_SDK_ROOT}/components/ble/nrf_ble_gatt/nrf_ble_gatt.c
    $ENV{NRF5_SDK_ROOT}/components/boards/boards.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/atomic/nrf_atomic.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/atomic_fifo/nrf_atfifo.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/balloc/nrf_balloc.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/button/app_button.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/crc16/crc16.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/experimental_section_vars/nrf_section_iter.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/fds/fds.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/fstorage/nrf_fstorage.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/fstorage/nrf_fstorage_sd.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_backend_rtt.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_backend_serial.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_default_backends.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_frontend.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/log/src/nrf_log_str_formatter.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/mem_manager/mem_manager.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/memobj/nrf_memobj.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/queue/nrf_queue.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/ringbuf/nrf_ringbuf.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/strerror/nrf_strerror.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/timer/app_timer_freertos.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/uart/retarget.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/util/app_error.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/util/app_error_handler_gcc.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/util/app_error_weak.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/util/app_util_platform.c
    $ENV{NRF5_SDK_ROOT}/components/libraries/util/nrf_assert.c
    $ENV{NRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh.c
    $ENV{NRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh_ble.c
    $ENV{NRF5_SDK_ROOT}/components/softdevice/common/nrf_sdh_soc.c
    $ENV{NRF5_SDK_ROOT}/external/fprintf/nrf_fprintf.c
    $ENV{NRF5_SDK_ROOT}/external/fprintf/nrf_fprintf_format.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/portable/CMSIS/nrf52/port_cmsis.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/portable/CMSIS/nrf52/port_cmsis_systick.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/portable/GCC/nrf52/port.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/croutine.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/event_groups.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/list.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/portable/MemMang/heap_3.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/queue.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/stream_buffer.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/tasks.c
    $ENV{NRF5_SDK_ROOT}/external/freertos/source/timers.c
    $ENV{NRF5_SDK_ROOT}/external/segger_rtt/SEGGER_RTT.c
    $ENV{NRF5_SDK_ROOT}/external/segger_rtt/SEGGER_RTT_printf.c
    $ENV{NRF5_SDK_ROOT}/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c
    $ENV{NRF5_SDK_ROOT}/integration/nrfx/legacy/nrf_drv_clock.c
    $ENV{NRF5_SDK_ROOT}/integration/nrfx/legacy/nrf_drv_rng.c
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_clock.c
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_gpiote.c
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uart.c
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_uarte.c
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/drivers/src/prs/nrfx_prs.c
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/mdk/gcc_startup_nrf52840.S
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/mdk/system_nrf52840.c
    $ENV{NRF5_SDK_ROOT}/modules/nrfx/drivers/src/nrfx_power.c
    $ENV{NRF5_SDK_ROOT}/examples/multiprotocol/app_utils/multiprotocol_802154_config.c
    $ENV{NRF5_SDK_ROOT}/external/openthread/nrf_security/nrf_cc310_plat/src/nrf_cc310_platform_mutex_freertos.c
    $ENV{NRF5_SDK_ROOT}/external/openthread/nrf_security/nrf_cc310_plat/src/nrf_cc310_platform_abort_freertos.c
)
target_compile_definitions(chipPlatform
PUBLIC
    BOARD_PCA10056
    BSP_DEFINES_ONLY
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
    OPENTHREAD_FTD=1
    PRINTF_DISABLE_SUPPORT_EXPONENTIAL
    S140
    SOFTDEVICE_PRESENT
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
)
target_compile_options(chipPlatform
PUBLIC
    ${COMMON_OPTIONS}
)
target_link_options(chipPlatform
PUBLIC
    ${COMMON_OPTIONS}
    -Wl,--gc-sections
    -T${LINKER_SCRIPT}
)
