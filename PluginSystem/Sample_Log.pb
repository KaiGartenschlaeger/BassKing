XIncludeFile "BK_Plugin.pbi"

EnableExplicit

If BassKing_SendMessage(#BKM_Register)
  
  BassKing_SendMessage(#BKM_OpenWindow, 6) ; Open Log Window
  BassKing_SendMessage(#BKM_LogClear)      ; Clear Log
  
  Define i.i
  For i = 10 To 1 Step -1
    BassKing_SendMessage(#BKM_LogAdd, 0, 0, Str(i))
    Delay(500)
  Next
  
  Delay(500)
  
  BassKing_SendMessage(#BKM_CloseWindow, 6)
  
Else
  MessageRequester("Fehler", "BassKing konnte nicht gefunden werden")
EndIf

End
; IDE Options = PureBasic 4.40 Beta 2 (Windows - x86)
; CursorPosition = 23
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 16
; EnableBuildCount = 0
; EnableExeConstant