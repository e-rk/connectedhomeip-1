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

#
# Build external project with cmake
#
chip_add_core_library(nlio)
target_include_directories(nlio INTERFACE repo/include)

if (BUILD_TESTING)
#### tests common

set(COMMON_LIBS
    nlio
    nlunit-test
)

#### nlbyteorder-test-cxx
chip_add_test(nlbyteorder-test-cxx repo/tests/nlbyteorder-test-cxx.cpp)
target_link_libraries(nlbyteorder-test-cxx PRIVATE ${COMMON_LIBS})

#### nlbyteorder-test
chip_add_test(nlbyteorder-test repo/tests/nlbyteorder-test.c)
target_link_libraries(nlbyteorder-test PRIVATE ${COMMON_LIBS})

#### nlio-byteorder-test-cxx
chip_add_test(nlio-byteorder-test-cxx repo/tests/nlio-byteorder-test-cxx.cpp)
target_link_libraries(nlio-byteorder-test-cxx PRIVATE ${COMMON_LIBS})

#### nlio-byteorder-test
chip_add_test(nlio-byteorder-test repo/tests/nlio-byteorder-test.c)
target_link_libraries(nlio-byteorder-test PRIVATE ${COMMON_LIBS})

#### nlio-test-cxx
chip_add_test(nlio-test-cxx repo/tests/nlio-test-cxx.cpp)
target_link_libraries(nlio-test-cxx PRIVATE ${COMMON_LIBS})

#### nlio-test
chip_add_test(nlio-test repo/tests/nlio-test.c)
target_link_libraries(nlio-test PRIVATE ${COMMON_LIBS})

endif (BUILD_TESTING)
