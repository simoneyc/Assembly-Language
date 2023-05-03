# 大二下 - Assembly Language - Note
###### tags: `大二下` `組合語言`
**考前筆記整理**
**前面有空再來補**

CH6 Conditional Processing
===
*條件處理*
> 一個看code一直跳來跳去的章節
> 主要看cmp的條件是否成立來決定jump or not

 布林&比較指令 
 ---
 Boolean and Comparison Instructions 
 
---
*  AND
 兩個運算元必須相同大小
 AND可用來清除位元 -> 遮罩(masking)
```MASM!
mov al,10101110b
and al,11110110b    ;al=10100110
```
轉大寫字母
```!
0 1 1 0 0 0 0 1 = 61h ('a')
0 1 0 0 0 0 0 1 = 41h ('A')
```
```MASM!
.data
array BYTE 50 DUP(?)
.code
mov ecx,LENGTHOF array
mov esi,OFFSET array
L1: 
and BYTE PTR [esi],11011111b ; 清掉 bit 5
inc esi
loop L1
```
:::info
:bulb: AND會清除OF & CF
:::
---
*  OR
 兩個運算元必須相同大小
:::info
:bulb: OR會清除OF & CF
:::
透過Flag看al的值
| ZF   | SF   | AL   |
| ---- | ---- | ---- |
|  ZF=0|SF=0  | 大於0 |
|  ZF=1|SF=0  | =0   |
|  ZF=0|SF=1  | 小於0 |
---
*  NOT
1's補數
```MASM!
mov al,11110000b 
not al             ; AL = 00001111b
```
:::info
:bulb: NOT不影響any flag
:::
---
*  XOR
    >互斥 異性戀代表 : 一個1 & 一個0 => 1

對稱式加密 -> 超帥的
>插播一則PF(同位flag)
PF=1 > 偶個1
PF=0 > 奇個1
```MASM!
mov al,10110101b ; 5 個 1
xor al,0         ; PF = 0
mov al,11001100b ; 4 個 1
xor al,0         ; PF = 1
```
:::info
:bulb: XOR會清除OF & CF
:::
---
*  TEST
    >TEST隱含ADN的運算
    >與AND不同點是 -> TEST不會改到*Destination*的值
```MASM!
test al,00001001b    ; 測 0 & 3 bit 也有 bit mask
```
:::info
:bulb: TEST會清除OF & CF
:::
---
*  CMP
>是個logic指令
>偷偷含有減法
>>unsigned

```
小-大要借位 -> CF=1
```
| CMP  | ZF   | CF   |
| ---- | ---- | ---- |
|  左<右|0 | 1 |
|  左>右|0 | 0 |
|  左=右|1 | 0 |
>>signed
>>
```
SF = 負的時候, SF = 1
減法的時候不可能溢位, OF 不可能 = 1, OF 在CMP都 = 0
```
| CMP | Flag |
| -------- | -------- |
| 左<右     |  SF(1) != OF(0) |
| 左>右     |  SF(0) = OF(0)  |
| 左=右     | ZF=1      |
---
* stc & clc
```MASM!
stc ; CF = 1
clc ; CF = 0
```
:::success
:joy: 接下來要跳個不停了:joy: 
:::
 條件跳躍 
 ---
 Conditional Jumps 
 ```html
 C = CF
 O = OF
 S = SF
 P = PF
 E = '='
 N = NOT
 Z = '0'
 CXZ = 'CX=0'
 ```
 ![](https://i.imgur.com/yjEbwqi.jpg)
 ![](https://i.imgur.com/9ljVkgQ.png)

 ```MASM
 CMP leftOp,rightOp
 ```
 
:::warning
:i_love_you_hand_sign: signed & unsigned不一樣的part
:::
```MASM!
mov al,+127      ; 7Fh
cmp al,-128      ; 80h
ja IsAbove       ; 7Fh < 80h so 不跳 ,無號數
jg IsGreater     ; +127 > -128 so 跳
```
* Unsigned
   >A = above
    B = below
    
![](https://i.imgur.com/NpnvQEP.png)
* Signed
   >G = greater
    L = lowerer
    
![](https://i.imgur.com/eJmaxvS.png)
* 可以玩比大小
```MASM!
;找最小的

.data
V1 WORD ?
V2 WORD ?
V3 WORD ?
.code
mov ax,V1     ; 假設 V1 最小
cmp ax,V2     ; if AX <= V2
jbe L1        ; 跳去 L1
mov ax,V2     ; else 把 V2 丟到 AX
L1: cmp ax,V3 ; if AX <= V3
jbe L2        ; jump to L2 
mov ax,V3     ; else 把 V3 丟到 AX
L2:
```
* 這邊一個Readkey
`找到user按下鍵 => ZF=1`

    ```MASM!
    .data
    char BYTE ?
    .code
    L1: mov eax,10 
    call Delay
    call ReadKey    ; 檢查user按下keyboard了沒
    jz L1        
    mov char,AL 
    ```
* 字串加密
    >XOR
![](https://i.imgur.com/xT0EGzY.png)

 
 條件迴圈指令 
 ---
 Conditional Loop Instructions
 * LOOPZ
     >if ZF=1 則繼續loop
 * LOOPE
     >if '=' 則繼續loop
 * LOOPNZ
     >if ZF=0 則繼續loop
 * LOOPNE
     >if '!=' 則繼續loop
    ```MASM!
    .data
    array SWORD -3,-6,-1,-10,10,30,40,4
    sentinel SWORD 0

    .code
    mov esi,OFFSET array
    mov ecx,LENGTHOF array
    L1: test WORD PTR [esi],8000h ; 看這行執行後的 ZF = ?
    pushfd 
    add esi,TYPE array
    popfd 
    loopnz L1 
    jnz quit 
    sub esi,TYPE array 
    quit:
    ```
 
 條件結構 
 ---
 Conditional Structures
 * 白箱測試
     >programmer自行指定給input, 然後...
     >trace trace trace
 * 捷徑估算
     >利用 ja, jbe 等...之類的不同以簡短code
 * WHILE loop
     ```MASM
     mov eax,val1 
    beginwhile:
    cmp eax,val2     ; if (val1 < val2) 是 false
    jnl endwhile
    inc eax 
    dec val2 
    jmp beginwhile 
    endwhile:
    mov val1,eax 
     ```
 * 表格驅動式
     >table-drive
     >![](https://i.imgur.com/nrWDsYS.png)

 應用:有限狀態機 
 ---
 Finite-State Machines(FSM)
* 驗證輸入的string
    >找x & z夾住的string
    >![](https://i.imgur.com/e3VYQ3a.png)
    >```
    >xaabcdefgz
    >xz
    >xyyqqrrstuvz
* 驗證signed int
    >IsDigit
    >```MASM
    >call IsDigit      ; ZF = 1 if AL 是數字
    >jz StateC 
    >```
    >![](https://i.imgur.com/uFngseF.png)

    :::info
    檢查是否在 ' 0 ' ~ ' 9 ' (也就是30~39) 就好
    :::

 條件控制流程指引 
 ---
 Conditional Control Flow Directives
* Conditional Control Flow Directives 
![](https://i.imgur.com/gMh0Gb0.png)
* Runtime Relational and Logical Operators
    `Runtime的relationship & 邏輯運算子`
![](https://i.imgur.com/3Bzy4Uv.png)
* 寫法
    ```MASM
    .data
    val1 DWORD 5
    result DWORD ?
    .code
    mov eax,6
    .IF eax > val1    ;很像高階語言的if
     mov result,1
    .ENDIF            ;一定要有這傢伙
    ```

    組譯器會生出這段

    ```MASM!
    mov eax,6
    cmp eax,val1
    jbe @C0001 
    mov result,1
    @C0001:
    ```

 `//以下還有兩種loop`


* .REPEAT
    ```MASM
    mov eax,0
    .REPEAT
    inc eax
    call WriteDec
    call Crlf
    .UNTIL eax == 10
    ```
* .WHILE
    ```MASM
    mov eax,0
    .WHILE eax < 10
    inc eax
    call WriteDec
    call Crlf
    .ENDW
    ```

CH7 Integer Arithmetic
===
*整數算數運算*
> 把一堆10移來移去的章節
> 分辨CF=1 or CF=0
> 分辨各指令是否包含把位元移進CF

 位移&旋轉指令 
 ---
 Shift and Rotate Instructions
 * SHL & SHR
     >邏輯移位
     >*SHL:*
     >高的去CF 
     >低的補0
     ![](https://i.imgur.com/0ltlYkE.png)
    ```MASM!     
    mov bl,8Fh     ; BL = 10001111b 
    shl bl,1       ; CF = 1, BL = 00011110b
    ```
     >可以乘法:無號數才可
     >左移n次 -> x 2^n
     >
     >---
     >*SHR*
     >
     >![](https://i.imgur.com/28fE0r6.png)
     >可以除法:無號數才可
     >右移n次 -> / 2^n
     ---
 * SAL & SAR
     >跟上面SHL & SHR很像
     >只差在signed跟unsigned
     >*SAL:*
     >![](https://i.imgur.com/SnyiJfM.png)
     >
     >---
     >*SAR:*
     >複製正負號位元 -> 第一個自己複製自己擺回去
     >這個可以執行有號除法!!!
     >![](https://i.imgur.com/uh4T5z9.png)
     >```MASM
     >;AX -> EAX
     >mov ax,-128 ; EAX = ????FF80h
     >shl eax,16  ; EAX = FF800000h
     >sar eax,16  ; EAX = FFFFFF80h
     >```
 * ROL & ROR
     >*ROL:*
     >![](https://i.imgur.com/JvKdWFR.png)
     >可交換位元:
     >ex: 1111 0000 上半和下半交換(byte)
     >-> 0000 1111
     >```MASM!
     >mov al,26h
     >rol al,4     ; AL = 62h
     >```
     >
     >---
     >*ROR:*
     >就 看圖吧 :smile:
     >![](https://i.imgur.com/XiWNzQS.png)
 * RCL & RCR
     >包含CF的旋轉 -> CF加入一起轉
     >*RCL:*
     >![](https://i.imgur.com/hqrgxoX.png)
     >
     >---
     >*RCR:*
     >![](https://i.imgur.com/1sIZmtY.png)
:::success
:bulb:有號數的OF:
旋轉後超過範圍(ex: AL 在 -128 ~ 127)
則OF = 1
:::
 * SHLD & SHRD
     >-> D : double
     >-> 適合做點陣圖影像(manipulate bit-mapped images)
     >*SHLD:*
     >```
     >SHLD dest, source, count
     >```
     >![](https://i.imgur.com/rCqGSU6.png)
     >
     >---
     >*SHRD:*
     >```
     >SHRD dest, source, count
     >```
     >![](https://i.imgur.com/PmMEK2p.png)
 
 應用:位移&旋轉應用
 ---
 Shift and Rotate Applications
 * 移多個DWORD
 ![](https://i.imgur.com/Dg04mxs.png)
 ![](https://i.imgur.com/AGN9ePU.png)
 ![](https://i.imgur.com/eFMqOFj.png)
 ![](https://i.imgur.com/017zSK4.png)
 `總之就是藉由CF把全部移動啦~`
 來個code
 ```MASM!
 .data
ArraySize = 3
array BYTE ArraySize DUP(99h) ; 1001 pattern in each nybble
.code
main PROC
mov esi,0
shr array[esi+2],1            ; high byte
rcr array[esi+1],1            ; middle byte, include CF
rcr array[esi],1              ; low byte, include CF
 ```
---
    
 * 二進位乘法
     >利用分配律
     >![](https://i.imgur.com/ZgGj4nJ.png)
     >![](https://i.imgur.com/M1XyRfu.png)
     >```MASM!
     >mov eax,123
     >mov ebx,eax
     >shl eax,5      ; x 2^5
     >shl ebx,2      ; x 2^2
     >add eax,ebx    ; 加起來
     >```
 ---
 * 日期
     >![](https://i.imgur.com/PhTKyta.png)
     >比較特別是year最後要加上1980
 
 乘法&除法指令
 ---
 Multiplication and Division Instructions
 * MUL
     >無號數
     >記得看CF是否 = 1 (超過AL AX EAX(跑到DX EDX裡面的話)會進位)
     >![](https://i.imgur.com/Ie4ktKb.png)
 * IMUL
     >有號數
     >```MASM!
     >; 因為AH不是AL的+-延伸 -> OF = 1
     >mov al,48
     >mov bl,4
     >imul bl      ; AX = 00C0h, OF = 1
     >                     ; -  這裡C是- 前面最高位元是+
     >```
     >```MASM!
     >; 因為AH是AL的+-延伸 -> OF = 0
     >mov al,-4
     >mov bl,4
     >imul bl      ; AX = FFF0h, OF = 0
     >                     ; -  這裡F是- 前面最高位元是-
     >```
 * DIV
     >無號
     >餘數 商數
     >![](https://i.imgur.com/MgheH1T.png)
 * IDIV
     >AX必須被完全符號延伸 -> 餘數要跟被除數+-號一樣
     >```MASM!
     >; CBW CWD CDQ => 延伸+-號
     >.data
     >wordVal SWORD -101 ; FF9Bh
     >.code
     >mov ax,wordVal     ; AX = FF9Bh
     >cwd                ; DX:AX = FFFFFF9Bh
     >```
     >
 
 延伸加法&減法
 ---
 Extended Addition and Subtraction
 * ADC
     >包含進位的加法
     >```MASM
     >mov dl,0
     >mov al,0FFh
     >add al,0FFh   ; AL = FEh
     >adc dl,0      ; DL/AL = 01FEh
     >; 把CF塞進DL
     >```
 * SBB
     >包含借位的減法
     >![](https://i.imgur.com/7i8BjyM.png)
 
 ASCII&未壓縮十進制算術運算
 ---
 ASCII and Unpacked Decimal Arithmetic
 最高4個位元永遠是0
 ![](https://i.imgur.com/qqYHFJQ.png)
 * AAA
     >加法後調整ASCII
     >可以調的: ADD ADC
     >```MASM
     >mov ah,0
     >mov al,'8'      ; AX = 0038h
     >add al,'2'      ; AX = 006Ah
     >aaa             ; AX = 0100h (ASCII adjust result)
     >or ax,3030h     ; AX = 3130h = '10' (轉成ASCII)
     >```
 * AAS
     >減法後調整ASCII
     >可以調的: SUB SBB
     >減完結果是負的才需要
 * AAM
     >乘法
     >```MASM
     >.data
     >AscVal BYTE 05h,06h
     >.code
     >mov bl,ascVal        ; first operand
     >mov al,[ascVal+1]    ; second operand
     >mul bl               ; AX = 001Eh
     >aam                  ; AX = 0300h 
     >```
 * AAD
     >把0307h轉為二進位
     >才好執行DIV
     >```MASM!
     >.data
     >quotient BYTE ?
     >remainder BYTE ?
     >.code
     >mov ax,0307h          ; dividend
     >aad                   ; AX = 0025h
     >mov bl,5              ; divisor
     >div bl                ; AX = 0207h
     >mov quotient,al
     >mov remainder,ah
     >```
 
 壓縮十進制算術運算
 ---
 Packed Decimal Arithmetic
 比未壓縮的簡單
 但是沒有乘法&除法
 * DAA(+)
     >```MASM!
     >mov al,35h
     >add al,48h    ; AL = 7Dh
     >daa           ; AL = 83h (直接變成美妙的十進位)
     >```
 * DAS(-)
     >```MASM!
     >mov bl,48h
     >mov al,85h
     >sub al,bl     ; AL = 3Dh
     >das           ; AL = 37h (直接變成美妙的十進位)
     >```
     
  
  
CH8 Advanced Procedures
===
*進階程序*
> 都是指引
> 各種越來越high-level的指引(directive)
:::danger
:warning: 這章節重點考！！！
:::

 堆疊框
 ---
 Stack Frames
 (Activation record)
 * push 進 stack
     >**根據值**
     >![](https://i.imgur.com/CEwY8dW.png)
     >
     >---
     >**根據reference**
     >一堆OFFSET
     >![](https://i.imgur.com/VsJLYyV.png)
     >傳遞array用reference比較快
:::info
:bulb:引數(argument)是倒著push進stack的
:::
* 開場程式碼(prologue)
    ```MASM
    AddTwo PROC
    push ebp
    mov ebp,esp
    ```
    ![](https://i.imgur.com/0wMI1hq.png)
    ```
    ESP會變
    
    EBP不會變 
    EBP當位移參考基準
    ```
 * Explicit Stack Parameters(明確堆疊參數)
     明白地寫出參數所在的位移位址 like -> [ebp + 8],
     ```MASM!
     y_param EQU [ebp + 12]
    x_param EQU [ebp + 8]
    AddTwo PROC
    push ebp
    mov ebp,esp
    mov eax,y_param
    add eax,x_param
    pop ebp            ;要先pop EBP, 再 ret, 否則沒有清除到 stack
    ret
    AddTwo ENDP
     ```
 * 32 - bit 呼叫慣例(32-Bit Calling Conventions)
     >:warning:STDCALL
     >```MASM
     >AddTwo PROC
     >push ebp
     >mov ebp,esp          ; base of stack frame
     >mov eax,[ebp + 12]   ; second parameter
     >add eax,[ebp + 8]    ; first parameter
     >pop ebp
     >ret 8                ; 清除stack , 8 是指process耗掉的space
     >AddTwo ENDP
     >```
 * 區域變數
     >通常在EBP下面
     >![](https://i.imgur.com/BsQttCT.png)
     >```MASM
     >MySub PROC
     >push ebp
     >mov ebp,esp
     >sub esp,8                     ; 建立區域變數
     >mov DWORD PTR [ebp-4],10      ; X
     >mov DWORD PTR [ebp-8],20      ; Y
     >mov esp,ebp                   ; 從stack移除區域變數,讓ESP回去EBP紀錄那
     >pop ebp
     >ret
     >MySub ENDP
     >```
 * LEA
     >回傳間接運算元的位移
     >```MASM
     >makeArray PROC
     >push ebp
     >mov ebp,esp
     >sub esp,32                  ; 30個byte, 但要對齊
     >lea esi,[ebp–30]            ; load address of myString
     >mov ecx,30 ; loop counter
     >L1: mov BYTE PTR [esi],'*'  
     >inc esi 
     >loop L1 
     >add esp,32                  ; 移除array, 恢復ESP
     >pop ebp
     >ret
     >makeArray ENDP
     >```
     >這裡不要用OFFSET

 * ENTER
    ```MASM
    MySub PROC
    push ebp
    mov ebp,esp
    sub esp,8
    ```
    ![](https://i.imgur.com/vHgePMX.png)

* LEAVE
    ```MASM
    mov esp,ebp
    pop ebp
     ret
    ```
* LOCAL
    >可以一次宣告多個區域變數
    >會自己分好指定要的記憶體大小
    >Example1示意圖:
    ![](https://i.imgur.com/X0KAAeV.png)

    ```MASM
    Example1 PROC
    LOCAL temp:DWORD
    mov eax,temp
    ret
    Example1 ENDP
    ; 下面這坨是 LOCAL temp: DWORD
    push ebp 
    mov ebp,esp 
    add esp,0FFFFFFFCh ; add -4 to ESP
    mov eax,[ebp-4]
    leave
    ret
    ```
 遞迴
 ---
 Recursion
* 階乘
    >去mov eax, [ebp+8] 找 n
    ![](https://i.imgur.com/8lGcjvk.png) 
    全部打開長這樣![](https://i.imgur.com/22o4Hrc.png)
    
    
 INVOKE,ADDR,PROC,PROTO
 ---
 這些directive幾乎有high-level language的便利
* INVOKE
    >將argumant push 進 stack
    >可以用任意個引數(arguments)
    ```
    用法:
    (避免覆寫EAX,EDX,用32-bit)
    INVOKE DumpArray,   ; displays an array
    OFFSET array,       ; points to the array
    LENGTHOF array,     ; the array length
    TYPE array          ; array component size
    ```
    ---
* ADDR
    >傳遞指標引數
    >必須跟INVOKE一起
    ```MASM
    .data
    Array DWORD 20 DUP(?)
    .code
    ...
    INVOKE Swap, 
    ADDR Array,
    ADDR [Array+4]
    ```
    組譯後長這樣:
    ```MASM
    push OFFSET Array+4
    push OFFSET Array
    call Swap
    ```
    ---
* PROC
    ```MASM
    AddTwo PROC,
    val1:DWORD,
    val2:DWORD
    mov eax,val1
    add eax,val2
    ret
    AddTwo ENDP
    ```
    來喔組譯了
    ```MASM
    AddTwo PROC
    push ebp
    mov ebp, esp
    mov eax,dword ptr [ebp+8] 
    add eax,dword ptr [ebp+0Ch] 
    leave
    ret 8
    AddTwo ENDP
    ```
    先定義好,並且生出
    push ebp
    mov ebp, esp
    ```
    因為每個參數都是DWORD:
    所以ret (n*4)
    
    push ebp
    mov ebp,esp
    .
    leave
    ret (n*4)
    ```
* PROTO
    指出程式外部的process
    :bulb:像是先宣告我等等要用這個function的意思
    >PROTO -> INVOKE -> PROC
    >PROC在INVOKE前的話也可以不要PROTO
* 來一個完整code範例
```MASM
ArraySum PROC USES esi ecx,  ; PROC是自己的PROTO
ptrArray:PTR DWORD,          ; 省掉EBP ESP 那坨
szArray:DWORD 
mov esi,ptrArray 
mov ecx,szArray 
mov eax,0 
cmp ecx,0 
je L2 
L1: add eax,[esi] 
add esi,4 
loop L1 
L2: ret 
ArraySum ENDP

.data
array DWORD 10000h,20000h,30000h,40000h,50000h
theSum DWORD ?
.code
main PROC
INVOKE ArraySum,
 ADDR array,        ; address of the array
 LENGTHOF array     ; number of elements
mov theSum,eax      ; store the sum
```
 
 建立多模組程式
 ---
 Creating Multimodule Programs
>將程式分割成多個modules
>2種方法
* EXTERN
    ```MASM
    ;插播一下:
    OPTION PROC : PRIVATE ;設定私用,封裝(encapsulation)
    
    main PROC PUBLIC      ;阿main一定要PUBLIC
    ```
    ```MASM
    INCLUDE Irvine32.inc
    EXTERN sub1@0:PROC   ; 這個 @0 是被宣告的傢伙用掉的總stack空間
    .code
    main PROC
    call sub1@0
    exit
    main ENDP
    END main
    ```
* INVOKE & PROTO
    比對INVOKE傳遞的list & PROC宣告的參數list
    這裡就展示了一堆modules -> 我懶得全貼了
 
 
 (選讀)
 ---
 * Advanced Use of Parameters
     * *USES:*
     >列出register名稱
     >自動產生push & pop
     ```MASM
     MySub2 PROC USES ecx edx
    push ebp
    mov ebp,esp 
    mov eax,[ebp+8] 
    pop ebp 
    ret 4 
    MySub2 ENDP
     ```
     變這樣:多塞了2個傢伙 -> ecx edx
     ![](https://i.imgur.com/GaKF83j.png)

     ```MASM
     push ecx
    push edx
    push ebp
    mov ebp,esp
    mov eax,dword ptr [ebp+8]   ; [ebp+8]是錯的, [ebp+16]才對
    pop ebp
    pop edx
    pop ecx
    ret 4
     ```
    * 傳8-bit & 16-bit
    要在進stack前先擴展成32-bit
    `movzx
    ```MASM
    .data
    word1 WORD 1234h
    word2 WORD 4111h
    .code
    movzx eax,word1       ; 藉由eax轉32-bit
    push eax
    movzx eax,word2
    push eax
    call AddTwo           ; sum is in EAX
    ```
     
 * Java Bytecodes(skip)
 