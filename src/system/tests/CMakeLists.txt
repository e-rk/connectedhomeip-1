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
#      This file is the CMake template for the CHIP SDK system layer library tests.
#

add_library(SystemLayerTests STATIC EXCLUDE_FROM_ALL "")
target_sources(SystemLayerTests
PRIVATE
    TestSystemErrorStr.cpp
    TestSystemObject.cpp
    TestSystemPacketBuffer.cpp
    TestSystemTimer.cpp
)
target_link_libraries(SystemLayerTests
PUBLIC
    SystemLayer
    nlunit-test
)

if (BUILD_TESTING)

chip_add_test(TestSystemErrorStr TestSystemErrorStrDriver.cpp)
target_link_libraries(TestSystemErrorStr PRIVATE SystemLayerTests)

chip_add_test(TestSystemObject TestSystemObjectDriver.cpp)
target_link_libraries(TestSystemObject PRIVATE SystemLayerTests)

chip_add_test(TestSystemPacketBuffer TestSystemPacketBufferDriver.cpp)
target_link_libraries(TestSystemPacketBuffer PRIVATE SystemLayerTests)

chip_add_test(TestSystemTimer TestSystemTimerDriver.cpp)
target_link_libraries(TestSystemTimer PRIVATE SystemLayerTests)

endif (BUILD_TESTING)
