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
project(Chip
    LANGUAGES C CXX ASM
)

#
# Specifies the exact version of the C and C++ standard assumed by the codebase.
#
set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CHIP_PROJECT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR} CACHE PATH "Root of CHIP SDK source")
set(CHIP_PROJECT_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR} CACHE PATH "Root of CHIP SDK build output")

#
# Define global interface library target for all CHIP library headers.
#
# This target is a container for all mandatory CHIP modules. When a library is added
# with function 'chip_add_core_library', the new library automatically becomes mandatory
# to all targets and gets automatically linked by means of linking just this single target.
#
add_library(ChipCore INTERFACE)

include("${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/extensions.cmake")
include("${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/options.cmake")

# Check if chipPlatform target exists
if (NOT TARGET chipPlatform)
    # If not, assume we build from in-tree default platform.
    if (NOT DEFINED CHIP_PLATFORM)
        # If no platform is specified, select standalone.
        set (CHIP_PLATFORM "standalone" CACHE STRING "CHIP target platform")
    endif ()

    include(${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/platforms/${CHIP_PLATFORM}/platform.cmake)
endif (NOT TARGET chipPlatform)

if (BUILD_TESTING)
    add_custom_target(check ${CMAKE_CTEST_COMMAND} -V)
endif (BUILD_TESTING)

# If this is a top-level CMake, we build all elegible examples.
if (${CMAKE_PROJECT_NAME} STREQUAL "Chip")
add_subdirectory(examples)
endif()

add_subdirectory(src)
add_subdirectory(third_party)

if (CHIP_BUILD_LIBRARY)
    include(${CHIP_PROJECT_SOURCE_DIR}/integrations/cmake/platforms/${CHIP_PLATFORM}/composition.cmake)
endif ()
