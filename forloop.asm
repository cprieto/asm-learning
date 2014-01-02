; Another example just to make sure I understand loops
; Simple, but let's face it, this shit is fun
%include "asm_io.inc"

segment .data
prompt db "Count up to ", 0
finish db "Finished counting ", 0
output db "ECX is ", 0
count  db " and I have ", 0

segment .text
	global asm_main
asm_main:
	enter 0, 0
	pusha

	mov eax, prompt
	call print_string

	call read_int
	mov ecx, eax
	mov ebx, 0           ; EBX has the sum, what I am going to count
start_loop:
	mov eax, output
	call print_string
	mov eax, ecx
	call print_int
	mov eax, count
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	add ebx, 1
	loop start_loop
end_loop:
	mov eax, output
	call print_string
	mov eax, ecx
	call print_int
	mov eax, count
	call print_string
	mov eax, ebx
	call print_int
	call print_nl
	mov eax, ecx

	mov eax, finish
	call print_string
	call print_nl

	popa
	mov eax, 0
	leave
	ret
