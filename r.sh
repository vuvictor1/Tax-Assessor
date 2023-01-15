#!/bin/bash

# Author: Victor V. Vu                                                                      
# Descrption: BASH compilation file                                                         
                                                                                           
# Copyright (C) 2022 Victor V. Vu                                                           
# This program is free software: you can redistribute it and/or modify it under the terms   
# of the GNU General Public License version 3 as published by the Free Software Foundation.  
# This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  
# without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
# See the GNU General Public License for more details. A copy of the GNU General Public     
# License v3 is available here:  <https://www.gnu.org/licenses/>.                                                                                                                    

# Programmed in Ubuntu-based Linux Platform.                                                
# To run program, type in terminal: "sh r.sh"   

# Removes old files when creating new compilation
rm *.o
rm *.out

# Compiles the C++ code
g++ -c -m64 -std=c++17 -fno-pie -no-pie -o assessor.o assessor.cpp #-g

# Compiles the assembly code
nasm -f elf64 -o get_assessed_values.o get_assessed_values.asm #-g -gdwarf

# Compiles the C code
gcc -c -m64 -std=c11 -no-pie -o isfloat.o isfloat.c #-g

# Compiles the assembly code
nasm -f elf64 -o manager.o manager.asm #-g -gdwarf

# Compiles the C code
gcc -c -m64 -std=c11 -no-pie -o show_property_values.o show_property_values.c #-g

# Compiles the assembly code
nasm -f elf64 -o sum_values.o sum_values.asm #-g -gdwarf

# Link files together
g++ -m64 -std=c++17 -fno-pie -no-pie -o ./linked.out assessor.o get_assessed_values.o isfloat.o manager.o show_property_values.o sum_values.o -lm #-g

# Runs the file linked.out
./linked.out
