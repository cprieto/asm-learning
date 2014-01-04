; Guess a prime
; Only God knows why this algorithm works
%include "asm_io.inc"

segment .data
message db "Find primes up to: ", 0

segment .bss
limit resd 1
guess resd 1

segment .text
	global asm_main
asm_main:
	enter 0, 0
	pusha

	mov eax, message
	call print_string

	call read_int
	mov [limit], eax

	mov eax, 2
	call print_int
	call print_nl
	mov eax, 3
	call print_int
	call print_nl

	mov dword [guess], 5

start_guess:
	mov eax, [guess]
	cmp eax, [limit]
	jbe end_guess
	mov ebx, 3                ; factor = 3

while_factor:
	mov edx, 0
	mul ebx                   ; edx:eax = ebx * ebx 
	jo end_while_factor       ; last operation doesn't fit in eax alone
	cmp eax, [guess]
	jnbe end_while_factor     ; (factor * factor) > guess
	mov eax, [guess]
	mov edx, 0
	div ebx                   ; edx:eax % ebx = edx
	cmp edx, 0
	je end_while_factor
	add dword [guess], 2

end_while_factor:
	mov eax, [guess]
	mov edx, 0
	div ebx
	cmp edx, 0
	je end_if
	mov eax, guess
	call print_int
	call print_nl

end_if:
	add dword [guess], 2
	
end_guess:
	popa
	mov eax, 0
	leave
	ret
