;4.10.5 - Fibonacci Numbers

.386
.model flat, stdcall
.stack 4096
ExitProcess proto
WriteDec PROTO


.data
fiba dword 01d
fibb dword 01d
fib dword 7 dup(0)

.code
main PROC
	mov eax, fiba
	mov fib, eax
	mov eax, fibb
	mov fib + 4, eax

	mov esi, offset fib
	mov edi, offset fib+8
	mov ecx, lengthof fib - 2  ;do it five next

	L1:
		mov eax, 0
		add eax, [esi]
		add esi, type fib
		add eax, [esi]
		mov [edi], eax
		add edi, type fib

	loop L1

	;print on screen
	mov ecx,LENGTHOF fib
	mov esi, OFFSET fib
	L2:
		mov eax,[esi]
		call WriteDec
		add esi,TYPE fib
		loop L2


main endp
end main