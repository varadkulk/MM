.model small                      

.data
	fname db 'a.txt',0
	fhandle dw 0

	mff db  "File found$"
	mfnf db "File not Found$"

	mfrs db 13,10,"File read sucessful$"
	mfrns db 13,10,"File read not sucessful$"

	mfc db 13,10,"File contents are:",13,10,"$"

	mfcs db 13,10,"File closed sucessful$"
	mfcf db 13,10,"File closing failed$"

	buffer db 100 dup ()

.code
	mov ax,@data 
	mov ds,ax

	lea dx,fname
	mov ah,3dh										;interrupt to open file
	mov al,0
	int 21h

	jnc ff
	lea dx,mfnf										;File not found error
	jnz ext

	ff:												;File found
		mov fhandle,ax
		lea dx,mff
		mov ah,09h
		int 21h

		mov ah,3fh									;interrupt to read file
		mov bx,fhandle
		lea dx,buffer
		mov cx,100
		xor si,si
		int 21h

		jnc rf
		lea dx,mfrns
		jnz ext

	rf:												;Read file
		mov si,ax
		mov buffer[si+1],'$'						;Transfering data to buffer
		
		lea dx,mfrs									;File read sucessful
		mov ah,09h
		int 21h

		lea dx,mfc									;Display before file data
		mov ah,09h
		int 21h

		lea dx,buffer								;Display File contents 
		mov ah,09h
		int 21h

		mov ah,3eh									;FIle Closing
		int 21h
		jnc fcs
		lea dx,mfcf									;FIle Closing Failed error
		jnz ext

	fcs:
		lea dx,mfcs									;File closing sucessful
	
	ext:											;Exit
		mov ah,09h
		int 21h

	mov ah,4ch
	int 21h
	end
	