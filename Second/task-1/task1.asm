section .text
	global sort

; struct node {
;     	int val;
;    	struct node* next;
; };

;; struct node* sort(int n, struct node* node);
; 	The function will link the nodes in the array
;	in ascending order and will return the address
;	of the new found head of the list

; @params:
;	n -> the number of nodes in the array
;	node -> a pointer to the beginning in the array

; @returns:
;	the address of the head of the sorted list

sort:
	enter 0x0, 0x0

	push ebx					; [epb - 4]
	mov ecx, 0x0				; contor inițial 0 pentru lista de noduri
	mov eax, [ebp + 0xc]		; primul nod din listă
	mov edx, 0x1				; contor care ia valorile consecutive ale secvenței {1, 2 ... n}

CAUTARE_1:
	cmp dword[eax], edx 
	je GASIT_1					; dacă primul element este egal cu primul număr din secvență (adică 1)
	add eax, 0x8				; trec la următorul element
	inc ecx						; incrementez contorul
	cmp ecx, dword[ebp + 0x8] 
	jl CAUTARE_1				; dacă n-am ajuns la capătul listei, continui cautarea din bucla for

GASIT_1:
	push eax
	mov ebx, eax				; salvez elementul găsit în ebx			
	mov ecx, 0x0
	inc ecx						; trec la următorul element cu contorul, pentru a căuta următorul element cel mai mic

PARCURGERE_SECVENTA:	
	mov eax, dword[ebp + 0xc] 	; reinițializez eax cu primul nod din șir
	inc edx 					; edx devine următorul număr din secvență

CAUTAREA_CONTINUA:
	cmp dword[eax], edx 		; compar elementul curent din șir cu valoarea curentă a lui edx
	je RESTUL_GASITE
	add eax, 0x8 				; trec la următorul element
	jmp CAUTAREA_CONTINUA

RESTUL_GASITE:
	mov [ebx + 0x4], eax 		; returnez elementul curent
	mov ebx, eax 				; salvez elementul curent în ebx

SKIP:
	inc ecx 					; incrementez contorul șirului
	cmp ecx, dword[ebp + 0x8]
	jl PARCURGERE_SECVENTA 		; continui să parcurg secvența dacă nu am ajuns la finalul șirului

	pop eax
	pop ebx

	leave
	ret