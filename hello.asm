global _start

EXIT_CODE equ 0

; Make macro for write data
%macro cout 2
  mov rax, 1
  mov rdi, 1
  mov rsi, %1
  mov rdx, %2
  syscall
%endmacro

; Make macro for exit program
%macro exit 1
  mov rax, 60
  xor rdi, %1
  syscall
%endmacro

section .data
  welcome: db "Hello, World!", 10
  welcome_len: equ $ - welcome

section .text
  global _start

_start:
  cout welcome, welcome_len

  exit EXIT_CODE
