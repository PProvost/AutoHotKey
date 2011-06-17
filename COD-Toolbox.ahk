#SingleInstance
#NoEnv
;------#COD TOOLBOX#-----------------------------------------------
;Last updated 13/11/2010
;Script by Zygorator		 
;Original crosshair script by guest and master131
;------------------------------------------------------------------

;------------------------------------------------------------------
;Add your games window class name to this list to activate the script for that game
;------#GAMES#--------------------------------------------------

GroupAdd,gamewindow ,ahk_class CoD4			;COD 4: MW
GroupAdd,gamewindow ,ahk_class CoD-WaW		;COD 5: WAW
GroupAdd,gamewindow ,ahk_class IW4			;COD 6: MW2
GroupAdd,gamewindow ,ahk_class CoDBlackOps	;COD 7: BO

;------------------------------------------------------------------
#IfWinActive ahk_group gamewindow
;------#INFO#------------------------------------------------------

;	Remember to set your game to run in windowed mode and restart if you want to show crosshair (and alt-tab out while dead)
;	The script will automatically maximize and remove borders from the game so it works completely like fullscreen mode
;	Punkbuster seems to hate overlays

;	There are three different fire modes:
;	1) Single gun rapidfire
;	2) Akimbo/Dual Wield rapidfire
;	3) Burst fire

;------------------------------------------------------------------
;All keys behave as normal when game window is not at the front.
;------#BINDINGS#--------------------------------------------------

anim_cancel		= <			;Animation canceling for faster reload.

switch_mode		= Insert 		;Switch between fire modes
crosshair		= Delete		;Toggle the crosshair

burst_down		= NumpadSub		;Lower amount of bullets fired in burst mode (different weapons have different firerates)
burst_up		= NumpadAdd		;Raise amount of bullets fired in burst mode (you might need to raise/lower this more than once just to add/remove one bullet in the burst)

recoil_toggle	= End			;Toggle recoil compensation
recoil_up		= PgUP			;Increase recoil compensation (how many pixels it moves each time it is run)
recoil_down		= PgDn			;Decrease recoil compensation

quick_knife		= -			;Does a very very fast knife attack, around double the speed of tact. knife
								;Note: Do not use with anything but Tomahawk/Throwing knife(MW2)/C4(MW2)
								;There is a miniscule chance that you'r equipment will bork and knife will fail.
								;It is spammable (almost) without fail with almost every weapon in BO.  In MW2 stick to pistols and G18 Akimbo with it.

;------------------------------------------------------------------
;Firerates in miliseconds. Lower is faster. Default should work fine, but some servers might kick when this low.
;For optimal results, set it close to the firerate of a specific gun (this will of course make it less optimal for other guns.)
;------#FIRERATES#-------------------------------------------------

firerate_1 = 85 		;Mode 1
firerate_2 = 25			;Mode 2
firerate_3 = 85 		;Mode 3

;------------------------------------------------------------------
;Crosshair colour in base16
;------#CROSSHAIR SETTINGS#----------------------------------------

red = 00
green = FF
blue = 00

;------------------------------------------------------------------
;Don't change these unless you know what you're doing:
;------#OTHER VARIABLES#-------------------------------------------

melee = v				
equip = g
switch_weapon = 1
window_title = ahk_group gamewindow
finalcolor = 0x00%blue%%green%%red%
fire = LButton
rcoil := 3
rcoil_on := 0
fullscreen := 0
max_burst := 20
max_recoil := 20
fire_mode := 0
looptime := 4
drawshit := 0
xpos := A_ScreenWidth/2
ypos := A_ScreenHeight/2
hDrwArea := DllCall("GetDC", "uint", Null)

;--------------------------------------------------------------
;Feel free to rage over incredible amounts of redundant code, my first script.
;--------------------------------------------------------------
Hotkey,~*%fire%,rapidfireLoop
Hotkey,~*%switch_mode%,doswitch_mode
Hotkey,~*%crosshair%,docrosshair
Hotkey,~*%burst_up%,doBurst_up
Hotkey,~*%burst_down%,doBurst_down
Hotkey,~*%recoil_down%,rcoildown
Hotkey,~*%recoil_up%,rcoilup
Hotkey,~*%recoil_toggle%,rcoiltoggle
Hotkey,~*%anim_cancel%,animcancel
Hotkey,~*%quick_knife%, quickKnife

lazor:
Loop
{
	WinWaitClose, %window_title%
	{
		fullscreen := 0
		fire_mode := 0
		Dontdraw()
		drawshit := 0
	}
	
	WinWait, %window_title%
	{	
		if not fullscreen = 1
		{
			WinActivate
			fullscreen := 1
			WinSet, Style, -0xC00000
			WinMove, , , 0, 0
			WinMaximize
		}
	}
sleep 10000
}
return

quickKnife:
	doQuickKnife(melee,equip,switch_weapon)
	
doQuickKnife(v1,v2,v3) {
   SendInput {%v1% Down}      
      Sleep 40
   SendInput {%v1% Up}      
      Sleep 100
   SendInput {%v2% Down}
      Sleep 40
   SendInput {%v3% Down}
      Sleep 40
   SendInput {%v2% Up}
      Sleep 40
   SendInput {%v3% Up}      
Sleep 190
Return
}


animcancel:
{
	SendInput {%switch_weapon%}
	sleep 10
	SendInput {%switch_weapon%}
	sleep 100
}
return

doswitch_mode:
If fire_mode < 3
{
	fire_mode += 1
	if fire_mode = 1
	{
SoundBeep, 600, 100
	}
	else if fire_mode = 2
	{
SoundBeep, 800, 100
	}
	else if fire_mode = 3
	{
SoundBeep, 1000, 100
	}
}
else
{
fire_mode := 0
SoundBeep, 200, 100
SoundBeep, 200, 100
}
return

docrosshair:
If drawshit < 1
{
	drawshit +=1
	If drawshit = 1
	{
		Draw()
	}
}
else
{
Dontdraw()
drawshit := 0
}
return

doBurst_down:
IfWinActive, %window_title%
{
	if looptime > 1
	{
		SoundBeep, 650, 100
		looptime -= 1
	}
	else
	{
		looptime = 1
		SoundBeep, 650, 100
		SoundBeep, 750, 100
	}
}
return

doBurst_up:
if looptime < %max_burst%
	{
		SoundBeep, 450, 100
		looptime += 1
	}
	else
	{
		looptime = %max_burst%
		SoundBeep, 450, 100
		SoundBeep, 550, 100
	}
return

rcoildown:
if rcoil > 1
	{
		SoundBeep, 450, 100
		rcoil -= 1
	}
	else
	{
		SoundBeep, 440, 100
		rcoil = 1
	}
return

rcoilup:
if rcoil < %max_recoil%
	{
		SoundBeep, 650, 100
		rcoil += 1
	}
	else
	{
		SoundBeep, 650, 100
		rcoil = %max_recoil%
	}
return

rcoiltoggle:
if rcoil_on = 0
	{
		SoundBeep, 1200, 100
		rcoil_on := 1
	}
	else
	{
		SoundBeep, 350, 100
		rcoil_on := 0
	}
return

recoil_reduction()
{
	global
	if rcoil_on = 1
	{
		MouseMove, 0, rcoil ,0 , r
	}
}
return

rapidfireLoop:
if not fire_mode = 0
{
    Loop
    {
		GetKeyState, LButtonState, LButton, P
		if fire_mode = 1
		{
			Click
			recoil_reduction()
			sleep, %firerate_1%
			If LButtonState = U
			{
				break
			}
		}
		else if fire_mode = 2
		{
			
			Click
			recoil_reduction()
			Sleep, %firerate_2%
			Click right
			Sleep, %firerate_2%
			If LButtonState = U
			{
				break
			}
		}
		else if fire_mode = 3
		{
			loop %looptime%
			{
				Click
				recoil_reduction()
				Sleep %firerate_3%
			}
			Sleep 20
			break
		}
		else
		{
			break
		}
    }	
}
else
{
	if rcoil_on = 1
	{
		loop
		{
			sleep 60
			recoil_reduction()
			GetKeyState, LButtonState, LButton, P
			If LButtonState = U
			{
				break
			}
		}
	}
}
return



Draw()
{
SetTimer, SetPixel, 1
}
return

Dontdraw()
{
SetTimer, SetPixel, Off
}
return


SetPixel:
IfWinActive, %window_title%
{
DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos - 2, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos + 2, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos - 3, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos + 3, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos - 2, "int", ypos, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos + 2, "int", ypos, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos - 3, "int", ypos, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos + 3, "int", ypos, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos - 4, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos + 4, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos - 4, "int", ypos, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos + 4, "int", ypos, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos - 5, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos + 5, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos - 5, "int", ypos, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos + 5, "int", ypos, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos - 6, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos + 6, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos - 6, "int", ypos, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos + 6, "int", ypos, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos - 7, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos, "int", ypos + 7, "uint", finalcolor)

DllCall("SetPixel", "uint", hDrwArea, "int", xpos - 7, "int", ypos, "uint", finalcolor)
DllCall("SetPixel", "uint", hDrwArea, "int", xpos + 7, "int", ypos, "uint", finalcolor)
}
Return

; THE END?
; (yes)
