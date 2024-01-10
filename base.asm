extern _UpdateWindow@4
extern _CreateWindowExA@48
extern _ShowWindow@8
extern _GetMessageA@16
extern _TranslateMessage@4
extern _DispatchMessageA@4
extern _PostQuitMessage@4
extern _DestroyWindow@4
extern _DefWindowProcA@16
extern _RegisterClassA@4
extern _MessageBoxA@16
extern _GetModuleHandleA@4
extern _GetLastError@0
extern _GetCommandLineA@0
extern _RegisterClassW@4
extern _LoadCursorA@8
extern _LoadIconA@8
extern _BeginPaint@8
extern _EndPaint@8
extern _SetPixel@16
extern _FillRect@12
extern _CreateSolidBrush@4
extern _DeleteObject@4
extern _InvalidateRect@12
extern _LoadImageA@24
extern _LoadCursorFromFileA@4

%define UpdateWindow                _UpdateWindow@4
%define CreateWindow                _CreateWindowExA@48
%define UpdateWindow                _UpdateWindow@4
%define ShowWindow                  _ShowWindow@8
%define GetMessage                  _GetMessageA@16
%define TranslateMessage            _TranslateMessage@4
%define DispatchMessage             _DispatchMessageA@4
%define PostQuitMessage             _PostQuitMessage@4
%define DestroyWindow               _DestroyWindow@4
%define DefWindowProc               _DefWindowProcA@16
%define RegisterClass               _RegisterClassA@4
%define MessageBox                  _MessageBoxA@16
%define GetModuleHandle             _GetModuleHandleA@4
%define GetLastError                _GetLastError@0
%define GetCommandLine              _GetCommandLineA@0
%define RegisterClass               _RegisterClassA@4
%define LoadCursor                  _LoadCursorA@8
%define LoadIcon                    _LoadIconA@8
%define BeginPaint                  _BeginPaint@8
%define EndPaint                    _EndPaint@8
%define SetPixel                    _SetPixel@16
%define FillRect                    _FillRect@12
%define CreateSolidBrush            _CreateSolidBrush@4
%define DeleteObject                _DeleteObject@4
%define InvalidateRect              _InvalidateRect@12
%define LoadImage                   _LoadImageA@24
%define LoadCursorFromFile          _LoadCursorFromFileA@4


CS_VREDRAW          equ 0x0001
CS_HREDRAW          equ 0x0002
IDI_APPLICATION     equ 32512
COLOR_WINDOW        equ 5
IDC_ARROW           equ 32512
MB_OK               equ 0x00000000
MB_ICONEXCLAMATION  equ 0x00000030
SW_SHOW             equ 5
WM_CREATE           equ 0x1
WM_DESTROY          equ 0x2
WM_CLOSE            equ 0x0010
WM_SIZE             equ 0x0005
WM_PAINT            equ 0x000F
LR_DEFAULTCOLOR     equ 0x00000000
LR_MONOCHROME       equ 0x00000001
LR_COLOR            equ 0x00000002
LR_COPYRETURNORG    equ 0x00000004
LR_COPYDELETEORG    equ 0x00000008
LR_LOADFROMFILE     equ 0x00000010
LR_LOADTRANSPARENT  equ 0x00000020
LR_DEFAULTSIZE      equ 0x00000040
LR_VGACOLOR         equ 0x00000080
LR_LOADMAP3DCOLORS  equ 0x00001000
LR_CREATEDIBSECTION equ 0x00002000
LR_COPYFROMRESOURCE equ 0x00004000
LR_SHARED           equ 0x00008000
IMAGE_ICON          equ 1
IMAGE_BITMAP        equ 0
WS_OVERLAPPED       equ 0x00000000
WS_POPUP            equ 0x80000000
WS_CHILD            equ 0x40000000
WS_MINIMIZE         equ 0x20000000
WS_VISIBLE          equ 0x10000000
WS_DISABLED         equ 0x08000000
WS_CLIPSIBLINGS     equ 0x04000000
WS_CLIPCHILDREN     equ 0x02000000
WS_MAXIMIZE         equ 0x01000000
WS_CAPTION          equ 0x00C00000    
WS_BORDER           equ 0x00800000
WS_DLGFRAME         equ 0x00400000
WS_VSCROLL          equ 0x00200000
WS_HSCROLL          equ 0x00100000
WS_SYSMENU          equ 0x00080000
WS_THICKFRAME       equ 0x00040000
WS_GROUP            equ 0x00020000
WS_TABSTOP          equ 0x00010000
WS_MINIMIZEBOX      equ 0x00020000
WS_MAXIMIZEBOX      equ 0x00010000
WS_TILED            equ WS_OVERLAPPED
WS_ICONIC           equ WS_MINIMIZE
WS_SIZEBOX          equ WS_THICKFRAME
WS_OVERLAPPEDWINDOW equ WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX
CW_USEDEFAULT       equ 0x80000000

STYLE_DEFAULT       equ WS_OVERLAPPEDWINDOW
STYLE_EXTRA         equ WS_OVERLAPPEDWINDOW | WS_VSCROLL  | WS_HSCROLL | WS_BORDER