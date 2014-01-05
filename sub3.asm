; Now let's do nasty things with the stack...
; yeah
%include "asm_io.inc"
segment .data
sum dd 0

segment .bss
input resd 1

segment .text
	global asm_main
asm_main:
	enter 0, 0
	pusha

	mov edx, 1
start_while:
	push edx
	push dword input
	call get_int

	add esp, 8         ; Remove input and edx from stack
	mov eax, [input]
	cmp eax, 0
	je end_while

	add [sum], eax     ; sum += input, remember? eax still have input
	inc edx            ; i++
	jmp start_while

end_while:
	push dword [sum]   ; push VALUE of sum into the stack
	call print_sum     ; here we go!
	pop ecx            ; remove sum from the stack

	popa
	mov eax, 0
	leave
	ret

segment .data
prompt db ") Enter an integer number (0 to quit): ", 0

get_int:
	push ebp
	mov ebp, esp

	mov eax, [ebp + 12] ; This is i, or well, previous value of edx
	call print_int

	mov eax, prompt
	call print_string

	call read_int
	mov ebx, [ebp + 8]  ; Now ebx has the address of input
	mov [ebx], eax      ; we put the value in input

	pop ebp
	ret                 ; return where we left

segment .data
result db "The sum is ", 0

print_sum:
	push ebp
	mov ebp, esp

	mov eax, result
	call print_string

	mov eax, [ebp + 8]  ; This is SUM
	call print_int
	call print_nl

	pop ebp
	ret
