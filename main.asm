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
    push dword WindowName
    push dword 400
    push dword 400
    push dword cursor
    push dword icon
    push dword STYLE_DEFAULT

    call create_window

    push dword func
    call window_main

    ret 