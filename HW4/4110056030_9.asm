; 8.11.9 -  Counting Nearly Matching Elements

INCLUDE Irvine32.inc

CountNearMatches PROTO, aptr:PTR SDWORD, bptr:PTR SDWORD, sizeA:DWORD, diff:DWORD
.data
array1_a SDWORD 1,2,3,4,5,6,7,8,9,10
array1_b SDWORD 2,4,6,8,10,12,14,16,18,20
array2_a SDWORD 3,6,9,12,15,18,21,24,27,30
array2_b SDWORD 5,10,15,20,25,30,35,40,45,50
array3_a SDWORD 1,3,6,7,4,1,2,5,9,11
array3_b SDWORD 1,3,5,7,9,11,13,15,17,19
array4_a SDWORD 10,20,30,40,50,60,70,80,90,100
array4_b SDWORD 100,50,150,200,25,75,125,175,250,225
cnt DWORD ?,0
diff1 DWORD 5
diff2 DWORD 0
diff3 DWORD 2
diff4 DWORD 50

.code
main PROC		
    INVOKE CountNearMatches, ADDR array1_a, ADDR array1_b, LENGTHOF array1_a, diff1
    call WriteInt
    call Crlf
    INVOKE CountNearMatches, ADDR array2_a, ADDR array2_b, LENGTHOF array2_a, diff2
    call WriteInt
    call Crlf
    INVOKE CountNearMatches, ADDR array3_a, ADDR array3_b, LENGTHOF array3_a, diff3
    call WriteInt
    call Crlf
    INVOKE CountNearMatches, ADDR array4_a, ADDR array4_b, LENGTHOF array4_a, diff4
    call WriteInt
    call Crlf
    exit
    main ENDP

CountNearMatches PROC USES edx ebx edi esi ecx, aptr:PTR SDWORD, bptr:PTR SDWORD, sizeA:DWORD, diff:DWORD
    mov esi,aptr
    mov edi,bptr
    mov ecx,sizeA
L1:
    mov ebx,0
    mov ebx,[esi]
    mov edx,0
    mov edx,[edi]
    ; use IF & ELSE
    .IF ebx > edx
        mov eax,ebx
        sub eax,edx
    .ELSE
        mov eax,edx
        sub eax,ebx
    .ENDIF
    .IF (eax <= diff)
        inc cnt
    .ENDIF
    add esi, SIZEOF SDWORD
    add edi, SIZEOF SDWORD
    loop L1
    mov eax,0
    mov eax,cnt
    mov cnt,0
    ret
    CountNearMatches ENDP
    END main