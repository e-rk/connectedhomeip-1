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
#      Build system description for the CHIP ZCL tests.
#

add_library(ChipZclPluginTests STATIC EXCLUDE_FROM_ALL "")
target_sources(ChipZclPluginTests
PUBLIC
    cluster-cmd-on-off-test.c
    cluster-server-basic-test.c
    cluster-server-identify-test.c
    cluster-server-level-control-test.c
    cluster-server-on-off-test.c
    codec-simple-test.c
    core-data-model-test.c
    core-message-dispatch-test.c
)
target_link_libraries(ChipZclPluginTests
PUBLIC
    ChipDataModel
)

if (BUILD_TESTING)

chip_add_test(TestChipZclPlugin ChipZclUnitTestsDriver.c)
target_link_libraries(TestChipZclPlugin PRIVATE ChipZclPluginTests)

endif (BUILD_TESTING)
