; // CSCI 321
; // Project 8
; // Bjarni Jonsson
; // Greatest Common Divisor

TITLE Bjarni

Include Irvine32.inc

Str_leng proto,
TargStr: ptr byte

Str_find proto,
TargStr : ptr byte,
SourceStr : ptr byte

.data

buffer BYTE 21 DUP(0)
bytecount DWORD ?

target BYTE 21 DUP(0)
source BYTE 21 DUP(0)
posOffset DWORD ?
pos DWORD ?

inputSource BYTE "Enter source string (the string to search for): ", 0
inputTarget BYTE "Enter target string (the string to search from): ", 0
foundOne BYTE "Source string found at position ", 0
foundTwo BYTE " in target string (counting from zero).", 0
strNotFound byte "Not found", 0

.code
main PROC

mainCode:

mov edx, OFFSET inputSource
call WriteString
mov edx, OFFSET source
mov ecx, SIZEOF source
call ReadString
mov bytecount, eax

mov edx, OFFSET inputTarget
call WriteString
mov edx, OFFSET target
mov ecx, SIZEOF target
call ReadString
mov bytecount, eax


invoke Str_find, addr source, addr target

jz notFound


mov edx, OFFSET foundOne
call WriteString
mov eax, OFFSET pos
call WriteDec
mov edx, OFFSET foundTwo
call WriteString
call Crlf

jmp quit

notFound :
mov edx, offset strNotFound
call WriteString
call Crlf

Get_Choice :
call ReadChar
call WriteChar



quit:
exit

main ENDP

Str_leng proc uses esi eax,
TargStr: ptr byte
mov esi, TargStr
mov ecx, 0
L1 :
	mov al, [esi]
	cmp al, 0
	je L2
	inc ecx
	inc esi
	jmp L1
	L2 :
ret
Str_leng endp

Str_find proc uses esi edi edx ebx eax,
TargStr : ptr byte,
SourceStr : ptr byte
mov esi, TargStr
L5 :
mov edx, esi
mov edi, SourceStr
L8 :
mov al, [edx]
mov bl, [edi]
cmp bl, 0
je L6
cmp al, bl
jne L7
inc edx
inc edi
jmp L8
L6 :
mov posOffset, esi
mov eax, esi
test dl, 0
jmp L9
L7 :
inc esi
loop L5
L9 :
mov esi, TargStr
sub eax, esi
mov pos, eax
ret
Str_find endp



END main