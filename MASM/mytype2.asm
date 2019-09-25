.model small                      

.data
	maxl db 10
	actl db ?
	fname db 10 dup(?)
	fhandle dw 0

	newname db "a.txt",0

	mi db 13,10,'Enter filename: $'
	mdi db 13,10,'Enter file contents: $'

	mff db 13,10,  "File found$"
	mfnf db 13,10,"File not Found$"

	mfrs db 13,10,"File read sucessful$"
	mfrns db 13,10,"File read not sucessful$"

	mfc db 13,10,"File contents are:",13,10,"$"

	mfcs db 13,10,"File closed sucessfully$"
	mfcf db 13,10,"File closing failed$"
	
	mcfn db 13,10,"File renamed$"
	
	mcd db 13,10,"Current directory: $"

	buffer db 100 dup ()

	md db 13,10, 'Date : $'     
	mt db 13,10, 'Time : $'     
	
	directory db 50 dup('$')

	Max db 100 
	Actual db ?
	buff db 100 dup('$')  

.code
	main proc
		
		mov ax,@data 
		mov ds,ax
		mov es,ax

		lea dx, md         
		mov ah, 09h              
		int 21h  
		
		;date
		mov ah,2ah    
		int 21h
		mov al,dl    
		aam
		mov bx,ax
		call disp

		mov dl,'/'
		mov ah,02h    
		int 21h

		mov ah,2ah
		int 21h
		mov al,dh    
		aam
		mov bx,ax
		call disp

		mov dl,'/'    
		mov ah,02h
		int 21h

		mov ah,2ah    
		int 21h
		add cx,0f830h 
		mov ax,cx     
		aam
		mov bx,ax
		call disp
 
		lea dx, mt         
		mov ah, 09h              
		int 21h	
		           
		mov ah, 2ch
		int 21h                       
		mov al, ch 
		aam                   
		mov bx, ax
		call disp

		mov dl,':'
		mov ah,02h    
		int 21h

		mov ah, 2ch
		int 21h    
		mov al, cl
		aam
		mov bx, ax
		call disp                  

		mov dl,':'
		mov ah,02h    
		int 21h

		mov ah, 2ch
		int 21h    
		mov al, dh
		aam
		mov bx, ax 		
		call disp                  

		lea dx, mcd         
		mov ah, 09h              
		int 21h     

		mov ah, 47h
		mov dl, 0       
		lea si, directory
		int 21h

		lea dx, directory
		mov ah, 09h
		int 21h

		lea dx,mi
		mov ah,09h
		int 21h

		mov ah, 0ah
		lea dx, maxl       
		int 21h
		
		mov al, actl
		xor ah, ah
		mov si, ax
		mov fname[si], 0  

		lea dx,fname
		mov ax,3d00h        
		int 21h
		jc fnf              
		mov fhandle,ax

		lea dx,mff
		mov ah,09h
		int 21h
		ff:
			mov ah,3fh         
			mov bx,fhandle
			lea dx,buff
			mov cx,100
			xor si,si         
			int 21h
			jc frns           
			lea dx,mfrs
			mov ah,09h
			int 21h

			lea dx,mfc
			mov ah,09h
			int 21h
			
			lea dx,buff 
			mov ah,09h
			int 21h

			mov ah,3eh    
			int 21h
			jc fcf     
			      
			lea dx,mfcs
			mov ah,09h
			int 21h
					
			lea dx,mcfn
			mov ah,09h
			int 21h
					
			mov ah,56h
			lea dx,fname
			lea di,newname
			int 21h

			jmp exit

		fnf:
			lea dx,mfnf
			mov ah,09h
			int 21h

			mov ah,3ch
			xor cx,cx
			lea dx,fname
			int 21h
			jc exit
			mov fhandle,ax

			lea dx,mdi
			mov ah,09h
			int 21h

			mov ah, 0ah
			lea dx, Max        
			int 21h
			
			mov al,Actual
			xor ah, ah

			mov cx,ax
			xor ax,ax
			mov bx,fhandle
			mov ah,40h
			lea dx,buff
			int 21h
			jc exit
			jmp ff
 
		frns:
			lea dx,mfrns
			mov ah,09h
			int 21h
			jmp exit

		fcf:
			lea dx,mfcf
			mov ah,09h
			int 21h

		exit:
			mov ah,4ch
			int 21h
			
	main endp
	disp proc
		mov dl,bh      
		add dl,30h     
		mov ah,02h     
		int 21h

		mov dl,bl      
		add dl,30h    
		mov ah,02h    
		int 21h
		ret
	disp endp 
	                     
	end main