;5.9.2. - Linking array items 


INCLUDE Irvine32.inc

;a space
space = 32                        
start = 1               
.data
    
    chars BYTE 48h,41h,43h,45h,42h,44h,46h,47h        
    links DWORD 0,4,5,6,2,3,7,0     
    output BYTE LENGTHOF chars DUP(?)
.code
main PROC
    ;set up offsets
    mov eax,start   
    mov ecx,LENGTHOF chars
    mov ebx,OFFSET chars            
    mov edi,OFFSET links      
    mov esi,OFFSET output   
    ;find the ans
    L1:    
        mov dl,[ebx+eax]      
        mov [esi],dl           
        mov eax,[edi+eax*4]    
        inc esi                   
        loop L1                
    ;set up esi    
    mov esi,OFFSET output       
    mov ecx,LENGTHOF chars   
    ;print        
    L2:    
        mov al,[esi]          
        call WriteChar   
        mov al,space            
        call WriteChar  
        inc esi                           
        loop L2                               
exit
main ENDP

END main