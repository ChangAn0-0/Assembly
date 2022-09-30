assume cs:code

data segment
db "Beginner's All-purpose Symbolic Instruction Code.",0
data ends

code segment
begin:
mov ax,data
mov ds,ax
mov si,0
mov cx,0
call letterc

mov ax,4c00H
int 21h
;===================================================================
letterc:
s:
mov cl,ds:[si]
cmp cl,61H
jb s1
cmp cl,7aH
ja s1
and cl,11011111B
mov ds:[si],cl
s1:
inc si
jcxz ok
jmp s

ok:ret
;====================================================================
code ends
end begin


