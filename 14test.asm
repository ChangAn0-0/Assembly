assume cs:code

code segment
data1: db 9,8,7,4,2,0
data2: db '00/00/00 00:00:00','$'

start:
;============================================================================
mov ax,cs
mov ds,ax
mov si,offset data1
mov di,offset data2

mov cx,6
loop_1:
push cx

mov al,[si]
out 70h,al
in al,71h

mov ah,al
mov cl,4
shr ah,cl
and al,00001111B

add ah,30h
add al,30h

mov ds:[di],ah
mov ds:[di+1],al

add di,3
inc si

pop cx
loop loop_1
;============================================================================
mov bh,0
mov dh,5
mov dl,12
mov ah,2
int 10H

mov ax,cs
mov ds,ax
mov dx,offset data2
mov ah,9
int 21h
;============================================================================
mov ax,4c00h
int 21h
code ends
end start