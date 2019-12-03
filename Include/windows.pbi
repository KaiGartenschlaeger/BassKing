; Enthällt alle Fensterproceduren zum öffnen und schließen
;
; Letzte Bearbeitung: 28.11.2009

;- Win_Hide
If OpenWindow(#Win_Hide, 0, 0, 0, 0, "", #PB_Window_Invisible|#PB_Window_BorderLess)
  DisableWindow(#Win_Hide, 0)
Else
  MsgBox_Error("Fenster 'MainHide' konnte nicht erstellt werden"): End
EndIf
;- Win_Main
If OpenWindow(#Win_Main, -1, -1, 640, 480, #PrgName, #PB_Window_Invisible|#PB_Window_SizeGadget|#PB_Window_SystemMenu|#PB_Window_MinimizeGadget, WindowID(#Win_Hide))
  ;Menu Playlist
  If CreatePopupImageMenu(#Menu_PlayList)
    MenuItem(#Mnu_PlayList_Play, "Wiedergabe", ImageList(#ImageList_Play))
    MenuBar()
    MenuItem(#Mnu_PlayList_SortMix, "Mischen")
    OpenSubMenu("Sortieren")
      MenuItem(#Mnu_PlayList_SortTitle, "Titel")
      MenuItem(#Mnu_PlayList_SortArtist, "Interpret")
      MenuItem(#Mnu_PlayList_SortAlbum, "Album")
      MenuItem(#Mnu_PlayList_SortTrack, "Nummer")
      MenuItem(#Mnu_PlayList_SortLength, "Länge")
      MenuItem(#Mnu_PlayList_SortYear, "Jahr")
      MenuItem(#Mnu_PlayList_SortType, "Typ")
    CloseSubMenu()
    MenuItem(#Mnu_PlayList_Search, "Suchen", ImageList(#ImageList_Search))
    MenuBar()
    MenuItem(#Mnu_PlayList_OpenFolder, "Ordner öffnen", ImageList(#ImageList_Folder))
    MenuItem(#Mnu_PlayList_Copy, "Kopieren..", ImageList(#ImageList_Copy))
    MenuBar()
    MenuItem(#Mnu_PlayList_Insert, "Einfügen", ImageList(#ImageList_Clipboard))
    OpenSubMenu("Hinzufügen")
      MenuItem(#Mnu_PlayList_AddFile, "Datei", ImageList(#ImageList_File))
      MenuItem(#Mnu_PlayList_AddFolder, "Ordner", ImageList(#ImageList_Folder))
    CloseSubMenu()
    MenuItem(#Mnu_PlayList_Generate, "Generieren", ImageList(#ImageList_PlayList))
    MenuItem(#Mnu_PlayList_SavePlayList, "Playlist speichern", ImageList(#ImageList_Save))
    MenuBar()
    MenuItem(#Mnu_PlayList_SelAll, "Alles auswählen")
    MenuItem(#Mnu_PlayList_Remove, "Entfernen", ImageList(#ImageList_Remove))
    MenuItem(#Mnu_PlayList_RemoveAll, "Alles entfernen", ImageList(#ImageList_Remove))
    MenuBar()
    ;MenuItem(#Mnu_PlayList_AutoTag, "AutoTag", ImageList(#ImageList_Rename))
    MenuItem(#Mnu_PlayList_Refresh, "Aktuallisieren", ImageList(#ImageList_Refresh))
    MenuItem(#Mnu_PlayList_Info, "Informationen", ImageList(#ImageList_TrackInfo))
  Else
    MsgBox_Error("PopUp Menu 'Playlist' konnte nicht erstellt werden"): End
  EndIf
  ;Menu MediaLibary
  If CreatePopupImageMenu(#Menu_MediaLibary)
    MenuItem(#Mnu_MediaLib_Play, "Wiedergabe", ImageList(#ImageList_Play))
    MenuItem(#Mnu_MediaLib_SelectAll, "Alles Auswählen")
    MenuBar()
    OpenSubMenu("Mehr von..")
      MenuItem(#Mnu_MediaLib_MoreAlbum, "Album")
      MenuItem(#Mnu_MediaLib_MoreInterpret, "Interpret")
      MenuItem(#Mnu_MediaLib_MoreGenre, "Genre")
    CloseSubMenu()
    OpenSubMenu("Zuordnen")
      MenuItem(#Mnu_MediaLib_BookmarkAdd, "Lesezeichen", ImageList(#ImageList_Bookmark))
      MenuItem(#Mnu_MediaLib_SetPlayList, "Wiedergabeliste")
    CloseSubMenu()
    OpenSubMenu("Zuordnung Entfernen")
      MenuItem(#Mnu_MediaLib_BookmarkRem, "Lesezeichen")
      MenuItem(#Mnu_MediaLib_RemPlayList, "Wiedergabeliste")
    CloseSubMenu()
    OpenSubMenu("Zurücksetzen")
      MenuItem(#Mnu_MediaLib_ResetPlayCount, "Abgespielt")
      MenuItem(#Mnu_MediaLib_ResetPlayDates, "Erste/Letzte Wiedergabe")
    CloseSubMenu()
    OpenSubMenu("Speichern")
      MenuItem(#Mnu_MediaLib_SaveAsPlayList, "Wiedergabeliste")
    CloseSubMenu()
    OpenSubMenu("Senden an")
      MenuItem(#Mnu_MediaLib_SendPlayList, "Wiedergabeliste", ImageList(#ImageList_PlayList))
      MenuItem(#Mnu_MediaLib_SendPlayListNew, "neuer Wiedergabeliste", ImageList(#ImageList_PlayList))
    CloseSubMenu()
    MenuBar()
    MenuItem(#Mnu_MediaLib_Info, "Informationen", ImageList(#ImageList_TrackInfo))
  Else
    MsgBox_Error("PopUp Menu 'MediaLibary' konnte nicht erstellt werden"): End
  EndIf
  ;Menu MediaLibInet
  If CreatePopupImageMenu(#Menu_MediaLib_Inet)
    MenuItem(#Mnu_MediaLib_Play, "Wiedergabe", ImageList(#ImageList_Play))
    MenuItem(#Mnu_MediaLib_SelectAll, "Alles Auswählen")
    MenuBar()
    MenuItem(#Mnu_MediaLibInet_Add, "Hinzufügen")
    MenuItem(#Mnu_MediaLibInet_Rem, "Entfernen", ImageList(#ImageList_Remove))
    MenuBar()
    MenuItem(#Mnu_MediaLibInet_Info, "Informationen", ImageList(#ImageList_TrackInfo))
  Else
    MsgBox_Error("PopUp Menu 'MediaLib Inet' konnte nicht erstellt werden") : End
  EndIf
  ;Menu Open
  If CreatePopupImageMenu(#Menu_Open)
    MenuItem(#Mnu_Open_File, "Datei", ImageList(#ImageList_File))
    MenuItem(#Mnu_Open_Folder, "Ordner", ImageList(#ImageList_Folder))
  Else
    MsgBox_Error("PopUp Menu 'Open' konnte nicht erstellt werden"): End
  EndIf
  ;Menu SysTray
  If CreatePopupImageMenu(#Menu_SysTray)
    MenuItem(#Mnu_SysTray_Show, "Verstecken", ImageList(#ImageList_ShowHide))
    OpenSubMenu("Fenster")
      MenuItem(#Mnu_SysTray_Pref, "Einstellungen", ImageList(#ImageList_Pref))
      MenuItem(#Mnu_SysTray_Equilizer, "Effekte", ImageList(#ImageList_Equilizer))
      MenuItem(#Mnu_SysTray_Task, "Aufgabe", ImageList(#ImageList_Watch))
      MenuItem(#Mnu_SysTray_Statistics, "Statistiken", ImageList(#ImageList_Statistics))
      MenuItem(#Mnu_SysTray_Log, "Log", ImageList(#ImageList_Search))
      MenuItem(#Mnu_SysTray_RadioLog, "Radio Log", ImageList(#ImageList_PlayList))
    CloseSubMenu()
    MenuItem(#Mnu_SysTray_RecordFolder, "Aufnahme Ordner", ImageList(#ImageList_Folder))
    MenuBar()
    OpenSubMenu("Wiedergabe")
      MenuItem(#Mnu_SysTray_BackTrack, "Vorheriger Titel", ImageList(#ImageList_Back))
      MenuItem(#Mnu_SysTray_Play, "Wiedergabe", ImageList(#ImageList_Play))
      MenuItem(#Mnu_SysTray_Pause, "Pause", ImageList(#ImageList_Pause))
      MenuItem(#Mnu_SysTray_Stop, "Stop", ImageList(#ImageList_Stop))
      MenuItem(#Mnu_SysTray_NextTrack, "Nächster Titel", ImageList(#ImageList_Next))
    CloseSubMenu()
    MenuBar()
    MenuItem(#Mnu_SysTray_Update, "Neue Version", ImageList(#ImageList_AddURL))
    MenuItem(#Mnu_SysTray_Website, "Webseite", ImageList(#ImageList_Website))
    MenuItem(#Mnu_SysTray_Feedback, "Feedback", ImageList(#ImageList_Feedback))
    MenuBar()
    MenuItem(#Mnu_SysTray_Help, "Hilfe", ImageList(#ImageList_Help))
    MenuItem(#Mnu_SysTray_About, "Informationen", ImageList(#ImageList_About))
    MenuBar()
    MenuItem(#Mnu_SysTray_End, "Beenden", ImageList(#ImageList_End))
  Else
    MsgBox_Error("Menu 'SysTray' konnte nicht erstellt werden"): End
  EndIf
  ;Menu ListIconGadget
  If CreatePopupMenu(#Menu_ListIconGadget)
    MenuItem(#Mnu_ListIconGadget_AlignL, "Linksbündig")
    MenuItem(#Mnu_ListIconGadget_AlignC, "Zentriert")
    MenuItem(#Mnu_ListIconGadget_AlignR, "Rechtsbündig")
    MenuBar()
    MenuItem(#Mnu_ListIconGadget_OptimizeWidth, "Optimale Breite")
    MenuItem(#Mnu_ListIconGadget_Width, "Breite")
  Else
    MsgBox_Error("Menu 'ListIconGadget' konnte nicht erstellt werden"): End
  EndIf
  ;Menu Position
  If CreatePopupMenu(#Menu_Position)
    MenuItem(#Mnu_Pos_Save, "Position Speichern")
    MenuItem(#Mnu_Pos_Load, "Position Öffnen")
    MenuItem(#Mnu_Pos_Remove, "Position Entfernen")
    MenuBar()
    MenuItem(#Mnu_Pos_Clear, "Alle Positionen Zurücksetzen")
  Else
    MsgBox_Error("Menu 'Position' konnte nicht erstellt werden"): End
  EndIf
  ;Menu Volume
  If CreatePopupMenu(#Menu_Volume)
    MenuItem(#Mnu_Volume_Low, "Leise")
    MenuItem(#Mnu_Volume_Midle, "Mittel")
    MenuItem(#Mnu_Volume_Loud, "Laut")
  Else
    MsgBox_Error("Menu 'Volume' konnte nicht erstellt werden"): End
  EndIf
  ;Menu RadioLog
  If CreatePopupMenu(#Menu_RadioLog)
    MenuItem(#Mnu_RadioLog_Save, "Speichern")
    MenuItem(#Mnu_RadioLog_Clear, "Leeren")
  Else
    MsgBox_Error("Menu 'RadioLog' konnte nicht erstellt werden"): End
  EndIf
  ;Menu Log
  If CreatePopupMenu(#Menu_Log)
    MenuItem(#Mnu_Log_Copy, "Kopieren")
    MenuItem(#Mnu_Log_Save, "Speichern")
    MenuItem(#Mnu_Log_Clear, "Leeren")
  Else
    MsgBox_Error("Menu 'Log' konnte nicht erstellt werden"): End
  EndIf
  If CreatePopupMenu(#Menu_MidiLyrics)
    MenuItem(#Mnu_MidiLyrics_Copy, "Kopieren")
    MenuItem(#Mnu_MidiLyrics_Save, "Speichern")
  Else
    MsgBox_Error("Menu 'MidiLyrics' konnte nicht erstellt werden"): End
  EndIf
  ;Menu RunPlugins
  If CreatePopupMenu(#Menu_RunPlugins)
    MenuItem(#Mnu_RunPlugins_Run, "Ausführen")
  Else
    MsgBox_Error("Menu 'RunPlugins' konnte nicht erstellt werden"): End
  EndIf
  ;Menu RegPlugins
  If CreatePopupMenu(#Menu_RegPlugins)
    MenuItem(#Mnu_RegPlugins_Preferences, "Einstellungen")
    MenuItem(#Mnu_RegPlugins_End, "Beenden")
  Else
    MsgBox_Error("Menu 'RegPlugins' konnte nicht erstellt werden")
  EndIf
  ;StatuBbar
  If CreateStatusBar(#Statusbar_Main, WindowID(#Win_Main))
    AddStatusBarField(180)        ; #SBField_PlayList
    AddStatusBarField(180)        ; #SBField_MediaLibary
    AddStatusBarField(120)        ; #SBField_MediaLibCount
    AddStatusBarField(25)         ; #SBField_Worker
    AddStatusBarField(#PB_Ignore) ; #SBField_Process
  Else
    MsgBox_Error("Statusbar 'Main' konnte nicht erstellt werden") : End
  EndIf
  ;Toolbar1
  If CreateToolBar(#Toolbar_Main1, WindowID(#Win_Main))
    SendMessage_(ToolBarID(#Toolbar_Main1), #TB_SETSTYLE, 0,  SendMessage_(ToolBarID(#Toolbar_Main1), #TB_GETSTYLE, 0, 0) | #CCS_NODIVIDER)
    SendMessage_(ToolBarID(#Toolbar_Main1), #TB_SETEXTENDEDSTYLE, 0, SendMessage_(ToolBarID(#Toolbar_Main1), #TB_GETEXTENDEDSTYLE, 0, 0) | #TBSTYLE_EX_DRAWDDARROWS)
    SendMessage_(ToolBarID(#Toolbar_Main1), #TB_SETIMAGELIST, #Null, iImagelist)
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Previous, -1, #ImageList_Back)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Previous, "Vorheriger Titel")
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Play, -1, #ImageList_Play)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Play, "Wiedergabe")
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Pause, -1, #ImageList_Pause)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Pause, "Pause")
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Stop, -1, #ImageList_Stop)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Stop, "Stop")
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Next, -1, #ImageList_Next)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Next, "Nächster Titel")
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Record, -1, #ImageList_RecordOff)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Record, "Radio Aufnahme")
    Toolbar_Seperator(#Toolbar_Main1, -1)
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Open, -1, #ImageList_Add, #BTNS_BUTTON|#BTNS_DROPDOWN)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Open, "Zur Wiedergabeliste hinzufügen")
    Toolbar_Seperator(#Toolbar_Main1, -1)
    Toolbar_Button(#Toolbar_Main1, #Mnu_Main_TB1_Volume, -1, #ImageList_Volume1)
    ToolBarToolTip(#Toolbar_Main1, #Mnu_Main_TB1_Volume, "Stumm")
  Else
    MsgBox_Error("Toolbar 'Main 1' konnte nicht erstellt werden"): End
  EndIf
  ;Toolbar2
  If CreateToolBar(#Toolbar_Main2, WindowID(#Win_Main))
    SetWindowLong_(ToolBarID(#Toolbar_Main2), #GWL_STYLE, GetWindowLong_(ToolBarID(#Toolbar_Main2), #GWL_STYLE)|#CCS_NODIVIDER)
    SendMessage_(ToolBarID(#Toolbar_Main2), #TB_SETIMAGELIST, #Null, iImagelist)
    Toolbar_Button(#Toolbar_Main2, #Mnu_Main_TB2_Equilizer, -1, #ImageList_Equilizer)
    ToolBarToolTip(#Toolbar_Main2, #Mnu_Main_TB2_Equilizer, "Effekte")
    Toolbar_Seperator(#Toolbar_Main2, -1)
    Toolbar_Button(#Toolbar_Main2, #Mnu_Main_TB2_Repeat, -1, #ImageList_Repeat, #TBSTYLE_CHECK)
    ToolBarToolTip(#Toolbar_Main2, #Mnu_Main_TB2_Repeat, "Wiedergabe wiederholen")
    Toolbar_Button(#Toolbar_Main2, #Mnu_Main_TB2_Random, -1, #ImageList_Random, #TBSTYLE_CHECK)
    ToolBarToolTip(#Toolbar_Main2, #Mnu_Main_TB2_Random, "Zufällige Wiedergabe")
    Toolbar_Button(#Toolbar_Main2, #Mnu_Main_TB2_Preview, -1, #ImageList_Preview, #TBSTYLE_CHECK)
    ToolBarToolTip(#Toolbar_Main2, #Mnu_Main_TB2_Preview, "Vorschaumodus")
    Toolbar_Seperator(#Toolbar_Main2, -1)
    Toolbar_Button(#Toolbar_Main2, #Mnu_Main_TB2_PlayList, -1, #ImageList_PlayList)
    ToolBarToolTip(#Toolbar_Main2, #Mnu_Main_TB2_PlayList, "Wiedergabeliste")
    Toolbar_Button(#Toolbar_Main2, #Mnu_Main_TB2_MediaLib, -1, #ImageList_MediaLib)
    ToolBarToolTip(#Toolbar_Main2, #Mnu_Main_TB2_MediaLib, "Medienbibliothek")
  Else
    MsgBox_Error("Toolbar 'Main 2' konnte nicht erstellt werden"): End
  EndIf
  ;InfoArea
  ContainerGadget(#G_CN_Main_IA_Background, 0, 0, WindowWidth(#Win_Main), 85, #PB_Container_BorderLess)
    TextGadget(#G_TX_Main_IA_InfoDesc1, 5, 5, 50, 15, "", #PB_Text_Right|#SS_NOTIFY)
    TextGadget(#G_TX_Main_IA_InfoCont1, 60, 5, 150, 15, "", #SS_NOPREFIX)
    TextGadget(#G_TX_Main_IA_InfoDesc2, 5, 20, 50, 15, "", #PB_Text_Right)
    TextGadget(#G_TX_Main_IA_InfoCont2, 60, 20, 150, 15, "", #SS_NOPREFIX)
    TextGadget(#G_TX_Main_IA_InfoDesc3, 5, 35, 50, 15, "", #PB_Text_Right)
    TextGadget(#G_TX_Main_IA_InfoCont3, 60, 35, 150, 15, "", #SS_NOPREFIX)
    TextGadget(#G_TX_Main_IA_InfoDesc4, 5, 50, 50, 15, "", #PB_Text_Right)
    TextGadget(#G_TX_Main_IA_InfoCont4, 60, 50, 150, 15, "", #SS_NOPREFIX)
    TextGadget(#G_TX_Main_IA_Length, 5, 65, 50, 15, "", #PB_Text_Right)
    TextGadget(#G_TX_Main_IA_LengthC, 60, 65, 150, 15, "", #SS_NOPREFIX)
    ImageGadget(#G_IG_Main_IA_PrgLogo, WindowWidth(#Win_Main) - 60, 28, 48, 48, iImgInfologo)
    ImageGadget(#G_IG_Main_IA_Spectrum, WindowWidth(#Win_Main) - 210, 18, 0, 0, 0)
  CloseGadgetList()
  Frame3DGadget(#G_FR_Main_IA_Gap, -5, GadgetHeight(#G_CN_Main_IA_Background), WindowWidth(#Win_Main) + 10, 2, "", #PB_Frame3D_Single)
  TrackBarGadget(#G_TB_Main_IA_Position, 0, GadgetHeight(#G_CN_Main_IA_Background) + GadgetHeight(#G_FR_Main_IA_Gap), WindowWidth(#Win_Main), 20, 0, #MaxPos, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
    SendMessage_(GadgetID(#G_TB_Main_IA_Position), #TBM_SETTHUMBLENGTH, 18, 0)
  ;Toolbar SetParents
  ContainerGadget(#G_CN_Main_IA_ToolbarLeft, 2, GadgetHeight(#G_CN_Main_IA_Background) + GadgetHeight(#G_FR_Main_IA_Gap) + GadgetHeight(#G_TB_Main_IA_Position) + 2, Toolbar_GetWidth(#Toolbar_Main1), Toolbar_GetHeight(#Toolbar_Main1), #PB_Container_BorderLess)
    SetParent_(ToolBarID(#Toolbar_Main1), GadgetID(#G_CN_Main_IA_ToolbarLeft))
  CloseGadgetList()
  TrackBarGadget(#G_TB_Main_IA_Volume, 2 + GadgetWidth(#G_CN_Main_IA_ToolbarLeft), GadgetY(#G_CN_Main_IA_ToolbarLeft), 100, GadgetHeight(#G_CN_Main_IA_ToolbarLeft), 0, 100, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
    SendMessage_(GadgetID(#G_TB_Main_IA_Volume), #TBM_SETTHUMBLENGTH, 15, 0)
  GadgetToolTip(#G_TB_Main_IA_Volume, "Lautstärke")
  ContainerGadget(#G_CN_Main_IA_ToolbarRight, 2 + GadgetWidth(#G_CN_Main_IA_ToolbarLeft) + GadgetWidth(#G_TB_Main_IA_Volume), GadgetY(#G_CN_Main_IA_ToolbarLeft), Toolbar_GetWidth(#Toolbar_Main2), Toolbar_GetHeight(#Toolbar_Main2), #PB_Container_BorderLess)
    SetParent_(ToolBarID(#Toolbar_Main2), GadgetID(#G_CN_Main_IA_ToolbarRight))
  CloseGadgetList()
  ;SecondArea
  Global iMain_SAStartY.i = GadgetY(#G_CN_Main_IA_ToolbarLeft) + GadgetHeight(#G_CN_Main_IA_ToolbarLeft) + 5
  ;Playlist
  ListIconGadget(#G_LI_Main_PL_PlayList, 2, iMain_SAStartY, 436, 180, "", 0, #PB_ListIcon_FullRowSelect|#PB_ListIcon_MultiSelect|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_HeaderDragDrop)
    AddGadgetColumn(#G_LI_Main_PL_PlayList, 1, "Titel", 150)
    AddGadgetColumn(#G_LI_Main_PL_PlayList, 2, "Interpret", 100)
    AddGadgetColumn(#G_LI_Main_PL_PlayList, 3, "Album", 80)
    AddGadgetColumn(#G_LI_Main_PL_PlayList, 4, "Nummer", 80)
    AddGadgetColumn(#G_LI_Main_PL_PlayList, 5, "Länge", 80)
    AddGadgetColumn(#G_LI_Main_PL_PlayList, 6, "Jahr", 80)
    AddGadgetColumn(#G_LI_Main_PL_PlayList, 7, "Typ", 80)
    SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_SETEXTENDEDLISTVIEWSTYLE, 0, SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)|#LVS_EX_LABELTIP)
    HideGadget(#G_LI_Main_PL_PlayList, 1)
  ;MediaLibary
  ComboBoxGadget(#G_SR_Main_ML_Search, 2, iMain_SAStartY, 312, 20, #PB_ComboBox_Editable)
    HideGadget(#G_SR_Main_ML_Search, 1)
  ButtonGadget(#G_BN_Main_ML_Search, 383, iMain_SAStartY, 80, 20, "Suchen")
    HideGadget(#G_BN_Main_ML_Search, 1)
  ButtonImageGadget(#G_BN_Main_ML_SearchOptions, 286, iMain_SAStartY, 50, 20, ImageList(#ImageList_SearchS))
    GadgetToolTip(#G_BN_Main_ML_SearchOptions, "Erweiterte Suche")
  HideGadget(#G_BN_Main_ML_SearchOptions, 1)
  ListIconGadget(#G_LI_Main_ML_MediaLib, 2, iMain_SAStartY + 22, 320, 202, "", 0, #PB_ListIcon_FullRowSelect|#PB_ListIcon_MultiSelect|#LVS_NOSORTHEADER|#PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_HeaderDragDrop)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 1, "Titel", 250)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 2, "Interpret", 100)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 3, "Album", 80)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 4, "Nummer", 80)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 5, "Länge", 100)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 6, "Jahr", 80)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 7, "Abgespielt", 80)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 8, "Erste Wiedergabe", 100)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 9, "Letzte Wiedergabe", 100)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 10, "Bewertung", 80)
    AddGadgetColumn(#G_LI_Main_ML_MediaLib, 11, "Typ", 80)
    SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_SETEXTENDEDLISTVIEWSTYLE, 0, SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)|#LVS_EX_LABELTIP)
  ListViewGadget(#G_LV_Main_ML_Category, 324, iMain_SAStartY + 22, 114, 100)
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Datenbank")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Am meisten abgespielt")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Zuletzt abgespielt")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Noch nie abgespielt")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Längste Tracks")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Zuletzt hinzugefügt")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Bewertung")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Lesezeichen")
    AddGadgetItem(#G_LV_Main_ML_Category, -1, "Internet Stream")
  ContainerGadget(#G_CN_Main_ML_Misc, 0, 0, 0, 0, #PB_Container_BorderLess)
    ComboBoxGadget(#G_CB_Main_ML_MiscType, 0, 0, GadgetWidth(#G_CN_Main_ML_Misc), 20)
      AddGadgetItem(#G_CB_Main_ML_MiscType, -1, "Album")
      AddGadgetItem(#G_CB_Main_ML_MiscType, -1, "Interpret")
      AddGadgetItem(#G_CB_Main_ML_MiscType, -1, "Genre")
      AddGadgetItem(#G_CB_Main_ML_MiscType, -1, "Wiedergabeliste")
      SetGadgetState(#G_CB_Main_ML_MiscType, 0)
    ListIconGadget(#G_LI_Main_ML_Misc, 0, 25, GadgetWidth(#G_CN_Main_ML_Misc), GadgetHeight(#G_CN_Main_ML_Misc) - 25, "Album", 120, #LVS_NOCOLUMNHEADER|#PB_ListIcon_AlwaysShowSelection)
      SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #LVM_SETEXTENDEDLISTVIEWSTYLE, 0, SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)|#LVS_EX_LABELTIP)
  CloseGadgetList()
  SplitterGadget(#G_SP_Main_ML_Vertical, 324, iMain_SAStartY + 22, 114, 200, #G_LV_Main_ML_Category, #G_CN_Main_ML_Misc, #PB_Splitter_FirstFixed|#PB_Splitter_SecondFixed)
    SetGadgetAttribute(#G_SP_Main_ML_Vertical, #PB_Splitter_FirstMinimumSize, 50)
    SetGadgetAttribute(#G_SP_Main_ML_Vertical, #PB_Splitter_SecondMinimumSize, 50)
  SplitterGadget(#G_SP_Main_ML_Horizontal, 2, iMain_SAStartY + GadgetHeight(#G_SR_Main_ML_Search) + 2, WindowWidth(#Win_Main) - 4, 200, #G_LI_Main_ML_MediaLib, #G_SP_Main_ML_Vertical, #PB_Splitter_Vertical|#PB_Splitter_FirstFixed|#PB_Splitter_SecondFixed)
    SetGadgetAttribute(#G_SP_Main_ML_Horizontal, #PB_Splitter_FirstMinimumSize, 450)
    SetGadgetAttribute(#G_SP_Main_ML_Horizontal, #PB_Splitter_SecondMinimumSize, 140)
    HideGadget(#G_SP_Main_ML_Horizontal, 1)
  
  iWinW_Main_SecondMin = Window_GetWidth(#Win_Main)
  iWinH_Main_SecondMin = Window_GetHeight(#Win_Main)
  
  ResizeWindow(#Win_Main, #PB_Ignore, #PB_Ignore, 2 + GadgetWidth(#G_CN_Main_IA_ToolbarLeft) + GadgetWidth(#G_TB_Main_IA_Volume) + GadgetWidth(#G_CN_Main_IA_ToolbarRight) + 2, GadgetHeight(#G_CN_Main_IA_Background) + GadgetHeight(#G_FR_Main_IA_Gap) + GadgetHeight(#G_TB_Main_IA_Position) + 2 + GadgetHeight(#G_CN_Main_IA_ToolbarLeft) + 2)
  
  iWinW_Main_NormalMin = WindowWidth(#Win_Main)
  
  WndEx_AddWindow(#Win_Main, #WndEx_Magnetic_Desktop|#WndEx_Magnetic_Window|#WndEx_Moveable)
  
  SmartWindowRefresh(#Win_Main, 1)
  
  WinSize(#Win_Main)\winid = WindowID(#Win_Main)
Else
  MsgBox_Error("Fenster 'Main' konnte nicht erstellt werden"): End
EndIf

Procedure OpenWindow_Preferences()
  If IsWindow(#Win_Preferences)
    HideWindow(#Win_Preferences, 0)
    SetActiveWindow(#Win_Preferences)
  Else
    If OpenWindow(#Win_Preferences, 0, 0, 460, 340, "Einstellungen", #PB_Window_Invisible|#PB_Window_SystemMenu, WindowID(#Win_Main))
      TreeGadget(#G_LV_Preferences_Menu, 5, 5, 120, 295, #PB_Tree_NoButtons|#PB_Tree_NoLines|#PB_Tree_AlwaysShowSelection)
      Frame3DGadget(#G_FR_Preferences_Seperator, -5, 305, 475, 2, "", #PB_Frame3D_Single)
      ButtonGadget(#G_BN_Preferences_Reset, 120, 310, 80, 25, "Zurücksetzen")
      ButtonGadget(#G_BN_Preferences_Use, 205, 310, 80, 25, "Übernehmen")
      ButtonGadget(#G_BN_Preferences_Apply, 290, 310, 80, 25, "OK")
      ButtonGadget(#G_BN_Preferences_Cancel, 375, 310, 80, 25, "Abbrechen")
      TextGadget(#G_TX_Preferences_Title, 130, 5, 325, 25, "", #SS_CENTERIMAGE|#SS_LEFTNOWORDWRAP|#SS_SUNKEN)
      ;Bass
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Bass")
      ScrollAreaGadget(#G_SA_Preferences_Bass, 130, 35, 325, 265, 0, 315, 15, #PB_ScrollArea_Single)
        SetGadgetAttribute(#G_SA_Preferences_Bass, #PB_ScrollArea_InnerWidth, Window_GetClientWidth(GadgetID(#G_SA_Preferences_Bass)) - GetSystemMetrics_(#SM_CXHTHUMB) - 5)
        ; Output
        TextGadget(#G_TX_Preferences_Bass_OutputDevice, 5, 5, 200, 15, "Ausgabe Gerät")
        ComboBoxGadget(#G_CB_Preferences_Bass_OutputDevice, 5, 20, 200, 20)
        TextGadget(#G_TX_Preferences_Bass_OutputRate, 5, 45, 200, 15, "Ausgabe Rate")
        ComboBoxGadget(#G_CB_Preferences_Bass_OutputRate, 5, 60, 200, 20)
          AddGadgetItem(#G_CB_Preferences_Bass_OutputRate, -1, "48000 Hz")
          AddGadgetItem(#G_CB_Preferences_Bass_OutputRate, -1, "44100 Hz")
          AddGadgetItem(#G_CB_Preferences_Bass_OutputRate, -1, "22050 Hz")
          AddGadgetItem(#G_CB_Preferences_Bass_OutputRate, -1, "11025 Hz")
          AddGadgetItem(#G_CB_Preferences_Bass_OutputRate, -1, "8000 Hz")
        ; Fading
        TextGadget(#G_TX_Preferences_Bass_FadeIn, 5, 90, 180, 15, "Einblenden")
        TrackBarGadget(#G_TB_Preferences_Bass_FadeIn, 5, 105, 180, 20, 0, 10, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          SendMessage_(GadgetID(#G_TB_Preferences_Bass_FadeIn), #TBM_SETTHUMBLENGTH, 15, 0)
          GadgetToolTip(#G_TB_Preferences_Bass_FadeIn, "Wiedergabe Einblendzeit")
        TextGadget(#G_TX_Preferences_Bass_FadeOut, 5, 125, 180, 15, "Ausblenden")
        TrackBarGadget(#G_TB_Preferences_Bass_FadeOut, 5, 140, 180, 20, 0, 10, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          SendMessage_(GadgetID(#G_TB_Preferences_Bass_FadeOut), #TBM_SETTHUMBLENGTH, 15, 0)
          GadgetToolTip(#G_TB_Preferences_Bass_FadeOut, "Wiedergabe Ausblendzeit")
        TextGadget(#G_TX_Preferences_Bass_FadeOutEnd, 5, 165, 180, 15, "Ausblenden Beenden")
        TrackBarGadget(#G_TB_Preferences_Bass_FadeOutEnd, 5, 180, 180, 20, 0, 10, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          SendMessage_(GadgetID(#G_TB_Preferences_Bass_FadeOutEnd), #TBM_SETTHUMBLENGTH, 15, 0)
          GadgetToolTip(#G_TB_Preferences_Bass_FadeOutEnd, "Wiedergabe Ausblendzeit beim Beenden")
        ; Midi Soundfont
        TextGadget(#G_TX_Preferences_Bass_MidiSF2File, 5, 205, 180, 15, "Midi Sound Font (SF2)")
        StringGadget(#G_SR_Preferences_Bass_MidiSF2File, 5, 220, 180, 20, "", #PB_String_ReadOnly)
          SetGadgetColor(#G_SR_Preferences_Bass_MidiSF2File, #PB_Gadget_BackColor, GetSysColor_(#COLOR_WINDOW))
          SetGadgetColor(#G_SR_Preferences_Bass_MidiSF2File, #PB_Gadget_FrontColor, GetSysColor_(#COLOR_WINDOWTEXT))
        ButtonGadget(#G_BN_Preferences_Bass_MidiSF2File, 190, 220, 25, 20, "...")
          GadgetToolTip(#G_BN_Preferences_Bass_MidiSF2File, "Datei Suchen")
        ; Midi Lyrics
        CheckBoxGadget(#G_CH_Preferences_Bass_MidiLyrics, 5, 250, 180, 15, "MidiLyrics Öffnen")
          GadgetToolTip(#G_CH_Preferences_Bass_MidiLyrics, "Öffnet das Midi Lyrics Fenster sobald eine Midi-Datei mit Lyric-Inhalten abgespielt wird.")
        ; Preview Modus
        TextGadget(#G_TX_Preferences_Bass_PreviewTime, 5, 275, 180, 15, "Vorschaumodus (" + Str(Pref\bass_preview) + "%)")
        TrackBarGadget(#G_TB_Preferences_Bass_PreviewTime, 5, 290, 180, 20, 5, 50, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          SendMessage_(GadgetID(#G_TB_Preferences_Bass_PreviewTime), #TBM_SETTHUMBLENGTH, 15, 0)
          GadgetToolTip(#G_TB_Preferences_Bass_PreviewTime, "Gibt an wie viel Prozent des Tracks im Vorschaumodus abgespielt wird.")
      CloseGadgetList()
      ;InternetStreaming
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Internet Radio")
      ScrollAreaGadget(#G_SA_Preferences_InetStream, 130, 35, 325, 265, 0, 275, 10, #PB_ScrollArea_Single)
        SetGadgetAttribute(#G_SA_Preferences_InetStream, #PB_ScrollArea_InnerWidth, Window_GetClientWidth(GadgetID(#G_SA_Preferences_InetStream)) - GetSystemMetrics_(#SM_CXHTHUMB) - 5)
        ; Wiedergabe Speichern
        CheckBoxGadget(#G_CH_Preferences_InetStream_SaveFile, 5, 5, 180, 15, "Wiedergabe Speichern")
          GadgetToolTip(#G_CH_Preferences_InetStream_SaveFile, "Aktueller Titel wird als MP3 im Ziel-Ordner gespeichert")
        ; Speicher-Ordner
        TextGadget(#G_TX_Preferences_InetStream_FilePath, 5, 30, 180, 15, "Ziel-Ordner")
        StringGadget(#G_SR_Preferences_InetStream_FilePath, 5, 45, 180, 20, "", #PB_String_ReadOnly)
          SetGadgetColor(#G_SR_Preferences_InetStream_FilePath, #PB_Gadget_BackColor, GetSysColor_(#COLOR_WINDOW))
          SetGadgetColor(#G_SR_Preferences_InetStream_FilePath, #PB_Gadget_FrontColor, GetSysColor_(#COLOR_WINDOWTEXT))
        ButtonGadget(#G_BN_Preferences_InetStream_FilePath, 187, 45, 25, 20, "...")
          GadgetToolTip(#G_BN_Preferences_InetStream_FilePath, "Ordner Suchen")
        ; Speicher-Name
        Frame3DGadget(#G_FR_Preferences_InetStream_FileName, 5, 75, 150, 60, "Datei-Name")
        OptionGadget(#G_OP_Preferences_InetStream_Full, 15, 95, 120, 15, "Radioname")
          GadgetToolTip(#G_OP_Preferences_InetStream_Full, "Benutzt als Speichername denn Name des Internetsenders")
        OptionGadget(#G_OP_Preferences_InetStream_Title, 15, 110, 120, 15, "Interpret/Titel")
          GadgetToolTip(#G_OP_Preferences_InetStream_Title, "Benutzt als Speichername denn aktuellen Titel/Interpret")
        ; TimeOut
        TextGadget(#G_TX_Preferences_InetStream_TimeOut, 5, 145, 180, 15, "TimeOut (Sekunden)")
        TrackBarGadget(#G_TB_Preferences_InetStream_TimeOut, 5, 160, 180, 20, 1, 25, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          SendMessage_(GadgetID(#G_TB_Preferences_InetStream_TimeOut), #TBM_SETTHUMBLENGTH, 15, 0)
        ; Buffer
        TextGadget(#G_TX_Preferences_InetStream_Buffer, 5, 190, 180, 15, "Buffer (Sekunden)")
        TrackBarGadget(#G_TB_Preferences_InetStream_Buffer, 5, 205, 180, 20, 5, 25, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          SendMessage_(GadgetID(#G_TB_Preferences_InetStream_Buffer), #TBM_SETTHUMBLENGTH, 15, 0)
        ; Proxy-Server
        TextGadget(#G_TX_Preferences_InetStream_ProxyServer, 5, 235, 250, 15, "Proxyserver [user:pass@server:port]")
        StringGadget(#G_SR_Preferences_InetStream_ProxyServer, 5, 250, 250, 20, "")
      CloseGadgetList()
      ;Oberfläche
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Oberfläche")
      ContainerGadget(#G_CN_Preferences_GUI, 130, 35, 325, 265)
        PanelGadget(#G_PN_Preferences_GUI_Sub, 0, 0, GadgetWidth(#G_CN_Preferences_GUI), GadgetHeight(#G_CN_Preferences_GUI))
          ; Fenster
          AddGadgetItem(#G_PN_Preferences_GUI_Sub, -1, "Fenster")
            CheckBoxGadget(#G_CH_Preferences_GUI_AlwaysOnTop, 5, 5, 180, 15, "Immer im Vordergrund")
              GadgetToolTip(#G_CH_Preferences_GUI_AlwaysOnTop, "Fenster befinden sich immer im Vordergrund")
            CheckBoxGadget(#G_CH_Preferences_GUI_Opacity, 5, 22, 180, 15, "Transparenz")
              GadgetToolTip(#G_CH_Preferences_GUI_Opacity, "Fenster werden transparent dargestellt")
            TrackBarGadget(#G_TB_Preferences_GUI_OpacityValue, 5, 39, 180, 20, #MinOpacity, #MaxOpacity, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
              SendMessage_(GadgetID(#G_TB_Preferences_GUI_OpacityValue), #TBM_SETTHUMBLENGTH, 15, 0)
              GadgetToolTip(#G_TB_Preferences_GUI_OpacityValue, "Regelt die Stärke der Transparenz")
            CheckBoxGadget(#G_CH_Preferences_GUI_Magnetic, 5, 61, 180, 15, "Magnetische Fenster")
              GadgetToolTip(#G_CH_Preferences_GUI_Magnetic, "Fenster werden magnetisch angezogen")
            TrackBarGadget(#G_TB_Preferences_GUI_MagneticValue, 5, 78, 180, 20, 6, 36, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
              SendMessage_(GadgetID(#G_TB_Preferences_GUI_MagneticValue), #TBM_SETTHUMBLENGTH, 15, 0)
              GadgetToolTip(#G_TB_Preferences_GUI_MagneticValue, "Bestimmt die Anziehkraft")
              SendMessage_(GadgetID(#G_TB_Preferences_GUI_MagneticValue), #TBM_SETTICFREQ, 3, #Null)
            CheckBoxGadget(#G_CH_Preferences_GUI_AutoColumnPL, 5, 124, 180, 15, "Spaltenbreite Wiedergabeliste")
              GadgetToolTip(#G_CH_Preferences_GUI_AutoColumnPL, "Passt die Spaltenbreiten der Wiedergabeliste automatisch an")
            CheckBoxGadget(#G_CH_Preferences_GUI_AutoColumnML, 5, 141, 180, 15, "Spaltenbreite Medienbibliothek")
              GadgetToolTip(#G_CH_Preferences_GUI_AutoColumnML, "Passt die Spaltenbreiten der Medienbibliothek automatisch an")
          ; Infobereich
          AddGadgetItem(#G_PN_Preferences_GUI_Sub, -1, "Infobereich")
            TextGadget(#G_TX_Preferences_GUI_LengthFormat, 5, 5, 180, 15, "Längenformat")
            ComboBoxGadget(#G_CB_Preferences_GUI_LengthFormat, 5, 20, 180, 20, #PB_ComboBox_Editable)
              GadgetToolTip(#G_CB_Preferences_GUI_LengthFormat, "Musterstring: %ptime, %ltime, %ftime, %ppercent, %lpercent")
              AddGadgetItem(#G_CB_Preferences_GUI_LengthFormat, -1, "%ptime")
              AddGadgetItem(#G_CB_Preferences_GUI_LengthFormat, -1, "%ltime")
              AddGadgetItem(#G_CB_Preferences_GUI_LengthFormat, -1, "%ptime / %ftime")
              AddGadgetItem(#G_CB_Preferences_GUI_LengthFormat, -1, "%ptime - %ppercent")
            TextGadget(#G_TX_Preferences_GUI_SpectrumType, 5, 45, 180, 15, "Spektrum Typ")
            ComboBoxGadget(#G_CB_Preferences_GUI_SpectrumType, 5, 60, 180, 20)
              AddGadgetItem(#G_CB_Preferences_GUI_SpectrumType, -1, "Aus")
              AddGadgetItem(#G_CB_Preferences_GUI_SpectrumType, -1, "Linear")
              AddGadgetItem(#G_CB_Preferences_GUI_SpectrumType, -1, "Waveform")
          ; Medienbibliothek
          AddGadgetItem(#G_PN_Preferences_GUI_Sub, -1, "Medienbibliothek")
            CheckBoxGadget(#G_CH_Preferences_GUI_AutoComplete, 5, 5, 180, 15, "Automatische Vervollständigung")
              GadgetToolTip(#G_CH_Preferences_GUI_AutoComplete, "Beim Medienbibliothek-Suchfeld wird ein Automatische-Vervollständigen Algorithums angewendet")
          ; Farbthemen
          AddGadgetItem(#G_PN_Preferences_GUI_Sub, -1, "Farben")
            ListIconGadget(#G_LI_Preferences_GUI_Layout, 2, 2, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel3D_ItemWidth) - 4, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel3D_ItemHeight) - 31, "Bereich", 220, #LVS_NOSORTHEADER|#PB_ListIcon_FullRowSelect)
              AddGadgetColumn(#G_LI_Preferences_GUI_Layout, 1, "Farbe", 80)
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Trackinfo Hintergrund")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Trackinfo Text")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Spektrum Hintergrund")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Spektrum Vordergrund")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Auswahl Hintergrund")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Auswahl Text")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "MidiLyrics Hintergrund")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "MidiLyrics Text")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Tracker Hintergrund")
              AddGadgetItem(#G_LI_Preferences_GUI_Layout, -1, "Tracker Text")
              SetGadgetItemAttribute(#G_LI_Preferences_GUI_Layout, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Preferences_GUI_Layout)) - GetGadgetItemAttribute(#G_LI_Preferences_GUI_Layout, -1, #PB_ListIcon_ColumnWidth, 0), 1)
            ComboBoxGadget(#G_CB_Preferences_GUI_LayoutTheme, 2, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel_ItemHeight) - 25, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel_ItemWidth) - 86, 20)
            ButtonGadget(#G_BN_Preferences_GUI_LayoutThemeSave, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel_ItemWidth) - 82, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel_ItemHeight) - 27, 80, 25, "Speichern")
          ; Fonts
          AddGadgetItem(#G_PN_Preferences_GUI_Sub, -1, "Fonts")
            ListIconGadget(#G_LI_Preferences_GUI_FontsOverview, 2, 2, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel_ItemWidth) - 4, GetGadgetAttribute(#G_PN_Preferences_GUI_Sub, #PB_Panel_ItemHeight) - 4, "Bereich", 120, #PB_ListIcon_FullRowSelect|#PB_ListIcon_CheckBoxes|#LVS_NOSORTHEADER)
              AddGadgetColumn(#G_LI_Preferences_GUI_FontsOverview, 1, "Font", 100)
              AddGadgetColumn(#G_LI_Preferences_GUI_FontsOverview, 2, "Größe", 80)
              For iNext = 0 To ArraySize(GUIFont())
                AddGadgetItem(#G_LI_Preferences_GUI_FontsOverview, -1, GUIFont(iNext)\desc)
              Next
              SetGadgetItemAttribute(#G_LI_Preferences_GUI_FontsOverview, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Preferences_GUI_FontsOverview)) - GetGadgetItemAttribute(#G_LI_Preferences_GUI_FontsOverview, -1, #PB_ListIcon_ColumnWidth, 1) - GetGadgetItemAttribute(#G_LI_Preferences_GUI_FontsOverview, -1, #PB_ListIcon_ColumnWidth, 2), 0)
        CloseGadgetList()
      CloseGadgetList()
      ;Shortcuts
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Shortcuts")
      ContainerGadget(#G_CN_Preferences_HotKey, 130, 35, 325, 265)
        CheckBoxGadget(#G_CH_Preferences_HotKey_EnableMediaKeys, 0, 0, 120, 20, "Media Tasten")
        CheckBoxGadget(#G_CH_Preferences_HotKey_EnableGlobal, 130, 0, 120, 20, "Globale Shortcuts")
        ListIconGadget(#G_LI_Preferences_HotKey_Overview, 0, 25, GadgetWidth(#G_CN_Preferences_HotKey), GadgetHeight(#G_CN_Preferences_HotKey) - 75, "Ereignis", 150, #PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#LVS_NOSORTHEADER)
          AddGadgetColumn(#G_LI_Preferences_HotKey_Overview, 1, "Shortcut", 150)
          For iNext = 0 To ArraySize(HotKey())
            AddGadgetItem(#G_LI_Preferences_HotKey_Overview, -1, HotKey(iNext)\event)
          Next
          SendMessage_(GadgetID(#G_LI_Preferences_HotKey_Overview), #LVM_SETCOLUMNWIDTHA, 1, #LVSCW_AUTOSIZE_USEHEADER)
        CheckBoxGadget(#G_CH_Preferences_HotKey_Control, 15, GadgetHeight(#G_CN_Preferences_HotKey) - 30, 60, 20, "Strg")
        CheckBoxGadget(#G_CH_Preferences_HotKey_Menu, 80, GadgetHeight(#G_CN_Preferences_HotKey) - 30, 60, 20, "Alt")
        CheckBoxGadget(#G_CH_Preferences_HotKey_Shift, 145, GadgetHeight(#G_CN_Preferences_HotKey) - 30, 60, 20, "Shift")
        ComboBoxGadget(#G_CB_Preferences_HotKey_Misc, 210, GadgetHeight(#G_CN_Preferences_HotKey) - 30, 100, 20)
          AddGadgetItem(#G_CB_Preferences_HotKey_Misc, 0, "")
          For iNext = 0 To ArraySize(Key())
            AddGadgetItem(#G_CB_Preferences_HotKey_Misc, -1, Key(iNext)\name)
          Next
      CloseGadgetList()
      ;Dateiverknüpfungen
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Dateitypen")
      ContainerGadget(#G_CN_Preferences_Filelink, 130, 35, 325, 265)
        ListIconGadget(#G_LI_Preferences_Filelink_OverView, 0, 0, GadgetWidth(#G_CN_Preferences_Filelink), GadgetHeight(#G_CN_Preferences_Filelink) - 30, "Erweiterung", 80, #LVS_NOSORTHEADER|#PB_ListIcon_CheckBoxes|#PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection)
          AddGadgetColumn(#G_LI_Preferences_Filelink_OverView, 1, "Beschreibung", 80)
          ForEach FileType()
            If FileType()\typ = #FileType_Audio
              AddGadgetItem(#G_LI_Preferences_Filelink_OverView, -1, FileType()\ext + Chr(10) + FileType()\dsc)
            EndIf
          Next
          SetGadgetItemAttribute(#G_LI_Preferences_Filelink_OverView, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Preferences_Filelink_OverView)) - GetGadgetItemAttribute(#G_LI_Preferences_Filelink_OverView, -1, #PB_ListIcon_ColumnWidth, 0), 1)
        ButtonGadget(#G_BN_Preferences_Filelink_All, GadgetWidth(#G_CN_Preferences_Filelink) - 165, GadgetHeight(#G_CN_Preferences_Filelink) - 25, 80, 25, "Alle")
        ButtonGadget(#G_BN_Preferences_Filelink_None, GadgetWidth(#G_CN_Preferences_Filelink) - 80, GadgetHeight(#G_CN_Preferences_Filelink) - 25, 80, 25, "Keine")
      CloseGadgetList()
      ;Tracker
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Tracker")
      ContainerGadget(#G_CN_Preferences_Tracker, 130, 35, 325, 265)
        ; Aktiviert
        CheckBoxGadget(#G_CH_Preferences_Tracker_Enable, 5, 5, 180, 15, "Aktiviert")
          GadgetToolTip(#G_CH_Preferences_Tracker_Enable, "Blendet ein Infofenster mit aktuellen Titelinformationen bei Wiedergabe ein")
        ; Bildschirmabstand
        TextGadget(#G_TX_Preferences_Tracker_Gap, 5, 30, 110, 15, "Bildschirmabstand")
        TrackBarGadget(#G_TB_Preferences_Tracker_Gap, 5, 45, 110, 20, 1, 50, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          GadgetToolTip(#G_TB_Preferences_Tracker_Gap, "Abstand zwischen Tracker und Bildschirmrand")
          SendMessage_(GadgetID(#G_TB_Preferences_Tracker_Gap), #TBM_SETTHUMBLENGTH, 15, 0)
        TextGadget(#G_TX_Preferences_Tracker_Spacing, 120, 30, 110, 15, "Innenabstand")
        TrackBarGadget(#G_TB_Preferences_Tracker_Spacing, 120, 45, 110, 20, 10, 100, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          GadgetToolTip(#G_TB_Preferences_Tracker_Spacing, "Abstand zwischen Trackerrand und Inhalt")
          SendMessage_(GadgetID(#G_TB_Preferences_Tracker_Spacing), #TBM_SETTHUMBLENGTH, 15, 0)
        ; Einblendzeit
        TextGadget(#G_TX_Preferences_Tracker_Time, 5, 75, 180, 15, "Einblendzeit")
        TrackBarGadget(#G_TB_Preferences_Tracker_Time, 5, 90, 180, 20, 1, 25, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          GadgetToolTip(#G_TB_Preferences_Tracker_Time, "Gibt an wie lange der Tracker eingeblendet wird")
          SendMessage_(GadgetID(#G_TB_Preferences_Tracker_Time), #TBM_SETTHUMBLENGTH, 15, 0)
        ; Position
        TextGadget(#G_TX_Preferences_Tracker_Position, 5, 120, 180, 15, "Position")
        ComboBoxGadget(#G_CB_Preferences_Tracker_Position, 5, 135, 180, 20)
          AddGadgetItem(#G_CB_Preferences_Tracker_Position, -1, "Oben Links")
          AddGadgetItem(#G_CB_Preferences_Tracker_Position, -1, "Oben Rechts")
          AddGadgetItem(#G_CB_Preferences_Tracker_Position, -1, "Unten Rechts")
          AddGadgetItem(#G_CB_Preferences_Tracker_Position, -1, "Unten Links")
        ; Minimale Größe
        TextGadget(#G_TX_Preferences_Tracker_MinSize, GadgetWidth(#G_CN_Preferences_Tracker) - 115, 120, 105, 15, "Min. Größe (Pixel)")
        StringGadget(#G_SR_Preferences_Tracker_MinWidth, GadgetWidth(#G_CN_Preferences_Tracker) - 115, 135, 50, 20, "")
        StringGadget(#G_SR_Preferences_Tracker_MinHeight, GadgetWidth(#G_CN_Preferences_Tracker) - 60, 135, 50, 20, "")
        ; Textausrichtung
        TextGadget(#G_TX_Preferences_Tracker_Align, 5, 165, 180, 15, "Textausrichtung")
        ComboBoxGadget(#G_CB_Preferences_Tracker_Align, 5, 180, 180, 20)
          AddGadgetItem(#G_CB_Preferences_Tracker_Align, -1, "Zentriert")
          AddGadgetItem(#G_CB_Preferences_Tracker_Align, -1, "Linksbündig")
          AddGadgetItem(#G_CB_Preferences_Tracker_Align, -1, "Rechtsbündig")
        ; Text
        TextGadget(#G_TX_Preferences_Tracker_Text, 5, 210, 180, 15, "Text")
        StringGadget(#G_SR_Preferences_Tracker_Text, 5, 225, 180, 20, "")
          GadgetToolTip(#G_SR_Preferences_Tracker_Text, "Musterstring: %TITL, %ALBM, %GNRE, %YEAR, %CMNT, %TRCK, |")
        ; Vorschau
        ButtonGadget(#G_BN_Preferences_Tracker_Preview, GadgetWidth(#G_CN_Preferences_Tracker) - 80, GadgetHeight(#G_CN_Preferences_Tracker) - 25, 80, 25, "Vorschau")
      CloseGadgetList()
      ;MediaLib
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Medienbibliothek")
      ContainerGadget(#G_CN_Preferences_MediaLib, 130, 35, 325, 265)
        ListViewGadget(#G_LV_Preferences_MediaLib_Path, 0, 0, GadgetWidth(#G_CN_Preferences_MediaLib) - 27, 106)
        ButtonImageGadget(#G_BI_Preferences_MediaLib_PathAdd, GadgetWidth(#G_CN_Preferences_MediaLib) - 25, 0, 25, 25, ImageList(#ImageList_FolderAdd))
          GadgetToolTip(#G_BI_Preferences_MediaLib_PathAdd, "Ordner Hinzufügen")
        ButtonImageGadget(#G_BI_Preferences_MediaLib_PathRem, GadgetWidth(#G_CN_Preferences_MediaLib) - 25, 27, 25, 25, ImageList(#ImageList_FolderRem))
          GadgetToolTip(#G_BI_Preferences_MediaLib_PathRem, "Ordner Entfernen")
        ButtonImageGadget(#G_BI_Preferences_MediaLib_FindInvalidFiles, GadgetWidth(#G_CN_Preferences_MediaLib) - 25, 54, 25, 25, ImageList(#ImageList_Remove2))
          GadgetToolTip(#G_BI_Preferences_MediaLib_FindInvalidFiles, "Ungültige Dateien Entfernen")
        ButtonImageGadget(#G_BI_Preferences_MediaLib_Scan, GadgetWidth(#G_CN_Preferences_MediaLib) - 25, 81, 25, 25, ImageList(#ImageList_FolderScan))
          GadgetToolTip(#G_BI_Preferences_MediaLib_Scan, "Ordner Durchsuchen")
        CheckBoxGadget(#G_CH_Preferences_MediaLib_CPUScan, 0, 110, 180, 15, "CPU schonendes scannen")
          GadgetToolTip(#G_CH_Preferences_MediaLib_CPUScan, "Beim einlesen der Medien wird eine CPU schonende Routine benutzt, jedoch dauert der Scannvorgang erheblich länger")
        CheckBoxGadget(#G_CH_Preferences_MediaLib_CheckFileExtension, 0, 125, 180, 15, "Erweiterung überprüfen")
          GadgetToolTip(#G_CH_Preferences_MediaLib_CheckFileExtension, "Ignoriert alle Dateien die keine verfügbare Dateierweiterung haben")
        CheckBoxGadget(#G_CH_Preferences_MediaLib_StartEntryCheck, 0, 145, 180, 15, "Bei Start überprüfen")
          GadgetToolTip(#G_CH_Preferences_MediaLib_StartEntryCheck, "Überprüft beim Start die Datenbank auf ungültige Einträge")
        CheckBoxGadget(#G_CH_Preferences_MediaLib_BackgroundScan, 0, 165, 180, 15, "Im Hintergrund aktualisieren")
          GadgetToolTip(#G_CH_Preferences_MediaLib_BackgroundScan, "Aktualisiert vorhandene Einträge automatisch im Hintergrund")        
        CheckBoxGadget(#G_CH_Preferences_MediaLib_AddPlayFile, 0, 180, 180, 15, "Abgespielte Dateien hinzufügen")
          GadgetToolTip(#G_CH_Preferences_MediaLib_AddPlayFile, "Fügt Dateien bei Wiedergabe automatisch in der Medienbibliothek ein")
        TextGadget(#G_TX_Preferences_MediaLib_CurrScan, 0, GadgetHeight(#G_CN_Preferences_MediaLib) - 15, GadgetWidth(#G_CN_Preferences_MediaLib) - 0, 15, "", #SS_LEFTNOWORDWRAP|#SS_PATHELLIPSIS)
      CloseGadgetList()
      ; Aufgaben
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Aufgaben")
      ContainerGadget(#G_CN_Preferences_Order, 130, 35, 325, 265)
        TextGadget(#G_TX_Preferences_Order_TimeOut, 5, 5, 180, 15, "Verzögerung")
        TrackBarGadget(#G_TB_Preferences_Order_TimeOut, 5, 20, 180, 25, 0, 60, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_NOTICKS)
          SendMessage_(GadgetID(#G_TB_Preferences_Order_TimeOut), #TBM_SETTHUMBLENGTH, 13, 0)
          GadgetToolTip(#G_TB_Preferences_Order_TimeOut, "Die Verzögerung bevor eine Aufgabe tatsächlich ausgeführt wird.")
      CloseGadgetList()
      ; Sonstiges
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Sonstiges")
      ScrollAreaGadget(#G_SA_Preferences_Misc, 130, 35, 325, 265, 0, 325, 10, #PB_ScrollArea_Single)
        SetGadgetAttribute(#G_SA_Preferences_Misc, #PB_ScrollArea_InnerWidth, Window_GetClientWidth(GadgetID(#G_SA_Preferences_Misc)) - GetSystemMetrics_(#SM_CXHTHUMB) - 5)
        CheckBoxGadget(#G_CH_Preferences_Misc_Clipboard, 5, 5, 150, 15, "Zwischenablage")
          GadgetToolTip(#G_CH_Preferences_Misc_Clipboard, "Kopiert Informationen über aktuelle Wiedergabe in die Zwischenablage")
        CheckBoxGadget(#G_CH_Preferences_Misc_SavePlayList, 5, 25, 150, 15, "Wiedergabeliste speichern")
          GadgetToolTip(#G_CH_Preferences_Misc_SavePlayList, "Öffnet und Speichert die Wiedergabeliste automatisch")
        Frame3DGadget(#G_FR_Preferences_Misc_AutoSave, 5, 45, 170, 110, "Automatische Speicherung")
        CheckBoxGadget(#G_CH_Preferences_Misc_AutoSavePreferences, 15, 65, 150, 15, "Einstellungen")
        CheckBoxGadget(#G_CH_Preferences_Misc_AutoSavePlayList, 15, 85, 150, 15, "Wiedergabeliste")
        CheckBoxGadget(#G_CH_Preferences_Misc_AutoSaveMediaLib, 15, 105, 150, 15, "Medienbibliothek")
        TextGadget(#G_TX_Preferences_Misc_AutoSaveIntervall, 15, 127, 100, 15, "Intervall (Minuten):")
        SpinGadget(#G_SP_Preferences_Misc_AutoSaveIntervall, 115, 125, 50, 20, 2, 240, #PB_Spin_Numeric)
        CheckBoxGadget(#G_CH_Preferences_Misc_RecursiveFolder, 5, 165, 180, 15, "Unterordner einbeziehen")
          GadgetToolTip(#G_CH_Preferences_Misc_RecursiveFolder, "Fügt bei Drag & Drop Unterordner hinzu")
        CheckBoxGadget(#G_CH_Preferences_Misc_DropClear, 5, 185, 180, 15, "Neue Wiedergabeliste bei DD")
          GadgetToolTip(#G_CH_Preferences_Misc_DropClear, "Leert die Wiedergabeliste bei Drag & Drop")
        CheckBoxGadget(#G_CH_Preferences_Misc_AskBeforeEnd, 5, 205, 180, 15, "Vor beenden Fragen")
          GadgetToolTip(#G_CH_Preferences_Misc_AskBeforeEnd, "Blendet eine Sicherheitsabfrage ein bevor " + #PrgName + " beendet wird")
        CheckBoxGadget(#G_CH_Preferences_Misc_TastBar, 5, 225, 180, 15, "Taskbar")
          GadgetToolTip(#G_CH_Preferences_Misc_TastBar, "Blendet das Fenster in der Taskbar ein")
        CheckBoxGadget(#G_CH_Preferences_Misc_StartCheckUpdate, 5, 245, 180, 15, "Neue Version suchen")
          GadgetToolTip(#G_CH_Preferences_Misc_StartCheckUpdate, "Sucht beim Programmstart nach einer neuen Programmversion")
        CheckBoxGadget(#G_CH_Preferences_Misc_ActivateLogging, 5, 265, 180, 15, "Log Aktivieren")
          GadgetToolTip(#G_CH_Preferences_Misc_ActivateLogging, "Falls Aktiviert, werden Ereignisse im Log Fenster aufgenommen")
        CheckBoxGadget(#G_CH_Preferences_Misc_ChangeMSN, 5, 285, 180, 15, "Windows Live Messenger")
          GadgetToolTip(#G_CH_Preferences_Misc_ChangeMSN, "Zeigt bei Windows Live Messenger aktuellen Track an")
        CheckBoxGadget(#G_CH_Preferences_Misc_PlayLastPlay, 5, 305, 180, 15, "Letzte Wiedergabe fortsetzen")
          GadgetToolTip(#G_CH_Preferences_Misc_PlayLastPlay, "Setzt die letzte Wiedergabe beim Programmstart fort")
      CloseGadgetList()
      ; Plugins
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Plugins")
      ContainerGadget(#G_CN_Preferences_Plugins, 130, 35, 325, 265)
        PanelGadget(#G_PN_Preferences_Plugins, 0, 0, GadgetWidth(#G_CN_Preferences_Plugins), GadgetHeight(#G_CN_Preferences_Plugins))
          AddGadgetItem(#G_PN_Preferences_Plugins, -1, "Plugins")
            ListIconGadget(#G_LI_Preferences_Plugins_RunPlugins, 2, 2, GetGadgetAttribute(#G_PN_Preferences_Plugins, #PB_Panel3D_ItemWidth) - 4, GetGadgetAttribute(#G_PN_Preferences_Plugins, #PB_Panel3D_ItemHeight) - 4, "Datei", 180, #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#LVS_NOSORTHEADER|#PB_ListIcon_CheckBoxes)
            SetGadgetItemAttribute(#G_LI_Preferences_Plugins_RunPlugins, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Preferences_Plugins_RunPlugins)), 0)
          AddGadgetItem(#G_PN_Preferences_Plugins, -1, "Angemeldet")
            ListIconGadget(#G_LI_Preferences_Plugins_RegPlugins, 2, 2, GetGadgetAttribute(#G_PN_Preferences_Plugins, #PB_Panel3D_ItemWidth) - 4, GetGadgetAttribute(#G_PN_Preferences_Plugins, #PB_Panel3D_ItemHeight) - 4, "Autor", 120, #PB_ListIcon_FullRowSelect|#PB_ListIcon_AlwaysShowSelection|#LVS_NOSORTHEADER)
              AddGadgetColumn(#G_LI_Preferences_Plugins_RegPlugins, 2, "Version", 80)
              AddGadgetColumn(#G_LI_Preferences_Plugins_RegPlugins, 3, "Beschreibung", 50)
              SetGadgetItemAttribute(#G_LI_Preferences_Plugins_RegPlugins, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Preferences_Plugins_RegPlugins)) - GetGadgetItemAttribute(#G_LI_Preferences_Plugins_RegPlugins, -1, #PB_ListIcon_ColumnWidth, 0) - GetGadgetItemAttribute(#G_LI_Preferences_Plugins_RegPlugins, -1, #PB_ListIcon_ColumnWidth, 1), 2)
        CloseGadgetList()
      CloseGadgetList()
      ; Backup
      AddGadgetItem(#G_LV_Preferences_Menu, -1, "Backup")
      ContainerGadget(#G_CN_Preferences_Backups, 130, 35, 325, 265)
        ListIconGadget(#G_LI_Preferences_Backups_Overview, 0, 0, GadgetWidth(#G_CN_Preferences_Backups), GadgetHeight(#G_CN_Preferences_Backups) - 30, "Datei", 180, #PB_ListIcon_AlwaysShowSelection|#PB_ListIcon_FullRowSelect|#LVS_NOSORTHEADER)
          AddGadgetColumn(#G_LI_Preferences_Backups_Overview, 1, "Datum", 100)
          SetGadgetItemAttribute(#G_LI_Preferences_Backups_Overview, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Preferences_Backups_Overview)) - GetGadgetItemAttribute(#G_LI_Preferences_Backups_Overview, -1, #PB_ListIcon_ColumnWidth, 0), 1)
        ButtonGadget(#G_BN_Preferences_Backups_Delete, 0, GadgetHeight(#G_CN_Preferences_Backups) - 25, 100, 25, "Löschen")
        ButtonGadget(#G_BN_Preferences_Backups_Restore, GadgetWidth(#G_CN_Preferences_Backups) - 205, GadgetHeight(#G_CN_Preferences_Backups) - 25, 100, 25, "Wiederherstellen")
        ButtonGadget(#G_BN_Preferences_Backups_Create, GadgetWidth(#G_CN_Preferences_Backups) - 100, GadgetHeight(#G_CN_Preferences_Backups) - 25, 100, 25, "Backup Erstellen")
      CloseGadgetList()
    Else
      MsgBox_Error("Fenster 'Preferences' konnte nicht erstellt werden") : End
    EndIf
    
    If WinSize(#Win_Preferences)\posx = -1 And WinSize(#Win_Preferences)\posy = -1
      Window_CenterOnWindow(#Win_Preferences, #Win_Main)
    Else
      ResizeWindow(#Win_Preferences, WinSize(#Win_Preferences)\posx, WinSize(#Win_Preferences)\posy, #PB_Ignore, #PB_Ignore)
    EndIf
    Window_CheckPos(#Win_Preferences)
    
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_Preferences, 1)
      Window_SetOpacity(#Win_Preferences, Pref\opacityval)
    EndIf
    
    WinSize(#Win_Preferences)\winid = WindowID(#Win_Preferences)
    
    WndEx_AddWindow(#Win_Preferences)
    
    Window_SetIcon(#Win_Preferences, ImageList(#ImageList_Pref))
    
    SetActiveGadget(#G_LV_Preferences_Menu)
    
    SetGadgetState(#G_LV_Preferences_Menu, -1)
    
    SmartWindowRefresh(#Win_Preferences, 1)
    
    HideWindow(#Win_Preferences, 0)
  EndIf
EndProcedure

Procedure CloseWindow_Preferences()
  If IsWindow(#Win_Preferences)
    WinSize(#Win_Preferences)\posx  = WindowX(#Win_Preferences)
    WinSize(#Win_Preferences)\posy  = WindowY(#Win_Preferences)
    WinSize(#Win_Preferences)\winid = 0
    WndEx_RemoveWindow(#Win_Preferences)
    Pref\prefarea = GetGadgetState(#G_LV_Preferences_Menu)
    CloseWindow(#Win_Preferences)
  EndIf
EndProcedure

Procedure OpenWindow_Statistics()
  If IsWindow(#Win_Statistics)
    HideWindow(#Win_Statistics, 0)
    SetActiveWindow(#Win_Statistics)
  Else
    If OpenWindow(#Win_Statistics, 0, 0, 460, 340, "Statistiken", #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_WindowCentered, WindowID(#Win_Main))
      TreeGadget(#G_TR_Statistics_Menu, 5, 5, 120, WindowHeight(#Win_Statistics) - 47, #PB_Tree_NoButtons|#PB_Tree_NoLines|#PB_Tree_AlwaysShowSelection)
        AddGadgetItem(#G_TR_Statistics_Menu, -1, "Allgemein")
        AddGadgetItem(#G_TR_Statistics_Menu, -1, "Wiedergabe")
        AddGadgetItem(#G_TR_Statistics_Menu, -1, "Medienbibliothek")
        AddGadgetItem(#G_TR_Statistics_Menu, -1, "Internet Radio")
      ListIconGadget(#G_LI_Statistics_Overview, 130, 5, WindowWidth(#Win_Statistics) - 135, WindowHeight(#Win_Statistics) - 47, "Eigenschaft", 180, #PB_ListIcon_GridLines|#LVS_NOSORTHEADER)
        AddGadgetColumn(#G_LI_Statistics_Overview, 1, "Wert", 100)
        SendMessage_(GadgetID(#G_LI_Statistics_Overview), #LVM_SETCOLUMNWIDTHA, 1, #LVSCW_AUTOSIZE_USEHEADER)
      Frame3DGadget(#G_FR_Statistics_Gap, -5, WindowHeight(#Win_Statistics) - 37, WindowWidth(#Win_Statistics) + 10, 2, "", #PB_Frame3D_Single)
      ButtonGadget(#G_BN_Statistics_Refresh, WindowWidth(#Win_Statistics) - 255, WindowHeight(#Win_Statistics) - 30, 80, 25, "Aktualisieren")
      ButtonGadget(#G_BN_Statistics_Reset, WindowWidth(#Win_Statistics) - 170, WindowHeight(#Win_Statistics) - 30, 80, 25, "Zurücksetzen")
      ButtonGadget(#G_BN_Statistics_Close, WindowWidth(#Win_Statistics) - 85, WindowHeight(#Win_Statistics) - 30, 80, 25, "Schließen")
      
      If WinSize(#Win_Statistics)\posx = -1 And WinSize(#Win_Statistics)\posy = -1
        Window_CenterOnWindow(#Win_Statistics, #Win_Main)
      Else
        ResizeWindow(#Win_Statistics, WinSize(#Win_Statistics)\posx, WinSize(#Win_Statistics)\posy, #PB_Ignore, #PB_Ignore)
      EndIf
      Window_CheckPos(#Win_Statistics)
     
      If Pref\opacity > 0
        Window_SetLayeredStyle(#Win_Statistics, 1)
        Window_SetOpacity(#Win_Statistics, Pref\opacityval)
      EndIf
      
      WinSize(#Win_Statistics)\winid = WindowID(#Win_Statistics)
      
      WndEx_AddWindow(#Win_Statistics)
      
      Window_SetIcon(#Win_Statistics, ImageList(#ImageList_Statistics))
      
      SetGadgetState(#G_TR_Statistics_Menu, 0)
      
      HideWindow(#Win_Statistics, 0)
    Else
      MsgBox_Error("Fenster 'Statistics' konnte nicht erstellt werden") : End
    EndIf
  EndIf
EndProcedure

Procedure CloseWindow_Statistics()
  If IsWindow(#Win_Statistics)
    WinSize(#Win_Statistics)\posx = WindowX(#Win_Statistics)
    WinSize(#Win_Statistics)\posy = WindowY(#Win_Statistics)
    WinSize(#Win_Statistics)\winid = 0
    WndEx_RemoveWindow(#Win_Statistics)
    CloseWindow(#Win_Statistics)
  EndIf
EndProcedure

Procedure OpenWindow_Effects()
  If IsWindow(#Win_Effects)
    HideWindow(#Win_Effects, 0)
    SetActiveWindow(#Win_Effects)
  Else
    If OpenWindow(#Win_Effects, 0, 0, 400, 320, "Effekte", #PB_Window_Invisible|#PB_Window_SystemMenu, WindowID(#Win_Main))
      PanelGadget(#G_PN_Effects_Categorie, 5, 5, WindowWidth(#Win_Effects) - 10, WindowHeight(#Win_Effects) - 40)
      ; Equalizer
      AddGadgetItem(#G_PN_Effects_Categorie, -1, "Equalizer")
        ; Border
        Frame3DGadget(#G_FR_Effects_Equalizer, 15, 15, 352, 224, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CH_Effects_Equalizer, 21, 21, 150, 20, "Equalizer verwenden")
        ComboBoxGadget(#G_CB_Effects_Equalizer, 212, 21, 150, 20)
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Standard")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Classic")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Club")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Dance")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Flat")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "FullBass")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Bass&Treble")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Fulltreble")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Laptop")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "LargeHall")                 
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Live")         
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Party")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Pop")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Reggae")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Rock")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Ska")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Soft")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Softrock")
          AddGadgetItem(#G_CB_Effects_Equalizer, -1, "Techno")
        ; Bands
        For iNext = 0 To 9
          TrackBarGadget(#G_TB_Effects_EqualizerBand0 + iNext, 25 + (iNext * 29), 51, 28, 160, 0, 240, #TBS_BOTH|#TBS_FIXEDLENGTH|#TBS_VERT|#TBS_AUTOTICKS)
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
        TextGadget(#G_TX_Effects_SystemVolumeV, 316, 16, 50, 20, "", #SS_CENTER|#SS_CENTERIMAGE)
        ; Speed
        Frame3DGadget(#G_FR_Effects_Speed, 15, 40, 352, 22, "", #PB_Frame3D_Flat)
        TextGadget(#G_TX_Effects_Speed, 16, 41, 120, 20, "Geschwindigkeit", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_Speed, 136, 41, 180, 20, 1, 200, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_Speed), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_SpeedV, 316, 41, 50, 20, "", #SS_CENTER|#SS_CENTERIMAGE)
        ; Panel
        Frame3DGadget(#G_FR_Effects_Panel, 15, 65, 352, 22, "", #PB_Frame3D_Flat)
        TextGadget(#G_TX_Effects_Panel, 16, 66, 120, 20, "Ausrichtung", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_Panel, 136, 66, 180, 20, 1, 200, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_Panel), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_PanelV, 316, 66, 50, 20, "", #SS_CENTER|#SS_CENTERIMAGE)
        ; Reverb
        Frame3DGadget(#G_FR_Effects_Reverb, 15, 90, 352, 61, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CH_Effects_Reverb, 18, 93, 346, 15, "Reverb")
        TextGadget(#G_TX_Effects_ReverbMix, 16, 110, 120, 20, "Mix", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_ReverbMix, 136, 110, 180, 20, 0, 96, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_ReverbMix), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_ReverbMixV, 316, 110, 50, 20, "", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_ReverbTime, 16, 130, 120, 20, "Zeit", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_ReverbTime, 136, 130, 180, 20, 1, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_ReverbTime), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_ReverbTimeV, 316, 130, 50, 20, "", #SS_CENTERIMAGE|#SS_CENTER)
        ; Echo
        Frame3DGadget(#G_FR_Effects_Echo, 15, 154, 352, 61, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CH_Effects_Echo, 18, 157, 346, 15, "Echo")
        TextGadget(#G_TX_Effects_EchoBack, 16, 174, 120, 20, "Effektivität", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_EchoBack, 136, 174, 180, 20, 0, 100, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_EchoBack), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_EchoBackV, 316, 174, 50, 20, "", #SS_CENTERIMAGE|#SS_CENTER)
        TextGadget(#G_TX_Effects_EchoDelay, 16, 194, 120, 20, "Verzögerung", #SS_CENTERIMAGE|#SS_CENTER)
        TrackBarGadget(#G_TB_Effects_EchoDelay, 136, 194, 180, 20, 1, 2000, #TBS_NOTICKS|#TBS_BOTH|#TBS_FIXEDLENGTH)
          SendMessage_(GadgetID(#G_TB_Effects_EchoDelay), #TBM_SETTHUMBLENGTH, 14, 0)
        TextGadget(#G_TX_Effects_EchoDelayV, 316, 194, 50, 20, "", #SS_CENTERIMAGE|#SS_CENTER)
        ; Flanger
        Frame3DGadget(#G_FR_Effects_Flanger, 15, 218, 352, 21, "", #PB_Frame3D_Flat)
        CheckBoxGadget(#G_CH_Effects_Flanger, 18, 221, 346, 15, "Flanger")
      CloseGadgetList()
      ; Misc
      ButtonGadget(#G_BN_Effects_Default, 5, WindowHeight(#Win_Effects) - 30, 80, 25, "Standard")
      ButtonGadget(#G_BN_Effects_Close, WindowWidth(#Win_Effects) - 85, WindowHeight(#Win_Effects) - 30, 80, 25, "OK")
    Else
      MsgBox_Error("Fenster 'Effects' konnte nicht erstellt werden") : End
    EndIf
    
    ; Init Window
    If WinSize(#Win_Effects)\posx = -1 And WinSize(#Win_Effects)\posy = -1
      Window_CenterOnWindow(#Win_Effects, #Win_Main)
    Else
      ResizeWindow(#Win_Effects, WinSize(#Win_Effects)\posx, WinSize(#Win_Effects)\posy, #PB_Ignore, #PB_Ignore)
    EndIf
    Window_CheckPos(#Win_Effects)
    
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_Effects, 1)
      Window_SetOpacity(#Win_Effects, Pref\opacityval)
    EndIf
    
    WinSize(#Win_Effects)\winid = WindowID(#Win_Effects)
    
    WndEx_AddWindow(#Win_Effects)
    
    Window_SetIcon(#Win_Effects, ImageList(#ImageList_Equilizer))
    
    ; Equalizer
    SetGadgetState(#G_CH_Effects_Equalizer, Pref\equilizer)
    SetGadgetState(#G_CB_Effects_Equalizer, Pref\equilizerpreset)
    For iNext = 0 To 9
      SetGadgetState(#G_TB_Effects_EqualizerBand0 + iNext, BassEQ\iCenter[iNext])
      If Pref\equilizer = 0 : DisableGadget(#G_TB_Effects_EqualizerBand0 + iNext, 1) : EndIf
    Next
    ; SystemVolume
    SetGadgetState(#G_TB_Effects_SystemVolume, BASS_GetVolume() * 100)
    SetGadgetText(#G_TX_Effects_SystemVolumeV, StrF(BASS_GetVolume(), 2))
    ; Speed
    SetGadgetState(#G_TB_Effects_Speed, Pref\speed)
    SetGadgetText(#G_TX_Effects_SpeedV, Str(Pref\speed) + "%")
    ; Panel
    SetGadgetState(#G_TB_Effects_Panel, Pref\panel)
    If IsGadget(#G_TX_Effects_PanelV)
      If Pref\panel = 100
        SetGadgetText(#G_TX_Effects_PanelV, "Center")
      Else
        If Pref\panel < 100
          SetGadgetText(#G_TX_Effects_PanelV, Str(100 - Pref\panel) + " <")
        Else
          SetGadgetText(#G_TX_Effects_PanelV, "> " + Str(Pref\panel - 100))
        EndIf
      EndIf
    EndIf
    ; Reverb
    SetGadgetState(#G_CH_Effects_Reverb, Effects\bReverb)
    SetGadgetState(#G_TB_Effects_ReverbMix, Effects\fReverbMix + 96)
    SetGadgetState(#G_TB_Effects_ReverbTime, (Effects\fReverbTime * 100) / 3000)
    SetGadgetText(#G_TX_Effects_ReverbMixV, Str(((Effects\fReverbMix + 96) * 100) / 96))
    SetGadgetText(#G_TX_Effects_ReverbTimeV, Str((Effects\fReverbTime * 100) / 3000))
    ; Echo
    SetGadgetState(#G_CH_Effects_Echo, Effects\bEcho)
    SetGadgetState(#G_TB_Effects_EchoBack, Effects\bEchoBack)
    SetGadgetState(#G_TB_Effects_EchoDelay, Effects\iEchoDelay)
    SetGadgetText(#G_TX_Effects_EchoBackV, Str(Effects\bEchoBack))
    SetGadgetText(#G_TX_Effects_EchoDelayV, Str(Effects\iEchoDelay * 100 / 2000))
    ; Flanger
    SetGadgetState(#G_CH_Effects_Flanger, Effects\bFlanger)
    
    HideWindow(#Win_Effects, 0)
  EndIf
EndProcedure

Procedure CloseWindow_Effects()
  If IsWindow(#Win_Effects)
    WinSize(#Win_Effects)\posx  = WindowX(#Win_Effects)
    WinSize(#Win_Effects)\posy  = WindowY(#Win_Effects)
    WinSize(#Win_Effects)\winid = 0
    WndEx_RemoveWindow(#Win_Effects)
    CloseWindow(#Win_Effects)
  EndIf
EndProcedure

Procedure OpenWindow_Search()
  If IsWindow(#Win_Search)
    HideWindow(#Win_Search, 0)
    SetActiveWindow(#Win_Search)
  Else
    If OpenWindow(#Win_Search, -1, -1, 330, 280, "Suche", #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_SizeGadget, WindowID(#Win_Main))
      ComboBoxGadget(#G_CB_Search_SearchIn, 5, 5, 250, 20)
        AddGadgetItem(#G_CB_Search_SearchIn, -1, "Überall")
        AddGadgetItem(#G_CB_Search_SearchIn, -1, "Titel")
        AddGadgetItem(#G_CB_Search_SearchIn, -1, "Interpret")
        AddGadgetItem(#G_CB_Search_SearchIn, -1, "Album")
        AddGadgetItem(#G_CB_Search_SearchIn, -1, "Kommentar")
        SetGadgetState(#G_CB_Search_SearchIn, 0)
      StringGadget(#G_SR_Search_String, 5, 30, 250, 20, "")
      ButtonGadget(#G_BN_Search_Start, 260, 25, 65, 25, "Suchen")
      ListViewGadget(#G_LV_Search_Result, 5, 55, 320, 220)
    Else
      MsgBox_Error("Fenster 'ShowSearch' konnte nicht erstellt werden") : End
    EndIf
    
    WindowBounds(#Win_Search, WindowWidth(#Win_Search), WindowHeight(#Win_Search), #PB_Ignore, #PB_Ignore)
    
    If WinSize(#Win_Search)\posx = -1 And WinSize(#Win_Search)\posy = -1
      Window_CenterOnWindow(#Win_Search, #Win_Main)
    Else
      ResizeWindow(#Win_Search, WinSize(#Win_Search)\posx, WinSize(#Win_Search)\posy, WinSize(#Win_Search)\width, WinSize(#Win_Search)\height)
    EndIf
    Window_CheckPos(#Win_Search)
    
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_Search, 1)
      Window_SetOpacity(#Win_Search, Pref\opacityval)
    EndIf
    
    WinSize(#Win_Search)\winid = WindowID(#Win_Search)
    
    WndEx_AddWindow(#Win_Search)
    
    Window_SetIcon(#Win_Search, ImageList(#ImageList_Search))
    
    SetActiveGadget(#G_SR_Search_String)
    
    AddKeyboardShortcut(#Win_Search, #PB_Shortcut_Return, #Shortcut_Search_Enter)
    
    HideWindow(#Win_Search, 0)
  EndIf
EndProcedure

Procedure CloseWindow_Search()
  If IsWindow(#Win_Search)
    WinSize(#Win_Search)\posx   = WindowX(#Win_Search)
    WinSize(#Win_Search)\posy   = WindowY(#Win_Search)
    WinSize(#Win_Search)\width  = WindowWidth(#Win_Search)
    WinSize(#Win_Search)\height = WindowHeight(#Win_Search)
    WinSize(#Win_Search)\winid  = 0
    WndEx_RemoveWindow(#Win_Search)
    RemoveKeyboardShortcut(#Win_Search, #PB_Shortcut_Return)
    CloseWindow(#Win_Search)
  EndIf
EndProcedure

Procedure OpenWindow_Info()
  If IsWindow(#Win_Info)
    HideWindow(#Win_Info, 0)
    SetActiveWindow(#Win_Info)
  Else
    If OpenWindow(#Win_Info, 0, 0, 380, 452, "Informationen", #PB_Window_Invisible|#PB_Window_SystemMenu, WindowID(#Win_Main))
      ImageGadget(#G_IG_Info_PrgLogo, 0, 0, 380, 139, iImgPrgLogo)
       DisableGadget(#G_IG_Info_PrgLogo, 1)
      Frame3DGadget(#G_FR_Info_Gap, -5, 139, 395, 2, "", #PB_Frame3D_Single)
      PanelGadget(#G_PN_Info_Info, 5, 145, 370, 265)
        AddGadgetItem(#G_PN_Info_Info, -1, "Informationen")
          TextGadget(#G_TX_Info_Info, 5, 5, GetGadgetAttribute(#G_PN_Info_Info, #PB_Panel_ItemWidth) - 10, GetGadgetAttribute(#G_PN_Info_Info, #PB_Panel_ItemHeight) - 10, "", #PB_Text_Center)
        AddGadgetItem(#G_PN_Info_Info, -1, "Geschichte")
          StringGadget(#G_TX_Info_ChangeLog, 5, 5, GetGadgetAttribute(#G_PN_Info_Info, #PB_Panel_ItemWidth) - 10, GetGadgetAttribute(#G_PN_Info_Info, #PB_Panel_ItemHeight) - 10, #ChangeLog, #ES_READONLY|#ES_MULTILINE|#WS_VSCROLL|#WS_HSCROLL)
            SetGadgetColor(#G_TX_Info_ChangeLog, #PB_Gadget_BackColor, GetSysColor_(#COLOR_WINDOW))
            SetGadgetColor(#G_TX_Info_ChangeLog, #PB_Gadget_FrontColor, GetSysColor_(#COLOR_WINDOWTEXT))
      CloseGadgetList()
      ButtonGadget(#G_BN_Info_Close, WindowWidth(#Win_Info)/2 - 40, 420, 80, 25, "OK")
    Else
      MsgBox_Error("Fenster 'Info' konnte nicht erstellt werden") : End
    EndIf
    
    If WinSize(#Win_Info)\posx = -1 And WinSize(#Win_Info)\posy = -1
      Window_CenterOnWindow(#Win_Info, #Win_Main)
    Else
      ResizeWindow(#Win_Info, WinSize(#Win_Info)\posx, WinSize(#Win_Info)\posy, #PB_Ignore, #PB_Ignore)
    EndIf
    Window_CheckPos(#Win_Info)
   
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_Info, 1)
      Window_SetOpacity(#Win_Info, Pref\opacityval)
    EndIf
    
    WinSize(#Win_Info)\winid = WindowID(#Win_Info)
    
    WndEx_AddWindow(#Win_Info)
    
    Window_SetIcon(#Win_Info, ImageList(#ImageList_About))
    
    ; Set Info
    Protected sInfo.s
    
    sInfo + #CRLF$
    sInfo + #PrgName + " Version " + StrF(#PrgVers/100, 2) + #CRLF$
    sInfo + "Compilebuild: " + StrF(#PB_Editor_BuildCount/100, 2) + #CRLF$ + #CRLF$
    sInfo + "Copyright©Kai Gartenschläger, 2009" + #CRLF$
    sInfo + #EMail + #CRLF$
    sInfo + #URLUpdateS + #CRLF$ + #CRLF$
    sInfo + "Bass Audio Libary " + Mid(Hex(iBassVersion), 1, 1) + "." + Mid(Hex(iBassVersion), 2, 2) + "." + Mid(Hex(iBassVersion), 4, 2) + "." + Mid(Hex(iBassVersion), 6, 2) + #CRLF$
    sInfo + "Copyright © 2003-2008 un4seen developments." + #CRLF$ + #CRLF$
    sInfo + "TagLib Audio Meta-Data Library 1.6" + #CRLF$
    sInfo + "Scott Wheeler <wheeler@kde.org>" + #CRLF$ + #CRLF$
    sInfo + "Silk Icons" + #CRLF$
    sInfo + "http://www.famfamfam.com"
    
    SetGadgetText(#G_TX_Info_Info, sInfo)
    
    HideWindow(#Win_Info, 0)
  EndIf
EndProcedure

Procedure CloseWindow_Info()
  If IsWindow(#Win_Info)
    WinSize(#Win_Info)\posx = WindowX(#Win_Info)
    WinSize(#Win_Info)\posy = WindowY(#Win_Info)
    WinSize(#Win_Info)\winid = 0
    WndEx_RemoveWindow(#Win_Info)
    CloseWindow(#Win_Info)
  EndIf
EndProcedure

Procedure OpenWindow_Log()
  If Pref\enablelogging = 0
    MsgBox_Exclamation("Log wurde deaktiviert, bitte in den Einstellungen wieder aktivieren.")
    ProcedureReturn 0
  EndIf
  
  If IsWindow(#Win_Log)
    HideWindow(#Win_Log, 0)
    SetActiveWindow(#Win_Log)
  Else
    If OpenWindow(#Win_Log, 0, 0, 280, 320, "Log", #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_SizeGadget, WindowID(#Win_Main))
      ListIconGadget(#G_LI_Log_Overview, 2, 2, WindowWidth(#Win_Log) - 4, WindowHeight(#Win_Log) - 4, "Eintrag", 100, #PB_ListIcon_FullRowSelect|#PB_ListIcon_MultiSelect|#LVS_NOSORTHEADER|#LVS_NOCOLUMNHEADER)
        SendMessage_(GadgetID(#G_LI_Log_Overview), #LVM_SETEXTENDEDLISTVIEWSTYLE, 0, SendMessage_(GadgetID(#G_LI_Log_Overview), #LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)|#LVS_EX_LABELTIP)
    Else
      MsgBox_Error("Fenster 'Log' konnte nicht erstellt werden") : End
    EndIf
    
    WindowBounds(#Win_Log, WindowWidth(#Win_Log), WindowHeight(#Win_Log), #PB_Ignore, #PB_Ignore)
    
    If WinSize(#Win_Log)\posx = -1 And WinSize(#Win_Log)\posy = -1
      Window_CenterOnWindow(#Win_Log, #Win_Main)
    Else
      ResizeWindow(#Win_Log, WinSize(#Win_Log)\posx, WinSize(#Win_Log)\posy, WinSize(#Win_Log)\width, WinSize(#Win_Log)\height)
    EndIf
    Window_CheckPos(#Win_Log)
   
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_Log, 1)
      Window_SetOpacity(#Win_Log, Pref\opacityval)
    EndIf
    
    WinSize(#Win_Log)\winid = WindowID(#Win_Log)
    
    WndEx_AddWindow(#Win_Log)
    
    Window_SetIcon(#Win_Log, ImageList(#ImageList_Search))
    
    ; AddItems
    Protected iImage.i
    
    SendMessage_(GadgetID(#G_LI_Log_Overview), #WM_SETREDRAW, #False, 0)
    ForEach Logging()
      Select Logging()\type
        Case #Log_Error       : iImage = ImageList(#ImageList_Error)
        Case #Log_Exclamation : iImage = ImageList(#ImageList_Exclamation)
        Case #Log_Warning     : iImage = ImageList(#ImageList_Warning)
        Case #Log_Info        : iImage = ImageList(#ImageList_Info)
        Case #Log_Normal      : iImage = ImageList(#ImageList_Info)
      EndSelect
      AddGadgetItem(#G_LI_Log_Overview, -1, FormatDate("%hh:%ii:%ss - ", Logging()\time) + Logging()\message, iImage)
    Next
    SendMessage_(GadgetID(#G_LI_Log_Overview), #WM_SETREDRAW, #True, 0)
    
    SetGadgetItemAttribute(#G_LI_Log_Overview, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Log_Overview)), 0)
    SendMessage_(GadgetID(#G_LI_Log_Overview), #LVM_ENSUREVISIBLE, CountGadgetItems(#G_LI_Log_Overview) - 1, 1)
    
    HideWindow(#Win_Log, 0)
  EndIf
EndProcedure

Procedure CloseWindow_Log()
  If IsWindow(#Win_Log)
    WinSize(#Win_Log)\posx   = WindowX(#Win_Log)
    WinSize(#Win_Log)\posy   = WindowY(#Win_Log)
    WinSize(#Win_Log)\width  = WindowWidth(#Win_Log)
    WinSize(#Win_Log)\height = WindowHeight(#Win_Log)
    WinSize(#Win_Log)\winid  = 0
    WndEx_RemoveWindow(#Win_Log)
    CloseWindow(#Win_Log)
  EndIf
EndProcedure

Procedure OpenWindow_Metadata()
  If IsWindow(#Win_Metadata) = 0
    If OpenWindow(#Win_Metadata, 0, 0, 585, 275, "Datei Informationen", #PB_Window_Invisible|#PB_Window_SystemMenu, WindowID(#Win_Main))
      Frame3DGadget(#G_FR_Metadata_File, 5, 5, 370, 40, "", #PB_Frame3D_Single)
      TextGadget(#G_TX_Metadata_File, 15, 18, 60, 15, "Datei", #PB_Text_Right)
      StringGadget(#G_SR_Metadata_File, 85, 15, 240, 20, "", #PB_String_ReadOnly)
        SetGadgetColor(#G_SR_Metadata_File, #PB_Gadget_BackColor, GetSysColor_(#COLOR_WINDOW))
        SetGadgetColor(#G_SR_Metadata_File, #PB_Gadget_FrontColor, GetSysColor_(#COLOR_WINDOWTEXT))
      ButtonGadget(#G_BN_Metadata_File, 330, 15, 35, 20, "...")
        GadgetToolTip(#G_BN_Metadata_File, "Ordner Öffnen")
      Frame3DGadget(#G_FR_Metadata_Meta, 5, 50, 370, 190, "", #PB_Frame3D_Single)
      TextGadget(#G_TX_Metadata_Title, 15, 62, 60, 15, "Titel", #PB_Text_Right)
      StringGadget(#G_SR_Metadata_Title, 85, 60, 145, 20, "")
      TextGadget(#G_TX_Metadata_Track, 235, 62, 60, 15, "Track", #PB_Text_Right)
      StringGadget(#G_SR_Metadata_Track, 305, 60, 60, 20, "")
      TextGadget(#G_TX_Metadata_Artist, 15, 92, 60, 15, "Interpret", #PB_Text_Right)
      StringGadget(#G_SR_Metadata_Artist, 85, 90, 280, 20, "")
      TextGadget(#G_TX_Metadata_Album, 15, 122, 60, 15, "Album", #PB_Text_Right)
      StringGadget(#G_SR_Metadata_Album, 85, 120, 280, 20, "")
      TextGadget(#G_TX_Metadata_Year, 15, 152, 60, 15, "Jahr", #PB_Text_Right)
      StringGadget(#G_SR_Metadata_Year, 85, 150, 60, 20, "")
      TextGadget(#G_TX_Metadata_Genre, 150, 152, 60, 15, "Genre", #PB_Text_Right)
      ComboBoxGadget(#G_CB_Metadata_Genre, 220, 150, 145, 20, #PB_ComboBox_Editable)
        For iNext = 0 To ArraySize(MP3Genre())
          AddGadgetItem(#G_CB_Metadata_Genre, -1, MP3Genre(iNext))
        Next
      TextGadget(#G_TX_Metadata_Comment, 15, 182, 60, 15, "Kommentar", #PB_Text_Right)
      StringGadget(#G_SR_Metadata_Comment, 85, 180, 280, 50, "")
      Frame3DGadget(#G_FR_Metadata_Format, 380, 5, 200, 235, "", #PB_Frame3D_Single)
      TextGadget(#G_TX_Metadata_Size, 390, 15, 60, 15, "Dateigröße", #PB_Text_Right)
      TextGadget(#G_TX_Metadata_SizeV, 455, 15, 115, 15, "")
      TextGadget(#G_TX_Metadata_Bitrate, 390, 35, 60, 15, "Bitrate", #PB_Text_Right)
      TextGadget(#G_TX_Metadata_BitrateV, 455, 35, 115, 15, "")
      TextGadget(#G_TX_Metadata_Samplerate, 390, 55, 60, 15, "Samplerate", #PB_Text_Right)
      TextGadget(#G_TX_Metadata_SamplerateV, 455, 55, 115, 15, "")
      TextGadget(#G_TX_Metadata_Channels, 390, 75, 60, 15, "Channels", #PB_Text_Right)
      TextGadget(#G_TX_Metadata_ChannelsV, 455, 75, 115, 15, "")
      TextGadget(#G_TX_Metadata_Length, 390, 95, 60, 15, "Länge", #PB_Text_Right)
      TextGadget(#G_TX_Metadata_LengthV, 455, 95, 115, 15, "")
      TextGadget(#G_TX_Metadata_Format, 390, 115, 60, 15, "Format", #PB_Text_Right)
      TextGadget(#G_TX_Metadata_FormatV, 455, 115, 120, 40, "")
      ButtonGadget(#G_BN_Metadata_MidiLyrics, 5, 245, 80, 25, "Lyriken")
      ButtonGadget(#G_BN_Metadata_Save, 210, 245, 80, 25, "OK")
      ButtonGadget(#G_BN_Metadata_Cancel, 295, 245, 80, 25, "Abbrechen")
    Else
      MsgBox_Error("Fenster 'Metadata' konnte nicht erstellt werden") : End
    EndIf
    
    If WinSize(#Win_Metadata)\posx = -1 And WinSize(#Win_Metadata)\posy = -1
      Window_CenterOnWindow(#Win_Metadata, #Win_Main)
    Else
      ResizeWindow(#Win_Metadata, WinSize(#Win_Metadata)\posx, WinSize(#Win_Metadata)\posy, #PB_Ignore, #PB_Ignore)
    EndIf
    Window_CheckPos(#Win_Metadata)
   
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_Metadata, 1)
      Window_SetOpacity(#Win_Metadata, Pref\opacityval)
    EndIf
    
    WinSize(#Win_Metadata)\winid = WindowID(#Win_Metadata)
    
    WndEx_AddWindow(#Win_Metadata)
    
    Window_SetIcon(#Win_Metadata, ImageList(#ImageList_TrackInfo))
    
    HideWindow(#Win_Metadata, 0)
  EndIf
EndProcedure

Procedure CloseWindow_Metadata()
  If IsWindow(#Win_Metadata)
    WinSize(#Win_Metadata)\posx  = WindowX(#Win_Metadata)
    WinSize(#Win_Metadata)\posy  = WindowY(#Win_Metadata)
    WinSize(#Win_Metadata)\winid = 0
    WndEx_RemoveWindow(#Win_Metadata)
    CloseWindow(#Win_Metadata)
  EndIf
EndProcedure

Procedure OpenWindow_Tracker(Preview = 0)
  Protected iTextAlign.i
  
  If IsWindow(#Win_Tracker) : CloseWindow(#Win_Tracker) : EndIf
  
  If OpenWindow(#Win_Tracker, 0, 0, 0, 0, #PrgName + " - Tracker", #PB_Window_Invisible|#PB_Window_BorderLess, WindowID(#Win_Main))
    Select Pref\tracker_align
      Case 0 : iTextAlign = #SS_CENTER
      Case 2 : iTextAlign = #SS_RIGHT
    EndSelect
    
    ContainerGadget(#G_CN_Tracker, 0, 0, 0, 0, #PB_Container_BorderLess|#PB_Container_Flat)
      TextGadget(#G_TX_Tracker_Title, 0, 0, 0, 0, "", iTextAlign|#SS_NOPREFIX)
    CloseGadgetList()
    
    If GUIFont(#Font_Tracker)\activ And IsFont(#Font_Tracker)
      SetGadgetFont(#G_TX_Tracker_Title, FontID(#Font_Tracker))
    EndIf
    
    Protected sString.s, iTextWidth.i, iTextHeight.i, iLines.i, iNext.i, iTempWidth.i, iTrackerW.i, iTrackerH.i
    
    sString = Pref\tracker_text
    
    Pref\tracker_test = Preview
    
    If BASS_ChannelIsActive(CurrPlay\channel[CurrPlay\curr]) <> #BASS_ACTIVE_STOPPED : Preview = 0 : EndIf
    
    If Preview = 0
      sString = ReplaceString(sString, "%ARTI", CurrPlay\tag\artist, #PB_String_NoCase)
    Else
      sString = ReplaceString(sString, "%ARTI", "Beispielartist", #PB_String_NoCase)
    EndIf
    If Preview = 0
      sString = ReplaceString(sString, "%TITL", CurrPlay\tag\title, #PB_String_NoCase)
    Else
      sString = ReplaceString(sString, "%TITL", "Beispieltitel", #PB_String_NoCase)
    EndIf
    If Preview = 0
      sString = ReplaceString(sString, "%ALBM", CurrPlay\tag\album, #PB_String_NoCase)
    Else
      sString = ReplaceString(sString, "%ALBM", "Beispielalbum", #PB_String_NoCase)
    EndIf
    If Preview = 0
      sString = ReplaceString(sString, "%GNRE", CurrPlay\tag\genre, #PB_String_NoCase)
    Else
      sString = ReplaceString(sString, "%GNRE", "Beispielgenre", #PB_String_NoCase)
    EndIf
    If Preview = 0
      sString = ReplaceString(sString, "%YEAR", Str(CurrPlay\tag\year), #PB_String_NoCase)
    Else
      sString = ReplaceString(sString, "%YEAR", "Jahr", #PB_String_NoCase)
    EndIf
    If Preview = 0
      sString = ReplaceString(sString, "%CMNT", CurrPlay\tag\comment, #PB_String_NoCase)
    Else
      sString = ReplaceString(sString, "%CMNT", "Das ist ein Kommentar", #PB_String_NoCase)
    EndIf
    If Preview = 0
      sString = ReplaceString(sString, "%TRCK", Str(CurrPlay\tag\track), #PB_String_NoCase)
    Else
      sString = ReplaceString(sString, "%TRCK", "Track", #PB_String_NoCase)
    EndIf
    
    iLines = CountString(sString, "|") + 1
    
    For iNext = 1 To iLines
      iTempWidth = Window_TextWidth(StringField(sString, iNext, "|"), GadgetID(#G_TX_Tracker_Title))
      If iTempWidth > iTextWidth
        iTextWidth = iTempWidth
      EndIf
    Next
    
    iTextHeight = Window_TextHeight(sString, GadgetID(#G_TX_Tracker_Title))
    If iLines >= 1
      iTextHeight = (iTextHeight * iLines)
    EndIf
    
    sString = ReplaceString(sString, "|", #CRLF$, #PB_String_NoCase)
    
    SetGadgetText(#G_TX_Tracker_Title, sString)
    
    If iTextWidth + Pref\tracker_spacing < Pref\tracker_minw
      iTrackerW = Pref\tracker_minw
    Else
      iTrackerW = iTextWidth + Pref\tracker_spacing
    EndIf
    If iTextHeight + Pref\tracker_spacing < Pref\tracker_minh
      iTrackerH = Pref\tracker_minh
    Else
      iTrackerH = iTextHeight + Pref\tracker_spacing
    EndIf
    
    ResizeWindow(#Win_Tracker, #PB_Ignore, #PB_Ignore, iTrackerW, iTrackerH)
    ResizeGadget(#G_CN_Tracker, #PB_Ignore, #PB_Ignore, iTrackerW, iTrackerH)
    ResizeGadget(#G_TX_Tracker_Title, GadgetWidth(#G_CN_Tracker) / 2 - iTextWidth / 2, GadgetHeight(#G_CN_Tracker) / 2 - iTextHeight / 2, iTextWidth, iTextHeight)
    
    SetGadgetColor(#G_CN_Tracker, #PB_Gadget_BackColor, Pref\color[#Color_Tracker_BG])
    SetGadgetColor(#G_TX_Tracker_Title, #PB_Gadget_BackColor, Pref\color[#Color_Tracker_BG])
    SetGadgetColor(#G_TX_Tracker_Title, #PB_Gadget_FrontColor, Pref\color[#Color_Tracker_FG])
    
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_Tracker, 1)
      Window_SetOpacity(#Win_Tracker, Pref\opacityval)
    EndIf
    
    Window_Snap(#Win_Tracker, Pref\tracker_corner, Pref\tracker_gap)
    Window_AlwaysOnTop(#Win_Tracker, 1)
    
    ShowWindow_(WindowID(#Win_Tracker), #SW_SHOWNA)
    
    Pref\tracker_currtime = timeGetTime_()
  Else
    MsgBox_Error("Fenster 'Metadata' konnte nicht erstellt werden") : End
  EndIf
EndProcedure

Procedure CloseWindow_Tracker()
  If IsWindow(#Win_Tracker)
    Protected iWin.i
    
    iWin = GetForegroundWindow_()
    
    HideWindow(#Win_Tracker, 1)
    CloseWindow(#Win_Tracker)
    
    Pref\tracker_test = 0
    
    If IsWindow_(iWin)
      SetForegroundWindow_(iWin)
    EndIf
  EndIf
EndProcedure

Procedure OpenWindow_PlayListGenerator()
  If IsWindow(#Win_PlaylistGenerator)
    HideWindow(#Win_PlaylistGenerator, 0)
    SetActiveWindow(#Win_PlaylistGenerator)
  Else
    If OpenWindow(#Win_PlaylistGenerator, 0, 0, 390, 373, "Wiedergabeliste erstellen", #PB_Window_Invisible|#PB_Window_SystemMenu, WindowID(#Win_Main))
      CheckBoxGadget(#G_CH_PlaylistGenerator_WordFilter, 10, 95, 210, 15, "Suchbegriffe")
        GadgetToolTip(#G_CH_PlaylistGenerator_WordFilter, "Hier Können Sie mehrere Suchbegriffe eingeben. Trennzeichen |")
      StringGadget(#G_SR_PlaylistGenerator_WordFilter, 10, 114, 210, 20, "")
      CheckBoxGadget(#G_CH_PlaylistGenerator_GenreFilter, 235, 95, 140, 15, "Genre Wahl")
      ListViewGadget(#G_LV_PlaylistGenerator_GenreFilter, 235, 114, 140, 177, #PB_ListView_ClickSelect)
        For iNext = 0 To ArraySize(MP3Genre())
          AddGadgetItem(#G_LV_PlaylistGenerator_GenreFilter, -1, MP3Genre(iNext))
        Next
        GadgetToolTip(#G_LV_PlaylistGenerator_GenreFilter, "Genres mit Linksklick auswählen")
      ButtonGadget(#G_BN_PlaylistGenerator_Cancel, 300, 340, 80, 25, "Abbrechen")
      ButtonGadget(#G_BN_PlaylistGenerator_Create, 215, 340, 80, 25, "Erstellen")
      ProgressBarGadget(#G_PB_PlaylistGenerator_Progress, 10, 346, 100, 14, 0, 100)
      Frame3DGadget(#G_FR_PlaylistGenerator_Length, 10, 140, 210, 120, "Länge")
      OptionGadget(#G_OP_PlaylistGenerator_Amount, 20, 160, 190, 15, "Nach Anzahl")
        GadgetToolTip(#G_OP_PlaylistGenerator_Amount, "Maximale Titelanzahl (-1:Unbegrenzt")
      OptionGadget(#G_OP_PlaylistGenerator_Time, 20, 205, 190, 15, "Nach Zeit")
        GadgetToolTip(#G_OP_PlaylistGenerator_Time, "Maximale Wiedergabedauer")
      StringGadget(#G_SR_PlaylistGenerator_Amount, 20, 179, 190, 20, "25")
      DateGadget(#G_CB_PlaylistGenerator_Time, 20, 224, 190, 24, "%hh Std. und %ii Min.", Date(1970,1,1,0,30,0), #PB_Date_UpDown)
        SetGadgetAttribute(#G_CB_PlaylistGenerator_Time, #PB_Date_Minimum, Date(1970,1,1,0,10,0))
        GadgetToolTip(#G_CB_PlaylistGenerator_Time, "Maximale Wiedergabedauer")
      TextGadget(#G_TX_PlaylistGenerator_Info, 10, 10, 370, 75, "Dieser Assistent kann ihnen automatisch eine Wiedergabeliste erstellen. Dabei können Sie gewisse Suchkriterien angeben, mit dessen Hilfe der Assisten die Auswahl trift. Zum erstellen klicken Sie auf 'Erstellen'. Bitte bedenken Sie das diese Funktion nur möglich ist, solange sich in ihrer Medienbibliothek auch genügend Dateien befinden.")
      TextGadget(#G_TX_PlaylistGenerator_Progress, 10, 310, 365, 15, "Klicken Sie auf 'Erstellen' um eine Wiedergabeliste zu generieren.")
      CheckBoxGadget(#G_CH_PlaylistGenerator_OnlyPlayed, 10, 270, 180, 15, "Bereits abgespielt")
        GadgetToolTip(#G_CH_PlaylistGenerator_OnlyPlayed, "Es werden nur Titel hinzugefügt, die bereits abgespielt wurden.")
      CheckBoxGadget(#G_CH_PlaylistGenerator_OnlyAdd, 10, 287, 180, 15, "Hinzufügen")
        GadgetToolTip(#G_CH_PlaylistGenerator_OnlyAdd, "Fügt die generierte Wiedergabeliste nur zur aktuellen hinzu")
      Frame3DGadget(#G_FR_PlaylistGenerator_Gap, 0, 330, 400, 2, "", #PB_Frame3D_Single)
      
      If WinSize(#Win_PlaylistGenerator)\posx = -1 And WinSize(#Win_PlaylistGenerator)\posy = -1
        Window_CenterOnWindow(#Win_PlaylistGenerator, #Win_Main)
      Else
        ResizeWindow(#Win_PlaylistGenerator, WinSize(#Win_PlaylistGenerator)\posx, WinSize(#Win_PlaylistGenerator)\posy, #PB_Ignore, #PB_Ignore)
      EndIf
      Window_CheckPos(#Win_PlaylistGenerator)
     
      If Pref\opacity > 0
        Window_SetLayeredStyle(#Win_PlaylistGenerator, 1)
        Window_SetOpacity(#Win_PlaylistGenerator, Pref\opacityval)
      EndIf
      
      WinSize(#Win_PlaylistGenerator)\winid = WindowID(#Win_PlaylistGenerator)
      
      WndEx_AddWindow(#Win_PlaylistGenerator)
      
      Window_SetIcon(#Win_PlaylistGenerator, ImageList(#ImageList_PlayList))
      
      DisableGadget(#G_SR_PlaylistGenerator_WordFilter, 1)
      DisableGadget(#G_SR_PlaylistGenerator_Amount, 1)
      SetGadgetState(#G_OP_PlaylistGenerator_Time, 1)
      DisableGadget(#G_LV_PlaylistGenerator_GenreFilter, 1)
      HideGadget(#G_PB_PlaylistGenerator_Progress, 1)
      
      HideWindow(#Win_PlaylistGenerator, 0)
    EndIf
  EndIf
EndProcedure

Procedure CloseWindow_PlayListGenerator()
  If IsWindow(#Win_PlaylistGenerator)
    WinSize(#Win_PlaylistGenerator)\posx = WindowX(#Win_PlaylistGenerator)
    WinSize(#Win_PlaylistGenerator)\posy = WindowY(#Win_PlaylistGenerator)
    WinSize(#Win_PlaylistGenerator)\winid = 0
    WndEx_RemoveWindow(#Win_PlaylistGenerator)
    CloseWindow(#Win_PlaylistGenerator)
  EndIf
EndProcedure

Procedure OpenWindow_PathRequester(Title$, Directory$, Recursive.b)
  If IsWindow(#Win_PathRequester) = 0
    If OpenWindow(#Win_PathRequester, 0, 0, 320, 240, Title$, #PB_Window_Invisible|#PB_Window_ScreenCentered|#PB_Window_SystemMenu|#PB_Window_SizeGadget, WindowID(#Win_Main))
      DisableWindow(#Win_Main, 1)
      
      ExplorerTreeGadget(#G_ET_PathRequester_Overview, 5, 5, 415, 255, "", #PB_Explorer_AlwaysShowSelection|#PB_Explorer_NoDriveRequester|#PB_Explorer_NoFiles)
      CheckBoxGadget(#G_CH_PathRequester_Recursive, 5, 270, 120, 15, "Mit Unterordner")
      ButtonGadget(#G_BN_PathRequester_Cancel, 340, 265, 80, 25, "Abbrechen")
      ButtonGadget(#G_BN_PathRequester_Apply, 255, 265, 80, 25, "OK")
      
      WindowBounds(#Win_PathRequester, WindowWidth(#Win_PathRequester), WindowHeight(#Win_PathRequester), #PB_Ignore, #PB_Ignore)
      
      If WinSize(#Win_PathRequester)\posx = -1 And WinSize(#Win_PathRequester)\posy = -1
        Window_CenterOnWindow(#Win_PathRequester, #Win_Main)
      Else
        ResizeWindow(#Win_PathRequester, WinSize(#Win_PathRequester)\posx, WinSize(#Win_PathRequester)\posy, WinSize(#Win_PathRequester)\width, WinSize(#Win_PathRequester)\height)
      EndIf
      Window_CheckPos(#Win_PathRequester)
     
      If Pref\opacity > 0
        Window_SetLayeredStyle(#Win_PathRequester, 1)
        Window_SetOpacity(#Win_PathRequester, Pref\opacityval)
      EndIf
      
      WinSize(#Win_PathRequester)\winid = WindowID(#Win_PathRequester)
      
      WndEx_AddWindow(#Win_PathRequester)
      
      Window_SetIcon(#Win_PathRequester, ImageList(#ImageList_Folder))
  
      SetGadgetText(#G_ET_PathRequester_Overview, Directory$)
      SetGadgetState(#G_CH_PathRequester_Recursive, Recursive)
      
      HideWindow(#Win_PathRequester, 0)
    EndIf
  EndIf
EndProcedure

Procedure CloseWindow_PathRequester()
  If IsWindow(#Win_PathRequester)
    WinSize(#Win_PathRequester)\posx   = WindowX(#Win_PathRequester)
    WinSize(#Win_PathRequester)\posy   = WindowY(#Win_PathRequester)
    WinSize(#Win_PathRequester)\width  = WindowWidth(#Win_PathRequester)
    WinSize(#Win_PathRequester)\height = WindowHeight(#Win_PathRequester)
    WinSize(#Win_PathRequester)\winid = 0
    WndEx_RemoveWindow(#Win_PathRequester)
    CloseWindow(#Win_PathRequester)
    DisableWindow(#Win_Main, 0)
  EndIf
EndProcedure

Procedure OpenWindow_TaskChange()
  If IsWindow(#Win_TaskChange)
    HideWindow(#Win_TaskChange, 0)
    SetActiveWindow(#Win_TaskChange)
  Else
    If OpenWindow(#Win_TaskChange, 0, 0, 380, 205, "Aufgabe", #PB_Window_Invisible|#PB_Window_SystemMenu, WindowID(#Win_Main))
      TextGadget(#G_TX_TaskChange_Need, 5, 5, 180, 15, "Auslöser")
      ListViewGadget(#G_LV_TaskChange_Need, 5, 20, 180, 150)
      TextGadget(#G_TX_TaskChange_Task, 195, 5, 180, 15, "Aufgabe")
      ListViewGadget(#G_LV_TaskChange_Task, 190, 20, 185, 150)
      ButtonGadget(#G_BN_TaskChange_Apply, 210, 175, 80, 25, "OK")
      ButtonGadget(#G_BN_TaskChange_Cancel, 295, 175, 80, 25, "Abbrechen")
    Else
      MsgBox_Error("Fenster 'TaskChange' konnte nicht erstellt werden.") : End
    EndIf
    
    ;Events
    AddGadgetItem(#G_LV_TaskChange_Need, -1, "Keine Aufgabe")
    AddGadgetItem(#G_LV_TaskChange_Need, -1, "Wiedergabe Beendet")
    AddGadgetItem(#G_LV_TaskChange_Need, -1, "Bildschirmschoner")
    ;Tasks
    AddGadgetItem(#G_LV_TaskChange_Task, -1, "Wiedergabe")
    AddGadgetItem(#G_LV_TaskChange_Task, -1, "Stop")
    AddGadgetItem(#G_LV_TaskChange_Task, -1, "Pause")
    AddGadgetItem(#G_LV_TaskChange_Task, -1, "Vorheriger Titel")
    AddGadgetItem(#G_LV_TaskChange_Task, -1, "Nächster Titel")
    AddGadgetItem(#G_LV_TaskChange_Task, -1, "Computer Herunterfahren")
    AddGadgetItem(#G_LV_TaskChange_Task, -1, #PrgName + " Beenden")
    
    SetGadgetState(#G_LV_TaskChange_Need, Task\event)
    SetGadgetState(#G_LV_TaskChange_Task, Task\task)
    
    If WinSize(#Win_TaskChange)\posx = -1 And WinSize(#Win_TaskChange)\posy = -1
      Window_CenterOnWindow(#Win_TaskChange, #Win_Main)
    Else
      ResizeWindow(#Win_TaskChange, WinSize(#Win_TaskChange)\posx, WinSize(#Win_TaskChange)\posy, #PB_Ignore, #PB_Ignore)
    EndIf
    Window_CheckPos(#Win_TaskChange)
   
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_TaskChange, 1)
      Window_SetOpacity(#Win_TaskChange, Pref\opacityval)
    EndIf
    
    WinSize(#Win_TaskChange)\winid = WindowID(#Win_TaskChange)
    
    WndEx_AddWindow(#Win_TaskChange)
    
    Window_SetIcon(#Win_TaskChange, ImageList(#ImageList_Watch))
    
    HideWindow(#Win_TaskChange, 0)
  EndIf
EndProcedure

Procedure CloseWindow_TaskChange()
  If IsWindow(#Win_TaskChange)
    WinSize(#Win_TaskChange)\posx   = WindowX(#Win_TaskChange)
    WinSize(#Win_TaskChange)\posy   = WindowY(#Win_TaskChange)
    WinSize(#Win_TaskChange)\winid  = 0
    WndEx_RemoveWindow(#Win_TaskChange)
    CloseWindow(#Win_TaskChange)
  EndIf
EndProcedure

Procedure OpenWindow_TaskRun()
  If IsWindow(#Win_TaskRun)
    HideWindow(#Win_TaskRun, 0)
    SetActiveWindow(#Win_TaskRun)
  Else
    If OpenWindow(#Win_TaskRun, 0, 0, 245, 35, "Aufgabe Ausführen..", #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_ScreenCentered, WindowID(#Win_Main))
      ProgressBarGadget(#G_PB_TaskRun, 5, 5, 150, 25, 0, 100)
      ButtonGadget(#G_BN_TaskRun, 160, 5, 80, 25, "STOP")
    Else
      MsgBox_Error("Fenster 'TaskRun' konnte nicht erstellt werden.") : End
    EndIf
    
    If IsWindowVisible_(WinSize(#Win_Main)\winid)
      Window_CenterOnWindow(#Win_TaskRun, #Win_Main)
    EndIf
    
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_TaskRun, 1)
      Window_SetOpacity(#Win_TaskRun, Pref\opacityval)
    EndIf
    
    WinSize(#Win_TaskRun)\winid = WindowID(#Win_TaskRun)
    
    WndEx_AddWindow(#Win_TaskRun)
    
    Window_SetIcon(#Win_TaskRun, ImageList(#ImageList_Watch))
    
    HideWindow(#Win_TaskRun, 0)
  EndIf
EndProcedure

Procedure CloseWindow_TaskRun()
  If IsWindow(#Win_TaskRun)
    Task\cancel = 1
    
    WinSize(#Win_TaskRun)\posx = WindowX(#Win_TaskRun)
    WinSize(#Win_TaskRun)\posy = WindowY(#Win_TaskRun)
    WinSize(#Win_TaskRun)\winid = 0
    WndEx_RemoveWindow(#Win_TaskRun)
    CloseWindow(#Win_TaskRun)
  EndIf
EndProcedure


Procedure OpenWindow_AutoTag()
  If IsWindow(#Win_AutoTag)
    HideWindow(#Win_AutoTag, 0)
    SetActiveWindow(#Win_AutoTag)
  Else
    If OpenWindow(#Win_AutoTag, 0, 0, 480, 320, "Autotager", #PB_Window_Invisible|#PB_Window_SystemMenu, WindowID(#Win_Main))
      ListIconGadget(#G_LI_AutoTag_Overview, 5, 45, 470, 240, "Dateiname", 200, #LVS_NOSORTHEADER)
        AddGadgetColumn(#G_LI_AutoTag_Overview, 1, "Vorschau", 200)
        SendMessage_(GadgetID(#G_LI_AutoTag_Overview), #LVM_SETCOLUMNWIDTHA, 1, #LVSCW_AUTOSIZE_USEHEADER)
      StringGadget(#G_SR_AutoTag_Msterstring, 5, 20, 470, 20, "%title - %artist")
      TextGadget(#G_TX_AutoTag_Musterstring, 5, 5, 470, 15, "Musterstring")
      ButtonGadget(#G_BN_AutoTag_Rename, 310, 290, 80, 25, "Ausführen")
      ButtonGadget(#G_BN_AutoTag_Preview, 5, 290, 80, 25, "Vorschau")
      ButtonGadget(#G_BN_AutoTag_Cancel, 395, 290, 80, 25, "Abbrechen")
    EndIf
    
    If WinSize(#Win_AutoTag)\posx = -1 And WinSize(#Win_AutoTag)\posy = -1
      Window_CenterOnWindow(#Win_AutoTag, #Win_Main)
    Else
      ResizeWindow(#Win_AutoTag, WinSize(#Win_AutoTag)\posx, WinSize(#Win_AutoTag)\posy, #PB_Ignore, #PB_Ignore)
    EndIf
    Window_CheckPos(#Win_AutoTag)
   
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_AutoTag, 1)
      Window_SetOpacity(#Win_AutoTag, Pref\opacityval)
    EndIf
    
    Window_SetIcon(#Win_AutoTag, ImageList(#ImageList_Rename))
    
    WinSize(#Win_AutoTag)\winid = WindowID(#Win_AutoTag)
    
    WndEx_AddWindow(#Win_AutoTag)
    
    HideWindow(#Win_AutoTag, 0)
  EndIf
EndProcedure

Procedure CloseWindow_AutoTag()
  If IsWindow(#Win_AutoTag)
    WinSize(#Win_AutoTag)\posx = WindowX(#Win_AutoTag)
    WinSize(#Win_AutoTag)\posy = WindowY(#Win_AutoTag)
    WinSize(#Win_AutoTag)\winid = 0
    WndEx_RemoveWindow(#Win_AutoTag)
    CloseWindow(#Win_AutoTag)
  EndIf
EndProcedure

Procedure OpenWindow_RadioLog()
  If IsWindow(#Win_RadioLog)
    HideWindow(#Win_RadioLog, 0)
    SetActiveWindow(#Win_RadioLog)
  Else
    If OpenWindow(#Win_RadioLog, 0, 0, 280, 250, "RadioLog", #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_SizeGadget, WindowID(#Win_Main))
      TextGadget(#G_TX_RadioLog_Downloaded, 2, 2, 100, 15, "Downloadtraffic:", #SS_CENTERIMAGE|#SS_LEFTNOWORDWRAP)
      TextGadget(#G_TX_RadioLog_DownloadedV, 104, 2, 100, 15, "", #SS_CENTERIMAGE|#SS_RIGHT)
      ListIconGadget(#G_LI_RadioLog_Overview, 2, 19, WindowWidth(#Win_RadioLog) - 4, WindowHeight(#Win_RadioLog) - 4, "Artist", 100, #PB_ListIcon_GridLines|#LVS_NOSORTHEADER)
        AddGadgetColumn(#G_LI_RadioLog_Overview, 1, "Titel", 100)
        SendMessage_(GadgetID(#G_LI_RadioLog_Overview), #LVM_SETEXTENDEDLISTVIEWSTYLE, 0, SendMessage_(GadgetID(#G_LI_RadioLog_Overview), #LVM_GETEXTENDEDLISTVIEWSTYLE, 0, 0)|#LVS_EX_LABELTIP|#LVS_EX_DOUBLEBUFFER)
    Else
      MsgBox_Error("Fenster 'RadioTrackLog' konnte nicht erstellt werden") : End
    EndIf
    
    ; Init Windows
    WindowBounds(#Win_RadioLog, WindowWidth(#Win_RadioLog), WindowHeight(#Win_RadioLog), #PB_Ignore, #PB_Ignore)
    
    ForEach RadioTrackLog()
      AddGadgetItem(#G_LI_RadioLog_Overview, -1, RadioTrackLog()\artist + Chr(10) + RadioTrackLog()\title)
    Next
    
    If WinSize(#Win_RadioLog)\posx = -1 And WinSize(#Win_RadioLog)\posy = -1
      Window_CenterOnWindow(#Win_RadioLog, #Win_Main)
    Else
      ResizeWindow(#Win_RadioLog, WinSize(#Win_RadioLog)\posx, WinSize(#Win_RadioLog)\posy, WinSize(#Win_RadioLog)\width, WinSize(#Win_RadioLog)\height)
    EndIf
    Window_CheckPos(#Win_RadioLog)
    
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_RadioLog, 1)
      Window_SetOpacity(#Win_RadioLog, Pref\opacityval)
    EndIf
    
    WinSize(#Win_RadioLog)\winid = WindowID(#Win_RadioLog)
    
    WndEx_AddWindow(#Win_RadioLog)
    
    Window_SetIcon(#Win_RadioLog, ImageList(#ImageList_PlayList))
    
    ; Init Gadgets
    If InternetStream\downloaded > 0
      SetGadgetText(#G_TX_RadioLog_DownloadedV, FormatByteSize(InternetStream\downloaded))
    EndIf
    
    HideWindow(#Win_RadioLog, 0)
  EndIf
EndProcedure

Procedure CloseWindow_RadioLog()
  If IsWindow(#Win_RadioLog)
    WinSize(#Win_RadioLog)\posx   = WindowX(#Win_RadioLog)
    WinSize(#Win_RadioLog)\posy   = WindowY(#Win_RadioLog)
    WinSize(#Win_RadioLog)\width  = WindowWidth(#Win_RadioLog)
    WinSize(#Win_RadioLog)\height = WindowHeight(#Win_RadioLog)
    WinSize(#Win_RadioLog)\winid = 0
    WndEx_RemoveWindow(#Win_RadioLog)
    CloseWindow(#Win_RadioLog)
  EndIf
EndProcedure

Procedure OpenWindow_SplashScreen()
  If OpenWindow(#Win_SplashScreen, 0, 0, 380, 110 + 55, #PrgName, #PB_Window_Invisible|#PB_Window_ScreenCentered|#PB_Window_BorderLess, WindowID(#Win_Main))
    ImageGadget(#G_IG_SplashScreen_Image, 0, 0, 380, 139, iImgPrgLogo)
      DisableGadget(#G_IG_SplashScreen_Image, 1)
    TextGadget(#G_TX_SplashScreen_Text, 5, GadgetHeight(#G_IG_SplashScreen_Image) + 7, WindowWidth(#Win_SplashScreen) - 10, 15, "Starte..")
    
    SetWindowColor(#Win_SplashScreen, $665241)
    SetGadgetColor(#G_TX_SplashScreen_Text, #PB_Gadget_BackColor, $665241)
    SetGadgetColor(#G_TX_SplashScreen_Text, #PB_Gadget_FrontColor, $FFFFFF)
    
    SetGadgetData(#G_IG_SplashScreen_Image, timeGetTime_())
    
    HideWindow(#Win_SplashScreen, 0)
  Else
    MsgBox_Error("Fenster 'SplashScreen' konnte nicht geöffnet werden") : End
  EndIf
EndProcedure

Procedure CloseWindow_SplashScreen()
  If IsWindow(#Win_SplashScreen)
    CloseWindow(#Win_SplashScreen)
  EndIf
EndProcedure

Procedure OpenWindow_MidiLyrics()
  
  ; Lyrics
  Protected sText.s
  ForEach MidiLyrics()
    If MidiLyrics()\text = "/"
      sText + #CRLF$
    ElseIf MidiLyrics()\text <> "\" And MidiLyrics()\text <> "@"
      sText + MidiLyrics()\text
    EndIf
  Next
  
  If IsWindow(#Win_MidiLyrics)
    SetGadgetText(#G_ED_MidiLyrics_Text, sText)
  Else
    If OpenWindow(#Win_MidiLyrics, 0, 0, 300, 180, "Midi Lyrics", #PB_Window_Invisible|#PB_Window_WindowCentered|#PB_Window_SizeGadget|#PB_Window_SystemMenu, WindowID(#Win_Main))
      EditorGadget(#G_ED_MidiLyrics_Text, 2, 2, WindowWidth(#Win_MidiLyrics) - 4, WindowHeight(#Win_MidiLyrics) - 4, #ES_READONLY|#ES_MULTILINE|#WS_VSCROLL|#WS_HSCROLL)
    Else
      MsgBox_Error("Fenster 'Midi Lyrics' konnte nicht erstellt werden") : End
    EndIf
    
    WindowBounds(#Win_MidiLyrics, WindowWidth(#Win_MidiLyrics), WindowHeight(#Win_MidiLyrics), #PB_Ignore, #PB_Ignore)
    
    If WinSize(#Win_MidiLyrics)\posx = -1 And WinSize(#Win_MidiLyrics)\posy = -1
      Window_CenterOnWindow(#Win_MidiLyrics, #Win_Main)
    Else
      ResizeWindow(#Win_MidiLyrics, WinSize(#Win_MidiLyrics)\posx, WinSize(#Win_MidiLyrics)\posy, WinSize(#Win_MidiLyrics)\width, WinSize(#Win_MidiLyrics)\height)
    EndIf
    Window_CheckPos(#Win_MidiLyrics)
    
    SetGadgetColor(#G_ED_MidiLyrics_Text, #PB_Gadget_BackColor, Pref\color[#Color_Midi_BG])
    SetGadgetColor(#G_ED_MidiLyrics_Text, #PB_Gadget_FrontColor, Pref\color[#Color_Midi_FG])
    SendMessage_(GadgetID(#G_ED_MidiLyrics_Text), #EM_SETTARGETDEVICE, 0, 0)
    SetGadgetText(#G_ED_MidiLyrics_Text, sText)
    
    If Pref\opacity > 0
      Window_SetLayeredStyle(#Win_MidiLyrics, 1)
      Window_SetOpacity(#Win_MidiLyrics, Pref\opacityval)
    EndIf
    
    WinSize(#Win_MidiLyrics)\winid = WindowID(#Win_MidiLyrics)
    
    WndEx_AddWindow(#Win_MidiLyrics)
    
    Window_SubClass(GadgetID(#G_ED_MidiLyrics_Text), @GadgetCallback_MidiLyrics())
    
    If GUIFont(#Font_MidiLyrics)\activ And IsFont(#Font_MidiLyrics)
      SetGadgetFont(#G_ED_MidiLyrics_Text, FontID(#Font_MidiLyrics))
    EndIf
    
    HideWindow(#Win_MidiLyrics, 0)
  EndIf
EndProcedure

Procedure CloseWindow_MidiLyrics()
  If IsWindow(#Win_MidiLyrics)
    WinSize(#Win_MidiLyrics)\posx   = WindowX(#Win_MidiLyrics)
    WinSize(#Win_MidiLyrics)\posy   = WindowY(#Win_MidiLyrics)
    WinSize(#Win_MidiLyrics)\width  = WindowWidth(#Win_MidiLyrics)
    WinSize(#Win_MidiLyrics)\height = WindowHeight(#Win_MidiLyrics)
    WinSize(#Win_MidiLyrics)\winid = 0
    WndEx_RemoveWindow(#Win_MidiLyrics)
    CloseWindow(#Win_MidiLyrics)
  EndIf
EndProcedure

Procedure OpenWindow_MLPlayList()
  If IsWindow(#Win_MLPlayList)
    HideWindow(#Win_MLPlayList, 0)
    SetActiveWindow(#Win_MLPlayList)
  Else
    If OpenWindow(#Win_MLPlayList, 0, 0, 260, 60, "Wiedergabeliste", #PB_Window_Invisible|#PB_Window_WindowCentered|#PB_Window_SizeGadget|#PB_Window_SystemMenu, WindowID(#Win_Main))
      ComboBoxGadget(#G_CB_MLPlayList, 5, 5, WindowWidth(#Win_MLPlayList) - 10, 20, #PB_ComboBox_Editable)
      
      ButtonGadget(#G_BN_MLPlayList_Remove, 5, WindowHeight(#Win_MLPlayList) - 30, 80, 25, "Entfernen")
      ButtonGadget(#G_BN_MLPlayList_Cancel, 90, WindowHeight(#Win_MLPlayList) - 30, 80, 25, "Abbrechen")
      ButtonGadget(#G_BN_MLPlayList_Set, 175, WindowHeight(#Win_MLPlayList) - 30, 80, 25, "Speichern")
      
      WindowBounds(#Win_MLPlayList, WindowWidth(#Win_MLPlayList), WindowHeight(#Win_MLPlayList), #PB_Ignore, WindowHeight(#Win_MLPlayList))
      
      If WinSize(#Win_MLPlayList)\posx = -1 And WinSize(#Win_MLPlayList)\posy = -1
        Window_CenterOnWindow(#Win_MLPlayList, #Win_Main)
      Else
        ResizeWindow(#Win_MLPlayList, WinSize(#Win_MLPlayList)\posx, WinSize(#Win_MLPlayList)\posy, WinSize(#Win_MLPlayList)\width, WinSize(#Win_MLPlayList)\height)
      EndIf
      Window_CheckPos(#Win_MLPlayList)
      
      If Pref\opacity > 0
        Window_SetLayeredStyle(#Win_MLPlayList, 1)
        Window_SetOpacity(#Win_MLPlayList, Pref\opacityval)
      EndIf
      
      WinSize(#Win_MLPlayList)\winid = WindowID(#Win_MLPlayList)
      
      WndEx_AddWindow(#Win_MLPlayList)
      
      Window_SetIcon(#Win_MLPlayList, ImageList(#ImageList_PlayList))
      
      ForEach MediaLibary_PlayList()
        AddGadgetItem(#G_CB_MLPlayList, -1, MapKey(MediaLibary_PlayList()))
      Next
      
      DisableGadget(#G_BN_MLPlayList_Remove, 1)
      DisableGadget(#G_BN_MLPlayList_Set, 1)
      
      AddKeyboardShortcut(#Win_MLPlayList, #PB_Shortcut_Return, #Shortcut_MLPlayList_Return)
      
      HideWindow(#Win_MLPlayList, 0)
    Else
      MsgBox_Error("Fenster 'MLPlayList' konnte nicht erstellt werden.") : End
    EndIf
    
  EndIf
EndProcedure

Procedure CloseWindow_MLPlayList()
  If IsWindow(#Win_MLPlayList)
    WinSize(#Win_MLPlayList)\posx   = WindowX(#Win_MLPlayList)
    WinSize(#Win_MLPlayList)\posy   = WindowY(#Win_MLPlayList)
    WinSize(#Win_MLPlayList)\width  = WindowWidth(#Win_MLPlayList)
    WinSize(#Win_MLPlayList)\height = WindowHeight(#Win_MLPlayList)
    WinSize(#Win_MLPlayList)\winid = 0
    WndEx_RemoveWindow(#Win_MLPlayList)
    CloseWindow(#Win_MLPlayList)
  EndIf
EndProcedure

Procedure OpenWindow_MLSearchPref()
  If IsWindow(#Win_MLSearchPref)
    HideWindow(#Win_MLSearchPref, 0)
    SetActiveWindow(#Win_MLSearchPref)
  Else
    If OpenWindow(#Win_MLSearchPref, 0, 0, 370, 170, "Erweiterte Suche", #PB_Window_Invisible|#PB_Window_Tool, WindowID(#Win_Main))
      Frame3DGadget(#G_FR_MLSearchPref_SearchIn, 10, 5, 175, 85, "Suchen in")
      CheckBoxGadget(#G_CH_MLSearchPref_SearchInTitle, 20, 25, 70, 15, "Titel")
      CheckBoxGadget(#G_CH_MLSearchPref_SearchInInterpret, 20, 45, 70, 15, "Artist")
      CheckBoxGadget(#G_CH_MLSearchPref_SearchInAlbum, 20, 65, 70, 15, "Album")
      CheckBoxGadget(#G_CH_MLSearchPref_SearchInGenre, 95, 25, 75, 15, "Genre")
      CheckBoxGadget(#G_CH_MLSearchPref_SearchInComment, 95, 45, 75, 15, "Kommentar")
      CheckBoxGadget(#G_CH_MLSearchPref_SearchInPath, 95, 65, 75, 15, "Pfad")
      Frame3DGadget(#G_FR_MLSearchPref_Misc, 195, 5, 165, 140, "Weiteres")
      CheckBoxGadget(#G_CH_MLSearchPref_MiscCaseSensetive, 205, 25, 150, 15, "Groß-/Kleinschreibung", #PB_CheckBox_Center)
        GadgetToolTip(#G_CH_MLSearchPref_MiscCaseSensetive, "Beachtet die Groß-/Kleinschreibung")
      CheckBoxGadget(#G_CH_MLSearchPref_MiscWholeWords, 205, 45, 150, 15, "Nur ganze Wörter", #PB_CheckBox_Center)
        GadgetToolTip(#G_CH_MLSearchPref_MiscWholeWords, "Sucht nach Ganzen Wörtern")
      CheckBoxGadget(#G_CH_MLSearchPref_MiscPlayed, 205, 65, 150, 15, "Bereits abgespielt", #PB_CheckBox_Center)
        GadgetToolTip(#G_CH_MLSearchPref_MiscPlayed, "Nur bereits abgespielte Dateien")
      CheckBoxGadget(#G_CH_MLSearchPref_MiscOr, 205, 85, 150, 15, "Leerzeichen = ODER", #PB_CheckBox_Center)
        GadgetToolTip(#G_CH_MLSearchPref_MiscOr, "Bei der Suche muss lediglich einer der Suchbegriffe vorkommen")
      CheckBoxGadget(#G_TX_MLSearchPref_MaxCount, 205, 117, 90, 15, "Max. Einträge")
        GadgetToolTip(#G_TX_MLSearchPref_MaxCount, "Legt fest, wie viel Einträge max. angezeigt werden.")
      StringGadget(#G_SR_MLSearchPref_MaxCount, 297, 115, 50, 20, "")
      Frame3DGadget(#G_FR_MLSearchPref_Length, 10, 95, 175, 65, "Länge")
      TextGadget(#G_TX_MLSearchPref_LengthMin, 20, 115, 50, 15, "Min.", #SS_CENTERIMAGE)
      StringGadget(#G_SR_MLSearchPref_LengthMin, 20, 130, 50, 20, "")
        SendMessage_(GadgetID(#G_SR_MLSearchPref_LengthMin), #EM_LIMITTEXT, 5, 0)
        GadgetToolTip(#G_SR_MLSearchPref_LengthMin, "Minimale Länge in Sekunden")
      TextGadget(#G_TX_MLSearchPref_LengthMax, 75, 115, 50, 15, "Max.", #SS_CENTERIMAGE)
      StringGadget(#G_SR_MLSearchPref_LengthMax, 75, 130, 50, 20, "")
        SendMessage_(GadgetID(#G_SR_MLSearchPref_LengthMax), #EM_LIMITTEXT, 5, 0)
        GadgetToolTip(#G_SR_MLSearchPref_LengthMax, "Maximale Länge in Sekunden")
      
      ; SucheIn
      If Pref\medialib_searchin & #MediaLib_SearchIn_Title
        SetGadgetState(#G_CH_MLSearchPref_SearchInTitle, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_Artist
        SetGadgetState(#G_CH_MLSearchPref_SearchInInterpret, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_Album
        SetGadgetState(#G_CH_MLSearchPref_SearchInAlbum, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_Genre
        SetGadgetState(#G_CH_MLSearchPref_SearchInGenre, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_Comment
        SetGadgetState(#G_CH_MLSearchPref_SearchInComment, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_Path
        SetGadgetState(#G_CH_MLSearchPref_SearchInPath, 1)
      EndIf
      ; Weiteres
      If Pref\medialib_searchin & #MediaLib_SearchIn_CaseSens
        SetGadgetState(#G_CH_MLSearchPref_MiscCaseSensetive, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_WholeWords
        SetGadgetState(#G_CH_MLSearchPref_MiscWholeWords, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_Played
        SetGadgetState(#G_CH_MLSearchPref_MiscPlayed, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_Or
        SetGadgetState(#G_CH_MLSearchPref_MiscOr, 1)
      EndIf
      If Pref\medialib_searchin & #MediaLib_SearchIn_MaxCount
        SetGadgetState(#G_TX_MLSearchPref_MaxCount, 1)
      Else
        DisableGadget(#G_SR_MLSearchPref_MaxCount, 1)
      EndIf
      ; Länge
      If Pref\medialib_searchlength[0] > 0
        SetGadgetText(#G_SR_MLSearchPref_LengthMin, Str(Pref\medialib_searchlength[0]))
      EndIf
      If Pref\medialib_searchlength[1] > 0
        SetGadgetText(#G_SR_MLSearchPref_LengthMax, Str(Pref\medialib_searchlength[1]))
      EndIf
      ; Max Count
      If Pref\medialib_maxsearchcount > 0
        SetGadgetText(#G_SR_MLSearchPref_MaxCount, Str(Pref\medialib_maxsearchcount))
      EndIf
      
      ; Fensterposition
      Protected P.POINT
      
      P\x = Window_GetClientPosX(#Win_Main) + GadgetX(#G_BN_Main_ML_SearchOptions) + GadgetWidth(#G_BN_Main_ML_SearchOptions) - Window_GetWidth(#Win_MLSearchPref)
      P\y = Window_GetClientPosY(#Win_Main) + GadgetY(#G_BN_Main_ML_SearchOptions) + GadgetHeight(#G_BN_Main_ML_SearchOptions) + 2
      
      ResizeWindow(#Win_MLSearchPref, P\x, P\y, #PB_Ignore, #PB_Ignore)
      
      ; Sonstiges
      If Pref\opacity > 0
        Window_SetLayeredStyle(#Win_MLSearchPref, 1)
        Window_SetOpacity(#Win_MLSearchPref, Pref\opacityval)
      EndIf
      
      WinSize(#Win_MLSearchPref)\winid = WindowID(#Win_MLSearchPref)
      
      WndEx_AddWindow(#Win_MLSearchPref)
      HideWindow(#Win_MLSearchPref, 0)
      SetActiveWindow(#Win_MLSearchPref)
    Else
      MsgBox_Error("Fenster 'MLSearchPref' konnte nicht erstellt werden") : End
    EndIf
  EndIf
EndProcedure

Procedure CloseWindow_MLSearchPref()
  If IsWindow(#Win_MLSearchPref)
    WinSize(#Win_MLSearchPref)\winid = 0
    WndEx_RemoveWindow(#Win_MLSearchPref)
    CloseWindow(#Win_MLSearchPref)
  EndIf
EndProcedure

Procedure OpenWindow_Feedback()
  If IsWindow(#Win_Feedback)
    HideWindow(#Win_Feedback, 0)
    SetActiveWindow(#Win_Feedback)
  Else
    If OpenWindow(#Win_Feedback, 0, 0, 425, 320, "Feedback", #PB_Window_Invisible|#PB_Window_SystemMenu|#PB_Window_SizeGadget, WindowID(#Win_Main))
      TextGadget(#G_TX_Feedback_Name, 5, 5, 60, 20, "Name:", #SS_CENTERIMAGE|#SS_LEFT)
      StringGadget(#G_SR_Feedback_Name, 70, 5, 220, 20, "")
      ImageGadget(#G_IG_Feedback_Name, 292, 7, 16, 16, 0)
        DisableGadget(#G_IG_Feedback_Name, 1)
      TextGadget(#G_TX_Feedback_Mail, 5, 30, 60, 20, "E-Mail:", #SS_CENTERIMAGE|#SS_LEFT)
      StringGadget(#G_SR_Feedback_Mail, 70, 30, 220, 20, "")
      ImageGadget(#G_IG_Feedback_Mail, 292, 32, 16, 16, 0)
        DisableGadget(#G_IG_Feedback_Mail, 1)
      TextGadget(#G_TX_Feedback_Subject, 5, 55, 60, 20, "Betreff:", #SS_CENTERIMAGE|#SS_LEFT)
      ComboBoxGadget(#G_CB_Feedback_Subject, 70, 55, 220, 20, #PB_ComboBox_Editable)
        AddGadgetItem(#G_CB_Feedback_Subject, -1, "Allgemein")
        AddGadgetItem(#G_CB_Feedback_Subject, -1, "Lob")
        AddGadgetItem(#G_CB_Feedback_Subject, -1, "Kritik")
        AddGadgetItem(#G_CB_Feedback_Subject, -1, "Fehlermeldung")
        AddGadgetItem(#G_CB_Feedback_Subject, -1, "Vermisste Funktionen")
        AddGadgetItem(#G_CB_Feedback_Subject, -1, "Sonstiges")
        SetGadgetState(#G_CB_Feedback_Subject, 0)
      ImageGadget(#G_IG_Feedback_Subject, 292, 57, 16, 16, 0)
        DisableGadget(#G_IG_Feedback_Subject, 1)
      TextGadget(#G_TX_Feedback_Message, 5, 80, 280, 15, "Nachricht:")
      StringGadget(#G_SR_Feedback_Message, 5, 95, 0, 0, "", #ES_MULTILINE|#ES_AUTOVSCROLL|#WS_VSCROLL)
      ImageGadget(#G_IG_Feedback_Message, WindowWidth(#Win_Feedback) - 21, 74, 16, 16, 0)
        DisableGadget(#G_IG_Feedback_Message, 1)
      Frame3DGadget(#G_FR_Feedback_Gap, -5, WindowHeight(#Win_Feedback) - 37, WindowWidth(#Win_Feedback) + 10, 2, "", #PB_Frame3D_Single)
      ButtonGadget(#G_BN_Feedback_Reset, WindowWidth(#Win_Feedback) - 275, WindowHeight(#Win_Feedback) - 30, 100, 25, "Zurücksetzen")
      ButtonGadget(#G_BN_Feedback_Send, WindowWidth(#Win_Feedback) - 170, WindowHeight(#Win_Feedback) - 30, 80, 25, "Senden")
        DisableGadget(#G_BN_Feedback_Send, 1)
      ButtonGadget(#G_BN_Feedback_Cancel, WindowWidth(#Win_Feedback) - 85, WindowHeight(#Win_Feedback) - 30, 80, 25, "Abbrechen")
      HyperLinkGadget(#G_HL_Feedback_URL, 5, WindowHeight(#Win_Feedback) - 20, 100, 15, "Homepage", $C16C3E)
      
      WindowBounds(#Win_Feedback, WindowWidth(#Win_Feedback), WindowHeight(#Win_Feedback), #PB_Ignore, #PB_Ignore)
      
      If WinSize(#Win_Feedback)\posx = -1 And WinSize(#Win_Feedback)\posy = -1
        Window_CenterOnWindow(#Win_Feedback, #Win_Main)
      Else
        ResizeWindow(#Win_Feedback, WinSize(#Win_Feedback)\posx, WinSize(#Win_Feedback)\posy, WinSize(#Win_Feedback)\width, WinSize(#Win_Feedback)\height)
      EndIf
      Window_CheckPos(#Win_Feedback)
      
      If Pref\opacity > 0
        Window_SetLayeredStyle(#Win_Feedback, 1)
        Window_SetOpacity(#Win_Feedback, Pref\opacityval)
      EndIf
      
      WinSize(#Win_Feedback)\winid = WindowID(#Win_Feedback)
      
      WndEx_AddWindow(#Win_Feedback)
      
      Window_SetIcon(#Win_Feedback, ImageList(#ImageList_Feedback))
      
      HideWindow(#Win_Feedback, 0)
      
      SetActiveGadget(#G_SR_Feedback_Name)
    EndIf
  EndIf
EndProcedure

Procedure CloseWindow_Feedback()
  If IsWindow(#Win_Feedback)
    WinSize(#Win_Feedback)\posx  = WindowX(#Win_Feedback)
    WinSize(#Win_Feedback)\posy  = WindowY(#Win_Feedback)
    WinSize(#Win_Feedback)\winid = 0
    WndEx_RemoveWindow(#Win_Feedback)
    CloseWindow(#Win_Feedback)
  EndIf
EndProcedure

Procedure CloseWindowOwn(Window)
  Select GetActiveWindow()
    Case #Win_Preferences       : CloseWindow_Preferences()
    Case #Win_Statistics        : CloseWindow_Statistics()
    Case #Win_Effects           : CloseWindow_Effects()
    Case #Win_Search            : CloseWindow_Search()
    Case #Win_Info              : CloseWindow_Info()
    Case #Win_Log               : CloseWindow_Log()
    Case #Win_Metadata          : CloseWindow_Metadata()
    Case #Win_PlaylistGenerator : CloseWindow_PlayListGenerator()
    Case #Win_PathRequester     : CloseWindow_PathRequester()
    Case #Win_TaskChange        : CloseWindow_TaskChange()
    Case #Win_TaskRun           : CloseWindow_TaskRun()
    Case #Win_RadioLog          : CloseWindow_RadioLog()
    Case #Win_MidiLyrics        : CloseWindow_MidiLyrics()
    Case #Win_AutoTag           : CloseWindow_AutoTag()
    Case #Win_MLPlayList        : CloseWindow_MLPlayList()
    Case #Win_Feedback          : CloseWindow_Feedback()
    Case #Win_MLSearchPref      : CloseWindow_MLSearchPref()
  EndSelect
EndProcedure

; Versteckt alle Fenster
; wird z.B. beim minimieren benutzt
Procedure HideAllWindow(IgnoreWindow = -1)
  Protected iNext.i
  
  For iNext = #Win_Main To #Win_Last - 1
    If iNext <> IgnoreWindow
      If IsWindow(iNext)
        HideWindow(iNext, 1)
      EndIf
    EndIf
  Next
EndProcedure

; Zeigt alle offenen Fenster an
; wird z.B. beim wiederherstellen benutzt
Procedure ShowAllWindow(IgnoreWindow = -1)
  Protected iNext.i
  
  For iNext = #Win_Main To #Win_Last - 1
    If iNext <> IgnoreWindow
      If IsWindow(iNext) > 0
        Window_CheckPos(iNext)
        HideWindow(iNext, 0)
      EndIf
    EndIf
  Next
EndProcedure

; Schließt alle offenen Fenster
; wird z.B. beim Beenden benutzt
Procedure CloseAllWindows()
  Protected iNext.i
  
  For iNext = #Win_Main + 1 To #Win_Last - 1
    If IsWindow(iNext) > 0
      DisableWindow(iNext, 1)
      CloseWindow(iNext)
    EndIf
  Next
EndProcedure
; IDE Options = PureBasic 4.41 (Windows - x86)
; CursorPosition = 1324
; FirstLine = 1228
; Folding = --------
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant