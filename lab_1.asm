; 5. Найти min(B(I)), которое состоит из целых чисел. I=1,2,...,10.
.286C
.model small
.stack 100h

.data
	arrayb db 12,30,15,45,2,13,91,104,24,11
	text   db 'The min element: $'

.code

	start:    
	          mov  ax, @data
	          mov  ds, ax

	          mov  ah, 09h        	; обозначаем, что будет выводится строка
	          mov  dx, offset text	; в dx передаем строку
	          int  21h            	; прерывание на вывод
	          xor  ax, ax         	; обнуляем ax

	          mov  si, 0          	; i-ое
	          mov  al, arrayb[si] 	; присваем первый эл
	          inc  si             	; увеличение счетчика
	searchmin:
	          mov  cl, arrayb[si] 	; присваем эл[i+1]
	          cmp  cl, al         	; сравниваем первый и следующий
	          jl   min            	; jump if less
	          jmp  endmin         	; jump
	min:      
	          mov  al, arrayb[si]
endmin:
	          inc  si
	          cmp  si, 10
	          jl   searchmin

	          call PrintNum

	          mov  ax, 4c00h      	; стандартный выход
	          int  21h            	; прерывание

PrintNum proc                 		;В al число
	          push ax             	; заносим в стек
	          push cx
	          push bx

	          xor  cx, cx
	          mov  bl, 10
	DivLoop:  
	          xor  ah, ah
	          div  bl             	; /10
	          add  ah, '0'        	; делаем символ
	          push ax
	          inc  cx
	          test al, al
	          jnz  DivLoop
	PrintLoop:
	          pop  ax
	          xchg al, ah         	; меняем местами
	          int  29h            	; короткое прерывание
	          loop PrintLoop
	          pop  bx
	          pop  cx
	          pop  ax

	          ret
PrintNum endp

end start
