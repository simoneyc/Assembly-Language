; 6.11.6 -  Boolean Calculator (2)
INCLUDE Irvine32.inc

.data
msgMenu BYTE "Hello, this is Boolean Calculator",0dh,0ah
BYTE 0dh,0ah
BYTE "Press 1 for x AND y"     ,0dh,0ah
BYTE "Press 2 for x OR y"      ,0dh,0ah
BYTE "Press 3 for NOT x"       ,0dh,0ah
BYTE "Press 4 for x XOR y"     ,0dh,0ah
BYTE "Press 5 for Exit program",0

msgAND BYTE "AND_op",0
msgOR  BYTE "OR_op",0
msgNOT BYTE "NOT_op",0
msgXOR BYTE "XOR_op",0

msgInt1 BYTE "Enter a 32-bit hex integer:  ",0
msgInt2 BYTE "Enter a 32-bit hex integer:  ",0
msgResult   BYTE "The result is:            ",0

case BYTE '1'			
	DWORD AND_op			
_Size = ($ - case )
	BYTE '2'
	DWORD OR_op
	BYTE '3'
	DWORD NOT_op
	BYTE '4'
	DWORD XOR_op
	BYTE '5'
	DWORD ExitProgram
NumberOfEntries = ($ - case) / _Size

.code
main PROC
	call Clrscr				

	Menu:
		mov edx, OFFSET msgMenu		
		call WriteString			
		call Crlf				

	L1:	call ReadChar			
		cmp al, '5'				
		ja L1					
		cmp al, '1'
		jb L1					

		call Crlf				
		call aProcedure		
		jc quit				

		call Crlf
		jmp Menu				

	quit: exit
main ENDP

aProcedure PROC

	push ebx				
	push ecx				
	mov ebx, OFFSET case	
	mov ecx, NumberOfEntries	

L1:	cmp al, [ebx]			
	jne L2				
	call NEAR PTR [ebx + 1]		
	jmp L3

	L2:	add ebx, _Size		
		loop L1				

	L3:	pop ecx				
		pop ebx				

	ret					

aProcedure ENDP

AND_op PROC

	pushad				

	mov edx, OFFSET msgAND		
	call WriteString			
	call Crlf
	mov edx, OFFSET msgInt1	
	call WriteString
	call ReadHex			
	mov ebx, eax			
	mov edx, OFFSET msgInt2	
	call WriteString
	call ReadHex			
	and eax, ebx			;The answer store here (eax)
	mov edx, OFFSET msgResult	
	call WriteString			
	call WriteHex			
	call Crlf

	popad					
	ret					

AND_op ENDP

OR_op PROC

	pushad				

	mov edx, OFFSET msgOR		
	call WriteString			
	call Crlf
	mov edx, OFFSET msgInt1	
	call WriteString
	call ReadHex			
	mov ebx, eax			
	mov edx, OFFSET msgInt2	
	call WriteString
	call ReadHex		
	or eax, ebx				;The answer store here (eax)
	mov edx, OFFSET msgResult	
	call WriteString
	call WriteHex		
	call Crlf

	popad	
	ret			
OR_op ENDP

NOT_op PROC

	pushad			

	mov edx, OFFSET msgNOT		
	call WriteString		
	call Crlf
	mov edx, OFFSET msgInt1
	call WriteString
	call ReadHex	
	not eax					;The answer store here (eax)
	mov edx, OFFSET msgResult	
	call WriteString
	call WriteHex			
	call Crlf

	popad					
	ret				

NOT_op ENDP

XOR_op PROC

	pushad				

	mov edx, OFFSET msgXOR		
	call WriteString			
	call Crlf
	mov edx, OFFSET msgInt1	
	call WriteString
	call ReadHex		
	mov ebx, eax		
	mov edx, OFFSET msgInt2	
	call WriteString
	call ReadHex			
	xor eax, ebx			;The answer store here (eax)
	mov edx, OFFSET msgResult	
	call WriteString
	call WriteHex			
	call Crlf

	popad					
	ret					

XOR_op ENDP

ExitProgram PROC
	stc					
	ret					
ExitProgram ENDP

END main