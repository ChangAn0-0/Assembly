assume cs:code

data segment
db 16 dup (0)
data ends

stack segment
db 128 dup (0)
stack ends

code segment
start:
mov ax,stack
mov ss,ax
mov sp,128

mov ax,12666
mov bx,data
mov ds,bx
mov si,0
call dtoc

mov ax,4c00H
int 21h

dtoc:
mov bp,sp
push ax
mov ax,10
push ax
mov ax,[bp-2]

s:
mov dx,0
div word ptr [bp-4]
add dx,30H
mov cx,ax
push dx
jcxz ok
jmp short s

ok:
mov ax,[bp-2]

s0:
mov dx,0
div word ptr [bp-4]
mov cx,ax
pop dx
mov [si],dx
add si,2
jcxz ok1
jmp short s0

ok1:
pop ax 
pop ax
ret

code ends
end start