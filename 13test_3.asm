assume cs:code

code segment
start:
;============================================================================
mov ax,cs
mov ds,ax
mov si,offset loop_replace

mov ax,0000H
mov es,ax
mov di,0200H

mov cx,offset loop_replace_end -offset loop_replace
cld
rep movsb

mov ax,0
mov es,ax
mov word ptr es:[7cH*4],0200H
mov word ptr es:[7cH*4+2],0000H

mov ax,4c00h
int 21h
;============================================================================
loop_replace:

push bp
mov bp,sp
dec cx
jcxz ok
add [bp+2],bx

ok:
pop bp
iret

loop_replace_end:nop
;============================================================================
code ends
end start