global _main

%include "window.asm"

section .text
    WindowName db "Window", 0

    icon dd   "test.ico", 0
    cursor dd "cursor.cur", 0


section .text
func:
    ret

_main:
    push dword WindowName     ;    title
    push dword 400            ;    width
    push dword 400            ;    height
    push dword cursor         ;    cursor path (0 for default)
    push dword icon           ;    icon path
    push dword STYLE_DEFAULT  ;    style options, can also use the win32 styles directly

    call create_window

    push dword func
    call window_main

    ret 