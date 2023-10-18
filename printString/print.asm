bits 64 ; mark this program as a 64 bits

; ***********************************************************************************
;                             DATA SECTION

section .data

; -----
; Basic constants

NULL            equ 0           ; end of string
STDOUT          equ 1           ; standard output (screen)
SYS_write       equ 1           ; write() syscall

section .text

; ***************************************************************
; Generic function that print string on the screen

global printString
printString:
  push    rbx

  mov     rbx,  rdi                ; save address of a string
  mov     rdx,  0                  ; count = 0

strCountLoop:
  cmp     byte [rbx],   NULL        ; while string[i] != NULL
  je      strCountDone              ; continue counting
  inc     rbx                       ; next char
  inc     rdx                       ; count++
  jmp     strCountLoop

strCountDone:
  cmp     rdx,  0                   ; check if string wasn't empty
  je      prtDone

  ; -----
  ; Print string on the screen

  mov     rax,  SYS_write           ; write() syscall
  mov     rsi,  rdi                 ; address of string to print
  mov     rdi,  STDOUT              ; descriptor of standard output
  syscall                           ; call the kernel (rdx set above)

prtDone:
  pop     rbx
ret
