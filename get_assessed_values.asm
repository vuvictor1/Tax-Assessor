;********************************************************************************************
; Author Information:                                                                       *
; Name: Victor V. Vu                                                                        *
; Email: vuvictor@csu.fullerton.edu                                                         *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Tax Assessor                                                                *
; This File: get_assessed_values.asm                                                        *
; Description: Called by manager to get user input and send it back.                        *
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

extern printf
extern scanf
extern atof
extern isfloat

global get_value

section .data

string_format db "%s", 0
new_format db "%ld", 0

section .bss

section .text

get_value:

; Back up all registers
push rbp
mov rbp, rsp
push rdi
push rsi
push rdx
push rcx
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
push rbx
; -------------------------

mov r15, rdi ; Save address of array to r15.
mov r14, rsi ; Max elements in array.
mov r13, 0 ; Set array counter to 0

input_loop:
; Take user input as a string.
mov rdi, string_format
mov rsi, rsp ; Points to where scanf outputs.
mov rax, 0
call scanf

; Check for controlD which is -1
cdqe
cmp rax, -1
je end_of_loop ; jump to end_of_loop.

mov rax, 0
mov rdi, rsp
call isfloat ; Check if float is valid
cmp rax, 0
je invalid_input

mov rax, 1
mov rdi, rsp
call atof ; Call atof to convert string back to float

movsd [r15+8*r13], xmm0; Copy user input into array at r13.
inc r13 ; Increments counter by 1 at r13.

; Check for max array capacity
cmp r13, r14 ; Compare # of elements (r13) to capacity (r14)
je exit; If # of elements = capacity then finish loop

jmp input_loop ; Restarts loop until user input is done

; jumps here if input is bad
invalid_input: ;Using the alternative method to check for error.

jmp input_loop ; If there is an error then restart

end_of_loop:

mov rax, r13 ; Copy number of elements to rax.

exit:

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

ret
