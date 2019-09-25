.model small
.data
	ctail equ 080H
	max db ?
	min db ?
	fname db 20 dup (?)

	md db "was deleted$"

.code
	mov ax,@data
	mov ds,ax
	mov es,ax

	mov ah,62h
	int 21h

	push ds

	mov ds,bx
	mov si,ctail
	lea di,max
	mov ch,0
	mov cl,[si]
	inc cl
	cld 
	rep movsb
	
	pop ds
	
	xor ax,ax
	mov al,max
	mov si,ax
	mov fname[si],'$'
	; int 21h

	lea dx,fname
	mov ah,41h
	int 21h

	lea dx,fname
	mov ah,09h
	int 21h
	
	lea dx,md
	mov ah,09h
	int 21h

	mov ah,4ch
    int 21h
end