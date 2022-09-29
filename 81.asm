assume cs:codesg

data segment
db '1975','1976','1977','1978','1979','1980','1981','1982','1983'
db '1984','1985','1986','1987','1988','1989','1990','1991','1992'
db '1993','1994','1995'

dd 16,22,382,1356,2390,8000,16000,24486,50065,97479,140417,197514
dd 345980,590827,803530,1183000,1843000,2759000,3753000,4649000,5937000

dw 3,7,9,13,28,38,130,220,476,778,1001,1442,2258,2793,4037,5635,8226
dw 11542,14430,15257,17800
data ends

table segment
db 21 dup ('year summ ne ?? ')
table ends

stack segment
db 128 dup (0)
stack ends

codesg segment
start:
mov ax,stack
mov ss,ax
mov sp,128

mov ax,data
mov ds,ax
mov ax,table
mov es,table

mov bx,0
mov si,84
mov di,168
mov bp,0

mov cx,21
s:
push ds:[bx]
pop es:[bp]
push ds:[bx+2]
pop es:[bp+2]

mov ax,ds:[si]
mov da,ds:[si+2]
mov es:[bp+5],ax
mov es:[bp+7],dx

push ds:[di]
pop es:[bp+10]

div dword ptr [di]
mov es,[bp+0DH],ax

add bx,4
add si,4
add di,2
add bp,16
loop s

mov ax,4c00h
int 21h
codesg ends
end start



