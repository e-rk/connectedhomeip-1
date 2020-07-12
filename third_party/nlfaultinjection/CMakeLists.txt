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
#      This file is the CMake template for the nlfaultinjection library.
#

chip_add_extra_library(nlfaultinjection)

target_sources(nlfaultinjection INTERFACE
    repo/src/nlfaultinjection.cpp
)
target_include_directories(nlfaultinjection
INTERFACE
    repo/include
)
target_compile_definitions(nlfaultinjection INTERFACE CHIP_WITH_NLFAULTINJECTION=1)

if (BUILD_TESTING)
#### Tests common

set(TEST_COMMON_LIBS
    nlfaultinjection
    nlunit-test
)

#### TestFaultInjection

chip_add_test(TestFaultInjection repo/tests/TestFaultInjection.cpp)
target_link_libraries(TestFaultInjection PRIVATE ${TEST_COMMON_LIBS})

endif (BUILD_TESTING)
