; Enthällt die OnError Procedure
;
; Letzte Bearbeitung: 28.11.2009

CompilerIf #PB_Compiler_Debugger = 0

Procedure ErrorHandler()
  If MessageRequester("Fehler", "Adresse: " + Hex(ErrorAddress()) + #CR$ + "Zeile: " + Str(ErrorLine()) + #CR$ + #CR$ + ErrorMessage(ErrorCode()), #MB_ICONERROR|#MB_RETRYCANCEL) = #IDCANCEL
    End
  EndIf
EndProcedure

OnErrorCall(@ErrorHandler())

CompilerEndIf
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant