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
#      This file is the CMake template for the CHIP SDK Cryptography library.
#

add_subdirectory(tests)

add_library(ChipCryptombedTLS INTERFACE)
target_sources(ChipCryptombedTLS INTERFACE CHIPCryptoPALmbedTLS.cpp)
target_include_directories(ChipCryptombedTLS INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(ChipCryptombedTLS INTERFACE CHIP_CRYPTO_MBEDTLS=1)

add_library(ChipCryptoOpenSSL INTERFACE)
target_sources(ChipCryptoOpenSSL INTERFACE CHIPCryptoPALOpenSSL.cpp)
target_include_directories(ChipCryptoOpenSSL INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})
target_compile_definitions(ChipCryptoOpenSSL INTERFACE CHIP_CRYPTO_OPENSSL=1)
