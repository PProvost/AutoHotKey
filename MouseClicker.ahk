
ToolTip, "Auto clicker active!! Repeated clicks will begin in 5 seconds. Click Right mouse button to stop."
Sleep, 5000

Loop 
{
	GetKeyState, state, RButton, P
	if state = D
		break

	Click
	Sleep, 5000
}

ToolTip, "Auto clicker complete. Re-run the script to start it again."
Sleep, 5000
ToolTip
