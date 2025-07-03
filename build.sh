#!/bin/bash 

mkdir build && cd build 
cmake ..
make appimagelight
mv src/appimagelight .
rm -rf src/
rm -rf CMakeFiles
rm cmake_install.cmake 
rm Makefile
