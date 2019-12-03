EnableExplicit
; BassKing Tracker Beispiel
; Letzte Bearbeitung: 08.11.09, Kai Gartenschläger

XIncludeFile "BK_Plugin.pbi"

Enumeration
  #Win_Main
  #Win_Preferences
EndEnumeration

Enumeration
  #G_BN_Main_Play
  #G_BN_Main_Stop
  #G_TB_Main_Volume
  #G_LI_Main_TrackInfos
  #G_TX_Preferences_Info
EndEnumeration

#PrgName = "Tracker"
#PrgComp = "PureSoft"
#PrgDesc = "Tracker Sample"
#PrgVers = 101

Global iCurrChannel.i

Declare WindowCallback(hWnd, Msg, wParam, lParam)
Declare OpenWindow_Main()
Declare OpenWindow_Preferences()
Declare EndApplication()
Declare WinLoop(TimeOut = 0)
Declare Main()

; Window Callback
Procedure WindowCallback(hWnd, Msg, wParam, lParam)
  Protected iResult.l = #PB_ProcessPureBasicEvents
  
  If Msg = #WM_COPYDATA And lParam <> 0
    Protected i.i
    Protected *CDS.COPYDATASTRUCT = lParam
    
    If *CDS
      Select *CDS\dwData
        ; Track Playing
        Case #BKR_Start
          iCurrChannel = PeekI(*CDS\lpData)
        ; Receive Tags..
        Case #BKR_TagTitle
          SetGadgetItemText(3, 0, PeekS(*CDS\lpData), 1)
        Case #BKR_TagArtist
          SetGadgetItemText(3, 1, PeekS(*CDS\lpData), 1)
        Case #BKR_TagAlbum
          SetGadgetItemText(3, 2, PeekS(*CDS\lpData), 1)
        ; Volume Changed
        Case #BKR_Volume
          SetGadgetState(#G_TB_Main_Volume, PeekI(*CDS\lpData))
        ; Track Stoped
        Case #BKR_Stop
          If iCurrChannel = PeekI(*CDS\lpData)
            For i = 0 To 3
              SetGadgetItemText(3, i, "", 1)
            Next
          EndIf
        ; Received Exit-Message from BassKing
        Case #BKR_End
          EndApplication()
        ; Open Preferences Message from BassKing
        Case #BKR_Preferences
          OpenWindow_Preferences()
      EndSelect
    EndIf
    
    iResult = 1
  EndIf
  
  ProcedureReturn iResult
EndProcedure

; Open MainWindow
Procedure OpenWindow_Main()
  If OpenWindow(0, 0, 0, 280, 200, #PrgName, #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
    ButtonGadget(0, 5, 5, 80, 25, "Play")
    ButtonGadget(1, 90, 5, 80, 25, "Stop")
    TrackBarGadget(2, 175, 5, 100, 25, 0, 100)
    ListIconGadget(3, 5, 35, WindowWidth(0) - 10, WindowHeight(0) - 45, "Tag", 80)
      AddGadgetColumn(3, 1, "Wert", 150)
      AddGadgetItem(3, -1, "Titel:")
      AddGadgetItem(3, -1, "Artist:")
      AddGadgetItem(3, -1, "Album:")
    HideWindow(#Win_Main, 0)
    SetWindowCallback(@WindowCallback(), #Win_Main)
  Else
    MessageRequester("Fehler", "Fenster 'Main' konnte nicht erstellt werden.", #MB_ICONERROR)
  EndIf
EndProcedure

Procedure OpenWindow_Preferences()
  If OpenWindow(#Win_Preferences, 0, 0, 200, 120, "Einstellungen", #PB_Window_Invisible|#PB_Window_WindowCentered|#PB_Window_SystemMenu, WindowID(#Win_Main))
    TextGadget(#G_TX_Preferences_Info, 2, 2, WindowWidth(#Win_Preferences) - 4, WindowHeight(#Win_Preferences) - 4, "Einstellungen!", #SS_CENTER|#SS_CENTERIMAGE)
    
    DisableWindow(#Win_Main, 1)
    HideWindow(#Win_Preferences, 0)
  EndIf
EndProcedure

Procedure EndApplication()
  BassKing_SendMessage(#BKM_LogAdd, 0, 0, "Tracker Addon Ending..")
  BassKing_SendMessage(#BKM_Unsubscribe, WindowID(#Win_Main))
  End
EndProcedure

Procedure WinLoop(TimeOut = 0)
  Protected iWinEvent.i
  Protected iEventWin.i
  Protected iEventGadget.i
  Protected iEventMenu.i
  Protected iEventType.i
  
  iWinEvent     = WaitWindowEvent(TimeOut)
  iEventWin     = EventWindow()
  iEventGadget  = EventGadget()
  iEventMenu    = EventMenu()
  iEventType    = EventType()
  
  Select iWinEvent
    Case #PB_Event_Gadget
      Select iEventWin
        Case #Win_Main
          Select iEventGadget
            Case #G_BN_Main_Play
              BassKing_SendMessage(#BKM_Play)
            Case #G_BN_Main_Stop
              BassKing_SendMessage(#BKM_Stop)
            Case #G_TB_Main_Volume
              BassKing_SendMessage(#BKM_Volume, GetGadgetState(#G_TB_Main_Volume))
          EndSelect
        Case #Win_Preferences
          Select iEventGadget
          EndSelect
      EndSelect
    Case #PB_Event_CloseWindow
      Select iEventWin
        Case #Win_Main
          EndApplication()
        Case #Win_Preferences
          CloseWindow(#Win_Preferences)
          DisableWindow(#Win_Main, 0)
      EndSelect
  EndSelect
EndProcedure

Procedure Main()
  OpenWindow_Main()
  
  ; Register Plugin
  If BassKing_SendMessage(#BKM_Register, WindowID(#Win_Main), #PrgVers, #PrgComp, #PrgDesc) = 0
    MessageRequester("Fehler", "Registrierung bei BassKing fehlgeschlagen!" + #CR$ + "BassKing nicht gestartet?")
    End
  EndIf
  
  BassKing_SendMessage(#BKM_LogAdd, 0, 0, "Tracker Addon Succefull started")
  
  Repeat
    WinLoop(25)
  ForEver
EndProcedure

; Run
Main()
End

; IDE Options = PureBasic 4.40 Beta 6 (Windows - x86)
; CursorPosition = 99
; FirstLine = 124
; Folding = --
; EnableXP
; Executable = ..\Plugins\Tracker.exe
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 123
; EnableBuildCount = 33
; EnableExeConstant