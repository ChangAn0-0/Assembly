assume cs:code

code segment
start:
mov ax,0000H
mov es,ax
mov di,0200h

mov ax,cs
mov ds,ax
mov si,offset square

cld
mov cx,offset square_end -offset square
rep movsb

mov ax,0
mov es,ax
mov word ptr es:[4*124],0200H
mov word ptr es:[4*124+2],0000H

mov ax,4x00h
int 21h

square:
mul ax
iret

square_end:nop

code ends
end start