;********************************************************************************************
; Author Information:                                                                       *
; Name: Victor V. Vu                                                                        *
; Email: vuvictor@csu.fullerton.edu                                                         *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Tax Assessor                                                                *
; This File: sum_values.asm                                                                 *
; Description: Once array is displayed, function is called to sum the array.                *
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

global sum_values

section .data

section .bss

section .text

sum_values:

; Back up registers
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
pushf

; Clear xmms
xorpd xmm15, xmm15
xorpd xmm14, xmm14

mov r15, rdi ; copy array
mov r14, rsi ; copy # of elements into r14
mov rbx, 0 ; counter

; Check if rbx is = to r14, then jump
start_loop:
cmp rbx, r14 
jge stop 

movsd xmm15, qword[r15+8*rbx] ; add into array if counter is not equal to size
addsd xmm14, xmm15 ; store result in xmm14

inc rbx ; increment rbx after each iteration
jmp start_loop ; restart loop

; Save xmm13 in 14 then return as sum in xmm0 
stop:
movsd xmm13, xmm14 
movsd xmm0, xmm14 

; Restore registers
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

ret ; return xmm0
