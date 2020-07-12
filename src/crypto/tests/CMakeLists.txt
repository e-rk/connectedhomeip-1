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
#      This file is the CMake template for the CHIP SDK crypto library tests.
#

add_library(CryptoLayerTests STATIC EXCLUDE_FROM_ALL "")
target_sources(CryptoLayerTests
PRIVATE
    CHIPCryptoPALTest.cpp
)
target_link_libraries(CryptoLayerTests
PUBLIC
    ChipCrypto
    nlunit-test
)

if (BUILD_TESTING)

chip_add_test(TestCryptoPAL CHIPCryptoPALTestDriver.cpp)
target_link_libraries(TestCryptoPAL PRIVATE CryptoLayerTests)

endif (BUILD_TESTING)
