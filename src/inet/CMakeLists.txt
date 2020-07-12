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

add_subdirectory(tests)

chip_add_core_library(InetLayer)

target_sources(InetLayer INTERFACE
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
target_include_directories(InetLayer INTERFACE
    ${CMAKE_CURRENT_SOURCE_DIR}
)
target_compile_definitions(InetLayer INTERFACE
    CONFIG_NETWORK_LAYER_INET=1
)

chip_public_headers(InetLayer
    ${CMAKE_CURRENT_SOURCE_DIR}/arpa-inet-compatibility.h
    ${CMAKE_CURRENT_SOURCE_DIR}/AsyncDNSResolverSockets.h
    ${CMAKE_CURRENT_SOURCE_DIR}/EndPointBasis.h
    ${CMAKE_CURRENT_SOURCE_DIR}/IANAConstants.h
    ${CMAKE_CURRENT_SOURCE_DIR}/Inet.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetArgParser.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetConfig.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetError.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetFaultInjection.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetInterface.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetLayer.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetLayerBasis.h
    ${CMAKE_CURRENT_SOURCE_DIR}/InetLayerEvents.h
    ${CMAKE_CURRENT_SOURCE_DIR}/IPAddress.h
    ${CMAKE_CURRENT_SOURCE_DIR}/IPEndPointBasis.h
    ${CMAKE_CURRENT_SOURCE_DIR}/IPPrefix.h
    ${CMAKE_CURRENT_SOURCE_DIR}/RawEndPoint.h
    ${CMAKE_CURRENT_SOURCE_DIR}/TCPEndPoint.h
    ${CMAKE_CURRENT_SOURCE_DIR}/TunEndPoint.h
    ${CMAKE_CURRENT_SOURCE_DIR}/UDPEndPoint.h
    ${CMAKE_CURRENT_SOURCE_DIR}/ZephyrSocket.h
)

chip_add_extra_library(TcpEndPoint)
target_sources(TcpEndPoint INTERFACE TCPEndPoint.cpp)
target_compile_definitions(TcpEndPoint INTERFACE INET_CONFIG_ENABLE_TCP_ENDPOINT=1)

chip_add_extra_library(RawEndPoint)
target_sources(RawEndPoint INTERFACE RawEndPoint.cpp)
target_compile_definitions(RawEndPoint INTERFACE INET_CONFIG_ENABLE_RAW_ENDPOINT=1)

chip_add_extra_library(TunEndPoint)
target_sources(TunEndPoint INTERFACE TunEndPoint.cpp)
target_compile_definitions(TunEndPoint INTERFACE INET_CONFIG_ENABLE_TUN_ENDPOINT=1)

chip_add_extra_library(UdpEndPoint)
target_sources(UdpEndPoint INTERFACE UDPEndPoint.cpp)
target_compile_definitions(UdpEndPoint INTERFACE INET_CONFIG_ENABLE_UDP_ENDPOINT=1)

chip_add_extra_library(DnsResolver)
target_sources(DnsResolver INTERFACE DNSResolver.cpp)
target_compile_definitions(DnsResolver INTERFACE INET_CONFIG_ENABLE_DNS_RESOLVER=1 INET_WANT_ENDPOINT_DNS=1)

chip_add_extra_library(AsyncDnsResolver)
target_sources(AsyncDnsResolver INTERFACE AsyncDNSResolverSockets.cpp)
target_compile_definitions(AsyncDnsResolver INTERFACE INET_CONFIG_ENABLE_ASYNC_DNS_SOCKETS=1)

chip_add_extra_library(IPv4Connectivity)
target_compile_definitions(IPv4Connectivity INTERFACE INET_CONFIG_ENABLE_IPV4=1)

chip_add_extra_library(InetSockets)
target_compile_definitions(InetSockets INTERFACE CHIP_SYSTEM_CONFIG_USE_SOCKETS=1)
