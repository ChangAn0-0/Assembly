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

showdata segment
db 16 dup (0)
showdata ends

stack segment
db 128 dup (0)
stack ends

codesg segment
start:
mov ax,stack
mov ss,ax
mov sp,128

call MoveAndSort
call clear_screen
call show_year
call show_income
call show_number_of_people
call show_average_salary


;=======================================================================================
mov ax,4c00h
int 21h
;========================================================================================
clear_screen:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

mov ax,0B800H
mov ds,ax
mov bx,0
mov cx,80*25

clear_screen_s:
mov word ptr ds:[bx],0
add bx,2
loop clear_screen_s

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax

ret
;========================================================================================
;MoveAndSort函数，将data段的值转移至table段并排列
MoveAndSort:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

mov ax,data
mov ds,ax
mov ax,table
mov es,ax

mov bx,0
mov si,84
mov di,168
mov bp,0

mov cx,21

MoveAndSortS:
push ds:[bx]
pop es:[bp]
push ds:[bx+2]
pop es:[bp+2]

mov ax,ds:[si]
mov dx,ds:[si+2]
mov es:[bp+5],ax
mov es:[bp+7],dx

push ds:[di]
pop es:[bp+10]

div word ptr [di]
mov es:[bp+0DH],ax

add bx,4
add si,4
add di,2
add bp,16
loop MoveAndSortS

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax

ret
;=========================================================================================
move_year:
push ax
push bx 
push cx
push dx
push ds
push es
push si


mov cx,2
s1:
mov ax,[si]
mov word ptr es:[di],ax
add si,2
add di,2
loop s1


pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;=========================================================================================
show_year:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di


mov ax,table
mov ds,ax
mov si,0

mov ax,showdata
mov es,ax
mov di,0

mov dh,1
mov dl,1
mov cx,21
moveyear:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

call move_year

mov cl,2
mov ax,showdata
mov ds,ax
mov si,0
call show_str

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
add si,16
inc dh
loop moveyear



pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;===========================================================================================
show_income:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

mov ax,table
mov ds,ax
mov si,5

mov ax,showdata
mov es,ax
mov di,0

mov dh,1
mov dl,10
mov cx,21
show_income_s:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

call move_income

mov cl,2
mov ax,showdata
mov ds,ax
mov si,0
call show_str

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax


add si,16
inc dh
loop show_income_s



pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;===========================================================================================
move_income:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

push ds
push si
mov ax,showdata
mov ds,ax
mov si,0

mov cx,16
clear_data_income:
mov byte ptr [si],0
inc si
loop clear_data_income
pop si
pop ds

mov ax,[si]
mov dx,[si+2]
move_income_s:
mov cx,10
call long_div
add cx,30H
push cx
mov cx,ax
inc bx
jcxz move_income_s1 
jmp move_income_s

move_income_s1:
mov cx,bx
move_income_s2:
pop bx
mov byte ptr es:[di],bl
inc di
loop move_income_s2

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;===========================================================================================
long_div:
mov bp,sp
push bx
push dx
push ax
push cx
mov dx,0
mov ax,[bp-4]
div word ptr [bp-8]
push ax
mov ax,[bp-6]
div word ptr [bp-8]
mov cx,dx
pop dx
pop bx
pop bx
pop bx
pop bx
ret
;===========================================================================================
show_number_of_people:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

mov ax,table
mov ds,ax
mov si,10

mov ax,showdata
mov es,ax
mov di,0

mov dh,1
mov dl,25
mov cx,21
show_number_of_people_s:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

call move_number_of_people

mov cl,2
mov ax,showdata
mov ds,ax
mov si,0
call show_str

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax


add si,16
inc dh
loop show_number_of_people_s



pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;===========================================================================================
move_number_of_people:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

push ds
push si
mov ax,showdata
mov ds,ax
mov si,0

mov cx,16
clear_data_number_of_people:
mov byte ptr [si],0
inc si
loop clear_data_number_of_people
pop si
pop ds

mov ax,[si]

move_number_of_people_s:
mov dx,0
mov cx,10
div cx
add dx,30H
push dx
mov cx,ax
inc bx
jcxz move_number_of_people_s1 
jmp move_number_of_people_s

move_number_of_people_s1:
mov cx,bx
move_number_of_people_s2:
pop bx
mov byte ptr es:[di],bl
inc di
loop move_number_of_people_s2

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;===========================================================================================
;===========================================================================================
show_average_salary:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

mov ax,table
mov ds,ax
mov si,13

mov ax,showdata
mov es,ax
mov di,0

mov dh,1
mov dl,35
mov cx,21
show_average_salary_s:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

call move_average_salary

mov cl,2
mov ax,showdata
mov ds,ax
mov si,0
call show_str

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax


add si,16
inc dh
loop show_average_salary_s



pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;===========================================================================================
move_average_salary:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

push ds
push si
mov ax,showdata
mov ds,ax
mov si,0

mov cx,16
clear_data_average_salary:
mov byte ptr [si],0
inc si
loop clear_data_average_salary
pop si
pop ds

mov ax,[si]

move_average_salary_s:
mov dx,0
mov cx,10
div cx
add dx,30H
push dx
mov cx,ax
inc bx
jcxz move_average_salary_s1 
jmp move_average_salary_s

move_average_salary_s1:
mov cx,bx
move_average_salary_s2:
pop bx
mov byte ptr es:[di],bl
inc di
loop move_average_salary_s2

pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;==================================================================================
show_str:
push ax
push bx 
push cx
push dx
push ds
push es
push si
push di

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

s12:
mov ch,0
mov cl,[si]
jcxz ok
inc si
mov al,cl
mov es:[bx],ax
add bx,2
jmp short s12
ok:
pop di
pop si
pop es
pop ds
pop dx
pop cx
pop bx
pop ax
ret
;=============================================================================================
codesg ends 
end start