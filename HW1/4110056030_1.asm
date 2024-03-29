;4.10.1 - Converting Big Endian to Little Endian 

.386
.model flat, stdcall
.stack 4096
ExitProcess proto
WriteHex PROTO

.data
bigEndian BYTE 12h, 34h, 56h, 78h
littleEndian DWORD ?

.code
main PROC
	  mov al,[bigEndian+3]
	  mov BYTE PTR [littleEndian+3],al

	  mov al,[bigEndian+2]
	  mov BYTE PTR [littleEndian+2],al

	  mov al,[bigEndian+1]
	  mov BYTE PTR [littleEndian+1],al

	  mov al,[bigEndian]
	  mov BYTE PTR [littleEndian],al

	;print on screen
	mov ecx,LENGTHOF littleEndian
	mov esi, OFFSET littleEndian
	L1:

		mov eax,[esi]
		call WriteHex
		add esi,TYPE littleEndian
		loop L1

	

main endp
end main