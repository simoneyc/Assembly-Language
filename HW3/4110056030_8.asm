; 6.11.8 - Message Encryption
INCLUDE Irvine32.inc
BUFMax = 128

.data
 sPrompt Byte "Enter the plain text:", 0
 inputKeyPrompt Byte "Key:", 0

 sEncrypt Byte "Cipher text:", 0
 sDecrypt Byte "Decrypted:", 0

 keyArray Byte BUFMax+1 DUP(0)
 keySize Dword ?

 buffer Byte BUFMax+1 DUP(0)
 bufferSize Dword ?

.code
inputMessage PROC
 pushad

 mov edx, OFFSET sPrompt      
 call WriteString

 mov ecx, BUFMax
 mov edx, OFFSET buffer
 call ReadString         

 mov bufferSize, eax

 popad
 ret
inputMessage ENDP

inputKey PROC
 pushad

 mov edx, OFFSET inputKeyPrompt      
 call WriteString

 mov ecx, BUFMax
 mov edx, OFFSET keyArray
 call ReadString          

 mov keySize, eax
 call CRLF

 popad
 ret
inputKey ENDP

encryptMessage PROC
 pushad

 initaial:
  mov esi, 0          
  mov ebx, 0          
 
 reset:
  mov eax, 0          

 loopText:
  mov bl, keyArray[eax]
  xor buffer[esi], bl        
  
  inc eax
  inc esi

  cmp esi, bufferSize        
   je quit

  cmp eax, keySize        
   je reset

  jmp loopText         
 
 quit:
  popad
  ret
encryptMessage ENDP

displayMessage PROC
 pushad

 call WriteString

 mov edx, OFFSET buffer
 call WriteString

 call CRLF

 popad
 ret
displayMessage ENDP

main PROC
 call inputMessage         
 call inputKey          

 call encryptMessage         

 mov edx, OFFSET sEncrypt	;edx answer
 call displayMessage         

 call encryptMessage         
 mov edx, OFFSET sDecrypt	;edx answer
 call displayMessage         

 exit
main ENDP 
END main