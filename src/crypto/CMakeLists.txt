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

add_library(ChipCrypto STATIC "")
target_include_directories(ChipCrypto
PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}
)
target_link_libraries(ChipCrypto
PUBLIC
    ChipConfig
    SupportLayer
)

add_library(ChipCryptoConfig INTERFACE)
target_link_libraries(ChipConfig INTERFACE ChipCryptoConfig)

if ("${CHIP_CRYPTO}" STREQUAL "openssl")

find_package(OpenSSL REQUIRED)

target_sources(ChipCrypto
PRIVATE
    CHIPCryptoPALOpenSSL.cpp
)
target_link_libraries(ChipCrypto
PUBLIC
    OpenSSL::SSL
)
target_compile_definitions(ChipCryptoConfig
INTERFACE
    CHIP_CRYPTO_OPENSSL=1
)

endif ()

if ("${CHIP_CRYPTO}" STREQUAL "mbedtls")

target_sources(ChipCrypto
PRIVATE
    CHIPCryptoPALmbedTLS.cpp
)
target_compile_definitions(ChipCryptoConfig
INTERFACE
    CHIP_CRYPTO_MBEDTLS=1
)
# target_link_libraries() mbedtls

endif ()
