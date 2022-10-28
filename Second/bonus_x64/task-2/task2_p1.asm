section .text
	global cmmmc

;; int cmmmc(int a, int b)
;
;; calculate least common multiple fow 2 numbers, a and b

cmmmc:
	add   esp, 0x4
	pop   eax         ; extrag valoarea a
	pop   ecx         ; extrag valoarea b
	sub   esp, 0xc    ; restaurez pointer-ul stivei
	push  ecx         ; pun b în stivă
	push  eax         ; pun a în stivă
	
CMMDC:
	push  ecx
	xor   edx, edx    ; edx va fi rezultatul lui a % b
	div   ecx
	push  edx       
	pop   ecx         ; b va lua locul lui edx în stivă, devenind a % b
	pop   eax         ; a va lua valoarea b-ului inițial, înainte sa fie schimbat
	cmp   ecx, DWORD 0 
	ja    CMMDC

CALCULARE_CMMMC_CMMDC:
	pop   edx         ; a devine edx
	pop   ecx         ; b devine ecx
	push  eax         ; pun eax-ul (care este cmmdc-ul) în stivă
	push  edx
	pop   eax         ; eax devine a
	imul  ecx        ; eax va lua valuarea a * b
	pop   ecx         ; ecx devine cmmdc-ul
	div   ecx         ; eax devine cmmmc-ul
	ret