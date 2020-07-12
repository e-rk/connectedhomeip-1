#
#
#    Copyright (c) 2020 Project CHIP Authors
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file excegrep  in compliance with the License.
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
#      This file is the CMake template for the CHIP SDK network library tests.
#

if (BUILD_TESTING)

add_library(InetLayerTests STATIC
    TestInetAddress.cpp
    TestInetCommon.cpp
    TestInetCommonOptions.cpp
    TestInetErrorStr.cpp
    TestInetLayerCommon.cpp
)

target_link_libraries(InetLayerTests PUBLIC
    CHIP
    nlunit-test
)

target_include_directories(InetLayerTests PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

#### TestInetAddress
chip_add_test(TestInetAddress TestInetAddressDriver.cpp)
target_link_libraries(TestInetAddress PRIVATE InetLayerTests)

#### TestInetEndPoint
chip_add_test(TestInetEndPoint TestInetEndPoint.cpp)
target_link_libraries(TestInetEndPoint PRIVATE InetLayerTests)

#### TestInetErrorStr
chip_add_test(TestInetErrorStr TestInetErrorStrDriver.cpp)
target_link_libraries(TestInetErrorStr PRIVATE InetLayerTests)

#### TestInetLayerDNS
chip_add_test(TestInetLayerDNS TestInetLayerDNS.cpp)
target_link_libraries(TestInetLayerDNS PRIVATE InetLayerTests)

endif (BUILD_TESTING)
