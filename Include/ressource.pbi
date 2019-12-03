; Entällt sämtliche deklarationen und ressourceaufrufe
; außerdem sind hier benötigte deklarationen für Proceduren vorhanden
;
; Letzte Bearbeitung: 28.11.2009

;- Window IDs
Enumeration
  #Win_Hide
  #Win_Main
  #Win_Preferences
  #Win_Statistics
  #Win_Effects
  #Win_Search
  #Win_Info
  #Win_Log
  #Win_Metadata
  #Win_PlaylistGenerator
  #Win_PathRequester
  #Win_TaskChange
  #Win_TaskRun
  #Win_AutoTag
  #Win_RadioLog
  #Win_MidiLyrics
  #Win_MLPlayList
  #Win_MLSearchPref
  #Win_Feedback
  #Win_Last
  #Win_SplashScreen
  #Win_Tracker
EndEnumeration

;- Gadgets IDs
Enumeration
  ; Win Main
  #G_CN_Main_IA_Background
  #G_TX_Main_IA_InfoDesc1
  #G_TX_Main_IA_InfoCont1
  #G_TX_Main_IA_InfoDesc2
  #G_TX_Main_IA_InfoCont2
  #G_TX_Main_IA_InfoDesc3
  #G_TX_Main_IA_InfoCont3
  #G_TX_Main_IA_InfoDesc4
  #G_TX_Main_IA_InfoCont4
  #G_TX_Main_IA_Length
  #G_TX_Main_IA_LengthC
  #G_IG_Main_IA_Spectrum
  #G_IG_Main_IA_PrgLogo
  #G_FR_Main_IA_Gap
  #G_TB_Main_IA_Position
  #G_CN_Main_IA_ToolbarLeft
  #G_TB_Main_IA_Volume
  #G_CN_Main_IA_ToolbarRight
  #G_LI_Main_PL_PlayList
  #G_SR_Main_ML_Search
  #G_BN_Main_ML_SearchOptions
  #G_BN_Main_ML_Search
  #G_LI_Main_ML_MediaLib
  #G_LV_Main_ML_Category
  #G_CN_Main_ML_Misc
  #G_CB_Main_ML_MiscType
  #G_LI_Main_ML_Misc
  #G_SP_Main_ML_Vertical
  #G_SP_Main_ML_Horizontal
  ; Preferences
  #G_LV_Preferences_Menu
  #G_FR_Preferences_Seperator
  #G_BN_Preferences_Reset
  #G_BN_Preferences_Use
  #G_BN_Preferences_Apply
  #G_BN_Preferences_Cancel
  #G_TX_Preferences_Title
  #G_SA_Preferences_Bass
  #G_TX_Preferences_Bass_OutputDevice
  #G_CB_Preferences_Bass_OutputDevice
  #G_TX_Preferences_Bass_OutputRate
  #G_CB_Preferences_Bass_OutputRate
  #G_TX_Preferences_Bass_FadeIn
  #G_TB_Preferences_Bass_FadeIn
  #G_TX_Preferences_Bass_FadeOut
  #G_TB_Preferences_Bass_FadeOut
  #G_TX_Preferences_Bass_FadeOutEnd
  #G_TB_Preferences_Bass_FadeOutEnd
  #G_TX_Preferences_Bass_MidiSF2File
  #G_SR_Preferences_Bass_MidiSF2File
  #G_BN_Preferences_Bass_MidiSF2File
  #G_CH_Preferences_Bass_MidiLyrics
  #G_TX_Preferences_Bass_PreviewTime
  #G_TB_Preferences_Bass_PreviewTime
  #G_SA_Preferences_InetStream
  #G_CH_Preferences_InetStream_SaveFile
  #G_TX_Preferences_InetStream_FilePath
  #G_SR_Preferences_InetStream_FilePath
  #G_BN_Preferences_InetStream_FilePath
  #G_FR_Preferences_InetStream_FileName
  #G_OP_Preferences_InetStream_Full
  #G_OP_Preferences_InetStream_Title
  #G_TX_Preferences_InetStream_TimeOut
  #G_TB_Preferences_InetStream_TimeOut
  #G_TX_Preferences_InetStream_Buffer
  #G_TB_Preferences_InetStream_Buffer
  #G_TX_Preferences_InetStream_ProxyServer
  #G_SR_Preferences_InetStream_ProxyServer
  #G_CN_Preferences_GUI
  #G_PN_Preferences_GUI_Sub
  #G_CH_Preferences_GUI_AlwaysOnTop
  #G_CH_Preferences_GUI_Opacity
  #G_TB_Preferences_GUI_OpacityValue
  #G_CH_Preferences_GUI_Magnetic
  #G_TB_Preferences_GUI_MagneticValue
  #G_CH_Preferences_GUI_AutoColumnPL
  #G_CH_Preferences_GUI_AutoColumnML
  #G_TX_Preferences_GUI_LengthFormat
  #G_CB_Preferences_GUI_LengthFormat
  #G_TX_Preferences_GUI_SpectrumType
  #G_CB_Preferences_GUI_SpectrumType
  #G_LI_Preferences_GUI_Layout
  #G_CB_Preferences_GUI_LayoutTheme
  #G_BN_Preferences_GUI_LayoutThemeSave
  #G_CH_Preferences_GUI_AutoComplete
  #G_LI_Preferences_GUI_FontsOverview
  #G_CN_Preferences_HotKey
  #G_LI_Preferences_HotKey_Overview
  #G_CH_Preferences_HotKey_Control
  #G_CH_Preferences_HotKey_Menu
  #G_CH_Preferences_HotKey_Shift
  #G_CB_Preferences_HotKey_Misc
  #G_CH_Preferences_HotKey_EnableMediaKeys
  #G_CH_Preferences_HotKey_EnableGlobal
  #G_CN_Preferences_Filelink
  #G_LI_Preferences_Filelink_OverView
  #G_BN_Preferences_Filelink_All
  #G_BN_Preferences_Filelink_None
  #G_CN_Preferences_Tracker
  #G_CH_Preferences_Tracker_Enable
  #G_TX_Preferences_Tracker_Gap
  #G_TB_Preferences_Tracker_Gap
  #G_TX_Preferences_Tracker_Spacing
  #G_TB_Preferences_Tracker_Spacing
  #G_TX_Preferences_Tracker_Time
  #G_TB_Preferences_Tracker_Time
  #G_TX_Preferences_Tracker_Position
  #G_CB_Preferences_Tracker_Position
  #G_TX_Preferences_Tracker_Align
  #G_CB_Preferences_Tracker_Align
  #G_TX_Preferences_Tracker_MinSize
  #G_SR_Preferences_Tracker_MinWidth
  #G_SR_Preferences_Tracker_MinHeight
  #G_TX_Preferences_Tracker_Text
  #G_SR_Preferences_Tracker_Text
  #G_BN_Preferences_Tracker_Preview
  #G_CN_Preferences_MediaLib
  #G_LV_Preferences_MediaLib_Path
  #G_BI_Preferences_MediaLib_PathAdd
  #G_BI_Preferences_MediaLib_PathRem
  #G_BI_Preferences_MediaLib_FindInvalidFiles
  #G_BI_Preferences_MediaLib_Scan
  #G_CH_Preferences_MediaLib_CPUScan
  #G_CH_Preferences_MediaLib_AddPlayFile
  #G_CH_Preferences_MediaLib_BackgroundScan
  #G_CH_Preferences_MediaLib_StartEntryCheck
  #G_CH_Preferences_MediaLib_CheckFileExtension
  #G_TX_Preferences_MediaLib_CurrScan
  #G_CN_Preferences_Order
  #G_TX_Preferences_Order_TimeOut
  #G_TB_Preferences_Order_TimeOut
  #G_SA_Preferences_Misc
  #G_CH_Preferences_Misc_TastBar
  #G_CH_Preferences_Misc_Clipboard
  #G_CH_Preferences_Misc_SavePlayList
  #G_FR_Preferences_Misc_AutoSave
  #G_CH_Preferences_Misc_AutoSavePreferences
  #G_CH_Preferences_Misc_AutoSavePlayList
  #G_CH_Preferences_Misc_AutoSaveMediaLib
  #G_TX_Preferences_Misc_AutoSaveIntervall
  #G_SP_Preferences_Misc_AutoSaveIntervall
  #G_CH_Preferences_Misc_AskBeforeEnd
  #G_CH_Preferences_Misc_DropClear
  #G_CH_Preferences_Misc_RecursiveFolder
  #G_CH_Preferences_Misc_StartCheckUpdate
  #G_CH_Preferences_Misc_ActivateLogging
  #G_CH_Preferences_Misc_ChangeMSN
  #G_CH_Preferences_Misc_PlayLastPlay
  #G_CN_Preferences_Plugins
  #G_PN_Preferences_Plugins
  #G_LI_Preferences_Plugins_RegPlugins
  #G_LI_Preferences_Plugins_RunPlugins
  #G_CN_Preferences_Backups
  #G_LI_Preferences_Backups_Overview
  #G_BN_Preferences_Backups_Restore
  #G_BN_Preferences_Backups_Create
  #G_BN_Preferences_Backups_Delete
  ; Statistiken
  #G_TR_Statistics_Menu
  #G_LI_Statistics_Overview
  #G_FR_Statistics_Gap
  #G_BN_Statistics_Refresh
  #G_BN_Statistics_Reset
  #G_BN_Statistics_Close
  ; Effects
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
  ; Win Search
  #G_CB_Search_SearchIn
  #G_SR_Search_String
  #G_BN_Search_Start
  #G_LV_Search_Result
  ; Win Info
  #G_IG_Info_PrgLogo
  #G_FR_Info_Gap
  #G_PN_Info_Info
  #G_TX_Info_Info
  #G_TX_Info_ChangeLog
  #G_BN_Info_Close
  ; Win_Log
  #G_LI_Log_Overview
  ; Win_Metadata
  #G_FR_Metadata_File
  #G_TX_Metadata_File
  #G_SR_Metadata_File
  #G_BN_Metadata_File
  #G_FR_Metadata_Meta
  #G_TX_Metadata_Title
  #G_SR_Metadata_Title
  #G_TX_Metadata_Track
  #G_SR_Metadata_Track
  #G_TX_Metadata_Artist
  #G_SR_Metadata_Artist
  #G_TX_Metadata_Album
  #G_SR_Metadata_Album
  #G_TX_Metadata_Year
  #G_SR_Metadata_Year
  #G_TX_Metadata_Genre
  #G_CB_Metadata_Genre
  #G_TX_Metadata_Comment
  #G_SR_Metadata_Comment
  #G_FR_Metadata_Format
  #G_TX_Metadata_Size
  #G_TX_Metadata_SizeV
  #G_TX_Metadata_Bitrate
  #G_TX_Metadata_BitrateV
  #G_TX_Metadata_Samplerate
  #G_TX_Metadata_SamplerateV
  #G_TX_Metadata_Channels
  #G_TX_Metadata_ChannelsV
  #G_TX_Metadata_Length
  #G_TX_Metadata_LengthV
  #G_TX_Metadata_Format
  #G_TX_Metadata_FormatV
  #G_BN_Metadata_MidiLyrics
  #G_BN_Metadata_Cancel
  #G_BN_Metadata_Save
  ; Win_PlayListGenerator
  #G_CH_PlaylistGenerator_WordFilter
  #G_SR_PlaylistGenerator_WordFilter
  #G_CH_PlaylistGenerator_GenreFilter
  #G_LV_PlaylistGenerator_GenreFilter
  #G_BN_PlaylistGenerator_Cancel
  #G_BN_PlaylistGenerator_Create
  #G_PB_PlaylistGenerator_Progress
  #G_FR_PlaylistGenerator_Length
  #G_OP_PlaylistGenerator_Amount
  #G_SR_PlaylistGenerator_Amount
  #G_OP_PlaylistGenerator_Time
  #G_CB_PlaylistGenerator_Time
  #G_TX_PlaylistGenerator_Info
  #G_TX_PlaylistGenerator_Progress
  #G_CH_PlaylistGenerator_OnlyPlayed
  #G_CH_PlaylistGenerator_OnlyAdd
  #G_FR_PlaylistGenerator_Gap
  ; Win_PathRequester
  #G_ET_PathRequester_Overview
  #G_CH_PathRequester_Recursive
  #G_BN_PathRequester_Apply
  #G_BN_PathRequester_Cancel
  ; Win_TaskChange
  #G_TX_TaskChange_Need
  #G_LV_TaskChange_Need
  #G_TX_TaskChange_Task
  #G_LV_TaskChange_Task
  #G_BN_TaskChange_Apply
  #G_BN_TaskChange_Cancel
  ; Win_TaskRun
  #G_PB_TaskRun
  #G_BN_TaskRun
  ; Win_AutoTag
  #G_LI_AutoTag_Overview
  #G_SR_AutoTag_Msterstring
  #G_TX_AutoTag_Musterstring
  #G_BN_AutoTag_Rename
  #G_BN_AutoTag_Preview
  #G_BN_AutoTag_Cancel
  ; Win_RadioLog
  #G_TX_RadioLog_Downloaded
  #G_TX_RadioLog_DownloadedV
  #G_LI_RadioLog_Overview
  ; Win_MidiLyrics
  #G_ED_MidiLyrics_Text
  #G_TX_MidiLyrics_Word
  ; Win_MLPlayList
  #G_CB_MLPlayList
  #G_BN_MLPlayList_Remove
  #G_BN_MLPlayList_Cancel
  #G_BN_MLPlayList_Set
  ; Win_SplashScreen
  #G_IG_SplashScreen_Image
  #G_TX_SplashScreen_Text
  ; Win_Tracker
  #G_CN_Tracker
  #G_TX_Tracker_Title
  ; Win_MLSearchPref
  #G_FR_MLSearchPref_SearchIn
  #G_CH_MLSearchPref_SearchInTitle
  #G_CH_MLSearchPref_SearchInInterpret
  #G_CH_MLSearchPref_SearchInAlbum
  #G_CH_MLSearchPref_SearchInGenre
  #G_CH_MLSearchPref_SearchInComment
  #G_CH_MLSearchPref_SearchInPath
  #G_FR_MLSearchPref_Misc
  #G_CH_MLSearchPref_MiscCaseSensetive
  #G_CH_MLSearchPref_MiscWholeWords
  #G_CH_MLSearchPref_MiscPlayed
  #G_CH_MLSearchPref_MiscOr
  #G_TX_MLSearchPref_MaxCount
  #G_SR_MLSearchPref_MaxCount
  #G_FR_MLSearchPref_Length
  #G_TX_MLSearchPref_LengthMin
  #G_SR_MLSearchPref_LengthMin
  #G_TX_MLSearchPref_LengthMax
  #G_SR_MLSearchPref_LengthMax
  ; Feedback
  #G_TX_Feedback_Name
  #G_SR_Feedback_Name
  #G_IG_Feedback_Name
  #G_TX_Feedback_Mail
  #G_SR_Feedback_Mail
  #G_IG_Feedback_Mail
  #G_TX_Feedback_Subject
  #G_CB_Feedback_Subject
  #G_IG_Feedback_Subject
  #G_TX_Feedback_Message
  #G_SR_Feedback_Message
  #G_IG_Feedback_Message
  #G_FR_Feedback_Gap
  #G_BN_Feedback_Reset
  #G_BN_Feedback_Send
  #G_BN_Feedback_Cancel
  #G_HL_Feedback_URL
EndEnumeration

;- Statusbar IDs
Enumeration
  #Statusbar_Main
EndEnumeration

;- Statusbar Fields
Enumeration
  #SBField_PlayList
  #SBField_MediaLibary
  #SBField_MediaLibCount
  #SBField_Worker
  #SBField_Process
  #SBField_Last = #SBField_Process
EndEnumeration

;- Toolbar IDs
Enumeration
  #Toolbar_Main1
  #Toolbar_Main2
EndEnumeration

;- Menu IDs
Enumeration
  #Menu_PlayList
  #Menu_MediaLibary
  #Menu_MediaLib_Inet
  #Menu_Open
  #Menu_SysTray
  #Menu_ListIconGadget
  #Menu_Position
  #Menu_Volume
  #Menu_RadioLog
  #Menu_Log
  #Menu_MidiLyrics
  #Menu_RunPlugins
  #Menu_RegPlugins
EndEnumeration

;- Menu/Toolbar Entrys
Enumeration
  ;Toolbars Main
  #Mnu_Main_TB1_Previous
  #Mnu_Main_TB1_Play
  #Mnu_Main_TB1_Pause
  #Mnu_Main_TB1_Stop
  #Mnu_Main_TB1_Next
  #Mnu_Main_TB1_Record
  #Mnu_Main_TB1_Volume
  #Mnu_Main_TB2_Repeat
  #Mnu_Main_TB2_Random
  #Mnu_Main_TB2_Preview
  #Mnu_Main_TB1_Open
  #Mnu_Main_TB2_PlayList
  #Mnu_Main_TB2_MediaLib
  #Mnu_Main_TB2_Equilizer
  ;PopUp Menu Playlist
  #Mnu_PlayList_Play
  #Mnu_PlayList_SortMix
  #Mnu_PlayList_SortTitle
  #Mnu_PlayList_SortArtist
  #Mnu_PlayList_SortAlbum
  #Mnu_PlayList_SortTrack
  #Mnu_PlayList_SortLength
  #Mnu_PlayList_SortYear
  #Mnu_PlayList_SortType
  #Mnu_PlayList_Search
  #Mnu_PlayList_Insert
  #Mnu_PlayList_AddFile
  #Mnu_PlayList_AddFolder
  #Mnu_PlayList_Generate
  #Mnu_PlayList_OpenFolder
  #Mnu_PlayList_Copy
  #Mnu_PlayList_SavePlayList
  #Mnu_PlayList_SelAll
  #Mnu_PlayList_Remove
  #Mnu_PlayList_RemoveAll
  #Mnu_PlayList_AutoTag
  #Mnu_PlayList_Refresh
  #Mnu_PlayList_Info
  ;PopUp Menu MediaLibary
  #Mnu_MediaLib_Play
  #Mnu_MediaLib_SelectAll
  #Mnu_MediaLib_BookmarkAdd
  #Mnu_MediaLib_BookmarkRem
  #Mnu_MediaLib_SetPlayList
  #Mnu_MediaLib_RemPlayList
  #Mnu_MediaLib_SendPlayList
  #Mnu_MediaLib_SendPlayListNew
  #Mnu_MediaLib_SaveAsPlayList
  #Mnu_MediaLib_ResetPlayCount
  #Mnu_MediaLib_ResetPlayDates
  #Mnu_MediaLib_MoreAlbum
  #Mnu_MediaLib_MoreInterpret
  #Mnu_MediaLib_MoreGenre
  #Mnu_MediaLib_Info
  ;PopUp Menu MediaLibary Inet
  #Mnu_MediaLibInet_Add
  #Mnu_MediaLibInet_Rem
  #Mnu_MediaLibInet_Info
  ;PopUp Menu Open
  #Mnu_Open_File
  #Mnu_Open_Folder
  ;PopUp Menu SysTray
  #Mnu_SysTray_Show
  #Mnu_SysTray_Play
  #Mnu_SysTray_Stop
  #Mnu_SysTray_Pause
  #Mnu_SysTray_NextTrack
  #Mnu_SysTray_BackTrack
  #Mnu_SysTray_Statistics
  #Mnu_SysTray_Update
  #Mnu_SysTray_UpdateCheck
  #Mnu_SysTray_About
  #Mnu_SysTray_Website
  #Mnu_SysTray_Feedback
  #Mnu_SysTray_Equilizer
  #Mnu_SysTray_RecordFolder
  #Mnu_SysTray_RadioLog
  #Mnu_SysTray_Log
  #Mnu_SysTray_Pref
  #Mnu_SysTray_Task
  #Mnu_SysTray_Help
  #Mnu_SysTray_End
  ;PopUp Menu ListIconGadget Headers
  #Mnu_ListIconGadget_AlignL
  #Mnu_ListIconGadget_AlignC
  #Mnu_ListIconGadget_AlignR
  #Mnu_ListIconGadget_OptimizeWidth
  #Mnu_ListIconGadget_Width
  ;PopUp Menu Position
  #Mnu_Pos_Save
  #Mnu_Pos_Load
  #Mnu_Pos_Remove
  #Mnu_Pos_Clear
  ;PopUp Menu Volume
  #Mnu_Volume_Low
  #Mnu_Volume_Midle
  #Mnu_Volume_Loud
  ;PopUp Menu RadioLog
  #Mnu_RadioLog_Save
  #Mnu_RadioLog_Clear
  ;PopUp Menu Log
  #Mnu_Log_Copy
  #Mnu_Log_Save
  #Mnu_Log_Clear
  ;PopUp Menu MidiLyrics
  #Mnu_MidiLyrics_Copy
  #Mnu_MidiLyrics_Save
  ;PopUp Menu RunPlugins
  #Mnu_RunPlugins_Run
  ;PopUp Menu RegPlugins
  #Mnu_RegPlugins_End
  #Mnu_RegPlugins_Preferences
  ;Shortcuts
  #Shortcut_Main_Enter
  #Shortcut_Search_Enter
  #Shortcut_MLPlayList_Return
EndEnumeration

;- PlayType
Enumeration 1
  #PlayType_Normal
  #PlayType_PlayList
  #PlayType_MediaLibary
  #PlayType_Shoutcast
EndEnumeration

;- SizeType
Enumeration
  #SizeType_Normal
  #SizeType_Playlist
  #SizeType_MediaLibary
EndEnumeration

;- ImageList
Enumeration
  #ImageList_Zero
  #ImageList_SysTray
  #ImageList_Back
  #ImageList_Play
  #ImageList_Pause
  #ImageList_Stop
  #ImageList_Next
  #ImageList_RecordOff
  #ImageList_RecordOn
  #ImageList_Add
  #ImageList_Save
  #ImageList_Info
  #ImageList_Rename
  #ImageList_Refresh
  #ImageList_Mute
  #ImageList_Volume1
  #ImageList_Volume2
  #ImageList_Volume3
  #ImageList_Search
  #ImageList_SearchS
  #ImageList_TrackInfo
  #ImageList_Equilizer
  #ImageList_Pref
  #ImageList_Statistics
  #ImageList_PlayList
  #ImageList_MediaLib
  #ImageList_Repeat
  #ImageList_Random
  #ImageList_Preview
  #ImageList_About
  #ImageList_End
  #ImageList_Clipboard
  #ImageList_Copy
  #ImageList_File
  #ImageList_Folder
  #ImageList_FolderScan
  #ImageList_FolderRem
  #ImageList_FolderAdd
  #ImageList_AddURL
  #ImageList_Remove
  #ImageList_Remove2
  #ImageList_Success
  #ImageList_Bookmark
  #ImageList_Website
  #ImageList_Feedback
  #ImageList_ShowHide
  #ImageList_Help
  #ImageList_Watch
  #ImageList_Warning
  #ImageList_Exclamation
  #ImageList_Error
EndEnumeration

;- Font IDs
Enumeration
  #Font_InfoArea
  #Font_PlayList
  #Font_MediaLib
  #Font_Tracker
  #Font_MidiLyrics
  #Font_Last = #Font_MidiLyrics
EndEnumeration

;- ChannelFlags
Enumeration
  #ChannelFlag_FadeIn  = $1
  #ChannelFlag_FadeOut = $2
  #ChannelFlag_Stop    = $4
EndEnumeration

;- Medienbibliothek Flags
Enumeration 
  #MediaLibFlag_Bookmark = $1
EndEnumeration

;- Medienbibliothek 'Erweiterte Suche' Einstellungen
Enumeration 
  ; Suche Flags
  #MediaLib_SearchIn_Title      = 1
  #MediaLib_SearchIn_Artist     = 2
  #MediaLib_SearchIn_Album      = 4
  #MediaLib_SearchIn_Genre      = 8
  #MediaLib_SearchIn_Comment    = 16
  #MediaLib_SearchIn_Path       = 32
  ; Sonstiges
  #MediaLib_SearchIn_CaseSens   = 64
  #MediaLib_SearchIn_WholeWords = 128
  #MediaLib_SearchIn_Played     = 256
  #MediaLib_SearchIn_Or         = 512
  #MediaLib_SearchIn_MaxCount   = 1024
EndEnumeration

;- Kategorien in Medienbibliothek
Enumeration 
  #MediaLib_Categorie_Database
  #MediaLib_Categorie_MostPlay
  #MediaLib_Categorie_LastPlay
  #MediaLib_Categorie_NeverPlay
  #MediaLib_Categorie_Longest
  #MediaLib_Categorie_LastAdded
  #MediaLib_Categorie_Rating
  #MediaLib_Categorie_Bookmark
  #MediaLib_Categorie_Internet
  #MediaLib_Categorie_PlayLists
EndEnumeration

Enumeration 
  #MediaLib_Misc_Album
  #MediaLib_Misc_Artist
  #MediaLib_Misc_Genre
  #mediaLib_Misc_PlayList
EndEnumeration

;- Medienbibliothek Ansicht
Enumeration 
  #MediaLib_Show_Search
  #MediaLib_Show_Normal
  #MediaLib_Show_MostPlay
  #MediaLib_Show_LastPlay
  #MediaLib_Show_NeverPlay
  #MediaLib_Show_Bookmarks
  #MediaLib_Show_InternetStreams
  #MediaLib_Show_Misc
  #MediaLib_Show_MoreAlbum
  #MediaLib_Show_MoreInterpret
  #MediaLib_Show_MoreGenre
  #MediaLib_Show_PlayList
  #MediaLib_Show_Rating
  #MediaLib_Show_Longest
  #MediaLib_Show_LastAdded
EndEnumeration

;- Wiedergabeliste Spalten
Enumeration
  #PlayList_Column_None
  #PlayList_Column_Title
  #PlayList_Column_Interpret
  #PlayList_Column_Album
  #PlayList_Column_Track
  #PlayList_Column_Length
  #PlayList_Column_Year
  #PlayList_Column_Type
  #PlayList_Column_Last = #PlayList_Column_Type
EndEnumeration

;- Medienbibliothek Spalten
Enumeration
  #MediaLib_Column_None
  #MediaLib_Column_Title
  #MediaLib_Column_Interpret
  #MediaLib_Column_URL = #MediaLib_Column_Interpret
  #MediaLib_Column_Album
  #MediaLib_Column_Track
  #MediaLib_Column_Length
  #MediaLib_Column_Year
  #MediaLib_Column_PlayCount
  #MediaLib_Column_FirstPlay
  #MediaLib_Column_LastPlay
  #MediaLib_Column_Rating
  #MediaLib_Column_Type
  #MediaLib_Column_Last = #MediaLib_Column_Type
EndEnumeration

;- Tasks Event
Enumeration 
  #TaskEvent_None
  #TaskEvent_Stop
  #TaskEvent_Screensaver
EndEnumeration

;- Tasks Tasks
Enumeration 
  #Task_Play
  #Task_Stop
  #Task_Pause
  #Task_Prev
  #Task_Next
  #Task_Shutdown
  #Task_End
EndEnumeration

;- Preferences Area
Enumeration
  #PrefArea_Bass
  #PrefArea_InetStream
  #PrefArea_GUI
  #PrefArea_HotKey
  #PrefArea_Filelink
  #PrefArea_Tracker
  #PrefArea_MediaLib
  #PrefArea_Order
  #PrefArea_Misc
  #PrefArea_Plugins
  #PrefArea_Backups
EndEnumeration

;- Spectrum Type
Enumeration 
  #Spectrum_None
  #Spectrum_Linear
  #Spectrum_Waveform
  #Spectrum_Last = #Spectrum_Waveform
EndEnumeration

;- Colors
Enumeration
  #Color_TrackInfo_BG ; Infobereich Hintergrund
  #Color_TrackInfo_FG ; Infobereich Text
  #Color_Spectrum_BG  ; Spektrum Hintergrund
  #Color_Spectrum_FG  ; Spektrum Vordergrund
  #Color_Select_BG    ; Auswahl Wiedergabeliste
  #Color_Select_FG    ; Auswahl Vordergrund
  #Color_Midi_BG      ; MidiLyrics Hintergrund
  #Color_Midi_FG      ; MidiLyrics Vordergrund
  #Color_Tracker_BG   ; Tracker Hintergrund
  #Color_Tracker_FG   ; Tracker Vordergrund
  #Color_Last = #Color_Tracker_FG + 1
EndEnumeration

;- Log Type
Enumeration
  #Log_Normal
  #Log_Info
  #Log_Warning
  #Log_Exclamation
  #Log_Error
EndEnumeration

;- File Types
Enumeration
  #FileType_Audio
  #FileType_PlayList
EndEnumeration

;- ListIconHeader SortAlign
Enumeration
  #ListIconSort_Align_None
  #ListIconSort_Align_Ascending
  #ListIconSort_Align_Descending
EndEnumeration

;- ListIconHeader SortType
Enumeration 
  #ListIconSort_Type_String
  #ListIconSort_Type_Value
EndEnumeration

;- ProcessMessage Überschreibprioritäten
Enumeration 
  #ProcessMessage_Low
  #ProcessMessage_Middle
  #ProcessMessage_High
EndEnumeration

Enumeration
  #PrivateDrop_InfoArea
  #PrivateDrop_MediaLib
EndEnumeration

;- Win API
#TBN_HOTITEMCHANGE = #TBN_FIRST - 13

;- Globale Werte
#PrgName                 = "BassKing"                ; Programmname
#PrgMutex                = "BASSKING-0000000003-VF1" ; Mutex zum einmaligen Start

;- Maximalwerte
#MaxLog                  = 500        ; Maximale Log Einträge
#MaxFileLogSize          = 5242880    ; Maximale Dateigröße der Logdatei, KB
#MaxPos                  = 1000       ; Maximale Größe des TrackBarGadget für Position
#MaxSavedPos             = 50         ; Maximale Anzahl gespeicherter Wiedergabepositionen
#MaxMediaLibSize         = 100000     ; Maximale Größe der Medienbibliothek (Einträge)
#MaxTracker              = 100        ; Maximale Zeichen im Tracker
#MinOpacity              = 40         ; Minimale Fenstertransparents
#MaxOpacity              = 240        ; Maximale Fenstertransparents
#MaxRating               = 10         ; Maximale Bewertung in Medienbibliothek
#MaxSize_SHistoryML      = 25         ; Maximale Größe des Suchverlaufes der Medienbibliothek

;- Dateiverarbeitung
#FileString_Check        = "BK-F"            ; Teststring für Dateien

#FileName_Preferences    = "BassKing.ini"    ; Dateiname Einstellungen
#FileName_PlayList       = "PlayList.dat"    ; Dateiname Wiedergabeliste
#FileName_MediaLib       = "MediaLibary.dat" ; Dateiname Medienbibliothek
#FileName_Log            = "Log.txt"         ; Dateiname Logging
#FileName_Help           = "BassKing.chm"    ; Dateiname Hilfe
#FileName_MidiFont       = "midi.sf2"        ; Standard Midi SoundFont

#FileExtension_Restore      = ".restore"  ; Erweiterung für Backupdateien
#FileExtension_ColorThemes  = ".clt"      ; Erweiterung für Farbthemen

#Folder_AppData          = "BassKing\"            ; Standardordner für Einstellungen
#Folder_Plugins          = "Plugins\"             ; Standardordner für Plugins
#Folder_Colors           = "Colors\"              ; Standardordner für Farbthemen
#Folder_Record           = "BassKing Aufnahmen\"  ; Standardordner für Aufnahme
#Folder_Backup           = "Backup\"              ; Standardordner für Sicherheitskopien

#URLUpdateC              = "http://www.kaisnet.de/data/version/bassking.inf"          ; URL Updateinfos
#URLUpdateS              = "http://www.kaisnet.de"                                    ; URL Homepage
#URLFeedback             = "http://www.kaisnet.de/index.php?seite=4.kontakt"          ; URL Kontakt
#URLFeedbackDirect       = "http://www.kaisnet.de/includes/misc/dmail.php"            ; Direkter Feedback Link

#EMail                   = "angel-kai@hotmail.de"

#ChangeLog               = "Version 1.32 (01.05.10)" + #CRLF$ + "[A] Update, Setup wird bei Abbruch nach Desktop kopiert" + #CRLF$ + "[A] Medienbibliothek, zuletzt hinzugefügt" + #CRLF$ + "[C] Wiedergabe bei Datei/Ordner hinzufügen zur WL" + #CRLF$ + "[F] Medienbibliothek, Autocomplete ändert G/K-Schreibung" + #CRLF$ + "[F] Fenstergröße bei aktivierten Tracker bei Start" + #CRLF$ + #CRLF$ + "Version 1.31 (09.12.09)" + #CRLF$ + "[A] Infobereich, Wiedergabe per Drag&Drop" + #CRLF$ + "[F] Log, max. 500 Einträge" + #CRLF$ + "[F] Wiedergabeliste, Absturz im Zufallsmodus" + #CRLF$ + "[F] Programmparameter mit Leerzeichen" + #CRLF$ + #CRLF$ + "Version 1.30 (01.12.09)" + #CRLF$ + "[A] Medienbibliothek, Suchmodus OR" + #CRLF$ + "[A] Medienbibliothek, Sucheinstellungen Länge" + #CRLF$ + "[A] Medienbibliothek, Bewertung" + #CRLF$ + "[A] Medienbibliothek, Speichern als Wiedergabeliste" + #CRLF$ + "[A] Medienbibliothek, Suchverlauf" + #CRLF$ + "[A] Medienbibliothek, Alles Auswählen (Kontextmenü)" + #CRLF$ + "[A] Einstellungen, Explizites FadeOut für Beenden" + #CRLF$ + "[A] Einstellungen, Letzte Wiedergabe fortsetzen" + #CRLF$ + "[A] Einstellungen, Fonts" + #CRLF$ + "[A] Spaltenbreiten festlegbar, Optimale Breite" + #CRLF$ + "[A] Wiedergabelisten Formate M3U8, SXPF" + #CRLF$ + "[A] Effekte, Auf Standard Zurücksetzen" + #CRLF$ + "[A] Feedback Fenster" + #CRLF$ + "[A] Hilfedatei (Alphaversion !)" + #CRLF$ + "[C] Medienbibliothek, Wiedergabelisten optimiert" + #CRLF$ + "[C] Einstellungen, Farbthemen Speichern" + #CRLF$ + "[C] Updatefunktion überarbeitet, Download u. Installation" + #CRLF$ + "[C] TagLib Version 1.5 -> TagLib Version 1.6" + #CRLF$ + #CRLF$ + "Version 1.29 (25.10.09)" + #CRLF$ + "[A] Einstellungen/Backup" + #CRLF$ + "[C] Einstellungen Fenster" + #CRLF$ + "[C] Extrafenster für Statistiken" + #CRLF$ + #CRLF$ + "Version 1.28 (22.10.09)" + #CRLF$ + "[F] Shortcuts Auswahl" + #CRLF$ + #CRLF$ + "Version 1.27 (18.10.09)" + #CRLF$ + "[A] Einstellungen/Statistiken erweitert" + #CRLF$ + "[C] Medienbibliothek Scanvorgang verbessert" + #CRLF$ + "[F] Statistiken Reset und Wiedergabe/Tag" + #CRLF$ + "[F] CPU Schonender Scanvorgang" + #CRLF$ + #CRLF$ + "Version 1.26 (16.10.09)" + #CRLF$ + "[A] Erweiterte Suche, Medienbibliothek" + #CRLF$ + "[A] Mehrere Stammordner, Medienbibliothek" + #CRLF$ + #CRLF$ + "Version 1.24 (03.10.09)" + #CRLF$ + "[A] Color Themen" + #CRLF$ + "[A] Medienbibliothek Wiedergabelisten" + #CRLF$ + "[C] Standardfarben Farbauswahl Oberfläche" + #CRLF$ + "[F] Menüereignisse Medienbibliothek" + #CRLF$ + #CRLF$ + "Version 1.22 (26.09.09)" + #CRLF$ + "[A] Einfügen in Wiedergabeliste" + #CRLF$ + "[A] Program parameter *.m3u/*.pls" + #CRLF$ + #CRLF$ + "Version 1.21 (22.09.09)" + #CRLF$ + "[F] Wiedergabelisten Generator" + #CRLF$ + #CRLF$ + "Version 1.20 (21.09.09)" + #CRLF$ + "[A] Album wählbar" + #CRLF$ + #CRLF$ + "Version 1.19 (19.09.09)" + #CRLF$ + "[A] Dateityp Verknüpfungen" + #CRLF$ + #CRLF$ + "Version 1.17 (14.09.09)" + #CRLF$ + "[A] Medienbibliothek 'Mehr von'" + #CRLF$ + #CRLF$ + "Version 1.16 (12.09.09)" + #CRLF$ + "[A] Windows Live Messenger Status text" + #CRLF$ + "[A] Plug-In Support erweitert" + #CRLF$ + #CRLF$ + "Version 1.15 (11.09.09)" + #CRLF$ + "[A] Midi Lyrics" + #CRLF$ + #CRLF$ + "Version 1.14 (10.09.09)" + #CRLF$ + "[A] Spektrum-Farbe separat" + #CRLF$ + "[C] Ausgabeformat für HTML Wiedergabeliste" + #CRLF$ + "[C] Plug-Ins können automatisch gestartet werden" + #CRLF$ + #CRLF$ + "Version 1.13 (06.09.09)" + #CRLF$ + "[A] Radio Log Speichern / Leeren" + #CRLF$ + "[A] Log Speichern / Leeren" + #CRLF$ + "[A] Tooltipps, Wiedergabeliste / Medienbibliothek" + #CRLF$ + "[A] Log deaktivieren" + #CRLF$ + "[A] Log bei Programmende speichern 'Log.txt'" + #CRLF$ + #CRLF$ + "Version 1.12 (05.09.09)" + #CRLF$ + "[A] Vorschaumodus" + #CRLF$ + "[F] ToolTipps bei Albumliste" + #CRLF$ + #CRLF$ + "Version 1.11 (04.09.09)" + #CRLF$ + "[A] Position Speichern/Öffnen" + #CRLF$ + "[F] Wiedergabeliste Erstellen, Fortschritte" + #CRLF$ + #CRLF$ + "Version 1.10 (13.07.09)" + #CRLF$ + "[A] Tastenkombination Suchen" + #CRLF$ + "[F] Shortcuts, direkte Anzeige" + #CRLF$ + #CRLF$ + "Version 1.08 (12.07.09)" + #CRLF$ + "[A] Radio Log, Download-Menge" + #CRLF$ + "[A] Timeout und Proxy server" + #CRLF$ + #CRLF$ + "Version 1.07 (11.07.09)" + #CRLF$ + "[C] Fade In / Out unabhängig festlegbar" + #CRLF$ + "[F] Menü item Sortieren/Typ" + #CRLF$ + #CRLF$ + "Version 1.06 (10.07.09)" + #CRLF$ + "[A] System Lautstärke" + #CRLF$ + "[A] Effekt Reverb" + #CRLF$ + "[A] Effekt Echo" + #CRLF$ + "[A] Effekt Flanger" + #CRLF$ + "[C] Equalizer Fenster" + #CRLF$ + "[C] Hauptfenster, Statusleiste" + #CRLF$ + "[F] Medienbibliothek, hinzufügen zur Wiedergabeliste" + #CRLF$ + #CRLF$ + "Version 1.05 (07.07.09)" + #CRLF$ + "[A] Wiedergabeliste, Sortieren per Headerklick" + #CRLF$ + "[A] Wiedergabeliste, Sortieren nach Typ" + #CRLF$ + #CRLF$ + "Legende" + #CRLF$ + "[A] Hinzugefügt" + #CRLF$ + "[R] Entfernt" + #CRLF$ + "[C] Änderung" + #CRLF$ + "[F] Fehlerkorrektur"

#HTML_DocType            = "<!DOCTYPE HTML PUBLIC " + Chr(34) + "-//W3C//DTD HTML 4.01 Transitional//EN" + Chr(34) + " " + Chr(34) + "http://www.w3.org/TR/html4/loose.dtd" + Chr(43) + ">"

;- PluginSystem
#BK_PluginEvent = #WM_USER + 102

Enumeration
  ; Jedes Plugin das Rückgabewerte erwartet muss sich mit dieser Message anmelden
  ; Andernfalls werden die Trackinfos nicht gesendet!
  #BKM_Register     ; Plugin Anmelden [WindowID, Version, Firma, Description]
  #BKM_Unsubscribe  ; Plugin Abmelden
  
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
  #BKM_Volume       ; Lautstärke ändern [iParam1 = 0.0 - 1.0]
  #BKM_Speed        ; Abspielgeschwindigkeit anpassen [iParam1 = 0.0 - 1.0]
  #BKM_Panel        ; Ausrichtung anpassen
  
  #BKM_PlayListSel  ; Eintrag in Wiedergabeliste auswählen
  #BKM_MediaLibSel  ; Eintrag in Medienbibliothek auswählen
  
  ; Öffnet oder Schließt ein Fenster
  ;
  ; 02 Preferences
  ; 03 Effects
  ; 04 Search
  ; 05 Info
  ; 06 Log
  ; 07 Metadata
  ; 08 PlaylistGenerator
  ; 10 TaskChange
  ; 12 AutoTag
  ; 13 RadioLog
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
  
  #BKR_Start  ; Channel Wiedergabe gestartet [iParam1 = Channel]
  #BKR_Stop   ; Channel wurde beendet [iParam1 = Channel]
  #BKR_End    ; Plugin Beenden Nachricht
  #BKR_Volume ; Lautstärke hat sich geändert [iParam1 = 0.0 - 0.1]
  
  ; BassKing Nachricht um Einstellungen des Plugins anzuzeigen
  ; Wird gesendet nach dem der Benutzer unter Einstellungen/Plugins/Ausführen im Menu Einstellungen gewählt hat.
  ; Bas Plugin sollte dann wenn vorhanden das Einstellungen Fenster öffnen.
  #BKR_Preferences
EndEnumeration

;- Globale Variablen

;Window
Global wMouseWheel.w

Global iLastHeaderRClick.i
Global iLastHeaderRClickIndex.i

Global iSizeTypeOld.i

Global lMediaLib_SPSize1.i
Global lMediaLib_SPSize2.i

Global iWinW_Main_Second.i
Global iWinH_Main_Second.i
Global iWinW_Main_Normal.i
Global iWinH_Main_Normal.i
Global iWinW_Main_SecondMin.i
Global iWinH_Main_SecondMin.i
Global iWinW_Main_NormalMin.i
Global iWinH_Main_NormalMin.i

Global iStartApplication.i

;Network
Global iInitNetwork.i ; Enthällt das Ergebniss von der Netzwerkinitialisierung

;Misc
Global iBassVersion.i
Global iEndApplication.i

;Ressource
Global iImagelist.i
Global iImgInfologo.i
Global iImgPrgLogo.i
Global iWorker.i
Global iNext.i
Global iTemp.i

Global iChannelStop.i ; Wird auf 1 gesetzt um die GUI nach Wiedergabeende zurückzusetzen

Structure _GUIFont
  desc.s
  font.s
  size.b
  activ.b
EndStructure
Global Dim GUIFont._GUIFont(#Font_Last)

GUIFont(#Font_InfoArea)\desc   = "Trackinfo"
GUIFont(#Font_PlayList)\desc   = "Wiedergabeliste"
GUIFont(#Font_MediaLib)\desc   = "Medienbibliothek"
GUIFont(#Font_Tracker)\desc    = "Tracker"
GUIFont(#Font_MidiLyrics)\desc = "Midi Lyrics"

Structure _Update
  Thread_Check.i
  Thread_Download.i
  URLDownload.s
  UpdateReady.b
  SetupFile.s
EndStructure
Global Update._Update

Structure _ListIconSort
  LastGadget.i
  LastColumn.i
  LastAlign.i
EndStructure
Global ListIconSort._ListIconSort

Global NewList Timer.i()

Structure _WinLoop
  WindowEvent.i
  EventWindow.i
  EventGadget.i
  EventMenu.i
  EventType.i
  EventTimer.i
  EventlParam.i
  EventwParam.i
  ActiveWindow.i
  ActiveGadget.i
EndStructure

Structure _Logging
  type.b
  time.i
  message.s
EndStructure
Global NewList Logging._Logging()

Structure _CreateBackup
  Thread.i
  Success.i
EndStructure
Global CreateBackup._CreateBackup

Structure _Position
  fingerprint.s
  position.i
EndStructure
Global NewList Position._Position()

Structure _ProcessMessage
  Text.s
  AddTime.i
  ShowTime.i
  Priority.b
EndStructure
Global ProcessMessage._ProcessMessage

Structure _MediaLibScan
  Mutex.i
  Thread.i
  Cancel.b
  CurrState.s
  MutexRF.i
  FolderScan.b
  BGThread.i
  BGIndex.i
EndStructure
Global MediaLibScan._MediaLibScan

MediaLibScan\Mutex   = CreateMutex()
MediaLibScan\MutexRF = CreateMutex()

Global Mutex_ReadTag.i = CreateMutex()

Structure _BassEQ
  iHandle.i
  iPreAmp.i
  iCenter.i [10]
EndStructure
Global BassEQ._BassEQ

Structure _Effects
  bReverb.b
  iReverb.i
  fReverbMix.i
  fReverbTime.i
  bEcho.b
  iEcho.i
  bEchoBack.b
  iEchoDelay.w
  bFlanger.b
  iFlanger.i
EndStructure
Global Effects._Effects

Structure _GeneratedPlayList
  index.i
  random.i
EndStructure

Structure _InternetStream
  connect_thread.i
  adress.s
  Stream.i
  downloaded.q
EndStructure
Global InternetStream._InternetStream

Structure _RadioTrackLog
  title.s
  artist.s
EndStructure
Global NewList RadioTrackLog._RadioTrackLog()

Structure _WinSize
  winid.i
  posx.i
  posy.i
  width.i
  height.i
EndStructure
Global Dim WinSize._WinSize(#Win_Last - 1)

Global Dim ColumnOrderArray_PL.i(#PlayList_Column_Last)
Global Dim ColumnOrderArray_ML.i(#MediaLib_Column_Last)

Global NewList AutoTag.s()

;- Pref
Structure _Pref
  ;bass
  bass_device.i       ; Bass Ausgabegerät
  bass_rate.i         ; Bass Ausgaberate
  bass_fadein.b       ; FadeIn  (Zeit)
  bass_fadeout.b      ; FadeOut (Zeit)
  bass_fadeoutend.b   ; FadeOut Beenden (0/1)
  bass_midisf2.s      ; Midi SoundFont (Dateipfad)
  bass_midilyrics.b   ; MidiLyrics (0/1)
  bass_preview.b      ; Vorschaumodus (5% - 50%)
  ;playoptions
  equilizer.i         ; Equalizer (0/1)
  equilizerpreset.i   ; Equalizer Preset
  panel.i             ; Ausrichtung
  speed.i             ; Abspielgeschwindigkeit
  ;gui
  ontop.i             ; Fenster Immer im Vordergrund (0/1)
  opacity.i           ; Fenstertransparents (0/1)
  opacityval.i        ; Fenstertransparents (40 - 240)
  magnetic.i          ; Magnetische Fenster (0/1)
  magneticval.i       ; Anziehkraft für Magnetische Fenster
  autoclnw_pl.i       ; Automatische Spaltenbreite PlayList (0/1)
  autoclnw_ml.i       ; Automatische Spaltenbreite Medienbibliothek (0/1)
  lengthformat.s      ; Längenformat in Anzeige (String)
  gui_autocomplete.b  ; Automatische Vervollständigung in Medienbibliothek (0/1)
  color.i [#Color_Last] ; Farben für Farbthema
  ;hotkeys
  sk_enableglobal.b   ; Globale Tastatur-Shortcuts (0/1)
  sk_enablemedia.i    ; Media Tasten (0/1)
  ;tracker
  tracker_enable.i    ; Tracker anzeigen (0/1)
  tracker_corner.i    ; Bildschirmecke für Tracker
  tracker_align.i     ; Textausrichtung im Tracker
  tracker_gap.i       ; Bildschirmabstand für Tracker
  tracker_spacing.i   ; Textabstand vom Rand
  tracker_minw.i      ; Minimale Breite
  tracker_minh.i      ; Minimale Höhe
  tracker_currtime.i  ; Aktuelle Zeit
  tracker_showtime.i  ; Einblendzeit
  tracker_text.s      ; Textmusterstring
  tracker_test.i      ; Vorschau
  ;medialib
  medialib_cpugentle.b        ; CPU Reduzierter Scan (0/1)
  medialib_addplayfiles.b     ; Abgespielte Dateien hinzufügen (0/1)
  medialib_searchin.i         ; Suchen 'in' (Flags)
  medialib_searchlength.i[2]  ; Längenbegrenzung für 'Suche'
  medialib_maxsearchcount.i   ; Max. Angezeigte Einträge in Medienbibliothek
  medialib_backgroundscan.b   ; Im Hintergrund aktualisieren (0/1)
  medialib_startcheck.b       ; Bei Start auf Fehler scanen
  medialib_checkextension.b   ; Dateierweiterungen überprüfen
  ;internetstreaming
  inetstream_savefile.b       ; Radioaufname aktiv 0/1
  inetstream_savepath.s       ; Speicherordner für Aufnahmen
  inetstream_savename.b       ; Speichername für Radioaufnahme
  inetstream_buffer.b         ; Buffergröße
  inetstream_timeout.b        ; Timeout
  inetstream_proxyserver.s    ; Proxyserver
  ;misc
  misc_laststart.i        ; Zuletzt Gestartet
  misc_clipboard.b        ; Aktuelle Wiedergabeinformationen in Zwischenablage kopieren
  misc_dropclear.b        ; Wiedergabeliste leeren bei Drag&Drop
  pl_auto.b               ; Automatische größenanpassung der Spaltenbreiten in Wiedergabeliste
  misc_autosave_pf.b      ; Automatische Speicherung, Einstellungen
  misc_autosave_pl.b      ; Automatische Speicherung, Wiedergabeliste
  misc_autosave_ml.b      ; Automatische Speicherung, Medienbibliothek
  misc_autosave_time.i    ; Automatische Speicherung, Zeitintervall
  endquestion.i           ; Vor Beenden Sicherheitsabfrage
  prefarea.i              ; Aktueller Bereich in Einstellungen
  spectrum.i              ; Aktuelles Spektrum
  recursivfolder.i        ; Unterordner mit hinzufügen Drag&Drop, Standard für Ordner hinzufügen
  taskbar.i               ; Eintrag in Taskbar
  startversioncheck.b     ; Bei Start nach neuer Version suchen
  enablelogging.b         ; Loging aktivieren
  enableworker.b          ; Interner Bool-Wert der angiebt ob der Worker in Statusbar läuft
  misc_changemsn.b        ; In Windows Live Messenger aktuelle Wiedergabeinfos anzeigen
  misc_MLMisc.b           ; Zuletzt ausgewählter sonstiger Anzeigeeintrag in Medienbibliothek ComboBoxGadget
  misc_playlastplay.b     ; Letzte Wiedergabe fortsetzen
EndStructure
Global Pref._Pref

Structure _Task
  event.b
  task.b
  timestart.i
  timeout.i
  cancel.b
  timer.i
EndStructure
Global Task._Task

;- Hotkeys
#MaxHotKey = 16
Structure _HotKey
  event.s
  release.b
  active.b  [2] ;1:State, 2:Temp for PreferencesApplyCheck
  control.b [2]
  menu.b    [2]
  shift.b   [2]
  misc.b    [2]
EndStructure
Global Dim HotKey._HotKey(#MaxHotKey)

HotKey(0)\event  = "Vorheriger Titel"
HotKey(1)\event  = "Play"
HotKey(2)\event  = "Pause"
HotKey(3)\event  = "Stop"
HotKey(4)\event  = "Nächster Titel"
HotKey(5)\event  = "Stumm"
HotKey(6)\event  = "Lautstärke veringern"
HotKey(7)\event  = "Lautstärke erhöhen"
HotKey(8)\event  = "Minimieren/Anzeigen"
HotKey(9)\event  = "Beenden"
HotKey(10)\event = "Einstellungen"
HotKey(11)\event = "Wiedergabeliste"
HotKey(12)\event = "Medienbibliothek"
HotKey(13)\event = "Alles Auswählen"
HotKey(14)\event = "Entfernen"
HotKey(15)\event = "Fenster Schliessen"
HotKey(16)\event = "Suche"

;- Keys
#MaxKey = 83
Structure _Key
  code.c
  name.s
EndStructure
Global Dim Key._Key(#MaxKey)

Key(0)\name  = "A"  :  Key(0)\code  = #VK_A
Key(1)\name  = "B"  :  Key(1)\code  = #VK_B
Key(2)\name  = "C"  :  Key(2)\code  = #VK_C
Key(3)\name  = "D"  :  Key(3)\code  = #VK_D
Key(4)\name  = "E"  :  Key(4)\code  = #VK_E
Key(5)\name  = "F"  :  Key(5)\code  = #VK_F
Key(6)\name  = "G"  :  Key(6)\code  = #VK_G
Key(7)\name  = "H"  :  Key(7)\code  = #VK_H
Key(8)\name  = "I"  :  Key(8)\code  = #VK_I
Key(9)\name  = "J"  :  Key(9)\code  = #VK_J
Key(10)\name = "K"  :  Key(10)\code = #VK_K
Key(11)\name = "L"  :  Key(11)\code = #VK_L
Key(12)\name = "M"  :  Key(12)\code = #VK_M
Key(13)\name = "N"  :  Key(13)\code = #VK_N
Key(14)\name = "O"  :  Key(14)\code = #VK_O
Key(15)\name = "P"  :  Key(15)\code = #VK_P
Key(16)\name = "Q"  :  Key(16)\code = #VK_Q
Key(17)\name = "R"  :  Key(17)\code = #VK_R
Key(18)\name = "S"  :  Key(18)\code = #VK_S
Key(19)\name = "T"  :  Key(19)\code = #VK_T
Key(20)\name = "U"  :  Key(20)\code = #VK_U
Key(21)\name = "V"  :  Key(21)\code = #VK_V
Key(22)\name = "W"  :  Key(22)\code = #VK_W
Key(23)\name = "X"  :  Key(23)\code = #VK_X
Key(24)\name = "Y"  :  Key(24)\code = #VK_Y
Key(25)\name = "Z"  :  Key(25)\code = #VK_Z
Key(26)\name = "0"  :  Key(26)\code = #VK_0
Key(27)\name = "1"  :  Key(27)\code = #VK_1
Key(28)\name = "2"  :  Key(28)\code = #VK_2
Key(29)\name = "3"  :  Key(29)\code = #VK_3
Key(30)\name = "4"  :  Key(30)\code = #VK_4
Key(31)\name = "5"  :  Key(31)\code = #VK_5
Key(32)\name = "6"  :  Key(32)\code = #VK_6
Key(33)\name = "7"  :  Key(33)\code = #VK_7
Key(34)\name = "8"  :  Key(34)\code = #VK_8
Key(35)\name = "9"  :  Key(35)\code = #VK_9
Key(36)\name = "F1" :  Key(36)\code = #VK_F1
Key(37)\name = "F2" :  Key(37)\code = #VK_F2
Key(38)\name = "F3" :  Key(38)\code = #VK_F3
Key(39)\name = "F4" :  Key(39)\code = #VK_F4
Key(40)\name = "F5" :  Key(40)\code = #VK_F5
Key(41)\name = "F6" :  Key(41)\code = #VK_F6
Key(42)\name = "F7" :  Key(42)\code = #VK_F7
Key(43)\name = "F8" :  Key(43)\code = #VK_F8
Key(44)\name = "F9" :  Key(44)\code = #VK_F9
Key(45)\name = "F10":  Key(45)\code = #VK_F10
Key(46)\name = "F11":  Key(46)\code = #VK_F11
Key(47)\name = "F12":  Key(47)\code = #VK_F12
Key(48)\name = "F13":  Key(48)\code = #VK_F13
Key(49)\name = "F14":  Key(49)\code = #VK_F14
Key(50)\name = "F15":  Key(50)\code = #VK_F15
Key(51)\name = "F16":  Key(51)\code = #VK_F16
Key(52)\name = "F17":  Key(52)\code = #VK_F17
Key(53)\name = "F18":  Key(53)\code = #VK_F18
Key(54)\name = "F19":  Key(54)\code = #VK_F19
Key(55)\name = "F20":  Key(55)\code = #VK_F20
Key(56)\name = "F21":  Key(56)\code = #VK_F21
Key(57)\name = "F22":  Key(57)\code = #VK_F22
Key(58)\name = "F23":  Key(58)\code = #VK_F23
Key(59)\name = "F24":  Key(59)\code = #VK_F24
Key(60)\name = "Bild Hoch"       : Key(60)\code = #VK_PRIOR
Key(61)\name = "Bild Runter"     : Key(61)\code = #VK_NEXT
Key(62)\name = "Pos 1"           : Key(62)\code = #VK_HOME
Key(63)\name = "Ende"            : Key(63)\code = #VK_END
Key(64)\name = "Einfügen"        : Key(64)\code = #VK_INSERT
Key(65)\name = "Entfernen"       : Key(65)\code = #VK_DELETE
Key(66)\name = "Cursor Hoch"     : Key(66)\code = #VK_UP
Key(67)\name = "Cursor Runter"   : Key(67)\code = #VK_DOWN
Key(68)\name = "Cursor Links"    : Key(68)\code = #VK_LEFT
Key(69)\name = "Cursor Rechts"   : Key(69)\code = #VK_RIGHT
Key(70)\name = "Druck"           : Key(70)\code = #VK_PRINT
Key(71)\name = "Rollen"          : Key(71)\code = #VK_SCROLL
Key(72)\name = "Pause"           : Key(72)\code = #VK_PAUSE
Key(73)\name = "Escape"          : Key(73)\code = #VK_ESCAPE
Key(74)\name = "Löschen"         : Key(74)\code = #VK_BACK
Key(75)\name = "Return"          : Key(75)\code = #VK_RETURN
Key(76)\name = "Addition"        : Key(76)\code = #VK_ADD
Key(77)\name = "Subtraktion"     : Key(77)\code = #VK_SUBTRACT
Key(78)\name = "Multiplikation"  : Key(78)\code = #VK_MULTIPLY
Key(79)\name = "Division"        : Key(79)\code = #VK_DIVIDE
Key(80)\name = "Windows Links"   : Key(80)\code = #VK_LWIN
Key(81)\name = "Windows Rechts"  : Key(81)\code = #VK_RWIN
Key(82)\name = "Leertaste"       : Key(82)\code = #VK_SPACE
Key(83)\name = "Tab"             : Key(83)\code = #VK_TAB

Structure _Statistics
  play_start.i     ; Wiedergabe gestartet
  play_end.i       ; Wiedergabe beendet
  play_time.q      ; Wiedergabedauer
  play_days.i      ; Wiedergabetage
  app_start.i      ; Programmstarts
  radio_traffic.q  ; Internetradio Gesammter Traffic
  ml_playstart_local.i   ; Wiedergabe gestartet von lokalen Dateien
  ml_playstart_online.i  ; Wiedergabe gestartet von online Dateien
EndStructure
Global Statistics._Statistics

Structure _Tag
  file.s
  title.s
  artist.s
  album.s
  year.w
  comment.s
  track.w
  genre.s
  bitrate.w
  samplerate.f
  channels.b
  length.i
  cType.i
EndStructure

Structure _CurrPlay
  curr.i
  file.s
  fingerprint.s
  channel.i [2]
  flags.i   [2]
  volume.f  [2]
  pos.i
  poschange.i
  playtype.i
  plindex.i
  description.s [5]
  tag._Tag
EndStructure
Global CurrPlay._CurrPlay

Structure _PlayLastPlay
  file.s
  fingerprint.s
  pos.q
  playtype.i
  plindex.i
EndStructure
Global PlayLastPlay._PlayLastPlay

Structure _PlayList
  mix.a
  tag._Tag
EndStructure
Global NewList PlayList._PlayList()

Structure _MediaLibary
 tag._Tag
 firstplay.i
 lastplay.i
 playcount.w
 rating.b
 added.i
 flags.b
 playlist.i
EndStructure
Global NewList MediaLibary._MediaLibary()

Structure _MediaLibary_PlayList
  id.i
EndStructure
Global NewMap MediaLibary_PlayList._MediaLibary_PlayList()

Structure _MediaLibarySearch
  file.s
  index.i
  misc.i
EndStructure
Global NewList MediaLibarySearch._MediaLibarySearch()

Global NewList MediaLib_Path.s() ; Enthällt die Medienbibliothek Stammordner

Structure _SearchResult
 name.s
 index.i
EndStructure
Global NewList SearchResult._SearchResult()

Structure _DeviceList
  name.s
  enabled.b
EndStructure
Global NewList DeviceList._DeviceList()

Structure _BKM
  Msg.i
  iParam1.i
  iParam2.i
  sParam1.s {500}
  sParam2.s {100}
EndStructure

;- MP3 Genre
#MaxMP3Genre = 147
Global Dim MP3Genre.s(#MaxMP3Genre)

MP3Genre(0)   = "Blues"
MP3Genre(1)   = "Classic Rock"
MP3Genre(2)   = "Country"
MP3Genre(3)   = "Dance"
MP3Genre(4)   = "Disco"
MP3Genre(5)   = "Funk"
MP3Genre(6)   = "Grunge"
MP3Genre(7)   = "Hip-Hop"
MP3Genre(8)   = "Jazz"
MP3Genre(9)   = "Metal"
MP3Genre(10)  = "New Age"
MP3Genre(11)  = "Oldies"
MP3Genre(12)  = "Other"
MP3Genre(13)  = "Pop"
MP3Genre(14)  = "R&B"
MP3Genre(15)  = "Rap"
MP3Genre(16)  = "Reggae"
MP3Genre(17)  = "Rock"
MP3Genre(18)  = "Techno"
MP3Genre(19)  = "Industrial"
MP3Genre(20)  = "Alternative"
MP3Genre(21)  = "Ska"
MP3Genre(22)  = "Death Metal"
MP3Genre(23)  = "Pranks"
MP3Genre(24)  = "Soundtrack"
MP3Genre(25)  = "Euro-Techno"
MP3Genre(26)  = "Ambient"
MP3Genre(27)  = "Trip-Hop"
MP3Genre(28)  = "Vocal"
MP3Genre(29)  = "Jazz+Funk"
MP3Genre(30)  = "Fusion"
MP3Genre(31)  = "Trance"
MP3Genre(32)  = "Classical"
MP3Genre(33)  = "Instrumental"
MP3Genre(34)  = "Acid"
MP3Genre(35)  = "House"
MP3Genre(36)  = "Game"
MP3Genre(37)  = "Sound Clip"
MP3Genre(38)  = "Gospel"
MP3Genre(39)  = "Noise"
MP3Genre(40)  = "AlternRock"
MP3Genre(41)  = "Bass"
MP3Genre(42)  = "Soul"
MP3Genre(43)  = "Punk"
MP3Genre(44)  = "Space"
MP3Genre(45)  = "Meditative"
MP3Genre(46)  = "Instrumental Pop"
MP3Genre(47)  = "Instrumental Rock"
MP3Genre(48)  = "Ethnic"
MP3Genre(49)  = "Gothic"
MP3Genre(50)  = "Darkwave"
MP3Genre(51)  = "Techno-Industrial"
MP3Genre(52)  = "Electronic"
MP3Genre(53)  = "Pop-Folk"
MP3Genre(54)  = "Eurodance"
MP3Genre(55)  = "Dream"
MP3Genre(56)  = "Southern Rock"
MP3Genre(57)  = "Comedy"
MP3Genre(58)  = "Cult"
MP3Genre(59)  = "Gangsta"
MP3Genre(60)  = "Top 40"
MP3Genre(61)  = "Christian Rap"
MP3Genre(62)  = "PopFunk"
MP3Genre(63)  = "Jungle"
MP3Genre(64)  = "Native American"
MP3Genre(65)  = "Cabaret"
MP3Genre(66)  = "New Wave"
MP3Genre(67)  = "Psychadelic"
MP3Genre(68)  = "Rave"
MP3Genre(69)  = "Showtunes"
MP3Genre(70)  = "Trailer"
MP3Genre(71)  = "Lo-Fi"
MP3Genre(72)  = "Tribal"
MP3Genre(73)  = "Acid Punk"
MP3Genre(74)  = "Acid Jazz"
MP3Genre(75)  = "Polka"
MP3Genre(76)  = "Retro"
MP3Genre(77)  = "Musical"
MP3Genre(78)  = "Rock & Roll"
MP3Genre(79)  = "Hard Rock"
MP3Genre(80)  = "Folk"
MP3Genre(81)  = "Folk-Rock"
MP3Genre(82)  = "National Folk"
MP3Genre(83)  = "Swing"
MP3Genre(84)  = "Fast Fusion"
MP3Genre(85)  = "Bebob"
MP3Genre(86)  = "Latin"
MP3Genre(87)  = "Revival"
MP3Genre(88)  = "Celtic"
MP3Genre(89)  = "Bluegrass"
MP3Genre(90)  = "Avantgarde"
MP3Genre(91)  = "Gothic Rock"
MP3Genre(92)  = "Progressive Rock"
MP3Genre(93)  = "Psychedelic Rock"
MP3Genre(94)  = "Symphonic Rock"
MP3Genre(95)  = "Slow Rock"
MP3Genre(96)  = "Big Band"
MP3Genre(97)  = "Chorus"
MP3Genre(98)  = "Easy Listening"
MP3Genre(99)  = "Acoustic"
MP3Genre(100) = "Humour"
MP3Genre(101) = "Speech"
MP3Genre(102) = "Chanson"
MP3Genre(103) = "Opera"
MP3Genre(104) = "Chamber Music"
MP3Genre(105) = "Sonata"
MP3Genre(106) = "Symphony"
MP3Genre(107) = "Booty Bass"
MP3Genre(108) = "Primus"
MP3Genre(109) = "Porn Groove"
MP3Genre(110) = "Satire"
MP3Genre(111) = "Slow Jam"
MP3Genre(112) = "Club"
MP3Genre(113) = "Tango"
MP3Genre(114) = "Samba"
MP3Genre(115) = "Folklore"
MP3Genre(116) = "Ballad"
MP3Genre(117) = "Power Ballad"
MP3Genre(118) = "Rhythmic Soul"
MP3Genre(119) = "Freestyle"
MP3Genre(120) = "Duet"
MP3Genre(121) = "Punk Rock"
MP3Genre(122) = "Drum Solo"
MP3Genre(123) = "A capella"
MP3Genre(124) = "Euro-House"
MP3Genre(125) = "Dance Hall"
MP3Genre(126) = "Goa"
MP3Genre(127) = "Drum & Bass"
MP3Genre(128) = "Club-House"
MP3Genre(129) = "Hardcore"
MP3Genre(130) = "Terror"
MP3Genre(131) = "Indie"
MP3Genre(132) = "BritPop"
MP3Genre(133) = "Negerpunk"
MP3Genre(134) = "Polsk Punk"
MP3Genre(135) = "Beat"
MP3Genre(136) = "Christian Gangsta"
MP3Genre(137) = "Heavy Metal"
MP3Genre(138) = "Black Metal"
MP3Genre(139) = "Crossover"
MP3Genre(140) = "Contemporary Christian"
MP3Genre(141) = "Christian Rock"
MP3Genre(142) = "Merengue"
MP3Genre(143) = "Salsa"
MP3Genre(144) = "Thrash Metal"
MP3Genre(145) = "Anime"
MP3Genre(146) = "JPop"
MP3Genre(147) = "SynthPop"

Structure _PluginExecutables
  hWnd.i
  file.s
  version.c
  autor.s
  description.s
EndStructure
Global NewList PluginEXE._PluginExecutables()

Structure _Plugin
  file.s
  start.b
EndStructure
Global NewList Plugin._Plugin()

Structure _MidiLyrics
  text.s
  spos.i
  epos.i
EndStructure
Global NewList MidiLyrics._MidiLyrics()

Global NewMap Misc_Album.s()
Global NewMap Misc_Artist.s()
Global NewMap Misc_Genre.s()

Global Dim Colors.i(15) ; Für ColorRequesterEx

;- FileType
Structure _FileType
  ext.s
  dsc.s
  typ.b
EndStructure
Global NewMap FileType._FileType()

FileType("WAV")\ext  = "WAV"  : FileType("WAV")\dsc  = "Riff Wave"                             : FileType("WAV")\typ  = #FileType_Audio
FileType("AIF")\ext  = "AIF"  : FileType("AIF")\dsc  = "Audio Interchange"                     : FileType("AIF")\typ  = #FileType_Audio
FileType("AIFF")\ext = "AIFF" : FileType("AIFF")\dsc = "Audio Interchange"                     : FileType("AIFF")\typ = #FileType_Audio
FileType("MP4")\ext  = "MP4"  : FileType("MP4")\dsc  = "MPEG 4 Container"                      : FileType("MP4")\typ  = #FileType_Audio
FileType("MP3")\ext  = "MP3"  : FileType("MP3")\dsc  = "MPEG 1 Audio Layer 3"                  : FileType("MP3")\typ  = #FileType_Audio
FileType("MP2")\ext  = "MP2"  : FileType("MP2")\dsc  = "MPEG 1 Audio Layer 2"                  : FileType("MP2")\typ  = #FileType_Audio
FileType("MP1")\ext  = "MP1"  : FileType("MP1")\dsc  = "MPEG 1 Audio Layer 1"                  : FileType("MP1")\typ  = #FileType_Audio
FileType("MO3")\ext  = "MO3"  : FileType("MO3")\dsc  = "MO3 Modul"                             : FileType("MO3")\typ  = #FileType_Audio
FileType("IT")\ext   = "IT"   : FileType("IT")\dsc   = "Impulse Tracker"                       : FileType("IT")\typ   = #FileType_Audio
FileType("XM")\ext   = "XM"   : FileType("XM")\dsc   = "FastTracker 2"                         : FileType("XM")\typ   = #FileType_Audio
FileType("S3M")\ext  = "S3M"  : FileType("S3M")\dsc  = "ScreamTracker 3"                       : FileType("S3M")\typ  = #FileType_Audio
FileType("MTM")\ext  = "MTM"  : FileType("MTM")\dsc  = "MultiTracker"                          : FileType("MTM")\typ  = #FileType_Audio
FileType("MOD")\ext  = "MOD"  : FileType("MOD")\dsc  = "Modul"                                 : FileType("MOD")\typ  = #FileType_Audio
FileType("UMX")\ext  = "UMX"  : FileType("UMX")\dsc  = "Unreal Music"                          : FileType("UMX")\typ  = #FileType_Audio
FileType("WMA")\ext  = "WMA"  : FileType("WMA")\dsc  = "Windows Media Audio"                   : FileType("WMA")\typ  = #FileType_Audio
FileType("WMV")\ext  = "WMV"  : FileType("WMV")\dsc  = "Windows Media Video"                   : FileType("WMV")\typ  = #FileType_Audio
FileType("FLAC")\ext = "FLAC" : FileType("FLAC")\dsc = "Free Lossless Audio Codec"             : FileType("FLAC")\typ = #FileType_Audio
FileType("MID")\ext  = "MID"  : FileType("MID")\dsc  = "Musical Instrument Digital Interface"  : FileType("MID")\typ  = #FileType_Audio
FileType("WV")\ext   = "WV"   : FileType("WV")\dsc   = "WavPack"                               : FileType("WV")\typ   = #FileType_Audio
FileType("WVC")\ext  = "WVC"  : FileType("WVC")\dsc  = "WavPack"                               : FileType("WVC")\typ  = #FileType_Audio
FileType("AAC")\ext  = "AAC"  : FileType("AAC")\dsc  = "Advanced Audio Coding"                 : FileType("AAC")\typ  = #FileType_Audio
FileType("OGG")\ext  = "OGG"  : FileType("OGG")\dsc  = "Ogg Vorbis"                            : FileType("OGG")\typ  = #FileType_Audio

FileType("PLS")\ext  = "PLS"  : FileType("PLS")\dsc  = "Wiedergabeliste"                       : FileType("PLS")\typ  = #FileType_PlayList
FileType("M3U")\ext  = "M3U"  : FileType("M3U")\dsc  = "Wiedergabeliste"                       : FileType("M3U")\typ  = #FileType_PlayList
FileType("XSPF")\ext = "XSPF" : FileType("XSPF")\dsc = "Wiedergabeliste"                       : FileType("XSPF")\typ = #FileType_PlayList
FileType("M3U8")\ext = "M3U8" : FileType("M3U8")\dsc = "Wiedergabeliste"                       : FileType("M3U8")\typ = #FileType_PlayList

;- DeclareProcedure

; proc_misc.pbi
Declare.i CompareString(String$, CompareString$, CaseSensetive = 0, WholeWords = 0)
Declare.s GetFileNamePart(Path$)
Declare.s ExecutableDirectory()
Declare.s AppDataDirectory()
Declare.s MyMusicDirectory()
Declare.i MsgBox_Error(Text$, Title$ = "Fehler")
Declare.i MsgBox_Exclamation(Text$, Title$ = "Hinweis")
Declare.s TimeString(Seconds.q)
Declare.i ColorBright(RGB, Bright)
Declare.i Clipboard_GetFileCount()
Declare.i ListIconGadget_SetColumnAlign(Gadget, Column, Align = #LVCFMT_LEFT)
Declare.i ListIconGadget_GetColumnAlign(Gadget, Column)
Declare.i ListIconSort_SetColumnArrow(Gadget, Column, Sort)
Declare.i ListIconSort_CompareString(lParam1, lParam2, lParamSort)
Declare.i ListIconSort_CompareValue(lParam1, lParam2, lParamSort)
Declare.i LISort_SortColumn(Gadget, Column, Type, Align)
Declare ComboBoxGadget_SetSel(Gadget, cpMin, cpMax)
Declare.i Toolbar_Button(Toolbar, ButtonID, Pos, ImageIndex, Style = #TBSTYLE_BUTTON)
Declare.i Toolbar_Seperator(Toolbar, Pos)
Declare.i Toolbar_ChangeIcon(Toolbar, Pos, ImageIndex)
Declare.i Toolbar_GetWidth(Toolbar)
Declare.i Toolbar_GetHeight(Toolbar)
Declare.s TextGadget_CompactPath(Gadget, Path$)
Declare.s PeekStringDoubleNull(*String, Format = #PB_Ascii)
Declare.i ChangeCursor(Gadget, Cursor)
Declare.s EditorGadget_GetSelText(Gadget)
Declare.i ListIconGadget_SelAll(Gadget)
Declare.s GetLastPathPart(Path$)
Declare.s FormatByteSize(ByteSize.q, RndCnt = 2, Ext = 1)
Declare.i ScreenSaver_Active()
Declare.i ShutdownWindows(flags = #EWX_SHUTDOWN)
Declare.i REG_OpenKey(hKey, SubKey$, Access)
Declare.i REG_CreateKey(hKey, SubKey$, NewSubKey$)
Declare.i REG_SetValue(hKey, SubKey$, Value$)
Declare.i RegisterFile(Extension$, Application$, Command$)
Declare.i ColorRequesterEx(Window, DefaultColor, *ClrArray)
Declare.i ChangeMSNStatus(Enable, Category$, Message$)
Declare.i BassKing_SendMessage(Msg.i, iParam1.i = 0, iParam2.i = 0, sParam1.s = "", sParam2.s = "")
Declare.i DayDif(FirstDate, SecondDate)

; procedures.pbi
Declare.i EditorGadget_SaveSel(Gadget)
Declare.s TagLib_CheckString(String$)
Declare.i TagLib_ReadTag(*Tag._Tag)
Declare.s MetaData_GetFormatString(cType, LongFormat = 1)
Declare.i MetaData_ReadData(*Tag._Tag)
Declare MetaData_RefreshWindow(*Tag._Tag)
Declare MetaData_SaveData()
Declare MetaData_CurrPlay()
Declare.s Bass_GetErrorString(Error)
Declare Bass_RefreshDeviceList()
Declare Bass_InitPlugin(Plugin$)
Declare Bass_InitSystem(Device, Rate)
Declare Bass_Volume(fVolume.f = -1, PluginMSG = 1)
Declare.s Bass_GetCurrFileName()
Declare Bass_SetPos(Position.q = 0)
Declare.q Bass_GetPos()
Declare Bass_SetFrequenz()
Declare Bass_SetPanel()
Declare Bass_SetEqualizerBand(Band)
Declare Bass_SetEqualizerPanel(BW, A, B, C, D, E, F, G, H, I, J)
Declare Bass_SetEqualizerPreset(Preset)
Declare Bass_SetEqualizer()
Declare Bass_SetReverbParameters()
Declare Bass_SetReverb()
Declare Bass_SetEchoParameters()
Declare Bass_SetEcho()
Declare Bass_SetFlanger()
Declare Bass_SyncEnd(handle, channel, datas, *user)
Declare Bass_SyncMeta(Handle, Channel, Datas, User)
Declare Bass_SyncPos(Handle, Channel, Datas, *user)
Declare Bass_SyncMidiLyrics(Handle, Channel, Datas, *user)
Declare Bass_SyncDownload(Buffer, Length, User)
Declare Bass_FadeIn()
Declare Bass_FadeOut(Wait = 0)
Declare Bass_ReadMidiLyrics(Channel)
Declare Bass_PlayInternetStream(IncrasePlayCounter)
Declare Bass_PlayMedia(File$, PlayType, IncrasePlayCounter = 1)
Declare Bass_PauseMedia()
Declare Bass_RefreshSpectrum()
Declare Bass_RefreshPos()
Declare Bass_DefauldEffects()
Declare Bass_Callback()
Declare.s HTML_ConvertText(String$)
Declare.s HTML_ConvertNum(Value)
Declare PlayList_RefreshHeader()
Declare PlayList_GetLength()
Declare PlayList_RefreshAllTimes()
Declare PlayList_RefreshMenu()
Declare PlayList_AddItem(Title$, Artist$, Album$, Track, Length, Year, Type, Sel = -1)
Declare PlayList_Play()
Declare PlayList_PreviousTrack()
Declare PlayList_NextTrack()
Declare PlayList_Remove(Sel)
Declare PlayList_Sort(Type)
Declare PlayList_Search()
Declare.i PlayList_Save(Path$ = "", Overwrite = -1)
Declare PlayList_AddPlayListM3U(File$, New = 0)
Declare PlayList_AddPlayListPLS(File$, New = 0)
Declare PlayList_AddPlayListXSPF(File$, New = 0)
Declare PlayList_AddFile(File$ = "", Play = 0)
Declare PlayList_AddFileFast(*Tag._Tag)
Declare PlayList_AddFolder(Folder.s, Recursiv.b, Play = 0)
Declare PlayList_AddDrop()
Declare PlayList_CopyFiles()
Declare PlayList_InsertClipboardFiles()
Declare PlayList_RefreshTrackInfo()
Declare PlayList_Generate()
Declare PlayList_Info()
Declare.i MediaLib_CalcRating()
Declare MediaLib_RefreshStatusText()
Declare MediaLib_RefreshHeader()
Declare MediaLib_AddItem(Title$, Artist$, Album$, Track, Length, Year, PlayCount, FirstPlay, LastPlay, Rating, Type, Sel)
Declare MediaLib_AddFile(File$, IncrasePlayCounter = 0)
Declare MediaLib_AddInetStream(URL$ = "")
Declare MediaLib_CheckFiles()
Declare MediaLib_ScanFolderRecursive(Folder$)
Declare MediaLib_Scan(*Dummy)
Declare MediaLib_StartScan()
Declare MediaLib_SortAlbumProc(lParam1, lParam2, lParamSort)
Declare MediaLib_FormatPopUp()
Declare MediaLib_MenuEventOne(EventMenu)
Declare MediaLib_MenuEventAll(EventMenu, Align = 1)
Declare MediaLib_SendToPlayList(New = 0)
Declare MediaLib_AutoComplete()
Declare MediaLib_ShowMisc()
Declare MediaLib_ShowDatabase(Filter)
Declare MediaLib_Play()
Declare MediaLib_SetPlayList()
Declare MediaLib_RemovePlayList()
Declare MediaLib_SavePlayList()
Declare MediaLib_BackgroundScan(*Dummy)
Declare Window_RefreshTaskBar()
Declare Window_ResizeGadgets(Window)
Declare Window_ChangeColor()
Declare Window_ChangeFonts()
Declare Window_ChangeOpacity()
Declare Window_ChangeSize(NewSizeType)
Declare Window_MinimizeMaximize()
Declare Window_Callback(hWnd, Msg, wParam, lParam)
Declare Window_ChangeColumnAlign(Align)
Declare Window_RefreshWorker()
Declare Window_SetSplashState(Text$)
Declare.i GadgetCallback_Position(hWnd, Msg, wParam, lParam)
Declare GadgetCallback_Volume(hWnd, Msg, wParam, lParam)
Declare GadgetCallback_MidiLyrics(hWnd, Msg, wParam, lParam)
Declare.s GetHotkeyName(Index)
Declare Position_Save()
Declare Position_Load()
Declare Position_Remove()
Declare Position_ClearList()
Declare RadioLog_Clear()
Declare RadioLog_Save()
Declare Preferences_RefreshColorThemes()
Declare Preferences_ReloadFonts()
Declare Preferences_ColorThema_OpenFile(File$)
Declare Preferences_ColorThema_Open()
Declare Preferences_ColorThema_Save()
Declare Preferences_Init()
Declare Preferences_Apply()
Declare Preferences_CheckApply()
Declare Preferences_ChangeArea(SetSel)
Declare Preferences_ChangeLayout()
Declare Preferences_ChangeFont()
Declare Preferences_ChangeHotKeyState()
Declare Preferences_SetHotKeyState()
Declare Preferences_ChangeSaveFolder()
Declare Preferences_ChangeMidiSF2File()
Declare Preferences_CheckPath(Path$)
Declare Preferences_AddPath()
Declare Preferences_RemPath()
Declare Statistics_RefreshArea()
Declare Statistics_ChangeArea()
Declare Statistics_Reset()
Declare ChangeClipboardText(*Tag._CurrPlay)
Declare AutoTag_CreateList()
Declare AutoTag_InitWindow()
Declare AutoTag_Run(*Dummy)
Declare Feedback_CheckInputs(Gadget = -1)
Declare Feedback_Reset()
Declare Feedback_Send()
Declare.s CheckSaveString(String$)
Declare Save_PlayList(Msg)
Declare Save_MediaLibary(Msg)
Declare Save_Preferences(Msg)
Declare Save_Log()
Declare Open_PlayList()
Declare Open_MediaLibary()
Declare Open_Preferences()
Declare AutoSave()
Declare Backup_RefreshOverview()
Declare Backup_CreateThread(*Dummy)
Declare Backup_Create()
Declare Backup_Restore()
Declare Backup_Delete()
Declare UpdateCheck_DownloadThread(ShowRequester)
Declare UpdateCheck_CheckThread(ShowRequester)
Declare UpdateCheck_Start(ShowMessage = 1)
Declare Task_DoTask()
Declare Task_StartTimeOut()
Declare Task()
Declare.i Plugin_SendMessage(Window, Message)
Declare.i Plugin_SendValue(Window.i, Message.i, Value.i)
Declare.i Plugin_SendString(Window, Message, String$)
Declare Plugin_SendCurrPlay(Plugin = 0)
Declare Plugin_ClearLists()
Declare Plugin_IsInList(File$)
Declare Plugin_ScanFolder()
Declare Plugin_RefreshLists()
Declare Plugin_Run(Plugin = -2)
Declare Plugin_RegPreferences()
Declare Plugin_RegEnd()
Declare Plugin_DoMessage(Msg, iParam1, iParam2, sParam1$, sParam2$)
Declare HotKey_GlobalEvent()
Declare HotKey_MediaEvent()
Declare Timer_Hotkeys()
Declare Timer_Misc()
Declare Application_Start()
Declare Application_End(FastEnd = 0)
Declare Log_Add(String$, Type = #Log_Normal, RefreshWin = 1)
Declare Log_Save()
Declare Log_Copy()
Declare Log_Clear()
Declare Log_ShowPopUp()

;- Ressource
iImagelist = ImageList_LoadImage_(GetModuleHandle_(0), "#1", 16, #Null, #CLR_DEFAULT, #IMAGE_BITMAP, #LR_CREATEDIBSECTION)
If iImagelist <> 0 And ImageList_GetImageCount_(iImagelist) > 0
  Global Dim ImageList.i(ImageList_GetImageCount_(iImagelist) - 1)
  For iNext = 0 To ImageList_GetImageCount_(iImagelist) - 1
    ImageList(iNext) = ImageList_GetIcon_(iImagelist, iNext, #Null)
  Next
Else
  MsgBox_Error("ImageList 'ImageList' konnte nicht geöffnet werden") : End
EndIf

iWorker = ImageList_LoadImage_(GetModuleHandle_(0), "#3", 16, #Null, #CLR_DEFAULT, #IMAGE_BITMAP, #LR_CREATEDIBSECTION)
If iWorker <> 0 And ImageList_GetImageCount_(iWorker) > 0
  Global Dim Worker.i(ImageList_GetImageCount_(iWorker) - 1)
  For iNext = 0 To ImageList_GetImageCount_(iWorker) - 1
    Worker(iNext) = ImageList_GetIcon_(iWorker, iNext, #Null)
  Next
Else
  MsgBox_Error("ImageList 'Worker' konnte nicht geöffnet werden") : End
EndIf

iImgInfologo = LoadImage_(GetModuleHandle_(0), "#1", #IMAGE_ICON, 48, 48, #LR_DEFAULTCOLOR)
If iImgInfologo = 0
  MsgBox_Error("InfoLogo konnte nicht geöffnet werden"): End
EndIf

iImgPrgLogo = LoadImage_(GetModuleHandle_(0), "#2", #IMAGE_BITMAP, 380, 139, #LR_DEFAULTCOLOR)
If iImgPrgLogo = 0
  MsgBox_Error("Programlogo konnte nicht geöffnet werden"): End
EndIf

Global iCursor_Hand.i = LoadCursor_(0, #IDC_HAND)
If iCursor_Hand = 0
  MsgBox_Exclamation("Cursor 'Hand' konnte nicht geöffnet werden")
EndIf
; IDE Options = PureBasic 4.41 (Windows - x86)
; CursorPosition = 1185
; FirstLine = 1167
; Folding = -----------
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant