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
  username_input_len: equ 64
  validation_value: db "sleepy4k"
  validation_value_len: equ $ - validation_value
  
  ; Define variable with value
  separate: db "----------------------", 10
  separate_len: equ $ - separate

  username_question: db "Silahkan masukan username anda : ", 0
  username_question_len: equ $ - username_question

  username_valid: db "Username valid, selamat datang tuan", 10
  username_valid_len: equ $ - username_valid

  username_invalid: db "Username invalid, silahkan coba lagi", 10
  username_invalid_len: equ $ - username_invalid

section .bss
  ; Make buffer for data input
  username_input: resb username_input_len

section .text
  global _start

_start:
  auth:
    cout separate, separate_len

    cout username_question, username_question_len
    cin username_input

    mov rsi, username_input
    mov rdi, validation_value
    mov rcx, validation_value_len ; Length of the validation value
  
    repe cmpsb ; Compare between username input data and validation value
    jne invalid_input ; Jump on this when return is false
    jmp valid_input ; Jump in this when return is true or username input and validation value are the same

valid_input:
  cout username_valid, username_valid_len
  exit EXIT_CODE

invalid_input:
  cout username_invalid, username_invalid_len
  jmp auth
