assume cs:code

data segment
db 'welcome to masm!'
db 01110010B
db 00100100B
db 01110001B
data ends

stack segment
db 128 dup (0)
stack ends

code segment
start:
mov ax,stack
mov ss,ax
mov sp,128

mov ax,0B800H
mov ds,ax
mov ax,data
mov es,ax
mov si,16

mov bx,12*160
add bx,32*2

mov cx,3

s0:
mov ax,0
mov ah,es:[si]
push cx
mov bp,0

mov cx,16
s:
mov al,es:[bp]
mov [bx],ax
inc bp
add bx,2
loop s

sub bx,16*2
inc si
add bx,160
pop cx
loop s0


mov ax,4c00H
int 21h

code ends
end start


