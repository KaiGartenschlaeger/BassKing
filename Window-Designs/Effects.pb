#Win_Effects = 0

Enumeration
  #G_FR_Effects_Equalizer
  #G_CH_Effects_Equalizer
  #G_CB_Effects_Equalizer
  #G_TB_Effects_EqualizerBand0
  #G_TB_Effects_EqualizerBand1
  #G_TB_Effects_EqualizerBand2
  #G_TB_Effects_EqualizerBand3
  #G_TB_Effects_EqualizerBand4
  #G_TB_Effects_EqualizerBand5
  #G_TB_Effects_EqualizerBand6
  #G_TB_Effects_EqualizerBand7
  #G_TB_Effects_EqualizerBand8
  #G_TB_Effects_EqualizerBand9
  #G_TX_Effects_Band0
  #G_TX_Effects_Band1
  #G_TX_Effects_Band2
  #G_TX_Effects_Band3
  #G_TX_Effects_Band4
  #G_TX_Effects_Band5
  #G_TX_Effects_Band6
  #G_TX_Effects_Band7
  #G_TX_Effects_Band8
  #G_TX_Effects_Band9
  #G_TX_Effects_MaxValue
  #G_TX_Effects_CenterValue
  #G_TX_Effects_MinValue
  #G_PN_Effects_Categorie
  #G_FR_Effects_SystemVolume
  #G_TX_Effects_SystemVolume
  #G_TB_Effects_SystemVolume
  #G_TX_Effects_SystemVolumeV
  #G_FR_Effects_Speed
  #G_TX_Effects_Speed
  #G_TB_Effects_Speed
  #G_TX_Effects_SpeedV
  #G_FR_Effects_Panel
  #G_TX_Effects_Panel
  #G_TB_Effects_Panel
  #G_TX_Effects_PanelV
  #G_FR_Effects_Reverb
  #G_CH_Effects_Reverb
  #G_TX_Effects_ReverbMix
  #G_TB_Effects_ReverbMix
  #G_TX_Effects_ReverbMixV
  #G_TX_Effects_ReverbTime
  #G_TB_Effects_ReverbTime
  #G_TX_Effects_ReverbTimeV
  #G_FR_Effects_Echo
  #G_CH_Effects_Echo
  #G_TX_Effects_EchoBack
  #G_TB_Effects_EchoBack
  #G_TX_Effects_EchoBackV
  #G_TX_Effects_EchoDelay
  #G_TB_Effects_EchoDelay
  #G_TX_Effects_EchoDelayV
  #G_FR_Effects_Flanger
  #G_CH_Effects_Flanger
  #G_BN_Effects_Default
  #G_BN_Effects_Close
EndEnumeration

Procedure OpenWindow_Effects()
  If IsWindow(#Win_Effects)
    
  Else
    Protected iNext.i
    
    If OpenWindow(#Win_Effects, 0, 0, 400, 320, "Effekte", #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_ScreenCentered)
      PanelGadget(#G_PN_Effects_Categorie, 5, 5, WindowWidth(#Win_Effects) - 10, WindowHeight(#Win_Effects) - 40)
      ; Equalizer
      AddGadgetItem(#G_PN_Effects_Categorie, -1, "Equalizer")
        ; Border
        Frame3DGadget(#G_FR_Effects_Equalizer, 15, 15, 352, 224, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CB_Effects_Equalizer, 21, 21, 150, 20, "Equalizer verwenden")
        ComboBoxGadget(#G_CH_Effects_Equalizer, 212, 21, 150, 20)
        ; Bands
        For iNext = 0 To 9
          TrackBarGadget(#G_TB_Effects_EqualizerBand0 + iNext, 25 + (iNext * 29), 51, 28, 160, 0, 255, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_VERT|#TBS_AUTOTICKS)
          SendMessage_(GadgetID(#G_TB_Effects_EqualizerBand0 + iNext), #TBM_SETTHUMBLENGTH, 13, 0)
          SendMessage_(GadgetID(#G_TB_Effects_EqualizerBand0 + iNext), #TBM_SETTICFREQ, 60, 0)
        Next
        ; Description Bottom
        TextGadget(#G_TX_Effects_Band0, 25, 214, 26, 15, "31", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band1, 54, 214, 26, 15, "63", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band2, 83, 214, 26, 15, "125", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band3, 112, 214, 26, 15, "250", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band4, 141, 214, 26, 15, "500", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band5, 170, 214, 26, 15, "1K", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band6, 199, 214, 26, 15, "2K", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band7, 228, 214, 26, 15, "4K", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band8, 257, 214, 26, 15, "8K", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_Band9, 286, 214, 26, 15, "16K", #SS_CENTERIMAGE|#SS_CENTER)
        ; Description Reight
        TextGadget(#G_TX_Effects_MaxValue, 323, 51, 35, 15, "+15db", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_CenterValue, 323, 124, 35, 15, "0db", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_MinValue, 323, 196, 35, 15, "-15db", #SS_CENTERIMAGE|#SS_CENTER)
      ; Effects
      AddGadgetItem(#G_PN_Effects_Categorie, -1, "Effekte")
        ; System Volume
        Frame3DGadget(#G_FR_Effects_SystemVolume, 15, 15, 352, 22, "", #PB_Frame3D_Flat)
        TextGadget(#G_TX_Effects_SystemVolume, 16, 16, 120, 20, "Systemlautstärke", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_SystemVolume, 136, 16, 180, 20, 0, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_SystemVolume), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_SystemVolumeV, 316, 16, 50, 20, "50%", #SS_CENTER|#SS_CENTERIMAGE)
        ; Speed
        Frame3DGadget(#G_FR_Effects_Speed, 15, 40, 352, 22, "", #PB_Frame3D_Flat)
        TextGadget(#G_TX_Effects_Speed, 16, 41, 120, 20, "Geschwindigkeit", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_Speed, 136, 41, 180, 20, 0, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_Speed), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_SpeedV, 316, 41, 50, 20, "100%", #SS_CENTER|#SS_CENTERIMAGE)
        ; Panel
        Frame3DGadget(#G_FR_Effects_Panel, 15, 65, 352, 22, "", #PB_Frame3D_Flat)
        TextGadget(#G_TX_Effects_Panel, 16, 66, 120, 20, "Ausrichtung", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_Panel, 136, 66, 180, 20, 0, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_Panel), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_PanelV, 316, 66, 50, 20, "Center", #SS_CENTER|#SS_CENTERIMAGE)
        ; Reverb
        Frame3DGadget(#G_FR_Effects_Reverb, 15, 90, 352, 61, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CH_Effects_Reverb, 18, 93, 346, 15, "Reverb")
        TextGadget(#G_TX_Effects_ReverbMix, 16, 110, 120, 20, "Mix", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_ReverbMix, 136, 110, 180, 20, 1, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_ReverbMix), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_ReverbMixV, 316, 110, 50, 20, "100", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_ReverbTime, 16, 130, 120, 20, "Zeit", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_ReverbTime, 136, 130, 180, 20, 1, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_ReverbTime), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_ReverbTimeV, 316, 130, 50, 20, "100", #SS_CENTERIMAGE|#SS_CENTER)
        ; Echo
        Frame3DGadget(#G_FR_Effects_Echo, 15, 154, 352, 61, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CH_Effects_Echo, 18, 157, 346, 15, "Echo")
        TextGadget(#G_TX_Effects_EchoBack, 16, 174, 120, 20, "Effektivität", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_EchoBack, 136, 174, 180, 20, 1, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_EchoBack), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_EchoBackV, 316, 174, 50, 20, "100", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_EchoDelay, 16, 194, 120, 20, "Verzögerung", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_EchoDelay, 136, 194, 180, 20, 1, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_EchoDelay), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_EchoDelayV, 316, 194, 50, 20, "100", #SS_CENTERIMAGE|#SS_CENTER)
        ; Flanger
        Frame3DGadget(#G_FR_Effects_Flanger, 15, 218, 352, 21, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CH_Effects_Flanger, 18, 221, 346, 15, "Flanger")
      CloseGadgetList()
      ; Buttons
      ButtonGadget(#G_BN_Effects_Default, WindowWidth(#Win_Effects) - 170, WindowHeight(#Win_Effects) - 30, 80, 25, "Standard")
      ButtonGadget(#G_BN_Effects_Close, WindowWidth(#Win_Effects) - 85, WindowHeight(#Win_Effects) - 30, 80, 25, "OK")
    Else
      ;MsgBox_Error("Fenster 'Effects' konnte nicht erstellt werden") : End
    EndIf
    
    HideWindow(#Win_Effects, 0)
  EndIf
EndProcedure

OpenWindow_Effects()
While WaitWindowEvent(10) <> #PB_Event_CloseWindow
Wend
; IDE Options = PureBasic 4.40 Beta 2 (Windows - x86)
; CursorPosition = 158
; FirstLine = 113
; Folding = -
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 305
; EnableBuildCount = 0
; EnableExeConstant