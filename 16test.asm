assume cs:code

code segment
start:
;============================================================
mov ax,0
mov es,ax
mov di,200H

mov ax,cs
mov ds,ax
mov si,offset program

mov cx,offset program_end -offset program
cld
rep movsb

mov word ptr es:[7*4],200h
mov word ptr es:[7*4+2],0

mov ax,4c00h
int 21h
;===========================================================
program:
jmp short func

table dw func_1,func_2,func_3,func_4

func:
push bx

cmp ah,3
ja func_ret
mov bl,ah
mov bh,0
add bx,bx
call word ptr table[bx]

func_ret:
pop bx
iret
;===========================================================
func_1:
push ax
push cx
push es
push di

mov ax,0b800h
mov es,ax
mov di,0
mov cx,2000

func_1_s:
mov byte ptr es:[di],' '
add di,2
loop func_1_s

pop di
pop es
pop cx
pop ax

ret
;===========================================================
func_2:
push bx
push cx
push es
push di

mov bx,0b800h
mov es,bx
mov di,1
mov cx,2000

func_2_s:
and byte ptr es:[di],11111000b
or byte ptr es:[di],al
add di,2
loop func_2_s

pop di
pop es
pop cx
pop bx

ret
;===========================================================
func_3:
push bx
push cx
push es
push di

mov bx,0b800h
mov es,bx
mov di,1
mov cl,4
shl al,cl
mov cx,2000

func_3_s:
and byte ptr es:[di],10001111b
or byte ptr es:[di],al
add di,2
loop func_3_s

pop di
pop es
pop cx
pop bx

ret
;===========================================================
func_4:
push bx
push cx
push ds
push es
push di
push si

mov bx,0b800h
mov es,bx
mov ds,bx
mov di,0
mov si,160
cld
mov cx,24

func_4_s:
push cx
mov cx,160
rep movsb
pop cx
loop func_4_s

mov cx,80
mov si,0
func_4_s1:
mov byte ptr [160*24+si],' '
add si,2
loop func_4_s1

pop si
pop di
pop es
pop ds
pop cx
pop bx
ret
;===========================================================
program_end:nop
;===========================================================
code ends
end start