#ifWinActive World of Warcraft
{
; The following script is run when the user presses the '1' key
; and will loop until the 1 key is no longer pressed, sending
; 1 over and over every 100 miliseconds. To use a different
; key, replace all three 1s with the key you want repeated.
$1::
   Loop  
   {
    if not GetKeyState("1", "P")
      break
     Send 1 
     Sleep 100
    }
return
}
