assume cs:code
data segment
db 'welcome to masm!',0
data ends

code segment
start:
mov dh,8
mov dl,3
mov cl,2
mov ax,data
mov ds,ax
mov si,0

call show_str

mov ax,4c00h
int 21h
;==============================================
show_str:
mov ax,0B800H
mov es,ax
mov ax,0
mov al,160
mov bx,0
mul dh
mov bx,ax
mov ax,0
mov al,2
mul dl
add bx,ax
mov ax,0
mov ah,cl

s:
mov ch,0
mov cl,[si]
jcxz ok
inc si
mov al,cl
mov es:[bx],ax
add bx,2
jmp short s
ok:ret

code ends
end start
