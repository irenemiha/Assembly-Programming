global get_words
global compare_func
global sort

section .data
    delimiters db ' .,'

section .text
    extern strtok
    extern qsort
    extern strcmp
    extern strlen
    extern strdup

COMPARARE:
    enter 0, 0

    push ebx
    push edx
    push ecx
    push esi

    mov esi, 0
    mov eax, 0
    mov ebx, [ebp + 12] ; primul cuvânt din șir
    push dword[ebx]
    call strlen         ; aflu lungimea cuvântului
    add esp, 4
    sub esi, eax        ; scad lungimile
    mov eax, 0
    mov ebx, [ebp + 8]  
    push dword[ebx]
    call strlen         
    add esp, 4
    add esi, eax        ; scad cele două lungimi
    mov ecx, esi
    mov eax, ecx
    cmp eax, 0
    jne STOP_COMPARARE
    mov edx, [ebp + 12] ; al doilea cuvânt din șir
    push dword[edx]
    push dword[ebx]     ; primul cuvânt din șir
    call strcmp
    add esp, 8

STOP_COMPARARE:
    pop esi
    pop ecx
    pop edx
    pop ebx

    leave
    ret

;; sort(char **words, int number_of_words, int size)
;  functia va trebui sa apeleze qsort pentru soratrea cuvintelor 
;  dupa lungime si apoi lexicografix

sort:
    enter 0, 0
    
    push eax

    push COMPARARE
    push dword[ebp + 16]    ; dimensiunea cuvântului
    push dword[ebp + 12]    ; numărul cuvintelor din șir
    push dword[ebp + 8]     ; vectorul de cuvinte salvate după delimitare

    call qsort              ; sortez vectorul de cuvinte
    add esp, 16

    pop eax

    leave
    ret

;; get_words(char *s, char **words, int number_of_words)
;  separa stringul s in cuvinte si salveaza cuvintele in words
;  number_of_words reprezinta numarul de cuvinte

get_words:
    enter 0, 0

    push eax
    push ecx
    push ebx
    push edx

    mov ecx, [ebp + 8]      ; primul token de spart 
    mov ebx, [ebp + 12]     ; vectorul **words
    mov edx, [ebp + 16]

    push delimiters         ; șirul de delimitatori
    push ecx
    call strtok             ; salvez primul token
    add esp, 8
    mov edx, eax
    push eax
    call strdup
    add esp, 4
    mov [ebx], eax
    dec edx

STRTOK:
    push delimiters         ; pun în stivă șirul de delimitatori
    push 0
    call strtok             ; apelul strtok cu NULL
    add esp, 8
    cmp eax, 0              ; compar token-ul rezultat cu NULL
    je EXIT
    push eax
    call strdup
    add esp, 4
    add ebx, 4
    mov [ebx], eax
    jne STRTOK

EXIT:
    pop edx
    pop ebx
    pop ecx
    pop eax

    leave
    ret