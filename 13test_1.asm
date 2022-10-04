assume cs:code

code segment
start:
;============================================================================
mov ax,cs
mov ds,ax
mov si,offset show_str

mov ax,0000H
mov es,ax
mov di,0200H

mov cx,offset show_str_end -offset show_str
cld
rep movsb

mov ax,0
mov es,ax
mov word ptr es:[7cH*4],0200H
mov word ptr es:[7cH*4+2],0000H

mov ax,4c00h
int 21h
;============================================================================
show_str:
push ax
push cx
push dx
push ds
push es
push si
push di


mov ax,0B800h
mov es,ax
mov ax,0
mov al,160
mul dh
mov di,ax

mov ax,0
mov al,2
mul dl
add di,ax

mov ah,cl
mov cx,0
s0:
mov al,[si]
mov cl,al
mov word ptr es:[di],ax
inc di
inc di
inc si
jcxz ok
jmp short s0

ok:
pop di
pop si
pop es
pop ds
pop dx
pop cx
pop ax

iret
show_str_end:nop
;============================================================================
code ends
end start