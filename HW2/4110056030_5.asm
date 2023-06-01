;5.9.5 - BetterRandomRange


INCLUDE Irvine32.inc

.data
count DWORD 0

.code
main PROC

	mov ecx ,50 ;test 50 times
	L1:
		mov ebx,-300 ; lower bound
		mov eax,100 ; upper bound
		call BetterRandomRange
	loop L1
	exit
	

BetterRandomRange PROC
	;get the range
	sub eax,ebx
	call RandomRange
	;add the random number 0~(n-1) to lower bound
	add eax,ebx
	call WriteInt
	call Crlf
ret

BetterRandomRange ENDP

exit
main ENDP
END main