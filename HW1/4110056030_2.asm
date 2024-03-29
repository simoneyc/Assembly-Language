;4.10.2 - Exchanging Pairs of Array Values

.386
.model flat, stdcall
.stack 4096
ExitProcess proto
WriteDec PROTO

.data
array DWORD 1,2,3,4,5,6,7,8,9,10

.code
main PROC
	mov esi, offset array
	mov edi, offset array+TYPE array
	mov ecx, lengthof array/2
	L1:
		mov eax, [esi]
		xchg eax, [edi]
		mov [esi], eax
		add esi, 2*TYPE array
		add edi, 2*TYPE array
	loop L1
	

	;print on screen
	mov ecx,LENGTHOF array
	mov esi, OFFSET array
	L2:
		mov eax,[esi]
		call WriteDec
		add esi,TYPE array
	loop L2

main endp
end main