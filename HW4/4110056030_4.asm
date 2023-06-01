; 8.11.4 - FindThrees Procedure

INCLUDE Irvine32.inc

FindThrees PROTO,
apointer: PTR DWORD,
aLength:DWORD

.data

msg1 BYTE "three 3s",0
msg2 BYTE "no three 3s",0

arr1 DWORD 1, 2, 3, 3, 2, 3
arr2 DWORD 3, 5, 7, 3, 9
arr3 DWORD 6, 7, 3, 3, 3, 6
arr4 DWORD 4, 6, 3, 3, 3, 6, 9

.code
main PROC
       ; test 3 times
       call Clrscr                                   
       INVOKE FindThrees, OFFSET arr1, LENGTHOF arr1
       .IF eax == 1
           mov edx,OFFSET msg1
           call WriteString
           call Crlf
       .ELSE
           mov edx,OFFSET msg2
           call WriteString
           call Crlf
       .ENDIF
       INVOKE FindThrees, OFFSET arr2, LENGTHOF arr2
       .IF eax == 1
           mov edx,OFFSET msg1
           call WriteString
           call Crlf
       .ELSE
           mov edx,OFFSET msg2
           call WriteString
           call Crlf
       .ENDIF
       INVOKE FindThrees, OFFSET arr3, LENGTHOF arr3
       .IF eax == 1
           mov edx,OFFSET msg1
           call WriteString
           call Crlf
       .ELSE
           mov edx,OFFSET msg2
           call WriteString
           call Crlf
       .ENDIF
       INVOKE FindThrees, OFFSET arr4, LENGTHOF arr4
       .IF eax == 1
           mov edx,OFFSET msg1
           call WriteString
           call Crlf
       .ELSE
           mov edx,OFFSET msg2
           call WriteString
           call Crlf
       .ENDIF
    exit
main ENDP
FindThrees PROC USES esi ecx, apointer: PTR DWORD, aLength: DWORD  
       mov esi,apointer             
       mov edx,aLength              
       mov ebx,0                     
       mov ecx,0                      
L1:       
       cmp ebx,edx                   
       jz zero                   
       mov eax, [esi]                  
       cmp eax,3                      
       jz cnt                       
       mov ecx,0                      
       jmp next                       
cnt:   
       add ecx,1                    
       cmp ecx,3                      
                                      
       jz one                   
next:                                 
       add ebx,1                      
       add esi,TYPE DWORD             
       jmp L1                          
one:      
       mov eax,1                      
       jmp re                     
zero:
       mov eax,0                      
re:   
       ret                         
FindThrees ENDP
END main