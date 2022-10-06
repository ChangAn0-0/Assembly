assume cs:code

stack segment
db 128 dup (0)
stack ends

code segment
start:
;=========================================================
mov ax,0
mov es,ax
mov si,204H

push cs
pop ds
mov di,offset program

mov cx,offset program -offset program_end
cld
rep movsb

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
;=========================================================
program:
push ax
push cx
push es
push si

in al,60h

pushf
call word ptr cs:[200h]

cmp al,9eH
jne program_ret

mov ax,0b800h
mov es,ax
mov si,0

mov cx,2000
s:
mov byte ptr es:[si],'A'
add si,2
loop s

program_ret:
pop si
pop es
pop cx
pop ax

iret

program_end:nop
;=========================================================
code ends
end start