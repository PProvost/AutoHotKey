; Launch console if necessary; hide/show on Win+`
#`::
DetectHiddenWindows, on
IfWinExist ahk_class Console_2_Main ; ahk_class Console Main Command Window
{
	IfWinActive ahk_class Console_2_Main ; ahk_class Console Main Command Window
	  {
			WinHide ahk_class Console_2_Main ; ahk_class Console Main Command Window
			; need to move the focus somewhere else.
			WinActivate ahk_class Shell_TrayWnd
		}
	else
	  {
	    WinShow ahk_class Console_2_Main ; ahk_class Console Main Command Window
	    WinActivate ahk_class Console_2_Main ; ahk_class Console Main Command Window
	  }
}
else
{
	EnvGet, HomeDir, Home
	Run console -c "%HomeDir%\AutoHotKey\QuickConsole.xml"
}

DetectHiddenWindows, off
return

; hide console on "esc".
#IfWinActive ahk_class Console_2_Main ; ahk_class Console Main Command Window
esc::
 {
   WinHide ahk_class Console_2_Main ; ahk_class Console Main Command Window
   WinActivate ahk_class Shell_TrayWnd
 }
return
