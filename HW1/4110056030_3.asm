;4.10.3 -  Summing the Gaps between Array Values

.386
.model flat, stdcall
.stack 4096
ExitProcess proto
WriteDec PROTO


.data
array dword  0,2,5,9,10
count EQU (LENGTHOF array)
total dword 0

.code
main PROC
	mov esi, OFFSET array     
    mov ecx, count            
                             
    
	L1:
        mov eax,[esi]			
        add esi, 4			   
        mov ebx,[esi]			
        
        sub ebx, eax			
        add total, ebx			   
        Loop L1  

	;print on screen
	mov esi, OFFSET total
	call WriteDec


main endp
end main