; I want to try the jump instruction
; Just to make sure it works as I want
%include "asm_io.inc"

segment .data
prompt1     db "Enter a number ", 0
prompt2     db "Enter another number ", 0
equal_msg   db "Both numbers are equal ", 0
greater_msg db "First number is greater than second ", 0
lesser_msg  db "First number is less than second ", 0

segment .bss
input1 resd 1
input2 resd 2

segment .text
	global asm_main
asm_main:
	enter 0, 0
	pusha

	mov eax, prompt1
	call print_string

	call read_int
	mov [input1], eax

	mov eax, prompt2
	call print_string

	call read_int
	mov [input2], eax

	; It looks like we need to compare against a register
	mov eax, [input1]     ; to compare we copy input1 to eax
	cmp eax, [input2]
	je are_equal
	jg first_is_greater
	
	mov eax,lesser_msg
	call print_string
	jmp continue

are_equal:
	mov eax, equal_msg
	call print_string
	jmp continue

first_is_greater:
	mov eax, greater_msg
	call print_string
	
continue:
	call print_nl

	popa
	mov eax, 0
	leave
	ret
