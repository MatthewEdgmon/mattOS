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

# Arbitrarily chosen to shutup obsolete warnings.
CMAKE_MINIMUM_REQUIRED(VERSION 3.0.0)

# Tell CMake to not try linking the test program it uses to determine if the
# compiler is working. Must be done before first project() call.
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

PROJECT(mattOS VERSION 0.0.0.1 DESCRIPTION "A homebrew OS" LANGUAGES CXX C ASM)

SET(IMAGE_ISO_NAME "${CMAKE_CURRENT_BINARY_DIR}/mattOS.iso")
SET(IMAGE_HDD_NAME "${CMAKE_CURRENT_BINARY_DIR}/mattOS.img")

SET(CMAKE_C_FLAGS "-nostdlib -ffreestanding -O2 -Wall -Wextra")
SET(CMAKE_CXX_FLAGS "-nostdlib -ffreestanding -O2 -Wall -Wextra -fno-exceptions -fno-rtti")
SET(CMAKE_ASM_FLAGS "${CFLAGS} -nostdlib -ffreestanding -x assembler-with-cpp")

SET(CMAKE_C_STANDARD 11)
SET(CMAKE_CXX_STANDARD 11)

# Add sub-projects.
ADD_SUBDIRECTORY(source/kernel)
ADD_SUBDIRECTORY(source/libc)

# Command to build ISO image.
ADD_CUSTOM_COMMAND(OUTPUT ${IMAGE_ISO_NAME}
                   COMMAND grub-mkrescue -o ${IMAGE_ISO_NAME} ${CMAKE_SOURCE_DIR}/sysroot
                   DEPENDS kernel
                   COMMENT "Building ISO image."
                   VERBATIM
)

# Command to build hard drive image.
ADD_CUSTOM_COMMAND(OUTPUT ${IMAGE_HDD_NAME}
                   COMMAND genext2fs -d ${CMAKE_SOURCE_DIR}/sysroot -b 131072 -N 4096 ${IMAGE_HDD_NAME}
                   DEPENDS kernel
                   COMMENT "Building HDD image."
                   VERBATIM
)

ADD_CUSTOM_TARGET(GenerateISO ALL DEPENDS ${IMAGE_ISO_NAME})
ADD_CUSTOM_TARGET(GenerateHDD ALL DEPENDS ${IMAGE_HDD_NAME})

# Target to debug with VirtualBox
ADD_CUSTOM_TARGET(vbox
                  COMMAND vboxmanage.exe unregistervm "mattOS_Debug" --delete
                  COMMAND vboxmanage.exe createvm --name "mattOS_Debug" --ostype Other_64 --register
                  COMMAND vboxmanage.exe modifyvm "mattOS_Debug" --memory 1024 --vram 32 --audiocontroller ac97 --bioslogodisplaytime 1 --bioslogofadeout off --bioslogofadein off --biosbootmenu disabled
                  COMMAND vboxmanage.exe storagectl "mattOS_Debug" --add ide --name "IDE"
                  COMMAND vboxmanage.exe storageattach "mattOS_Debug" --storagectl "IDE" --port 0 --device 0 --medium mattOS.iso --type dvddrive
                  COMMAND vboxmanage.exe setextradata "mattOS_Debug" GUI/DefaultCloseAction PowerOff
                  COMMAND vboxmanage.exe startvm "mattOS_Debug" --type gui
                  DEPENDS ${IMAGE_ISO_NAME}
)