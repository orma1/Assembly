
MODEL small
STACK 100h
DATA SEGMENT
array db 8 dup(?)
num_of_elements dw 8

; --------------------------
; Your variables here
; --------------------------
DATA ENDS
CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
print_array proc
	mov dl,10 ;to go to a lower line
	mov ah,2
	int 21h
	mov dl,13 ;to go back to the start of the line
	mov ah,2
	int 21h
	mov bp, sp
	mov cx, [bp + 4] ;put array length in cx
	dec cx
	mov bx, [bp + 2] ;put array address in bx
print_loop:
	mov dl,[bx]
	mov ah,2
	int 21h
	inc bx
	mov dl,',' ; to print ,
	mov ah,2
	int 21h
	loop print_loop
	mov dl,[bx] ;to print the last number
	mov ah,2
	int 21h
	ret 4
print_array endp

bubblesort proc
	mov bp, sp
	mov cx, [bp + 4] ;put array length in cx
	dec cx
	mov bx, [bp + 2] ;put array address in bx
sort_loop:
	mov al, [bx] ;put value in ax from arr
	inc bx
	cmp al, [bx] ;compare value from arr with the next one 
	jb sorted ; if the first one is smaller don't change the order
	xchg al, [bx] ;if the first one is bigger, switch them
	mov [bx - 1], al
sorted:
	cmp bx, cx  ;first loop
	jne sort_loop
	mov bx, [bp + 2] ;array address in bx
	loop sort_loop ;second loop
	ret 4
bubblesort endp
start:
	mov ax, DATA
	mov ds, ax
	mov cx, 8
	mov si, offset array
input_loop:
	mov ah, 1 ;to get a character
	int 21h
	mov [bx], al ;insert the character to the corresponding loaction
	inc bx
	loop input_loop
	
	push num_of_elements ;push the length of the array to the stack
	push offset array ;push the address of the array to the stack
	call bubblesort
	
	push num_of_elements ;push the length of the array to the stack
	push offset array ;push the address of the array to the stack
	call print_array
	
; --------------------------
; Your code here
; --------------------------
exit:
	mov ax, 4c00h
	int 21h
CODE ENDS
END start


