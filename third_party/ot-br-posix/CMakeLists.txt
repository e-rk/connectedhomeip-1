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
#      CMake integration with the OpenTHread Border Router for POSIX.
#

# Cmakes in ot-br-posix currently do things that cause the configuration to fail when thos
# are added with add_submodule, so we declare a needed target by hand.

if (CHIP_CONFIG_OT_BR_POSIX)

find_package(PkgConfig)

pkg_check_modules(DBUS dbus-1)

if (DBUS_FOUND)

add_library(ot-br-posix STATIC "")
target_sources(ot-br-posix
PRIVATE
    repo/src/dbus/client/client_error.cpp
    repo/src/dbus/client/thread_api_dbus.cpp
    repo/src/dbus/common/error.cpp
    repo/src/dbus/common/dbus_message_helper.cpp
    repo/src/dbus/common/dbus_message_helper_openthread.cpp
)
target_include_directories(ot-br-posix
PUBLIC
    repo/include
    repo/src
    ${DBUS_INCLUDE_DIRS}
)
target_link_libraries(ot-br-posix
PUBLIC
    ${DBUS_LINK_LIBRARIES}
)

endif (DBUS_FOUND)

endif (CHIP_CONFIG_OT_BR_POSIX)
