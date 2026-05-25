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
	mov	rdx, 0
	mov	rax, rbx
	div	rcx
	test	rdx, rdx
	ret

_start:
	mov	rbx, 1		; loop counter

loop:
	cmp	rbx, 100	; loop condition
	jg	end

	; check divisibility by 15
	mov	rcx, 15
	call	is_divisible
	jz	.fizzbuzz

	; check divisibility by 3
	mov	rcx, 3
	call	is_divisible
	jz	.fizz

	; check divisibility by 5
	mov	rcx, 5
	call	is_divisible
	jz	.buzz

	; otherwise print the number
	jmp	number

.fizz:
	; write Fizz
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, fizz_msg
	mov	rdx, fizz_len
	syscall

	inc	rbx
	jmp	loop

.buzz:
	; write Buzz
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, buzz_msg
	mov	rdx, buzz_len
	syscall

	inc	rbx
	jmp	loop

.fizzbuzz:
	; write FizzBuzz
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, fizzbuzz_msg
	mov	rdx, fizzbuzz_len
	syscall

	inc	rbx
	jmp	loop

number:
	; we need to convert %rbx to ascii before we print it
	mov	rax, rbx
	mov	rcx, 10		; divisor
	mov	r8, 0		; number of digits
	push	LF

.to_ascii:
	mov	rdx, 0		; reset rdx
	div	rcx

	add	dl, '0'		; convert remainder to ascii

	; push digit into stack and increase digit counter
	dec	rsp
	mov	[rsp], dl
	inc	r8

	cmp	rax, 0
	jne	.to_ascii

	inc	r8		; to include newline

	; write the number
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, rsp
	mov	rdx, r8
	syscall

	inc	rbx
	jmp	loop

end:
	mov	rdi, 0
	mov	rax, 60
	syscall
