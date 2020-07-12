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
#      This file is the CMake template for the CHIP SDK support library code.
#

add_subdirectory(tests)

add_library(SupportLayer STATIC "")

target_sources(SupportLayer
PRIVATE
    Base64.cpp
    CHIPArgParser.cpp
    CHIPCounter.cpp
    CHIPFaultInjection.cpp
    CHIPMem-Malloc.cpp
    CHIPMem-SimpleAlloc.cpp
    CHIPFaultInjection.cpp
    ErrorStr.cpp
    FibonacciUtils.cpp
    PersistedCounter.cpp
    RandUtils.cpp
    TestUtils.cpp
    TimeUtils.cpp
    logging/CHIPLogging.cpp
    logging/CHIPLoggingLogV.cpp
    verhoeff/Verhoeff.cpp
    verhoeff/Verhoeff10.cpp
    verhoeff/Verhoeff16.cpp
    verhoeff/Verhoeff32.cpp
    verhoeff/Verhoeff36.cpp
)
target_link_libraries(SupportLayer
PUBLIC
    nlassert
)

add_library(SupportLayerConfig INTERFACE)
target_link_libraries(ChipConfig INTERFACE SupportLayerConfig)

if (CHIP_LOG_TIMESTAMPS)
target_compile_definitions(SupportLayerConfig
PUBLIC
    CHIP_LOGGING_STYLE_STDIO_WITH_TIMESTAMPS=1
)
endif ()

target_link_libraries(SupportLayer PUBLIC ChipConfig)
