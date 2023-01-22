;********************************************************************************************
; Author Information:                                                                       *
; Name: Victor V. Vu                                                                        *
; Email: vuvictor@csu.fullerton.edu                                                         *
;                                                                                           *
; Program Information:                                                                      *
; Program Name: Harmonic Series                                                             *
; This File: manager.asm                                                                    *
; Description: Called by harmonic to ask prompt and then calls on compute_sum for sum       *
;********************************************************************************************
; Copyright (C) 2022 Victor V. Vu                                                           *
; This program is free software: you can redistribute it and/or modify it under the terms   *
; of the GNU General Public License version 3 as published by the Free Software Foundation. *
; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY  *
; without even the implied Warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. *
; See the GNU General Public License for more details. A copy of the GNU General Public     *
; License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;********************************************************************************************
; Programmed in Ubuntu-based Linux Platform.                                                *
; To run program, type in terminal: "sh r.sh"                                               *
;********************************************************************************************
extern printf
extern scanf

extern compute_sum
extern clock_check

global manager ; Function declared with global scope

segment .data ; Indicates initialized data

item_prompt db "How many terms do you want to include? ", 0
int_format db "%ld", 0
float_format db "%lf", 0
start_time db "Thank you. The time is now %lu tics.", 10
            db "The computation has begun.", 10, 10, 0
end_time db 10, "The time is now %lu tics.", 10, 10, 0
elapsed_time db "The elapsed time is %.0lf tics", 10, 10, 0
cpu_clock db "An Intel processor was detected. Your processor frequency is: %.2lf GHz", 10, 10, 0
amd_clock db "An Amd processor was detected. Please enter your processor frequency in GHz: ", 0
seconds db "The elapsed time equals %.11lf seconds", 10, 10, 0
exit db "The sum will be returned to the caller module.", 10, 0

segment .bss ; Indicates values that require user input

segment .text ; Stores executable code

manager: ; program will enter assembly = int main() {}

; Backs up 15 pushes, required for assembly
push rbp
mov rbp, rsp
push rbx
push rcx
push rdx
push rdi
push rsi
push r8
push r9
push r10
push r11
push r12
push r13
push r14
push r15
pushf

; ask user for number of items
mov rax, 0
mov rdi, item_prompt
call printf

; take in user input
push qword 0
push qword 0
mov rax, 0
mov rdi, int_format
mov rsi, rsp
call scanf
pop r12 ; pop input into r12
pop rax

; Start Tick Calulator
;---------------------

; zero out rax and rdx to use
mov rax, 0
mov rdx, 0

cpuid ; stop system process
rdtsc ; read cpu info

shl rdx, 32 ; shift bits in rdx 32 bits left
add rdx, rax ; add right half of cpu info
mov r14, rdx ; store tics into r14

; print out start time tics elapsed
mov rax, 0
mov rdi, start_time
mov rsi, r14
call printf

; call compute sum
mov rax, 0
mov rdi, r12
call compute_sum
movsd xmm10, xmm12

; compare results if Intel
movq r10, xmm10
cmp r10, 0 ; if 10 is bigger than 0 than intel cpu
jge print_out
; End Tick Calulator
;---------------------

cpuid ; stop system processes
rdtsc ; read cpu info

shl rdx, 32 ; shift bits in rdx 32 bits left
add rdx, rax ; add right half of cpu info
mov r13, rdx ; store tics into r13

; print out end tics
mov rax, 0
mov rdi, end_time
mov rsi, r13
call printf

; Elapsed Time Calulator
;---------------------

; convert tics to float numbers
cvtsi2sd xmm15, r14 ; start time
cvtsi2sd xmm14, r13 ; end time

subsd xmm14, xmm15 ; subtract end with start tic
movsd xmm15, xmm14 ; save value intto xmm15
movsd xmm12, xmm15 ; copy elapsed time into xmm12

; print out elapsed tics
mov rax, 1
mov rdi, elapsed_time
movsd xmm0, xmm15
call printf

;--------------------

; get cpu clock speed
mov rax, 1
call clock_check
movsd xmm13, xmm0

; check for amd cpu
mov rax, 0
cvtsi2sd xmm9, rax
ucomisd xmm13, xmm9
jg print_out

; ask for amd clock
mov rax, 0
mov rdi, amd_clock
call printf

; take in amd clock
mov rax, 1
mov rdi, float_format
mov rsi, rsp
call scanf
movsd xmm8, [rsp]
movsd xmm13, xmm8
jmp amd_exit

print_out:
; print out cpu clock speed
mov rax, 1
mov rdi, cpu_clock
movsd xmm0, xmm13
call printf

; Nanoseconds and seconds conversation
;-------------------------------------
amd_exit:
;convert to nanoseconds
divsd xmm12, xmm13 ; take elapsed tic and divde by clock speed

; move 1 billion hex into xmm11
mov rax, 0x41cdcd6500000000
push rax
movsd xmm11, [rsp] ; dereference top of stack to move value
pop rax

; divide nanoseconds by 1 billion for secs
divsd xmm12, xmm11

; print out seconds
mov rax, 1
mov rdi, seconds
movsd xmm0, xmm12
call printf

; return sum text before leaving program
mov rax, 0
mov rdi, exit
call printf

movsd xmm0, xmm10 ; send seconds

; Backs up 15 pops, required for assembly
popf
pop r15
pop r14
pop r13
pop r12
pop r11
pop r10
pop r9
pop r8
pop rsi
pop rdi
pop rdx
pop rcx
pop rbx
pop rbp

ret ; return value to caller
