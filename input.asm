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

; Make macro for read data
%macro cin 1
  mov rdi, 1
  mov rsi, %1
  mov rdx, rax
  mov rax, 0
  syscall
%endmacro

; Make macro for destroy data
%macro destroy 2
  mov rdi, %1
  mov rcx, %2
  xor rax, rax
  rep stosb
%endmacro

; Make macro for exit program
%macro exit 1
  mov rax, 60
  xor rdi, %1
  syscall
%endmacro

section .data
  ; Define constant data
  name_input_len: equ 256
  age_input_len: equ 128

  ; Define variable with value
  separate: db "----------------------", 10
  separate_len: equ $ - separate

  welcome: db "Welcome to assembly app", 10
  welcome_len: equ $ - welcome

  name_question: db "Silahkan masukan nama kamu : ", 0
  name_question_len: equ $ - name_question

  age_question: db "Silahkan masukan umur kamu : ", 0
  age_question_len: equ $ - age_question

  name_show: db "Nama kamu adalah ", 0
  name_show_len: equ $ - name_show

  age_show: db "Umur kamu adalah ", 0
  age_show_len: equ $ - age_show

section .bss
  ; Make buffer for data input
  name_input: resb name_input_len
  age_input: resb age_input_len

section .text
  global _start

_start:
  cout welcome, welcome_len

  cout separate, separate_len

  cout name_question, name_question_len
  cin name_input

  cout age_question, age_question_len
  cin age_input

  cout separate, separate_len

  cout name_show, name_show_len
  cout name_input, name_input_len
  destroy name_input, name_input_len

  cout age_show, age_show_len
  cout age_input, age_input_len
  destroy age_input, age_input_len

  cout separate, separate_len

  exit EXIT_CODE
