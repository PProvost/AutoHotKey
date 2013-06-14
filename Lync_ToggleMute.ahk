#SingleInstance
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; F4 to the Lync window toggles mute
ControlSend , , #{F4}, ahk_class CommunicatorMainWindowClass
