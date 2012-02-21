#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir C:\Program Files (x86)\Steam\steamapps\common\skyrim\

winTitle = ahk_class Skyrim

; To not use a custom launcher use:
; Run steam://rungameid/72850

; To use the skse loader uncomment this
Run skse_loader.exe

WinWait %winTitle%

WinActivate, %winTitle%
WinSet, Style, -0xC40000, %winTitle%
WinMove, %winTitle%, , 0, 0, 1680, 1050

; WinMaximize, A
