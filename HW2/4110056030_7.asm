;5.9.7 - Random Screen Locations


INCLUDE Irvine32.inc

.data
X WORD ?
Y WORD ?

.code
main PROC
    
    mov ecx, 100
    L1:
        call GetMaxXY
        mov X, ax
        mov Y, dx       
        movzx eax, X
        call RandomRange
        mov dh, al
        movzx eax, Y
        call RandomRange
        mov dl, al
        call Gotoxy
        mov al,'S'
        call WriteChar
        mov eax,100
        call Delay
        Loop L1
exit
main ENDP

END main