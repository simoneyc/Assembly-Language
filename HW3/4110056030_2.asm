; 6.11.2 - Summing Array Elements in a Range

INCLUDE Irvine32.inc
  
.data
arr1 SDWORD 1,2,3,4,5,6,7,8
arr2 SDWORD -1,-2,-3,-4,-5,-6,-7,-8
j SDWORD ?
k SDWORD ?
sum SDWORD ?

.code
SumArr PROC
	mov sum,0
	L1:
	mov eax, [edi]
	.IF (eax >= j) && (eax <= k)
		add sum,eax
	.ENDIF
	add edi,TYPE sum
	loop L1
	mov eax,sum ;The answer is stored here (eax)
	ret
SumArr ENDP

main PROC
	;call 1st
	mov j,2
	mov k,5
	mov ecx,LENGTHOF arr1
	mov edi,OFFSET arr1
	call SumArr
	call WriteInt
	call Crlf
	
	;call 2nd
	mov j,-7
	mov k,-5
	mov ecx,LENGTHOF arr2
	mov edi,OFFSET arr2
	call SumArr
	call WriteInt
	call Crlf
exit
main ENDP

END main