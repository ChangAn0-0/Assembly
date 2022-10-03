assume cs:code

data segment
db 'conversation',0
data ends

code segment
start:
mov ax,data
mov ds,ax
mov si,0

int 7ch

mov ax,4c00h
int 21h
;===============================================================================
;°²×°³ÌÐò
assume cs:code
code segment
start:
mov ax,cs
mov ds,ax
mov si,offset upper

mov ax,0000H
mov es,ax
mov di,0200H

mov cx,offset change_end- offset change
cld
rep movsb

mov ax,0
mov es,ax
mov word ptr [4*7ch],0200h
mov word ptr [4*7ch+2],0000H

mov ax,4c00h
int 21h
;===============================================================================
change:
push cx
push si

upper:
mov ch,0
mov cl,[si]
jcxz ok
and byte ptr [si],11011111B
inc si
jmp short upper

ok:
push si
pop cx
iret

change_end
;================================================================================
code ends
end start
