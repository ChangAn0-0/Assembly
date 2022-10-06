assume cs:code

stack segment
db 128 dup (0)
stack ends

code segment
start:
;========================================================
mov ax,stack
mov ss,ax
mov sp,128

mov ax,0000H
mov es,ax
mov di,0204h

mov ax,cs
mov ds,ax
mov si,offset program

mov cx,offset program_end -offset program
cld
rep movsb

mov ax,0
mov es,ax

push es:[9*4]
pop es:[200h]
push es:[9*4+2]
pop es:[202h]

cli
mov word ptr es:[9*4],204h
mov word ptr es:[9*4+2],0
sti

mov ax,4c00h
int 21h
;========================================================
program:
push ax
push bx
push cx
push es

in al,60H

pushf 
call word ptr cs:[200]

cmp al,3bh
jne program_ret


mov ax,0b800h
mov es,ax
mov bx,1
mov cx,2000
s:
inc byte ptr es:[bx]
add bx,2
loop s

program_ret:
pop es
pop cx
pop bx
pop ax
iret
`
program_end:nop
;========================================================
code ends
end start