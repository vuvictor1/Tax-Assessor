;********************************************************************************************
; Author Information:                                                                       *
; Name: Victor V. Vu                                                                        *
; Email: vuvictor@csu.fullerton.edu                                                         *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Tax Assessor                                                                *
; This File: manager.asm                                                                    *
; Description: Called by assessor which calls for get input, show value, and sum value      *
;                                                                                           *
; Copyright (C) 2022 Victor V. Vu                                                           *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;                                                                                           *
; Programmed in Ubuntu-based Linux Platform.                                                *
; To run program, type in terminal: "sh r.sh"                                               *
;********************************************************************************************

; Required externals
extern printf
extern scanf
extern fgets
extern stdin
extern strlen 
extern atof ; converts string to float
extern isfloat 
extern show_property_values
extern get_value
extern sum_values

; Set maximum bytes for variables
INPUT_LEN equ 256 ; max bytes of name, title, response
cells equ 16 ; hold max btyes for input

global tax ; Giving the function global scope

segment .data ; Indicates initialized data

; Format specifiers
string_format db "%s", 0 
int_format db "%ld", 0
array_format db 10, 10, "The sum of assessed values is %ld", 0

; Text variables
name_prompt db 10, "Please enter your name and press enter: ", 0
title_prompt db "Please enter your title: ", 0
name_output db "Thank you %s.", 10, 10, 0
float_prompt db "Next we will collect the property values in your assessment district. Between each value enter while space. When finished entering values press <enter> followed by control+D.", 10, 10, 0
sum_print db 10, "The sum of assessed values is $%.2lf", 10, 0
mean_print db "The mean assessed value is $%.4lf.", 10, 0
mean_return db 10, "The mean will now be returned to the caller function.", 10, 0
leave_text db "We enjoy serving everyone who is a %s.", 0

segment .bss ; Indicates values that require user input

; Reserve bytes
align 16
title: resb INPUT_LEN
name: resb INPUT_LEN 
user_input: resb 32
plywood resq cells

segment .text ; Stores executable code

tax: ; = assembly equivalent of int main() {} 

; Required 15 pushes and pops for asssembly to run
push       rbp

mov        rbp, rsp
push       rbx
push       rcx
push       rdx
push       rsi
push       rdi
push       r8
push       r9
push       r10
push       r11
push       r12
push       r13
push       r14
push       r15
pushf

; Prompt asking for name
mov rax, 0
mov rdi, name_prompt
call printf

; fgets block to take input
mov rax, 0
mov rdi, name
mov rsi, INPUT_LEN ; read 256 btyes
mov rdx, [stdin] ; move data from stdin to rdx
call fgets ; call fgets function

; Take 2nd part of name
mov rax, 0
mov rdi, name
call strlen ; call strlen which returns length of string up to \0
sub rax, 1 ; subtract 1 from rax to find \n
mov byte [name + rax], 0 ; replace byte where \n is with \0

; Asks for title input
mov rax, 0
mov rdi, title_prompt
call printf

; fgets takes user input
mov rax, 0
mov rdi, title
mov rsi, INPUT_LEN ; read 256 btyes
mov rdx, [stdin] ; move data from stdin to rdx
call fgets ; call fgets function

; Take 2nd part of title
mov rax, 0
mov rdi, title
call strlen ; call strlen which returns length of string up to \0
sub rax, 1 ; subtract 1 from rax to find \n
mov byte [title + rax], 0 ; replace byte where \n is with \0

; Print out the name
mov rax, 0
mov rdi, name_output
mov rsi, name
call printf

; Prompt asking for floats
mov rax, 0
mov rdi, float_prompt
call printf

; Receives property values from user & passed array 
push qword 0
mov rax, 0
mov rdi, plywood ; move array into rdi
mov rsi, cells ; cells represent array size
call get_value
mov r14, rax ; save the size of the array
pop rax

; If r14 is 0, there is no array
cmp r14, 0
je no_array

; Show values in an array.
mov rax, 0
mov rdi, plywood
mov rsi, r14
call show_property_values

no_array:
mov rax, 0
mov rdi, plywood ; move array into rdi
mov rsi,r14      ; move number of elements in array
call sum_values  ; function call to sum array
movsd xmm15, xmm0  ; save a copy of the returned value in xmm15

; Print out sum of 0 if no array
mov rax, 1
mov rdi, sum_print
movsd xmm0, xmm15
call printf

; Calculate mean
xorpd xmm12, xmm12  ; clears space in xmm12
cvtsi2sd xmm12,r14  ; convert number of elements from integer to IEEE754
divsd xmm13, xmm12  ; divide sum of values by number of elements
; Mean is now safely stored in xmm13

; Print out the mean
mov rax, 1
mov rdi, mean_print
movsd xmm0, xmm13
call printf

; Text stating mean will be returned
mov rax, 0
mov rdi, mean_return
call printf

; Text greeting user farewell before exiting
mov rax, 0
mov rdi, leave_text
mov rsi, title
call printf

movsd xmm0, xmm13 ; copy mean to free register for return

; Backs up 15 pushes and pop, required for assembly
popf
pop rbx
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rcx
pop rdx
pop rsi
pop rdi
pop rbp

ret ; return statemnt
