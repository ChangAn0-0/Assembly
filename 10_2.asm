assume cs:code
stack segment
db 16 dup (0)
stack ends

code segment
start:
mov ax,stack
mov ss,ax
mov sp,16

mov ax,4240H
mov dx,000FH
mov cx,0AH
call divdw

mov ax,4c00h
int 21h

divdw:
mov bp,sp
push bx
push dx
push ax
push cx
mov dx,0
mov ax,[bp-4]
div word ptr [bp-8]
push ax
mov ax,[bp-6]
div word ptr [bp-8]
mov cx,dx
pop dx
pop bx
pop bx
pop bx
pop bx
ret

code ends
end start