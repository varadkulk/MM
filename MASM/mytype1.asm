.model small                      

.data
	fname db 'a.txt',0
	fhandle dw 0

	mff db 13,10, "FILE FOUND$"
	mfnf db 13,10,"FILE NOT FOUND$"

	mfrs db 13,10,"FILE READ SUCESSFUL$"
	mfrns db 13,10,"FILE READ NOT SUCESSFUL$"

	mfc db 13,10,"FILE CONTENTS ARE: $"
	ms db 13,10,"$"

	mfcs db 13,10,"FILE CLOSED SUCCESSFUL $"
	mfcf db 13,10,"FILE CLOSING FAILED$"

	buffer db 100 dup ()

.code
	mov ax,@data 
	mov ds,ax

	lea dx,fname
	mov ah,3dh
	mov al,2
	int 21h

	jnc ff
	lea dx,mfnf
	jnz ext

	ff:
		mov fhandle,ax
		lea dx,mff
		mov ah,09h
		int 21h
		mov ah,3fh
		mov bx,fhandle
		lea dx,buffer
		mov cx,100
		xor si,si
		int 21h
		jnc rf
		lea dx,mfrns
		jnz ext

	rf:
		mov si,ax
		mov buffer[si+1],'$'
		lea dx,mfrs
		mov ah,09h
		int 21h
		lea dx,mfc
		mov ah,09h
		int 21h
		lea dx,ms
		mov ah,09h
		int 21h
		lea dx,buffer 
		mov ah,09h
		int 21h

		mov ah,3eh
		int 21h
		jnc fcs
		lea dx,mfcf
		jnz ext

	fcs:
		lea dx,mfcs
	
	ext:
		mov ah,09h
		int 21h

	mov ah,4ch
	int 21h
	end
	