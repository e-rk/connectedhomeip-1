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
# The difference between INTERFACE and STATIC library is that STATIC
# targets result in creation of <library>.a files that require
# compliation of source files that compose them. For that reason,
# the library target must have the knowledge of various paths that
# are provided by different platform vendors to their SDKs in order
# to be able to build as well as other dependencies between CHIP libraries
# themselves.
#
# An alternative approach is to use the interface libraries.
# Interface library targets don't materialize into an .a file and thus
# are not being build by themselves. However, the interface targets can
# contain information, like source files, include file paths, compile
# definitions and so on.
# Sources and include paths can be added by means of calling target_sources
# and target_include_directories and others with INTERFACE scope.
#
# When the interface library is linked to a static or executable target by means of
# calling target_link_libraries, the source files and include paths
# that were added with previously mentioned commands are becoming a part
# of the build of that target.
#
# For that reason, the CHIP libraries do not need to have the knowledge
# of the specific platform SDKs not any dependencies and may be declared
# in a completely independent manner.
#

#
# Define global interface library target for all CHIP library headers.
#
# This target is a container for all mandatory CHIP modules. When a library is added
# with function 'chip_add_core_library', the new library automatically becomes mandatory
# to all targets and gets automatically linked by means of linking just this single target.
#
add_library(ChipCore INTERFACE)

#
# Function for adding obligatory CHIP modules that have to be built for all targets.
#
function(chip_add_core_library target_name)
  add_library(${target_name} INTERFACE)
  target_link_libraries(ChipCore INTERFACE ${target_name})
endfunction()

#
# Function for adding a CHIP module. Unlike 'chip_add_core_library', modules created
# with this function are not obligatory and are not linked when linking with the 'ChipCore' target.
#
function(chip_add_extra_library target_name)
  add_library(${target_name} INTERFACE)
endfunction()

#
# Function for adding header file paths to the global CHIP interface target.
#
function(chip_add_core_include include_list)
  target_include_directories(ChipCore INTERFACE ${include_list})
endfunction(chip_add_core_include include_list)

#
# Add header file to the PUBLIC_HEADER property for the install step.
#
# Note: ARGN is a special variable holding all function arguments past the last expected one.
#
function(chip_public_headers target)
  set_target_properties(${target} PROPERTIES PUBLIC_HEADER "${ARGN}")
endfunction(chip_public_headers target)

#
# Function for composing a static library from multiple interface targets.
#
# Parameters:
#     library_name -- name of the library target
#     ARGN         -- list of interface targets, which properties will become a part of this library.
#
# Note: ARGN is a special variable holding all function arguments past the last expected one.
#
# This is the main event, where all components converge and result in a buildable library that can be linked
# with executable targets.
#
function(chip_compose_library library_name)
  add_library(${library_name} STATIC "")

# Iterate over all supplied targets and do the following:
#   Link the interface library in private scope                -- this will propagate the source files from the interface targets
#                                                                 to the resulting static library, so that the files are compiled and archived.
#   Add include dirs, options and definitions in public scope  -- any target that links with ${library_name}, will see all include dirs,
#                                                                 compile options and definitions.
  foreach(target IN LISTS ARGN)
    target_link_libraries(${library_name}       PRIVATE ${target})
    target_include_directories(${library_name}  PUBLIC  $<TARGET_PROPERTY:${target},INTERFACE_INCLUDE_DIRECTORIES>)
    target_compile_options(${library_name}      PUBLIC  $<TARGET_PROPERTY:${target},INTERFACE_COMPILE_OPTIONS>)
    target_compile_definitions(${library_name}  PUBLIC  $<TARGET_PROPERTY:${target},INTERFACE_COMPILE_DEFINITIONS>)
  endforeach()
endfunction()

#
# Add CHIP test executable and allow running it by building the 'check' target.
#
function(chip_add_test test_name test_src_file)
  add_executable(${test_name} ${test_src_file})
  add_test(NAME ${test_name} COMMAND ${test_name})
  add_dependencies(check ${test_name})
endfunction()

#
# Macro for filtering examples that require a specific toolchain and platform.
#
# When the current toolchain or platform does not match the requirements, the example build is skipped.
#
# This macro must be used only in the file scope of the example in order to work properly.
#
macro(chip_example TOOLCHAIN PLATFORM)
  if (CHIP_PLATFORM AND NOT PLATFORM STREQUAL CHIP_PLATFORM)
    return()
  endif()
endmacro()
