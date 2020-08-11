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

# Library body.
add_library(ChipCrypto STATIC "")
target_link_libraries(ChipCrypto
PUBLIC
    ChipConfig
    SupportLayer
)

# CHIP configuration.
add_library(ChipCryptoConfig INTERFACE)
target_link_libraries(ChipConfig INTERFACE ChipCryptoConfig)

#
# OpenSSL crypto variant
#
if ("${CHIP_CRYPTO}" STREQUAL "openssl")

target_sources(ChipCrypto
PRIVATE
    CHIPCryptoPALOpenSSL.cpp
)
target_compile_definitions(ChipCryptoConfig
INTERFACE
    CHIP_CRYPTO_OPENSSL=1
)

#
# Find OpenSSL and add it to usage requirements.
#
find_package(OpenSSL REQUIRED)
target_link_libraries(ChipCrypto
PUBLIC
    OpenSSL::SSL
)

endif ("${CHIP_CRYPTO}" STREQUAL "openssl")

#
# MbedTLS crypto variant
#
if ("${CHIP_CRYPTO}" STREQUAL "mbedtls")

target_sources(ChipCrypto
PRIVATE
    CHIPCryptoPALmbedTLS.cpp
)
target_compile_definitions(ChipCryptoConfig
INTERFACE
    CHIP_CRYPTO_MBEDTLS=1
)

#
# If we use the builtin mbedTLS, add it to the usage requirements.
#
if (CHIP_CONFIG_ENABLE_BUILTING_MBEDTLS)
target_link_libraries(ChipCrypto PUBLIC mbedtls)
endif ()

endif ("${CHIP_CRYPTO}" STREQUAL "mbedtls")
