; v1.0 2010-02-23 Original Release
; v1.1 2010-02-25 Added user configuration section
;                 Added option to block mouse clicks
;                 Added option to omit blocking for shift, ctrl, alt, win keys

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;user configuration
DisableTime := 500 ;in milliseconds
BlockMouseMove := True
BlockLeftClick := True
BlockMiddleClick := True
BlockRightClick := True
AllowShift := True
AllowCtrl := True
AllowAlt := True
AllowWin :=True

;keyboard hook code credit: http://www.autohotkey.com/forum/post-127490.html#127490
#Persistent
OnExit, Unhook

;initialize
hHookKeybd := SetWindowsHookEx(WH_KEYBOARD_LL   := 13, RegisterCallback("Keyboard", "Fast"))
Hotkey, LButton, DoNothing, Off
Hotkey, MButton, DoNothing, Off
Hotkey, RButton, DoNothing, Off
Return

DisableTrackpad:
ShiftActive := AllowShift && GetKeyState("Shift")
CtrlActive := AllowCtrl && GetKeyState("Ctrl")
AltActive := AllowAlt && GetKeyState("Alt")
LWinActive := AllowWin && GetKeyState("LWin")
RWinActive := AllowWin && GetKeyState("RWin")
if (!ShiftActive && !CtrlActive && !AltActive && !LWinActive && !RWinActive)
{
   if (BlockMouseMove)
      BlockInput, MouseMove
   if (BlockLeftClick)
      Hotkey, LButton, DoNothing, On
   if (BlockMiddleClick)
      Hotkey, MButton, DoNothing, On
   if (BlockLeftClick)
      Hotkey, RButton, DoNothing, On
}
Return

ReenableTrackpad:
if (BlockMouseMove)
   BlockInput, MouseMoveOff
if (BlockLeftClick)
   Hotkey, LButton, Off
if (BlockMiddleClick)
   Hotkey, MButton, Off
if (BlockLeftClick)
   Hotkey, RButton, Off
Return

DoNothing:
Return

Unhook:
UnhookWindowsHookEx(hHookKeybd)
ExitApp

Keyboard(nCode, wParam, lParam)
{
   Critical
   If !nCode
   {
      Gosub, DisableTrackpad
      SetTimer, ReenableTrackpad, %DisableTime%
   }
   Return CallNextHookEx(nCode, wParam, lParam)
}

SetWindowsHookEx(idHook, pfn)
{
   Return DllCall("SetWindowsHookEx", "int", idHook, "Uint", pfn, "Uint", DllCall("GetModuleHandle", "Uint", 0), "Uint", 0)
}

UnhookWindowsHookEx(hHook)
{
   Return DllCall("UnhookWindowsHookEx", "Uint", hHook)
}

CallNextHookEx(nCode, wParam, lParam, hHook = 0)
{
   Return DllCall("CallNextHookEx", "Uint", hHook, "int", nCode, "Uint", wParam, "Uint", lParam)
}

