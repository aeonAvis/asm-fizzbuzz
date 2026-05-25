section .data
	LF	equ 0xA		; newline character

	fizz_msg	db "Fizz", LF
	fizz_len	equ $ - fizz_msg

	buzz_msg	db "Buzz", LF
	buzz_len	equ $ - buzz_msg

	fizzbuzz_msg	db "FizzBuzz", LF
	fizzbuzz_len	equ $ - fizzbuzz_msg

section .text
	global _start

is_divisible:
	xor	edx, edx
	mov	eax, ebx
	div	ecx
	test	edx, edx
	ret

_start:
	mov	ebx, 1		; loop counter

loop:
	cmp	ebx, 100	; loop condition
	jg	end

	; check divisibility by 3
	mov	ecx, 3
	call	is_divisible
	jnz	.check_buzzonly	; it cannot be divisible by 15

	; it is divisible by 3, alos check 5
	mov	ecx, 5
	call	is_divisible
	jz	.fizzbuzz	; it is divisible by 15

	jmp	.fizz		; it was only 3

.check_buzzonly:
	; it wasn't divisible by 3, now check 5
	mov	ecx, 5
	call	is_divisible
	jz	.buzz

	; otherwise print the number
	jmp	number

.fizz:
	; write Fizz
	mov	eax, 1
	mov	edi, 1
	mov	esi, fizz_msg
	mov	edx, fizz_len
	syscall

	inc	ebx
	jmp	loop

.buzz:
	; write Buzz
	mov	eax, 1
	mov	edi, 1
	mov	esi, buzz_msg
	mov	edx, buzz_len
	syscall

	inc	ebx
	jmp	loop

.fizzbuzz:
	; write FizzBuzz
	mov	eax, 1
	mov	edi, 1
	mov	esi, fizzbuzz_msg
	mov	edx, fizzbuzz_len
	syscall

	inc	ebx
	jmp	loop

number:
	; we need to convert %ebx to ascii before we print it
	mov	rbp, rsp	; save stack pointer
	mov	eax, ebx
	mov	ecx, 10		; divisor
	mov	r8d, 1		; number of digits + newline
	push	LF

.to_ascii:
	xor	edx, edx
	div	ecx

	add	dl, '0'		; convert remainder to ascii

	; push digit into stack and increase digit counter
	dec	rsp
	mov	[rsp], dl
	inc	r8d

	test	eax, eax
	jnz	.to_ascii

	; write the number
	mov	eax, 1
	mov	edi, 1
	mov	rsi, rsp
	mov	edx, r8d
	syscall

	mov	rsp, rbp	; restore stack pointer

	inc	ebx
	jmp	loop

end:
	xor	edi, edi
	mov	eax, 60
	syscall
