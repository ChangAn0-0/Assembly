assume cs:code
code segment
start:
mov al,8
out 70H,al
in al,71h

mov ah,al
mov cl,4
shr ah,cl
and al,00001111B

add ah,30h
add al,30h

mov bx,0B800h
mov es,bx
mov byte ptr es:[160*12+40*2],ah
mov byte ptr es:[160*12+40*2+2],al

mov ax,4c00h
int 21h

code ends
end start
