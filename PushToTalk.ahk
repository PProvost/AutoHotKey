;PushToTalk.ahk
; Push and hold Win+S to activate the microphone, release to mute.
;Skrommel @2006

#SingleInstance,Force

applicationname=PushToTalk
Gosub,TRAYMENU
SoundGet,micvol,Microphone:2,Volume
SoundSet,0,Microphone:2,Volume
ToolTip,Mic is Off
Sleep,2000
ToolTip,
Return

#s::
SoundGet,micvol,Microphone:2,Volume
ToolTip,Mic is On
SoundSet,100,Microphone:2,Volume
Loop
{
  Sleep,10
  GetKeyState,states,LWin,P
  GetKeyState,state,S,P
  states=%states%%state%
  IfInString,states,U
    Break
}
ToolTip,Mic is Off
SoundSet,0,Microphone:2,Volume
Sleep,2000
ToolTip,
Return

TRAYMENU:
Menu,Tray,NoStandard
Menu,Tray,DeleteAll
Menu,Tray,Add,%applicationname%,TOGGLE
Menu,Tray,Add
Menu,Tray,Add,&Mic enabled,TOGGLE
Menu,Tray,Add
Menu,Tray,Add,&About...,ABOUT
Menu,Tray,Add,E&xit,EXIT
Menu,Tray,Default,%applicationname%
Menu,Tray,UnCheck,&Mic enabled
Menu,Tray,Tip,%applicationname%
Return

TOGGLE:
SoundGet,micvol,Microphone:2,Volume
If micvol=0
{
  ToolTip,Mic is On
  SoundSet,100,Microphone:2,Volume
  Menu,Tray,Check,&Mic enabled
}
Else
{
  ToolTip,Mic is Off
  SoundSet,0,Microphone:2,Volume
  Menu,Tray,UnCheck,&Mic enabled
}
Sleep,2000
ToolTip,
Return


ABOUT:
Gui,99:Destroy
Gui,99:Margin,20,20
Gui,99:Add,Picture,xm Icon1,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,%applicationname% v1.0
Gui,99:Font
Gui,99:Add,Text,y+10,Push and hold Win+S to activate the microphone, release to mute.

Gui,99:Add,Picture,xm y+20 Icon5,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,1 Hour Software by Skrommel
Gui,99:Font
Gui,99:Add,Text,y+10,For more tools, information and donations, please visit 
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+5 G1HOURSOFTWARE,www.1HourSoftware.com
Gui,99:Font

Gui,99:Add,Picture,xm y+20 Icon7,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,DonationCoder
Gui,99:Font
Gui,99:Add,Text,y+10,Please support the contributors at
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+5 GDONATIONCODER,www.DonationCoder.com
Gui,99:Font

Gui,99:Add,Picture,xm y+20 Icon6,%applicationname%.exe
Gui,99:Font,Bold
Gui,99:Add,Text,x+10 yp+10,AutoHotkey
Gui,99:Font
Gui,99:Add,Text,y+10,This tool was made using the powerful
Gui,99:Font,CBlue Underline
Gui,99:Add,Text,y+5 GAUTOHOTKEY,www.AutoHotkey.com
Gui,99:Font

Gui,99:Show,,%applicationname% About
hCurs:=DllCall("LoadCursor","UInt",NULL,"Int",32649,"UInt") ;IDC_HAND
OnMessage(0x200,"WM_MOUSEMOVE") 
Return

1HOURSOFTWARE:
  Run,http://www.1hoursoftware.com,,UseErrorLevel
Return

DONATIONCODER:
  Run,http://www.donationcoder.com,,UseErrorLevel
Return

AUTOHOTKEY:
  Run,http://www.autohotkey.com,,UseErrorLevel
Return

99GuiClose:
  Gui,99:Destroy
  OnMessage(0x200,"")
  DllCall("DestroyCursor","Uint",hCur)
Return

WM_MOUSEMOVE(wParam,lParam)
{
  Global hCurs
  MouseGetPos,,,,ctrl
  If ctrl in Static7,Static11,Static15
    DllCall("SetCursor","UInt",hCurs)
  Return
}
Return


EXIT:
ExitApp

