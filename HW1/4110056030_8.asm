;4.10.8 - Shifting the Elements in an Array

.386
.model flat, stdcall
.stack 4096
ExitProcess proto
WriteString PROTO
WriteDec PROTO

.data
array DWORD 10,20,30,40

.code
main PROC

	    mov esi, offset array
		mov edi, offset array + type array
		mov eax, [esi]
		mov ecx, lengthof array - 1

		L1:
			mov ebx, [edi]
			xchg ebx, eax
			mov [edi], ebx
			add edi, type array
		loop L1

		mov array, eax

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