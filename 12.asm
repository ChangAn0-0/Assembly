assume cs:code

code segment
start:
mov ax,0000h
mov es,ax
mov di,0200h

mov ax,cs
mov ds,ax
mov si,offset do0

cld
mov cx,offset do0end -offset do0
rep movsb

mov ax,0
mov es,ax
mov word ptr es:[4*0],200h
mov word ptr es:[4*0+2],0

mov ax,4c00h
int 21h
;=====================================================================
do0:
jmp short do0start

db "divide error!"

do0start:
mov ax,0b800h
mov es,ax
mov di,160*12+36*2

mov ax,cs
mov ds,ax
mov si,0202H

mov ah,2
mov cx,13
s12:
mov al,[si]
mov es:[di],al
inc si
add di,2
loop s12

mov ax,4c00h
int 21h

do0end:nop
;==========================================================================
code ends
end start