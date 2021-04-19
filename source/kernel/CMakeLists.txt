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

PROJECT(mattOS_kernel)

SET(TARGET_NAME "kernel")

FILE(GLOB_RECURSE SOURCE_FILES CONFIGURE_DEPENDS *.s *.c *.cpp *.h)

SET(CMAKE_EXE_LINKER_FLAGS "-T ${PROJECT_SOURCE_DIR}/link.ld")

ADD_EXECUTABLE(${TARGET_NAME} ${SOURCE_FILES})

SET_TARGET_PROPERTIES(${TARGET_NAME} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/sysroot/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/sysroot/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/sysroot/boot"
)