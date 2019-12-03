; BassKing Plugin Include
; Letzte Änderung: 21.09.2009

Structure _BKM ; Message Strukture für BassKing_SendMessage
  Msg.i
  iParam1.i
  iParam2.i
  sParam1.s {500}
  sParam2.s {100}
EndStructure

#BK_PluginEvent = #WM_USER + 102

Enumeration
  ; Jedes Plugin das Rückgabewerte erwartet muss sich mit dieser Message anmelden
  ; Andernfalls werden die Trackinfos nicht gesendet!
  #BKM_Register     ; Plugin Anmelden [WindowID, Version, Firma, Description]
  #BKM_Unsubscribe  ; Plugin Abmelden [iParam1 = WindowID]
  
  #BKM_End          ; BassKing Beenden
  #BKM_Show         ; Fenster anzeigen/wiederherstellen
  #BKM_Hide         ; Fenster verstecken/minimieren
  
  #BKM_LogAdd       ; Log Eintrag hinzufügen
  #BKM_LogClear     ; Log Fenster Leeren
  
  #BKM_Play         ; Wiedergabe starten
  #BKM_PlayFile     ; Datei abspielen [sParam1 = Filename]
  #BKM_PrevTrack    ; Letzter Track
  #BKM_NextTrack    ; Nächster Track
  #BKM_Pause        ; Pause
  #BKM_Stop         ; Wiedergabe anhalten
  #BKM_Volume       ; Lautstärke ändern [iParam1 = 0 - 100]
  #BKM_Speed        ; Abspielgeschwindigkeit anpassen [iParam1 = 1 - 200]
  #BKM_Panel        ; Ausrichtung anpassen
  
  #BKM_PlayListSel  ; Eintrag in Wiedergabeliste auswählen (-1 - n)
  #BKM_MediaLibSel  ; Eintrag in Medienbibliothek auswählen (-1 - n)
  
  ; Öffnet oder Schließt ein Fenster
  #BKM_OpenWindow
  #BKM_CloseWindow
  
  ; Empfang von Titelinformationen
  ; lpData = String
  #BKR_TagFile     ; Filepath
  #BKR_TagTitle    ; Titel
  #BKR_TagArtist   ; Interpret
  #BKR_TagAlbum    ; Album
  #BKR_TagYear     ; Jahr
  #BKR_TagComment  ; Kommentar
  #BKR_TagTrack    ; Nummer
  #BKR_TagGenre    ; Genre
  
  #BKR_Start   ; Channel Wiedergabe gestartet [iParam1 = Channel]
  #BKR_Stop    ; Channel wurde beendet [iParam1 = Channel]
  #BKR_End     ; Plugin Beenden Nachricht
  #BKR_Volume  ; Lautstärke hat sich geändert [iParam1 = 0.0 - 0.1]
  
  ; BassKing Nachricht um Einstellungen des Plugins anzuzeigen
  ; Wird gesendet nach dem der Benutzer unter Einstellungen/Plugins/Ausführen im Menu Einstellungen gewählt hat.
  ; Bas Plugin sollte dann wenn vorhanden das Einstellungen Fenster öffnen.
  #BKR_Preferences
EndEnumeration

; Sendet eine Nachricht an BassKing
Procedure.i BassKing_SendMessage(Msg.i, iParam1.i = 0, iParam2.i = 0, sParam1.s = "", sParam2.s = "")
  Protected iWindow.i, iResult.i
  Protected CDS.COPYDATASTRUCT
  Protected BKM._BKM
  
  iWindow = FindWindow_("WindowClass_1", "BassKing")
  If IsWindow_(iWindow)
    BKM\Msg     = Msg
    BKM\iParam1 = iParam1
    BKM\iParam2 = iParam2
    BKM\sParam1 = sParam1
    BKM\sParam2 = sParam2
    
    CDS\dwData = #BK_PluginEvent
    CDS\cbData = SizeOf(_BKM)
    CDS\lpData = @BKM
    
    iResult = SendMessage_(iWindow, #WM_COPYDATA, 0, @CDS)
  EndIf
  
  ProcedureReturn iResult
EndProcedure



BassKing_SendMessage(#BKM_OpenWindow, 2)


; IDE Options = PureBasic 4.40 (Windows - x86)
; CursorPosition = 91
; FirstLine = 47
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 48
; EnableBuildCount = 0
; EnableExeConstant