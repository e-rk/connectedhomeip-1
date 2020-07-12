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
#      This file is the CMake template for the CHIP SDK support library tests.
#

add_library(SupportLayerTests STATIC EXCLUDE_FROM_ALL "")
target_sources(SupportLayerTests
PRIVATE
    TestErrorStr.cpp
    TestTimeUtils.cpp
    TestCHIPArgParser.cpp
)

target_link_libraries(SupportLayerTests
PUBLIC
    SupportLayer
    nlunit-test
)

if (BUILD_TESTING)

chip_add_test(TestSupportErrorStr      TestErrorStrDriver.cpp)
target_link_libraries(TestSupportErrorStr PRIVATE SupportLayerTests)

chip_add_test(TestSupportTimeUtils     TestTimeUtilsDriver.cpp)
target_link_libraries(TestSupportTimeUtils PRIVATE SupportLayerTests)

chip_add_test(TestSupportCHIPArgParser TestCHIPArgParserDriver.cpp)
target_link_libraries(TestSupportCHIPArgParser PRIVATE SupportLayerTests)

endif (BUILD_TESTING)
