; Enthält die Funktion die überprüft ob BassKing bereits gestartet wurde
;
; Letzte Bearbeitung: 28.11.2009

CompilerIf #PB_Compiler_Debugger = 0

Global hMutex.i = CreateMutex_(0, 0, #PrgMutex)

If GetLastError_() = #ERROR_ALREADY_EXISTS
  CloseHandle_(hMutex)
  
  BassKing_SendMessage(#BKM_Show)
  
  If FileSize(GetProgramParameter()) > 0
    BassKing_SendMessage(#BKM_PlayFile, 0, 0, GetProgramParameter())
  EndIf
  
  End
EndIf

CompilerEndIf
; IDE Options = PureBasic 4.40 (Windows - x86)
; CursorPosition = 14
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant