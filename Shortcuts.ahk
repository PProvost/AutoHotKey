#SingleInstance force

;----------------------------------------------------------------
; WIN+SHIFT+V opens Ventrilo
;------------------------------------------------------------------------
#+v::Run C:\Program Files\Ventrilo\Ventrilo.exe

;----------------------------------------------------------------
; WIN+W opens WoW
;------------------------------------------------------------------------
#w::Run C:\World of Warcraft\Launcher.exe

;----------------------------------------------------------------
; Ctrl+Alt+S: screensaver launcher
;------------------------------------------------------------------------
^!s::
   PostMessage 0x0112, 0xF140, 0,, Program Manager ; 0x0112 is WM_SYSCOMMAND -- 0xF140 is SC_SCREENSAVE
return

;------------------------------------------------------------------------
; Ctrl+Alt+Space - Always on top current window
;------------------------------------------------------------------------
^!SPACE:: Winset, Alwaysontop, , A

;------------------------------------------------------------------------
; Alt+F3 toggles maximize, whether it is enabled or not
;------------------------------------------------------------------------
!F3:: ;Maximize/Restore Window
WinGet MX, MinMax, A
if MX
{
	WinRestore A
	WinSet, Style, +0xC00000, A
}
else 
{
	WinMaximize A
	WinSet, Style, -0xC00000, A
}
return

;------------------------------------------------------------------------
; Win+Alt+T toggle autohide taskbar
;------------------------------------------------------------------------
#!t::ToggleAutoHideTaskBar()
ToggleAutoHideTaskBar()
{
   VarSetCapacity( APPBARDATA, 36, 0 )
   NumPut(36, APPBARDATA, 0, "UInt") ; First field is the size of the struct
   bits := DllCall("Shell32.dll\SHAppBarMessage"
             ,"UInt", 4 ; ABM_GETSTATE
             ,"UInt", &APPBARDATA )  
  NumPut( (bits ^ 0x1), APPBARDATA, 32, "UInt" ) ; Toggle Autohide
  DllCall("Shell32.dll\SHAppBarMessage"
             ,"UInt", ( ABM_SETSTATE := 0xA )
             ,"UInt", &APPBARDATA )
}

;------------------------------------------------------------------------
; Ctrl+Alt+NumpadSub - Resize the current window to 350x700
; Meant to be used with IM windows
;------------------------------------------------------------------------
^!NumpadSub:: 
	WinGet, hwnd, ID, A
	WinGetPos, X, Y, Width, Height, ahk_id %hwnd%
	WinMove, ahk_id %hwnd%,, X, Y, 375, 700
return

