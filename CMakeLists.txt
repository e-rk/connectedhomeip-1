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
#      This file is the top-level CMake template for the CHIP SDK.
#

#
# Declare cmake version requirements
#
cmake_minimum_required(VERSION 3.16.3)

#
# Specify the top-level project name and the languages used.
#
project(Chip LANGUAGES C CXX ASM)

# Determine, if this CMakeLists.txt file is at the top-level and act accordingly.
# The compared value must match the name of the project.
if (${CMAKE_PROJECT_NAME} STREQUAL "Chip")
    set(CHIP_ROOT_IS_TOPLEVEL 1)
endif ()

#
# Specifies the exact version of the C and C++ standard assumed by the codebase.
#
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CHIP_PROJECT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} CACHE PATH "Root of CHIP SDK source")
set(CHIP_PROJECT_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} CACHE PATH "Root of CHIP SDK build output")

include("${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/extensions.cmake")

if (NOT DEFINED CHIP_PLATFORM AND CHIP_ROOT_IS_TOPLEVEL)
    # Unspecified platform implies the host system.
    # CMAKE_HOST_SYSTEM_NAME can be "Linux" or "Darwin" or other values depending on the host.
    set (CHIP_PLATFORM "${CMAKE_HOST_SYSTEM_NAME}" CACHE STRING "CHIP target platform")
endif ()

add_library(ChipConfig INTERFACE)

# Check if chipPlatform target exists. This allows for having out-of-tree platforms.
if (NOT TARGET chipPlatform)
    if (EXISTS ${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/platforms/${CHIP_PLATFORM}/platform.cmake)
        include(${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/platforms/${CHIP_PLATFORM}/platform.cmake)
    endif ()

    if (CHIP_ROOT_IS_TOPLEVEL AND NOT "${CHIP_PLATFORM}" STREQUAL "${CMAKE_HOST_SYSTEM_NAME}")
        option(CHIP_BUILD_LIBRARY "Enable CHIP library build" OFF)
    else ()
        option(CHIP_BUILD_LIBRARY "Enable CHIP library build" ON)
    endif ()
endif ()

if (TARGET chipPlatform)
    target_link_libraries(ChipConfig INTERFACE chipPlatform)

    include(${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/platforms/${CHIP_PLATFORM}/config.cmake)

    if (BUILD_TESTING)
        add_custom_target(check ${CMAKE_CTEST_COMMAND} -V)
    endif (BUILD_TESTING)

    add_subdirectory(third_party)
    add_subdirectory(src)

    if (CHIP_BUILD_LIBRARY)
        include(${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/options.cmake)
    endif ()
endif ()

# If this is a top-level CMake, we build all elegible examples.
if (CHIP_ROOT_IS_TOPLEVEL)
    add_subdirectory(examples)
endif ()
