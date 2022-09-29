assume cs:code,ss:stack,ds:datasg

stack segment
dw 0,0,0,0,0,0,0,0
stack ends

datasg segment
db '1. display      '
db '2. brows        '
db '3. replace      '
db '4. modify       '
datasg ends

code segment
start:mov ax,datasg
mov ds,ax
mov ax,stack
mov ss,ax
mov sp,16

mov bx,0
mov cx,4

s:push cx
mov cx,4
mov si,3

s0:mov al,[bx][si]
and al,11011111b
mov [bx][si],al
inc si
loop s0

add bx,16
pop cx
loop s

mov ax,4c00h
int 21h

code ends
end start