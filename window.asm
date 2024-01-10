%include "base.asm"

section .text
    WindowClassName db "Class Name", 0

    ErrorTitle db "error:",0
    error_register_class	db "Register class error",0
	error_create_window 	db "Create window error",0

section .bss
    hInstance resb 4
    CommandLine resb 4

    WindowClassEx resb 40
    MessageStruct resb 7*4

    WindowHandle resb 4
    PaintStruct resb 64

    BackGroundColor resb 4

    HDC resb 4


section .text
fill_screen:
    mov esi, eax

    mov edi, 0 ; x-coordinate

L5:
    mov edx, 0 ; reset y-coordinate at the start of each row
L4:
    push dword edx
    push dword edi
    push dword esi

    ; Call SetPixel
    push 0xFF00FFFF
    push dword edx
    push dword edi
    push dword esi
    call SetPixel

    mov esi, dword [esp]   
    add esp, 4              

    mov edi, dword [esp]  
    add esp, 4              

    mov edx, dword [esp]  
    add esp, 4              


    inc edx 
    cmp edx, 200 ; check if y-coordinate reached the end of the screen
    jle L4 ; continue drawing pixels 

    inc edi ; increment x-coordinate
    cmp edi, 200 ; check if x-coordinate reached the end of the screen
    jle L5 ; continue drawing and reset y coordinate

    ret

main_message_loop:
    push dword 0
    push dword 0
    push dword 0
    push dword MessageStruct
    call GetMessage
    cmp eax, 0
    jle QuitProgram

    push dword MessageStruct
    call TranslateMessage

    push dword MessageStruct
    call DispatchMessage

    jmp main_message_loop

    QuitProgram:
        ret

window_proc:
    push ebp
    mov ebp, esp

    %define ebp_hwnd 	ebp+8
    %define ebp_message ebp+12
    %define ebp_wparam 	ebp+16
    %define ebp_lparam 	ebp+20

    ; Switch/jump table
    ;cmp [ebp_message], dword WM_PAINT
    ;je .onPaint
	cmp [ebp_message],dword WM_CLOSE
	je .onClose
	cmp [ebp_message],dword WM_DESTROY
	je .onDestroy
	cmp [ebp_message],dword WM_CREATE
	je .onCreate
    
	
    .defaultProcedure:
	    push dword [ebp_lparam]
	    push dword [ebp_wparam]
	    push dword [ebp_message]
	    push dword [ebp_hwnd]
	    call DefWindowProc
	    mov esp,ebp
	    pop ebp
	    ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes
	
    .onPaint:
        push dword PaintStruct
        push dword [ebp_hwnd]
        call BeginPaint

        mov ebx, eax

        mov esi, BackGroundColor
        add dword [esi], 0x00000001

        push dword [esi] ; ABGR
        call CreateSolidBrush

        mov esi, eax

        mov edi, PaintStruct       ; Load the address of PaintStruct
        add edi, 12                ; Move to the rcPaint member

        mov dword [edi], 0         ; Set left coordinate
        mov dword [edi + 4], 50    ; Set top coordinate 
        mov dword [edi + 8], 100   ; Set right coordinate 
        mov dword [edi + 12], 100  ; Set bottom coordinate 

        push dword esi
        push dword edi ;rcPaint
        push dword ebx ; HDC ctx
        call FillRect

        push esi
        call DeleteObject


        push dword PaintStruct
        push dword [ebp_hwnd]
        call EndPaint

        push 1
        push 0
        push dword [ebp_hwnd]
        call InvalidateRect
        
        mov esp,ebp
        pop ebp
        ret 16


    .onCreate:
	    push dword SW_SHOW
	    push dword [ebp_hwnd]
	    call ShowWindow
    
	    push dword [ebp_hwnd]
	    call UpdateWindow
    
	    mov eax,0
	    mov esp,ebp
	    pop ebp
	    ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes
	
    .onClose:
	    push dword [ebp_hwnd]
	    call DestroyWindow
	    mov eax,0
	    mov esp,ebp
	    pop ebp
	    ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes
	
    .onDestroy:
	    push dword 0
	    call PostQuitMessage
	    mov eax,0
	    mov esp,ebp
	    pop ebp
	    ret 16 ; stdcall convetion requres pop all parameters from stack 4*4 = 16 bytes

; dword msg in esi
show_error:
    push 0x00000006
    push esi
    push ErrorTitle
    push 0
    call MessageBox

    ret 

; dword Title
; dword Width
; dword Height
; dword Image Icon Path
; dword Options

%define ebp_options ebp+8
%define ebp_icon    ebp+12
%define ebp_cursor  ebp+16
%define ebp_height  ebp+20
%define ebp_width   ebp+24
%define ebp_title   ebp+28

create_window:
    push ebp
    mov ebp, esp

    push dword 0
    call GetModuleHandle
    mov [hInstance], eax

    call GetCommandLine
    mov [CommandLine], eax

    mov [WindowClassEx], dword CS_VREDRAW ;style
    mov [WindowClassEx + 4], dword window_proc ;lpfnWndProc
    mov [WindowClassEx + 8], dword 0 ;cbclsextra
    mov [WindowClassEx + 12], dword 0 ;CbWndExtra
    
    mov eax, dword [hInstance] ;WNDCLASSEX.hInstance
    mov [WindowClassEx + 16], eax

    ;hIcon
    push LR_LOADFROMFILE | LR_SHARED 
    push 0 ;size
    push 0 ; size
    push IMAGE_ICON ;type
    push dword [ebp_icon]   ;name
    push dword [hInstance] ;hInstace
    call LoadImage

    mov [WindowClassEx + 20], eax

    mov eax, dword [ebp_cursor]
    cmp eax, 0
    jne continue

    push dword [ebp_cursor]
    call LoadCursorFromFile
    mov [WindowClassEx + 24], eax
    
    jmp continue_on

    continue:
    push dword IDC_ARROW
    push dword 0
    call LoadCursor

    continue_on:

    ; background
    mov [WindowClassEx + 28], dword COLOR_WINDOW

    mov [WindowClassEx + 32], dword 0 ;MenuName
    mov [WindowClassEx + 36], dword WindowClassName ;class name

    push dword WindowClassEx
    call RegisterClass
    cmp eax, 0
    mov esi, error_register_class
    je show_error

    push dword 0 ;lpParam
    push dword 0 ;hInstance
    push dword 0 ; hMenu
    push dword 0 ;hWndParent
    push dword [ebp_width] ;height
    push dword [ebp_height] ;width
    push dword CW_USEDEFAULT ;y
    push dword CW_USEDEFAULT ;x
    push dword [ebp_options] ;style
    push dword [ebp_title]
    push dword WindowClassName
    push dword 0 ;extra style
    call CreateWindow
    mov [WindowHandle], eax
    cmp eax, 0
    mov esi, error_create_window
    je show_error
    
    
    mov esp, ebp
    pop ebp

    ret 24

;dword function pointer
window_main:
    push ebp
    mov ebp, esp

    mov ebx, [ebp + 8]
    L1:

    push dword 0
    push dword 0
    push dword 0
    push dword MessageStruct
    call GetMessage
    cmp eax, 0
    jle quit

    push dword MessageStruct
    call TranslateMessage

    push dword MessageStruct
    call DispatchMessage

    call ebx

    jmp L1

    quit:
        mov esp, ebp
        pop ebp

        ret 4
