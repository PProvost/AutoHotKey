#SingleInstance
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.

;------------------------------------------------------------------
;Add your games window class name to this list to activate the script for that game
;------#GAMES#--------------------------------------------------

GroupAdd,gamewindow ,ahk_class CoD4			;COD 4: MW
GroupAdd,gamewindow ,ahk_class CoD-WaW		;COD 5: WAW
GroupAdd,gamewindow ,ahk_class IW4			;COD 6: MW2
GroupAdd,gamewindow ,ahk_class CoDBlackOps	;COD 7: BO

;--- Bindings ---
fire = LButton
aim = RButton
zoomfire = MButton

;------------------------------------------------------------------
#IfWinActive ahk_group gamewindow

~*MButton::
{
	GetKeyState, RButtonState, RButton, P

	; If we've not already got RButton down, press and hold it
	if RButtonState = U 
	{
		Sleep 35
		Send { %aim% down }
	}

	; Fire!
	Sleep 35
	Send { %fire% down }

	; Wait until the primary button has been released
	KeyWait, %zoomfire%, T5

	; Cleanup the mess by clicking everything LOL
	Sleep 35
	Click, left

	if RButtonState = U
	{
		Sleep 35
		Click, right
	}
}


