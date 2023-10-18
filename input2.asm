bits 64 ; mark this program as a 64 bits

; ***********************************************************************************
;                             INCLUDE SECTION

%include "printString/print.asm"

; ***********************************************************************************
;                             MACRO SECTION

; -----
; Make macro for read data
; %1 parameter - buffer
%macro cin 1
  mov rdi, STDOUT
  mov rsi, %1
  mov rdx, rax
  mov rax, NULL
  syscall
%endmacro

; ***********************************************************************************
;                             DATA SECTION

section .data

; -----
; Basic constants

LF                  equ 10      ; new line character
NULL                equ 0       ; string terminate
SYS_exit            equ 60      ; terminate program
EXIT_SUCCESS        equ 0       ; success code

; -----
; Variables

separate:           db "----------------------", LF, NULL

welcome:            db "Welcome to assembly app", LF, NULL

name_question:      db "Silahkan masukan nama kamu : ", NULL, NULL
age_question:       db "Silahkan masukan umur kamu : ", NULL, NULL

name_show:          db "Nama kamu adalah ", NULL, NULL
age_show:           db "Umur kamu adalah ", NULL, NULL

section .bss

; -----
; Buffers

name_buffer:        resb 256
age_buffer:         resb 32

; ***********************************************************************************
;                             CODE SECTION

section .text
global _start
_start:
; -----
; Print welcome

  mov     rdi,  welcome
  call    printString

; -----
; Print separate line

  mov     rdi,  separate
  call    printString

; -----
; Print name question input

  mov     rdi,  name_question
  call    printString

; -----
; Read name input value

  cin     name_buffer

; -----
; Print age question input

  mov     rdi,  age_question
  call    printString

; -----
; Read age input value

  cin     age_buffer

; -----
; Print name data

  mov     rdi,  name_show
  call    printString

  mov     rdi,  name_buffer
  call    printString

; -----
; Print age data

  mov     rdi,  age_show
  call    printString

  mov     rdi,  age_buffer
  call    printString

; -----
; End program

progEnd:
  mov     rax,  SYS_exit
  mov     rdi,  EXIT_SUCCESS
  syscall
