# mattOS

My personal operating system project, not meant for public use.

## Build Instructions

### Toolchain

To download and compile a toolchain, run the script ```toolchain/build.sh```. Required programs, and steps to follow if the script breaks on your system are there.

### OS Images

To build for 32-bit i686 systems:

```
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../CMakeToolchain32.cmake ..
make -j$(nproc)
```

To build for 64-bit x86_64 systems:

```
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../CMakeToolchain64.cmake ..
make -j$(nproc)
```

### Debugging

Once the OS is built it can be debugged with:

```
make vbox
```

## License

```
mattOS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

mattOS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with mattOS.  If not, see <http://www.gnu.org/licenses/>.
```