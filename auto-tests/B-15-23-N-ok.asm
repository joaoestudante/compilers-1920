; TEXT
segment	.text
; ALIGN
align	4
; GLOBAL _main, :function
global	_main:function
; LABEL _main
_main:
; ENTER 0
	push	ebp
	mov	ebp, esp
	sub	esp, 0
; INT 10
	push	dword 10
; INT 3
	push	dword 3
; EQ
	pop	eax
	xor	ecx, ecx
	cmp	[esp], eax
	sete	cl
	mov	[esp], ecx
; DUP32
	push	dword [esp]
; JNZ _L1
	pop	eax
	cmp	eax, byte 0
	jne	near _L1
; INT 10
	push	dword 10
; INT 3
	push	dword 3
; EQ
	pop	eax
	xor	ecx, ecx
	cmp	[esp], eax
	sete	cl
	mov	[esp], ecx
; OR
	pop	eax
	or	dword [esp], eax
; ALIGN
align	4
; LABEL _L1
_L1:
; CALL printi
	call	printi
; TRASH 4
	add	esp, 4
; INT 0
	push	dword 0
; STFVAL32
	pop	eax
; LEAVE
	leave
; RET
	ret
; EXTERN printi
extern	printi
