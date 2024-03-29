;4.10.7 -  Copy a String in Reverse Order

.386
.model flat, stdcall
.stack 4096
ExitProcess proto
WriteString PROTO

.data
source BYTE "This is the source string", 0
target BYTE SIZEOF source DUP('#')

.code
main PROC

	    mov esi,0
        mov edi,LENGTHOF source - 2
        mov ecx,SIZEOF source

	 L1:
            mov al,source[esi]
            mov target[edi],al
            inc esi
            dec edi
        loop L1

        mov edx, OFFSET target
        call WriteString


main endp
end main