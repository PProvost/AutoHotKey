#SingleInstance
#NoEnv
SendMode, Input

;------------------------------------------------------------------
;Add your games window class name to this list to activate the script for that game
;------#GAMES#--------------------------------------------------

GroupAdd,gamewindow ,ahk_class CoD4			;COD 4: MW
GroupAdd,gamewindow ,ahk_class CoD-WaW		;COD 5: WAW
GroupAdd,gamewindow ,ahk_class IW4			;COD 6: MW2
GroupAdd,gamewindow ,ahk_class CoDBlackOps	;COD 7: BO
#IfWinActive ahk_group gamewindow

;--- Bindings ---
fire = LButton
aim = RButton
zoomfire = MButton

; --- Setup hotkey ---
Hotkey,~*%zoomfire%,do_ZoomFire
return

do_ZoomFire:
{
	; If we've not already got RButton down, press and hold it
	GetKeyState, aimstate, %aim%, P
	if aimstate = U 
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
	Send { %fire%  }

	; If we clicked it down, click it back up
	if aimstate = U
	{
		Sleep 35
		Send { %aim%  }
	}

	return
}


