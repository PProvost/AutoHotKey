ResizeWin(Width = 0,Height = 0)
{
  WinGetPos,X,Y,W,H,A
  If %Width% = 0
    Width := W
 
  If %Height% = 0
    Height := H
 
  WinMove,A,,%X%,%Y%,%Width%,%Height%
}

; Win+Alt+U sized to 1024x768
#!u::ResizeWin(1024,768)

#!z::ResizeWin(1280,800)
