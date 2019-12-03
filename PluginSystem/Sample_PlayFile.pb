XIncludeFile "BK_Plugin.pbi"

EnableExplicit

Procedure.i PlayFile(File$ = "")
  If File$ = ""
    File$ = OpenFileRequester("Datei Wiedergeben", GetCurrentDirectory(), "Unterstützte Formate|*.wav;*.aif;*.mp3;*.mp2;*.mp1;*.mo3;*.it;*.xm;*.s3m;*.mtm;*.mod;*.umx;*.wma;*.flac;*.mid", 0)
  EndIf
  If BassKing_SendMessage(#BKM_PlayFile, 0, 0, File$)
    BassKing_SendMessage(#BKM_Show)
    ProcedureReturn 1
  EndIf
EndProcedure

If BassKing_SendMessage(#BKM_Register) = 0
  MessageRequester("Fehler", "BassKing nicht gefunden")
Else
  PlayFile()
EndIf
; IDE Options = PureBasic 4.40 Beta 2 (Windows - x86)
; CursorPosition = 16
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 20
; EnableBuildCount = 0
; EnableExeConstant