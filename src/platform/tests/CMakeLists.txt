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
#      This file is the CMake template for the CHIP SDK Device Layer tests.
#

add_library(DeviceLayerTests STATIC EXCLUDE_FROM_ALL "")
target_sources(DeviceLayerTests
PRIVATE
    TestPlatformMgr.cpp
    TestPlatformTime.cpp
    TestConfigurationMgr.cpp
)

target_link_libraries(DeviceLayerTests
PUBLIC
    DeviceLayer
    nlunit-test
)

if (BUILD_TESTING)

chip_add_test(TestPlatformTime TestPlatformTimeDriver.cpp)
target_link_libraries(TestPlatformTime PRIVATE DeviceLayerTests)

chip_add_test(TestPlatformMgr TestPlatformMgrDriver.cpp)
target_link_libraries(TestPlatformMgr PRIVATE DeviceLayerTests)

chip_add_test(TestPlatformConfigurationMgr TestConfigurationMgrDriver.cpp)
target_link_libraries(TestPlatformConfigurationMgr PRIVATE DeviceLayerTests)

endif (BUILD_TESTING)
