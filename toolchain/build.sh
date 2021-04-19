#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# BUILD CONFIGURATION OPTIONS
# Toolchain versions, this should match the filname of the tarball minus extension.
GCC=gcc-10.3.0
BINUTILS=binutils-2.36.1
# Directory to place built toolchain.
PREFIX=$DIR/local
# Target triplet for toolchain.
TARGET=i686-elf
#TARGET=i686-pc-mattos
# System root for toolchain location.
SYSROOT=$DIR/../sysroot
LIBC=$DIR/../source/libc

function main() {

    if [ -f $DIR/.toolchain-built ]; then
        echo "Toolchain already built. Rebuilding in 10 seconds."
        for i in {10..1};do echo "." && sleep 1; done
        echo
        clean
    fi

    # Check commands needed to build toolchain are present.
    command_check wget
    command_check tar
    command_check find
    command_check patch
    command_check make
    command_check gcc
    command_check genisoimage
    command_check genext2fs

    echo "Building toolchain in $PREFIX targeting $TARGET at sysroot $SYSROOT"

    # Create toolchain subdirectories.
    directory_check $DIR/build
    directory_check $DIR/build/$GCC
    directory_check $DIR/build/$BINUTILS
    directory_check $DIR/download
    directory_check $DIR/local
    directory_check $DIR/source

    # Prepare system root.
    build_sysroot

    # Download tarballs.
    download_tarball "ftp://ftp.gnu.org/gnu/gcc/$GCC/" $GCC ".tar.xz"
    download_tarball "ftp://ftp.gnu.org/gnu/binutils/" $BINUTILS ".tar.xz"

    # Extract tarballs.
    extract_tarball $GCC ".tar.xz"
    extract_tarball $BINUTILS ".tar.xz"

    # Patch sources.
    apply_patches $BINUTILS
    apply_patches $GCC

    # Build binutils.
    pushd $DIR/build/$BINUTILS > /dev/null
        $DIR/source/$BINUTILS/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot=$SYSROOT --disable-werror --disable-nls --disable-libssp
        make -j$(nproc) --output-sync
        make install
    popd > /dev/null

    # Build gcc.
    pushd $DIR/build/$GCC > /dev/null
        # TODO: Enable this configure option once GCC patching is put in.
        #$DIR/source/$GCC/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot=$SYSROOT --enable-languages=c,c++ --disable-nls --disable-libssp
        $DIR/source/$GCC/configure --target=$TARGET --prefix="$PREFIX" --enable-languages=c,c++ --disable-nls --disable-libssp
        make -j$(nproc) --output-sync all-gcc all-target-libgcc
        make install-gcc install-target-libgcc
    popd > /dev/null

    touch $DIR/.toolchain-built
}

function directory_check() {
    if [ ! -d $1 ]; then
        mkdir -p $1
    fi
}

function command_check() {
    command -v $1 >/dev/null 2>&1 || { echo "Command "$1" was not found on your system, ensure the software is installed and run build.sh again."; exit 1; }
}

function build_sysroot() {
    directory_check $SYSROOT
    directory_check $SYSROOT/bin
    directory_check $SYSROOT/boot
    directory_check $SYSROOT/boot/grub
    # Copy grub files to boot/grub
    # TODO
    directory_check $SYSROOT/lib
    directory_check $SYSROOT/usr/include
    directory_check $SYSROOT/usr/lib

    # Copy libc headers to system root.
    (cd $LIBC/include && find . -name '*.h' -print | tar --create --files-from -) | (cd $SYSROOT/usr/include/ && tar xvfp -)
}

function apply_patches() {

    pushd $DIR/patches > /dev/null
    popd > /dev/null

}

function download_tarball() {

    pushd $DIR/download > /dev/null
        if [ ! -f "$2$3" ]; then
            echo "Downloading $2$3"
            wget -q "$1$2$3"
        else
            echo "File $2$3 already exists. Skipping download."
        fi
    popd > /dev/null

}

function extract_tarball() {

    pushd $DIR/source > /dev/null
        if [ ! -d "./$1" ]; then
            echo "Extracting $1$2"
            tar -xf ../download/$1$2
        else
            echo "Directory $1 already exists. Skipping extraction."
        fi
    popd > /dev/null

}

function clean() {
    rm -rf $DIR/build
    #rm -rf $DIR/download
    rm -rf $DIR/local
    rm -rf $DIR/source
    rm -rf $DIR/.toolchain-built
}

main "$@"
