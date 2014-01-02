; Now let's play with while loops
; More fun ahead! put your seatbelt on!

%include "asm_io.inc"

segment .data
prompt db "Count up to ", 0
finish db "Finished counting ", 0
output db "I see ", 0

segment .text
	global asm_main
asm_main:
	enter 0, 0
	pusha

	mov eax, prompt
	call print_string

	call read_int
	mov ebx, eax          ; EBX has the limit
	mov ecx, 1            ; ECX is our counter
when_start:
	cmp ecx, ebx
	je when_finish
	mov eax, output
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	add ecx, 1
	jmp when_start

when_finish:
	mov eax, finish
	call print_string
	call print_nl

	popa
	mov eax, 0
	leave
	ret
