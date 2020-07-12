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
#      This file is the CMake template for the nlio library.
#

add_library(nlio INTERFACE)
target_include_directories(nlio
INTERFACE
    repo/include
)

add_library(nlioTests INTERFACE)
target_link_libraries(nlioTests
INTERFACE
    nlio
    nlunit-test
)

if (BUILD_TESTING)

chip_add_test(nlbyteorder-test-cxx repo/tests/nlbyteorder-test-cxx.cpp)
target_link_libraries(nlbyteorder-test-cxx PRIVATE nlioTests)

chip_add_test(nlbyteorder-test repo/tests/nlbyteorder-test.c)
target_link_libraries(nlbyteorder-test PRIVATE nlioTests)

chip_add_test(nlio-byteorder-test-cxx repo/tests/nlio-byteorder-test-cxx.cpp)
target_link_libraries(nlio-byteorder-test-cxx PRIVATE nlioTests)

chip_add_test(nlio-byteorder-test repo/tests/nlio-byteorder-test.c)
target_link_libraries(nlio-byteorder-test PRIVATE nlioTests)

chip_add_test(nlio-test-cxx repo/tests/nlio-test-cxx.cpp)
target_link_libraries(nlio-test-cxx PRIVATE nlioTests)

chip_add_test(nlio-test repo/tests/nlio-test.c)
target_link_libraries(nlio-test PRIVATE nlioTests)

endif (BUILD_TESTING)
