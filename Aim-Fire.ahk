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
fire = MButton
aim = RButton
zoomfire = LButton
zoomfiretoggle = NumpadDot   ; the decimal point on the number pad turns it on or off

;-- Locals ---
zoomfireon := true

;--- Setup hotkey ---
Hotkey,~*%zoomfire%,do_ZoomFire
Hotkey,~*%zoomfiretoggle%,do_ZoomFireToggle
return

do_ZoomFireToggle:
{
	if (zoomfireon = true) 	
	{
		zoomfireon := false
		SoundBeep, 350, 100
	}
	else 
	{
		zoomfireon := true
		SoundBeep, 1200, 100
	}

	return
}

do_ZoomFire:
{
	if not zoomfireon
		return

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


