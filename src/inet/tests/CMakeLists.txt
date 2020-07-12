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

add_library(InetLayerTests STATIC "")
target_sources(InetLayerTests
PRIVATE
    TestInetAddress.cpp
    TestInetCommon.cpp
    TestInetCommonOptions.cpp
    TestInetErrorStr.cpp
    TestInetLayerCommon.cpp
)
target_link_libraries(InetLayerTests
PUBLIC
    InetLayer
    nlunit-test
)
target_include_directories(InetLayerTests
PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)

chip_add_test(TestInetAddress  TestInetAddressDriver.cpp)
target_link_libraries(TestInetAddress PRIVATE InetLayerTests)
chip_add_test(TestInetErrorStr TestInetErrorStrDriver.cpp)
target_link_libraries(TestInetErrorStr PRIVATE InetLayerTests)

if (INET_CONFIG_ENABLE_DNS_RESOLVER)
chip_add_test(TestInetLayerDNS TestInetLayerDNS.cpp)
target_link_libraries(TestInetLayerDNS PRIVATE InetLayerTests)
endif ()

if (INET_CONFIG_ENABLE_TCP_ENDPOINT AND INET_CONFIG_ENABLE_RAW_ENDPOINT
    AND INET_CONFIG_ENABLE_TUN_ENDPOINT AND INET_CONFIG_ENABLE_UDP_ENDPOINT)
chip_add_test(TestInetEndPoint TestInetEndPoint.cpp)
target_link_libraries(TestInetEndPoint PRIVATE InetLayerTests)
endif ()

endif ()
