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
  number_data: equ 12
  username_input_len: equ 64
  
  ; Define variable with value
  separate: db "----------------------", 10
  separate_len: equ $ - separate

  username_question: db "Silahkan masukan username anda : ", 0
  username_question_len: equ $ - username_question

  username_valid: db "Username valid, selamat datang tuan", 10
  username_valid_len: equ $ - username_valid

  username_invalid: db "Username invalid, silahkan coba lagi", 10
  username_invalid_len: equ $ - username_invalid

  validation_data: db "sleepy4k"
  validation_data_len: equ $ - validation_data

  number_data_equal: db "Nomor ini sama dengan 0", 10
  number_data_equal_len: equ $ - number_data_equal

  number_data_less: db "Nomor ini kurang dari 0", 10
  number_data_less_len: equ $ - number_data_less

  number_data_more: db "Nomor ini lebih dari 0", 10
  number_data_more_len: equ $ - number_data_more

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
    mov rdi, validation_data
    mov rcx, validation_data_len ; Length of the validation value
  
    repe cmpsb ; Compare between username input data and validation value
    jne invalid_input ; Jump on this when return is false
    jmp valid_input ; Jump in this when return is true or username input and validation value are the same

valid_input:
  cout username_valid, username_valid_len

  %if number_data > 0
    cout number_data_more, number_data_more_len
  %elif number_data == 0
    cout number_data_equal, number_data_equal_len
  %else
    cout number_data_less, number_data_less_len
  %endif

  jmp end

invalid_input:
  cout username_invalid, username_invalid_len
  jmp auth

end:
  exit EXIT_CODE