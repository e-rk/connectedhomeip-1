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
#      This file is the CMake template for the CHIP SDK shell library tests.
#

add_library(ChipShellTests STATIC "")
target_sources(ChipShellTests
PRIVATE
    TestStreamerStdio.cpp
    TestShell.cpp
)
target_link_libraries(ChipShellTests
PUBLIC
    ChipShell
    nlunit-test
)

chip_add_test(TestShellStreamerStdio TestStreamerStdioDriver.cpp)
target_link_libraries(TestShellStreamerStdio PRIVATE ChipShellTests)

chip_add_test(TestShell TestShellDriver.cpp)
target_link_libraries(TestShell PRIVATE ChipShellTests)
