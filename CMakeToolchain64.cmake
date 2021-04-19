###############################################################################
# This file is part of mattOS.
#
# mattOS is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# mattOS is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with mattOS.  If not, see <http://www.gnu.org/licenses/>.

# CMake toolchain file for mattOS toolchain.
SET(CMAKE_SYSTEM_NAME mattOS)
SET(CMAKE_SYSTEM_PROCESSOR x86_64)
SET(CMAKE_SYSTEM_VERSION 1)

SET(CMAKE_SYSROOT ${CMAKE_CURRENT_LIST_DIR}/sysroot)
SET(CMAKE_STAGING_PREFIX ${CMAKE_CURRENT_LIST_DIR}/image)

SET(toolchain ${CMAKE_CURRENT_LIST_DIR}/toolchain/local)
SET(CMAKE_ASM_COMPILER ${toolchain}/bin/x86_64-elf-gcc)
SET(CMAKE_C_COMPILER ${toolchain}/bin/x86_64-elf-gcc)
SET(CMAKE_CXX_COMPILER ${toolchain}/bin/x86_64-elf-g++)

SET(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
SET(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
SET(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

SET(CMAKE_C_SIZEOF_DATA_PTR 8)

SET(CMAKE_C_FLAGS "-O2 -g -nostdlib -ffreestanding -fbuiltin -Wall -Wextra -std=c++11 -mcmodel=kernel -mno-red-zone" CACHE STRING "" FORCE)