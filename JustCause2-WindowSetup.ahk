#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

winTitle = ahk_class Just Cause 2

WinActivate, %winTitle%
WinSet, Style, -0xC40000, %winTitle%
WinMove, %winTitle%, , 0, 0, 1680, 1050

; WinMaximize, A
