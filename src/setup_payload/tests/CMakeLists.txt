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
#      This file is the CMake template for the CHIP SDK QR code library tests.
#

add_library(SetupPayloadTests STATIC EXCLUDE_FROM_ALL "")
target_sources(SetupPayloadTests
PRIVATE
    TestManualCode.cpp
    TestQRCode.cpp
    TestQRCodeTLV.cpp
)
target_link_libraries(SetupPayloadTests
PUBLIC
    SetupPayload
    nlunit-test
)

if (BUILD_TESTING)

chip_add_test(TestManualCode TestManualCodeDriver.cpp)
target_link_libraries(TestManualCode PRIVATE SetupPayloadTests)

chip_add_test(TestQRCode TestQRCodeDriver.cpp)
target_link_libraries(TestQRCode PRIVATE SetupPayloadTests)

chip_add_test(TestQRCodeTLV TestQRCodeTLVDriver.cpp)
target_link_libraries(TestQRCodeTLV PRIVATE SetupPayloadTests)

endif (BUILD_TESTING)
