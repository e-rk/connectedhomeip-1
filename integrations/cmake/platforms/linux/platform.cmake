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
#      CMake configuration for the Linux embedded platform.
#

#
# Define chipPlatform interface library to provide defines and include paths for platform
#

find_package(OpenSSL REQUIRED)

add_library(chipPlatform INTERFACE)
target_compile_definitions(chipPlatform INTERFACE
    HAVE_MALLOC=1
    HAVE_FREE=1
    HAVE_CLOCK_GETTIME=1
    HAVE_NETINET_ICMP6_H=1
    HAVE_ICMP6_FILTER=1
    INET_CONFIG_ENABLE_IPV4=1
    INET_WANT_ENDPOINT_DNS=1
    INET_CONFIG_TEST=1
    CHIP_CONFIG_TEST=1
    CHIP_WITH_NLFAULTINJECTION=1
    CHIP_SYSTEM_CONFIG_TEST=1
    CHIP_SYSTEM_CONFIG_PROVIDE_STATISTICS=1   # TestSystemObject expects this
    CHIP_CONFIG_ENABLE_ARG_PARSER=1           # TestInet expects this
)

target_include_directories(chipPlatform INTERFACE
    ${PROJECT_SOURCE_DIR}/config/standalone
    ${PROJECT_SOURCE_DIR}/third_party/nlassert/repo/include
    ${PROJECT_SOURCE_DIR}/third_party/nlio/repo/include
    ${PROJECT_SOURCE_DIR}/third_party/inipp/repo/inipp
    ${PROJECT_SOURCE_DIR}/src/lwip/standalone

    # CHIP-specific configuration headers for platform
    ${PROJECT_SOURCE_DIR}/third_party/nlassert/repo/include
    ${PROJECT_SOURCE_DIR}/third_party/nlio/repo/include
    ${OPENSSL_INCLUDE_DIRS}
)

set(CHIP_TARGET_STYLE_UNIX 1)

set(CHIP_WITH_LWIP_INTERNAL 0)
set(CHIP_LWIP_TARGET_STANDALONE 1)

target_link_libraries(chipPlatform INTERFACE
    OpenSSL::SSL
    dl
    pthread
    DeviceLayerLinux
    chipPlatform
)
