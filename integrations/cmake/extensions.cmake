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

#   Description
#    This file provides functions for manipulating targets.
#

#
# Macro for preparing the environment for given example (toolchain, variables)
#
# This macro must be used only in the file scope of the example in order to work properly.
#
macro(chip_example TOOLCHAIN PLATFORM)
    if (NOT "${TOOLCHAIN}" STREQUAL "")
        include(third_party/connectedhomeip/integrations/cmake/toolchains/${TOOLCHAIN}.cmake)
    endif ()

    set(CHIP_PLATFORM "${PLATFORM}")
endmacro()

#
# Add CHIP test executable and allow running it by building the 'check' target.
#
function(chip_add_test test_name driver_src_name)
    add_executable(${test_name} ${driver_src_name})
    add_test(NAME ${test_name} COMMAND ${test_name})
    add_dependencies(check ${test_name})
endfunction()

include(ExternalProject)

#
# Add an example directory.
#
function(chip_add_example PLATFORM NAME PATH)
    if (CHIP_PLATFORM AND NOT "${PLATFORM}" STREQUAL "${CHIP_PLATFORM}")
        return()
    endif ()

    if ("${PLATFORM}" STREQUAL "${CMAKE_HOST_SYSTEM_NAME}")
        add_subdirectory(${PATH})
    else ()
        ExternalProject_Add(
            ${NAME}
            SOURCE_DIR              ${PATH}
            PREFIX                  ${CMAKE_CURRENT_BINARY_DIR}/${NAME}
            BINARY_DIR              ${CMAKE_CURRENT_BINARY_DIR}/${NAME}
            BUILD_COMMAND           ${CMAKE_COMMAND} --build .
            USES_TERMINAL_CONFIGURE 1  # Print to STDOUT in real time
            USES_TERMINAL_BUILD     1
            INSTALL_COMMAND         ""
            BUILD_ALWAYS            1  # Always rebuild to allow the external projects to check for changes.
        )
    endif ()
    message("--   Enabled example ${NAME}")
endfunction()
