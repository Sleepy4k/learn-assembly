bits 64 ; mark this program as a 64 bits

; ***********************************************************************************
;                             INCLUDE SECTION

%include "printString/print.asm"

; ***********************************************************************************
;                             DATA SECTION

section .data

; -----
; Basic constants

LF                  equ 10      ; new line character
SYS_exit            equ 60      ; terminate program
EXIT_SUCCESS        equ 0       ; success code

; -----
; Variables

hello:            db "Hello, World!", LF, NULL

; ***********************************************************************************
;                             CODE SECTION

section .text
global _start
_start:
; -----
; Print hello data

  mov     rdi,  hello
  call    printString

; -----
; End program

progEnd:
  mov     rax,  SYS_exit
  mov     rdi,  EXIT_SUCCESS
  syscall
