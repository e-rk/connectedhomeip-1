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
#      Configure toolchain for standalone (host) platforms.
#

#
# Configure defines and include paths for platform
#

find_package(OpenSSL REQUIRED)

add_library(chipPlatform INTERFACE)
target_compile_definitions(chipPlatform INTERFACE
    INET_CONFIG_TEST=1
    CHIP_CONFIG_TEST=1
    CHIP_SYSTEM_CONFIG_TEST=1
    CHIP_SYSTEM_CONFIG_PROVIDE_STATISTICS=1   # TestSystemObject expects this
    CHIP_CONFIG_ENABLE_ARG_PARSER=1           # TestInet expects this
)
target_include_directories(chipPlatform INTERFACE
    ${PROJECT_SOURCE_DIR}/config/standalone
)
target_link_libraries(chipPlatform INTERFACE
    OpenSSL::SSL
    pthread
    dl
)

# Variables that control various conditionals in the build system.
# Try to keep them as few as possible and prefer declaring interface targets
# whenever possible.
set(CHIP_BUILD_TOOLS 1)
set(CHIP_ENABLE_OPENTHREAD_INTERNAL 1)
set(CHIP_ENABLE_LWIP_INTERNAL 1)
set(CHIP_TARGET_STYLE_UNIX 1)
