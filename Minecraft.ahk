#SingleInstance
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Add other minecraft window titles to this group
; e.g. Tekkit, MultiMC, etc.
GroupAdd, MinecraftWindows, Tekkit Lite
GroupAdd, MinecraftWindows, Minecraft

#IfWinActive, ahk_group MinecraftWindows
Xbutton1::Space
