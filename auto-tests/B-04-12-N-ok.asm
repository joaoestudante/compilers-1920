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
; INT 1
	push	dword 1
; INT 3
	push	dword 3
; SUB
	pop	eax
	sub	dword [esp], eax
; INT 5
	push	dword 5
; SUB
	pop	eax
	sub	dword [esp], eax
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
