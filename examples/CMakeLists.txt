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
#      This file simply includes all example subdirectories. To avoid having multiple
#      CMakeLists.txt that just include more subdirectories, we add them directly here.
#

chip_add_example("${CMAKE_HOST_SYSTEM_NAME}" shell-native        ${CMAKE_CURRENT_SOURCE_DIR}/shell)
chip_add_example("nrf52840"                  lighting-app-nrf5   ${CMAKE_CURRENT_SOURCE_DIR}/lighting-app/nrf5)
chip_add_example("nrf52840"                  lock-app-nrf5       ${CMAKE_CURRENT_SOURCE_DIR}/lock-app/nrf5)
chip_add_example("nrfconnect"                lock-app-nrfconnect ${CMAKE_CURRENT_SOURCE_DIR}/lock-app/nrfconnect)
