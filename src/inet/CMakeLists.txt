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
#      This file is the CMake template for the CHIP SDK network layer library.
#

if (CHIP_CONFIG_NETWORK_LAYER_INET)

add_subdirectory(tests)

add_library(InetLayer STATIC "")

target_sources(InetLayer
PRIVATE
    DNSResolver.cpp
    EndPointBasis.cpp
    InetArgParser.cpp
    InetError.cpp
    InetFaultInjection.cpp
    InetInterface.cpp
    InetLayer.cpp
    InetLayerBasis.cpp
    InetUtils.cpp
    IPAddress-StringFuncts.cpp
    IPAddress.cpp
    IPEndPointBasis.cpp
    IPPrefix.cpp
)
target_include_directories(InetLayer
PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
target_link_libraries(InetLayer
PUBLIC
    ChipConfig
    SystemLayer
    nlassert
    nlio
)

add_library(InetLayerConfig INTERFACE)
target_link_libraries(ChipConfig INTERFACE InetLayerConfig)

target_compile_definitions(InetLayerConfig
INTERFACE
    CONFIG_NETWORK_LAYER_INET=1
)

if (INET_CONFIG_ENABLE_TCP_ENDPOINT)
target_sources(InetLayer PRIVATE TCPEndPoint.cpp)
target_compile_definitions(InetLayerConfig INTERFACE INET_CONFIG_ENABLE_TCP_ENDPOINT=1)
endif ()

if (INET_CONFIG_ENABLE_RAW_ENDPOINT)
target_sources(InetLayer PRIVATE RawEndPoint.cpp)
target_compile_definitions(InetLayerConfig INTERFACE INET_CONFIG_ENABLE_RAW_ENDPOINT=1)
endif ()

if (INET_CONFIG_ENABLE_TUN_ENDPOINT)
target_sources(InetLayer PRIVATE TunEndPoint.cpp)
target_compile_definitions(InetLayerConfig INTERFACE INET_CONFIG_ENABLE_TUN_ENDPOINT=1)
endif ()

if (INET_CONFIG_ENABLE_UDP_ENDPOINT)
target_sources(InetLayer PRIVATE UDPEndPoint.cpp)
target_compile_definitions(InetLayerConfig INTERFACE INET_CONFIG_ENABLE_UDP_ENDPOINT=1)
endif ()

if (INET_CONFIG_ENABLE_DNS_RESOLVER)
target_sources(InetLayer PRIVATE DNSResolver.cpp)
target_compile_definitions(InetLayerConfig INTERFACE INET_CONFIG_ENABLE_DNS_RESOLVER=1 INET_WANT_ENDPOINT_DNS=1)
endif ()

if (INET_CONFIG_ENABLE_ASYNC_DNS_SOCKETS)
target_sources(InetLayer PRIVATE AsyncDNSResolverSockets.cpp)
target_compile_definitions(InetLayerConfig INTERFACE INET_CONFIG_ENABLE_ASYNC_DNS_SOCKETS=1)
endif ()

if (INET_CONFIG_ENABLE_IPV4)
target_compile_definitions(InetLayerConfig INTERFACE INET_CONFIG_ENABLE_IPV4=1)
endif ()

if (CHIP_SYSTEM_CONFIG_USE_SOCKETS)
target_compile_definitions(InetLayerConfig INTERFACE CHIP_SYSTEM_CONFIG_USE_SOCKETS=1)
endif ()

if (CHIP_SYSTEM_CONFIG_USE_LWIP)
target_compile_definitions(InetLayerConfig INTERFACE CHIP_SYSTEM_CONFIG_USE_SOCKETS=0 CHIP_SYSTEM_CONFIG_USE_LWIP=1)
target_link_libraries(InetLayer PUBLIC lwip)
endif ()

if (INET_PROJECT_CONFIG_INCLUDE)
target_compile_definitions(InetLayerConfig INTERFACE INET_PROJECT_CONFIG_INCLUDE=${INET_PROJECT_CONFIG_INCLUDE})
endif ()

if (INET_PLATFORM_CONFIG_INCLUDE)
target_compile_definitions(InetLayerConfig INTERFACE INET_PLATFORM_CONFIG_INCLUDE=${INET_PLATFORM_CONFIG_INCLUDE})
endif ()

target_link_libraries(CHIP INTERFACE InetLayer)

endif (CHIP_CONFIG_NETWORK_LAYER_INET)
