; Programmschleife
;
; Letzte Bearbeitung: 28.11.2009

Procedure Main()
  Protected Event._WinLoop
  
  Application_Start()
  
  Repeat
    Event\WindowEvent  = WaitWindowEvent()
    Event\EventWindow  = EventWindow()
    Event\EventGadget  = EventGadget()
    Event\EventMenu    = EventMenu()
    Event\EventType    = EventType()
    Event\EventlParam  = EventlParam()
    Event\EventwParam  = EventwParam()
    Event\ActiveWindow = GetActiveWindow()
    Event\ActiveGadget = GetActiveGadget()
    
    If Update\UpdateReady
      Application_End(1)
    EndIf
    
    Select Event\WindowEvent
      
      ;- WM_MouseMove
      Case #WM_MOUSEMOVE
        If CurrPlay\file
          ChangeCursor(#G_TX_Main_IA_InfoDesc1, iCursor_Hand)
        EndIf
        ChangeCursor(#G_IG_Main_IA_PrgLogo, iCursor_Hand)
      
      ;- WM_MouseWheel
      Case #WM_MOUSEWHEEL
        If Event\ActiveGadget = #G_TB_Main_IA_Volume
          SetFocus_(WinSize(#Win_Main)\winid)
        EndIf
        If Event\ActiveGadget = -1
          wMouseWheel = ((Event\EventwParam >> 16) & $FFFF)
          wMouseWheel / 120
          SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume) + (wMouseWheel * 5))
          Bass_Volume()
        EndIf
        
      ;- PB_Event_Gadget
      Case #PB_Event_Gadget
        Select Event\EventWindow
          ; ############################################
          ; Hauptfenster
          Case #Win_Main
            Select Event\EventGadget
              Case #G_SP_Main_ML_Vertical
                Window_ResizeGadgets(#Win_Main)
              Case #G_TX_Main_IA_InfoDesc1
                MetaData_CurrPlay()
              Case #G_LI_Main_PL_PlayList
                If Event\EventType = #PB_EventType_LeftDoubleClick
                  If GetGadgetState(#G_LI_Main_PL_PlayList) > -1
                    PlayList_Play()
                  EndIf
                EndIf
                If Event\EventType = #PB_EventType_RightClick
                  PlayList_RefreshMenu()
                  DisplayPopupMenu(#Menu_PlayList, WindowID(#Win_Main))
                EndIf
                If Event\EventType = #PB_EventType_DragStart
                  If GetGadgetState(#G_LI_Main_PL_PlayList) > -1
                    SelectElement(PlayList(), GetGadgetState(#G_LI_Main_PL_PlayList))
                    DragPrivate(#PrivateDrop_InfoArea)
                  EndIf
                EndIf
              Case #G_LI_Main_ML_MediaLib
                If Event\EventType = #PB_EventType_LeftDoubleClick
                  If GetGadgetState(#G_LI_Main_ML_MediaLib) > -1 And GetGadgetState(#G_LI_Main_ML_MediaLib) <= ListSize(MediaLibarySearch()) - 1
                    SelectElement(MediaLibarySearch(), GetGadgetState(#G_LI_Main_ML_MediaLib))
                    Bass_PlayMedia(MediaLibarySearch()\file, #PlayType_MediaLibary)
                  EndIf
                ElseIf Event\EventType = #PB_EventType_RightClick
                  MediaLib_FormatPopUp()
                  If GetGadgetState(#G_LV_Main_ML_Category) = #MediaLib_Categorie_Internet
                    DisplayPopupMenu(#Menu_MediaLib_Inet, WindowID(#Win_Main))
                  Else
                    DisplayPopupMenu(#Menu_MediaLibary, WindowID(#Win_Main))
                  EndIf
                ElseIf Event\EventType = #PB_EventType_DragStart
                  If GetGadgetState(#G_LI_Main_ML_MediaLib) > -1
                    SelectElement(MediaLibarySearch(), GetGadgetState(#G_LI_Main_ML_MediaLib))
                    DragPrivate(#PrivateDrop_MediaLib)
                  EndIf
                EndIf
              Case #G_SR_Main_ML_Search
                If Event\EventType = #CBN_SETFOCUS
                  SendMessage_(GadgetID(#G_SR_Main_ML_Search), #EM_SETSEL, 0, -1)
                ElseIf Event\EventType = #CBN_SELCHANGE Or Event\EventType = #CBN_EDITCHANGE
                  If Len(Trim(GetGadgetText(#G_SR_Main_ML_Search))) > 2
                    If Event\EventType <> #CBN_SELCHANGE
                      MediaLib_AutoComplete()
                    EndIf
                    DisableGadget(#G_BN_Main_ML_Search, 0)
                  Else
                    DisableGadget(#G_BN_Main_ML_Search, 1)
                  EndIf
                EndIf
              Case #G_TB_Main_IA_Volume
                Bass_Volume()
              Case #G_TB_Main_IA_Position
                Bass_SetPos()
                SetFocus_(WinSize(#Win_Main)\winid)              
              Case #G_IG_Main_IA_PrgLogo
                If Event\EventType = #PB_EventType_LeftClick
                  OpenWindow_Info()
                EndIf
              Case #G_LV_Main_ML_Category
                Select GetGadgetState(#G_LV_Main_ML_Category)
                  Case #MediaLib_Categorie_Database
                    MediaLib_ShowDatabase(#MediaLib_Show_Normal)
                  Case #MediaLib_Categorie_MostPlay
                    MediaLib_ShowDatabase(#MediaLib_Show_MostPlay)
                  Case #MediaLib_Categorie_LastPlay
                    MediaLib_ShowDatabase(#MediaLib_Show_LastPlay)
                  Case #MediaLib_Categorie_NeverPlay
                    MediaLib_ShowDatabase(#MediaLib_Show_NeverPlay)
                  Case #MediaLib_Categorie_Longest
                    MediaLib_ShowDatabase(#MediaLib_Show_Longest)
                  Case #MediaLib_Categorie_LastAdded
                    MediaLib_ShowDatabase(#MediaLib_Show_LastAdded)
                  Case #MediaLib_Categorie_Rating
                    MediaLib_ShowDatabase(#MediaLib_Show_Rating)
                  Case #MediaLib_Categorie_Bookmark
                    MediaLib_ShowDatabase(#MediaLib_Show_Bookmarks)
                  Case #MediaLib_Categorie_Internet
                    MediaLib_ShowDatabase(#MediaLib_Show_InternetStreams)
                EndSelect
              Case #G_CB_Main_ML_MiscType
                If GetGadgetState(#G_CB_Main_ML_MiscType) <> Pref\Misc_MLMisc
                  Pref\Misc_MLMisc = GetGadgetState(#G_CB_Main_ML_MiscType)
                  MediaLib_ShowMisc()
                EndIf
              Case #G_BN_Main_ML_Search
                MediaLib_ShowDatabase(#MediaLib_Show_Search)
              Case #G_LI_Main_ML_Misc
                If GetGadgetState(#G_LI_Main_ML_Misc) > -1
                  If GetGadgetState(#G_CB_Main_ML_MiscType) = 3
                    MediaLib_ShowDatabase(#MediaLib_Show_PlayList)
                  Else
                    MediaLib_ShowDatabase(#MediaLib_Show_Misc)
                  EndIf
                EndIf
              Case #G_BN_Main_ML_SearchOptions
                OpenWindow_MLSearchPref()
              Case #G_SP_Main_ML_Vertical
                SetGadgetItemAttribute(#G_LI_Main_ML_Misc, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Main_ML_Misc)), 0)
            EndSelect
          ; ############################################
          ; Feedback
          Case #Win_Feedback
            Select Event\EventGadget
              Case #G_BN_Feedback_Cancel
                CloseWindow_Feedback()
              Case #G_BN_Feedback_Reset
                Feedback_Reset()
              Case #G_BN_Feedback_Send
                Feedback_Send()
              Case #G_HL_Feedback_URL
                RunProgram(#URLFeedback)
            EndSelect
            Feedback_CheckInputs()
          ; ############################################
          ; Medienbibliothek Sucheinstellungen
          Case #Win_MLSearchPref
            Select Event\EventGadget
              Case #G_CH_MLSearchPref_SearchInTitle
                If GetGadgetState(#G_CH_MLSearchPref_SearchInTitle)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Title
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Title
                EndIf
              Case #G_CH_MLSearchPref_SearchInInterpret
                If GetGadgetState(#G_CH_MLSearchPref_SearchInInterpret)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Artist
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Artist
                EndIf
              Case #G_CH_MLSearchPref_SearchInAlbum
                If GetGadgetState(#G_CH_MLSearchPref_SearchInAlbum)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Album
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Album
                EndIf
              Case #G_CH_MLSearchPref_SearchInGenre
                If GetGadgetState(#G_CH_MLSearchPref_SearchInGenre)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Genre
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Genre
                EndIf
              Case #G_CH_MLSearchPref_SearchInComment
                If GetGadgetState(#G_CH_MLSearchPref_SearchInComment)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Comment
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Comment
                EndIf
              Case #G_CH_MLSearchPref_SearchInPath
                If GetGadgetState(#G_CH_MLSearchPref_SearchInPath)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Path
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Path
                EndIf
              Case #G_CH_MLSearchPref_MiscCaseSensetive
                If GetGadgetState(#G_CH_MLSearchPref_MiscCaseSensetive)
                  Pref\medialib_searchin | #MediaLib_SearchIn_CaseSens
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_CaseSens
                EndIf
              Case #G_CH_MLSearchPref_MiscWholeWords
                If GetGadgetState(#G_CH_MLSearchPref_MiscWholeWords)
                  Pref\medialib_searchin | #MediaLib_SearchIn_WholeWords
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_WholeWords
                EndIf
              Case #G_CH_MLSearchPref_MiscPlayed
                If GetGadgetState(#G_CH_MLSearchPref_MiscPlayed)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Played
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Played
                EndIf
              Case #G_CH_MLSearchPref_MiscOr
                If GetGadgetState(#G_CH_MLSearchPref_MiscOr)
                  Pref\medialib_searchin | #MediaLib_SearchIn_Or
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_Or
                EndIf
              Case #G_TX_MLSearchPref_MaxCount
                If GetGadgetState(#G_TX_MLSearchPref_MaxCount)
                  Pref\medialib_searchin | #MediaLib_SearchIn_MaxCount
                Else
                  Pref\medialib_searchin &~ #MediaLib_SearchIn_MaxCount
                EndIf
                DisableGadget(#G_SR_MLSearchPref_MaxCount, GetGadgetState(#G_TX_MLSearchPref_MaxCount)!1)
              Case #G_SR_MLSearchPref_MaxCount
                If Event\EventType = #PB_EventType_Change And Val(GetGadgetText(#G_SR_MLSearchPref_MaxCount)) >= 0
                  Pref\medialib_maxsearchcount = Val(GetGadgetText(#G_SR_MLSearchPref_MaxCount))
                EndIf
              Case #G_SR_MLSearchPref_LengthMin
                Pref\medialib_searchlength[0] = Val(GetGadgetText(#G_SR_MLSearchPref_LengthMin))
              Case #G_SR_MLSearchPref_LengthMax
                Pref\medialib_searchlength[1] = Val(GetGadgetText(#G_SR_MLSearchPref_LengthMax))
            EndSelect
          ; ############################################
          ; Statistiken
          Case #Win_Statistics
            Select Event\EventGadget
              Case #G_TR_Statistics_Menu
                Statistics_ChangeArea()
              Case #G_BN_Statistics_Refresh
                Statistics_RefreshArea()
              Case #G_BN_Statistics_Reset
                Statistics_Reset()
              Case #G_BN_Statistics_Close
                CloseWindow_Statistics()
            EndSelect
          ; ############################################
          ; MedienBibliothek Senden an 'Wiedergabeliste'
          Case #Win_MLPlayList
            Select Event\EventGadget
              Case #G_BN_MLPlayList_Cancel
                CloseWindow_MLPlayList()
              Case #G_BN_MLPlayList_Set
                MediaLib_SetPlayList()
              Case #G_CB_MLPlayList
                If Trim(GetGadgetText(#G_CB_MLPlayList))
                   DisableGadget(#G_BN_MLPlayList_Remove, 0)
                   DisableGadget(#G_BN_MLPlayList_Set, 0)
                Else
                   DisableGadget(#G_BN_MLPlayList_Remove, 1)
                   DisableGadget(#G_BN_MLPlayList_Set, 1)                  
                EndIf
              Case #G_BN_MLPlayList_Remove
                MediaLib_RemovePlayList()
            EndSelect
          ; ############################################
          ; Einstellungen
          Case #Win_Preferences
            Select Event\EventGadget
              ; Main
              Case #G_LV_Preferences_Menu
                Preferences_ChangeArea(GetGadgetState(#G_LV_Preferences_Menu))
              Case #G_BN_Preferences_Reset
                Preferences_Init()
              Case #G_BN_Preferences_Use
                Preferences_Apply()
              Case #G_BN_Preferences_Apply
                Preferences_Apply()
                CloseWindow_Preferences()
              Case #G_BN_Preferences_Cancel
                CloseWindow_Preferences()
              ; BASS
              Case #G_CB_Preferences_Bass_OutputDevice
                GadgetToolTip(#G_CB_Preferences_Bass_OutputDevice, GetGadgetText(#G_CB_Preferences_Bass_OutputDevice))
              Case #G_CB_Preferences_Bass_OutputRate
                GadgetToolTip(#G_CB_Preferences_Bass_OutputRate, GetGadgetText(#G_CB_Preferences_Bass_OutputRate))
              Case #G_TB_Preferences_Bass_FadeIn
                If GetGadgetState(#G_TB_Preferences_Bass_FadeIn) = 0
                  SetGadgetText(#G_TX_Preferences_Bass_FadeIn, "Einblenden (Aus)")
                Else
                  SetGadgetText(#G_TX_Preferences_Bass_FadeIn, "Einblenden (" + Str(GetGadgetState(#G_TB_Preferences_Bass_FadeIn)) + " Sek.)")
                EndIf
              Case #G_TB_Preferences_Bass_FadeOut
                If GetGadgetState(#G_TB_Preferences_Bass_FadeOut) = 0
                  SetGadgetText(#G_TX_Preferences_Bass_FadeOut, "Ausblenden (Aus)")
                Else
                  SetGadgetText(#G_TX_Preferences_Bass_FadeOut, "Ausblenden (" + Str(GetGadgetState(#G_TB_Preferences_Bass_FadeOut)) + " Sek.)")
                EndIf
              Case #G_TB_Preferences_Bass_FadeOutEnd
                If GetGadgetState(#G_TB_Preferences_Bass_FadeOutEnd) = 0
                  SetGadgetText(#G_TX_Preferences_Bass_FadeOutEnd, "Ausblenden Beenden (Aus)")
                Else
                  SetGadgetText(#G_TX_Preferences_Bass_FadeOutEnd, "Ausblenden Beenden (" + Str(GetGadgetState(#G_TB_Preferences_Bass_FadeOutEnd)) + " Sek.)")
                EndIf
              Case #G_TB_Preferences_Bass_PreviewTime
                SetGadgetText(#G_TX_Preferences_Bass_PreviewTime, "Vorschaumodus (" + Str(GetGadgetState(#G_TB_Preferences_Bass_PreviewTime)) + "%)")
              Case #G_BN_Preferences_Bass_MidiSF2File
                Preferences_ChangeMidiSF2File()
              ; Medienbibliothek
              Case #G_BI_Preferences_MediaLib_PathAdd
                Preferences_AddPath()
              Case #G_BI_Preferences_MediaLib_PathRem
                Preferences_RemPath()
              Case #G_BI_Preferences_MediaLib_FindInvalidFiles
                If IsThread(MediaLibScan\Thread) = 0
                  MediaLibScan\FolderScan = 0
                  MediaLib_StartScan()
                EndIf
              Case #G_BI_Preferences_MediaLib_Scan
                If IsThread(MediaLibScan\Thread)
                  MediaLibScan\Cancel = 1
                Else
                  MediaLibScan\FolderScan = 1
                  MediaLib_StartScan()
                EndIf
              ; Oberfläche
              Case #G_LI_Preferences_GUI_Layout
                Preferences_ChangeLayout()
              Case #G_CB_Preferences_GUI_LayoutTheme
                If GetGadgetData(#G_CB_Preferences_GUI_LayoutTheme) <> GetGadgetState(#G_CB_Preferences_GUI_LayoutTheme)
                  SetGadgetData(#G_CB_Preferences_GUI_LayoutTheme, GetGadgetState(#G_CB_Preferences_GUI_LayoutTheme))
                  Preferences_ColorThema_Open()
                EndIf
              Case #G_BN_Preferences_GUI_LayoutThemeSave
                Preferences_ColorThema_Save()
              Case #G_LI_Preferences_GUI_FontsOverview
                If Event\EventType = #PB_EventType_LeftDoubleClick
                  Preferences_ChangeFont()
                EndIf
              ; Dateierweiterungen
              Case #G_BN_Preferences_Filelink_All
                For iNext = 0 To CountGadgetItems(#G_LI_Preferences_Filelink_OverView) - 1
                  SetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext, GetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext) | #PB_ListIcon_Checked)
                Next
              Case #G_BN_Preferences_Filelink_None
                For iNext = 0 To CountGadgetItems(#G_LI_Preferences_Filelink_OverView) - 1
                  SetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext, GetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext) &~ #PB_ListIcon_Checked)
                Next
              ; Shortcuts
              Case #G_LI_Preferences_HotKey_Overview
                Preferences_ChangeHotKeyState()
              Case #G_CH_Preferences_HotKey_Control , #G_CH_Preferences_HotKey_Menu , #G_CH_Preferences_HotKey_Shift
                Preferences_SetHotKeyState()
              Case #G_CB_Preferences_HotKey_Misc
                If Event\EventType = #PB_EventType_RightClick
                  Preferences_SetHotKeyState()
                EndIf
              Case #G_CH_Preferences_HotKey_EnableGlobal
                If GetGadgetState(#G_CH_Preferences_HotKey_EnableGlobal)
                  DisableGadget(#G_LI_Preferences_HotKey_Overview, 0)
                Else
                  DisableGadget(#G_LI_Preferences_HotKey_Overview, 1)
                  SetGadgetState(#G_LI_Preferences_HotKey_Overview, -1)
                  DisableGadget(#G_CH_Preferences_HotKey_Control, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Control, 0)
                  DisableGadget(#G_CH_Preferences_HotKey_Menu, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Menu, 0)
                  DisableGadget(#G_CH_Preferences_HotKey_Shift, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Shift, 0)
                  DisableGadget(#G_CB_Preferences_HotKey_Misc, 1) : SetGadgetState(#G_CB_Preferences_HotKey_Misc, 0)
                EndIf
              ; Tracker
              Case #G_BN_Preferences_Tracker_Preview
                OpenWindow_Tracker(1)
              Case #G_TB_Preferences_Tracker_Time
                SetGadgetText(#G_TX_Preferences_Tracker_Time, "Einblendzeit (" + Str(GetGadgetState(#G_TB_Preferences_Tracker_Time)) + " Sekunden)")
              ; InternetRadio
              Case #G_BN_Preferences_InetStream_FilePath
                Preferences_ChangeSaveFolder()
              Case #G_CH_Preferences_InetStream_SaveFile
                Pref\inetstream_savefile = GetGadgetState(#G_CH_Preferences_InetStream_SaveFile)
                If Pref\inetstream_savefile
                  Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Record, #ImageList_RecordOn)
                Else
                  Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Record, #ImageList_RecordOff)
                EndIf
              Case #G_TB_Preferences_InetStream_TimeOut
                SetGadgetText(#G_TX_Preferences_InetStream_TimeOut, "TimeOut (" + Str(GetGadgetState(#G_TB_Preferences_InetStream_TimeOut)) + " Sekunden)")
              Case #G_TB_Preferences_InetStream_Buffer
                SetGadgetText(#G_TX_Preferences_InetStream_Buffer, "Buffer (" + Str(GetGadgetState(#G_TB_Preferences_InetStream_Buffer)) + " Sekunden)")
              ; Aufgaben
              Case #G_TB_Preferences_Order_TimeOut
                If GetGadgetState(#G_TB_Preferences_Order_TimeOut) = 0
                  SetGadgetText(#G_TX_Preferences_Order_TimeOut, "Verzögerung (Aus)")
                Else
                  SetGadgetText(#G_TX_Preferences_Order_TimeOut, "Verzögerung (" + Str(GetGadgetState(#G_TB_Preferences_Order_TimeOut)) + " Sek.)")
                EndIf
              ; Plugins
              Case #G_LI_Preferences_Plugins_RegPlugins
                If Event\EventType = #PB_EventType_RightClick
                  If GetGadgetState(#G_LI_Preferences_Plugins_RegPlugins) = -1
                    DisableMenuItem(#Menu_RegPlugins, #Mnu_RegPlugins_Preferences, 1)
                    DisableMenuItem(#Menu_RegPlugins, #Mnu_RegPlugins_End, 1)
                  Else
                    DisableMenuItem(#Menu_RegPlugins, #Mnu_RegPlugins_Preferences, 0)
                    DisableMenuItem(#Menu_RegPlugins, #Mnu_RegPlugins_End, 0)                
                  EndIf
                  DisplayPopupMenu(#Menu_RegPlugins, WindowID(#Win_Preferences))
                EndIf
              Case #G_LI_Preferences_Plugins_RunPlugins
                If Event\EventType = #PB_EventType_LeftDoubleClick
                  Plugin_Run()
                EndIf
                If Event\EventType = #PB_EventType_RightClick
                  If GetGadgetState(#G_LI_Preferences_Plugins_RunPlugins) = -1
                    DisableMenuItem(#Menu_RunPlugins, #Mnu_RunPlugins_Run, 1)
                  Else
                    DisableMenuItem(#Menu_RunPlugins, #Mnu_RunPlugins_Run, 0)
                  EndIf
                  DisplayPopupMenu(#Menu_RunPlugins, WindowID(#Win_Preferences))
                EndIf
              ; Backups
              Case #G_BN_Preferences_Backups_Create
                Backup_Create()
              Case #G_BN_Preferences_Backups_Delete
                Backup_Delete()
              Case #G_BN_Preferences_Backups_Restore
                Backup_Restore()
            EndSelect
            Preferences_CheckApply()
          ; ############################################
          ; Effekte
          Case #Win_Effects
            Select Event\EventGadget
              Case #G_BN_Effects_Default
                BASS_DefauldEffects()
              Case #G_CB_Effects_Equalizer
                If Pref\equilizerpreset <> GetGadgetState(#G_CB_Effects_Equalizer)
                  Bass_SetEqualizerPreset(GetGadgetState(#G_CB_Effects_Equalizer))
                  Pref\equilizerpreset = GetGadgetState(#G_CB_Effects_Equalizer)
                EndIf
              Case #G_CH_Effects_Equalizer
                Pref\equilizer = GetGadgetState(#G_CH_Effects_Equalizer)
                Bass_SetEqualizer()
                For iNext = #G_TB_Effects_EqualizerBand0 To #G_TB_Effects_EqualizerBand9
                  DisableGadget(iNext, Pref\equilizer!1)
                Next
              Case #G_TB_Effects_EqualizerBand0 To #G_TB_Effects_EqualizerBand9
                BassEQ\iCenter[Event\EventGadget - #G_TB_Effects_EqualizerBand0] = GetGadgetState(Event\EventGadget)
                Bass_SetEqualizerBand(Event\EventGadget - #G_TB_Effects_EqualizerBand0)
              Case #G_TB_Effects_SystemVolume
                BASS_SetVolume(GetGadgetState(#G_TB_Effects_SystemVolume) / 100)
                SetGadgetText(#G_TX_Effects_SystemVolumeV, StrF(BASS_GetVolume(), 2))
              Case #G_TB_Effects_Speed
                Pref\speed = GetGadgetState(#G_TB_Effects_Speed)
                Bass_SetFrequenz()
              Case #G_TB_Effects_Panel
                Pref\panel = GetGadgetState(#G_TB_Effects_Panel)
                Bass_SetPanel()
              Case #G_CH_Effects_Reverb
                Effects\bReverb = GetGadgetState(#G_CH_Effects_Reverb)
                Bass_SetReverb()
              Case #G_TB_Effects_ReverbMix
                Effects\fReverbMix = GetGadgetState(#G_TB_Effects_ReverbMix) - 96
                Bass_SetReverbParameters()
              Case #G_TB_Effects_ReverbTime
                Effects\fReverbTime = ((GetGadgetState(#G_TB_Effects_ReverbTime) * 3000) / 100)
                Bass_SetReverbParameters()
              Case #G_CH_Effects_Echo
                Effects\bEcho = GetGadgetState(#G_CH_Effects_Echo)
                Bass_SetEcho()
              Case #G_TB_Effects_EchoBack
                Effects\bEchoBack = GetGadgetState(#G_TB_Effects_EchoBack)
                Bass_SetEchoParameters()
              Case #G_TB_Effects_EchoDelay
                Effects\iEchoDelay = GetGadgetState(#G_TB_Effects_EchoDelay)
                Bass_SetEchoParameters()
              Case #G_CH_Effects_Flanger
                Effects\bFlanger = GetGadgetState(#G_CH_Effects_Flanger)
                Bass_SetFlanger()
              Case #G_BN_Effects_Close
                CloseWindow_Effects()
            EndSelect
          ; ############################################
          ; Wiedergabeliste Suche
          Case #Win_Search
            Select Event\EventGadget
              Case #G_BN_Search_Start
                PlayList_Search()
              Case #G_LV_Search_Result
                If Event\EventType = #PB_EventType_LeftClick And GetGadgetState(#G_LV_Search_Result) > -1
                  If ListSize(SearchResult()) >= GetGadgetState(#G_LV_Search_Result)
                    SelectElement(SearchResult(), GetGadgetState(#G_LV_Search_Result))
                    SetGadgetState(#G_LI_Main_PL_PlayList, -1)
                    SetGadgetState(#G_LI_Main_PL_PlayList, SearchResult()\index)
                    SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_ENSUREVISIBLE, SearchResult()\index, #True)
                    SetActiveGadget(#G_LI_Main_PL_PlayList)
                  EndIf
                EndIf
                If Event\EventType = #PB_EventType_LeftDoubleClick And GetGadgetState(#G_LV_Search_Result) > -1
                  CloseWindow_Search()
                  SetActiveWindow(#Win_Main)
                  SetActiveGadget(#G_LI_Main_PL_PlayList)
                EndIf
            EndSelect
          ; ############################################
          ; Programinformationen
          Case #Win_Info
            Select Event\EventGadget
              Case #G_BN_Info_Close
                CloseWindow_Info()
            EndSelect
          ; ############################################
          ; Metadaten
          Case #Win_Metadata
            Select Event\EventGadget
              Case #G_BN_Metadata_File
                RunProgram("explorer.exe", "/select," + GetGadgetText(#G_SR_Metadata_File), "")
              Case #G_BN_Metadata_Save
                MetaData_SaveData()
                CloseWindow_Metadata()
                PlayList_RefreshTrackInfo()
              Case #G_BN_Metadata_Cancel
                CloseWindow_Metadata()
              Case #G_BN_Metadata_MidiLyrics
                If CurrPlay\channel[CurrPlay\curr] And ListSize(MidiLyrics()) > 0 And CurrPlay\tag\cType = #BASS_CTYPE_STREAM_MIDI
                  OpenWindow_MidiLyrics()
                EndIf
            EndSelect
          ; ############################################
          ; Wiedergabelisten Generator
          Case #Win_PlaylistGenerator
            Select Event\EventGadget
              Case #G_CH_PlaylistGenerator_WordFilter
                DisableGadget(#G_SR_PlaylistGenerator_WordFilter, GetGadgetState(Event\EventGadget)!1)
              Case #G_OP_PlaylistGenerator_Amount , #G_OP_PlaylistGenerator_Time
                DisableGadget(#G_SR_PlaylistGenerator_Amount, GetGadgetState(#G_OP_PlaylistGenerator_Amount)!1)
                DisableGadget(#G_CB_PlaylistGenerator_Time, GetGadgetState(#G_OP_PlaylistGenerator_Time)!1)
              Case #G_CH_PlaylistGenerator_GenreFilter
                DisableGadget(#G_LV_PlaylistGenerator_GenreFilter, GetGadgetState(Event\EventGadget)!1)
              Case #G_BN_PlaylistGenerator_Cancel
                CloseWindow_PlayListGenerator()
              Case #G_BN_PlaylistGenerator_Create
                PlayList_Generate()
            EndSelect
          ; ############################################
          ; Ordner zur Wiedergabeliste Hinzufügen
          Case #Win_PathRequester
            Select Event\EventGadget
              Case #G_BN_PathRequester_Apply
                PlayList_AddFolder(GetGadgetText(#G_ET_PathRequester_Overview), GetGadgetState(#G_CH_PathRequester_Recursive), 1)
              Case #G_BN_PathRequester_Cancel
                CloseWindow_PathRequester()
            EndSelect
          ; ############################################
          ; Aufgaben
          Case #Win_TaskChange
            Select Event\EventGadget
              Case #G_BN_TaskChange_Apply
                KillTimer_(0, Task\timer)
                If IsWindow(#Win_TaskRun)
                  CloseWindow_TaskRun()
                EndIf
                Task\event  = GetGadgetState(#G_LV_TaskChange_Need)
                Task\task   = GetGadgetState(#G_LV_TaskChange_Task)
                Task\cancel = 0
                Task\timer  = 0
                CloseWindow_TaskChange()
              Case #G_BN_TaskChange_Cancel
                CloseWindow_TaskChange()
            EndSelect
          ; ############################################
          ; Aufgabe Ausführen (TimeOut)
          Case #Win_TaskRun
            Select Event\EventGadget
              Case #G_BN_TaskRun
                CloseWindow_TaskRun()
            EndSelect
          ; ############################################
          ; AutoTags (Nicht implementiert!)
          Case #Win_AutoTag
            Select Event\EventGadget
              Case #G_BN_AutoTag_Cancel
                CloseWindow_AutoTag()
            EndSelect
          ; ############################################
          ; Log
          Case #Win_Log
            Select Event\EventGadget
              Case #G_LI_Log_Overview
                If Event\EventType = #PB_EventType_RightClick
                  Log_ShowPopUp()
                EndIf
            EndSelect
          ; ############################################
          ; RadioLog
          Case #Win_RadioLog
            Select Event\EventGadget
              Case #G_LI_RadioLog_Overview
                If Event\EventType = #PB_EventType_RightClick
                  If CountGadgetItems(#G_LI_RadioLog_Overview) = 0
                    DisableMenuItem(#Menu_RadioLog, #Mnu_RadioLog_Save, 1)
                    DisableMenuItem(#Menu_RadioLog, #Mnu_RadioLog_Clear, 1)
                  Else
                    DisableMenuItem(#Menu_RadioLog, #Mnu_RadioLog_Save, 0)
                    DisableMenuItem(#Menu_RadioLog, #Mnu_RadioLog_Clear, 0)                  
                  EndIf
                  DisplayPopupMenu(#Menu_RadioLog, WindowID(#Win_RadioLog))
                EndIf
            EndSelect
        EndSelect
      ; ############################################
      ;- PB_Event_GadgetDrop
      Case #PB_Event_GadgetDrop
        Select Event\EventGadget
          Case #G_LI_Main_PL_PlayList
            Select EventDropType()
              Case #PB_Drop_Files
               PlayList_AddDrop()
            EndSelect
          Case #G_CN_Main_IA_Background
            Select EventDropType()
              Case #PB_Drop_Files
                If FileSize(StringField(EventDropFiles(), 1, #LF$)) > 0
                  Bass_PlayMedia(StringField(EventDropFiles(), 1, #LF$), #PlayType_Normal)
                EndIf
              Case #PB_Drop_Private
                Select EventDropPrivate()
                  Case #PrivateDrop_InfoArea, #PrivateDrop_MediaLib
                    PlayList_Play()
                EndSelect
            EndSelect
        EndSelect
      ; ############################################
      ;- PB_Event_Menu
      Case #PB_Event_Menu
        Select Event\EventMenu
          ;Shortcuts
          Case #Shortcut_Main_Enter
            Select Event\ActiveGadget
              Case #G_SR_Main_ML_Search
                If Trim(GetGadgetText(#G_SR_Main_ML_Search)) <> "" And Len(Trim(GetGadgetText(#G_SR_Main_ML_Search))) >= 3
                  MediaLib_ShowDatabase(#MediaLib_Show_Search)
                EndIf
              Case #G_LI_Main_PL_PlayList
                If GetGadgetState(#G_LI_Main_PL_PlayList) > -1
                  PlayList_Play()
                EndIf
              Case #G_LI_Main_ML_MediaLib
                If GetGadgetState(#G_LI_Main_ML_MediaLib) > -1
                  MediaLib_Play()
                EndIf
            EndSelect
          Case #Shortcut_Search_Enter
            If Trim(GetGadgetText(#G_SR_Search_String)) <> ""
              PlayList_Search()
            EndIf
          Case #Shortcut_MLPlayList_Return
            If IsWindow(#Win_MLPlayList)
              MediaLib_SetPlayList()
            EndIf
          ;Toolbar Main 1
          Case #Mnu_Main_TB1_Play
            PlayList_Play()
          Case #Mnu_Main_TB1_Pause
            Bass_PauseMedia()
          Case #Mnu_Main_TB1_Stop
            CurrPlay\playtype = #PlayType_Normal
            Bass_FadeOut()
          Case #Mnu_Main_TB1_Next
            PlayList_NextTrack()
          Case #Mnu_Main_TB1_Record
            If FileSize(Pref\inetstream_savepath) = -2
              Pref\inetstream_savefile!1
              If Pref\inetstream_savefile
                Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Record, #ImageList_RecordOn)
              Else
                Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Record, #ImageList_RecordOff)
              EndIf
              If IsWindow(#Win_Preferences)
                SetGadgetState(#G_CH_Preferences_InetStream_SaveFile, Pref\inetstream_savefile)
              EndIf
            Else
              MsgBox_Exclamation("Aufnahme nicht möglich" + #CR$ + "Der Ordner '" + Pref\inetstream_savepath + "' existiert nicht")
            EndIf
          Case #Mnu_Main_TB1_Previous
            PlayList_PreviousTrack()
          Case #Mnu_Main_TB1_Volume
            If GetGadgetState(#G_TB_Main_IA_Volume) = 0
              SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetData(#G_TB_Main_IA_Volume))
            Else
              SetGadgetData(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume))
              SetGadgetState(#G_TB_Main_IA_Volume, 0)
            EndIf
            Bass_Volume()
          ;Toolbar Main 2
          Case #Mnu_Main_TB2_Equilizer
            OpenWindow_Effects()
          Case #Mnu_Main_TB2_PlayList
            Window_ChangeSize(#SizeType_Playlist)
          Case #Mnu_Main_TB2_MediaLib
            Window_ChangeSize(#SizeType_MediaLibary)
          ;Open
          Case #Mnu_Main_TB1_Open
            PlayList_AddFile("", 1)
          Case #Mnu_Open_File
            PlayList_AddFile("", 1)
          Case #Mnu_Open_Folder
            OpenWindow_PathRequester("Ordner Hinzufügen", MyMusicDirectory(), Pref\recursivfolder)
          ;PlayList
          Case #Mnu_PlayList_Insert
            PlayList_InsertClipboardFiles()
          Case #Mnu_PlayList_AddFile
            PlayList_AddFile("", 1)
          Case #Mnu_PlayList_AddFolder
            OpenWindow_PathRequester("Ordner Hinzufügen", MyMusicDirectory(), Pref\recursivfolder)
          Case #Mnu_PlayList_Generate
            OpenWindow_PlaylistGenerator()
          Case #Mnu_PlayList_SavePlayList
            PlayList_Save("", 0)
          Case #Mnu_PlayList_Play
            PlayList_Play()
          Case #Mnu_PlayList_SortMix To #Mnu_PlayList_SortType
            PlayList_Sort(Event\EventMenu - #Mnu_PlayList_SortMix)
          Case #Mnu_PlayList_Search
            OpenWindow_Search()
          Case #Mnu_PlayList_OpenFolder
            If ListSize(PlayList()) >= GetGadgetState(#G_LI_Main_PL_PlayList)
              SelectElement(PlayList(), GetGadgetState(#G_LI_Main_PL_PlayList))
              RunProgram("explorer.exe", "/select," + PlayList()\tag\file, "")
            EndIf
          Case #Mnu_PlayList_Copy
            PlayList_CopyFiles()
          Case #Mnu_PlayList_SelAll
            ListIconGadget_SelAll(#G_LI_Main_PL_PlayList)
          Case #Mnu_PlayList_Remove
            If GetGadgetState(#G_LI_Main_PL_PlayList) <> -1
              PlayList_Remove(GetGadgetState(#G_LI_Main_PL_PlayList))
            EndIf
          Case #Mnu_PlayList_RemoveAll
            PlayList_Remove(-1)
          Case #Mnu_PlayList_AutoTag
            AutoTag_CreateList()
            OpenWindow_AutoTag()
            AutoTag_InitWindow()
          Case #Mnu_PlayList_Refresh
            PlayList_RefreshTrackInfo()
          Case #Mnu_PlayList_Info
            PlayList_Info()
          ;MediaLib
          Case #Mnu_MediaLib_Play
            MediaLib_MenuEventOne(Event\EventMenu)
          Case #Mnu_MediaLib_SelectAll
            ListIconGadget_SelAll(#G_LI_Main_ML_MediaLib)
          Case #Mnu_MediaLib_Info , #Mnu_MediaLibInet_Info
            MediaLib_MenuEventOne(Event\EventMenu)
          Case #Mnu_MediaLib_SetPlayList
            OpenWindow_MLPlayList()
          Case #Mnu_MediaLib_RemPlayList
            MediaLib_MenuEventAll(Event\EventMenu)
          Case #Mnu_MediaLib_BookmarkAdd
            MediaLib_MenuEventAll(Event\EventMenu)
          Case #Mnu_MediaLib_BookmarkRem
            MediaLib_MenuEventAll(Event\EventMenu)
          Case #Mnu_MediaLib_SaveAsPlayList
            MediaLib_SavePlayList()
          Case #Mnu_MediaLib_SendPlayList
            MediaLib_SendToPlayList()
          Case #Mnu_MediaLib_SendPlayListNew
            MediaLib_SendToPlayList(1)
          Case #Mnu_MediaLib_MoreAlbum
            MediaLib_ShowDatabase(#MediaLib_Show_MoreAlbum)
          Case #Mnu_MediaLib_MoreInterpret
            MediaLib_ShowDatabase(#MediaLib_Show_MoreInterpret)
          Case #Mnu_MediaLib_MoreGenre
            MediaLib_ShowDatabase(#MediaLib_Show_MoreGenre)
          Case #Mnu_MediaLib_ResetPlayCount
            MediaLib_MenuEventAll(Event\EventMenu)
          Case #Mnu_MediaLib_ResetPlayDates
            MediaLib_MenuEventAll(Event\EventMenu)
          ;MediaLib Inet
          Case #Mnu_MediaLibInet_Add
            MediaLib_AddInetStream()
          Case #Mnu_MediaLibInet_Rem
            MediaLib_MenuEventAll(#Mnu_MediaLibInet_Rem)
          ;Menu Position
          Case #Mnu_Pos_Load
            Position_Load()
          Case #Mnu_Pos_Save
            Position_Save()
          Case #Mnu_Pos_Remove
            Position_Remove()
          Case #Mnu_Pos_Clear
            Position_ClearList()
          ;Volume
          Case #Mnu_Volume_Low
            Bass_Volume(0.10)
          Case #Mnu_Volume_Midle
            Bass_Volume(0.50)
          Case #Mnu_Volume_Loud
            Bass_Volume(0.90)
          ;SysTray
          Case #Mnu_SysTray_BackTrack
            PlayList_PreviousTrack()
          Case #Mnu_SysTray_Play
            PlayList_Play()
          Case #Mnu_SysTray_Stop
            CurrPlay\playtype = #PlayType_Normal
            Bass_FadeOut()
          Case #Mnu_SysTray_Pause
            Bass_PauseMedia()
          Case #Mnu_SysTray_NextTrack
            PlayList_NextTrack()
          Case #Mnu_SysTray_Show
            Window_MinimizeMaximize()
          Case #Mnu_SysTray_Pref
            OpenWindow_Preferences()
            Preferences_ChangeArea(-1)
            Preferences_Init()
            Preferences_CheckApply()
          Case #Mnu_SysTray_Task
            OpenWindow_TaskChange()
          Case #Mnu_SysTray_Statistics
            OpenWindow_Statistics()
            Statistics_ChangeArea()
          Case #Mnu_SysTray_Log
            OpenWindow_Log()
          Case #Mnu_SysTray_RadioLog
            OpenWindow_RadioLog()
          Case #Mnu_SysTray_Equilizer
            OpenWindow_Effects()
          Case #Mnu_SysTray_RecordFolder
            If FileSize(Pref\inetstream_savepath) = -2
              RunProgram("explorer.exe", Pref\inetstream_savepath, Pref\inetstream_savepath)
            EndIf
          Case #Mnu_SysTray_Update
            UpdateCheck_Start(1)
          Case #Mnu_SysTray_Website
            RunProgram(#URLUpdateS)
          Case #Mnu_SysTray_Feedback
            If iInitNetwork
              OpenWindow_Feedback()
              Feedback_CheckInputs()
            Else
              MsgBox_Exclamation("InitNetwork ist fehlgeschlagen")
            EndIf
          Case #Mnu_SysTray_Help
            If FileSize(ExecutableDirectory() + #FileName_Help) > 0
              OpenHelp(ExecutableDirectory() + #FileName_Help, "")
            Else
              MsgBox_Exclamation("Hilfe konnte nicht geöffnet werden" + #CR$ + "'" + ExecutableDirectory() + #FileName_Help + "'")
            EndIf
          Case #Mnu_SysTray_About
            OpenWindow_Info()
          Case #Mnu_SysTray_End
            Application_End()
          ;Menu RadioLog
          Case #Mnu_RadioLog_Clear
            RadioLog_Clear()
          Case #Mnu_RadioLog_Save
            RadioLog_Save()
          ;Menu Log
          Case #Mnu_Log_Copy
            Log_Copy()
          Case #Mnu_Log_Save
            Log_Save()
          Case #Mnu_Log_Clear
            Log_Clear()
          ;Menu MidiLyrics
          Case #Mnu_MidiLyrics_Copy
            SetClipboardText(EditorGadget_GetSelText(#G_ED_MidiLyrics_Text))
          Case #Mnu_MidiLyrics_Save
            EditorGadget_SaveSel(#G_ED_MidiLyrics_Text)
          ;Menu RunPlugins
          Case #Mnu_RunPlugins_Run
            Plugin_Run()
          ;Menu RegPlugins
          Case #Mnu_RegPlugins_End
            Plugin_RegEnd()
          Case #Mnu_RegPlugins_Preferences
            Plugin_RegPreferences()
          ;ListIconGadget
          Case #Mnu_ListIconGadget_AlignL , #Mnu_ListIconGadget_AlignC , #Mnu_ListIconGadget_AlignR , #Mnu_ListIconGadget_Width , #Mnu_ListIconGadget_OptimizeWidth
            Window_ChangeColumnAlign(Event\EventMenu)
        EndSelect
      
      ; ############################################
      ;- PB_Event_SizeMove
      Case #PB_Event_SizeWindow , #PB_Event_MoveWindow
        If ArraySize(WinSize()) >= Event\EventWindow
          WinSize(Event\EventWindow)\posx   = WindowX(Event\EventWindow)
          WinSize(Event\EventWindow)\posy   = WindowY(Event\EventWindow)
          WinSize(Event\EventWindow)\width  = WindowWidth(Event\EventWindow)
          WinSize(Event\EventWindow)\height = WindowHeight(Event\EventWindow)
        EndIf
      
      ; ############################################
      ;- PB_Event_Close
      Case #PB_Event_CloseWindow
        If Event\EventWindow = #Win_Main
          Application_End()
        Else
          CloseWindowOwn(Event\EventWindow)
        EndIf
      
      ; ############################################
      ;- PB_Event_SysTray
      Case #PB_Event_SysTray
        Select Event\EventType
          Case #PB_EventType_LeftClick
            Window_MinimizeMaximize()
          Case #PB_EventType_RightClick
            DisplayPopupMenu(#Menu_SysTray, WindowID(#Win_Main))
        EndSelect
  
    EndSelect
  ForEver
EndProcedure

Main()

End
; IDE Options = PureBasic 4.41 (Windows - x86)
; CursorPosition = 653
; FirstLine = 637
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant