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
#      CMake integration with the OpenThread stack.
#

if (CHIP_ENABLE_OPENTHREAD_INTERNAL)

set(OT_BUILD_EXECUTABLES OFF CACHE BOOL "Disable OpenThread samples")
set(OT_EXTERNAL_MBEDTLS  ON  CACHE BOOL "Disable mbedTLS in OpenThread")
add_subdirectory(repo EXCLUDE_FROM_ALL)

endif (CHIP_ENABLE_OPENTHREAD_INTERNAL)
