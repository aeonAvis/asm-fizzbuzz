section .data
	fizz_msg db "Fizz", 10
	buzz_msg db "Buzz", 10
	fizzbuzz_msg db "FizzBuzz", 10
	nope db "No FizzBuzz", 10

section .text
	global _start

_start:
	mov	rbx, 1	; loop counter

loop:
	cmp	rbx, 100	; loop condition
	jg	end

	mov 	rax, rbx
	mov	rcx, 15
	mov	rdx, 0
	div	rcx
	cmp	rdx, 0
	je	fizzbuzz	

	mov 	rax, rbx
	mov	rcx, 3
	mov	rdx, 0
	div	rcx
	cmp	rdx, 0
	je	fizz


	mov 	rax, rbx
	mov	rcx, 5
	mov	rdx, 0
	div	rcx
	cmp	rdx, 0
	je	buzz

	jmp	nofizzbuzz

fizz:
	mov	rdx, 5
	mov	rsi, fizz_msg
	mov	rdi, 1
	mov	rax, 1
	syscall		

	inc	rbx
	jmp	loop

buzz:
	mov	rdx, 5
	mov	rsi, buzz_msg
	mov	rdi, 1
	mov	rax, 1
	syscall		

	inc	rbx
	jmp	loop

fizzbuzz:
	mov	rdx, 9
	mov	rsi, fizzbuzz_msg
	mov	rdi, 1
	mov	rax, 1
	syscall		

	inc	rbx
	jmp	loop

nofizzbuzz:
	mov	rdx, 12
	; TODO: use reg-to-ascii to print %rbx instead
	mov	rsi, nope
	mov	rdi, 1
	mov	rax, 1
	syscall

	inc	rbx
	jmp	loop

end:
	mov	rdi, 0
	mov	rax, 60
	syscall
