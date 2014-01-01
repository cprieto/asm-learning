; My second assembly program
; Now we do math operations

%include "asm_io.inc"

segment .data
prompt     db "Enter a number: ", 0
square_msg db "Square of input is ", 0
cube_msg   db "Cube of input is ", 0
cube25_msg db "25 times the cube of input is ", 0
quot_msg   db "Quotient of cube/100 is ", 0
rem_msg    db "Remainder of cube/100 is ", 0
neg_msg    db "The negation of the remainder is ", 0

segment .bss
input resd 1

segment .text
	global asm_main
asm_main:
	enter 0,0
	pusha

	mov eax, prompt
	call print_string

	call read_int
	mov [input], eax

	imul eax            ; Multiply EAX * EAX = EDX:EAX
	mov ebx, eax
	mov eax, square_msg
	call print_string
	mov eax, ebx
	call print_int
	call print_nl

	; Now remember, EBX has the squared value
	mov ebx, eax        ; Multiply EBX * [input] = EBX
	imul ebx, [input]
	mov eax, cube_msg
	call print_string
	mov eax, ebx
	call print_int
	call print_nl

	; EBX contains cubed value
	; Another way to multiply, multiply EBX * 25 = ECX
	imul ecx, ebx, 25
	mov eax, cube25_msg
	call print_string
	mov eax, ecx
	call print_int
	call print_nl

	; Now ECX has the 25*cube
	; And EBX has the cube
	mov eax, ecx
	cdq                ; extend EAX so EDX is zero
	mov ecx, 100
	idiv ecx           ; we divide cube (EDX:EAX) by 100 (ECX)
	; After this remember, EDX has remainder, EAX quotient
	mov ecx, eax
	mov eax, quot_msg
	call print_string
	mov eax, ecx
	call print_int
	call print_nl
	mov eax, rem_msg
	call print_string
	mov eax, edx
	call print_int
	call print_nl

	; EDX still contain remainder
	; NEG is our friend when trying to negate a number	
	neg edx
	mov eax, neg_msg
	call print_string
	mov eax, edx
	call print_int
	call print_nl

	popa
	mov eax, 0
	leave
	ret
