; Enthällt alle Programminternen Proceduren von BassKing
; Proceduren die nur für BassKing gelten!
;
; Letzte Bearbeitung: 28.11.2009

Procedure.i EditorGadget_SaveSel(Gadget)
  If IsGadget(Gadget) And GadgetType(Gadget) = #PB_GadgetType_Editor
    Protected sFile.s, iFile.i
    
    sFile = SaveFileRequester("Speichern", GetCurrentDirectory(), "Text Datei|*.*|Alle Dateien|*.*", 0)
    If sFile
      
      If SelectedFilePattern() = 0 And GetExtensionPart(sFile) = ""
        sFile + ".txt"
      EndIf
      
      If FileSize(sFile) > 0
        If MessageRequester("Warnung", "Datei '" + sFile + "' existiert bereits, Datei überschreiben?", #MB_ICONQUESTION|#MB_YESNO) = #IDNO
          ProcedureReturn 0
        EndIf
      EndIf
      
      iFile = CreateFile(#PB_Any, sFile)
      If iFile
        WriteString(iFile, GetGadgetText(#G_ED_MidiLyrics_Text))
        CloseFile(iFile)
      Else
        MessageRequester("Fehler", "Datei '" + sFile + "' konnte nicht erstellt werden.", #MB_ICONERROR|#MB_OK)
      EndIf
      
      ProcedureReturn 1
    EndIf
  EndIf
EndProcedure

; Ändert die Aktionsnachricht in der Statusbar
; Priority gibt die Priorität an, bzw. wie hoch die Priorität sein muß zum ersetzen
; ShowTime gibt an, wie lange der Text angezeigt wird, 0 für unendlich
Procedure ProcessMessage(Text$, Priority, ShowTime = 1500)
  If Trim(Text$) <> "" And Text$ <> ProcessMessage\Text
    If ProcessMessage\Priority <= Priority
      ProcessMessage\Text      = Text$
      ProcessMessage\AddTime   = timeGetTime_()
      ProcessMessage\ShowTime  = ShowTime
      ProcessMessage\Priority  = Priority
      
      StatusBarText(#Statusbar_Main, #SBField_Process, Text$)
    EndIf
  EndIf
EndProcedure

; Entfernt die Aktionsnachricht in der Statusbar
Procedure ProcessMessage_Remove()
  StatusBarText(#Statusbar_Main, #SBField_Process, "")
  
  ClearStructure(@ProcessMessage, _ProcessMessage)
EndProcedure

Procedure.s TagLib_CheckString(String$)
  String$ = Trim(String$)
  
  If FindString(String$, "|", 1) > 0
    String$ = ReplaceString(String$, "|", " ")
  EndIf
  If FindString(String$, #CRLF$, 1) > 0
    String$ = ReplaceString(String$, #CRLF$, " ")
  EndIf
  If FindString(String$, #LFCR$, 1) > 0
    String$ = ReplaceString(String$, #LFCR$, " ")
  EndIf
  If FindString(String$, #CR$, 1) > 0
    String$ = ReplaceString(String$, #CR$, " ")
  EndIf
  If FindString(String$, #LF$, 1) > 0
    String$ = ReplaceString(String$, #LF$, " ")
  EndIf
  
  ProcedureReturn String$
EndProcedure

Procedure.i TagLib_ReadTag(*Tag._Tag)
  Protected iResult.i
  
  If Trim(*Tag\file)
    Protected iFile.i
    
    iFile = taglib_file_new(*Tag\file)
    If iFile
      Protected *Datas
      
      taglib_set_strings_unicode(1)
      
      *Datas = taglib_file_tag(iFile)
      If *Datas
        *Tag\title   = TagLib_CheckString(PeekS(taglib_tag_title(*Datas) ,-1, #PB_UTF8))
        *Tag\artist  = TagLib_CheckString(PeekS(taglib_tag_artist(*Datas) ,-1, #PB_UTF8))
        *Tag\album   = TagLib_CheckString(PeekS(taglib_tag_album(*Datas) ,-1, #PB_UTF8))
        *Tag\year    = taglib_tag_year(*Datas)
        *Tag\comment = TagLib_CheckString(PeekS(taglib_tag_comment(*Datas), -1, #PB_UTF8))
        *Tag\track   = taglib_tag_track(*Datas)
        *Tag\genre   = TagLib_CheckString(PeekS(taglib_tag_genre(*Datas) ,-1, #PB_UTF8))
      EndIf
      
      *Datas = taglib_file_audioproperties(iFile)
      If *Datas
        *Tag\bitrate    = taglib_audioproperties_bitrate(*Datas)
        *Tag\samplerate = taglib_audioproperties_samplerate(*Datas)
        *Tag\channels   = taglib_audioproperties_channels(*Datas)
        *Tag\length     = taglib_audioproperties_length(*Datas)
      EndIf
      
      taglib_tag_free_strings()
      taglib_file_free(iFile)
      
      iResult = 1
    EndIf
  EndIf
  
  ProcedureReturn iResult
EndProcedure

; Konvertier Channel cType zu einen String
Procedure.s MetaData_GetFormatString(cType, LongFormat = 1)
  Protected sResult.s
  
  If LongFormat = 1
    Select cType
      Case #BASS_CTYPE_SAMPLE            : sResult = "Sample Channel"
      Case #BASS_CTYPE_RECORD            : sResult = "Aufnahme"
      Case #BASS_CTYPE_STREAM            : sResult = "User Sample Stream"
      Case #BASS_CTYPE_STREAM_OGG	       : sResult = FileType("OGG")\dsc
      Case #BASS_CTYPE_STREAM_MP1	       : sResult = FileType("MP1")\dsc
      Case #BASS_CTYPE_STREAM_MP2	       : sResult = FileType("MP2")\dsc
      Case #BASS_CTYPE_STREAM_MP3	       : sResult = FileType("MP3")\dsc
      Case #BASS_CTYPE_STREAM_MP4        : sResult = FileType("MP4")\dsc
      Case #BASS_CTYPE_STREAM_AAC        : sResult = FileType("AAC")\dsc
      Case #BASS_CTYPE_STREAM_AIFF       : sResult = FileType("AIFF")\dsc
      Case #BASS_CTYPE_STREAM_WAV        : sResult = FileType("WAV")\dsc
      Case #BASS_CTYPE_STREAM_WAV_PCM    : sResult = FileType("WAV")\dsc
      Case #BASS_CTYPE_STREAM_WAV_FLOAT  : sResult = FileType("WAV")\dsc
      Case #BASS_CTYPE_STREAM_WMA        : sResult = FileType("WMA")\dsc
      Case #BASS_CTYPE_STREAM_WMA_MP3    : sResult = FileType("WMA")\dsc
      Case #BASS_CTYPE_STREAM_MIDI       : sResult = FileType("MID")\dsc
      Case #BASS_CTYPE_STREAM_WV         : sResult = FileType("WV")\dsc
      Case #BASS_CTYPE_MUSIC_MOD	       : sResult = FileType("MOD")\dsc
      Case #BASS_CTYPE_MUSIC_MTM	       : sResult = FileType("MTM")\dsc
      Case #BASS_CTYPE_MUSIC_S3M	       : sResult = FileType("S3M")\dsc
      Case #BASS_CTYPE_MUSIC_XM		       : sResult = FileType("XM")\dsc
      Case #BASS_CTYPE_MUSIC_IT		       : sResult = FileType("IT")\dsc
      Case #BASS_CTYPE_MUSIC_MO3	       : sResult = FileType("MO3")\dsc
    EndSelect
  Else
    Select cType
      Case #BASS_CTYPE_STREAM_OGG	       : sResult = "OGG"
      Case #BASS_CTYPE_STREAM_MP1	       : sResult = "MP1"
      Case #BASS_CTYPE_STREAM_MP2	       : sResult = "MP2"
      Case #BASS_CTYPE_STREAM_MP3	       : sResult = "MP3"
      Case #BASS_CTYPE_STREAM_MP4        : sResult = "MP4"
      Case #BASS_CTYPE_STREAM_AAC        : sResult = "AAC"
      Case #BASS_CTYPE_STREAM_AIFF       : sResult = "AIFF"
      Case #BASS_CTYPE_STREAM_WAV        : sResult = "WAV"
      Case #BASS_CTYPE_STREAM_WAV_PCM    : sResult = "WAV"
      Case #BASS_CTYPE_STREAM_WAV_FLOAT  : sResult = "WAV"
      Case #BASS_CTYPE_STREAM_WMA        : sResult = "WMA"
      Case #BASS_CTYPE_STREAM_WMA_MP3    : sResult = "WMA"
      Case #BASS_CTYPE_STREAM_MIDI       : sResult = "MIDI"
      Case #BASS_CTYPE_STREAM_WV         : sResult = "WV"
      Case #BASS_CTYPE_MUSIC_MOD	       : sResult = "MOD"
      Case #BASS_CTYPE_MUSIC_MTM	       : sResult = "MTM"
      Case #BASS_CTYPE_MUSIC_S3M	       : sResult = "S3M"
      Case #BASS_CTYPE_MUSIC_XM		       : sResult = "XM"
      Case #BASS_CTYPE_MUSIC_IT		       : sResult = "IT"
      Case #BASS_CTYPE_MUSIC_MO3	       : sResult = "MO3"
    EndSelect
  EndIf
  
  ProcedureReturn sResult
EndProcedure

; Liesst Metadaten ein (Result 0 ungültige Datei)
Procedure.i MetaData_ReadData(*Tag._Tag)
  Protected iResult.i
  
  LockMutex(Mutex_ReadTag)
  
  If Trim(*Tag\file) <> ""
    
    ; Reset
    *Tag\title      = ""
    *Tag\artist     = ""
    *Tag\album      = ""
    *Tag\year       = 0
    *Tag\comment    = ""
    *Tag\track      = -1
    *Tag\genre      = ""
    *Tag\bitrate    = 0
    *Tag\samplerate = 0
    *Tag\channels   = 0
    *Tag\length     = 0
    *Tag\cType      = 0
    
    If FileSize(*Tag\file) > 0
      ; Local
      Protected qLength.q
      Protected iChannel.i, CI.BASS_CHANNELINFO
      Protected sTag.s, sCurrTag.s, iCount.i
      
      iChannel = BASS_StreamCreateFile(0, @*Tag\file, 0, 0, 0)
      If iChannel <> 0
        BASS_ChannelGetInfo(iChannel, @CI)
        
        *Tag\cType       = CI\cType ; Format
        *Tag\samplerate  = CI\freq  ; Samplerate
        *Tag\channels    = CI\chans ; Channels
        *Tag\length      = BASS_ChannelBytes2Seconds(iChannel, BASS_ChannelGetLength(iChannel, #BASS_POS_BYTE)) ; Length
        
        Select CI\ctype
          
          ; Windows Media Audio
          Case #BASS_CTYPE_STREAM_WMA , #BASS_CTYPE_STREAM_WMA_MP3
            sTag = PeekStringDoubleNull(BASS_ChannelGetTags(iChannel, #BASS_TAG_WMA), #PB_UTF8)
            If sTag
              iCount = CountString(sTag, "|") + 1
              For iNext = 1 To iCount
                sCurrTag = Trim(StringField(sTag, iNext, "|"))
                ; Title
                If LCase(Left(sCurrTag, 6)) = "title="
                  *Tag\title = Mid(sCurrTag, 7)
                EndIf
                ; Interpret
                If LCase(Left(sCurrTag, 7)) = "author="
                  If *Tag\artist <> ""
                    *Tag\artist + "; "
                  EndIf
                  *Tag\artist + Mid(sCurrTag, 8)
                EndIf
                ; Album
                If LCase(Left(sCurrTag, 14)) = "wm/albumtitle="
                  *Tag\album = Mid(sCurrTag, 15)
                EndIf
                ; Genre
                If LCase(Left(sCurrTag, 9)) = "wm/genre="
                  *Tag\genre = Mid(sCurrTag, 10)
                EndIf
                ; Year
                If LCase(Left(sCurrTag, 8)) = "wm/year="
                  *Tag\year = Val(Mid(sCurrTag, 9))
                EndIf
                ; Track
                If LCase(Left(sCurrTag, 15)) = "wm/tracknumber="
                  *Tag\track = Val(Mid(sCurrTag, 16))
                EndIf
                ; Bitrate
                If LCase(Left(sCurrTag, 8)) = "bitrate="
                  *Tag\bitrate = Val(Mid(sCurrTag, 9)) / 1000
                EndIf
              Next
            EndIf
          
          ; MP4/ACC
          Case #BASS_CTYPE_STREAM_MP4
            sTag = PeekStringDoubleNull(BASS_ChannelGetTags(iChannel, #BASS_TAG_MP4), #PB_UTF8)
            If sTag
              iCount = CountString(sTag, "|") + 1
              For iNext = 1 To iCount
                sCurrTag = Trim(StringField(sTag, iNext, "|"))
                ; Title
                If LCase(Left(sCurrTag, 6)) = "title="
                  *Tag\title = Mid(sCurrTag, 7)
                EndIf
                ; Artist
                If LCase(Left(sCurrTag, 7)) = "artist="
                  *Tag\artist = Mid(sCurrTag, 8)
                EndIf
                ; Album
                If LCase(Left(sCurrTag, 6)) = "album="
                  *Tag\album = Mid(sCurrTag, 7)
                EndIf
                ; Year
                If LCase(Left(sCurrTag, 5)) = "date="
                  *Tag\year = Val(Mid(sCurrTag, 6))
                EndIf
                ; Genre
                If LCase(Left(sCurrTag, 6)) = "genre="
                  *Tag\genre = Mid(sCurrTag, 7)
                EndIf
                ; Comment
                If LCase(Left(sCurrTag, 8)) = "comment="
                  *Tag\comment = Mid(sCurrTag, 9)
                EndIf
                ; Track
                If LCase(Left(sCurrTag, 6)) = "track="
                  *Tag\track = Val(Mid(sCurrTag, 7))
                EndIf
              Next
            EndIf
          
          ; Misc
          Default
            TagLib_ReadTag(*Tag)
            
        EndSelect
        
        If Trim(*Tag\title) = ""
          *Tag\title = GetFileNamePart(*Tag\file)
        EndIf
        
        BASS_StreamFree(iChannel)
        
        iResult = 1 ; Lacal File OK
      Else
        ; Can't open with BASS
        iResult = 0
      EndIf
      
    ElseIf LCase(Left(*Tag\file, 7)) = "http://" Or LCase(Left(*Tag\file, 6)) = "ftp://"
      ;Internet
      *Tag\file = *Tag\file
      iResult = 2 ; Internet Stream OK
      
    Else
      ; Invalid
      iResult = 0
      
    EndIf
  EndIf
  
  UnlockMutex(Mutex_ReadTag)
  
  ProcedureReturn iResult
EndProcedure

Procedure MetaData_RefreshWindow(*Tag._Tag)
  If IsWindow(#Win_Metadata) And *Tag
    Protected qSize.q
    
    ; Path
    SetGadgetText(#G_SR_Metadata_File, *Tag\file)
    GadgetToolTip(#G_SR_Metadata_File, *Tag\file)
    ; Title
    SetGadgetText(#G_SR_Metadata_Title, *Tag\title)
    GadgetToolTip(#G_SR_Metadata_Title, *Tag\title)
    ; Track
    If *Tag\track > 0
      SetGadgetText(#G_SR_Metadata_Track, Str(*Tag\track))
      GadgetToolTip(#G_SR_Metadata_Track, Str(*Tag\track))
    Else
      SetGadgetText(#G_SR_Metadata_Track, "")
      GadgetToolTip(#G_SR_Metadata_Track, "")
    EndIf
    ; Artist
    SetGadgetText(#G_SR_Metadata_Artist, *Tag\artist)
    GadgetToolTip(#G_SR_Metadata_Artist, *Tag\artist)
    ; Album
    SetGadgetText(#G_SR_Metadata_Album, *Tag\album)
    GadgetToolTip(#G_SR_Metadata_Album, *Tag\album)
    ; Year
    If *Tag\year > 0
      SetGadgetText(#G_SR_Metadata_Year, Str(*Tag\year))
      GadgetToolTip(#G_SR_Metadata_Year, Str(*Tag\year))
    Else
      SetGadgetText(#G_SR_Metadata_Year, "")
      GadgetToolTip(#G_SR_Metadata_Year, "")
    EndIf
    ; Genre
    SetGadgetText(#G_CB_Metadata_Genre, *Tag\genre)
    GadgetToolTip(#G_CB_Metadata_Genre, *Tag\genre)
    ; Comment
    SetGadgetText(#G_SR_Metadata_Comment, *Tag\comment)
    GadgetToolTip(#G_SR_Metadata_Comment, *Tag\comment)
    ; FileSize
    qSize = FileSize(*Tag\file)
    If qSize > 0
      SetGadgetText(#G_TX_Metadata_SizeV, FormatByteSize(FileSize(*Tag\file)))
    Else
      SetGadgetText(#G_TX_Metadata_SizeV, "")
    EndIf
    ; Bitrate
    If *Tag\bitrate > 0
      SetGadgetText(#G_TX_Metadata_BitrateV, Str(*Tag\bitrate))
    Else
      SetGadgetText(#G_TX_Metadata_BitrateV, "")
    EndIf
    ; Samplerate
    If *Tag\samplerate > 0
      SetGadgetText(#G_TX_Metadata_SamplerateV, Str(*Tag\samplerate))
    Else
      SetGadgetText(#G_TX_Metadata_SamplerateV, "")
    EndIf
    ; Channels
    If *Tag\channels > 0
      SetGadgetText(#G_TX_Metadata_ChannelsV, Str(*Tag\channels))
    Else
      SetGadgetText(#G_TX_Metadata_ChannelsV, "")
    EndIf
    ; Length
    If *Tag\length > 0
      SetGadgetText(#G_TX_Metadata_LengthV, TimeString(*Tag\length))
    Else
      SetGadgetText(#G_TX_Metadata_LengthV, "")
    EndIf
    ; Format
    SetGadgetText(#G_TX_Metadata_FormatV, MetaData_GetFormatString(*Tag\cType))
    
    ; Midi Lyriken
    If *Tag\cType = #BASS_CTYPE_STREAM_MIDI And ListSize(MidiLyrics()) > 0 And *Tag\file = CurrPlay\file
      DisableGadget(#G_BN_Metadata_MidiLyrics, 0)
    Else
      DisableGadget(#G_BN_Metadata_MidiLyrics, 1)
    EndIf
    
  EndIf
EndProcedure

;Speichert Metadaten aus Metadata Fenster
Procedure MetaData_SaveData()
  Protected File$
  
  File$ = Trim(GetGadgetText(#G_SR_Metadata_File))
  If FileSize(File$) > 0
    Protected iFile.i
    
    iFile = taglib_file_new(File$)
    If iFile
      Protected *Tag, *Proberties
      
      *Tag = taglib_file_tag(iFile)
      If *Tag
        taglib_set_strings_unicode(0)
        
        taglib_tag_set_title(*Tag, Trim(GetGadgetText(#G_SR_Metadata_Title)))
        taglib_tag_set_track(*Tag, Val(Trim(GetGadgetText(#G_SR_Metadata_Track))))
        taglib_tag_set_artist(*Tag, Trim(GetGadgetText(#G_SR_Metadata_Artist)))
        taglib_tag_set_album(*Tag, Trim(GetGadgetText(#G_SR_Metadata_Album)))
        taglib_tag_set_year(*Tag, Val(Trim(GetGadgetText(#G_SR_Metadata_Year))))
        taglib_tag_set_genre(*Tag, Trim(GetGadgetText(#G_CB_Metadata_Genre)))
        taglib_tag_set_comment(*Tag, Trim(GetGadgetText(#G_SR_Metadata_Comment)))
        
        taglib_file_save(iFile)
      EndIf
      
      taglib_tag_free_strings()
      taglib_file_free(iFile)
    EndIf
  EndIf
EndProcedure

Procedure MetaData_CurrPlay()
  Protected Tag._Tag
  
  If CurrPlay\file <> ""
    Tag\file = CurrPlay\file
    If MetaData_ReadData(Tag)
      OpenWindow_Metadata()
      MetaData_RefreshWindow(Tag)
      SetGadgetText(#G_SR_Metadata_File, Bass_GetCurrFileName())
    EndIf
  EndIf
EndProcedure

Procedure.s Bass_GetErrorString(Error)
  Protected sError.s
  
  Select Error
    Case #BASS_OK	            : sError = "Erfolgreich"
    Case #BASS_ERROR_MEM	    : sError = "Speicher Fehler"
    Case #BASS_ERROR_FILEOPEN	: sError = "Datei konnte nicht geöffnet werden"
    Case #BASS_ERROR_DRIVER	  : sError = "Es konnte kein gültiger Treiber gefunden werden"
    Case #BASS_ERROR_BUFLOST  : sError = "Sample Buffer verloren"
    Case #BASS_ERROR_HANDLE	  : sError = "Ungültige Nummer"
    Case #BASS_ERROR_FORMAT	  : sError = "Nicht unterstütztes Sample Format"
    Case #BASS_ERROR_POSITION	: sError = "Ungültige Wiedergabeposition"
    Case #BASS_ERROR_INIT		  : sError = "Bass wurde nicht korrekt initialisiert"
    Case #BASS_ERROR_START	  : sError = "Bass wurde nicht korekt gestartet"
    Case #BASS_ERROR_ALREADY	: sError = "Bereits initialisiert"
    Case #BASS_ERROR_NOCHAN	  : sError = "Es kann kein freier Kanal gefunden werden"
    Case #BASS_ERROR_ILLTYPE	: sError = "Ein ungültiger Typ wurde angegeben"
    Case #BASS_ERROR_ILLPARAM	: sError = "Ein ungültiger Parameter wurde angegeben"
    Case #BASS_ERROR_NO3D		  : sError = "Keine 3D Unterstützung"
    Case #BASS_ERROR_NOEAX	  : sError = "Keine EAX Unterstützung"
    Case #BASS_ERROR_DEVICE	  : sError = "Ungültige Gerätenummer"
    Case #BASS_ERROR_NOPLAY	  : sError = "Keine Wiedergabe"
    Case #BASS_ERROR_FREQ		  : sError = "Ungültige Sample Rate"
    Case #BASS_ERROR_NOTFILE	: sError = "Es handelt sich nicht um einen Dateistream"
    Case #BASS_ERROR_NOHW		  : sError = "Keine Soundgeräte verfügbar"
    Case #BASS_ERROR_EMPTY	  : sError = "Die MOD Musik hat kein Sequence Daten"
    Case #BASS_ERROR_NONET	  : sError = "Es konnte keine Internetverbindung geöffnet werden"
    Case #BASS_ERROR_CREATE	  : sError = "Datei konnte nicht erstellt werden"
    Case #BASS_ERROR_NOFX		  : sError = "Effekte sind nicht verfügbar"
    Case #BASS_ERROR_PLAYING	: sError = "Der Kanal wird wiedergegeben"
    Case #BASS_ERROR_NOTAVAIL	: sError = "Angeforderte Daten sind nicht verfügbar"
    Case #BASS_ERROR_DECODE	  : sError = "Es handelt sich um ein Decoding Kanal"
    Case #BASS_ERROR_DX		    : sError = "Keine gültige DirectX Version"
    Case #BASS_ERROR_TIMEOUT	: sError = "Verbindung Timeout"
    Case #BASS_ERROR_FILEFORM	: sError = "Nicht unterstützes Dateiformat"
    Case #BASS_ERROR_SPEAKER	: sError = "Nicht unterstützte Lautsprecher"
    Case #BASS_ERROR_VERSION  : sError = "Ungültige Bass Version"
    Case #BASS_ERROR_CODEC    : sError = "Codec nicht verfügbar"
    Case #BASS_ERROR_ENDED    : sError = "Der Kanal ist beendet"
    Case #BASS_ERROR_UNKNOWN	: sError = "Unbekannter Fehler"
  EndSelect
  
  ProcedureReturn sError
EndProcedure

Procedure Bass_RefreshDeviceList()
  ; Refresh DeviceList
  Protected iNext.i, BDI.BASS_DEVICEINFO
  
  ClearList(DeviceList())
  While BASS_GetDeviceInfo(iNext, @BDI)
    AddElement(DeviceList())
    DeviceList()\name    = Trim(PeekS(BDI\name))
    DeviceList()\enabled = BDI\flags
    iNext + 1
  Wend
EndProcedure

Procedure Bass_InitPlugin(Plugin$)
  Log_Add("BASS_InitPlugin '" + Plugin$ + "'")
  
  If BASS_PluginLoad(Plugin$, 0)
    Log_Add("OK")
  Else
    Log_Add("Fehlgeschlagen")
  EndIf
EndProcedure

; Initialisiert BASS
Procedure Bass_InitSystem(Device, Rate)
  Protected iResult.i, iDevice.i, iRate.i
  
  If IsThread(MediaLibScan\Thread)
    MediaLibScan\Cancel = 1
    WaitThread(MediaLibScan\Thread)
  EndIf
  
  If Device < -1 : Device = -1 : EndIf
  
  Select Rate
    Case 0 : iRate = 48000
    Case 1 : iRate = 44100
    Case 2 : iRate = 22050
    Case 3 : iRate = 11025
    Case 4 : iRate =  8000
  EndSelect
  
  BASS_PluginFree(0)
  BASS_Free()
  
  iResult = BASS_Init(Device, iRate, #BASS_DEVICE_SPEAKERS, WindowID(#Win_Main), 0)
  If iResult = 0
    MsgBox_Error("Initialisierung von BASS fehlgeschlagen." + #CR$ + "BASS wird versucht mit Standardeinstellungen zu initialisieren")
    iResult = BASS_Init(-1, 44100, #BASS_DEVICE_SPEAKERS, WindowID(#Win_Main), 0)
  EndIf
  
  If iResult
    iBassVersion = BASS_GetVersion()
    
    Bass_InitPlugin("basswma.dll")
    Bass_InitPlugin("bassflac.dll")
    Bass_InitPlugin("bassmidi.dll")
    Bass_InitPlugin("basswv.dll")
    Bass_InitPlugin("bass_aac.dll")
    
    BASS_FX_GetVersion()
    
    BASS_SetConfig(#BASS_CONFIG_FLOATDSP, 1)
    BASS_SetConfig(#BASS_CONFIG_NET_PLAYLIST, 1)
    BASS_SetConfig(#BASS_CONFIG_MIDI_AUTOFONT, 2)
    BASS_SetConfig(#BASS_CONFIG_MP4_VIDEO, 1)
    BASS_SetConfig(#BASS_CONFIG_NET_PREBUF, 0)
    BASS_SetConfig(#BASS_CONFIG_NET_BUFFER, Pref\inetstream_buffer * 1000)
    BASS_SetConfig(#BASS_CONFIG_NET_TIMEOUT, Pref\inetstream_timeout * 1000)
    BASS_SetConfigPtr(#BASS_CONFIG_NET_PROXY, Pref\inetstream_proxyserver)
    
    Bass_RefreshDeviceList()
    
    Pref\bass_device = BASS_GetDevice()
    Pref\bass_rate   = Rate
    
    CurrPlay\playtype = #PlayType_Normal
    
    ProcedureReturn 1
  Else
    Pref\bass_device = -1
    MessageRequester("Fehler", "BASS konnte nicht initialisiert werden." + #CR$ + #CR$ + Bass_GetErrorString(BASS_ErrorGetCode()))
    ProcedureReturn 0
  EndIf
EndProcedure

Procedure Bass_Volume(fVolume.f = -1, PluginMSG = 1)
  ; Neue Lautstärke Ermitteln
  If fVolume = -1
    fVolume = GetGadgetState(#G_TB_Main_IA_Volume) / 100
  Else
    SetGadgetState(#G_TB_Main_IA_Volume, fVolume * 100)
  EndIf
  
  ; SlidingEffekt Entfernen
  If CurrPlay\channel[CurrPlay\curr]
    If BASS_ChannelIsSliding(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_VOL)
      BASS_ChannelSlideAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_VOL, fVolume, 0)
    EndIf
    BASS_ChannelSetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_VOL, fVolume)
  EndIf
  
  ; Plugins Nachricht senden
  If PluginMSG = 1
    ForEach PluginEXE()
      Plugin_SendValue(PluginEXE()\hWnd, #BKR_Volume, Round(fVolume * 100, #PB_Round_Up))
    Next
  EndIf
  
  ; MuteButton Icon Wechseln
  If GetGadgetState(#G_TB_Main_IA_Volume) >= 75
    Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Volume, #ImageList_Volume3)
  ElseIf GetGadgetState(#G_TB_Main_IA_Volume) >= 45
    Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Volume, #ImageList_Volume2)
  ElseIf GetGadgetState(#G_TB_Main_IA_Volume) > 0
    Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Volume, #ImageList_Volume1)
  Else
    Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Volume, #ImageList_Mute)
  EndIf
  
  ; Tooltip Setzen
  Protected sToolTip.s
  
  If GetGadgetState(#G_TB_Main_IA_Volume) < 1
    sToolTip = "Lautstärke: Lautlos"
  Else
    sToolTip = Str(GetGadgetState(#G_TB_Main_IA_Volume)) + "%"
  EndIf
  
  GadgetToolTip(#G_TB_Main_IA_Volume, sToolTip)
  
  ProcessMessage("Lautstärke: " + sToolTip, #ProcessMessage_Middle)
EndProcedure

; Ermitelt aktuellen Dateiname
Procedure.s Bass_GetCurrFileName()
  Protected sResult.s
  
  If BASS_ChannelIsActive(CurrPlay\channel[CurrPlay\curr]) <> #BASS_ACTIVE_STOPPED
    Protected CI.BASS_CHANNELINFO
    BASS_ChannelGetInfo(CurrPlay\channel[CurrPlay\curr], @CI)
    If CI\filename
      sResult = Trim(PeekS(CI\filename))
    EndIf
  EndIf
  
  ProcedureReturn sResult
EndProcedure

; Verändert die Wiedergabeposition
Procedure Bass_SetPos(Position.q = 0)
  If Position >= 0 And CurrPlay\playtype <> #PlayType_Shoutcast
    If CurrPlay\tag\length > 0
      CurrPlay\poschange = 1
      If GetAsyncKeyState_(#VK_LBUTTON) = 0 Or Position > 0
        Protected qByteLen.q, qPos.q
        
        qByteLen = BASS_ChannelGetLength(CurrPlay\channel[CurrPlay\curr], #BASS_POS_BYTE)
        qPos     = (GetGadgetState(#G_TB_Main_IA_Position) * qByteLen / #MaxPos)
        
        If Position = 0
          BASS_ChannelSetPosition(CurrPlay\channel[CurrPlay\curr], qPos, #BASS_POS_BYTE)
        Else
          BASS_ChannelSetPosition(CurrPlay\channel[CurrPlay\curr], Position, #BASS_POS_BYTE)
        EndIf
        
        CurrPlay\poschange = 0
      EndIf
    EndIf
  EndIf
EndProcedure

; Ermittelt die aktuelle Position in Byte
Procedure.q Bass_GetPos()
  If CurrPlay\channel[CurrPlay\curr]
    Protected qPos.q
    
    qPos = BASS_ChannelGetPosition(CurrPlay\channel[CurrPlay\curr], #BASS_POS_BYTE)
    ;qPos = BASS_ChannelBytes2Seconds(CurrPlay\channel[CurrPlay\curr], qPos)
  EndIf
  ProcedureReturn qPos
EndProcedure

; Verändert die Wiedergabegeschwindigkeit
Procedure Bass_SetFrequenz()
  Protected fFrequenz.f, fNewFrequenz.f
  
  If CurrPlay\channel[CurrPlay\curr] <> 0 And CurrPlay\tag\samplerate <> 0
    BASS_ChannelGetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_FREQ, @fFrequenz)
    fNewFrequenz = Pref\speed * CurrPlay\tag\samplerate / 100
    If fFrequenz <> fNewFrequenz
      BASS_ChannelSetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_FREQ, fNewFrequenz)
    EndIf
  EndIf
  
  If IsWindow(#Win_Effects)
    SetGadgetState(#G_TB_Effects_Speed, Pref\speed)
    SetGadgetText(#G_TX_Effects_SpeedV, Str(Pref\speed) + "%")
  EndIf
EndProcedure

; Verändert die Ausrichtung
Procedure Bass_SetPanel()
  Protected fPanel.f, fNewPanel.f
  
  If BASS_ChannelGetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_PAN, @fPanel)
    fNewPanel = (Pref\panel - 100) / 100
    If fPanel <> fNewPanel
      BASS_ChannelSetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_PAN, fNewPanel)
    EndIf
  EndIf
  
  If IsWindow(#Win_Effects)
    SetGadgetState(#G_TB_Effects_Panel, Pref\panel)
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
EndProcedure

; Verändert ein Eqalizer Band
Procedure Bass_SetEqualizerBand(Band)
  If Pref\equilizer
    Protected EQ.BASS_BFX_PEAKEQ, fGain.f
    
    EQ\lBand = Band
    BASS_FXGetParameters(BassEQ\iHandle, @EQ)
    EQ\fGain = ((BassEQ\iCenter[Band] / 10) - 12)
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)    
  EndIf
EndProcedure

; Verändert denn Gadgetstatus vom Equalizer
Procedure Bass_SetEqualizerPanel(BW, A, B, C, D, E, F, G, H, I, J)
  SetGadgetState(#G_TB_Effects_EqualizerBand0, A) : BassEQ\iCenter[0] = A
  SetGadgetState(#G_TB_Effects_EqualizerBand1, B) : BassEQ\iCenter[1] = B
  SetGadgetState(#G_TB_Effects_EqualizerBand2, C) : BassEQ\iCenter[2] = C
  SetGadgetState(#G_TB_Effects_EqualizerBand3, D) : BassEQ\iCenter[3] = D
  SetGadgetState(#G_TB_Effects_EqualizerBand4, E) : BassEQ\iCenter[4] = E
  SetGadgetState(#G_TB_Effects_EqualizerBand5, F) : BassEQ\iCenter[5] = F
  SetGadgetState(#G_TB_Effects_EqualizerBand6, G) : BassEQ\iCenter[6] = G
  SetGadgetState(#G_TB_Effects_EqualizerBand7, H) : BassEQ\iCenter[7] = H
  SetGadgetState(#G_TB_Effects_EqualizerBand8, I) : BassEQ\iCenter[8] = I
  SetGadgetState(#G_TB_Effects_EqualizerBand9, J) : BassEQ\iCenter[9] = J
  
  Protected iNext
  For iNext = 0 To 9
    Bass_SetEqualizerBand(iNext)
  Next
  
EndProcedure

; Setzt ein vordefiniertes Equalizerpreset
Procedure Bass_SetEqualizerPreset(Preset)
  Select Preset
    Case 0  : Bass_SetEqualizerPanel(120, 120,120,120,120,120,120,120,120,120,120) ;standard
    Case 1  : Bass_SetEqualizerPanel(-1, 120,120,120,120,120,120,72,72,72,57)      ;classic
    Case 2  : Bass_SetEqualizerPanel(-1, 120,120,145,156,156,156,145,120,120,120)  ;club
    Case 3  : Bass_SetEqualizerPanel(-1, 179,164,137,120,120,84,72,72,120,120)     ;dance
    Case 4  : Bass_SetEqualizerPanel(-1, 120,120,120,120,120,120,120,120,120,120)  ;Flat
    Case 5  : Bass_SetEqualizerPanel(-1, 179,179,179,156,120,91,65,53,50,50)       ;fullbass
    Case 6  : Bass_SetEqualizerPanel(-1, 168,156,120,72,88,120,171,187,194,194)    ;basstreb
    Case 7  : Bass_SetEqualizerPanel(-1, 57,57,57,91,137,187,217,217,217,217)      ;fulltreb
    Case 8  : Bass_SetEqualizerPanel(-1, 149,187,152,103,103,130,159,179,198,210)  ;laptop
    Case 9  : Bass_SetEqualizerPanel(-1, 187,187,156,156,120,88,88,88,120,120)     ;LargeHall
    Case 10 : Bass_SetEqualizerPanel(-1, 88,120,145,152,156,156,145,137,137,133)   ;live
    Case 11 : Bass_SetEqualizerPanel(-1, 164,164,120,120,120,120,120,120,164,164)  ;party
    Case 12 : Bass_SetEqualizerPanel(-1, 107,149,164,168,152,110,103,103,107,107)  ;pop
    Case 13 : Bass_SetEqualizerPanel(-1, 120,120,114,84,120,164,164,120,120,120)   ;reggae
    Case 14 : Bass_SetEqualizerPanel(-1, 168,149,84,69,95,145,175,187,187,187)     ;rock
    Case 15 : Bass_SetEqualizerPanel(-1, 193,88,91,114,145,156,175,179,187,179)    ;ska
    Case 16 : Bass_SetEqualizerPanel(-1, 149,130,110,103,110,145,171,179,187,194)  ;soft
    Case 17 : Bass_SetEqualizerPanel(-1, 145,145,133,114,91,84,95,114,137,175)     ;softrock
    Case 18 : Bass_SetEqualizerPanel(-1, 168,156,120,84,88,120,168,179,179,175)    ;techno
  EndSelect
EndProcedure

; Fügt denn Equalizereffekt zum Channel hinzu und setzt aktuelle Werte
Procedure Bass_SetEqualizer()
  If Pref\equilizer
    ; Add Equilizer Effect
    BassEQ\iHandle = BASS_ChannelSetFX(CurrPlay\channel[currplay\curr], #BASS_FX_BFX_PEAKEQ, 1)
    ; Add Bands
    Protected EQ.BASS_BFX_PEAKEQ, iNext.i
    
    EQ\fBandwidth = 2.5
    EQ\fQ         = 0
    EQ\fGain      = 0
    EQ\lChannel   = #BASS_BFX_CHANALL
    
    EQ\lBand      = 0
    EQ\fCenter    = 31
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 1
    EQ\fCenter    = 63
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 2
    EQ\fCenter    = 125
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 3
    EQ\fCenter    = 250
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 4
    EQ\fCenter    = 500
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 5
    EQ\fCenter    = 1000
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 6
    EQ\fCenter    = 2000
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 7
    EQ\fCenter    = 4000
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 8
    EQ\fCenter    = 8000
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    EQ\lBand      = 9
    EQ\fCenter    = 16000
    BASS_FXSetParameters(BassEQ\iHandle, @EQ)
    ; Set Band Values
    For iNext = 0 To 9
      Bass_SetEqualizerBand(iNext)
    Next
  Else
    ; Remove Equilizer
    BASS_ChannelRemoveFX(CurrPlay\channel[currplay\curr], BassEQ\iHandle)
  EndIf
EndProcedure

Procedure Bass_SetReverbParameters()
  If Effects\iReverb
    Protected R.BASS_DX8_REVERB
    
    R\fInGain          = 0
    R\fReverbMix       = Effects\fReverbMix
    R\fReverbTime      = Effects\fReverbTime
    R\fHighFreqRTRatio = 0.001
    
    BASS_FXSetParameters(Effects\iReverb, @R)
  EndIf
  
  If IsWindow(#Win_Effects)
    If 96 + Effects\fReverbMix <> GetGadgetState(#G_TB_Effects_ReverbMix)
      SetGadgetState(#G_TB_Effects_ReverbMix, 96 + Effects\fReverbMix)
    EndIf
    If Str(((Effects\fReverbMix + 96) * 100) / 96) <> GetGadgetText(#G_TX_Effects_ReverbMixV)
      SetGadgetText(#G_TX_Effects_ReverbMixV, Str(((Effects\fReverbMix + 96) * 100) / 96))
    EndIf
    If (Effects\fReverbTime * 100) / 3000 <> GetGadgetState(#G_TB_Effects_ReverbTime)
      SetGadgetState(#G_TB_Effects_ReverbTime, (Effects\fReverbTime * 100) / 3000)
    EndIf
    If GetGadgetText(#G_TX_Effects_ReverbTimeV) <> Str((Effects\fReverbTime * 100) / 3000)
      SetGadgetText(#G_TX_Effects_ReverbTimeV, Str((Effects\fReverbTime * 100) / 3000))
    EndIf
  EndIf
EndProcedure

Procedure Bass_SetReverb()
  If Effects\bReverb
    Effects\iReverb = BASS_ChannelSetFX(CurrPlay\channel[currplay\curr], #BASS_FX_DX8_REVERB, 2)
    Bass_SetReverbParameters()
  Else
    If Effects\iReverb
      BASS_ChannelRemoveFX(CurrPlay\channel[currplay\curr], Effects\iReverb)
      Effects\iReverb = 0
    EndIf
  EndIf
  
  If IsWindow(#Win_Effects)
    If Effects\bReverb <> GetGadgetState(#G_CH_Effects_Reverb)
      SetGadgetState(#G_CH_Effects_Reverb, Effects\bReverb)
    EndIf
  EndIf
EndProcedure

Procedure Bass_SetEchoParameters()
  If Effects\bEcho
    Protected E.BASS_DX8_ECHO
    
    E\fWetDryMix   = 50
    E\fFeedback    = Effects\bEchoBack
    E\fLeftDelay   = Effects\iEchoDelay
    E\fRightDelay  = Effects\iEchoDelay
    E\lPanDelay    = 0
    
    BASS_FXSetParameters(Effects\iEcho, @E)
  EndIf
  
  If IsWindow(#Win_Effects)
    If Effects\bEchoBack <> GetGadgetState(#G_TB_Effects_EchoBack)
      SetGadgetState(#G_TB_Effects_EchoBack, Effects\bEchoBack)
    EndIf
    If Str(Effects\bEchoBack) <> GetGadgetText(#G_TX_Effects_EchoBackV)
      SetGadgetText(#G_TX_Effects_EchoBackV, Str(Effects\bEchoBack))
    EndIf
    If Effects\iEchoDelay <> GetGadgetState(#G_TB_Effects_EchoDelay)
      SetGadgetState(#G_TB_Effects_EchoDelay, Effects\iEchoDelay)
    EndIf
    If (Effects\iEchoDelay * 2000) / 100 <> GetGadgetState(#G_TB_Effects_EchoDelay)
      SetGadgetText(#G_TX_Effects_EchoDelayV, Str(Effects\iEchoDelay * 100 / 2000))
    EndIf
  EndIf
EndProcedure

Procedure Bass_SetEcho()
  ; Echo
  If Effects\bEcho
    Protected E.BASS_DX8_ECHO
    
    Effects\iEcho = BASS_ChannelSetFX(CurrPlay\channel[currplay\curr], #BASS_FX_DX8_ECHO, 2)
    
    Bass_SetEchoParameters()
  Else
    If Effects\iEcho
      BASS_ChannelRemoveFX(CurrPlay\channel[currplay\curr], Effects\iEcho)
      Effects\iEcho = 0
    EndIf
  EndIf
  
  If IsWindow(#Win_Effects)
    If Effects\bEcho <> GetGadgetState(#G_CH_Effects_Echo)
      SetGadgetState(#G_CH_Effects_Echo, Effects\bEcho)
    EndIf
  EndIf
EndProcedure

Procedure Bass_SetFlanger()
  ; Flanger
  If Effects\bFlanger
    Protected F.BASS_DX8_FLANGER
    
    Effects\iFlanger = BASS_ChannelSetFX(CurrPlay\channel[currplay\curr], #BASS_FX_DX8_FLANGER, 2)
    
    F\fWetDryMix = 50
    F\fDepth     = 100
    F\fFeedback  = -50
    F\fFrequency = 0.25
    F\lWaveform  = 1
    F\fDelay     = 2
    F\lPhase     = #BASS_DX8_PHASE_ZERO
    
    BASS_FXSetParameters(Effects\iFlanger, @F)
  Else
    If Effects\iFlanger
      BASS_ChannelRemoveFX(CurrPlay\channel[currplay\curr], Effects\iFlanger)
      Effects\iFlanger = 0
    EndIf
  EndIf
  
  If IsWindow(#Win_Effects)
    If Effects\bFlanger <> GetGadgetState(#G_CH_Effects_Flanger)
      SetGadgetState(#G_CH_Effects_Flanger, Effects\bFlanger)
    EndIf
  EndIf
EndProcedure

; Channel wurde beendet
Procedure Bass_SyncEnd(handle, channel, datas, *user)
  Log_Add("Kanal Beendet '" + Str(channel) + "'")
  
  ; Statics
  Statistics\play_end + 1
  
  iChannelStop = 1
EndProcedure

; Radio Tags auslesen
Procedure Bass_SyncMeta(Handle, Channel, Datas, User)
  Protected *Pointer
  Protected iCount.i
  Protected sTag.s
  
  *Pointer = BASS_ChannelGetTags(Channel, #BASS_TAG_META)
  If *Pointer
    sTag + Trim(PeekS(*Pointer))
    If sTag
      
      ; Interpret/Title
      If LCase(Left(sTag, 12)) = "streamtitle="
        
        sTag = Mid(sTag, 13)
        sTag = StringField(sTag, 1, ";")
        
        If Left(sTag, 1) = "'"
          sTag = Right(sTag, Len(sTag) - 1)
        EndIf
        If Right(sTag, 1) = "'"
          sTag = Left(sTag, Len(sTag) - 1)
        EndIf
        
        CurrPlay\tag\artist = Trim(StringField(sTag, 1, "-"))
        CurrPlay\tag\album  = Trim(StringField(sTag, 2, "-"))
        
        If Trim(CurrPlay\tag\artist) <> "" And Trim(CurrPlay\tag\album) <> ""
          AddElement(RadioTrackLog())
          RadioTrackLog()\title  = CurrPlay\tag\album
          RadioTrackLog()\artist = CurrPlay\tag\artist
          
          If IsWindow(#Win_RadioLog)
            AddGadgetItem(#G_LI_RadioLog_Overview, -1, RadioTrackLog()\artist + Chr(10) + RadioTrackLog()\title)
          EndIf
        EndIf
        
      EndIf
    
    EndIf
  EndIf
EndProcedure

Procedure Bass_SyncPos(Handle, Channel, Datas, *user)
  If GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Preview)
    If CurrPlay\playtype = #PlayType_PlayList
      Bass_FadeOut()
    EndIf
  EndIf
EndProcedure

Procedure Bass_SyncMidiLyrics(Handle, Channel, Datas, *user)
  Protected M.BASS_MIDI_MARK, sText.s
  
  If ListSize(MidiLyrics()) >= Datas And IsGadget(#G_ED_MidiLyrics_Text)
    SelectElement(MidiLyrics(), Datas)
    
    If MidiLyrics()\spos > -1
      SendMessage_(GadgetID(#G_ED_MidiLyrics_Text), #EM_SETSEL, MidiLyrics()\spos, MidiLyrics()\epos)
    EndIf
  EndIf
  
  ProcedureReturn 1
EndProcedure

Procedure Bass_SyncDownload(Buffer, Length, User)
  
  ; Refresh Download Amount
  If Length > 0
    InternetStream\downloaded + Length
    Statistics\radio_traffic + Length
    If IsWindow(#Win_RadioLog)
      SetGadgetText(#G_TX_RadioLog_DownloadedV, FormatByteSize(InternetStream\downloaded))
    EndIf
  EndIf
  
  ; Save InternetStream
  If Pref\inetstream_savefile = 1 And FileSize(Pref\inetstream_savepath) = -2 And Buffer <> 0 And Length > 0
    Protected iFile.i, sName.s
    
    ; Generate Name
    Select Pref\inetstream_savename
      Case 0 ;Interpret/Titel
        If Trim(CurrPlay\tag\artist) = ""
          sName + "Unbekannter Artist"
        Else
          sName + CurrPlay\tag\artist
        EndIf
        sName + " - "
        If Trim(CurrPlay\tag\album) = ""
          sName + "Unbekannter Titel"
        Else
          sName + CurrPlay\tag\album
        EndIf
      Case 1 ;Radioname
        sName = CurrPlay\tag\title
        If sName = ""
          sName = "Unbekannter Sender"
        EndIf
    EndSelect
    sName = FormatDate("[%mm.%dd.%yy] ", Date()) + sName
    
    ; Write Data
    iFile = OpenFile(#PB_Any, Pref\inetstream_savepath + sName + ".mp3")
    If iFile
      FileSeek(iFile, Lof(iFile))
      WriteData(iFile, Buffer, Length)
      CloseFile(iFile)
    EndIf
    
  EndIf
  
EndProcedure

Procedure Bass_FadeIn()
  Protected fVolume.f
  
  fVolume = GetGadgetState(#G_TB_Main_IA_Volume) / 100
  BASS_ChannelSlideAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_VOL, fVolume, Pref\bass_fadein * 1000)
EndProcedure

Procedure Bass_FadeOut(Wait = 0)
  Protected fVolume.f
  Protected iTimeOut.i
  
  If iEndApplication = 1
    iTimeOut = Pref\bass_fadeoutend
    If iTimeOut > 0 : Wait = 1 : EndIf
  Else
    iTimeOut = Pref\bass_fadeout
  EndIf
  
  If iTimeOut > 0
    BASS_ChannelSlideAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_VOL, 0, iTimeOut * 1000)
  Else
    BASS_ChannelSetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_VOL, 0)
  EndIf
  
  CurrPlay\flags[CurrPlay\curr] = #ChannelFlag_Stop
  
  If Wait > 0 And iTimeOut > 0
    Repeat
      BASS_ChannelGetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_VOL, @fVolume)
      Delay(100)
    Until fVolume <= 0
  EndIf  
EndProcedure

Procedure Bass_ReadMidiLyrics(Channel)
  Protected M.BASS_MIDI_MARK
  Protected iResult.i, iIndex.i, sRead.s
  Protected iLen.i
  
  ClearList(MidiLyrics())
  
  Repeat
    iResult = BASS_MIDI_StreamGetMark(Channel, #BASS_MIDI_MARK_LYRIC, iIndex, @M)    
    If iResult <> 0
        
      sRead = PeekS(M\text)
      If Left(sRead, 1) <> ""
        AddElement(MidiLyrics())
        MidiLyrics()\text = sRead
        
        If Left(sRead, 1) = "/"
          MidiLyrics()\spos = -1
          iLen + Len(#CR$)
        Else
          If Left(sRead, 1) <> "\" And Left(sRead, 1) <> "@"
            MidiLyrics()\spos = iLen
            MidiLyrics()\epos = iLen + Len(sRead) - 1
            iLen + Len(sRead)
          Else
            MidiLyrics()\spos = -1
          EndIf
        EndIf
        
      EndIf
    EndIf
    
    iIndex + 1
  Until iResult = 0
  
  If ListSize(MidiLyrics()) > 0
    OpenWindow_MidiLyrics()
  EndIf
  
EndProcedure

Procedure Bass_PlayInternetStream(IncrasePlayCounter)
  Protected iNewChannel.i
  
  SetGadgetText(#G_TX_Main_IA_InfoCont1, "Verbinde..")
  
  iNewChannel = BASS_StreamCreateURL(@InternetStream\adress, 0, #BASS_STREAM_AUTOFREE|#BASS_STREAM_BLOCK|#BASS_STREAM_STATUS, @Bass_SyncDownload(), 0)
  If iNewChannel <> 0
    
    If BASS_ChannelPlay(iNewChannel, 1)
      Log_Add("Internetstream '" + Bass_GetErrorString(BASS_ErrorGetCode()) + "'")
      
      ; Remove PlayList Select
      If CountGadgetItems(#G_LI_Main_PL_PlayList) -1 >= CurrPlay\plindex And CurrPlay\plindex > -1
        SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_BackColor, -1)
        SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_FrontColor, -1)
      EndIf
      
      ; Reset RadioLog
      InternetStream\downloaded = 0
      ClearList(RadioTrackLog())
      
      If IsWindow(#Win_RadioLog)
        SetGadgetText(#G_TX_RadioLog_DownloadedV, "")
        ClearGadgetItems(#G_LI_RadioLog_Overview)
      EndIf
      
      ; Mute
      BASS_ChannelSetAttribute(iNewChannel, #BASS_ATTRIB_VOL, 0)
      
      ; Set Callbacks
      BASS_ChannelSetSync(iNewChannel, #BASS_SYNC_FREE,  #BASS_SYNC_MIXTIME, @Bass_SyncEnd(),   0)
      BASS_ChannelSetSync(iNewChannel, #BASS_SYNC_META,  #BASS_SYNC_MIXTIME, @Bass_SyncMeta(),  0)
      
      ; FadeOut Old Stream
      Bass_FadeOut()
      
      ; Change Current Channel
      CurrPlay\curr!1
      
      ; Stop Old Channel (Falls ein Channel nicht von selbst entfernt wurde!)
      BASS_ChannelStop(CurrPlay\channel[CurrPlay\curr])
      
      ; Get ChannelHandle
      InternetStream\Stream = iNewChannel
      CurrPlay\channel[CurrPlay\curr] = iNewChannel
      
      ; Refresh SampleRate
      BASS_ChannelGetAttribute(CurrPlay\channel[CurrPlay\curr], #BASS_ATTRIB_FREQ, @CurrPlay\tag\samplerate)
      
      ; Reset Attribute
      Bass_SetEqualizer()
      Bass_SetFrequenz()
      Bass_SetPanel()
      Bass_SetReverb()
      Bass_SetEcho()
      Bass_SetFlanger()
      
      ; Play..
      Bass_FadeIn()
      
      Statistics\play_start + 1
      
      CurrPlay\flags[CurrPlay\curr] = 0
      CurrPlay\file                 = InternetStream\adress
      CurrPlay\pos                  = 0
      CurrPlay\tag\length           = 0
      CurrPlay\playtype             = #PlayType_Shoutcast
      CurrPlay\fingerprint          = ""
      
      CurrPlay\description[0] = "Name:"
      CurrPlay\description[1] = "Artist:"
      CurrPlay\description[2] = "Album:"
      CurrPlay\description[3] = "Genre:"
      CurrPlay\description[4] = "Länge:"
      
      CurrPlay\tag\title      = ""
      CurrPlay\tag\artist     = ""
      CurrPlay\tag\album      = ""
      CurrPlay\tag\year       = 0
      CurrPlay\tag\comment    = ""
      CurrPlay\tag\track      = 0
      CurrPlay\tag\genre      = ""
      CurrPlay\tag\bitrate    = 0
      CurrPlay\tag\channels   = 0
      
      DisableToolBarButton(#Toolbar_Main1, #Mnu_Main_TB1_Record, 0)
      
      ; ReadTags..
      Protected sTag.s, iCount.i, *Pointer
      Protected NewList InetTag.s()
      
      *Pointer = BASS_ChannelGetTags(iNewChannel, #BASS_TAG_ICY)
      If *Pointer : sTag + PeekStringDoubleNull(*Pointer) : EndIf
      If sTag : sTag + "|" : EndIf
      *Pointer = BASS_ChannelGetTags(iNewChannel, #BASS_TAG_META)
      If *Pointer : sTag + PeekS(*Pointer) : EndIf
      
      If sTag
        iCount = CountString(sTag, "|") + 1
        For iNext = 1 To iCount
          AddElement(InetTag())
          InetTag() = Trim(StringField(sTag, iNext, "|"))
        Next
      EndIf
      
      ForEach InetTag()
        sTag = InetTag()
        If sTag <> ""
          ;Name
          If LCase(Left(sTag, 9)) = "icy-name:"
            CurrPlay\tag\title = Trim(Right(sTag, Len(sTag) - 9))
          EndIf
          ;Genre
          If LCase(Left(sTag, 10)) = "icy-genre:"
            CurrPlay\tag\genre = Trim(Right(sTag, Len(sTag) - 10))
          EndIf
          ;Interpret/Title
          If LCase(Left(sTag, 12)) = "streamtitle="
            sTag = Mid(sTag, 13)
            sTag = StringField(sTag, 1, ";")
            If Left(sTag, 1) = "'" : sTag = Right(sTag, Len(sTag) - 1) : EndIf
            If Right(sTag, 1) = "'" : sTag = Left(sTag, Len(sTag) - 1) : EndIf
            CurrPlay\tag\artist = Trim(StringField(sTag, 1, "-"))
            CurrPlay\tag\album  = Trim(StringField(sTag, 2, "-"))
          EndIf
        EndIf
      Next
      
      If CurrPlay\tag\title = ""
        CurrPlay\tag\title = CurrPlay\file
      EndIf
      
      ; Change WindowsLiveMessanger Status Text
      If Pref\misc_changemsn
        ChangeMSNStatus(1, "Music", CurrPlay\tag\title)
      EndIf
      
      Plugin_SendCurrPlay()
      
      ; Refresh MediaLibary Infos
      LockMutex(MediaLibScan\Mutex)
        ForEach MediaLibary()
          If LCase(MediaLibary()\tag\file)  = LCase(InternetStream\adress)
            
            If MediaLibary()\firstplay = 0
              MediaLibary()\firstplay = Date()
            EndIf
            MediaLibary()\lastplay = Date()
            
            If IncrasePlayCounter
              MediaLibary()\playcount + 1
            EndIf
            
            MediaLibary()\tag\title = CurrPlay\tag\title
            MediaLibary()\tag\genre = CurrPlay\tag\genre
          EndIf
        Next
      UnlockMutex(MediaLibScan\Mutex)
      
    Else
      Log_Add("Internetstream '" + Bass_GetErrorString(BASS_ErrorGetCode()) + "'", #Log_Error)
    EndIf
  Else
    Log_Add("Internetstream '" + Bass_GetErrorString(BASS_ErrorGetCode()) + "'", #Log_Error)
  EndIf
EndProcedure

Procedure Bass_PlayMedia(File$, PlayType, IncrasePlayCounter = 1)
  Protected iFoundInDB.i
  Protected iNewChannel.i, qLength.q
  
  ; InternetStream
  If UCase(Left(File$, 7)) = "HTTP://" Or UCase(Left(File$, 6)) = "FTP://"
    If IsThread(InternetStream\connect_thread) = 0
      InternetStream\adress = File$
      InternetStream\connect_thread = CreateThread(@Bass_PlayInternetStream(), IncrasePlayCounter)
    EndIf
    ProcedureReturn 0
    
  ; Lokale Datei
  Else
    ; Normal
    iNewChannel = BASS_StreamCreateFile(0, @File$, 0, 0, #BASS_STREAM_AUTOFREE|#BASS_STREAM_PRESCAN)
    ; Music
    If iNewChannel = 0
      iNewChannel = BASS_MusicLoad(0, @File$, 0, 0, #BASS_MUSIC_AUTOFREE|#BASS_MUSIC_PRESCAN, 0)
    EndIf
    
    ; Channel konnte erfolgreich erstellt werden
    If iNewChannel
      Protected CI.BASS_CHANNELINFO
      
      ; Channelinformationen abrufen
      BASS_ChannelGetInfo(iNewChannel, @CI)
      
      ; Es handelt sich um eine Midi
      If CI\cType = #BASS_CTYPE_STREAM_MIDI
        ; Soundfont Öffnen
        If FileSize(Pref\bass_midisf2) > 0
          Protected iSoundFont.i
          Protected Dim SF.BASS_MIDI_FONT(0)
          
          iSoundFont = BASS_MIDI_FontInit(@Pref\bass_midisf2, 0)
          
          BASS_MIDI_FontLoad(iSoundFont, -1, -1)
          
          SF(0)\font   = iSoundFont
          SF(0)\preset = -1
          SF(0)\bank   = 0
          
          BASS_MIDI_StreamSetFonts(iNewChannel, @SF(), 1)
          BASS_MIDI_StreamLoadSamples(iNewChannel)
        EndIf
        ; Lyrics Öffnen
        If Pref\bass_midilyrics = 1
          Protected M.BASS_MIDI_MARK
          
          If BASS_MIDI_StreamGetMark(iNewChannel, #BASS_MIDI_MARK_LYRIC, 0, @M) <> 0
            BASS_ChannelSetSync(iNewChannel, #BASS_SYNC_MIDI_LYRIC, 0, @Bass_SyncMidiLyrics(), 0)
            Bass_ReadMidiLyrics(iNewChannel)
          EndIf
        EndIf
      EndIf ; Midi
      
      ; Wiedergabe Starten
      If BASS_ChannelPlay(iNewChannel, 1)
        
        ; Markierung in Wiedergabeliste entfernen
        If CurrPlay\plindex > -1 And CountGadgetItems(#G_LI_Main_PL_PlayList) -1 >= CurrPlay\plindex
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_BackColor, -1)
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_FrontColor, -1)
        EndIf
        
        ; Lautlos
        BASS_ChannelSetAttribute(iNewChannel, #BASS_ATTRIB_VOL, 0)
        
        ; Callbacks Erstellen
        BASS_ChannelSetSync(iNewChannel, #BASS_SYNC_FREE, #BASS_SYNC_MIXTIME, @Bass_SyncEnd(), 0)
        
        ; Vorschau-Modus
        If GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Preview)
          Protected qPreviewPos.q
          
          qPreviewPos = (Pref\bass_preview * BASS_ChannelGetLength(iNewChannel, #BASS_POS_BYTE)) / 100
          
          BASS_ChannelSetSync(iNewChannel, #BASS_SYNC_POS, qPreviewPos, @Bass_SyncPos(), 0)
        EndIf
        
        ; FadeOut des alten Streams
        Bass_FadeOut()
        
        ; Aktuellen Stream Wechseln
        CurrPlay\curr = 1 - CurrPlay\curr
        
        ; Anhalten des alten Channels, falls dieser nicht automatisch entfernt wurde
        ; Könnte auftretten wenn im FadeOut bereits eine erneute Wiedergabe gestartet wird
        BASS_ChannelStop(CurrPlay\channel[CurrPlay\curr])
        
        ; ChannelHandle Speichern
        CurrPlay\channel[CurrPlay\curr] = iNewChannel
        
        ; SampleRate Aktualisieren
        BASS_ChannelGetAttribute(iNewChannel, #BASS_ATTRIB_FREQ, @CurrPlay\tag\samplerate)
        
        ; Alle Effekte und Wiedergabeeinstellungen Setzen
        Bass_SetEqualizer()
        Bass_SetFrequenz()
        Bass_SetPanel()
        Bass_SetReverb()
        Bass_SetEcho()
        Bass_SetFlanger()
        
        ; Wiedergabe-Tage erhöhen
        If FormatDate("%dd%mm%yyyy", Pref\misc_laststart) <> FormatDate("%dd%mm%yyyy", Date())
          Statistics\play_days + 1
          Pref\misc_laststart = Date()
        EndIf
        
        ; Wiedergabestart
        Log_Add("Kanal Wiedergabe '" + Str(iNewChannel) + "'")
        
        Bass_FadeIn()
        
        ; Länge Ermitteln
        qLength = BASS_ChannelBytes2Seconds(iNewChannel, BASS_ChannelGetLength(iNewChannel, #BASS_POS_BYTE))
        
        ; Wiedergabeanzahl Statistik erhöhen
        Statistics\play_start + 1
        
        ; Aktuelle Wiedergabedaten speichern
        CurrPlay\file                      = File$
        CurrPlay\fingerprint               = MD5FileFingerprint(File$)
        CurrPlay\pos                       = 0
        CurrPlay\tag\length                = qLength
        CurrPlay\playtype                  = PlayType
        CurrPlay\flags[CurrPlay\curr]      = 0
        CurrPlay\tag\cType                 = CI\cType
        
        CurrPlay\description[0] = "Titel:"
        CurrPlay\description[1] = "Artist:"
        CurrPlay\description[2] = "Album:"
        CurrPlay\description[3] = "Genre:"
        CurrPlay\description[4] = "Länge:"
        
        ; Tags Ermitteln
        Protected Tag._Tag
        
        Tag\file = CurrPlay\file
        
        MetaData_ReadData(Tag)
        
        CurrPlay\tag\title  = Tag\title
        CurrPlay\tag\artist = Tag\artist
        CurrPlay\tag\album  = Tag\album
        CurrPlay\tag\genre  = Tag\genre
        
        ; Radio-Aufnahme bei Lokaler Datei nicht möglich
        DisableToolBarButton(#Toolbar_Main1, #Mnu_Main_TB1_Record, 1)
        
        ; Position Zurücksetzen
        SetGadgetState(#G_TB_Main_IA_Position, 0)
        If qLength > 0
          DisableGadget(#G_TB_Main_IA_Position, 0)
        Else
          DisableGadget(#G_TB_Main_IA_Position, 1)
        EndIf
        
        ; Aktualisierung der Medienbibliothekinfos
        LockMutex(MediaLibScan\Mutex)
        ForEach MediaLibary()
          If LCase(MediaLibary()\tag\file) = LCase(File$)
            If MediaLibary()\firstplay = 0
              MediaLibary()\firstplay = Date()
            EndIf
            MediaLibary()\lastplay = Date()
            If IncrasePlayCounter
              MediaLibary()\playcount + 1
            EndIf
            MediaLibary()\tag\title    = Tag\title
            MediaLibary()\tag\artist   = Tag\artist
            MediaLibary()\tag\album    = Tag\album
            MediaLibary()\tag\year     = Tag\year
            MediaLibary()\tag\comment  = Tag\comment
            MediaLibary()\tag\track    = Tag\track
            MediaLibary()\tag\genre    = Tag\genre
            MediaLibary()\tag\bitrate  = Tag\bitrate
            MediaLibary()\tag\channels = Tag\channels
            
            iFoundInDB = 1
          EndIf
        Next
        UnlockMutex(MediaLibScan\Mutex)
        
        ; Titel zur Medienbibliothek hinzufügen
        If iFoundInDB = 0 And Pref\medialib_addplayfiles
          LockMutex(MediaLibScan\MutexRF)
          
          ForEach MediaLib_Path()
            If UCase(MediaLib_Path()) = Left(UCase(GetPathPart(File$)), Len(MediaLib_Path()))
              iFoundInDB = 1
              Break
            EndIf
          Next
          
          If iFoundInDB
            MediaLib_AddFile(File$, IncrasePlayCounter)
          EndIf
          
          UnlockMutex(MediaLibScan\MutexRF)
        EndIf
        
        ; Infos in Zwischenablage Speichern
        ChangeClipboardText(@CurrPlay)
        
        ; Plugins Informieren
        Plugin_SendCurrPlay()
        
        ; Windows Live Messanger Statustext Setzen
        If Pref\misc_changemsn
          Protected sText.s
          
          sText = CurrPlay\tag\title
          If Trim(CurrPlay\tag\artist) <> ""
            sText = CurrPlay\tag\artist + " - " + sText
          EndIf
          
          If sText
            ChangeMSNStatus(1, "Music", sText)
          EndIf
        EndIf
        
        ; Tracker Anzeigen
        If Pref\tracker_enable = #True And iStartApplication = #False
          OpenWindow_Tracker()
        EndIf
        
        ProcedureReturn 1
      Else
        ; Wiedergabe Fehlgeschlagen
        ; Channel Kann Entfernt werden
        BASS_ChannelStop(CurrPlay\channel[CurrPlay\curr])
      EndIf
      
    Else
      Log_Add("Wiedergabe fehlgeschlagen '" + Bass_GetErrorString(BASS_ErrorGetCode()) + "'", #Log_Error)
    EndIf ; Channel
    
  EndIf ; Lokale Datei
EndProcedure

Procedure Bass_PauseMedia()
  Select BASS_ChannelIsActive(CurrPlay\channel[currplay\curr])
    Case #BASS_ACTIVE_PAUSED
      BASS_ChannelPlay(CurrPlay\channel[currplay\curr], 0)
      SetToolBarButtonState(#Toolbar_Main1, #Mnu_Main_TB1_Pause, 0)
    Case #BASS_ACTIVE_PLAYING
      BASS_ChannelPause(CurrPlay\channel[currplay\curr])
      SetToolBarButtonState(#Toolbar_Main1, #Mnu_Main_TB1_Pause, 1)
  EndSelect
EndProcedure

; Aktualisiert den Spektrumanalyser (Image!)
Procedure Bass_RefreshSpectrum()
  If Pref\spectrum = #Spectrum_None
    If GetGadgetState(#G_IG_Main_IA_Spectrum)
      SetGadgetState(#G_IG_Main_IA_Spectrum, 0)
      ResizeGadget(#G_IG_Main_IA_Spectrum, #PB_Ignore, #PB_Ignore, 0, 0)
    EndIf
  Else
    Static iSpectrum.i, iTime.i, iChannel.i, iLChannel.i, iRChannel.i, fLChannel.f, fRChannel.f
    Protected Dim FFT.f(127)
    Protected CI.BASS_CHANNELINFO
    Protected iNext.i, iNext2.i, fMaxValue.f, fHeight.f
    
    If timeGetTime_() - iTime >= 50
      
      If IsImage(iSpectrum) = 0
        iSpectrum = CreateImage(#PB_Any, 128, 50, 24)
      EndIf
      
      If IsImage(iSpectrum)
        
        Select Pref\spectrum
          
          Case #Spectrum_Linear
            ;Receive Data
            BASS_ChannelGetData(CurrPlay\channel[CurrPlay\curr], FFT(), #BASS_DATA_FFT256)
            
            ;Normalize
            For iNext = 0 To 127
              If FFT(iNext) > fMaxValue
                fMaxValue = FFT(iNext)
              EndIf
            Next
            
            For iNext = 0 To 127
              FFT(iNext) = FFT(iNext) / fMaxValue
              FFT(iNext) = Sqr(FFT(iNext))
            Next
            
            ;Draw
            If StartDrawing(ImageOutput(iSpectrum))
              Box(0, 0, 128, 50, Pref\color[#Color_TrackInfo_BG])
              
              For iNext = 0 To 64
                If iNext % 4 = 0 And iNext < 61
                  For iNext2 = 0 To 4
                    fHeight = FFT(iNext + iNext2) * 50
                  Next iNext2
                  If fHeight < 1
                    fHeight = 1
                  EndIf
                  Box(iNext * 2, 50 - fHeight, 7, fHeight, Pref\color[#Color_Spectrum_FG])
                EndIf
              Next
              
              StopDrawing()
            EndIf
          
          Case #Spectrum_Waveform
            ;Receive Channel Amplitude
            iChannel = BASS_ChannelGetLevel(CurrPlay\channel[CurrPlay\curr])
            iLChannel = LOWORD(iChannel)
            iRChannel = HIWORD(iChannel)
            
            If StartDrawing(ImageOutput(iSpectrum))
              Box(0, 0, 128, 50, Pref\color[#Color_TrackInfo_BG])
              
              ;Left
              If iLChannel >= 3640
                Box(63, 22, 1, 4, ColorBright(Pref\color[#Color_Spectrum_FG], -160))
              Else
                Box(63, 22, 1, 4, ColorBright(Pref\color[#Color_Spectrum_BG], 30))
              EndIf
              If iLChannel >= 7280
                Box(60, 21, 2, 6, ColorBright(Pref\color[#Color_Spectrum_FG], -140))
              Else
                Box(60, 21, 2, 6, ColorBright(Pref\color[#Color_Spectrum_BG], 35))
              EndIf
              If iLChannel >= 10920
                Box(56, 20, 3, 8, ColorBright(Pref\color[#Color_Spectrum_FG], -120))
              Else
                Box(56, 20, 3, 8, ColorBright(Pref\color[#Color_Spectrum_BG], 40))
              EndIf
              If iLChannel >= 14560
                Box(51, 19, 4, 10, ColorBright(Pref\color[#Color_Spectrum_FG], -100))
              Else
                Box(51, 19, 4, 10, ColorBright(Pref\color[#Color_Spectrum_BG], 45))
              EndIf
              If iLChannel >= 18200
                Box(45, 18, 5, 12, ColorBright(Pref\color[#Color_Spectrum_FG], -80))
              Else
                Box(45, 18, 5, 12, ColorBright(Pref\color[#Color_Spectrum_BG], 50))
              EndIf
              If iLChannel >= 21840
                Box(38, 17, 6, 14, ColorBright(Pref\color[#Color_Spectrum_FG], -60))
              Else
                Box(38, 17, 6, 14, ColorBright(Pref\color[#Color_Spectrum_BG], 55))
              EndIf
              If iLChannel >= 25480
                Box(30, 16, 7, 16, ColorBright(Pref\color[#Color_Spectrum_FG], -40))
              Else
                Box(30, 16, 7, 16, ColorBright(Pref\color[#Color_Spectrum_BG], 60))
              EndIf
              If iLChannel >= 29120
                Box(21, 15, 8, 18, ColorBright(Pref\color[#Color_Spectrum_FG], -20))
              Else
                Box(21, 15, 8, 18, ColorBright(Pref\color[#Color_Spectrum_BG], 65))
              EndIf
              If iLChannel >= 32760
                Box(11, 14, 9, 20, Pref\color[#Color_Spectrum_FG])
              Else
                Box(11, 14, 9, 20, ColorBright(Pref\color[#Color_Spectrum_BG], 70))
              EndIf
              
              ;Right
              If iRChannel >= 3640
                Box(64, 22, 1, 4, ColorBright(Pref\color[#Color_Spectrum_FG], -160))
              Else
                Box(64, 22, 1, 4, ColorBright(Pref\color[#Color_Spectrum_BG], 30))
              EndIf
              If iRChannel >= 7280
                Box(66, 21, 2, 6, ColorBright(Pref\color[#Color_Spectrum_FG], -140))
              Else
                Box(66, 21, 2, 6, ColorBright(Pref\color[#Color_Spectrum_BG], 35))
              EndIf
              If iRChannel >= 10920
                Box(69, 20, 3, 8, ColorBright(Pref\color[#Color_Spectrum_FG], -120))
              Else
                Box(69, 20, 3, 8, ColorBright(Pref\color[#Color_Spectrum_BG], 40))
              EndIf
              If iRChannel >= 14560
                Box(73, 19, 4, 10, ColorBright(Pref\color[#Color_Spectrum_FG], -100))
              Else
                Box(73, 19, 4, 10, ColorBright(Pref\color[#Color_Spectrum_BG], 45))
              EndIf
              If iRChannel >= 18200
                Box(78, 18, 5, 12, ColorBright(Pref\color[#Color_Spectrum_FG], -80))
              Else
                Box(78, 18, 5, 12, ColorBright(Pref\color[#Color_Spectrum_BG], 50))
              EndIf
              If iRChannel >= 21840
                Box(84, 17, 6, 14, ColorBright(Pref\color[#Color_Spectrum_FG], -60))
              Else
                Box(84, 17, 6, 14, ColorBright(Pref\color[#Color_Spectrum_BG], 55))
              EndIf
              If iRChannel >= 25480
                Box(91, 16, 7, 16, ColorBright(Pref\color[#Color_Spectrum_FG], -40))
              Else
                Box(91, 16, 7, 16, ColorBright(Pref\color[#Color_Spectrum_BG], 60))
              EndIf
              If iRChannel >= 29120
                Box(99, 15, 8, 18, ColorBright(Pref\color[#Color_Spectrum_FG], -20))
              Else
                Box(99, 15, 8, 18, ColorBright(Pref\color[#Color_Spectrum_BG], 65))
              EndIf
              If iRChannel >= 32760
                Box(108, 14, 9, 20, Pref\color[#Color_Spectrum_FG])
              Else
                Box(108, 14, 9, 20, ColorBright(Pref\color[#Color_Spectrum_BG], 70))
              EndIf
              
              StopDrawing()
            EndIf
            
        EndSelect
        
        ;RefreshImage
        SetGadgetState(#G_IG_Main_IA_Spectrum, ImageID(iSpectrum))
      EndIf
      
      iTime = timeGetTime_()
    EndIf
  EndIf
EndProcedure

; Aktualisiert die Zeitangaben im Infobereich des Hauptfensters sowie den Systray Icon Tooltip
Procedure Bass_RefreshPos()
  Protected qPos.q, iPercent.i, sTimeString.s
  
  qPos = BASS_ChannelGetPosition(CurrPlay\channel[CurrPlay\curr], #BASS_POS_BYTE)
  qPos = BASS_ChannelBytes2Seconds(CurrPlay\channel[CurrPlay\curr], qPos)
  
  CurrPlay\pos = qPos
  
  If CurrPlay\poschange = 0
    If CurrPlay\tag\length <= 0
      If GetGadgetState(#G_TB_Main_IA_Position) <> 0
        SetGadgetText(#G_TX_Main_IA_LengthC, "")
        SetGadgetState(#G_TB_Main_IA_Position, 0)
      EndIf
    Else
      iPercent = qPos * #MaxPos / CurrPlay\tag\length
      If GetGadgetState(#G_TB_Main_IA_Position) <> iPercent
        SetGadgetState(#G_TB_Main_IA_Position, iPercent)
      EndIf
    EndIf
  EndIf
  
  sTimeString = Pref\lengthformat
  If CurrPlay\tag\length > 0 And sTimeString
    sTimeString = ReplaceString(sTimeString, "%ptime",    TimeString(qPos), #PB_String_NoCase)
    sTimeString = ReplaceString(sTimeString, "%ltime",    TimeString(CurrPlay\tag\length - qPos), #PB_String_NoCase)
    sTimeString = ReplaceString(sTimeString, "%ftime",    TimeString(CurrPlay\tag\length), #PB_String_NoCase)
    sTimeString = ReplaceString(sTimeString, "%ppercent", Str(qPos * 100 / CurrPlay\tag\length) + "%", #PB_String_NoCase)
    sTimeString = ReplaceString(sTimeString, "%fppercent", StrF(qPos * 100 / CurrPlay\tag\length, 1) + "%", #PB_String_NoCase)
    sTimeString = ReplaceString(sTimeString, "%lpercent", Str(100 - (qPos * 100 / CurrPlay\tag\length)) + "%", #PB_String_NoCase)
    sTimeString = ReplaceString(sTimeString, "%flpercent", StrF(100 - (qPos * 100 / CurrPlay\tag\length), 1) + "%", #PB_String_NoCase)
  Else
    sTimeString = TimeString(qPos)
  EndIf
  
  If GetGadgetText(#G_TX_Main_IA_LengthC) <> sTimeString
    SetGadgetText(#G_TX_Main_IA_LengthC, sTimeString)
    
    If Len(CurrPlay\tag\title) > 50
      sTimeString = Left(CurrPlay\tag\title, 47) + "... [" + sTimeString + "]"
    Else
      sTimeString = CurrPlay\tag\title + " [" + sTimeString + "]"
    EndIf
    
    SysTrayIconToolTip(0, sTimeString)
  EndIf
EndProcedure

Procedure Bass_DefauldEffects()
  Protected iNext.i
  
  ; Equalizer
  If GetGadgetState(#G_PN_Effects_Categorie) = 0
    SetGadgetState(#G_CH_Effects_Equalizer, 0)
    SetGadgetState(#G_CB_Effects_Equalizer, 0)
    
    For iNext = 0 To 9
      SetGadgetState(#G_TB_Effects_EqualizerBand0 + iNext, 120)
      BassEQ\iCenter[iNext] = 120
    Next
    
    Pref\equilizer = 0
    
    Bass_SetEqualizer()
  
  ; Effects
  Else
    
    Pref\speed = 100
    Bass_SetFrequenz()
    
    Pref\panel = 100
    Bass_SetPanel()
    
    Effects\bReverb = 0
    Effects\fReverbMix = 0
    Effects\fReverbTime = 1000
    Bass_SetReverbParameters()
    Bass_SetReverb()
    
    Effects\bEcho = 0
    Effects\bEchoBack = 50
    Effects\iEchoDelay = 500
    Bass_SetEchoParameters()
    Bass_SetEcho()
    
    Effects\bFlanger = 0
    Bass_SetFlanger()
    
  EndIf
EndProcedure

; Diese Prozedure wird regelmäsig aufgerufen um alle Wiedergabeinformationen zu aktualisieren
Procedure Bass_Callback()
  Protected iNext.i, iPlaying.i
  Static iTime.i
  
  ; Disable Position
  If CurrPlay\tag\length <= 0 And CurrPlay\tag\length <> -1
    CurrPlay\tag\length = -1
    SetGadgetState(#G_TB_Main_IA_Position, 0)
    DisableGadget(#G_TB_Main_IA_Position, 1)
  EndIf
  
  ; Überprüfen ob Wiedergabe läuft
  For iNext = 0 To 1
    If BASS_ChannelIsActive(CurrPlay\channel[iNext]) <> #BASS_ACTIVE_STOPPED
      BASS_ChannelGetAttribute(CurrPlay\channel[iNext], #BASS_ATTRIB_VOL, @CurrPlay\volume[iNext])
      iPlaying = 1
    Else
      CurrPlay\channel[iNext] = 0
      CurrPlay\flags[iNext]   = 0
      CurrPlay\volume[iNext]  = 0
    EndIf
  Next
  
  ; Stop Inactive Channel
  For iNext = 0 To 1
    If CurrPlay\flags[iNext] = #ChannelFlag_Stop And CurrPlay\volume[iNext] <= 0
      BASS_ChannelStop(CurrPlay\channel[iNext])
      
      ; Send Plugin ChannelStop
      ForEach PluginEXE()
        Plugin_SendValue(PluginEXE()\hWnd, #BKR_Stop, CurrPlay\channel[iNext])
      Next
      
      CurrPlay\channel[iNext] = 0
      iChannelStop = 1
    EndIf
  Next
  
  ; All Channel Stopped
  If iPlaying = 0 And iChannelStop = 1
    iChannelStop = 0
    
    ; Free Memory
    ClearList(MidiLyrics())
    
    ; Remove MSN Status Text
    If Pref\misc_changemsn
      ChangeMSNStatus(0, "Music", "")
    EndIf
    
    SysTrayIconToolTip(0, #PrgName)
    
    SetToolBarButtonState(#Toolbar_Main1, #Mnu_Main_TB1_Pause, 0)
    
    ; Reset Gadgets
    DisableToolBarButton(#Toolbar_Main1, #Mnu_Main_TB1_Record, 1)
    
    SetGadgetState(#G_IG_Main_IA_Spectrum,  0)
    
    SetGadgetState(#G_TB_Main_IA_Position,  0)
    DisableGadget(#G_TB_Main_IA_Position,   1)
    
    For iNext = 0 To 4
      CurrPlay\description[iNext] = ""
    Next
    
    SetGadgetText(#G_TX_Main_IA_InfoDesc1,  "")
    SetGadgetText(#G_TX_Main_IA_InfoDesc2,  "")
    SetGadgetText(#G_TX_Main_IA_InfoDesc3,  "")
    SetGadgetText(#G_TX_Main_IA_InfoDesc4,  "")
    SetGadgetText(#G_TX_Main_IA_Length,     "")
    SetGadgetText(#G_TX_Main_IA_InfoCont1,  "")
    SetGadgetText(#G_TX_Main_IA_InfoCont2,  "")
    SetGadgetText(#G_TX_Main_IA_InfoCont3,  "")
    SetGadgetText(#G_TX_Main_IA_InfoCont4,  "")
    SetGadgetText(#G_TX_Main_IA_LengthC,    "")
    
    SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_BackColor, -1)
    SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_FrontColor, -1)
    
    ; Close Tracker
    If Pref\tracker_test = 0
      CloseWindow_Tracker()
    EndIf
  EndIf
  
  If iPlaying = 0
    PlayList_NextTrack()
  EndIf
  
  ; Refresh Infos
  Protected iState.i
  
  iState = BASS_ChannelIsActive(CurrPlay\channel[CurrPlay\curr])
  Select iState
    
    ; Invalid
    Case #BASS_ACTIVE_STOPPED
      CurrPlay\file = ""
      
    ; Wait for Data, buffering
    Case #BASS_ACTIVE_STALLED
      
    ; Play
    Case #BASS_ACTIVE_PLAYING
      If GetGadgetText(#G_TX_Main_IA_InfoDesc1) <> CurrPlay\description[0]
        SetGadgetText(#G_TX_Main_IA_InfoDesc1, CurrPlay\description[0])
      EndIf
      If GetGadgetText(#G_TX_Main_IA_InfoDesc2) <> CurrPlay\description[1]
        SetGadgetText(#G_TX_Main_IA_InfoDesc2, CurrPlay\description[1])
      EndIf
      If GetGadgetText(#G_TX_Main_IA_InfoDesc3) <> CurrPlay\description[2]
        SetGadgetText(#G_TX_Main_IA_InfoDesc3, CurrPlay\description[2])
      EndIf
      If GetGadgetText(#G_TX_Main_IA_InfoDesc4) <> CurrPlay\description[3]
        SetGadgetText(#G_TX_Main_IA_InfoDesc4, CurrPlay\description[3])
      EndIf
      If GetGadgetText(#G_TX_Main_IA_Length) <> CurrPlay\description[4]
        SetGadgetText(#G_TX_Main_IA_Length, CurrPlay\description[4])
      EndIf
      
      ; InetStream Buffer in Percent
      If CurrPlay\playtype = #PlayType_Shoutcast
        Protected qLen.q, qBuffer.q, fProgress.f
        qLen      = BASS_StreamGetFilePosition(CurrPlay\channel[CurrPlay\curr], #BASS_FILEPOS_END)
        qBuffer   = BASS_StreamGetFilePosition(CurrPlay\channel[CurrPlay\curr], #BASS_FILEPOS_BUFFER)
        fProgress = qBuffer * 100.0 / qLen
      Else
        fProgress = 100
      EndIf
      If fProgress < 50
        SetGadgetText(#G_TX_Main_IA_InfoCont1, "Bufferung.. [" + StrF(fProgress, 0) + "%]")
      Else
        If GetGadgetText(#G_TX_Main_IA_InfoCont1) <> CurrPlay\tag\title
          SetGadgetText(#G_TX_Main_IA_InfoCont1, CurrPlay\tag\title)
        EndIf
      EndIf
      
      If GetGadgetText(#G_TX_Main_IA_InfoCont2) <> CurrPlay\tag\artist
        SetGadgetText(#G_TX_Main_IA_InfoCont2, CurrPlay\tag\artist)
      EndIf
      If GetGadgetText(#G_TX_Main_IA_InfoCont3) <> CurrPlay\tag\album
        SetGadgetText(#G_TX_Main_IA_InfoCont3, CurrPlay\tag\album)
      EndIf
      If GetGadgetText(#G_TX_Main_IA_InfoCont4) <> CurrPlay\tag\genre
        SetGadgetText(#G_TX_Main_IA_InfoCont4, CurrPlay\tag\genre)
      EndIf
      
      Bass_RefreshSpectrum()
      Bass_RefreshPos()
      
      ; Stop Channel while Time is up
      If CurrPlay\tag\length > 0 And CurrPlay\tag\length - CurrPlay\pos <= Pref\bass_fadeout
        Bass_FadeOut()
      EndIf
      
      ; Incrase Statics PlayTime
      If timeGetTime_() - iTime >= 1000
        iTime = timeGetTime_()
        Statistics\play_time + 1
      EndIf
      
    ; Pause
    Case #BASS_ACTIVE_PAUSED
      
  EndSelect
EndProcedure

Procedure.s HTML_ConvertText(String$)
  String$ = Trim(String$)
  
  If String$ = ""
    String$ = "&nbsp;"
  Else
    String$ = ReplaceString(String$, "ä", "&auml;")
    String$ = ReplaceString(String$, "ö", "&ouml;")
    String$ = ReplaceString(String$, "ü", "&uuml;")
    String$ = ReplaceString(String$, "Ä", "&Auml;")
    String$ = ReplaceString(String$, "Ö", "&Ouml;")
    String$ = ReplaceString(String$, "Ü", "&Uuml;")    
  EndIf
  
  ProcedureReturn String$
EndProcedure

Procedure.s HTML_ConvertNum(Value)
  If Value > 0
    ProcedureReturn Str(Value)
  Else
    ProcedureReturn "&nbsp;"
  EndIf
EndProcedure

Procedure PlayList_RefreshHeader()
  If Pref\autoclnw_pl > 0
    Protected iNext.i
    
    For iNext = 1 To #PlayList_Column_Last
      SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_SETCOLUMNWIDTH, iNext, #LVSCW_AUTOSIZE_USEHEADER)
    Next
  EndIf
EndProcedure

Procedure PlayList_GetLength()
  Protected iLength.i
  
  ForEach PlayList()
    iLength + PlayList()\tag\length
  Next
  
  ProcedureReturn iLength
EndProcedure

Procedure PlayList_RefreshAllTimes()
  Protected sString.s
  Protected iFullLength.i
  
  If ListSize(PlayList()) > 0
    ForEach PlayList()
      If PlayList()\tag\length > 0
        iFullLength + PlayList()\tag\length
      EndIf
    Next
    sString = " " + Str(ListSize(PlayList())) + " [" + TimeString(iFullLength) + "]"
  Else
    sString = " 0"
  EndIf
  
  StatusBarText(#Statusbar_Main, #SBField_PlayList, sString)
EndProcedure

Procedure PlayList_RefreshMenu()
  Protected iSel.i, iCount.i
  
  iSel.i   = GetGadgetState(#G_LI_Main_PL_PlayList)
  iCount.i = CountGadgetItems(#G_LI_Main_PL_PlayList)
  
  If iSel = -1
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Play, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Copy, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_OpenFolder, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Remove, 1)
    ;DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_AutoTag, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Refresh, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Info, 1)
  Else
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Play, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Copy, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_OpenFolder, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Remove, 0)
    ;DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_AutoTag, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Refresh, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Info, 0)
  EndIf
  
  If iCount = 0
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SavePlayList, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_RemoveAll, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SelAll, 1)
  Else
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SavePlayList, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_RemoveAll, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SelAll, 0)
  EndIf
  
  If iCount < 2
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Search, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortMix, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortTitle, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortArtist, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortAlbum, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortLength, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortTrack, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortYear, 1)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortType, 1)
  Else
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Search, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortMix, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortTitle, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortArtist, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortAlbum, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortLength, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortTrack, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortYear, 0)
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_SortType, 0)
  EndIf
  
  If Clipboard_GetFileCount() > 0
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Insert, 0)
  Else
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Insert, 1)
  EndIf
  
  LockMutex(MediaLibScan\Mutex)
  
  If ListSize(MediaLibary()) = 0
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Generate, 1)
  Else
    DisableMenuItem(#Menu_PlayList, #Mnu_PlayList_Generate, 0)
  EndIf
  
  UnlockMutex(MediaLibScan\Mutex)
  
EndProcedure

Procedure PlayList_AddItem(Title$, Artist$, Album$, Track, Length, Year, Type, Sel = -1)
  
  ; Neues Item hinzufügen
  If Sel = -1
    AddGadgetItem(#G_LI_Main_PL_PlayList, -1, "")
    Sel = CountGadgetItems(#G_LI_Main_PL_PlayList) - 1
  EndIf
  
  ; Spaltentexte aktualisieren
  If CountGadgetItems(#G_LI_Main_PL_PlayList) >= Sel
    ;Title
    SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, Trim(Title$), #PlayList_Column_Title)
    ;Artist
    SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, Trim(Artist$), #PlayList_Column_Interpret)
    ;Album
    SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, Trim(Album$), #PlayList_Column_Album)
    ;Track
    If Track > 0
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, Str(Track), #PlayList_Column_Track)
    Else
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, "", #PlayList_Column_Track)
    EndIf
    ;Length
    If Length > 0
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, TimeString(Length), #PlayList_Column_Length)
    Else
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, "", #PlayList_Column_Length)
    EndIf
    ;Year
    If Year > 0
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, Trim(Str(Year)), #PlayList_Column_Year)
    Else
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, "", #PlayList_Column_Year)
    EndIf
    ;Type
    If Type > 0
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, MetaData_GetFormatString(Type, 0), #PlayList_Column_Type)
    Else
      SetGadgetItemText(#G_LI_Main_PL_PlayList, Sel, "", #PlayList_Column_Type)
    EndIf
  EndIf
  
EndProcedure

Procedure PlayList_Play()
  If iSizeTypeOld = #SizeType_MediaLibary
    ;Medienbibliothek ist offen deshalb wird auch nur diese abgespielt
    MediaLib_Play()
  Else
    ; Wiedergabe aus Playlist
    Protected iSel.i
    
    iSel = GetGadgetState(#G_LI_Main_PL_PlayList)
    
    If BASS_ChannelIsActive(CurrPlay\channel[CurrPlay\curr]) = #BASS_ACTIVE_PAUSED
      Bass_PauseMedia()
      ProcedureReturn 1
    EndIf
    
    If BASS_ChannelIsActive(CurrPlay\channel[CurrPlay\curr]) <> #BASS_ACTIVE_STOPPED And iSel = -1
      BASS_ChannelPlay(CurrPlay\channel[CurrPlay\curr], 1)
      ProcedureReturn 2
    EndIf
    
    If ListSize(PlayList()) > 0
      If iSel = -1
        iSel = 0
      EndIf
      
      If ListSize(PlayList()) >= iSel
        SelectElement(PlayList(), iSel)
        If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
          CurrPlay\plindex = ListIndex(PlayList())
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
        EndIf
      EndIf
    EndIf
  EndIf
EndProcedure

; Spielt einen Track aus der Wiedergabeliste ab, egal welcher Fensterbereich offen ist.
Procedure PlayList_PlayTrack(Track)
  If ListSize(PlayList()) >= Track
    SelectElement(PlayList(), Track)
    
    If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
      CurrPlay\plindex = Track
      SetGadgetItemColor(#G_LI_Main_PL_PlayList, Track, #PB_Gadget_BackColor,  Pref\color[#Color_Select_BG])
      SetGadgetItemColor(#G_LI_Main_PL_PlayList, Track, #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
    EndIf
  EndIf
EndProcedure

; Spielt den vorherigen Titel in der Wiedergabeliste ab
Procedure PlayList_PreviousTrack()
  If CurrPlay\playtype = #PlayType_PlayList And ListSize(PlayList()) > 0
    
    ; Zufallswiedergabe
    If GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Random)
      Protected iRandom.i
      
      If ListSize(PlayList()) = 1
        ; Da die Wiedergabeliste lediglich einen Titel enthält, diesen wiederholen
        iRandom = 0
      Else
        ; Zufallstitel bestimmen
        iRandom = Random(ListSize(PlayList()) - 1)
        ; Solange wiederholen bis der neue Titel sich vom letzten unterscheidet
        While iRandom = CurrPlay\plindex
          iRandom = Random(ListSize(PlayList()) - 1)
        Wend
      EndIf
      
      ; Wiedergabe Starten
      If ListSize(PlayList()) >= iRandom
        SelectElement(PlayList(), iRandom)
        If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
          CurrPlay\plindex = iRandom
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
        Else
          CurrPlay\playtype = #PlayType_Normal
        EndIf
      EndIf
      
    Else
      ; Vorheriger Titel
      If CurrPlay\plindex - 1 >= 0
        
        ; Wiedergabe Starten
        If ListSize(PlayList()) >= CurrPlay\plindex - 1
          SelectElement(PlayList(), CurrPlay\plindex - 1)
          
          If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
            CurrPlay\plindex - 1
            SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
            SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
          Else
            CurrPlay\playtype = #PlayType_Normal
          EndIf
        EndIf
        
      ; Wiederholung
      Else
        
        ; Erneute Wiedergabe der Wiedergabeliste da der Anfang erreicht wurde und Wiederholung aktivert ist
        If GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Repeat)
          
          ; Wiedergabe Starten
          If ListSize(PlayList()) > 0
            LastElement(PlayList())
            If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
              CurrPlay\plindex = ListIndex(PlayList())
              SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
              SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
            Else
              CurrPlay\playtype = #PlayType_Normal
            EndIf
          EndIf
          
        ; Wiedergabe Beenden
        Else
          CurrPlay\playtype = #PlayType_Normal
        EndIf
        
      EndIf
    EndIf
    
  EndIf
EndProcedure

; Spielt den Nächsten Titel in der Wiedergabeliste ab
Procedure PlayList_NextTrack()
  If CurrPlay\playtype = #PlayType_PlayList And ListSize(PlayList()) > 0
    
    If GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Random)
      ; Random
      Protected iRandom.i
      
      If ListSize(PlayList()) = 1
        iRandom = 0
      Else
        iRandom = Random(ListSize(PlayList()) - 1)
        While iRandom = CurrPlay\plindex
          iRandom = Random(ListSize(PlayList()) - 1)
        Wend
      EndIf
      
      SelectElement(PlayList(), iRandom)
      If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
        CurrPlay\plindex = iRandom
        SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
        SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
      Else
        CurrPlay\playtype = #PlayType_Normal
      EndIf
      
    Else
      If ListSize(PlayList()) - 1 > CurrPlay\plindex
        ; Next
        SelectElement(PlayList(), CurrPlay\plindex + 1)
        If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
          CurrPlay\plindex + 1
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
          SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
        Else
          CurrPlay\playtype = #PlayType_Normal
        EndIf
      Else
        ; Repeat
        If GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Repeat)
          If ListSize(PlayList()) > 0
            SelectElement(PlayList(), 0)
            If Bass_PlayMedia(PlayList()\tag\file, #PlayType_PlayList)
              CurrPlay\plindex = 0
              SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
              SetGadgetItemColor(#G_LI_Main_PL_PlayList, ListIndex(PlayList()), #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
            Else
              CurrPlay\playtype = #PlayType_Normal
            EndIf
          EndIf
        Else
          CurrPlay\playtype = #PlayType_Normal
        EndIf
      EndIf
    EndIf
    
  EndIf
EndProcedure

Procedure PlayList_Remove(Sel)
  
  SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #WM_SETREDRAW, 0, 0)
  
  If Sel < 0
    ;Remove All
    ClearList(PlayList())
    ClearGadgetItems(#G_LI_Main_PL_PlayList)
  Else
    ;Remove Sel
    Protected iNext.i, iMax.i = CountGadgetItems(#G_LI_Main_PL_PlayList) - 1
    For iNext = 0 To iMax
      If GetGadgetItemState(#G_LI_Main_PL_PlayList, iMax - iNext) & #PB_ListIcon_Selected
        SelectElement(PlayList(), iMax - iNext)
        DeleteElement(PlayList())
        RemoveGadgetItem(#G_LI_Main_PL_PlayList, iMax - iNext)
        If iMax - iNext < CurrPlay\plindex
          CurrPlay\plindex - 1
        EndIf
      EndIf
    Next
  EndIf
  
  SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #WM_SETREDRAW, 1, 0)
  
  Playlist_RefreshAllTimes()
  
  If ListSize(PlayList()) = 0 And CurrPlay\playtype = #PlayType_PlayList
    CurrPlay\playtype = #PlayType_Normal
  EndIf
EndProcedure

Procedure PlayList_Sort(Type)
  If Type >= 0 And Type <= 7 And ListSize(PlayList()) > 1
    Static iLastType.i, iLastSort.i
    
    ; Save Curr Selection
    If CurrPlay\playtype = #PlayType_PlayList And ListSize(PlayList()) >= CurrPlay\plindex
      SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_BackColor, -1)
      SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_FrontColor, -1)
      SelectElement(PlayList(), CurrPlay\plindex)
      PlayList()\tag\comment = "CURR_SEL" + PlayList()\tag\comment
    EndIf
    
    If Type = iLastType
      If iLastSort = #PB_Sort_Ascending
        iLastSort = #PB_Sort_Descending
      Else
        iLastSort = #PB_Sort_Ascending
      EndIf
    Else
      iLastSort = #PB_Sort_Ascending
    EndIf
    
    ListIconSort_SetColumnArrow(#G_LI_Main_PL_PlayList, iLastType, 0)
    If iLastSort = #PB_Sort_Ascending
      ListIconSort_SetColumnArrow(#G_LI_Main_PL_PlayList, Type, 1)
    Else
      ListIconSort_SetColumnArrow(#G_LI_Main_PL_PlayList, Type, 2)
    EndIf
    
    iLastType = Type
    
    ; Sort
    Select Type
      Case 0 ; Mischen
        ForEach PlayList()
          PlayList()\mix = Random(255)
        Next
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\mix), #PB_Sort_Byte)
      Case #PlayList_Column_Title
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\tag) + OffsetOf(_Tag\title), #PB_Sort_String)
      Case #PlayList_Column_Interpret
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\tag) + OffsetOf(_Tag\artist), #PB_Sort_String)
      Case #PlayList_Column_Album
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\tag) + OffsetOf(_Tag\album), #PB_Sort_String)
      Case #PlayList_Column_Track
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\tag) + OffsetOf(_Tag\track), #PB_Sort_Word)
      Case #PlayList_Column_Length
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\tag) + OffsetOf(_Tag\length), #PB_Sort_Integer)
      Case #PlayList_Column_Year
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\tag) + OffsetOf(_Tag\year), #PB_Sort_Word)
      Case #PlayList_Column_Type
        SortStructuredList(PlayList(), iLastSort, OffsetOf(_PlayList\tag) + OffsetOf(_Tag\cType), #PB_Sort_Integer)
    EndSelect
    
    ; Refresh ListIconGadget
    ForEach PlayList()
      PlayList_AddItem(PlayList()\tag\title, PlayList()\tag\artist, PlayList()\tag\album, PlayList()\tag\track, PlayList()\tag\length, PlayList()\tag\year, PlayList()\tag\cType, ListIndex(PlayList()))
      
      ; Refresh Curr Selection
      If Left(PlayList()\tag\comment, 8) = "CURR_SEL"
        PlayList()\tag\comment = Right(PlayList()\tag\comment, Len(PlayList()\tag\comment) - 8)
        CurrPlay\plindex = ListIndex(PlayList())
        SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
        SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
      EndIf
    Next
    
    PlayList_RefreshHeader()
  EndIf
EndProcedure

Procedure PlayList_Search()
  Protected sSearch.s = Trim(LCase(GetGadgetText(#G_SR_Search_String))), iAddBool.i
  
  If ListSize(PlayList()) > 0 And Trim(sSearch) <> ""
    DisableGadget(#G_BN_Search_Start, 1)
    
    ClearGadgetItems(#G_LV_Search_Result)
    ClearList(SearchResult())
    
    ForEach PlayList()
      iAddBool = 0
      
      ;Title
      If GetGadgetState(#G_CB_Search_SearchIn) = 0 Or GetGadgetState(#G_CB_Search_SearchIn) = 1
        If FindString(LCase(PlayList()\tag\title), sSearch, 1) : iAddBool = 1 : EndIf
      EndIf
      ;Artist
      If GetGadgetState(#G_CB_Search_SearchIn) = 0 Or GetGadgetState(#G_CB_Search_SearchIn) = 2
        If FindString(LCase(PlayList()\tag\artist), sSearch, 1) : iAddBool = 1 : EndIf
      EndIf
      ;Album
      If GetGadgetState(#G_CB_Search_SearchIn) = 0 Or GetGadgetState(#G_CB_Search_SearchIn) = 3
        If FindString(LCase(PlayList()\tag\album), sSearch, 1) : iAddBool = 1 : EndIf
      EndIf
      ;Comment
      If GetGadgetState(#G_CB_Search_SearchIn) = 0 Or GetGadgetState(#G_CB_Search_SearchIn) = 4
        If FindString(LCase(PlayList()\tag\comment), sSearch, 1) : iAddBool = 1 : EndIf
      EndIf
      
      If iAddBool
        AddElement(SearchResult())
        SearchResult()\index = ListIndex(PlayList())
        SearchResult()\name  = PlayList()\tag\title
        AddGadgetItem(#G_LV_Search_Result, -1, SearchResult()\name)
      EndIf
     
      While WindowEvent() : Wend
    Next
    
    SetGadgetText(#G_SR_Search_String, "")
    DisableGadget(#G_BN_Search_Start, 0)
  EndIf
EndProcedure

Procedure.i PlayList_Save(Path$ = "", Overwrite = -1)
  If ListSize(PlayList()) > 0
    Protected lFileID.i, sTemp.s
    
    If Path$ = ""
      Path$ = SaveFileRequester("Speichern", MyMusicDirectory(), "Playlist (*.m3u)|*.m3u|Playlist (*.m3u8)|*.m3u8|Playlist (*.pls)|*.pls|Playlist (*.xspf)|*.xspf|HTML-Datei (*.html)|*.html|Alle Dateien|*.*", 0)
    EndIf
    
    If Path$ <> ""
      ;AddExtension
      If GetExtensionPart(Path$) = ""
        Select SelectedFilePattern()
          Case 0 : Path$ + ".m3u"
          Case 1 : Path$ + ".m3u8"
          Case 2 : Path$ + ".pls"
          Case 3 : Path$ + ".xspf"
          Case 4 : Path$ + ".html"
        EndSelect
      EndIf
      
      ;Overwrite
      If FileSize(Path$) > 0 And Overwrite <> -1
        If MessageRequester("Überschreiben", "Datei '" + Path$ + "' existiert bereits," + #CRLF$ + "soll die Datei überschrieben werden?", #MB_YESNO|#MB_ICONEXCLAMATION) = #IDNO
          ProcedureReturn 0
        EndIf
      EndIf
      
      ;Save
      lFileID = CreateFile(#PB_Any, Path$)
      If lFileID <> 0
        Select SelectedFilePattern()
          ;M3U
          Case 0, 5
            WriteStringN(lFileID, "#EXTM3U")
            ForEach PlayList()
              WriteStringN(lFileID, "#EXTINF:" + Str(PlayList()\tag\length) + "," + PlayList()\tag\title)
              WriteStringN(lFileID, PlayList()\tag\file)
            Next
          ;M3U8
          Case 1
            WriteStringFormat(lFileID, #PB_UTF8)
            WriteStringN(lFileID, "#EXTM3U", #PB_UTF8)
            ForEach PlayList()
              WriteStringN(lFileID, "#EXTINF:" + Str(PlayList()\tag\length) + "," + PlayList()\tag\title, #PB_UTF8)
              WriteStringN(lFileID, PlayList()\tag\file, #PB_UTF8)
            Next
          ;PLS
          Case 2
            WriteStringN(lFileID, "[playlist]")
            ForEach PlayList()
              WriteStringN(lFileID, "File" + Str(ListIndex(PlayList()) + 1) + "=" + PlayList()\tag\file)
              WriteStringN(lFileID, "Title" + Str(ListIndex(PlayList()) + 1) + "=" + PlayList()\tag\title)
              WriteStringN(lFileID, "Length" + Str(ListIndex(PlayList()) + 1) + "=" + Str(PlayList()\tag\length))
            Next
            WriteStringN(lFileID, "NumberOfEntries=" + Str(ListSize(PlayList())))
            WriteStringN(lFileID, "Version=2")
          ;XSPF
          Case 3
            WriteStringFormat(lFileID, #PB_UTF8)
            WriteStringN(lFileID, "<?xml version=" + Chr(34) + "1.0" + Chr(34) + " encoding=" + Chr(34) + "UTF-8" + Chr(34) + "?>", #PB_UTF8)
            WriteStringN(lFileID, "<playlist version=" + Chr(34) + "1" + Chr(34) + " xmlns=" + Chr(34) + "http://xspf.org/ns/0/" + Chr(34) + ">", #PB_UTF8)
            WriteStringN(lFileID, "  <trackList>", #PB_UTF8)
            ForEach PlayList()
              WriteStringN(lFileID, "    <track>", #PB_UTF8)
              WriteStringN(lFileID, "      <title>" + PlayList()\tag\title + "</title>", #PB_UTF8)
              WriteStringN(lFileID, "      <creator>" + PlayList()\tag\artist + "</creator>", #PB_UTF8)
              WriteStringN(lFileID, "      <location>" + PlayList()\tag\file + "</location>", #PB_UTF8)
              WriteStringN(lFileID, "    </track>", #PB_UTF8)
            Next
            WriteStringN(lFileID, "  </trackList>", #PB_UTF8)
            WriteStringN(lFileID, "</playlist>", #PB_UTF8)
          ;HTML
          Case 4
            WriteStringN(lFileID, #HTML_DocType)
            WriteStringN(lFileID, "<html>")
            WriteStringN(lFileID, "<head>")
            WriteStringN(lFileID, "<title>" + #PrgName + " - Wiedergabeliste</title>")
            WriteStringN(lFileID, "<meta name=" + Chr(34) + "editor" + Chr(34) + " " + "content=" + Chr(34) + #PrgName + Chr(34) + ">")
            WriteStringN(lFileID, "<style type=" + Chr(34) + "text/css" + Chr(34) + ">")
            WriteStringN(lFileID, "body { font-family: Verdana, Arial; font-size: 12px; color: #000000; }")
            WriteStringN(lFileID, "table { border: 2px solid #000000; margin: 5px; }")
            WriteStringN(lFileID, "td { border: 1px solid #000000; padding: 2px; }")
            WriteStringN(lFileID, "</style>")
            WriteStringN(lFileID, "</head>")
            WriteStringN(lFileID, "<body>")
            WriteStringN(lFileID, "<table>")
            WriteStringN(lFileID, "<tr><td colspan=" + Chr(34) + "7" + Chr(34) + ">Wiedergabeliste [" + FormatDate("%dd.%mm.%yyyy", Date()) + "]</td></tr>")
            WriteStringN(lFileID, "<tr><td>Titel</td><td>Interpret</td><td>Album</td><td>Länge</td><td>Track</td><td>Jahr</td><td>Format</td></tr>")
            ForEach PlayList()
              WriteString(lFileID, "<tr>")
              ; Titel
              WriteString(lFileID, "<td>" + HTML_ConvertText(PlayList()\tag\title) + "</td>")
              ; Artist
              WriteString(lFileID, "<td>" + HTML_ConvertText(PlayList()\tag\artist) + "</td>")
              ; Album
              WriteString(lFileID, "<td>" + HTML_ConvertText(PlayList()\tag\album) + "</td>")
              ; Length
              WriteString(lFileID, "<td>" + TimeString(PlayList()\tag\length) + "</td>") 
               ; Track
              WriteString(lFileID, "<td>" + HTML_ConvertNum(PlayList()\tag\track) + "</td>")
              ; Year
              WriteString(lFileID, "<td>" + HTML_ConvertNum(PlayList()\tag\year) + "</td>")
              ; Typ
              WriteString(lFileID, "<td>" + HTML_ConvertText(MetaData_GetFormatString(PlayList()\tag\cType, 0)) + "</td>")
              WriteStringN(lFileID, "</tr>")
            Next
            WriteStringN(lFileID, "<tr><td colspan=" + Chr(34) + "3" + Chr(34) + ">Länge [" + Str(ListSize(PlayList())) + " Tracks]</td><td colspan=" + Chr(34) + "4" + Chr(34) + ">" + TimeString(PlayList_GetLength()) + "</td></tr>")
            WriteStringN(lFileID, "</table>")
            WriteStringN(lFileID, "</body>")            
            WriteStringN(lFileID, "</html>")
        EndSelect
        CloseFile(lFileID)
      Else
        MsgBox_Exclamation("PlayList konnte nicht gespeichert werden")
      EndIf
    
    EndIf
  EndIf
EndProcedure

; Öffnet eine M3U Wiedergabeliste
Procedure PlayList_AddPlayListM3U(File$, New = 0)
  Protected iFile.i, sFile.s, sRead.s
  Protected iFileFormat.i
  
  iFile = ReadFile(#PB_Any, File$)
  If iFile
    iFileFormat = ReadStringFormat(iFile)
    
    If Trim(ReadString(iFile)) = "#EXTM3U"
      
      
      While Eof(iFile) = 0
        
        sRead = Trim(ReadString(iFile, iFileFormat))
        If sRead <> "" And UCase(Left(sRead, 8)) <> "#EXTINF:"
          
          If New
            New = 0
            PlayList_Remove(-1)
          EndIf
          
          ; Absoluter Pfad
          If FileSize(sRead) > 0
            PlayList_AddFile(sRead)
          ; Relativer Pfad
          ElseIf FileSize(GetFilePart(File$) + sRead)
            PlayList_AddFile(GetFilePart(File$) + sRead)
          EndIf
          
        EndIf
        
      Wend
      
    EndIf
    
    CloseFile(iFile)
  EndIf
EndProcedure

; Öffnet eine PLS Wiedergabeliste
Procedure PlayList_AddPlayListPLS(File$, New = 0)
  Protected iFile.i, sRead.s
  Protected iFileFormat.i
  
  iFile = ReadFile(#PB_Any, File$)
  If iFile
    iFileFormat = ReadStringFormat(iFile)
    
    While Eof(iFile) = 0
      sRead = Trim(ReadString(iFile, iFileFormat))
      
      If UCase(Left(sRead, 4)) = "FILE"
        sRead = StringField(sRead, 2, "=")
        
        If FileSize(sRead) > 0
          
          If New = 1
            New = 0
            PlayList_Remove(-1)
          EndIf          
          
          PlayList_AddFile(sRead)
        EndIf
        
      EndIf
      
    Wend
    
    CloseFile(iFile)
  EndIf
EndProcedure

; Öffnet eine XSPF Wiedergabeliste
Procedure PlayList_AddPlayListXSPF(File$, New = 0)
  Protected iFile.i, sRead.s
  Protected iFileFormat.i
  
  iFile = ReadFile(#PB_Any, File$)
  If iFile
    iFileFormat = ReadStringFormat(iFile)
    
    While Eof(iFile) = 0
      sRead = Trim(ReadString(iFile, iFileFormat))
      If LCase(Left(sRead, 10)) = "<location>" And LCase(Right(sRead, 11)) = "</location>"
        sRead = Mid(sRead, 11, Len(sRead) - 21)
        If FileSize(sRead) > 0
          
          If New = 1
            New = 0
            PlayList_Remove(-1)
          EndIf     
          
          PlayList_AddFile(sRead)
        EndIf
      EndIf
    Wend
    
    CloseFile(iFile)
  EndIf
EndProcedure

Procedure PlayList_AddFile(File$ = "", Play = 0)
  Protected iPlayListCount.i
  
  iPlayListCount = ListSize(PlayList())
  
  If File$ = ""
    Protected sPattern.s
    
    ; All Supported Formats
    sPattern = "Unterstützte Formate|"
    ForEach FileType()
      sPattern + "*." + FileType()\ext + ";"
    Next
    ; Audio
    sPattern + "|Audio|"
    ForEach FileType()
      If FileType()\typ = #FileType_Audio
        sPattern + "*." + FileType()\ext + ";"
      EndIf
    Next
    ; Playlist
    sPattern + "|Wiedergabeliste|"
    ForEach FileType()
      If FileType()\typ = #FileType_PlayList
        sPattern + "*." + FileType()\ext + ";"
      EndIf
    Next
    ; All Files
    sPattern + "|Alle Dateien|*.*"
    
    File$ = OpenFileRequester("Dateien Hinzufügen", MyMusicDirectory(), sPattern, 0, #PB_Requester_MultiSelection)
  EndIf
  
  If File$
    Protected iStream.i, Tag._Tag, sExtension.s
    
    While File$
      sExtension = UCase(GetExtensionPart(File$))
      
      If sExtension = "M3U" Or sExtension = "M3U8"
        PlayList_AddPlayListM3U(File$)
      ElseIf sExtension = "PLS"
        PlayList_AddPlayListPLS(File$)
      ElseIf sExtension = "XSPF"
        PlayList_AddPlayListXSPF(File$)
      Else
        Tag\file = File$
        If MetaData_ReadData(Tag) <> 0
          
          LastElement(PlayList())
          AddElement(PlayList())
          
          PlayList()\tag\file       = File$
          PlayList()\mix            = Random(32767)
          PlayList()\tag\title      = Tag\title
          PlayList()\tag\artist     = Tag\artist
          PlayList()\tag\album      = Tag\album
          PlayList()\tag\year       = Tag\year
          PlayList()\tag\comment    = Tag\comment
          PlayList()\tag\track      = Tag\track
          PlayList()\tag\genre      = Tag\genre
          PlayList()\tag\bitrate    = Tag\bitrate
          PlayList()\tag\samplerate = Tag\samplerate
          PlayList()\tag\channels   = Tag\channels
          PlayList()\tag\length     = Tag\length
          PlayList()\tag\cType      = Tag\cType
          
          PlayList_AddItem(PlayList()\tag\title, PlayList()\tag\artist, PlayList()\tag\album, PlayList()\tag\track, PlayList()\tag\length, PlayList()\tag\Year, PlayList()\tag\cType)
          
          Playlist_RefreshAllTimes()
          PlayList_RefreshHeader()
        EndIf
      EndIf
      
      WindowEvent()
      
      File$ = NextSelectedFileName()
    Wend
    
    If iPlayListCount < ListSize(PlayList()) And Play
      PlayList_PlayTrack(iPlayListCount)
    EndIf
    
  EndIf
EndProcedure

Procedure PlayList_AddFileFast(*Tag._Tag)
  If FileSize(*Tag\file) > 0
    LastElement(PlayList())
    AddElement(PlayList())
    
    PlayList()\mix            = Random(255)
    PlayList()\tag\file       = *Tag\file
    PlayList()\tag\title      = *Tag\title
    PlayList()\tag\artist     = *Tag\artist
    PlayList()\tag\album      = *Tag\album
    PlayList()\tag\track      = *Tag\track
    PlayList()\tag\length     = *Tag\length
    PlayList()\tag\year       = *Tag\year
    PlayList()\tag\cType      = *Tag\cType
    PlayList()\tag\comment    = *Tag\comment
    PlayList()\tag\genre      = *Tag\genre
    PlayList()\tag\bitrate    = *Tag\bitrate
    PlayList()\tag\samplerate = *Tag\samplerate
    PlayList()\tag\channels   = *Tag\channels
    
    PlayList_AddItem(PlayList()\tag\title, PlayList()\tag\artist, PlayList()\tag\album, PlayList()\tag\track, PlayList()\tag\length, PlayList()\tag\year, PlayList()\tag\cType)
  EndIf
EndProcedure

Procedure PlayList_AddFolder(Folder.s, Recursiv.b, Play = 0)
  Protected iPlayListCount.i
  
  CloseWindow_PathRequester()
  
  ; Letzte Wiedergabelisten eigenschaften merken
  iPlayListCount = ListSize(PlayList())
  
  ; Ordner hinzufügen
  If FileSize(Folder) = -2
    Protected iFolder.i, sFile.s
    
    iFolder = ExamineDirectory(#PB_Any, Folder, "*.*")
    If iFolder
      
      While NextDirectoryEntry(iFolder)
        sFile = DirectoryEntryName(iFolder)
        ; Cancel
        If GetAsyncKeyState_(#VK_ESCAPE)
          Break
        EndIf
        ; Add
        If DirectoryEntryType(iFolder) = #PB_DirectoryEntry_Directory
          If Recursiv = 1 And sFile <> "." And sFile <> ".."
            PathAddBackslash_(@sFile)
            PlayList_AddFolder(Folder + sFile, Recursiv)
          EndIf
        Else
          PlayList_AddFile(Folder + sFile)
        EndIf
      Wend
      
      FinishDirectory(iFolder)
    EndIf
    
    ; Wiedergabe starten
    If iPlayListCount < ListSize(PlayList()) And Play
      PlayList_PlayTrack(iPlayListCount)
    EndIf
    
  EndIf
EndProcedure

Procedure PlayList_AddDrop()
  Protected iNext.i, sFile.s, iCount.i, sCurrFile.s
  
  sFile  = EventDropFiles()
  iCount = CountString(sFile, Chr(10)) + 1
  
  If sFile And iCount
    
    If Pref\misc_dropclear
      PlayList_Remove(-1)
    EndIf
    
    For iNext = 1 To iCount
      sCurrFile = StringField(sFile, iNext, Chr(10))
      
      ;File
      If FileSize(sCurrFile) > 0
        PlayList_AddFile(sCurrFile)
      EndIf
      ;Folder
      If FileSize(sCurrFile) = -2
        PathAddBackslash_(@sCurrFile)
        PlayList_AddFolder(sCurrFile, Pref\recursivfolder)
      EndIf
      
    Next
  EndIf
EndProcedure

;Procedure PlayList_CopyCallback(TotalFileSize, TotalBytesTransferred, StreamSize, StreamBytesTransferred, dwStreamNumber, dwCallbackReason, hSourceFile, hDestinationFile, lpData)
;EndProcedure

Procedure PlayList_CopyFiles()
  If GetGadgetState(#G_LI_Main_PL_PlayList) > -1
    Protected sFolder.s, iNext.i
    
    Protected sSourceFile.s, sTargetFile.s
    
    sFolder = PathRequester("Kopieren Nach:", MyMusicDirectory())
    If sFolder
      ForEach PlayList()
        
        If GetGadgetItemState(#G_LI_Main_PL_PlayList, ListIndex(PlayList())) & #PB_ListIcon_Selected
          CopyFile(PlayList()\tag\file, sFolder + GetFilePart(PlayList()\tag\file))
          
          ; sSourceFile = PlayList()\tag\file
          ; sTargetFile = sFolder + GetFilePart(PlayList()\tag\file)
          ; CopyFileEx_(@sSourceFile, @sTargetFile, @PlayList_CopyCallback(), 0, 0, 0)
        EndIf
        
        While WindowEvent() : Wend
      Next
    EndIf
    
  EndIf
EndProcedure

; Fügt Dateien in der Wiedergabeliste aus der Zwischenablage ein
Procedure PlayList_InsertClipboardFiles()
  If OpenClipboard_(0)
    Protected hClipboard.i
    Protected iAmount.i
    Protected iNext.i
    Protected sBuffer.s = Space(#MAX_PATH)
    
    hClipboard = GetClipboardData_(#CF_HDROP)
    If hClipboard
      iAmount = DragQueryFile_(hClipboard, $FFFFFFFF, 0, 0)
      If iAmount > 0
        For iNext = 0 To iAmount - 1
          DragQueryFile_(hClipboard, iNext, @sBuffer, #MAX_PATH)
          PlayList_AddFile(sBuffer)
        Next
      EndIf
    EndIf
    
    CloseClipboard_()
  EndIf
EndProcedure

Procedure PlayList_RefreshTrackInfo()
  Protected Tag._Tag, iNext.i
  
  ForEach PlayList()
    If GetGadgetItemState(#G_LI_Main_PL_PlayList, ListIndex(PlayList())) & #PB_ListIcon_Selected
      Tag\file = PlayList()\tag\file
      
      If MetaData_ReadData(Tag) <> 0
        PlayList()\tag\title  = Tag\title
        PlayList()\tag\artist = Tag\artist
        PlayList()\tag\album  = Tag\album
        PlayList()\tag\track  = Tag\track
        PlayList()\tag\length = Tag\length
        PlayList()\tag\year   = Tag\year
        PlayList_AddItem(PlayList()\tag\title, PlayList()\tag\artist, PlayList()\tag\album, PlayList()\tag\track, PlayList()\tag\length, PlayList()\tag\year, PlayList()\tag\cType, ListIndex(PlayList()))
      EndIf
      
    EndIf
  Next
EndProcedure

; Erstellt eine Wiedergabeliste
Procedure PlayList_Generate()
  If IsWindow(#Win_PlaylistGenerator)
    Protected sWordFilter.s, iCount.i, iNext.i, iAddBool.i, qAmount.q, qTime.q, qCurrTime.q, iFailed.i, qAdded.q
    Protected T._Tag
    
    Protected NewList WordFilter.s()
    Protected NewList GenreFilter.s()
    Protected NewList MediaLibIndex._GeneratedPlayList()
    
    ; Word Filter
    sWordFilter = Trim(LCase(GetGadgetText(#G_SR_PlaylistGenerator_WordFilter)))
    iCount      = CountString(sWordFilter, "|")
    For iNext = 1 To iCount + 1
      AddElement(WordFilter())
      WordFilter() = StringField(sWordFilter, iNext, "|")
    Next
    
    ; Amount
    qAmount = Val(GetGadgetText(#G_SR_PlaylistGenerator_Amount))
    
    ; Time
    qTime = GetGadgetState(#G_CB_PlaylistGenerator_Time) - Date(1970,1,1,0,0,0)
    
    ; Genre Filter
    For iNext = 0 To ArraySize(MP3Genre())
      If GetGadgetItemState(#G_LV_PlaylistGenerator_GenreFilter, iNext) & #PB_ListIcon_Selected
        AddElement(GenreFilter())
        GenreFilter() = LCase(MP3Genre(iNext))
      EndIf
    Next
    
    ; Eingegebene Anzahl Überprüfen
    If GetGadgetState(#G_OP_PlaylistGenerator_Amount) And qAmount <= 0 And qAmount <> -1
      MsgBox_Exclamation("Bitte geben Sie einen Wert größer 0 bei 'Anzahl' ein." + #CR$ + "Dieser bestimmt wieviel Einträge die generierte" + #CR$ + "Wiedergabeliste beeinhalten soll." + #CR$ + #CR$ + "Wenn die neue Liste alle gefunden Titel beeinhalten soll," + #CR$ + "so benutzen sie als Anzahl -1.", "Ungültige Eingabe")
      ProcedureReturn -1
    EndIf
    ; Eingegebene Zeit überprüfen
    If GetGadgetState(#G_OP_PlaylistGenerator_Time) And qTime <= 0
      MsgBox_Exclamation("Bitte geben Sie die Gesamtdauer der Wiedergabeliste ein.", "Ungültige Eingabe")
      ProcedureReturn -1
    EndIf
    
    ; Suchen
    SetGadgetText(#G_TX_PlaylistGenerator_Progress, "Durchsuche Medienbibliothek..")
    
    DisableGadget(#G_BN_PlaylistGenerator_Cancel, 1)
    DisableGadget(#G_BN_PlaylistGenerator_Create, 1)
    HideGadget(#G_PB_PlaylistGenerator_Progress, 0)
    
    LockMutex(MediaLibScan\Mutex)
    
    ForEach MediaLibary()
      iAddBool = 0
      
      If GetGadgetState(#G_PB_PlaylistGenerator_Progress) <> (ListIndex(MediaLibary()) * 100) / ListSize(MediaLibary())
        SetGadgetState(#G_PB_PlaylistGenerator_Progress, (ListIndex(MediaLibary()) * 100) / ListSize(MediaLibary()))
      EndIf
      
      ; WordFilter
      If GetGadgetState(#G_CH_PlaylistGenerator_WordFilter)
        ForEach WordFilter()
          If FindString(LCase(MediaLibary()\tag\title), WordFilter(), 1)
            iAddBool = 1
          ElseIf FindString(LCase(MediaLibary()\tag\artist), WordFilter(), 1)
            iAddBool = 1
          ElseIf FindString(LCase(MediaLibary()\tag\album), WordFilter(), 1)
            iAddBool = 1
          ElseIf FindString(LCase(MediaLibary()\tag\comment), WordFilter(), 1)
            iAddBool = 1
          ElseIf FindString(LCase(MediaLibary()\tag\file), WordFilter(), 1)
            iAddBool = 1
          EndIf
        Next
      EndIf
      
      ; Genre Filter
      If GetGadgetState(#G_CH_PlaylistGenerator_GenreFilter)
        iAddBool = 0
        ForEach GenreFilter()
          If LCase(MediaLibary()\tag\genre) = GenreFilter()
            iAddBool = 1
          EndIf
        Next
      EndIf
      
      If GetGadgetState(#G_CH_PlaylistGenerator_WordFilter) = 0 And GetGadgetState(#G_CH_PlaylistGenerator_GenreFilter) = 0
        iAddBool = 1
      EndIf
      
      If GetGadgetState(#G_CH_PlaylistGenerator_OnlyPlayed)
        If MediaLibary()\playcount = 0 Or MediaLibary()\lastplay = 0
          iAddBool = 0
        EndIf
      EndIf
      
      ; Add
      If iAddBool
        AddElement(MediaLibIndex())
        MediaLibIndex()\index  = ListIndex(MediaLibary())
        MediaLibIndex()\random = Random(30000)
        qCurrTime + MediaLibary()\tag\length
      EndIf
      
      While WindowEvent() : Wend
    Next
    
    ; CheckResult
    If (GetGadgetState(#G_OP_PlaylistGenerator_Amount) And ListSize(MediaLibIndex()) < qAmount) Or (GetGadgetState(#G_OP_PlaylistGenerator_Time) And qCurrTime < qTime)
      MsgBox_Exclamation("Es konnten nicht genügend Einträge nach ihren Suchkriterien gefunden werden.")
      iFailed = 1
    EndIf
    
    If iFailed
      ; Failed - Reset Window
      DisableGadget(#G_BN_PlaylistGenerator_Cancel, 0)
      DisableGadget(#G_BN_PlaylistGenerator_Create, 0)
      SetGadgetState(#G_PB_PlaylistGenerator_Progress, 0)
      HideGadget(#G_PB_PlaylistGenerator_Progress, 1)
      SetGadgetText(#G_TX_PlaylistGenerator_Progress, "Klicken Sie auf 'Erstellen' um eine Wiedergabeliste zu generieren.")
    Else
      ; CreatePlayList
      SetGadgetText(#G_TX_PlaylistGenerator_Progress, "Erstelle Wiedergabeliste..")
      
      ; Sortieren
      SortStructuredList(MediaLibIndex(), #PB_Sort_Ascending, OffsetOf(_GeneratedPlayList\random), #PB_Sort_Integer)
      
      ; Falls erwünscht, PlayList leeren
      If GetGadgetState(#G_CH_PlaylistGenerator_OnlyAdd) = 0
        PlayList_Remove(-1)
      EndIf
      
      qCurrTime = 0 ; Gesamtlänge, zur überprüfung ob bereits Zeitlimit erreicht ist!
      qAdded    = 0 ; hinzugefügte Elemente, zur überprüfung ob Limit erreicht wurde
      
      SetGadgetState(#G_PB_PlaylistGenerator_Progress, 0)
      
      ForEach MediaLibIndex()
        
        If GetAsyncKeyState_(#VK_ESCAPE)
          Break
        EndIf
        If GetGadgetState(#G_OP_PlaylistGenerator_Amount) = 1 And qAdded >= qAmount And qAmount > -1
          Break
        EndIf
        If GetGadgetState(#G_OP_PlaylistGenerator_Time) = 1 And qCurrTime > qTime
          Break
        EndIf
        
        ; Prozentstatus aktualisieren
        If GetGadgetState(#G_OP_PlaylistGenerator_Amount) = 1
          If qAmount = -1
            If GetGadgetState(#G_PB_PlaylistGenerator_Progress) <> ListIndex(MediaLibIndex()) * 100 / ListSize(MediaLibIndex())
              SetGadgetState(#G_PB_PlaylistGenerator_Progress, ListIndex(MediaLibIndex()) * 100 / ListSize(MediaLibIndex()))
            EndIf
          Else
            If GetGadgetState(#G_PB_PlaylistGenerator_Progress) <> qAdded * 100 / qAmount
              SetGadgetState(#G_PB_PlaylistGenerator_Progress, qAdded * 100 / qAmount)
            EndIf
          EndIf
        Else
          If GetGadgetState(#G_PB_PlaylistGenerator_Progress) <> qCurrTime * 100 / qTime
            SetGadgetState(#G_PB_PlaylistGenerator_Progress, qCurrTime * 100 / qTime)
          EndIf
        EndIf
        
        ; Hinzufügen
        If ListSize(MediaLibary()) >= MediaLibIndex()\index
          SelectElement(MediaLibary(), MediaLibIndex()\index)
          
          T\file    = MediaLibary()\tag\file
          T\title   = MediaLibary()\tag\title
          T\artist  = MediaLibary()\tag\artist
          T\album   = MediaLibary()\tag\album
          T\track   = MediaLibary()\tag\track
          T\year    = MediaLibary()\tag\year
          T\cType   = MediaLibary()\tag\cType
          T\length  = MediaLibary()\tag\length
          
          PlayList_AddFileFast(@T)
          
          qCurrTime + MediaLibary()\tag\length
          qAdded + 1
        EndIf
        
        While WindowEvent(): Wend
      Next
      
      CloseWindow_PlayListGenerator()
    EndIf
    
    ClearList(WordFilter())
    ClearList(GenreFilter())
    ClearList(MediaLibIndex())
    
    Playlist_RefreshAllTimes()
    PlayList_RefreshHeader()
    
    UnlockMutex(MediaLibScan\Mutex)
  EndIf
EndProcedure

; Öffnet das Metadata Info Fenster aus der Playlist
Procedure PlayList_Info()
  Protected iSel.i, Tag._Tag
  
  iSel = GetGadgetState(#G_LI_Main_PL_PlayList)
  If iSel > -1 And ListSize(PlayList()) >= iSel
    SelectElement(PlayList(), iSel)
    
    Tag\file = PlayList()\tag\file
    
    If MetaData_ReadData(Tag) <> 0
      OpenWindow_Metadata()
      MetaData_RefreshWindow(Tag)
    EndIf
  EndIf
EndProcedure

; Berechnet die Bewertung eines Titels
Procedure.i MediaLib_CalcRating()
  Protected iRating.i
  Protected iEntryAmount.i
  Protected iPlayCounter.i
  Protected fAvPlayCount.f
  
  LockMutex(MediaLibScan\Mutex)
  
  iEntryAmount = ListSize(MediaLibary())
  
  ForEach MediaLibary()
    If MediaLibary()\playcount > 0
      iPlayCounter + MediaLibary()\playcount
    EndIf
  Next
  
  UnlockMutex(MediaLibScan\Mutex)
  
  ProcedureReturn iRating
EndProcedure

Procedure MediaLib_RefreshStatusText()
  Protected sText.s
  
  sText = " " + Str(CountGadgetItems(#G_LI_Main_ML_MediaLib))
  
  StatusBarText(#Statusbar_Main, #SBField_MediaLibary, sText)
EndProcedure

Procedure MediaLib_RefreshHeader()
  If Pref\autoclnw_ml > 0
    Protected iNext.i
    
    For iNext = 0 To #MediaLib_Column_Last
      SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_SETCOLUMNWIDTH, iNext, #LVSCW_AUTOSIZE_USEHEADER)
    Next
  EndIf
EndProcedure

Procedure MediaLib_AddItem(Title$, Artist$, Album$, Track, Length, Year, PlayCount, FirstPlay, LastPlay, Rating, Type, Sel)
  
  ; Item hinzufügen
  If Sel < 0
    AddGadgetItem(#G_LI_Main_ML_MediaLib, -1, "")
    Sel = CountGadgetItems(#G_LI_Main_ML_MediaLib) - 1
  EndIf
  
  If CountGadgetItems(#G_LI_Main_ML_MediaLib) >= Sel
    ;Title
    SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, Trim(Title$), #MediaLib_Column_Title)
    ;Artist
    SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, Trim(Artist$), #MediaLib_Column_Interpret)
    ;Album
    SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, Trim(Album$), #MediaLib_Column_Album)
    ;Track
    If Track > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, Str(Track), #MediaLib_Column_Track)
    Else
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, "", #MediaLib_Column_Track)
    EndIf
    ;Length
    If Length > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, TimeString(Length), #MediaLib_Column_Length)
    Else
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, "", #MediaLib_Column_Length)
    EndIf
    ;Year
    If Year > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, Str(Year), #MediaLib_Column_Year)
    Else
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, "", #MediaLib_Column_Year)
    EndIf
    ;PlayCount
    If PlayCount > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, Str(PlayCount), #MediaLib_Column_PlayCount)
    Else
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, "", #MediaLib_Column_PlayCount)
    EndIf
    ; Erste Wiedergabe
    If FirstPlay > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, FormatDate("%dd.%mm.%yy %hh:%ii:%ss", FirstPlay), #MediaLib_Column_FirstPlay)
    Else
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, "", #MediaLib_Column_FirstPlay)
    EndIf
    ; Letzte Wiedergabe
    If LastPlay > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, FormatDate("%dd.%mm.%yy %hh:%ii:%ss", LastPlay), #MediaLib_Column_LastPlay)
    Else
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, "", #MediaLib_Column_LastPlay)
    EndIf
    ; Bewertung
    If Rating > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, Str(Rating), #MediaLib_Column_Rating)
    EndIf
    ; Type
    If Type > 0
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, MetaData_GetFormatString(Type, 0), #MediaLib_Column_Type)
    Else
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, Sel, "", #MediaLib_Column_Type)
    EndIf
  EndIf
EndProcedure

Procedure MediaLib_AddFile(File$, IncrasePlayCounter = 0)
  Protected iResult.i
  Protected iIndex.i
  Protected iPercent.i
  Protected Tag._Tag
  
  LockMutex(MediaLibScan\Mutex)
  
  ForEach MediaLibary()
    If LCase(MediaLibary()\tag\file) = LCase(File$)
      iIndex = ListIndex(MediaLibary()) + 1
      Break
    EndIf
  Next
  
  Tag\file = File$
  If MetaData_ReadData(Tag) = 1
    
    If iIndex = 0
      If ListSize(MediaLibary()) >= #MaxMediaLibSize
        UnlockMutex(MediaLibScan\Mutex)
        ProcedureReturn 0
      EndIf
      LastElement(MediaLibary())
      AddElement(MediaLibary())
    Else
      SelectElement(MediaLibary(), iIndex - 1)
    EndIf
    
    MediaLibary()\tag\file        = File$
    MediaLibary()\tag\title       = Tag\title
    MediaLibary()\tag\artist      = Tag\artist
    MediaLibary()\tag\album       = Tag\album
    MediaLibary()\tag\year        = Tag\year
    MediaLibary()\tag\comment     = Tag\comment
    MediaLibary()\tag\track       = Tag\track
    MediaLibary()\tag\genre       = Tag\genre
    MediaLibary()\tag\bitrate     = Tag\bitrate
    MediaLibary()\tag\samplerate  = Tag\samplerate
    MediaLibary()\tag\channels    = Tag\channels
    MediaLibary()\tag\length      = Tag\length
    MediaLibary()\tag\cType       = Tag\cType
    
    If iIndex = 0
      MediaLibary()\added = Date()
    EndIf
    
    If IncrasePlayCounter
      MediaLibary()\playcount + 1
      If MediaLibary()\firstplay = 0
        MediaLibary()\firstplay = Date()
      EndIf
      MediaLibary()\lastplay = Date()
    EndIf
    
    iResult = 1
  Else
    iResult = 0
  EndIf
  
  UnlockMutex(MediaLibScan\Mutex)
  
  ProcedureReturn iResult
EndProcedure

Procedure MediaLib_AddInetStream(URL$ = "")
  Protected iExist.i
  
  If Trim(URL$) = ""
    URL$ = InputRequester("Internet Stream hinzufügen", "Adresse:", "http://")
    URL$ = Trim(URL$)
  EndIf
  
  If LCase(Left(URL$, 7)) = "http://" And Len(URL$) > 7
    LockMutex(MediaLibScan\Mutex)
    
    ForEach MediaLibary()
      If LCase(MediaLibary()\tag\file) = LCase(URL$)
        iExist = 1
        Break
      EndIf
    Next
    
    If iExist = 0
      LastElement(MediaLibary())
      AddElement(MediaLibary())
      MediaLibary()\tag\file = URL$
      
      If GetGadgetState(#G_LV_Main_ML_Category) = #MediaLib_Categorie_Internet
        AddGadgetItem(#G_LI_Main_ML_MediaLib, -1, "")
        SetGadgetItemText(#G_LI_Main_ML_MediaLib, CountGadgetItems(#G_LI_Main_ML_MediaLib) - 1, URL$, #MediaLib_Column_URL)
      
        LastElement(MediaLibarySearch())
        AddElement(MediaLibarySearch())
        MediaLibarySearch()\file = URL$
        MediaLibarySearch()\index = ListIndex(MediaLibary())
      EndIf
      
    EndIf
    
    UnlockMutex(MediaLibScan\Mutex)
  EndIf

EndProcedure

Procedure MediaLib_CheckFiles()
  Protected sMainFolder.s, iDelBool.i
  
  LockMutex(MediaLibScan\Mutex)
  
  ForEach MediaLibary()
    iDelBool = 0
    
    ; Check InternetStream
    If UCase(Left(MediaLibary()\tag\file, 7)) = "HTTP://" Or UCase(Left(MediaLibary()\tag\file, 6)) = "FTP://"
      iDelBool = -1
    EndIf
    
    If iDelBool = 0
      
      ; Ordner Überprüfen
      LockMutex(MediaLibScan\MutexRF)
      ForEach MediaLib_Path()
        If LCase(MediaLib_Path()) = GetFilePart(MediaLibary()\tag\file)
          iDelBool = 1
          Break
        EndIf
      Next
      UnlockMutex(MediaLibScan\MutexRF)
      
      ; Datei überprüfen
      If iDelBool = 0
        If FileSize(MediaLibary()\tag\file) < 1
          iDelBool = 1
        EndIf
      EndIf
      
    EndIf
    
    ; Remove
    If iDelBool = 1
      DeleteElement(MediaLibary())
    EndIf
    
    If MediaLibScan\Cancel : Break : EndIf
  Next
  
  UnlockMutex(MediaLibScan\Mutex)
EndProcedure

Procedure MediaLib_ScanFolderRecursive(Folder$)
  Protected iDirectory.i
  Protected sCurrEntry.s
  
  iDirectory = ExamineDirectory(#PB_Any, Folder$, "*.*")
  If iDirectory
    
    While NextDirectoryEntry(iDirectory)
      sCurrEntry = DirectoryEntryName(iDirectory)
      
      MediaLibScan\CurrState = Folder$
      
      If Pref\medialib_cpugentle : Delay(100) : EndIf
      
      If DirectoryEntryType(iDirectory) = #PB_DirectoryEntry_Directory
        ; Ordner
        If sCurrEntry <> "." And sCurrEntry <> ".."
          MediaLib_ScanFolderRecursive(Folder$ + sCurrEntry + "\")
        EndIf
      Else
        ; Datei
        If Pref\medialib_startcheck
          If FindMapElement(FileType(), UCase(GetExtensionPart(sCurrEntry)))
            MediaLib_AddFile(Folder$ + sCurrEntry)
          EndIf
        Else
          MediaLib_AddFile(Folder$ + sCurrEntry)
        EndIf
      EndIf
      
      If MediaLibScan\Cancel : Break : EndIf
    Wend
    
    FinishDirectory(iDirectory)
  Else
    Log_Add("Ordner '" + Folder$ + "' konnte nicht geöffnet werden", #Log_Warning)
  EndIf  
EndProcedure

Procedure MediaLib_Scan(*Dummy)
  Protected iDirectory.i
  Protected sFile.s
  Protected iNext.i
  Protected sRootFolder.s
  
  ; Fehlerhafte Einträge aus der Datenbank entfernen
  MediaLibScan\CurrState = "Überprüfe Datenbank.."
  MediaLib_CheckFiles()
  
  ; Neue Dateien suchen
  If MediaLibScan\FolderScan
    For iNext = 0 To ListSize(MediaLib_Path()) - 1
      
      LockMutex(MediaLibScan\MutexRF)
        SelectElement(MediaLib_Path(), iNext)
        sRootFolder = MediaLib_Path()
      UnlockMutex(MediaLibScan\MutexRF)
      
      If MediaLibScan\Cancel : Break : EndIf
      
      MediaLib_ScanFolderRecursive(sRootFolder)
    Next
  EndIf  
EndProcedure

Procedure MediaLib_StartScan()
  ; Maximale Dateien erreicht
  If ListSize(MediaLibary()) >= #MaxMediaLibSize
    MsgBox_Exclamation("Ihre Medienbibliothek hat das Limit von '" + Str(#MaxMediaLibSize) + "' erreicht." + #CR$ + "Es werden keine weiteren Dateien hinzugefügt!")
  EndIf
  ; Scanvorgang beginnen
  If ListSize(MediaLib_Path()) > 0
    DisableGadget(#G_BI_Preferences_MediaLib_PathAdd, 1)
    DisableGadget(#G_BI_Preferences_MediaLib_PathRem, 1)
    DisableGadget(#G_BI_Preferences_MediaLib_FindInvalidFiles, 1)
    SetGadgetAttribute(#G_BI_Preferences_MediaLib_Scan, #PB_Button_Image, ImageList(#ImageList_Remove))
    GadgetToolTip(#G_BI_Preferences_MediaLib_Scan, "Abbrechen")
    
    MediaLibScan\Cancel = 0
    MediaLibScan\Thread = CreateThread(@MediaLib_Scan(), 0)
    
    If MediaLibScan\Thread = 0
      MediaLibScan\Thread = -1
      MsgBox_Error("Es konnte kein Thread erzeugt werden!")
    EndIf
  EndIf
EndProcedure

Procedure MediaLib_SortAlbumProc(lParam1, lParam2, lParamSort)
  Protected LVI.LV_ITEM
  Protected sString1.s = Space(255)
  Protected sString2.s = Space(255)
  Protected iResult.i
  
  LVI\iSubItem    = lParamSort
  LVI\cchTextMax  = 255
  
  LVI\pszText = @sString1
  SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #LVM_GETITEMTEXT, lParam1, @LVI)
  LVI\pszText = @sString2
  SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #LVM_GETITEMTEXT, lParam2, @LVI)
  
  iResult = lstrcmpi_(sString1, sString2)
  
  ProcedureReturn iResult
EndProcedure

Procedure MediaLib_FormatPopUp()
  Protected iSel.i, iCount.i
  
  iSel   = GetGadgetState(#G_LI_Main_ML_MediaLib)
  iCount = CountGadgetItems(#G_LI_Main_ML_MediaLib)
  
  If GetGadgetState(#G_LV_Main_ML_Category) = #MediaLib_Categorie_Internet
    
    If iCount > 0
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLib_SelectAll, 0)
    Else
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLib_SelectAll, 1)
    EndIf
    
    If iSel = -1
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLib_Play, 1)
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLibInet_Rem, 1)
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLibInet_Info, 1)
    Else
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLib_Play, 0)
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLibInet_Rem, 0)
      DisableMenuItem(#Menu_MediaLib_Inet, #Mnu_MediaLibInet_Info, 0)
    EndIf
    
  Else
    
    If iCount > 0
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SelectAll, 0)
    Else
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SelectAll, 1)
    EndIf
    
    If iSel = -1
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_Play, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_MoreAlbum, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_MoreInterpret, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_MoreGenre, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_BookmarkAdd, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_BookmarkRem, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SetPlayList, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_RemPlayList, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SendPlayList, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SendPlayListNew, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_ResetPlayCount, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_ResetPlayDates, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SaveAsPlayList, 1)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_Info, 1)
    Else
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_Play, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_MoreAlbum, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_MoreInterpret, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_MoreGenre, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_BookmarkAdd, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_BookmarkRem, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SetPlayList, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_RemPlayList, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SendPlayList, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SendPlayListNew, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_ResetPlayCount, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_ResetPlayDates, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_SaveAsPlayList, 0)
      DisableMenuItem(#Menu_MediaLibary, #Mnu_MediaLib_Info, 0)
    EndIf
    
  EndIf
EndProcedure

Procedure MediaLib_MenuEventOne(EventMenu)
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LI_Main_ML_MediaLib)
  If iSel > -1
    If ListSize(MediaLibarySearch()) >= iSel
      SelectElement(MediaLibarySearch(), iSel)
      
      ; Wiedergabe
      If EventMenu = #Mnu_MediaLib_Play
        Bass_PlayMedia(MediaLibarySearch()\file, #PlayType_MediaLibary)
      EndIf
      
      ; Informationen Anzeigen
      If EventMenu = #Mnu_MediaLib_Info Or EventMenu = #Mnu_MediaLibInet_Info
        Protected Tag._Tag
        
        Tag\file = MediaLibarySearch()\file
        
        If MetaData_ReadData(Tag) <> 0
          OpenWindow_Metadata()
          MetaData_RefreshWindow(Tag)
        EndIf
      EndIf
      
    EndIf
  EndIf
  
EndProcedure

Procedure MediaLib_MenuEventAll(EventMenu, Align = 1)
  If CountGadgetItems(#G_LI_Main_ML_MediaLib) > 0 And ListSize(MediaLibarySearch()) > 0
    If ListSize(MediaLibarySearch()) = CountGadgetItems(#G_LI_Main_ML_MediaLib)
      Protected iAmount.i
      Protected iNext.i
      Protected sFile.s
      Protected iFile.i
      Protected iCounter.i
      
      iAmount = CountGadgetItems(#G_LI_Main_ML_MediaLib)
      
      If Align = 0
        ; ########
        ; Vorwärts
        For iNext = 0 To iAmount
          If GetGadgetItemState(#G_LI_Main_ML_MediaLib, iNext) & #PB_ListIcon_Selected
            If ListSize(MediaLibarySearch()) >= iNext
              SelectElement(MediaLibarySearch(), iNext)
              
              ;...
              
            EndIf
          EndIf
        Next
      Else
        ; #########
        ; Rückwärts
        For iNext = iAmount To 0 Step -1
          If GetGadgetItemState(#G_LI_Main_ML_MediaLib, iNext) & #PB_ListIcon_Selected
            If ListSize(MediaLibarySearch()) >= iNext
              SelectElement(MediaLibarySearch(), iNext)
              
              ; Wiedergabeliste-Zuordnung Entfernen
              If EventMenu = #Mnu_MediaLib_RemPlayList
                LockMutex(MediaLibScan\Mutex)
                If ListSize(MediaLibary()) >= MediaLibarySearch()\index
                  SelectElement(MediaLibary(), MediaLibarySearch()\index)
                  MediaLibary()\playlist = 0
                EndIf
                UnlockMutex(MediaLibScan\Mutex)
              EndIf
              
              ; Lesezeichen Setzen
              If EventMenu = #Mnu_MediaLib_BookmarkAdd
                LockMutex(MediaLibScan\Mutex)
                If ListSize(MediaLibary()) >= MediaLibarySearch()\index
                  SelectElement(MediaLibary(), MediaLibarySearch()\index)
                  MediaLibary()\flags | #MediaLibFlag_Bookmark
                EndIf
                UnlockMutex(MediaLibScan\Mutex)
              EndIf
              
              ; Lesezeichen Entfernen
              If EventMenu = #Mnu_MediaLib_BookmarkRem
                LockMutex(MediaLibScan\Mutex)
                If ListSize(MediaLibary()) >= MediaLibarySearch()\index
                  SelectElement(MediaLibary(), MediaLibarySearch()\index)
                  MediaLibary()\flags &~ #MediaLibFlag_Bookmark
                  If GetGadgetState(#G_LV_Main_ML_Category) = 4
                    RemoveGadgetItem(#G_LI_Main_ML_MediaLib, ListIndex(MediaLibarySearch()))
                    DeleteElement(MediaLibarySearch())
                  EndIf
                EndIf
                UnlockMutex(MediaLibScan\Mutex)
              EndIf
              
              ; Internet Stream Entfernen
              If EventMenu = #Mnu_MediaLibInet_Rem
                LockMutex(MediaLibScan\Mutex)
                
                If ListSize(MediaLibary()) >= MediaLibarySearch()\index
                  SelectElement(MediaLibary(), MediaLibarySearch()\index)
                  
                  If MessageRequester("Entfernen", "Soll der Eintrag wirklich entfernt werden?" + #CR$ + MediaLibary()\tag\title + #CR$ + MediaLibary()\tag\file, #MB_ICONQUESTION|#MB_YESNO) = #IDYES
                    DeleteElement(MediaLibary())
                    RemoveGadgetItem(#G_LI_Main_ML_MediaLib, ListIndex(MediaLibarySearch()))
                    DeleteElement(MediaLibarySearch())
                  EndIf
                  
                EndIf
                
                UnlockMutex(MediaLibScan\Mutex)
              EndIf
              
              ; Wiedergabecounter zurücksetzen
              If EventMenu = #Mnu_MediaLib_ResetPlayCount
                LockMutex(MediaLibScan\Mutex)
                If ListSize(MediaLibary()) >= MediaLibarySearch()\index
                  SelectElement(MediaLibary(), MediaLibarySearch()\index)
                  MediaLibary()\playcount = 0
                  MediaLibary()\rating    = 0
                  If GetGadgetState(#G_LV_Main_ML_Category) = #MediaLib_Categorie_Rating Or GetGadgetState(#G_LV_Main_ML_Category) = #MediaLib_Categorie_MostPlay
                    RemoveGadgetItem(#G_LI_Main_ML_MediaLib, iNext)
                    DeleteElement(MediaLibarySearch())
                  EndIf
                EndIf
                UnlockMutex(MediaLibScan\Mutex)
              EndIf
              
              ; Zuerst/Zuletzt Abgespielt
              If EventMenu = #Mnu_MediaLib_ResetPlayDates
                LockMutex(MediaLibScan\Mutex)
                If ListSize(MediaLibary()) >= MediaLibarySearch()\index
                  SelectElement(MediaLibary(), MediaLibarySearch()\index)
                  MediaLibary()\firstplay = 0
                  MediaLibary()\lastplay  = 0
                  MediaLibary()\rating    = 0
                  If GetGadgetState(#G_LV_Main_ML_Category) = #MediaLib_Categorie_Rating Or GetGadgetState(#G_LV_Main_ML_Category) = #MediaLib_Categorie_LastPlay
                    RemoveGadgetItem(#G_LI_Main_ML_MediaLib, iNext)
                    DeleteElement(MediaLibarySearch())
                  EndIf
                EndIf
                UnlockMutex(MediaLibScan\Mutex)
              EndIf
              
            EndIf
          EndIf
        Next
      EndIf
      
    EndIf
  EndIf
EndProcedure

Procedure MediaLib_SendToPlayList(New = 0)
  If CountGadgetItems(#G_LI_Main_ML_MediaLib) > 0 And ListSize(MediaLibarySearch()) > 0
    If ListSize(MediaLibarySearch()) = CountGadgetItems(#G_LI_Main_ML_MediaLib)
      Protected iAmount.i
      Protected iNext.i
      
      StatusBarText(#Statusbar_Main, #SBField_Process, "Erstelle Wiedergabeliste..")
      
      LockMutex(MediaLibScan\Mutex)
      
      iAmount = CountGadgetItems(#G_LI_Main_ML_MediaLib)
      
      If New > 0
        ClearList(PlayList())
        ClearGadgetItems(#G_LI_Main_PL_PlayList)
      EndIf
      
      For iNext = 0 To iAmount
        If GetGadgetItemState(#G_LI_Main_ML_MediaLib, iNext) & #PB_ListIcon_Selected
          If ListSize(MediaLibarySearch()) >= iNext
            SelectElement(MediaLibarySearch(), iNext)
            
            If ListSize(MediaLibary()) >= MediaLibarySearch()\index
              SelectElement(MediaLibary(), MediaLibarySearch()\index)
              PlayList_AddFileFast(@MediaLibary()\tag)
            EndIf
          EndIf
        EndIf
      Next
      
      StatusBarText(#Statusbar_Main, #SBField_Process, "")
      
      PlayList_RefreshHeader()
      PlayList_RefreshAllTimes()
      
      UnlockMutex(MediaLibScan\Mutex)
    EndIf
  EndIf     
EndProcedure

Procedure MediaLib_AutoComplete()
  If Pref\gui_autocomplete = 1 And Pref\medialib_searchin <> 0
    Protected iItem.i, iItemCount.i, sInput.s, iInputLen.i
    Static iInputLenSave.i
    
    sInput    = LCase(GetGadgetText(#G_SR_Main_ML_Search))
    iInputLen = Len(sInput)
    
    If iInputLen <= iInputLenSave
      iInputLenSave = iInputLen
    ElseIf iInputLen
      LockMutex(MediaLibScan\Mutex)
      ForEach MediaLibary()
        If sInput = LCase(Left(MediaLibary()\tag\title, iInputLen)) And Pref\medialib_searchin & #MediaLib_SearchIn_Title
          SetGadgetText(#G_SR_Main_ML_Search, GetGadgetText(#G_SR_Main_ML_Search) + Mid(MediaLibary()\tag\title, iInputLen + 1))
          ComboBoxGadget_SetSel(#G_SR_Main_ML_Search, iInputLen, -1)
          iInputLenSave = iInputLen
          Break
        ElseIf sInput = LCase(Left(MediaLibary()\tag\artist, iInputLen)) And Pref\medialib_searchin & #MediaLib_SearchIn_Artist
          SetGadgetText(#G_SR_Main_ML_Search, GetGadgetText(#G_SR_Main_ML_Search) + Mid(MediaLibary()\tag\artist, iInputLen + 1))
          ComboBoxGadget_SetSel(#G_SR_Main_ML_Search, iInputLen, -1)
          iInputLenSave = iInputLen
          Break
        ElseIf sInput = LCase(Left(MediaLibary()\tag\album, iInputLen)) And Pref\medialib_searchin & #MediaLib_SearchIn_Album
          SetGadgetText(#G_SR_Main_ML_Search, GetGadgetText(#G_SR_Main_ML_Search) + Mid(MediaLibary()\tag\album, iInputLen + 1))
          ComboBoxGadget_SetSel(#G_SR_Main_ML_Search, iInputLen, -1)
          iInputLenSave = iInputLen
          Break
        ElseIf sInput = LCase(Left(MediaLibary()\tag\genre, iInputLen)) And Pref\medialib_searchin & #MediaLib_SearchIn_Genre
          SetGadgetText(#G_SR_Main_ML_Search, GetGadgetText(#G_SR_Main_ML_Search) + Mid(MediaLibary()\tag\genre, iInputLen + 1))
          ComboBoxGadget_SetSel(#G_SR_Main_ML_Search, iInputLen, -1)
          iInputLenSave = iInputLen
          Break
        ElseIf sInput = LCase(Left(MediaLibary()\tag\comment, iInputLen))  And Pref\medialib_searchin & #MediaLib_SearchIn_Comment
          SetGadgetText(#G_SR_Main_ML_Search, GetGadgetText(#G_SR_Main_ML_Search) + Mid(MediaLibary()\tag\comment, iInputLen + 1))
          ComboBoxGadget_SetSel(#G_SR_Main_ML_Search, iInputLen, -1)
          iInputLenSave = iInputLen
          Break
        EndIf
      Next
      UnlockMutex(MediaLibScan\Mutex)
    EndIf
    
  EndIf
EndProcedure

Procedure MediaLib_ShowMisc()
  ; Gadget leeren
  ClearGadgetItems(#G_LI_Main_ML_Misc)
  ; Redraw deaktivieren
  SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #WM_SETREDRAW, 0, 0)
  ; Einträge hinzufügen
  Select GetGadgetState(#G_CB_Main_ML_MiscType)
    Case 0 ; Album
      ForEach Misc_Album()
        AddGadgetItem(#G_LI_Main_ML_Misc, -1, Misc_Album())
        While WindowEvent(): Wend
      Next
    Case 1 ; Artist
      ForEach Misc_Artist()
        AddGadgetItem(#G_LI_Main_ML_Misc, -1, Misc_Artist())
        While WindowEvent(): Wend
      Next
    Case 2 ; Genre
      ForEach Misc_Genre()
        AddGadgetItem(#G_LI_Main_ML_Misc, -1, Misc_Genre())
        While WindowEvent(): Wend
      Next
    Case 3 ; PlayList
      ForEach MediaLibary_PlayList()
        AddGadgetItem(#G_LI_Main_ML_Misc, -1, MapKey(MediaLibary_PlayList()))
      Next
  EndSelect
  ; Sortieren
  SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #LVM_SORTITEMSEX, 0, @MediaLib_SortAlbumProc())
  ; Redraw aktivieren
  SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #WM_SETREDRAW, 1, 0)
  ; Spaltenbreite korrekt einstellen
  SetGadgetItemAttribute(#G_LI_Main_ML_Misc, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Main_ML_Misc)), 0)
EndProcedure

Procedure MediaLib_ShowDatabase(Filter)
  LockMutex(MediaLibScan\Mutex)
  
  If ListSize(MediaLibary()) > 0
    Protected iAddBool.i
    Protected sSearch.s
    Protected iCount.i
    Protected sSearchWord.s
    Protected iTime.i
    Protected iSel.i
    Protected iPlayList.i
    Protected iCaseSensetive.i
    Protected iWholeWords.i
    Protected iNext.i
    Protected iMaxCount.i
    
    If Pref\medialib_searchin & #MediaLib_SearchIn_CaseSens
      iCaseSensetive = 1
    EndIf
    If Pref\medialib_searchin & #MediaLib_SearchIn_WholeWords
      iWholeWords = 1
    EndIf
    
    Pref\enableworker = 1
    
    iTime = timeGetTime_()
    
    ProcessMessage("Suche..", #ProcessMessage_High, 0)
    
    DisableGadget(#G_LV_Main_ML_Category, 1)
    
    iSel = GetGadgetState(#G_LI_Main_ML_MediaLib)
    
    DisableGadget(#G_SP_Main_ML_Horizontal, 1)
    
    SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #WM_SETREDRAW, 0, 0)
    SendMessage_(GadgetID(#G_LI_Main_ML_Misc),     #WM_SETREDRAW, 0, 0)
    
    ;PlayList
    If Filter = #MediaLib_Show_PlayList
      iPlayList = MediaLibary_PlayList(GetGadgetText(#G_LI_Main_ML_Misc))\id
    EndIf
    
    ;Mehr von
    If Filter = #MediaLib_Show_MoreAlbum Or Filter = #MediaLib_Show_MoreInterpret Or Filter = #MediaLib_Show_MoreGenre And iSel > -1
      If ListSize(MediaLibarySearch()) >= iSel
        SelectElement(MediaLibarySearch(), iSel)
        If ListSize(MediaLibary()) >= MediaLibarySearch()\index
          SelectElement(MediaLibary(), MediaLibarySearch()\index)
          Select Filter
            Case #MediaLib_Show_MoreGenre
              sSearch = LCase(MediaLibary()\tag\genre)
            Case #MediaLib_Show_MoreAlbum
              sSearch = LCase(MediaLibary()\tag\album)
            Case #MediaLib_Show_MoreInterpret
              sSearch = LCase(MediaLibary()\tag\artist)
          EndSelect
        EndIf
      EndIf
    EndIf
    
    ClearGadgetItems(#G_LI_Main_ML_MediaLib)
    ClearList(MediaLibarySearch())
    
    If Filter <> #MediaLib_Show_Misc And Filter <> #MediaLib_Show_PlayList
      ClearMap(Misc_Album())
      ClearMap(Misc_Artist())
      ClearMap(Misc_Genre())
      ClearGadgetItems(#G_LI_Main_ML_Misc)
    EndIf
    
    If Filter = #MediaLib_Show_InternetStreams
      ;Internet
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, -1, "Name", 1)
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, -1, "Adresse", 2)
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, -1, "Genre", 3)
    Else
      ;Other
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, -1, "Titel", 1)
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, -1, "Interpret", 2)
      SetGadgetItemText(#G_LI_Main_ML_MediaLib, -1, "Album", 3)
    EndIf
    
    ;Suche
    If Filter = #MediaLib_Show_Search
      sSearch = Trim(GetGadgetText(#G_SR_Main_ML_Search))
      SetGadgetState(#G_LV_Main_ML_Category, -1)
    EndIf
    
    ;Album
    If Filter = #MediaLib_Show_Misc
      sSearch = LCase(GetGadgetText(#G_LI_Main_ML_Misc))
    EndIf
    
    ;SearchBool
    ForEach MediaLibary()
      iAddBool = 0
      
      Select Filter
        Case #MediaLib_Show_Normal
          iAddBool = 1
        Case #MediaLib_Show_MostPlay
          If MediaLibary()\playcount > 0
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_LastPlay
          If MediaLibary()\lastplay > 0
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_NeverPlay
          If MediaLibary()\playcount = 0 And MediaLibary()\lastplay = 0
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_Longest
          If MediaLibary()\tag\length > 0
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_Rating
          If MediaLibary()\rating > 0
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_Bookmarks
          If MediaLibary()\flags & #MediaLibFlag_Bookmark
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_LastAdded
          If MediaLibary()\added > 0
            iAddBool = 1
          EndIf
        ; Suche
        Case #MediaLib_Show_Search
          If Pref\medialib_searchin & #MediaLib_SearchIn_Played And MediaLibary()\playcount = 0
            iAddBool = 0
          ElseIf Pref\medialib_searchlength[0] > 0 And MediaLibary()\tag\length < Pref\medialib_searchlength[0]
            iAddBool = 0
          ElseIf Pref\medialib_searchlength[1] > 0 And MediaLibary()\tag\length > Pref\medialib_searchlength[1]
            iAddBool = 0
          Else
            iCount = CountString(sSearch, " ") + 1
            For iNext = 1 To iCount
              sSearchWord  = StringField(sSearch, iNext, " ")
              
              If Not Pref\medialib_searchin & #MediaLib_SearchIn_Or
                iAddBool = 0
              EndIf
              
              If Pref\medialib_searchin & #MediaLib_SearchIn_Title
                If CompareString(MediaLibary()\tag\title, sSearchWord, iCaseSensetive, iWholeWords)
                  iAddBool = 1
                EndIf
              EndIf
              If Pref\medialib_searchin & #MediaLib_SearchIn_Artist
                If CompareString(MediaLibary()\tag\artist, sSearchWord, iCaseSensetive, iWholeWords)
                  iAddBool = 1
                EndIf
              EndIf
              If Pref\medialib_searchin & #MediaLib_SearchIn_Album
                If CompareString(MediaLibary()\tag\album, sSearchWord, iCaseSensetive, iWholeWords)
                  iAddBool = 1
                EndIf
              EndIf
              If Pref\medialib_searchin & #MediaLib_SearchIn_Genre
                If CompareString(MediaLibary()\tag\genre, sSearchWord, iCaseSensetive, iWholeWords)
                  iAddBool = 1
                EndIf
              EndIf
              If Pref\medialib_searchin & #MediaLib_SearchIn_Comment
                If CompareString(MediaLibary()\tag\comment, sSearchWord, iCaseSensetive, iWholeWords)
                  iAddBool = 1
                EndIf
              EndIf
              If Pref\medialib_searchin & #MediaLib_SearchIn_Path
                If CompareString(MediaLibary()\tag\file, sSearchWord, iCaseSensetive, iWholeWords)
                  iAddBool = 1
                EndIf
              EndIf
              
              If Pref\medialib_searchin & #MediaLib_SearchIn_Or
                If iAddBool = 1
                  Break
                EndIf
              Else
                If iAddBool = 0
                  Break
                EndIf
              EndIf
              
            Next
          EndIf
        Case #MediaLib_Show_Misc
          Select GetGadgetState(#G_CB_Main_ML_MiscType)
            Case 0 ; Album
              If LCase(MediaLibary()\tag\album) = sSearch : iAddBool = 1 : EndIf
            Case 1 ; Artist
              If LCase(MediaLibary()\tag\artist) = sSearch : iAddBool = 1 : EndIf
            Case 2 ; Genre
              If LCase(MediaLibary()\tag\genre) = sSearch : iAddBool = 1 : EndIf
          EndSelect
        Case #MediaLib_Show_InternetStreams
          If LCase(Left(MediaLibary()\tag\file, 7)) = "http://" Or LCase(Left(MediaLibary()\tag\file, 6)) = "ftp://"
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_MoreInterpret
          If FindString(LCase(MediaLibary()\tag\artist), sSearch, 1)
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_MoreAlbum
          If FindString(LCase(MediaLibary()\tag\album), sSearch, 1)
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_MoreGenre
          If FindString(LCase(MediaLibary()\tag\genre), sSearch, 1)
            iAddBool = 1
          EndIf
        Case #MediaLib_Show_PlayList
          If MediaLibary()\playlist = iPlayList
            iAddBool = 1
          EndIf
      EndSelect
      
      If Filter <> #MediaLib_Show_InternetStreams
        If LCase(Left(MediaLibary()\tag\file, 7)) = "http://" Or LCase(Left(MediaLibary()\tag\file, 6)) = "ftp://"
          iAddBool = 0
        EndIf
      EndIf
      
      ; Hinzufügen
      If iAddBool
        
        ;Normal
        If Filter <> #MediaLib_Show_MostPlay And Filter <> #MediaLib_Show_LastPlay And Filter <> #MediaLib_Show_InternetStreams And Filter <> #MediaLib_Show_Rating And Filter <> #MediaLib_Show_Longest And Filter <> #MediaLib_Show_LastAdded
          iMaxCount + 1
          MediaLib_AddItem(MediaLibary()\tag\title, MediaLibary()\tag\artist, MediaLibary()\tag\album, MediaLibary()\tag\track, MediaLibary()\tag\length, MediaLibary()\tag\year, MediaLibary()\playcount, MediaLibary()\firstplay, MediaLibary()\lastplay, MediaLibary()\rating, MediaLibary()\tag\cType, -1)
        EndIf

        ;InetStream
        If Filter = #MediaLib_Show_InternetStreams
          iMaxCount + 1
          MediaLib_AddItem(MediaLibary()\tag\title, MediaLibary()\tag\file, MediaLibary()\tag\genre, -1, 0, 0, MediaLibary()\playcount, MediaLibary()\firstplay, MediaLibary()\lastplay, MediaLibary()\rating, 0, -1)
        EndIf
        
        ;Filter
        If Filter <> #MediaLib_Show_Misc And Filter <> #MediaLib_Show_InternetStreams
          If MediaLibary()\tag\album
            Misc_Album(MediaLibary()\tag\album) = MediaLibary()\tag\album
          EndIf
          If MediaLibary()\tag\artist
            Misc_Artist(MediaLibary()\tag\artist) = MediaLibary()\tag\artist
          EndIf
          If MediaLibary()\tag\genre
            Misc_Genre(MediaLibary()\tag\genre) = MediaLibary()\tag\genre
          EndIf
        EndIf
        
        AddElement(MediaLibarySearch())
        MediaLibarySearch()\file  = MediaLibary()\tag\file
        MediaLibarySearch()\index = ListIndex(MediaLibary())
        
        Select Filter
          Case #MediaLib_Show_MostPlay  : MediaLibarySearch()\misc = MediaLibary()\playcount
          Case #MediaLib_Show_LastPlay  : MediaLibarySearch()\misc = MediaLibary()\lastplay
          Case #MediaLib_Show_Rating    : MediaLibarySearch()\misc = MediaLibary()\rating
          Case #MediaLib_Show_Longest   : MediaLibarySearch()\misc = MediaLibary()\tag\length
          Case #MediaLib_Show_LastAdded : MediaLibarySearch()\misc = MediaLibary()\added
        EndSelect
        
        If Pref\medialib_searchin & #MediaLib_SearchIn_MaxCount And Pref\medialib_maxsearchcount > 0
          If iMaxCount >= Pref\medialib_maxsearchcount
            Break
          EndIf
        EndIf
      EndIf
      
      While WindowEvent() : Wend
    Next
    
    If Filter = #MediaLib_Show_MostPlay Or Filter = #MediaLib_Show_LastPlay Or Filter = #MediaLib_Show_Rating Or Filter = #MediaLib_Show_Longest Or Filter = #MediaLib_Show_LastAdded
      
      If Filter = #MediaLib_Show_MostPlay
        SortStructuredList(MediaLibarySearch(), #PB_Sort_Descending, OffsetOf(_MediaLibarySearch\misc), #PB_Sort_Integer)
      ElseIf Filter = #MediaLib_Show_LastPlay
        SortStructuredList(MediaLibarySearch(), #PB_Sort_Descending, OffsetOf(_MediaLibarySearch\misc), #PB_Sort_Integer)
      ElseIf Filter = #MediaLib_Show_Rating
        SortStructuredList(MediaLibarySearch(), #PB_Sort_Descending, OffsetOf(_MediaLibarySearch\misc), #PB_Sort_Integer)
      ElseIf Filter = #MediaLib_Show_Longest
        SortStructuredList(MediaLibarySearch(), #PB_Sort_Descending, OffsetOf(_MediaLibarySearch\misc), #PB_Sort_Integer)
      ElseIf Filter = #MediaLib_Show_LastAdded
        SortStructuredList(MediaLibarySearch(), #PB_Sort_Descending, OffsetOf(_MediaLibarySearch\misc), #PB_Sort_Integer)
      EndIf
      
      ForEach MediaLibarySearch()
        iMaxCount + 1
        
        SelectElement(MediaLibary(), MediaLibarySearch()\index)
        MediaLib_AddItem(MediaLibary()\tag\title, MediaLibary()\tag\artist, MediaLibary()\tag\album, MediaLibary()\tag\track, MediaLibary()\tag\length, MediaLibary()\tag\year, MediaLibary()\playcount, MediaLibary()\firstplay, MediaLibary()\lastplay, MediaLibary()\rating, MediaLibary()\tag\cType, -1)
        
        If Pref\medialib_searchin & #MediaLib_SearchIn_MaxCount And Pref\medialib_maxsearchcount > 0
          If iMaxCount >= Pref\medialib_maxsearchcount
            Break
          EndIf
        EndIf
      Next
      
    EndIf
    
    ; Albenliste erzeugen und sortieren
    If Filter <> #MediaLib_Show_Misc And Filter <> #MediaLib_Show_PlayList
      MediaLib_ShowMisc()
    EndIf
    
    ; Einträge zum Suchverlauf der Medienbibliothek hinzufügen
    If Filter = #MediaLib_Show_Search And CountGadgetItems(#G_LI_Main_ML_MediaLib) > 0
      iAddBool = -1
      
      For iNext = 0 To CountGadgetItems(#G_SR_Main_ML_Search) - 1
        If UCase(GetGadgetItemText(#G_SR_Main_ML_Search, iNext)) = UCase(sSearch)
          iAddBool = iNext
        EndIf
      Next
      
      If iAddBool = -1
        While #MaxSize_SHistoryML <= CountGadgetItems(#G_SR_Main_ML_Search)
          RemoveGadgetItem(#G_SR_Main_ML_Search, CountGadgetItems(#G_SR_Main_ML_Search) - 1)
        Wend
        AddGadgetItem(#G_SR_Main_ML_Search, 0, sSearch)
      Else
        RemoveGadgetItem(#G_SR_Main_ML_Search, iAddBool)
        AddGadgetItem(#G_SR_Main_ML_Search, 0, sSearch)
      EndIf
    EndIf
    
    SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #WM_SETREDRAW, 1, 0)
    SendMessage_(GadgetID(#G_LI_Main_ML_Misc), #WM_SETREDRAW, 1, 0)
    
    MediaLib_RefreshHeader()
    
    If Filter = #MediaLib_Show_Search
      SetGadgetText(#G_SR_Main_ML_Search, "")
      DisableGadget(#G_BN_Main_ML_Search, 1)
    EndIf
    
    iTime = timeGetTime_() - iTime
    
    StatusBarText(#Statusbar_Main, #SBField_MediaLibary, " " + Str(CountGadgetItems(#G_LI_Main_ML_MediaLib)) + " (" + Str(iTime) + " ms.)")
    
    Pref\enableworker = 0
  EndIf
  
  If Filter = #MediaLib_Show_PlayList Or Filter = #MediaLib_Show_Misc
    SetGadgetState(#G_LV_Main_ML_Category, -1)
  EndIf
  
  SetGadgetItemAttribute(#G_LI_Main_ML_Misc, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Main_ML_Misc)), 0)
  
  DisableGadget(#G_SP_Main_ML_Horizontal, 0)
  
  ;ProcessMessage_Remove()
  If CountGadgetItems(#G_LI_Main_ML_MediaLib) > 0
    ProcessMessage(Str(CountGadgetItems(#G_LI_Main_ML_MediaLib)) + " Einträge gefunden", #ProcessMessage_High)
  Else
    ProcessMessage("Keine Einträge vorhanden", #ProcessMessage_High)
  EndIf
  
  DisableGadget(#G_LV_Main_ML_Category, 0)
  
  UnlockMutex(MediaLibScan\Mutex)
EndProcedure

Procedure MediaLib_Play()
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LI_Main_ML_MediaLib)
  If iSel > -1 And ListSize(MediaLibarySearch()) >= iSel
    SelectElement(MediaLibarySearch(), iSel)
    
    Bass_PlayMedia(MediaLibarySearch()\file, #PlayType_MediaLibary)
  EndIf
EndProcedure

; Verändert bzw. fügt eine Wiedergabeliste zur Medienbibliothek hinzu
Procedure MediaLib_SetPlayList()
  If IsWindow(#Win_MLPlayList) And GetGadgetState(#G_LI_Main_ML_MediaLib) > -1
    Protected sName.s
    Protected iPlayList.i, iMaxID.i
    
    sName = Trim(GetGadgetText(#G_CB_MLPlayList))
    If sName
      
      ; Wiedergabelisten ID ermitteln
      If FindMapElement(MediaLibary_PlayList(), sName)
        iPlayList = MediaLibary_PlayList(sName)\id
      Else
        iPlayList = 1
        
        ForEach MediaLibary_PlayList()
          If MediaLibary_PlayList()\id >= iPlayList
            iPlayList = MediaLibary_PlayList()\id + 1
          EndIf
        Next
        
        MediaLibary_PlayList(sName)\id = iPlayList
      EndIf
      
      ; Neue Wiedergabeliste in DB eintragen
      LockMutex(MediaLibScan\Mutex)
        ForEach MediaLibarySearch()
          If GetGadgetItemState(#G_LI_Main_ML_MediaLib, ListIndex(MediaLibarySearch())) & #PB_ListIcon_Selected
            If ListSize(MediaLibary()) >= MediaLibarySearch()\index
              SelectElement(MediaLibary(), MediaLibarySearch()\index)
              
              MediaLibary()\playlist = iPlayList
            EndIf
          EndIf
        Next
      UnlockMutex(MediaLibScan\Mutex)
      
      ; Fenster Schließen
      CloseWindow_MLPlayList()
      
      ; Wiedergabelisten aktualisieren
      If GetGadgetState(#G_CB_Main_ML_MiscType) = 3
        MediaLib_ShowMisc()
      EndIf
      
    Else
      MsgBox_Exclamation("Ungültige Wiedergabeliste")
    EndIf
      
  EndIf
EndProcedure

; Entfernt eine Wiedergabeliste aus der Medienbibliothek
Procedure MediaLib_RemovePlayList()
  If IsWindow(#Win_MLPlayList)
    Protected iPlayList.i
    Protected sPlayList.s
    
    sPlayList = Trim(GetGadgetText(#G_CB_MLPlayList))
    If sPlayList
      If FindMapElement(MediaLibary_PlayList(), sPlayList)
        
        If MessageRequester("Wiedergabeliste Entfernen", "Möchten Sie die Wiedergabeliste '" + sPlayList + "' wirklich entfernen?" + #CR$ + "Alle enthaltenen Einträge werden damit entfernt!", #MB_ICONEXCLAMATION|#MB_YESNO|#MB_DEFBUTTON2) = #IDYES
          
          If GetGadgetState(#G_CB_MLPlayList) >= 0
            
            iPlayList = MediaLibary_PlayList(sPlayList)\id

            LockMutex(MediaLibScan\Mutex)
              If MediaLibary()\playlist = iPlayList
                MediaLibary()\playlist = iPlayList
              EndIf
            UnlockMutex(MediaLibScan\Mutex)
            
            RemoveGadgetItem(#G_CB_MLPlayList, GetGadgetState(#G_CB_MLPlayList))
            DeleteMapElement(MediaLibary_PlayList(), sPlayList)
            
            If GetGadgetState(#G_CB_Main_ML_MiscType) = 3
              MediaLib_ShowMisc()
            EndIf
            
          EndIf
          
        EndIf
        
      EndIf
    EndIf
    
  EndIf
EndProcedure

Procedure MediaLib_SavePlayList()
  If CountGadgetItems(#G_LI_Main_ML_MediaLib) > 0 And ListSize(MediaLibarySearch()) > 0
    If ListSize(MediaLibarySearch()) = CountGadgetItems(#G_LI_Main_ML_MediaLib)
      Protected iAmount.i
      Protected iNext.i
      Protected sFile.s
      Protected iFile.i
      Protected iCounter.i
      
      ; Dateiauswahl
      sFile = SaveFileRequester("Wiedergabeliste Speichern", GetCurrentDirectory() + "Neue Wiedergabeliste", "Playlist (*.m3u)|*.m3u|Playlist (*.pls)|*.pls", 0)
      If sFile = ""
        ProcedureReturn 0
      EndIf
      
      ; Erweiterung hinzufügen
      If SelectedFilePattern() = 0 And GetExtensionPart(sFile) = "" : sFile + ".m3u"  : EndIf
      If SelectedFilePattern() = 1 And GetExtensionPart(sFile) = "" : sFile + ".pls"  : EndIf
      
      ; Überschreiben
      If FileSize(sFile) > 0
        If MessageRequester("Überschreiben", "Datei '" + sFile + "' existiert bereits," + #CRLF$ + "soll die Datei überschrieben werden?", #MB_YESNO|#MB_ICONEXCLAMATION) = #IDNO
          ProcedureReturn 0
        EndIf
      EndIf
      
      ; Speichern
      iFile = CreateFile(#PB_Any, sFile)
      If iFile
        
        ; Kopf
        If SelectedFilePattern() = 0
          ; M3U
          WriteStringN(iFile, "#EXTM3U")
        Else
          ; PLS
          WriteStringN(iFile, "[playlist]")
        EndIf
        
        ; Dateiliste
        iAmount = CountGadgetItems(#G_LI_Main_ML_MediaLib)
        
        For iNext = 0 To iAmount
          If GetGadgetItemState(#G_LI_Main_ML_MediaLib, iNext) & #PB_ListIcon_Selected
            If ListSize(MediaLibarySearch()) >= iNext
              SelectElement(MediaLibarySearch(), iNext)
              
              LockMutex(MediaLibScan\Mutex)
              If ListSize(MediaLibary()) >= MediaLibarySearch()\index
                SelectElement(MediaLibary(), MediaLibarySearch()\index)
              
                If SelectedFilePattern() = 0
                  ; M3U
                  WriteStringN(iFile, "#EXTINF:" + Str(MediaLibary()\tag\length) + "," + MediaLibary()\tag\title)
                  WriteStringN(iFile, MediaLibary()\tag\file)
                Else
                  ; PLS
                  iCounter + 1
                  WriteStringN(iFile, "File" + Str(iCounter) + "=" + MediaLibary()\tag\file)
                  WriteStringN(iFile, "Title" + Str(iCounter) + "=" + MediaLibary()\tag\title)
                  WriteStringN(iFile, "Length" + Str(iCounter) + "=" + Str(MediaLibary()\tag\length))
                EndIf
              
              EndIf
              UnlockMutex(MediaLibScan\Mutex)
              
            EndIf
          EndIf
        Next
        
        ; Fuß
        If SelectedFilePattern() = 0
          ; M3U
          
        Else
          ; PLS
          WriteStringN(iFile, "NumberOfEntries=" + Str(iCounter))
          WriteStringN(iFile, "Version=2")
        EndIf
        
        CloseFile(iFile)
      Else
        MsgBox_Exclamation("Datei konnte nicht erstellt werden")
      EndIf
      
    EndIf
  EndIf
EndProcedure

Procedure MediaLib_BackgroundScan(*Dummy)
  Protected iTime.i
  Protected iInetStream.i
  Protected Tag._Tag
  Protected iTagResult.i
  
  Repeat
    If iEndApplication
      Break
    EndIf
    
    If timeGetTime_() - iTime >= 2500 And MediaLibScan\Thread = 0 And Pref\medialib_backgroundscan = 1
      iTime = timeGetTime_()
      
      LockMutex(MediaLibScan\Mutex)
      
      If ListSize(MediaLibary()) > 0
        
        ;Make Curr Index
        If MediaLibScan\BGIndex >= 0 And ListSize(MediaLibary()) - 1 > MediaLibScan\BGIndex
          MediaLibScan\BGIndex + 1
          SelectElement(MediaLibary(), MediaLibScan\BGIndex)
        Else
          MediaLibScan\BGIndex = 0
          FirstElement(MediaLibary())
        EndIf
        
        ;Refresh..
        If ListIndex(MediaLibary()) > -1
          ;Check InetStream
          If LCase(Left(MediaLibary()\tag\file, 7)) = "http://" Or LCase(Left(MediaLibary()\tag\file, 6)) = "ftp://"
            iInetStream = 1
          Else
            iInetStream = 0
          EndIf
          ;Refresh CurrFile
          MediaLibScan\CurrState = MediaLibary()\tag\file
          
          ;RefreshTags
          Tag\file = MediaLibary()\tag\file
          iTagResult = MetaData_ReadData(Tag)
          If iTagResult = 1
            MediaLibary()\tag\title      = Tag\title
            MediaLibary()\tag\artist     = Tag\artist
            MediaLibary()\tag\album      = Tag\album
            MediaLibary()\tag\year       = Tag\year
            MediaLibary()\tag\comment    = Tag\comment
            MediaLibary()\tag\track      = Tag\track
            MediaLibary()\tag\genre      = Tag\genre
            MediaLibary()\tag\bitrate    = Tag\bitrate
            MediaLibary()\tag\samplerate = Tag\samplerate
            MediaLibary()\tag\channels   = Tag\channels
            MediaLibary()\tag\length     = Tag\length
          ElseIf iTagResult = 2
            ; Internet Stream
          Else
            DeleteElement(MediaLibary(), 1)
            If MediaLibScan\BGIndex > 0
              MediaLibScan\BGIndex - 1
            EndIf
          EndIf
          
        EndIf
      EndIf
      
      UnlockMutex(MediaLibScan\Mutex)
    Else
      Delay(500)
    EndIf
    
  ForEver
EndProcedure

Procedure Window_RefreshTaskBar()
  Protected iVisible.i = IsWindowVisible_(WindowID(#Win_Main))
  
  If Pref\taskbar
    If iVisible : HideWindow(#Win_Main, 1) : EndIf
    SetWindowLong_(WindowID(#Win_Main), #GWL_HWNDPARENT, 0)
    If iVisible : HideWindow(#Win_Main, 0) : EndIf
  Else
    If GetWindowState(#Win_Main) = #PB_Window_Minimize
      SetWindowState(#Win_Main, #PB_Window_Normal)
    EndIf
    SetWindowLong_(WindowID(#Win_Main), #GWL_HWNDPARENT, WindowID(#Win_Hide))
  EndIf
EndProcedure

Procedure Window_ResizeGadgets(Window)
  Select Window
    ; Main
    Case -1, #Win_Main, WinSize(#Win_Main)\winid
      ; Main
      ResizeGadget(#G_CN_Main_IA_Background, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main), #PB_Ignore)
      ResizeGadget(#G_TX_Main_IA_InfoCont1, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 275, #PB_Ignore)
      ResizeGadget(#G_TX_Main_IA_InfoCont2, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 275, #PB_Ignore)
      ResizeGadget(#G_TX_Main_IA_InfoCont3, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 275, #PB_Ignore)
      ResizeGadget(#G_TX_Main_IA_InfoCont4, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 275, #PB_Ignore)
      ResizeGadget(#G_TX_Main_IA_LengthC, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 275, #PB_Ignore)
      ResizeGadget(#G_IG_Main_IA_PrgLogo, WindowWidth(#Win_Main) - 60, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      SetGadgetState(#G_IG_Main_IA_PrgLogo, iImgInfologo)
      ResizeGadget(#G_IG_Main_IA_Spectrum, WindowWidth(#Win_Main) - 210, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_FR_Main_IA_Gap, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) + 10, #PB_Ignore)
      ResizeGadget(#G_TB_Main_IA_Position, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main), #PB_Ignore)
      ; Playlist
      ResizeGadget(#G_LI_Main_PL_PlayList, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 5, WindowHeight(#Win_Main) - GadgetHeight(#G_CN_Main_IA_Background) - GadgetHeight(#G_CN_Main_IA_ToolbarLeft) - GadgetHeight(#G_TB_Main_IA_Position) - GadgetHeight(#G_FR_Main_IA_Gap) - StatusBarHeight(#Statusbar_Main) - 10)
      ; MediaLibary
      ResizeGadget(#G_SR_Main_ML_Search, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 138, 20)
      ResizeGadget(#G_BN_Main_ML_Search, WindowWidth(#Win_Main) - 134, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_BN_Main_ML_SearchOptions, WindowWidth(#Win_Main) - 52, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_SP_Main_ML_Horizontal, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Main) - 4, WindowHeight(#Win_Main) - GadgetHeight(#G_CN_Main_IA_Background) - GadgetHeight(#G_CN_Main_IA_ToolbarLeft) - GadgetHeight(#G_TB_Main_IA_Position) - GadgetHeight(#G_FR_Main_IA_Gap) - StatusBarHeight(#Statusbar_Main) - GadgetHeight(#G_SR_Main_ML_Search) - 12)
      ResizeGadget(#G_CB_Main_ML_MiscType, #PB_Ignore, #PB_Ignore, GadgetWidth(#G_CN_Main_ML_Misc), #PB_Ignore)
      ResizeGadget(#G_LI_Main_ML_Misc, #PB_Ignore, #PB_Ignore, GadgetWidth(#G_CN_Main_ML_Misc), GadgetHeight(#G_CN_Main_ML_Misc) - 25)
      SetGadgetItemAttribute(#G_LI_Main_ML_Misc, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Main_ML_Misc)), 0)
    ; Log
    Case -1, #Win_Log, WinSize(#Win_Log)\winid
      ResizeGadget(#G_LI_Log_Overview, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Log) - 4, WindowHeight(#Win_Log) - 4)
        SetGadgetItemAttribute(#G_LI_Log_Overview, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Log_Overview)), 0)
      SendMessage_(GadgetID(#G_LI_Log_Overview), #LVM_ENSUREVISIBLE, CountGadgetItems(#G_LI_Log_Overview) - 1, 1)
    ; PathRequester
    Case -1, #Win_PathRequester, WinSize(#Win_PathRequester)\winid
      ResizeGadget(#G_ET_PathRequester_Overview, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_PathRequester) - 10, WindowHeight(#Win_PathRequester) - 40)
      ResizeGadget(#G_CH_PathRequester_Recursive, #PB_Ignore, WindowHeight(#Win_PathRequester) - 25, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_BN_PathRequester_Apply, WindowWidth(#Win_PathRequester) - 170, WindowHeight(#Win_PathRequester) - 30, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_BN_PathRequester_Cancel, WindowWidth(#Win_PathRequester) - 85, WindowHeight(#Win_PathRequester) - 30, #PB_Ignore, #PB_Ignore)
    ; Search
    Case -1, WinSize(#Win_Search)\winid
      ResizeGadget(#G_SR_Search_String, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Search) - 80, #PB_Ignore)
      ResizeGadget(#G_BN_Search_Start, WindowWidth(#Win_Search) - 70, #PB_Ignore, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_LV_Search_Result, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Search) - 10, WindowHeight(#Win_Search) - 60)
    ; RadioTrackLog
    Case -1, WinSize(#Win_RadioLog)\winid
      ResizeGadget(#G_TX_RadioLog_DownloadedV, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_RadioLog) - GadgetWidth(#G_TX_RadioLog_Downloaded) - 6, #PB_Ignore)
      ResizeGadget(#G_LI_RadioLog_Overview, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_RadioLog) - 4, WindowHeight(#Win_RadioLog) - 21)
        SetGadgetItemAttribute(#G_LI_RadioLog_Overview, -1, #PB_ListIcon_ColumnWidth, GadgetWidth(#G_LI_RadioLog_Overview) / 2, 0)
        SendMessage_(GadgetID(#G_LI_RadioLog_Overview), #LVM_SETCOLUMNWIDTHA, 1, #LVSCW_AUTOSIZE_USEHEADER)
    ; MidiLyrics
    Case -1, WinSize(#Win_MidiLyrics)\winid
      ResizeGadget(#G_ED_MidiLyrics_Text, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_MidiLyrics) - 4, WindowHeight(#Win_MidiLyrics) - 4)
    ; MLPlayList
    Case -1, WinSize(#Win_MLPlayList)\winid
      ResizeGadget(#G_CB_MLPlayList, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_MLPlayList) - 10, #PB_Ignore)
      ResizeGadget(#G_BN_MLPlayList_Set, WindowWidth(#Win_MLPlayList) - 85, #PB_Ignore, #PB_Ignore, #PB_Ignore)
    ; Feedback
    Case -1, WinSize(#Win_Feedback)\winid
      ResizeGadget(#G_SR_Feedback_Message, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Feedback) - 10, WindowHeight(#Win_Feedback) - 137)
      ResizeGadget(#G_FR_Feedback_Gap, #PB_Ignore, WindowHeight(#Win_Feedback) - 37, WindowWidth(#Win_Feedback) + 10, #PB_Ignore)
      ResizeGadget(#G_BN_Feedback_Reset, WindowWidth(#Win_Feedback) - 275, WindowHeight(#Win_Feedback) - 30, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_BN_Feedback_Send, WindowWidth(#Win_Feedback) - 170, WindowHeight(#Win_Feedback) - 30, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_BN_Feedback_Cancel, WindowWidth(#Win_Feedback) - 85, WindowHeight(#Win_Feedback) - 30, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_HL_Feedback_URL, #PB_Ignore, WindowHeight(#Win_Feedback) - 20, #PB_Ignore, #PB_Ignore)
      ResizeGadget(#G_IG_Feedback_Message, WindowWidth(#Win_Feedback) - 21, #PB_Ignore, #PB_Ignore, #PB_Ignore)
  EndSelect
EndProcedure

Procedure Window_ChangeColor()
 ;InfoArea
 SetGadgetColor(#G_TX_Main_IA_InfoDesc1, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoDesc1, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_InfoDesc2, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoDesc2, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_InfoDesc3, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoDesc3, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_InfoDesc4, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoDesc4, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_Length, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_Length, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 
 SetGadgetColor(#G_TX_Main_IA_InfoCont1, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoCont1, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_InfoCont2, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoCont2, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_InfoCont3, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoCont3, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_InfoCont4, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_InfoCont4, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 SetGadgetColor(#G_TX_Main_IA_LengthC, #PB_Gadget_FrontColor, Pref\color[#Color_TrackInfo_FG])
 SetGadgetColor(#G_TX_Main_IA_LengthC, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 
 SetGadgetColor(#G_CN_Main_IA_Background, #PB_Gadget_BackColor, Pref\color[#Color_TrackInfo_BG])
 
 If CurrPlay\channel[CurrPlay\curr] <> 0 And CurrPlay\playtype = #PlayType_PlayList
   If BASS_ChannelIsActive(CurrPlay\channel[CurrPlay\curr]) <> #BASS_ACTIVE_STOPPED
     SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
     SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
   EndIf
 EndIf
 
 If IsWindow(#Win_MidiLyrics)
   SetGadgetColor(#G_ED_MidiLyrics_Text, #PB_Gadget_BackColor, Pref\color[#Color_Midi_BG])
   SetGadgetColor(#G_ED_MidiLyrics_Text, #PB_Gadget_FrontColor, Pref\color[#Color_Midi_FG])
 EndIf
EndProcedure

Procedure Window_ChangeFonts()
  ; Infobereich
  If GUIFont(#Font_InfoArea)\activ And IsFont(#Font_InfoArea)
    SetGadgetFont(#G_TX_Main_IA_InfoCont1, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_InfoCont2, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_InfoCont3, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_InfoCont4, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_InfoDesc1, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_InfoDesc2, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_InfoDesc3, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_InfoDesc4, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_Length, FontID(#Font_InfoArea))
    SetGadgetFont(#G_TX_Main_IA_LengthC, FontID(#Font_InfoArea))
  Else
    SetGadgetFont(#G_TX_Main_IA_InfoCont1, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_InfoCont2, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_InfoCont3, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_InfoCont4, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_InfoDesc1, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_InfoDesc2, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_InfoDesc3, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_InfoDesc4, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_Length, #PB_Default)
    SetGadgetFont(#G_TX_Main_IA_LengthC, #PB_Default)
  EndIf
  ; Wiedergabeliste
  If GUIFont(#Font_PlayList)\activ And IsFont(#Font_PlayList)
    SetGadgetFont(#G_LI_Main_PL_PlayList, FontID(#Font_PlayList))
  Else
    SetGadgetFont(#G_LI_Main_PL_PlayList, #PB_Default)
  EndIf
  ; Medienbibliothek
  If GUIFont(#Font_MediaLib)\activ And IsFont(#Font_MediaLib)
    SetGadgetFont(#G_LI_Main_ML_MediaLib, FontID(#Font_MediaLib))
    SetGadgetFont(#G_LV_Main_ML_Category, FontID(#Font_MediaLib))
    SetGadgetFont(#G_LI_Main_ML_Misc, FontID(#Font_MediaLib))
    SetGadgetFont(#G_SR_Main_ML_Search, FontID(#Font_MediaLib))
  Else
    SetGadgetFont(#G_LI_Main_ML_MediaLib, #PB_Default)
    SetGadgetFont(#G_LV_Main_ML_Category, #PB_Default)
    SetGadgetFont(#G_LI_Main_ML_Misc, #PB_Default)
    SetGadgetFont(#G_SR_Main_ML_Search, #PB_Default)
  EndIf
  ; Tracker
  If GUIFont(#Font_Tracker)\activ And IsFont(#Font_Tracker)
    If IsWindow(#Win_Tracker)
      SetGadgetFont(#G_TX_Tracker_Title, FontID(#Font_Tracker))
    EndIf
  Else
    If IsWindow(#Win_Tracker)
      SetGadgetFont(#G_TX_Tracker_Title, #PB_Default)
    EndIf
  EndIf
  ; MidiLyrics
  If GUIFont(#Font_MidiLyrics)\activ And IsFont(#Font_MidiLyrics)
    If IsWindow(#Win_MidiLyrics)
      SetGadgetFont(#G_ED_MidiLyrics_Text, FontID(#Font_MidiLyrics))
    EndIf
  Else
    If IsWindow(#Win_MidiLyrics)
      SetGadgetFont(#G_ED_MidiLyrics_Text, #PB_Default)
    EndIf
  EndIf
EndProcedure

Procedure Window_ChangeOpacity()
 Protected iNext.i
 
 If Pref\opacity > 0
  For iNext = #Win_Main To #Win_Last - 1
   If IsWindow(iNext)
    Window_SetLayeredStyle(iNext, 1)
    Window_SetOpacity(iNext, Pref\opacityval)
   EndIf
  Next
 Else
  For iNext = #Win_Main To #Win_Last - 1
   If IsWindow(iNext)
    Window_SetOpacity(iNext, 255)
    Window_SetLayeredStyle(iNext, 0)
   EndIf
  Next
 EndIf
EndProcedure

Procedure Window_ChangeSize(NewSizeType)
  Protected iNext.i
  
  ;Close CurrArea
  Select iSizeTypeOld
    
    Case #SizeType_Normal
      If iSizeTypeOld = #SizeType_Normal
        iWinW_Main_Normal = WindowWidth(#Win_Main)
      EndIf
    
    Case #SizeType_Playlist
      If iSizeTypeOld = #SizeType_Playlist
        iWinW_Main_Second = WindowWidth(#Win_Main)
        iWinH_Main_Second = WindowHeight(#Win_Main)
        HideGadget(#G_LI_Main_PL_PlayList, 1)
        If NewSizeType = #SizeType_Playlist
          NewSizeType = #SizeType_Normal
        EndIf
      EndIf
      
    Case #SizeType_MediaLibary
      If iSizeTypeOld = #SizeType_MediaLibary
        iWinW_Main_Second = WindowWidth(#Win_Main)
        iWinH_Main_Second = WindowHeight(#Win_Main)
        lMediaLib_SPSize1 = GetGadgetState(#G_SP_Main_ML_Vertical)
        lMediaLib_SPSize2 = GetGadgetState(#G_SP_Main_ML_Horizontal)
        HideGadget(#G_SR_Main_ML_Search, 1)
        HideGadget(#G_BN_Main_ML_SearchOptions, 1)
        HideGadget(#G_BN_Main_ML_Search, 1)
        HideGadget(#G_SP_Main_ML_Horizontal, 1)
        If NewSizeType = #SizeType_MediaLibary
          NewSizeType = #SizeType_Normal
        EndIf
      EndIf
   
  EndSelect
  
  ;Show NewArea
  Select NewSizeType
    
    Case #SizeType_Normal
      WindowBounds(#Win_Main, 0, 0, #PB_Ignore, #PB_Ignore)
      Window_ResizeGadgets(#Win_Main)
      If iWinW_Main_Normal > 0
        ResizeWindow(#Win_Main, #PB_Ignore, #PB_Ignore, iWinW_Main_Normal, GadgetHeight(#G_CN_Main_IA_Background) + GadgetHeight(#G_FR_Main_IA_Gap) + GadgetHeight(#G_TB_Main_IA_Position) + 2 + GadgetHeight(#G_CN_Main_IA_ToolbarLeft) + 2)
      Else
        ResizeWindow(#Win_Main, #PB_Ignore, #PB_Ignore, 2 + GadgetWidth(#G_CN_Main_IA_ToolbarLeft) + GadgetWidth(#G_TB_Main_IA_Volume) + GadgetWidth(#G_CN_Main_IA_ToolbarRight) + 2, GadgetHeight(#G_CN_Main_IA_Background) + GadgetHeight(#G_FR_Main_IA_Gap) + GadgetHeight(#G_TB_Main_IA_Position) + 2 + GadgetHeight(#G_CN_Main_IA_ToolbarLeft) + 2)
      EndIf
      WindowBounds(#Win_Main, iWinW_Main_NormalMin, WindowHeight(#Win_Main), GetSystemMetrics_(#SM_CXSCREEN), WindowHeight(#Win_Main))
      ShowWindow_(StatusBarID(#Statusbar_Main), #SW_HIDE)
      
    Case #SizeType_Playlist
      WindowBounds(#Win_Main, iWinW_Main_SecondMin, iWinH_Main_SecondMin, GetSystemMetrics_(#SM_CXSCREEN), GetSystemMetrics_(#SM_CYSCREEN))
      ResizeWindow(#Win_Main, #PB_Ignore, #PB_Ignore, iWinW_Main_Second, iWinH_Main_Second)
      Window_ResizeGadgets(#Win_Main)
      HideGadget(#G_LI_Main_PL_PlayList, 0)
      ShowWindow_(StatusBarID(#Statusbar_Main), #SW_NORMAL)
     
    Case #SizeType_MediaLibary
      WindowBounds(#Win_Main, iWinW_Main_SecondMin, iWinH_Main_SecondMin, GetSystemMetrics_(#SM_CXSCREEN), GetSystemMetrics_(#SM_CYSCREEN))
      ResizeWindow(#Win_Main, #PB_Ignore, #PB_Ignore, iWinW_Main_Second, iWinH_Main_Second)
      Window_ResizeGadgets(#Win_Main)
      SetGadgetText(#G_SR_Main_ML_Search, "")
      DisableGadget(#G_BN_Main_ML_Search, 1)
      MediaLib_RefreshHeader()
      SetGadgetState(#G_SP_Main_ML_Vertical, lMediaLib_SPSize1)
      SetGadgetState(#G_SP_Main_ML_Horizontal, lMediaLib_SPSize2)
      HideGadget(#G_SR_Main_ML_Search, 0)
      HideGadget(#G_BN_Main_ML_SearchOptions, 0)
      HideGadget(#G_BN_Main_ML_Search, 0)
      HideGadget(#G_SP_Main_ML_Horizontal, 0)
      ShowWindow_(StatusBarID(#Statusbar_Main), #SW_NORMAL)
  EndSelect
  
  iSizeTypeOld = NewSizeType
  Window_CheckPos(#Win_Main)
EndProcedure

Procedure Window_MinimizeMaximize()
  If Pref\taskbar
    If GetWindowState(#Win_Main) = #PB_Window_Minimize
      SetWindowState(#Win_Main, #PB_Window_Normal)
      SetMenuItemText(#Menu_SysTray, #Mnu_SysTray_Show, "Verstecken")
      SetForegroundWindow_(WinSize(#Win_Main)\winid)
      SetFocus_(WinSize(#Win_Main)\winid)
    Else
      SetWindowState(#Win_Main, #PB_Window_Minimize)
      SetMenuItemText(#Menu_SysTray, #Mnu_SysTray_Show, "Zeigen")
      SetFocus_(0)
    EndIf
  Else
    If IsWindowVisible_(WinSize(#Win_Main)\winid)
      SetMenuItemText(#Menu_SysTray, #Mnu_SysTray_Show, "Zeigen")
      HideAllWindow()
      SetFocus_(0)
    Else
      SetMenuItemText(#Menu_SysTray, #Mnu_SysTray_Show, "Verstecken")
      ShowAllWindow()
      SetForegroundWindow_(WinSize(#Win_Main)\winid)
      SetFocus_(WinSize(#Win_Main)\winid)
    EndIf
  EndIf
EndProcedure

Procedure Window_Callback(hWnd, Msg, wParam, lParam)
  Protected iResult.i = #PB_ProcessPureBasicEvents
  
  ; Keine Events mehr bearbeiten, da das Programm beendet wird.
  If iEndApplication
    ProcedureReturn iResult
  EndIf
  
  ; WndEx Events
  If Pref\magnetic > 0
    WndEx_Callback(hWnd, Msg, wParam, lParam)
  EndIf
  
  ; Global ResizeGadgets
  If Msg = #WM_SIZE
    Window_ResizeGadgets(hWnd)
  EndIf
  
  If Msg = #WM_NOTIFY
    Protected *NMHDR.NMHDR = lParam
    
    Select *NMHDR\code
      
      ; Toolbar Button MouseOver
;       Case #TBN_HOTITEMCHANGE
;         Protected *NMTBHOTITEM.NMTBHOTITEM = lParam
;         
;         Select *NMTBHOTITEM\hdr\hwndFrom
;           Case ToolBarID(#Toolbar_Main1)
;             Select *NMTBHOTITEM\idNew
;               Case #Mnu_Main_TB1_Previous : TimeMessage\message = "Vorheriger Titel"
;               Case #Mnu_Main_TB1_Next     : TimeMessage\message = "Nächster Titel"
;               Case #Mnu_Main_TB1_Play     : TimeMessage\message = "Wiedergabe"
;               Case #Mnu_Main_TB1_Pause    : TimeMessage\message = "Wiedergabe unterbrechen"
;               Case #Mnu_Main_TB1_Stop     : TimeMessage\message = "Wiedergabe anhalten"
;               Case #Mnu_Main_TB1_Record   : TimeMessage\message = "Radio Aufnahme"
;               Case #Mnu_Main_TB1_Open     : TimeMessage\message = "Zur Wiedergabeliste hinzufügen"
;             EndSelect
;           Case ToolBarID(#Toolbar_Main2)
;             Select *NMTBHOTITEM\idNew
;               Case #Mnu_Main_TB2_Equilizer : TimeMessage\message = "Effekte"
;             EndSelect
;         EndSelect
      
      ; ToolBar DropDown Click
      Case #TBN_DROPDOWN
        Protected *NMTOOLBAR.NMTOOLBAR = lParam
        
        If *NMTOOLBAR\hdr\hwndFrom = ToolBarID(#Toolbar_Main1) And *NMTOOLBAR\iItem = #Mnu_Main_TB1_Open
          DisplayPopupMenu(#Menu_Open, WindowID(#Win_Main), Window_GetClientPosX(#Win_Main) + GadgetX(#G_CN_Main_IA_ToolbarLeft) + *NMTOOLBAR\rcButton\left, Window_GetClientPosY(#Win_Main) + GadgetY(#G_CN_Main_IA_ToolbarLeft) + *NMTOOLBAR\rcButton\bottom)
        EndIf
        
    EndSelect
    
  EndIf
  
  ; Main Fenster
  If hWnd = WinSize(#Win_Main)\winid
    ; Plugin Events
    If Msg = #WM_COPYDATA
      Protected *CDS.COPYDATASTRUCT = lParam
      Protected *BKM._BKM = *CDS\lpData
      
      If *CDS And *BKM
        If *CDS\dwData = #BK_PluginEvent And *CDS\cbData = SizeOf(_BKM) And *BKM <> 0
          Plugin_DoMessage(*BKM\Msg, *BKM\iParam1, *BKM\iParam2, *BKM\sParam1, *BKM\sParam2)
          iResult = 1
        EndIf
      EndIf
    EndIf
    ; Minimieren
    If Msg = #WM_SYSCOMMAND
      If wParam = #SC_MINIMIZE And Pref\taskbar = 0
        Window_MinimizeMaximize()
        iResult = 0
      EndIf
    EndIf
    ;ListIconGadget ColumnRClick (PopUp Menu)
    If Msg = #WM_NOTIFY
      Protected HDH.HD_HITTESTINFO
      Protected *NMHR.NMHEADER = lParam
      
      If *NMHR
        Select *NMHR\hdr\code
          Case #HDN_ITEMCLICK
            If *NMHR\hdr\hwndFrom = SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_GETHEADER, #Null, #Null)
              PlayList_Sort(*NMHR\iItem)
            EndIf
          Case #NM_RCLICK
            If *NMHR\hdr\hwndFrom = SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_GETHEADER, #Null, #Null) Or *NMHR\hdr\hwndFrom = SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_GETHEADER, #Null, #Null)
              GetCursorPos_(@HDH\pt)
              ScreenToClient_(*NMHR\hdr\hwndFrom, @HDH\pt)
              
              Debug HDH\pt\x
              Debug HDH\pt\y              
              
              SendMessage_(*NMHR\hdr\hwndFrom, #HDM_HITTEST, 0, @HDH)
              iLastHeaderRClick      = *NMHR\hdr\hwndFrom
              iLastHeaderRClickIndex = HDH\iItem
              DisplayPopupMenu(#Menu_ListIconGadget, WindowID(#Win_Main), DesktopMouseX(), DesktopMouseY())
            EndIf
          Case #HDN_ITEMCHANGING
            If *NMHR\hdr\hwndFrom = SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_GETHEADER, #Null, #Null) Or *NMHR\hdr\hwndFrom = SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_GETHEADER, #Null, #Null)
              If *NMHR\iItem = 0 : iResult = 1 : EndIf
            EndIf
        EndSelect
      EndIf
    EndIf
    ; Remove Focus
    If Msg = #WM_LBUTTONDOWN
      SetFocus_(WinSize(#Win_Main)\winid)
    EndIf
    If Msg = #WM_RBUTTONDOWN
      DisplayPopupMenu(#Menu_SysTray, WindowID(#Win_Main))
    EndIf
  EndIf
  
  ; Shortcuts
  If Msg = #WM_NOTIFY
    Protected *NMH.NMHDR
    Protected *NMLV.NM_LISTVIEW
    
    *NMH = lParam
    If *NMH
      If WinSize(#Win_Preferences)\winid
        If *NMH\hwndFrom = GadgetID(#G_LI_Preferences_HotKey_Overview) And *NMH\code = #LVN_ITEMCHANGED
          *NMLV = lParam
          If *NMLV\uNewState & #LVIS_STATEIMAGEMASK
            SetGadgetState(#G_LI_Preferences_HotKey_Overview, *NMLV\iItem)
          EndIf
        EndIf
      EndIf
    EndIf 
  EndIf
  
  ; Medienbibliothek Erweiterte Suche
  If hWnd = WinSize(#Win_MLSearchPref)\winid And Msg = #WM_ACTIVATE
    If wParam = #WA_INACTIVE
      CloseWindow_MLSearchPref()
    EndIf
  EndIf
  
  ProcedureReturn iResult
EndProcedure

Procedure Window_ChangeColumnAlign(Align)
  If iLastHeaderRClick > 0 And iLastHeaderRClickIndex > 0
    Protected iAccept.i, iGadget.i, iWidth.i
    
    Select iLastHeaderRClick
      ;PlayList
      Case SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_GETHEADER, 0, 0)
        iAccept = 1
        iGadget = #G_LI_Main_PL_PlayList
      ;MediaLibary
      Case SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_GETHEADER, 0, 0)
        iAccept = 1
        iGadget = #G_LI_Main_ML_MediaLib
    EndSelect
    
    If iAccept > 0 And IsGadget(iGadget)
      Select Align
        Case #Mnu_ListIconGadget_AlignL
          ListIconGadget_SetColumnAlign(iGadget, iLastHeaderRClickIndex, #LVCFMT_LEFT)
        Case #Mnu_ListIconGadget_AlignC
          ListIconGadget_SetColumnAlign(iGadget, iLastHeaderRClickIndex, #LVCFMT_CENTER)
        Case #Mnu_ListIconGadget_AlignR
          ListIconGadget_SetColumnAlign(iGadget, iLastHeaderRClickIndex, #LVCFMT_RIGHT)
        Case #Mnu_ListIconGadget_OptimizeWidth
          SendMessage_(GadgetID(iGadget), #LVM_SETCOLUMNWIDTH, iLastHeaderRClickIndex, #LVSCW_AUTOSIZE_USEHEADER)
        Case #Mnu_ListIconGadget_Width
          If Align = #Mnu_ListIconGadget_Width
            iWidth = GetGadgetItemAttribute(iGadget, -1, #PB_ListIcon_ColumnWidth, iLastHeaderRClickIndex)
            iWidth = Val(InputRequester("Spaltenbreite", "Breite (Pixel):", Str(iWidth)))
          EndIf
          If iWidth > 0
            SetGadgetItemAttribute(iGadget, -1, #PB_ListIcon_ColumnWidth, iWidth, iLastHeaderRClickIndex)
          EndIf
      EndSelect
    EndIf
    
 EndIf
EndProcedure

Procedure Window_RefreshWorker()
  Static iIndex.i, iZero.i
  If Pref\enableworker
    iZero = 0
    If iIndex < ArraySize(Worker()) - 1
      iIndex + 1
    Else
      iIndex = 0
    EndIf
    StatusBarImage(#Statusbar_Main, #SBField_Worker, Worker(iIndex), #PB_StatusBar_BorderLess)
  Else
    If iZero <> 1
      StatusBarImage(#Statusbar_Main, #SBField_Worker, ImageList(#ImageList_Zero), #PB_StatusBar_BorderLess)
      iZero = 1
    EndIf
  EndIf
EndProcedure

Procedure Window_SetSplashState(Text$)
  If IsWindow(#Win_SplashScreen)
    SetGadgetText(#G_TX_SplashScreen_Text, Text$)
    UpdateWindow_(WindowID(#Win_SplashScreen))
    WindowEvent()
  EndIf
EndProcedure

; Anzeigen und einstellen des RadioLog PopUp Menus
Procedure.i GadgetCallback_Position(hWnd, Msg, wParam, lParam)
  Protected iEnable.i
  
  If Msg = #WM_RBUTTONDOWN And CurrPlay\fingerprint <> ""
    ForEach Position()
      If Position()\fingerprint = CurrPlay\fingerprint
        iEnable = 1
        Break
      EndIf
    Next
    
    If iEnable = 1
      DisableMenuItem(#Menu_Position, #Mnu_Pos_Load, 0)
      DisableMenuItem(#Menu_Position, #Mnu_Pos_Remove, 0)
    Else
      DisableMenuItem(#Menu_Position, #Mnu_Pos_Load, 1)
      DisableMenuItem(#Menu_Position, #Mnu_Pos_Remove, 1)
    EndIf
    
    If ListSize(Position()) = 0
      DisableMenuItem(#Menu_Position, #Mnu_Pos_Clear, 1)
    Else
      DisableMenuItem(#Menu_Position, #Mnu_Pos_Clear, 0)
    EndIf
    
    DisplayPopupMenu(#Menu_Position, WindowID(#Win_Main))
  EndIf
  
  ProcedureReturn CallWindowProc_(GetProp_(hWnd, "winproc"), hWnd, Msg, wParam, lParam)
EndProcedure

Procedure GadgetCallback_Volume(hWnd, Msg, wParam, lParam)
  If Msg = #WM_RBUTTONDOWN
    DisplayPopupMenu(#Menu_Volume, WindowID(#Win_Main))
  EndIf
  
  ProcedureReturn CallWindowProc_(GetProp_(hWnd, "winproc"), hWnd, Msg, wParam, lParam)
EndProcedure

Procedure GadgetCallback_MidiLyrics(hWnd, Msg, wParam, lParam)
  If Msg = #WM_CONTEXTMENU
    If EditorGadget_GetSelText(#G_ED_MidiLyrics_Text) = ""
      DisableMenuItem(#Menu_MidiLyrics, #Mnu_MidiLyrics_Copy, 1)
    Else
      DisableMenuItem(#Menu_MidiLyrics, #Mnu_MidiLyrics_Copy, 0)
    EndIf
    
    If GetGadgetText(#G_ED_MidiLyrics_Text) = ""
      DisableMenuItem(#Menu_MidiLyrics, #Mnu_MidiLyrics_Save, 1)
    Else
      DisableMenuItem(#Menu_MidiLyrics, #Mnu_MidiLyrics_Save, 0)
    EndIf
    
    DisplayPopupMenu(#Menu_MidiLyrics, WindowID(#Win_MidiLyrics))
  EndIf
  
  ProcedureReturn CallWindowProc_(GetProp_(hWnd, "winproc"), hWnd, Msg, wParam, lParam)
EndProcedure

Procedure.s GetHotkeyName(Index)
  If ArraySize(HotKey()) >= Index
    Protected sResult.s
    
    ; Ctrl
    If HotKey(Index)\control[0]
      sResult + "Strg"
    EndIf
    ; Menu
    If HotKey(Index)\menu[0]
      If sResult : sResult + " + " : EndIf
      sResult + "Alt"
    EndIf
    ; Shift
    If HotKey(Index)\shift[0]
      If sResult : sResult + " + " : EndIf
      sResult + "Shift"
    EndIf
    ; Misc
    If HotKey(Index)\misc[0] > -1 And ArraySize(Key()) >= Index
      If sResult : sResult + " + " : EndIf
      sResult + Key(HotKey(Index)\misc[0])\name
    EndIf
    
    ProcedureReturn sResult
  EndIf
EndProcedure

; Speichert die Wiedergabeposition der aktuellen Wiedergabe
Procedure Position_Save()
  
  ; Aktualisiere bereits gespeicherten Wert
  ForEach Position()
    If Position()\fingerprint = CurrPlay\fingerprint
      Position()\position = Bass_GetPos()
      ProcedureReturn 1
    EndIf
  Next
  
  ; Lösche überflüssige Elemente
  While ListSize(Position()) >= #MaxSavedPos
    LastElement(Position())
    DeleteElement(Position())
  Wend
  
  ; Speichere Wert
  AddElement(Position())
  Position()\fingerprint = CurrPlay\fingerprint
  Position()\position    = Bass_GetPos()
  
EndProcedure

; Lädt die Wiedergabeposition
Procedure Position_Load()
  ForEach Position()
    If Position()\fingerprint = CurrPlay\fingerprint
      Bass_SetPos(Position()\position)
    EndIf
  Next
EndProcedure

Procedure Position_Remove()
  ForEach Position()
    If Position()\fingerprint = CurrPlay\fingerprint
      DeleteElement(Position())
      Break
    EndIf
  Next
EndProcedure

Procedure Position_ClearList()
  ClearList(Position())
EndProcedure

; Löscht die RadioTrackLog leer
Procedure RadioLog_Clear()
  If ListSize(RadioTrackLog()) > 0
    ClearList(RadioTrackLog())
    ClearGadgetItems(#G_LI_RadioLog_Overview)
  EndIf
EndProcedure

; Speichert den RadioTrackLog in eine Datei ab.
Procedure RadioLog_Save()
  If ListSize(RadioTrackLog()) > 0
    Protected iFile.i, sFile.s
    
    sFile = SaveFileRequester("RadioLog Speichern", GetCurrentDirectory() + "RadioLog", "Text Datei|*.txt|Alle Dateien|*.*", 0)
    If sFile
      
      If SelectedFilePattern() = 0 And GetExtensionPart(sFile) = ""
        sFile + ".txt"
      EndIf
      
      iFile = CreateFile(#PB_Any, sFile)
      If iFile
        ForEach RadioTrackLog()
          WriteString(iFile, RadioTrackLog()\artist)
          If RadioTrackLog()\title <> ""
            WriteStringN(iFile, " - " + RadioTrackLog()\title)
          Else
            WriteStringN(iFile, "")
          EndIf
        Next
        
        CloseFile(iFile)
      Else
        MsgBox_Error("Datei '" + sFile + "' konnte nicht erstellt werden")
      EndIf
    EndIf
    
  EndIf
EndProcedure

Procedure Preferences_RefreshColorThemes()
  If IsWindow(#Win_Preferences)
    Protected iDirectory.i
    Protected NewList ColorThemes.s()
    
    ClearGadgetItems(#G_CB_Preferences_GUI_LayoutTheme)
    AddGadgetItem(#G_CB_Preferences_GUI_LayoutTheme, -1, "Aktuell")
    
    ; Executable Directory
    iDirectory = ExamineDirectory(#PB_Any, ExecutableDirectory() + #Folder_Colors, "*" + #FileExtension_ColorThemes)
    If iDirectory
      While NextDirectoryEntry(iDirectory)
        If DirectoryEntryType(iDirectory) = #PB_DirectoryEntry_File
          AddElement(ColorThemes())
          ColorThemes() = GetFileNamePart(DirectoryEntryName(iDirectory))
        EndIf
      Wend
      FinishDirectory(iDirectory)
    EndIf
    
    ; AppData
    iDirectory = ExamineDirectory(#PB_Any, AppDataDirectory() + #Folder_AppData + #Folder_Colors, "*" + #FileExtension_ColorThemes)
    If iDirectory
      While NextDirectoryEntry(iDirectory)
        If DirectoryEntryType(iDirectory) = #PB_DirectoryEntry_File
          AddElement(ColorThemes())
          ColorThemes() = GetFileNamePart(DirectoryEntryName(iDirectory))
        EndIf
      Wend
      FinishDirectory(iDirectory)
    EndIf
    
    SortList(ColorThemes(), #PB_Sort_Ascending)
    ForEach ColorThemes()
      AddGadgetItem(#G_CB_Preferences_GUI_LayoutTheme, -1, ColorThemes())
    Next
    
    ClearList(ColorThemes())
    
    SetGadgetState(#G_CB_Preferences_GUI_LayoutTheme, 0)
  EndIf
EndProcedure

Procedure Preferences_ReloadFonts()
  If GUIFont(#Font_InfoArea)\font And GUIFont(#Font_InfoArea)\size > 0
    LoadFont(#Font_InfoArea, GUIFont(#Font_InfoArea)\font, GUIFont(#Font_InfoArea)\size)
  EndIf
  If GUIFont(#Font_PlayList)\font And GUIFont(#Font_PlayList)\size > 0
    LoadFont(#Font_PlayList, GUIFont(#Font_PlayList)\font, GUIFont(#Font_PlayList)\size)
  EndIf
  If GUIFont(#Font_MediaLib)\font And GUIFont(#Font_MediaLib)\size > 0
    LoadFont(#Font_MediaLib, GUIFont(#Font_MediaLib)\font, GUIFont(#Font_MediaLib)\size)
  EndIf
  If GUIFont(#Font_Tracker)\font And GUIFont(#Font_Tracker)\size > 0
    LoadFont(#Font_Tracker, GUIFont(#Font_Tracker)\font, GUIFont(#Font_Tracker)\size)
  EndIf
  If GUIFont(#Font_MidiLyrics)\font And GUIFont(#Font_MidiLyrics)\size > 0
    LoadFont(#Font_MidiLyrics, GUIFont(#Font_MidiLyrics)\font, GUIFont(#Font_MidiLyrics)\size)
  EndIf
EndProcedure

Procedure Preferences_ColorThema_OpenFile(File$)
  Protected iFile.i
  
  iFile = ReadFile(#PB_Any, File$)
  If iFile
    
    If ReadCharacter(iFile) = 'B' And ReadCharacter(iFile) = 'K' And ReadCharacter(iFile) = 'C' And ReadCharacter(iFile) = 'T'
      If ReadByte(iFile) = 1
        
        For iNext = 0 To #Color_Last
          SetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iNext, #PB_Gadget_BackColor, ReadInteger(iFile), 1)
        Next
        
      EndIf
    EndIf
    
    CloseFile(iFile)
  EndIf
EndProcedure

Procedure Preferences_ColorThema_Open()
  If IsWindow(#Win_Preferences)
    
    If GetGadgetState(#G_CB_Preferences_GUI_LayoutTheme) = 0
      ; Aktuell
      For iNext = 0 To #Color_Last - 1
        SetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iNext, #PB_Gadget_BackColor, Pref\color[iNext], 1)
      Next
      
    ElseIf GetGadgetState(#G_CB_Preferences_GUI_LayoutTheme) > 0
      ; Aus Datei
      Protected sFile.s, iNext.i
      
      sFile = GetGadgetText(#G_CB_Preferences_GUI_LayoutTheme) + #FileExtension_ColorThemes
      If GetGadgetState(#G_CB_Preferences_GUI_LayoutTheme) > 0 And sFile
        
        If FileSize(ExecutableDirectory() + #Folder_Colors + sFile) > 1
          Preferences_ColorThema_OpenFile(ExecutableDirectory() + #Folder_Colors + sFile)
        Else
          Preferences_ColorThema_OpenFile(AppDataDirectory() + #Folder_AppData + #Folder_Colors + sFile)
        EndIf
        
      EndIf
    
    EndIf
  EndIf
EndProcedure

Procedure Preferences_ColorThema_Save()
  Protected iFile.i, sFile.s, iNext.i
  
  sFile = SaveFileRequester("Farbthema Speichern", AppDataDirectory() + #Folder_AppData + #Folder_Colors, "Farbthema|*" + #FileExtension_ColorThemes, 0)
  If sFile
    
    If UCase(GetExtensionPart(sFile)) <> UCase(#FileExtension_ColorThemes)
      sFile + #FileExtension_ColorThemes
    EndIf
    
    ; Egal welcher Ordner, es wird immer im Colors Order gespeichert.
    sFile = AppDataDirectory() + #Folder_AppData + #Folder_Colors + GetFilePart(sFile)
    
    ; Datei Erstellen
    iFile = CreateFile(#PB_Any, sFile)
    If iFile
      
      ; Checkstring
      WriteCharacter(iFile, 'B')
      WriteCharacter(iFile, 'K')
      WriteCharacter(iFile, 'C')
      WriteCharacter(iFile, 'T')
      ; Version
      WriteByte(iFile, 1)
      
      ; Farbwerte
      For iNext = 0 To #Color_Last - 1
        WriteInteger(iFile, GetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iNext, #PB_Gadget_BackColor, 1))
      Next
      
      CloseFile(iFile)
      
      AddGadgetItem(#G_CB_Preferences_GUI_LayoutTheme, -1, GetFileNamePart(sFile))
    Else
      MsgBox_Error("Datei '" + sFile + "' konnte nicht erstellt werden")
    EndIf
    
  EndIf
EndProcedure

; Wird beim öffnen des Einstellungen Fenster aufgerufen
; Hier werden generell alle Werte eingetragen
Procedure Preferences_Init()
  If IsWindow(#Win_Preferences)
    Protected iNext.i
    
    ;Bass
    ClearGadgetItems(#G_CB_Preferences_Bass_OutputDevice)
    ForEach DeviceList()
      AddGadgetItem(#G_CB_Preferences_Bass_OutputDevice, -1, DeviceList()\name)
    Next
    
    SetGadgetState(#G_CB_Preferences_Bass_OutputDevice, Pref\bass_device)
    SetGadgetState(#G_CB_Preferences_Bass_OutputRate, Pref\bass_rate)
    
    GadgetToolTip(#G_CB_Preferences_Bass_OutputDevice, GetGadgetText(#G_CB_Preferences_Bass_OutputDevice))
    GadgetToolTip(#G_CB_Preferences_Bass_OutputRate, GetGadgetText(#G_CB_Preferences_Bass_OutputRate))
    
    If Pref\bass_fadein = 0
      SetGadgetText(#G_TX_Preferences_Bass_FadeIn, "Einblenden (Aus)")
    Else
      SetGadgetText(#G_TX_Preferences_Bass_FadeIn, "Einblenden (" + Str(Pref\bass_fadein) + " Sek.)")
    EndIf
    SetGadgetState(#G_TB_Preferences_Bass_FadeIn, Pref\bass_fadein)
    
    If Pref\bass_fadeout = 0
      SetGadgetText(#G_TX_Preferences_Bass_FadeOut, "Ausblenden (Aus)")
    Else
      SetGadgetText(#G_TX_Preferences_Bass_FadeOut, "Ausblenden (" + Str(Pref\bass_fadeout) + " Sek.)")
    EndIf
    SetGadgetState(#G_TB_Preferences_Bass_FadeOut, Pref\bass_fadeout)
    
    If Pref\bass_fadeoutend = 0
      SetGadgetText(#G_TX_Preferences_Bass_FadeOutEnd, "Ausblenden Beenden (Aus)")
    Else
      SetGadgetText(#G_TX_Preferences_Bass_FadeOutEnd, "Ausblenden Beenden (" + Str(Pref\bass_fadeoutend) + " Sek.)")
    EndIf
    SetGadgetState(#G_TB_Preferences_Bass_FadeOutEnd, Pref\bass_fadeoutend)
    
    SetGadgetText(#G_SR_Preferences_Bass_MidiSF2File, Pref\bass_midisf2)
    
    SetGadgetState(#G_CH_Preferences_Bass_MidiLyrics, Pref\bass_midilyrics)
    
    SetGadgetState(#G_TB_Preferences_Bass_PreviewTime, Pref\bass_preview)
    
    ;InetStream
    SetGadgetState(#G_CH_Preferences_InetStream_SaveFile, Pref\inetstream_savefile)
    SetGadgetText(#G_SR_Preferences_InetStream_FilePath, Pref\inetstream_savepath)
    
    If Pref\inetstream_savename = 0
      SetGadgetState(#G_OP_Preferences_InetStream_Title, 1)
    Else
      SetGadgetState(#G_OP_Preferences_InetStream_Full, 1)
    EndIf
    
    SetGadgetState(#G_TB_Preferences_InetStream_TimeOut, Pref\inetstream_timeout)
    SetGadgetText(#G_TX_Preferences_InetStream_TimeOut, "TimeOut (" + Str(Pref\inetstream_timeout) + " Sekunden)")
    
    SetGadgetState(#G_TB_Preferences_InetStream_Buffer, Pref\inetstream_buffer)
    SetGadgetText(#G_TX_Preferences_InetStream_Buffer, "Buffer (" + Str(Pref\inetstream_buffer) + " Sekunden)")
    
    SetGadgetText(#G_SR_Preferences_InetStream_ProxyServer, Pref\inetstream_proxyserver)
    
    ;GUI
    SetGadgetState(#G_CH_Preferences_GUI_AlwaysOnTop, Pref\ontop)
    SetGadgetState(#G_CH_Preferences_GUI_Opacity, Pref\opacity)
    SetGadgetState(#G_TB_Preferences_GUI_OpacityValue, Pref\opacityval)
    SetGadgetState(#G_CH_Preferences_GUI_Magnetic, Pref\magnetic)
    SetGadgetState(#G_TB_Preferences_GUI_MagneticValue, Pref\magneticval)
    SetGadgetState(#G_CH_Preferences_GUI_AutoColumnPL, Pref\autoclnw_pl)
    SetGadgetState(#G_CH_Preferences_GUI_AutoColumnML, Pref\autoclnw_ml)
    SetGadgetText(#G_CB_Preferences_GUI_LengthFormat, Pref\lengthformat)
    SetGadgetState(#G_CH_Preferences_GUI_AutoComplete, Pref\gui_autocomplete)
    SetGadgetState(#G_CB_Preferences_GUI_SpectrumType, Pref\spectrum)
    
    ; GUI Color
    For iNext = 0 To #Color_Last - 1
      SetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iNext, #PB_Gadget_BackColor, Pref\color[iNext], 1)
    Next
    
    Preferences_RefreshColorThemes()
    
    ; GUI Fonts
    For iNext = 0 To #Font_Last
      If GUIFont(iNext)\activ
        SetGadgetItemState(#G_LI_Preferences_GUI_FontsOverview, iNext, GetGadgetItemState(#G_LI_Preferences_GUI_FontsOverview, iNext) | #PB_ListIcon_Checked)
      EndIf
      If GUIFont(iNext)\font
        SetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iNext, GUIFont(iNext)\font, 1)
      EndIf
      If GUIFont(iNext)\size > 0
        SetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iNext, Str(GUIFont(iNext)\size), 2)
      EndIf
    Next
    
    ;Hotkey
    SetGadgetState(#G_CH_Preferences_HotKey_EnableMediaKeys, Pref\sk_enablemedia)
    SetGadgetState(#G_CH_Preferences_HotKey_EnableGlobal, Pref\sk_enableglobal)
    
    If Pref\sk_enableglobal
      DisableGadget(#G_LI_Preferences_HotKey_Overview, 0)
    Else
      DisableGadget(#G_LI_Preferences_HotKey_Overview, 1)
      SetGadgetState(#G_LI_Preferences_HotKey_Overview, -1)
      DisableGadget(#G_CH_Preferences_HotKey_Control, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Control, 0)
      DisableGadget(#G_CH_Preferences_HotKey_Menu, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Menu, 0)
      DisableGadget(#G_CH_Preferences_HotKey_Shift, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Shift, 0)
      DisableGadget(#G_CB_Preferences_HotKey_Misc, 1) : SetGadgetState(#G_CB_Preferences_HotKey_Misc, 0)
    EndIf
    
    For iNext = 0 To ArraySize(HotKey())
      If HotKey(iNext)\active[0] = 1
        SetGadgetItemState(#G_LI_Preferences_HotKey_Overview, iNext, GetGadgetItemState(#G_LI_Preferences_HotKey_Overview, iNext) | #PB_ListIcon_Checked)
      Else
        SetGadgetItemState(#G_LI_Preferences_HotKey_Overview, iNext, GetGadgetItemState(#G_LI_Preferences_HotKey_Overview, iNext) &~ #PB_ListIcon_Checked)
      EndIf
      SetGadgetItemText(#G_LI_Preferences_HotKey_Overview, iNext, GetHotkeyName(iNext), 1)
      HotKey(iNext)\active[1]   = HotKey(iNext)\active[0]
      HotKey(iNext)\control[1]  = HotKey(iNext)\control[0]
      HotKey(iNext)\menu[1]     = HotKey(iNext)\menu[0]
      HotKey(iNext)\shift[1]    = HotKey(iNext)\shift[0]
      HotKey(iNext)\misc[1]     = HotKey(iNext)\misc[0]
    Next
    
    SendMessage_(GadgetID(#G_LI_Preferences_HotKey_Overview), #LVM_ENSUREVISIBLE, 0, 1)
    SetGadgetState(#G_LI_Preferences_HotKey_Overview, -1)
    
    ;FileLink
    For iNext = 0 To CountGadgetItems(#G_LI_Preferences_Filelink_OverView) - 1
      SetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext, GetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext) &~ #PB_ListIcon_Checked)
    Next
    
    ;Tracker
    SetGadgetState(#G_CH_Preferences_Tracker_Enable, Pref\tracker_enable)
    SetGadgetState(#G_TB_Preferences_Tracker_Gap, Pref\tracker_gap)
    SetGadgetState(#G_TB_Preferences_Tracker_Spacing, Pref\tracker_spacing)
    
    SetGadgetText(#G_SR_Preferences_Tracker_MinWidth, Str(Pref\tracker_minw))
    SetGadgetText(#G_SR_Preferences_Tracker_MinHeight, Str(Pref\tracker_minh))
    
    SetGadgetText(#G_TX_Preferences_Tracker_Time, "Einblendzeit (" + Str(Pref\tracker_showtime / 1000) + " Sekunden)")
    SetGadgetState(#G_TB_Preferences_Tracker_Time, Pref\tracker_showtime / 1000)
    
    SetGadgetState(#G_CB_Preferences_Tracker_Position, Pref\tracker_corner - 1)
    
    SetGadgetState(#G_CB_Preferences_Tracker_Align, Pref\tracker_align)
    
    SetGadgetText(#G_SR_Preferences_Tracker_Text, Pref\tracker_text)
    
    ;Order
    If Task\timeout = 0
      SetGadgetText(#G_TX_Preferences_Order_TimeOut, "Verzögerung (Aus)")
    Else
      SetGadgetText(#G_TX_Preferences_Order_TimeOut, "Verzögerung (" + Str(Task\timeout / 1000) + " Sek.)")
    EndIf
    SetGadgetState(#G_TB_Preferences_Order_TimeOut, Task\timeout / 1000)
    
    ;MediaLib
    ClearGadgetItems(#G_LV_Preferences_MediaLib_Path)
    ForEach MediaLib_Path()
      AddGadgetItem(#G_LV_Preferences_MediaLib_Path, -1, MediaLib_Path())
    Next
    
    If IsThread(MediaLibScan\Thread)
      DisableGadget(#G_BI_Preferences_MediaLib_PathAdd, 1)
      DisableGadget(#G_BI_Preferences_MediaLib_PathRem, 1)
      DisableGadget(#G_BI_Preferences_MediaLib_FindInvalidFiles, 1)
      SetGadgetAttribute(#G_BI_Preferences_MediaLib_Scan, #PB_Button_Image, ImageList(#ImageList_Remove))
      GadgetToolTip(#G_BI_Preferences_MediaLib_Scan, "Abbrechen")
    EndIf
    
    SetGadgetState(#G_CH_Preferences_MediaLib_CPUScan, Pref\medialib_cpugentle)
    SetGadgetState(#G_CH_Preferences_MediaLib_AddPlayFile, Pref\medialib_addplayfiles)
    SetGadgetState(#G_CH_Preferences_MediaLib_BackgroundScan, Pref\medialib_backgroundscan)
    SetGadgetState(#G_CH_Preferences_MediaLib_StartEntryCheck, Pref\medialib_startcheck)
    SetGadgetState(#G_CH_Preferences_MediaLib_CheckFileExtension, Pref\medialib_checkextension)
    
    ;Misc
    SetGadgetState(#G_CH_Preferences_Misc_Clipboard, Pref\misc_clipboard)
    SetGadgetState(#G_CH_Preferences_Misc_DropClear, Pref\misc_dropclear)
    SetGadgetState(#G_CH_Preferences_Misc_SavePlayList, Pref\pl_auto)
    SetGadgetState(#G_CH_Preferences_Misc_AutoSavePreferences, Pref\misc_autosave_pf)
    SetGadgetState(#G_CH_Preferences_Misc_AutoSavePlayList, Pref\misc_autosave_pl)
    SetGadgetState(#G_CH_Preferences_Misc_AutoSaveMediaLib, Pref\misc_autosave_ml)
    SetGadgetState(#G_SP_Preferences_Misc_AutoSaveIntervall, (Pref\misc_autosave_time / 1000) / 60)
    SetGadgetState(#G_CH_Preferences_Misc_AskBeforeEnd, Pref\endquestion)
    SetGadgetState(#G_CH_Preferences_Misc_RecursiveFolder, Pref\recursivfolder)
    SetGadgetState(#G_CH_Preferences_Misc_TastBar, Pref\taskbar)
    SetGadgetState(#G_CH_Preferences_Misc_StartCheckUpdate, Pref\startversioncheck)
    SetGadgetState(#G_CH_Preferences_Misc_ActivateLogging, Pref\enablelogging)
    SetGadgetState(#G_CH_Preferences_Misc_ChangeMSN, Pref\misc_changemsn)
    SetGadgetState(#G_CH_Preferences_Misc_PlayLastPlay, Pref\misc_playlastplay)
    
    ;Plugins
    Plugin_ClearLists()
    Plugin_RefreshLists()
    
    ForEach Plugin()
      If Plugin()\start
        SetGadgetItemState(#G_LI_Preferences_Plugins_RunPlugins, ListIndex(Plugin()), #PB_ListIcon_Checked)
      EndIf
    Next
    
    ; Backups
    If IsThread(CreateBackup\Thread)
       DisableGadget(#G_BN_Preferences_Backups_Create, 1)
    EndIf
    
  EndIf
EndProcedure

; Wird bei Übernehmen und OK von Einstellungen aufgerufen
Procedure Preferences_Apply()
  If IsWindow(#Win_Preferences)
    If GetGadgetData(#G_BN_Preferences_Use) = 0
      Protected iNext.i
      
      ;Bass
      If BASS_GetDevice() - 1 Or Pref\bass_device <> GetGadgetState(#G_CB_Preferences_Bass_OutputDevice) Or Pref\bass_rate <> GetGadgetState(#G_CB_Preferences_Bass_OutputRate)
        Bass_InitSystem(GetGadgetState(#G_CB_Preferences_Bass_OutputDevice), GetGadgetState(#G_CB_Preferences_Bass_OutputRate))
      EndIf
      
      Pref\bass_fadein     = GetGadgetState(#G_TB_Preferences_Bass_FadeIn)
      Pref\bass_fadeout    = GetGadgetState(#G_TB_Preferences_Bass_FadeOut)
      Pref\bass_fadeoutend = GetGadgetState(#G_TB_Preferences_Bass_FadeOutEnd)
      Pref\bass_midisf2    = GetGadgetText(#G_SR_Preferences_Bass_MidiSF2File)
      Pref\bass_midilyrics = GetGadgetState(#G_CH_Preferences_Bass_MidiLyrics)
      If Pref\bass_midilyrics = 0
        CloseWindow_MidiLyrics()
        ClearList(MidiLyrics())
      EndIf
      
      Pref\bass_preview = GetGadgetState(#G_TB_Preferences_Bass_PreviewTime)
      
      ;Inet Stream
      Pref\inetstream_savefile = GetGadgetState(#G_CH_Preferences_InetStream_SaveFile)
      Pref\inetstream_savepath = GetGadgetText(#G_SR_Preferences_InetStream_FilePath)
      
      If GetGadgetState(#G_OP_Preferences_InetStream_Title)
        Pref\inetstream_savename = 0
      Else
        Pref\inetstream_savename = 1
      EndIf
      
      If GetGadgetState(#G_TB_Preferences_InetStream_TimeOut) <> Pref\inetstream_timeout
        Pref\inetstream_timeout = GetGadgetState(#G_TB_Preferences_InetStream_TimeOut)
        BASS_SetConfig(#BASS_CONFIG_NET_TIMEOUT, Pref\inetstream_timeout * 1000)
      EndIf
      
      If GetGadgetState(#G_TB_Preferences_InetStream_Buffer) <> Pref\inetstream_buffer
        Pref\inetstream_buffer = GetGadgetState(#G_TB_Preferences_InetStream_Buffer)
        BASS_SetConfig(#BASS_CONFIG_NET_BUFFER, Pref\inetstream_buffer * 1000)
      EndIf
      
      If GetGadgetText(#G_SR_Preferences_InetStream_ProxyServer) <> Pref\inetstream_proxyserver
        Pref\inetstream_proxyserver = Trim(GetGadgetText(#G_SR_Preferences_InetStream_ProxyServer))
        BASS_SetConfigPtr(#BASS_CONFIG_NET_PROXY, Pref\inetstream_proxyserver)
      EndIf
      
      ;GUI
      If Pref\ontop <> GetGadgetState(#G_CH_Preferences_GUI_AlwaysOnTop)
        Pref\ontop = GetGadgetState(#G_CH_Preferences_GUI_AlwaysOnTop)
        StickyWindow(#Win_Main, Pref\ontop)
      EndIf
      
      If Pref\opacity <> GetGadgetState(#G_CH_Preferences_GUI_Opacity) Or Pref\opacityval <> GetGadgetState(#G_TB_Preferences_GUI_OpacityValue)
        Pref\opacity    = GetGadgetState(#G_CH_Preferences_GUI_Opacity)
        Pref\opacityval = GetGadgetState(#G_TB_Preferences_GUI_OpacityValue)
        Window_ChangeOpacity()
      EndIf
      
      Pref\magnetic     = GetGadgetState(#G_CH_Preferences_GUI_Magnetic)
      Pref\magneticval  = GetGadgetState(#G_TB_Preferences_GUI_MagneticValue)
      
      WndEx_SetMagneticValue(Pref\magneticval)
      
      If Pref\autoclnw_pl <> GetGadgetState(#G_CH_Preferences_GUI_AutoColumnPL)
        Pref\autoclnw_pl = GetGadgetState(#G_CH_Preferences_GUI_AutoColumnPL)
        PlayList_RefreshHeader()
      EndIf
      
      If Pref\autoclnw_ml <> GetGadgetState(#G_CH_Preferences_GUI_AutoColumnML)
        Pref\autoclnw_ml = GetGadgetState(#G_CH_Preferences_GUI_AutoColumnML)
        MediaLib_RefreshHeader()
      EndIf
      
      Pref\lengthformat = Trim(GetGadgetText(#G_CB_Preferences_GUI_LengthFormat))
      
      Pref\gui_autocomplete = GetGadgetState(#G_CH_Preferences_GUI_AutoComplete)
      
      Pref\spectrum = GetGadgetState(#G_CB_Preferences_GUI_SpectrumType)
      
      For iNext = 0 To #Color_Last - 1
        Pref\color[iNext] = GetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iNext, #PB_Gadget_BackColor, 1)
      Next
      Window_ChangeColor()
      
      For iNext = 0 To #Font_Last
        If GetGadgetItemState(#G_LI_Preferences_GUI_FontsOverview, iNext) & #PB_ListIcon_Checked
          GUIFont(iNext)\activ = 1
        Else
          GUIFont(iNext)\activ = 0
        EndIf
        GUIFont(iNext)\font = GetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iNext, 1)
        GUIFont(iNext)\size = Val(GetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iNext, 2))
      Next
      
      Preferences_ReloadFonts()
      Window_ChangeFonts()
      
      ;HotKey
      Pref\sk_enablemedia = GetGadgetState(#G_CH_Preferences_HotKey_EnableMediaKeys)
      Pref\sk_enableglobal = GetGadgetState(#G_CH_Preferences_HotKey_EnableGlobal)
      
      If Pref\sk_enableglobal
        DisableGadget(#G_LI_Preferences_HotKey_Overview, 0)
      Else
        DisableGadget(#G_LI_Preferences_HotKey_Overview, 1)
        SetGadgetState(#G_LI_Preferences_HotKey_Overview, -1)
        DisableGadget(#G_CH_Preferences_HotKey_Control, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Control, 0)
        DisableGadget(#G_CH_Preferences_HotKey_Menu, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Menu, 0)
        DisableGadget(#G_CH_Preferences_HotKey_Shift, 1) : SetGadgetState(#G_CH_Preferences_HotKey_Shift, 0)
        DisableGadget(#G_CB_Preferences_HotKey_Misc, 1) : SetGadgetState(#G_CB_Preferences_HotKey_Misc, 0)
      EndIf
      
      For iNext = 0 To ArraySize(HotKey())
        HotKey(iNext)\active[0]  = HotKey(iNext)\active[1]
        HotKey(iNext)\control[0] = HotKey(iNext)\control[1]
        HotKey(iNext)\menu[0]    = HotKey(iNext)\menu[1]
        HotKey(iNext)\shift[0]   = HotKey(iNext)\shift[1]
        HotKey(iNext)\misc[0]    = HotKey(iNext)\misc[1]
        SetGadgetItemText(#G_LI_Preferences_HotKey_Overview, iNext, GetHotkeyName(iNext), 1)
      Next
      
      ;FileLink
      iNext = -1
      ResetMap(FileType())
      While NextMapElement(FileType())
        iNext + 1
        If GetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext)
          RegisterFile(FileType()\ext, #PrgName, ProgramFilename() + " %1")
          SetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext, 0)
        EndIf
      Wend
      
      ;Tracker
      Pref\tracker_enable = GetGadgetState(#G_CH_Preferences_Tracker_Enable)
      If Pref\tracker_enable = 0 : CloseWindow_Tracker() : EndIf
      
      Pref\tracker_gap = GetGadgetState(#G_TB_Preferences_Tracker_Gap)
      
      Pref\tracker_spacing = GetGadgetState(#G_TB_Preferences_Tracker_Spacing)
      
      Pref\tracker_minw = Val(GetGadgetText(#G_SR_Preferences_Tracker_MinWidth))
      Pref\tracker_minh = Val(GetGadgetText(#G_SR_Preferences_Tracker_MinHeight))
      
      Pref\tracker_showtime = GetGadgetState(#G_TB_Preferences_Tracker_Time) * 1000
      
      Pref\tracker_corner = GetGadgetState(#G_CB_Preferences_Tracker_Position) + 1
      
      Pref\tracker_align = GetGadgetState(#G_CB_Preferences_Tracker_Align)
      
      Pref\tracker_text = GetGadgetText(#G_SR_Preferences_Tracker_Text)
      
      ; Medienbibliothek
      If IsThread(MediaLibScan\Thread) = 0
        ClearList(MediaLib_Path())
        For iNext = 0 To CountGadgetItems(#G_LV_Preferences_MediaLib_Path) - 1
          AddElement(MediaLib_Path())
          MediaLib_Path() = GetGadgetItemText(#G_LV_Preferences_MediaLib_Path, iNext)
        Next
      EndIf
      
      Pref\medialib_cpugentle = GetGadgetState(#G_CH_Preferences_MediaLib_CPUScan)
      Pref\medialib_addplayfiles = GetGadgetState(#G_CH_Preferences_MediaLib_AddPlayFile)
      Pref\medialib_backgroundscan = GetGadgetState(#G_CH_Preferences_MediaLib_BackgroundScan)
      Pref\medialib_startcheck = GetGadgetState(#G_CH_Preferences_MediaLib_StartEntryCheck)
      Pref\medialib_checkextension = GetGadgetState(#G_CH_Preferences_MediaLib_CheckFileExtension)
      
      ; Aufgaben
      Task\timeout = GetGadgetState(#G_TB_Preferences_Order_TimeOut) * 1000
      
      ; Sonstiges
      Pref\misc_clipboard = GetGadgetState(#G_CH_Preferences_Misc_Clipboard)
      Pref\misc_dropclear = GetGadgetState(#G_CH_Preferences_Misc_DropClear)
      Pref\pl_auto = GetGadgetState(#G_CH_Preferences_Misc_SavePlayList)
      Pref\misc_autosave_pf = GetGadgetState(#G_CH_Preferences_Misc_AutoSavePreferences)
      Pref\misc_autosave_pl = GetGadgetState(#G_CH_Preferences_Misc_AutoSavePlayList)
      Pref\misc_autosave_ml = GetGadgetState(#G_CH_Preferences_Misc_AutoSaveMediaLib)
      Pref\misc_autosave_time = (GetGadgetState(#G_SP_Preferences_Misc_AutoSaveIntervall) * 60) * 1000
      Pref\endquestion = GetGadgetState(#G_CH_Preferences_Misc_AskBeforeEnd)
      Pref\recursivfolder = GetGadgetState(#G_CH_Preferences_Misc_RecursiveFolder)
      
      If Pref\taskbar <> GetGadgetState(#G_CH_Preferences_Misc_TastBar)
        Pref\taskbar = GetGadgetState(#G_CH_Preferences_Misc_TastBar)
        Window_RefreshTaskBar()
      EndIf
      
      Pref\startversioncheck = GetGadgetState(#G_CH_Preferences_Misc_StartCheckUpdate)
      
      Pref\enablelogging = GetGadgetState(#G_CH_Preferences_Misc_ActivateLogging)
      If Pref\enablelogging = 0
        CloseWindow_Log()
        ClearList(Logging())
      EndIf
      
      Pref\misc_changemsn = GetGadgetState(#G_CH_Preferences_Misc_ChangeMSN)
      If Pref\misc_changemsn = 0
        ChangeMSNStatus(0, "Music", "")
      EndIf
      
      Pref\misc_playlastplay = GetGadgetState(#G_CH_Preferences_Misc_PlayLastPlay)
      
      ; Plugins
      ForEach Plugin()
        If GetGadgetItemState(#G_LI_Preferences_Plugins_RunPlugins, ListIndex(Plugin())) & #PB_ListIcon_Checked
          Plugin()\start = 1
        Else
          Plugin()\start = 0
        EndIf
      Next
      
    EndIf
  EndIf
EndProcedure

; Hier wird geprüft ob die eingestellten Einstellungen im Fenster sich von den gespeicherten Werten unterscheiden
; Speert z.B. den Übernehmen Button!
Procedure Preferences_CheckApply()
  If IsWindow(#Win_Preferences)
    Protected iNext.i
    Protected iEnable.i = 1
    
    ; Bass
    If BASS_GetDevice() <> GetGadgetState(#G_CB_Preferences_Bass_OutputDevice)
      iEnable = 0
    EndIf
    
    If Pref\bass_rate <> GetGadgetState(#G_CB_Preferences_Bass_OutputRate)
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_TB_Preferences_Bass_FadeIn) <> Pref\bass_fadein
      iEnable = 0
    EndIf
    If GetGadgetState(#G_TB_Preferences_Bass_FadeOut) <> Pref\bass_fadeout
      iEnable = 0
    EndIf
    If GetGadgetState(#G_TB_Preferences_Bass_FadeOutEnd) <> Pref\bass_fadeoutend
      iEnable = 0
    EndIf
    
    If GetGadgetText(#G_SR_Preferences_Bass_MidiSF2File) <> Pref\bass_midisf2
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_CH_Preferences_Bass_MidiLyrics) <> Pref\bass_midilyrics
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_TB_Preferences_Bass_PreviewTime) <> Pref\bass_preview
      iEnable = 0
    EndIf
    
    ; Internet Stream
    If GetGadgetText(#G_SR_Preferences_InetStream_FilePath) <> Pref\inetstream_savepath
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_OP_Preferences_InetStream_Title) = 1 And Pref\inetstream_savename <> 0
      iEnable = 0
    EndIf
    If GetGadgetState(#G_OP_Preferences_InetStream_Full) = 1 And Pref\inetstream_savename <> 1
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_TB_Preferences_InetStream_TimeOut) <> Pref\inetstream_timeout
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_TB_Preferences_InetStream_Buffer) <> Pref\inetstream_buffer
      iEnable = 0
    EndIf
    
    If GetGadgetText(#G_SR_Preferences_InetStream_ProxyServer) <> Pref\inetstream_proxyserver
      iEnable = 0
    EndIf
    
    ; GUI
    If GetGadgetState(#G_CH_Preferences_GUI_AlwaysOnTop) <> Pref\ontop
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_CH_Preferences_GUI_Opacity) <> Pref\opacity
      iEnable = 0
    EndIf
    If GetGadgetState(#G_TB_Preferences_GUI_OpacityValue) <> Pref\opacityval
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_CH_Preferences_GUI_Magnetic) <> Pref\magnetic
      iEnable = 0
    EndIf
    If GetGadgetState(#G_TB_Preferences_GUI_MagneticValue) <> Pref\magneticval
      iEnable = 0
    EndIf
    
    If GetGadgetState(#G_CH_Preferences_GUI_AutoColumnPL) <> Pref\autoclnw_pl
      iEnable = 0
    EndIf
    If GetGadgetState(#G_CH_Preferences_GUI_AutoColumnML) <> Pref\autoclnw_ml
      iEnable = 0
    EndIf
    
    If GetGadgetText(#G_CB_Preferences_GUI_LengthFormat) <> Pref\lengthformat
      iEnable = 0
    EndIf
    
    If Pref\gui_autocomplete <> GetGadgetState(#G_CH_Preferences_GUI_AutoComplete)
      iEnable = 0
    EndIf
    
    If Pref\spectrum <> GetGadgetState(#G_CB_Preferences_GUI_SpectrumType)
      iEnable = 0
    EndIf
    
    For iNext = 0 To #Color_Last - 1
      If Pref\color[iNext] <> GetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iNext, #PB_Gadget_BackColor, 1)
        iEnable = 0
      EndIf
    Next
    
    For iNext = 0 To #Font_Last
      If GetGadgetItemState(#G_LI_Preferences_GUI_FontsOverview, iNext) & #PB_ListIcon_Checked
        If GUIFont(iNext)\activ <> 1
          iEnable = 0
        EndIf
      Else
        If GUIFont(iNext)\activ <> 0
          iEnable = 0
        EndIf
      EndIf
      If GUIFont(iNext)\font <> GetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iNext, 1)
        iEnable = 0
      EndIf
      If GUIFont(iNext)\size <> Val(GetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iNext, 2))
        iEnable = 0
      EndIf
    Next
    
    ; HotKeys
    If Pref\sk_enableglobal <> GetGadgetState(#G_CH_Preferences_HotKey_EnableGlobal)
      iEnable = 0
    EndIf
    If Pref\sk_enablemedia <> GetGadgetState(#G_CH_Preferences_HotKey_EnableMediaKeys)
      iEnable = 0
    EndIf
    
    For iNext = 0 To ArraySize(HotKey())
      If HotKey(iNext)\active[0] <> HotKey(iNext)\active[1]
        iEnable = 0
      EndIf
      If HotKey(iNext)\control[0] <> HotKey(iNext)\control[1]
        iEnable = 0
      EndIf      
      If HotKey(iNext)\menu[0] <> HotKey(iNext)\menu[1]
        iEnable = 0
      EndIf
      If HotKey(iNext)\shift[0] <> HotKey(iNext)\shift[1]
        iEnable = 0
      EndIf
      If HotKey(iNext)\misc[0] <> HotKey(iNext)\misc[1]
        iEnable = 0
      EndIf
    Next
    
    ; File Link
    For iNext = 0 To CountGadgetItems(#G_LI_Preferences_Filelink_OverView) - 1
      If GetGadgetItemState(#G_LI_Preferences_Filelink_OverView, iNext) & #PB_ListIcon_Checked
        iEnable = 0
        Break
      EndIf
    Next
    
    ; Tracker
    If Pref\tracker_enable <> GetGadgetState(#G_CH_Preferences_Tracker_Enable)
      iEnable = 0
    EndIf
    If Pref\tracker_gap <> GetGadgetState(#G_TB_Preferences_Tracker_Gap)
      iEnable = 0
    EndIf
    If Pref\tracker_spacing <> GetGadgetState(#G_TB_Preferences_Tracker_Spacing)
      iEnable = 0
    EndIf
    If Pref\tracker_minw <> Val(GetGadgetText(#G_SR_Preferences_Tracker_MinWidth))
      iEnable = 0
    EndIf
    If Pref\tracker_minh <> Val(GetGadgetText(#G_SR_Preferences_Tracker_MinHeight))
      iEnable = 0
    EndIf
    If Pref\tracker_showtime / 1000 <> GetGadgetState(#G_TB_Preferences_Tracker_Time)
      iEnable = 0
    EndIf
    If Pref\tracker_corner <> GetGadgetState(#G_CB_Preferences_Tracker_Position) + 1
      iEnable = 0
    EndIf
    If Pref\tracker_align <> GetGadgetState(#G_CB_Preferences_Tracker_Align)
      iEnable = 0
    EndIf
    If Pref\tracker_text <> GetGadgetText(#G_SR_Preferences_Tracker_Text)
      iEnable = 0
    EndIf
    
    ; Medienbibliothek
    If CountGadgetItems(#G_LV_Preferences_MediaLib_Path) <> ListSize(MediaLib_Path())
      iEnable = 0
    Else
      ForEach MediaLib_Path()
        If LCase(MediaLib_Path()) <> LCase(GetGadgetItemText(#G_LV_Preferences_MediaLib_Path, ListIndex(MediaLib_Path())))
          iEnable = 0
        EndIf
      Next
    EndIf
    
    If Pref\medialib_cpugentle <> GetGadgetState(#G_CH_Preferences_MediaLib_CPUScan)
      iEnable = 0
    EndIf
    
    If Pref\medialib_addplayfiles <> GetGadgetState(#G_CH_Preferences_MediaLib_AddPlayFile)
     iEnable = 0
    EndIf
    
    If Pref\medialib_backgroundscan <> GetGadgetState(#G_CH_Preferences_MediaLib_BackgroundScan)
      iEnable = 0
    EndIf
    
    If Pref\medialib_startcheck <> GetGadgetState(#G_CH_Preferences_MediaLib_StartEntryCheck)
      iEnable = 0
    EndIf
    
    If Pref\medialib_checkextension <> GetGadgetState(#G_CH_Preferences_MediaLib_CheckFileExtension)
      iEnable = 0
    EndIf
    
    ; Order
    If Task\timeout <> GetGadgetState(#G_TB_Preferences_Order_TimeOut) * 1000
      iEnable = 0
    EndIf
    
    ; Misc
    If Pref\misc_clipboard <> GetGadgetState(#G_CH_Preferences_Misc_Clipboard)
      iEnable = 0
    EndIf
    
    If Pref\misc_dropclear <> GetGadgetState(#G_CH_Preferences_Misc_DropClear)
      iEnable = 0
    EndIf
    
    If Pref\pl_auto <> GetGadgetState(#G_CH_Preferences_Misc_SavePlayList)
      iEnable = 0
    EndIf
    
    If Pref\misc_autosave_pf <> GetGadgetState(#G_CH_Preferences_Misc_AutoSavePreferences)
      iEnable = 0
    EndIf
    If Pref\misc_autosave_pl <> GetGadgetState(#G_CH_Preferences_Misc_AutoSavePlayList)
      iEnable = 0
    EndIf
    If Pref\misc_autosave_ml <> GetGadgetState(#G_CH_Preferences_Misc_AutoSaveMediaLib)
      iEnable = 0
    EndIf
    If Pref\misc_autosave_time <> (GetGadgetState(#G_SP_Preferences_Misc_AutoSaveIntervall) * 60) * 1000
      iEnable = 0
    EndIf
    
    If Pref\endquestion <> GetGadgetState(#G_CH_Preferences_Misc_AskBeforeEnd)
      iEnable = 0
    EndIf
    
    If Pref\recursivfolder <> GetGadgetState(#G_CH_Preferences_Misc_RecursiveFolder)
      iEnable = 0
    EndIf
    
    If Pref\taskbar <> GetGadgetState(#G_CH_Preferences_Misc_TastBar)
      iEnable = 0
    EndIf
    
    If Pref\startversioncheck <> GetGadgetState(#G_CH_Preferences_Misc_StartCheckUpdate)
      iEnable = 0
    EndIf
    
    If Pref\enablelogging <> GetGadgetState(#G_CH_Preferences_Misc_ActivateLogging)
      iEnable = 0
    EndIf
    
    If Pref\misc_changemsn <> GetGadgetState(#G_CH_Preferences_Misc_ChangeMSN)
      iEnable = 0
    EndIf
    
    If Pref\misc_playlastplay <> GetGadgetState(#G_CH_Preferences_Misc_PlayLastPlay)
      iEnable = 0
    EndIf
    
    ; Plugins
    ForEach Plugin()
      If GetGadgetItemState(#G_LI_Preferences_Plugins_RunPlugins, ListIndex(Plugin())) & #PB_ListIcon_Checked
        If Plugin()\start = 0
          iEnable = 0 : Break
        EndIf
      Else
        If Plugin()\start = 1
          iEnable = 0 : Break
        EndIf
      EndIf
    Next
    
    ; Enable
    DisableGadget(#G_BN_Preferences_Use, iEnable)
    SetGadgetData(#G_BN_Preferences_Use, iEnable)
  EndIf
EndProcedure

Procedure Preferences_ChangeArea(SetSel)
  Static iSel.i
  
  If GetGadgetState(#G_LV_Preferences_Menu) <> iSel
    
    If SetSel = -1
      SetSel = Pref\prefarea
    EndIf
    
    iSel = SetSel
    
    ;Hide
    HideGadget(#G_SA_Preferences_Bass, 1)
    HideGadget(#G_SA_Preferences_InetStream, 1)
    HideGadget(#G_CN_Preferences_GUI, 1)
    HideGadget(#G_CN_Preferences_HotKey, 1)
    HideGadget(#G_CN_Preferences_Filelink, 1)
    HideGadget(#G_CN_Preferences_Tracker, 1)
    HideGadget(#G_CN_Preferences_MediaLib, 1)
    HideGadget(#G_CN_Preferences_Order, 1)
    HideGadget(#G_SA_Preferences_Misc, 1)
    HideGadget(#G_CN_Preferences_Plugins, 1)
    HideGadget(#G_CN_Preferences_Backups, 1)
    
    ;Show
    Select iSel
      Case #PrefArea_Bass
        SetGadgetAttribute(#G_SA_Preferences_Bass, #PB_ScrollArea_Y, 0)
        HideGadget(#G_SA_Preferences_Bass, 0)
      Case #PrefArea_InetStream
        SetGadgetAttribute(#G_SA_Preferences_InetStream, #PB_ScrollArea_Y, 0)
        HideGadget(#G_SA_Preferences_InetStream, 0)
      Case #PrefArea_GUI
        HideGadget(#G_CN_Preferences_GUI, 0)
      Case #PrefArea_HotKey
        HideGadget(#G_CN_Preferences_HotKey, 0)
      Case #PrefArea_Filelink
        HideGadget(#G_CN_Preferences_Filelink, 0)
      Case #PrefArea_Tracker
        HideGadget(#G_CN_Preferences_Tracker, 0)
      Case #PrefArea_MediaLib
        HideGadget(#G_CN_Preferences_MediaLib, 0)
      Case #PrefArea_Order
        HideGadget(#G_CN_Preferences_Order, 0)
      Case #PrefArea_Misc
        SetGadgetAttribute(#G_SA_Preferences_Misc, #PB_ScrollArea_Y, 0)
        HideGadget(#G_SA_Preferences_Misc, 0)
      Case #PrefArea_Plugins
        HideGadget(#G_CN_Preferences_Plugins, 0)
      Case #PrefArea_Backups
        Backup_RefreshOverview()
        HideGadget(#G_CN_Preferences_Backups, 0)
    EndSelect
    
    SetGadgetText(#G_TX_Preferences_Title, " - " + GetGadgetItemText(#G_LV_Preferences_Menu, iSel) + " - ")
    
    SetGadgetState(#G_LV_Preferences_Menu, iSel)
  EndIf
  
EndProcedure

Procedure Preferences_ChangeLayout()
  If IsWindow(#Win_Preferences)
    Protected iSel.i, iColor.i, iNext.i
    
    iSel = GetGadgetState(#G_LI_Preferences_GUI_Layout)
    If iSel <> -1
      
      For iNext = 0 To CountGadgetItems(#G_LI_Preferences_GUI_Layout)
        Colors(iNext + 1) = GetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iNext, #PB_Gadget_BackColor, 1)
      Next
      
      iColor = GetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iSel, #PB_Gadget_BackColor, 1)
      iColor = ColorRequesterEx(WinSize(#Win_Preferences)\winid, iColor, @Colors())
      
      If iColor > -1
        SetGadgetItemColor(#G_LI_Preferences_GUI_Layout, iSel, #PB_Gadget_BackColor, iColor, 1)
      EndIf
      
      SetGadgetState(#G_LI_Preferences_GUI_Layout, -1)
    EndIf
  EndIf
EndProcedure

Procedure Preferences_ChangeFont()
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LI_Preferences_GUI_FontsOverview)
  If iSel > -1 And iSel <= ArraySize(GUIFont())
    
    If FontRequester(GUIFont(iSel)\font, GUIFont(iSel)\size, 0)
      
      If IsWindow(#Win_Preferences)
        SetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iSel, SelectedFontName(), 1)
        SetGadgetItemText(#G_LI_Preferences_GUI_FontsOverview, iSel, Str(SelectedFontSize()), 2)
      EndIf
    EndIf
    
  EndIf
EndProcedure

Procedure Preferences_ChangeHotKeyState()
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LI_Preferences_HotKey_Overview)
  If iSel = -1
    DisableGadget(#G_CH_Preferences_HotKey_Control, 1)
    DisableGadget(#G_CH_Preferences_HotKey_Menu, 1)
    DisableGadget(#G_CH_Preferences_HotKey_Shift, 1)
    DisableGadget(#G_CB_Preferences_HotKey_Misc, 1)
    SetGadgetState(#G_CH_Preferences_HotKey_Control, 0)
    SetGadgetState(#G_CH_Preferences_HotKey_Menu, 0)
    SetGadgetState(#G_CH_Preferences_HotKey_Shift, 0)
    SetGadgetState(#G_CB_Preferences_HotKey_Misc, 0)
  Else
    DisableGadget(#G_CH_Preferences_HotKey_Control, 0)
    DisableGadget(#G_CH_Preferences_HotKey_Menu, 0)
    DisableGadget(#G_CH_Preferences_HotKey_Shift, 0)
    DisableGadget(#G_CB_Preferences_HotKey_Misc, 0)
    
    If GetGadgetItemState(#G_LI_Preferences_HotKey_Overview, iSel) & #PB_ListIcon_Checked
      HotKey(iSel)\active[1] = 1
    Else
      HotKey(iSel)\active[1] = 0
    EndIf
    
    SetGadgetState(#G_CH_Preferences_HotKey_Control, HotKey(iSel)\control[1])
    SetGadgetState(#G_CH_Preferences_HotKey_Menu,    HotKey(iSel)\menu[1])
    SetGadgetState(#G_CH_Preferences_HotKey_Shift,   HotKey(iSel)\shift[1])
    SetGadgetState(#G_CB_Preferences_HotKey_Misc,    HotKey(iSel)\misc[1] + 1)
  EndIf
EndProcedure

Procedure Preferences_SetHotKeyState()
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LI_Preferences_HotKey_Overview)
  If iSel > -1
    HotKey(iSel)\control[1] = GetGadgetState(#G_CH_Preferences_HotKey_Control)
    HotKey(iSel)\menu[1]    = GetGadgetState(#G_CH_Preferences_HotKey_Menu)
    HotKey(iSel)\shift[1]   = GetGadgetState(#G_CH_Preferences_HotKey_Shift)
    
    If GetGadgetState(#G_CB_Preferences_HotKey_Misc) < 1
      HotKey(iSel)\misc[1] = -1
    Else
      HotKey(iSel)\misc[1] = GetGadgetState(#G_CB_Preferences_HotKey_Misc) - 1
    EndIf
  EndIf
  
EndProcedure

; Ändert den Speicherpfad für Radio-Aufnahme
Procedure Preferences_ChangeSaveFolder()
  Protected sFolder.s
  
  If FileSize(Pref\inetstream_savepath) = -2
    sFolder = Pref\inetstream_savepath
  Else
    sFolder = GetCurrentDirectory()
  EndIf
  
  sFolder = PathRequester("Speicher-Ordner", sFolder)
  If sFolder
    SetGadgetText(#G_SR_Preferences_InetStream_FilePath, sFolder)
  EndIf
EndProcedure

Procedure Preferences_ChangeMidiSF2File()
  Protected sFile.s
  
  sFile = OpenFileRequester("Datei Öffnen", GetCurrentDirectory(), "Midi Sound Font|*.sf2", 0)
  If sFile And sFile <> GetGadgetText(#G_SR_Preferences_Bass_MidiSF2File)
    If UCase(GetExtensionPart(sFile)) = "SF2"
      SetGadgetText(#G_SR_Preferences_Bass_MidiSF2File, sFile)
    Else
      MsgBox_Exclamation("Ungültiger Dateityp '" + sFile + "'")
    EndIf
  EndIf
EndProcedure

; Gibt 1 zurück falls sich der Path bereits in der Medienbibliothek Stammordner Liste befindet
Procedure Preferences_CheckPath(Path$)
  Protected iNext.i
  
  For iNext = 0 To CountGadgetItems(#G_LV_Preferences_MediaLib_Path) - 1
    If LCase(Path$) = LCase(GetGadgetItemText(#G_LV_Preferences_MediaLib_Path, iNext))
      ProcedureReturn 1
    EndIf
  Next
EndProcedure

; Fügt einen Medienbibliothek Stammordner hinzu
Procedure Preferences_AddPath()
  Protected sPath.s
  
  sPath = PathRequester("Ordner Hinzufügen", GetCurrentDirectory())
  If sPath
    AddGadgetItem(#G_LV_Preferences_MediaLib_Path, -1, sPath)
  EndIf
EndProcedure

; Entfernt einen Medienbibliothek Stammordner
Procedure Preferences_RemPath()
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LV_Preferences_MediaLib_Path)
  If iSel > -1
    RemoveGadgetItem(#G_LV_Preferences_MediaLib_Path, iSel)
  EndIf
EndProcedure

Procedure Statistics_RefreshArea()
  If IsWindow(#Win_Statistics)
    Select GetGadgetState(#G_TR_Statistics_Menu)
      
      Case 0 ; Allgemein
        ; Programmstarts
        SetGadgetItemText(#G_LI_Statistics_Overview, 0, Str(Statistics\app_start), 1)
        
      Case 1 ; Wiedergabe
        ; Wiedergabe gestartet
        SetGadgetItemText(#G_LI_Statistics_Overview, 0, Str(Statistics\play_start), 1)
        ; Wiedergabe beendet
        SetGadgetItemText(#G_LI_Statistics_Overview, 1, Str(Statistics\play_end), 1)
        ; Wiedergabezeit
        SetGadgetItemText(#G_LI_Statistics_Overview, 2, TimeString(Statistics\play_time), 1)
        ; Wiedergabetage
        SetGadgetItemText(#G_LI_Statistics_Overview, 3, Str(Statistics\play_days), 1)
        ; Wiedergabe pro Tag
        If Statistics\play_days > 0
          SetGadgetItemText(#G_LI_Statistics_Overview, 4, TimeString(Statistics\play_time / Statistics\play_days), 1)
        Else
          SetGadgetItemText(#G_LI_Statistics_Overview, 4, TimeString(Statistics\play_time), 1)
        EndIf
        
      Case 2 ; Medienbibliothek
        Protected iPlayed.i, qFullLength.q, qDiffLength.q, iPlayCounter.i
        Protected iInetStreams.i, iAudioFiles.i, iComments.i
        
        LockMutex(MediaLibScan\Mutex)
        
        If ListSize(MediaLibary()) > 0
          ForEach MediaLibary()
            
            If MediaLibary()\playcount > 0
              iPlayed + 1
              iPlayCounter + MediaLibary()\playcount
            EndIf
            qFullLength + MediaLibary()\tag\length
            
            If Trim(MediaLibary()\tag\comment) <> ""
              iComments + 1
            EndIf
            
            If Left(LCase(MediaLibary()\tag\file), 4) = "http" Or Left(LCase(MediaLibary()\tag\file), 3) = "ftp"
              iInetStreams + 1
            Else
              iAudioFiles + 1
            EndIf
            
          Next
          qDiffLength = qFullLength / ListSize(MediaLibary())
          
          ; Internet Streams
          SetGadgetItemText(#G_LI_Statistics_Overview, 0, Str(iInetStreams), 1)
          ; Audio Dateien
          SetGadgetItemText(#G_LI_Statistics_Overview, 1, Str(iAudioFiles), 1)
          ; Kommentare
          SetGadgetItemText(#G_LI_Statistics_Overview, 2, Str(iComments), 1)
          ; Wiedergabe Gestartet
          SetGadgetItemText(#G_LI_Statistics_Overview, 3, Str(iPlayCounter), 1)
          ; Medienbibliothek abgespielt
          SetGadgetItemText(#G_LI_Statistics_Overview, 4, Str(iPlayed) + " Tracks - (" + StrF(iPlayed * 100 / ListSize(MediaLibary()), 2) + "%)", 1)
          ; Wiedergabe
          SetGadgetItemText(#G_LI_Statistics_Overview, 5, TimeString(qFullLength), 1)
          ; Durchschnittliche Tracklänge
          SetGadgetItemText(#G_LI_Statistics_Overview, 6, TimeString(qDiffLength), 1)
        EndIf
        
        UnlockMutex(MediaLibScan\Mutex)
        
      Case 3 ; Internet Radio
        SetGadgetItemText(#G_LI_Statistics_Overview, 0, FormatByteSize(Statistics\radio_traffic), 1)
        
    EndSelect
  EndIf
EndProcedure

Procedure Statistics_ChangeArea()
  If IsWindow(#Win_Statistics)
    ClearGadgetItems(#G_LI_Statistics_Overview)
    Select GetGadgetState(#G_TR_Statistics_Menu)
      Case 0 ; Allgemein
        AddGadgetItem(#G_LI_Statistics_Overview, -1, #PrgName + " gestartet")
      Case 1 ; Wiedergabe
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Wiedergabe Gestartet")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Wiedergabe Beendet")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Gesamte Wiedergabedauer")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Widergabetage")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Wiedergabedauer pro Tag")
      Case 2 ; Medienbibliothek
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Internet Streams")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Audio Dateien")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Kommentare")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Wiedergabe Gestartet")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Abgespielte Einträge")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Wiedergabedauer")
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Durchschnittliche Tracklänge")
      Case 3 ; Internet Radio
        AddGadgetItem(#G_LI_Statistics_Overview, -1, "Datentraffic")
    EndSelect
    Statistics_RefreshArea()
  EndIf
EndProcedure

Procedure Statistics_Reset()
  If MessageRequester("Warnung", "Möchten Sie die Statistik wirklich zurücksetzen?", #MB_ICONQUESTION|#MB_YESNO) = #IDYES
    ClearStructure(@Statistics, _Statistics)
    
    Statistics_RefreshArea()
  EndIf
EndProcedure

; Kopiert aktuele Wiedergabeinformationen in die Zwischenablage
Procedure ChangeClipboardText(*Tag._CurrPlay)
  If Pref\misc_clipboard
    Protected sCurr.s
    
    sCurr = GetClipboardText()
    
    ; Nur Kopieren solange die Zwischenablage Leer oder bereits von BK beschrieben wurde
    If sCurr = "" Or Left(LCase(sCurr), 6) = "bl_ct:"
      sCurr = ""
      
      sCurr = "BL_CT:"
      sCurr + CurrPlay\file                + "|"
      sCurr + CurrPlay\tag\title           + "|"
      sCurr + CurrPlay\tag\artist          + "|"
      sCurr + CurrPlay\tag\album           + "|"
      sCurr + Str(CurrPlay\tag\year)       + "|"
      sCurr + CurrPlay\tag\comment         + "|"
      sCurr + Str(CurrPlay\tag\track)      + "|"
      sCurr + CurrPlay\tag\genre           + "|"
      sCurr + Str(CurrPlay\tag\bitrate)    + "|"
      sCurr + Str(CurrPlay\tag\samplerate) + "|"
      sCurr + Str(CurrPlay\tag\channels)   + "|"
      sCurr + Str(CurrPlay\tag\length)
      
      If sCurr : SetClipboardText(sCurr) : EndIf
    EndIf
    
  EndIf 
EndProcedure

Procedure AutoTag_CreateList()
  Protected iNext.i
  
  ClearList(AutoTag())
  
  If GetGadgetState(#G_LI_Main_PL_PlayList) > -1
    For iNext = 0 To CountGadgetItems(#G_LI_Main_PL_PlayList)
      If GetGadgetItemState(#G_LI_Main_PL_PlayList, iNext) & #PB_ListIcon_Selected
        If ListSize(PlayList()) >= iNext
          SelectElement(PlayList(), iNext)
          
          AddElement(AutoTag())
          AutoTag() = PlayList()\tag\file
        EndIf
      EndIf
    Next
  EndIf
EndProcedure

Procedure AutoTag_InitWindow()
  ClearGadgetItems(#G_LI_AutoTag_Overview)
  ForEach AutoTag()
    AddGadgetItem(#G_LI_AutoTag_Overview, -1, GetFilePart(AutoTag()))
    While WindowEvent() : Wend
  Next
  SendMessage_(GadgetID(#G_LI_AutoTag_Overview), #LVM_SETCOLUMNWIDTHA, 1, #LVSCW_AUTOSIZE_USEHEADER)
EndProcedure

Procedure AutoTag_Run(*Dummy)
  Protected T._Tag
  
  ForEach AutoTag()
  Next
EndProcedure

Procedure Feedback_CheckInputs(Gadget = -1)
  If IsWindow(#Win_Feedback)
    Protected sTemp.s
    Protected iError.i
    
    ; Name
    If Gadget = -1 Or Gadget = #G_SR_Feedback_Name
      sTemp = Trim(GetGadgetText(#G_SR_Feedback_Name))
      If sTemp = ""
        iError + 1
        SetGadgetState(#G_IG_Feedback_Name, ImageList(#ImageList_Remove2))
      Else
        SetGadgetState(#G_IG_Feedback_Name, ImageList(#ImageList_Success))
      EndIf
    EndIf
    
    ; E-Mail
    If Gadget = -1 Or Gadget = #G_SR_Feedback_Mail
      sTemp = Trim(GetGadgetText(#G_SR_Feedback_Mail))
      sTemp = RemoveString(sTemp, " ")
      If sTemp = "" Or FindString(sTemp, "@", 1) = 0 Or FindString(sTemp, ".", FindString(sTemp, "@", 1)) - 1 <= FindString(sTemp, "@", 1) Or Right(sTemp, 1) = "." Or Left(sTemp, 1) = "@"
        iError + 1
        SetGadgetState(#G_IG_Feedback_Mail, ImageList(#ImageList_Remove2))
      Else
        SetGadgetState(#G_IG_Feedback_Mail, ImageList(#ImageList_Success))
      EndIf
    EndIf
    
    ; Betreff
    If Gadget = -1 Or Gadget = #G_CB_Feedback_Subject
      sTemp = Trim(GetGadgetText(#G_CB_Feedback_Subject))
      If sTemp = ""
        SetGadgetState(#G_IG_Feedback_Subject, ImageList(#ImageList_Remove2))
        iError + 1
      Else
        SetGadgetState(#G_IG_Feedback_Subject, ImageList(#ImageList_Success))
      EndIf
    EndIf
    
    ; Nachricht
    If Gadget = -1 Or Gadget = #G_SR_Feedback_Message
      sTemp = Trim(GetGadgetText(#G_SR_Feedback_Message))
      sTemp = RemoveString(sTemp, #CR$)
      sTemp = RemoveString(sTemp, #LF$)
      If sTemp = ""
        SetGadgetState(#G_IG_Feedback_Message, ImageList(#ImageList_Remove2))
        iError + 1
      Else
        SetGadgetState(#G_IG_Feedback_Message, ImageList(#ImageList_Success))
      EndIf
    EndIf
    
    If iError <> 0 Or iInitNetwork = 0
      DisableGadget(#G_BN_Feedback_Send, 1)
    Else
      DisableGadget(#G_BN_Feedback_Send, 0)
    EndIf
    
    ProcedureReturn iError
  EndIf
EndProcedure

Procedure Feedback_Reset()
  If IsWindow(#Win_Feedback)
    SetGadgetText(#G_SR_Feedback_Name, "")
    SetGadgetText(#G_SR_Feedback_Mail, "")
    SetGadgetState(#G_CB_Feedback_Subject, 0)
    SetGadgetText(#G_SR_Feedback_Message, "")
    
    Feedback_CheckInputs()
  EndIf
EndProcedure

Procedure Feedback_Send()
  If IsWindow(#Win_Feedback)
    Protected iError.i
    Protected sURL.s
    Protected sName.s
    Protected sMail.s
    Protected sSubject.s
    Protected sMessage.s
    
    ; Eingaben überprüfen
    sName    = Trim(GetGadgetText(#G_SR_Feedback_Name))
    sMail    = Trim(GetGadgetText(#G_SR_Feedback_Mail))
    sSubject = Trim(GetGadgetText(#G_CB_Feedback_Subject))
    sMessage = Trim(GetGadgetText(#G_SR_Feedback_Message))
    iError   = Feedback_CheckInputs()
    
    ; Nachricht Senden
    If iError = 0
      
      ; URL erzeugen
      sMessage = "BassKing Feedback:" + #CRLF$
      sMessage + "Name: " + sName + #CRLF$
      sMessage + "Mail: " + sMail + #CRLF$
      sMessage + "Betreff: " + sSubject + #CRLF$
      sMessage + "Nachricht:" + #CRLF$
      sMessage + Trim(GetGadgetText(#G_SR_Feedback_Message))
      
      sURL = #URLFeedbackDirect + "?betreff=BassKing Feedback: " + sSubject + "&nachricht=" + sMessage + "&mail=" + sMail
      sURL = URLEncoder(sURL)
      
      ; URL aufrufen
      If URLDownloadToFile_(0, @sURL, 0, 0, 0) = #S_OK
        CloseWindow_Feedback()
        MessageRequester("Feedback", "Ihr Feedback wurde erfolgreich versendet," + #CR$ + "Vielen Dank!", #MB_ICONINFORMATION|#MB_OK)
      Else
        MsgBox_Error("Feedback konnte nicht versendet werden")
      EndIf
      
    EndIf
    
  EndIf
EndProcedure

; Überprüft einen String auf korektheit für der speicherung in der eigenen Text-Datenbank
; Entfernt alle Zeichen die die Strukture davon zerstören könnten
Procedure.s CheckSaveString(String$)
  String$ = Trim(String$)
  
  If FindString(String$, "|", 1) > 0
    String$ = ReplaceString(String$, "|", " ")
  EndIf
  If FindString(String$, #CRLF$, 1) > 0
    String$ = ReplaceString(String$, #CRLF$, " ")
  EndIf
  If FindString(String$, #LFCR$, 1) > 0
    String$ = ReplaceString(String$, #LFCR$, " ")
  EndIf
  If FindString(String$, #CR$, 1) > 0
    String$ = ReplaceString(String$, #CR$, " ")
  EndIf
  If FindString(String$, #LF$, 1) > 0
    String$ = ReplaceString(String$, #LF$, " ")
  EndIf
  
  ProcedureReturn String$
EndProcedure

; Speichert die Wiedergabeliste ab
Procedure Save_PlayList(Msg)
  If Pref\pl_auto > 0
    Protected iFile.i

    iFile = CreateFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_PlayList)
    If iFile <> 0
      Log_Add("Schreibe Datei '" + AppDataDirectory() + #Folder_AppData + #FileName_PlayList + "'")
      
      WriteStringN(iFile, #FileString_Check + "-PLV2")
      
      ForEach PlayList()
        WriteString(iFile, "ETY:")
        WriteString(iFile, Trim(CheckSaveString(PlayList()\tag\file))    + "|")
        WriteString(iFile, Trim(CheckSaveString(PlayList()\tag\title))   + "|")
        WriteString(iFile, Trim(CheckSaveString(PlayList()\tag\artist))  + "|")
        WriteString(iFile, Trim(CheckSaveString(PlayList()\tag\album))   + "|")
        WriteString(iFile, Str(PlayList()\tag\year)                      + "|")
        WriteString(iFile, Trim(CheckSaveString(PlayList()\tag\comment)) + "|")
        WriteString(iFile, Str(PlayList()\tag\track)                     + "|")
        WriteString(iFile, Trim(CheckSaveString(PlayList()\tag\genre))   + "|")
        WriteString(iFile, Str(PlayList()\tag\bitrate)                   + "|")
        WriteString(iFile, Str(PlayList()\tag\samplerate)                + "|")
        WriteString(iFile, Str(PlayList()\tag\channels)                  + "|")
        WriteString(iFile, Str(PlayList()\tag\length)                    + "|")
        WriteString(iFile, Str(PlayList()\tag\cType)                     + "|")
        WriteString(iFile, #CRLF$)
      Next
      
      CloseFile(iFile)
    Else
      If Msg : MsgBox_Error("Playlist konnte nicht gespeichert werden" + #CRLF$ + "'" + AppDataDirectory() + #Folder_AppData + #FileName_PlayList + "'") : EndIf
    EndIf
  EndIf
EndProcedure

; Speichert die Medienbibliothek ab
Procedure Save_MediaLibary(Msg)
  LockMutex(MediaLibScan\Mutex)
  
  If ListSize(MediaLibary()) > 0
    Protected iPlayDays.i
    Protected iFile.i
    
    iFile = CreateFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + ".tmp")
    If iFile <> 0
      Log_Add("Schreibe Datei '" + AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + "'")
      
      WriteStringN(iFile, #FileString_Check + "-MLV1")
      
      ; MediaLibary
      ForEach MediaLibary_PlayList()
        WriteString(iFile, "ETP:")
        WriteString(iFile, MapKey(MediaLibary_PlayList())     + "|")
        WriteString(iFile, Str(MediaLibary_PlayList()\id))
        WriteString(iFile, #CRLF$)
      Next
      
      ForEach MediaLibary()
        WriteString(iFile, "ETY:")
        WriteString(iFile, MediaLibary()\tag\file             + "|")
        WriteString(iFile, MediaLibary()\tag\title            + "|")
        WriteString(iFile, MediaLibary()\tag\artist           + "|")
        WriteString(iFile, MediaLibary()\tag\album            + "|")
        WriteString(iFile, Str(MediaLibary()\tag\year)        + "|")
        WriteString(iFile, MediaLibary()\tag\comment          + "|")
        WriteString(iFile, Str(MediaLibary()\tag\track)       + "|")
        WriteString(iFile, MediaLibary()\tag\genre            + "|")
        WriteString(iFile, Str(MediaLibary()\tag\bitrate)     + "|")
        WriteString(iFile, Str(MediaLibary()\tag\samplerate)  + "|")
        WriteString(iFile, Str(MediaLibary()\tag\channels)    + "|")
        WriteString(iFile, Str(MediaLibary()\tag\length)      + "|")
        WriteString(iFile, Str(MediaLibary()\lastplay)        + "|")
        WriteString(iFile, Str(MediaLibary()\playcount)       + "|")
        WriteString(iFile, Str(MediaLibary()\flags)           + "|")
        WriteString(iFile, Str(MediaLibary()\tag\cType)       + "|")
        WriteString(iFile, Str(MediaLibary()\playlist)        + "|")
        WriteString(iFile, Str(MediaLibary()\firstplay)       + "|")
        WriteString(iFile, Str(MediaLibary()\added))
        WriteString(iFile, #CRLF$)
      Next
      
      CloseFile(iFile)
      
      ;Remove Tempfile
      CopyFile(AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + ".tmp", AppDataDirectory() + #Folder_AppData + #FileName_MediaLib)
      DeleteFile(AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + ".tmp")
    Else
      If Msg : MsgBox_Error("MediaLibary konnte nicht gespeichert werden") : EndIf
    EndIf
    
  EndIf
  
  UnlockMutex(MediaLibScan\Mutex)
EndProcedure

; Speichert die Einstellungen
Procedure Save_Preferences(Msg)
  Protected iNext.i
  
  If CreatePreferences(AppDataDirectory() + #Folder_AppData + #FileName_Preferences)
    Log_Add("Schreibe Datei '" + AppDataDirectory() + #Folder_AppData + #FileName_Preferences + "'")
    
    ;Group WinSize
    PreferenceGroup("WinSize")
      For iNext = 1 To #Win_Last - 1
        WritePreferenceInteger("WinSize_X" + Str(iNext), WinSize(iNext)\posx)
        WritePreferenceInteger("WinSize_Y" + Str(iNext), WinSize(iNext)\posy)
        WritePreferenceInteger("WinSize_W" + Str(iNext), WinSize(iNext)\width)
        WritePreferenceInteger("Winsize_H" + Str(iNext), WinSize(iNext)\height)
      Next
    
    ;Group WinSize_Main
    PreferenceComment("")
    PreferenceGroup("WinSizeMain")
      WritePreferenceInteger("WinSizeMain_SizeType", iSizeTypeOld)
      If iSizeTypeOld = #SizeType_Normal
        WritePreferenceInteger("WinSizeMain_WinW_Second", iWinW_Main_Second)
        WritePreferenceInteger("WinSizeMain_WinH_Second", iWinH_Main_Second)
        WritePreferenceInteger("WinSizeMain_WinW_Normal", WindowWidth(#Win_Main))
      Else
        WritePreferenceInteger("WinSizeMain_WinW_Second", WindowWidth(#Win_Main))
        WritePreferenceInteger("WinSizeMain_WinH_Second", WindowHeight(#Win_Main))
        WritePreferenceInteger("WinSizeMain_WinW_Normal", iWinW_Main_Normal)
      EndIf
      If iSizeTypeOld = #SizeType_MediaLibary
        WritePreferenceInteger("WinSizeMain_MediaLibSP1", GetGadgetState(#G_SP_Main_ML_Vertical))
        WritePreferenceInteger("WinSizeMain_MediaLibSP2", GetGadgetState(#G_SP_Main_ML_Horizontal))
      Else
        WritePreferenceInteger("WinSizeMain_MediaLibSP1", lMediaLib_SPSize1)
        WritePreferenceInteger("WinSizeMain_MediaLibSP2", lMediaLib_SPSize2)
      EndIf
    
    ;Group Preferences
    PreferenceComment("")
    PreferenceGroup("Preferences")
      ;Bass
      PreferenceComment("")
      PreferenceComment("Bass")
      WritePreferenceInteger("BASS_QutputDevice", Pref\bass_device)
      WritePreferenceInteger("BASS_OutputRate", Pref\bass_rate)
      WritePreferenceInteger("BASS_FadeIn", Pref\bass_fadein)
      WritePreferenceInteger("BASS_FadeOut", Pref\bass_fadeout)
      WritePreferenceInteger("BASS_FadeOutEnd", Pref\bass_fadeoutend)
      WritePreferenceString("BASS_MidiSF2File", Pref\bass_midisf2)
      WritePreferenceInteger("BASS_MidiLyrics", Pref\bass_midilyrics)
      WritePreferenceInteger("BASS_Preview", Pref\bass_preview)
      
      ;Internet Streaming
      PreferenceComment("")
      PreferenceComment("Internet Streaming")
      WritePreferenceInteger("NETStream_SaveFile", Pref\inetstream_savefile)
      WritePreferenceString("NETStream_SavePath", Pref\inetstream_savepath)
      WritePreferenceInteger("NETStream_SaveName", Pref\inetstream_savename)
      WritePreferenceInteger("NETStream_TimeOut", Pref\inetstream_timeout)
      WritePreferenceInteger("NETStream_Buffer", Pref\inetstream_buffer)
      WritePreferenceString("NETStream_Proxy", Pref\inetstream_proxyserver)
      
      ;Equalizer
      PreferenceComment("")
      PreferenceComment("Equalizer")
      WritePreferenceInteger("Equalizer_Active", Pref\equilizer)
      WritePreferenceInteger("Equalizer_Preset", Pref\equilizerpreset)
      WritePreferenceInteger("Equalizer_PreAmp", BassEQ\iPreAmp)
      For iNext = 0 To 9
        WritePreferenceInteger("Equalizer_Pan" + Str(iNext), BassEQ\iCenter[iNext])
      Next
      WritePreferenceInteger("Equalizer_Speed", Pref\speed)
      WritePreferenceInteger("Equalizer_Panel", Pref\panel)
      
      ;Effects
      PreferenceComment("")
      PreferenceComment("Effects")
      WritePreferenceInteger("Effects_Reverb", Effects\bReverb)
      WritePreferenceFloat("Effects_ReverbMix", Effects\fReverbMix)
      WritePreferenceFloat("Effects_ReverbTime", Effects\fReverbTime)
      WritePreferenceInteger("Effects_Echo", Effects\bEcho)
      WritePreferenceInteger("Effects_EchoBack", Effects\bEchoBack)
      WritePreferenceInteger("Effects_EchoDelay", Effects\iEchoDelay)
      WritePreferenceInteger("Effects_Flanger", Effects\bFlanger)
      
      ;GUI
      PreferenceComment("")
      PreferenceComment("GUI")
      WritePreferenceInteger("GUI_OnTop", Pref\ontop)
      WritePreferenceInteger("GUI_Opacity", Pref\opacity)
      WritePreferenceInteger("GUI_OpacityValue", Pref\opacityval)
      WritePreferenceInteger("GUI_Magnetic", Pref\magnetic)
      WritePreferenceInteger("GUI_MagneticValue", Pref\magneticval)
      WritePreferenceInteger("GUI_AutoColumnWidthPL", Pref\autoclnw_pl)
      WritePreferenceInteger("GUI_AutoColumnWidthML", Pref\autoclnw_ml)
      WritePreferenceString("GUI_LengthFormat", Pref\lengthformat)
      WritePreferenceInteger("GUI_AutoComplete", Pref\gui_autocomplete)
      
      ;Colors
      PreferenceComment("")
      PreferenceComment("Colors")
      WritePreferenceInteger("CLR_TrackInfo_BG", Pref\color[#Color_TrackInfo_BG])
      WritePreferenceInteger("CLR_TrackInfo_FG", Pref\color[#Color_TrackInfo_FG])
      WritePreferenceInteger("CLR_Spectrum_BG",  Pref\color[#Color_Spectrum_BG])
      WritePreferenceInteger("CLR_Spectrum_FG",  Pref\color[#Color_Spectrum_FG])
      WritePreferenceInteger("CLR_Select_BG",    Pref\color[#Color_Select_BG])
      WritePreferenceInteger("CLR_Select_FG",    Pref\color[#Color_Select_FG])
      WritePreferenceInteger("CLR_Midi_BG",      Pref\color[#Color_Midi_BG])
      WritePreferenceInteger("CLR_Midi_FG",      Pref\color[#Color_Midi_FG])
      WritePreferenceInteger("CLR_Tracker_BG",   Pref\color[#Color_Tracker_BG])
      WritePreferenceInteger("CLR_Tracker_FG",   Pref\color[#Color_Tracker_FG])
      
      ;HotKeys
      PreferenceComment("")
      PreferenceComment("Hotkeys")
      WritePreferenceInteger("HK_MediaKeys", Pref\sk_enablemedia)
      WritePreferenceInteger("HK_Global", Pref\sk_enableglobal)
      For iNext = 0 To ArraySize(HotKey())
        WritePreferenceInteger("HK_" + Str(iNext) + "_AV", HotKey(iNext)\active)
        WritePreferenceInteger("HK_" + Str(iNext) + "_CL", HotKey(iNext)\control)
        WritePreferenceInteger("HK_" + Str(iNext) + "_MU", HotKey(iNext)\menu)
        WritePreferenceInteger("HK_" + Str(iNext) + "_ST", HotKey(iNext)\shift)
        WritePreferenceInteger("HK_" + Str(iNext) + "_MC", HotKey(iNext)\misc)
      Next
      
      ;Tracker
      PreferenceComment("")
      PreferenceComment("Tracker")
      WritePreferenceInteger("Tracker_Enable", Pref\tracker_enable)
      WritePreferenceInteger("Tracker_Corner", Pref\tracker_corner)
      WritePreferenceInteger("Tracker_Align", Pref\tracker_align)
      WritePreferenceInteger("Tracker_Gap", Pref\tracker_gap)
      WritePreferenceInteger("Tracker_Spacing", Pref\tracker_spacing)
      WritePreferenceInteger("Tracker_MinWidth", Pref\tracker_minw)
      WritePreferenceInteger("Tracker_MinHeight", Pref\tracker_minh)
      WritePreferenceInteger("Tracker_Time", Pref\tracker_showtime)
      WritePreferenceString("Tracker_Text", Pref\tracker_text)
      
      ;MediaLib
      PreferenceComment("")
      PreferenceComment("MediaLibary")
      WritePreferenceInteger("MediaLib_PathAmount", ListSize(MediaLib_Path()))
      ForEach MediaLib_Path()
        WritePreferenceString("MediaLib_Path" + Str(ListIndex(MediaLib_Path())), MediaLib_Path())
      Next
      WritePreferenceInteger("MediaLib_CPU", Pref\medialib_cpugentle)
      WritePreferenceInteger("MediaLib_AddPlay", Pref\medialib_addplayfiles)
      WritePreferenceInteger("MediaLib_SearchIn", Pref\medialib_searchin)
      WritePreferenceInteger("MediaLib_BackgroundScan", Pref\medialib_backgroundscan)
      WritePreferenceInteger("MediaLib_StartCheck", Pref\medialib_startcheck)
      WritePreferenceInteger("MediaLib_BGIndex", MediaLibScan\BGIndex)
      WritePreferenceInteger("MediaLib_CheckExtension", Pref\medialib_checkextension)
      WritePreferenceInteger("MediaLib_MaxSearchCount", Pref\medialib_maxsearchcount)
      
      ;Order
      PreferenceComment("")
      PreferenceComment("Order")
      WritePreferenceInteger("Order_TimeOut", Task\timeout)
      
      ;Misc
      PreferenceComment("")
      PreferenceComment("Misc")
      WritePreferenceInteger("Misc_LastStart", Pref\misc_laststart)
      WritePreferenceInteger("Misc_Clipboard", Pref\misc_clipboard)
      WritePreferenceInteger("Misc_DropClear", Pref\misc_dropclear)
      WritePreferenceInteger("Misc_AutoPlayList", Pref\pl_auto)
      WritePreferenceInteger("Misc_AutoSave_PF", Pref\misc_autosave_pf)
      WritePreferenceInteger("Misc_AutoSave_PL", Pref\misc_autosave_pl)
      WritePreferenceInteger("Misc_AutoSave_ML", Pref\misc_autosave_ml)
      WritePreferenceInteger("Misc_AutoSave_IV", Pref\misc_autosave_time)
      WritePreferenceInteger("Misc_EndQuestion", Pref\endquestion)
      WritePreferenceInteger("Misc_RecursiveFolder", Pref\recursivfolder)
      WritePreferenceInteger("Misc_TaskBar", Pref\taskbar)
      WritePreferenceInteger("Misc_StartUpdateCheck", Pref\startversioncheck)
      WritePreferenceInteger("Misc_Logging", Pref\enablelogging)
      WritePreferenceInteger("Misc_ChangeMSN", Pref\misc_changemsn)
      WritePreferenceInteger("Misc_PlayLastPlay", Pref\misc_playlastplay)
      WritePreferenceInteger("Misc_SpectrumType", Pref\spectrum)
      WritePreferenceInteger("Misc_Volume", GetGadgetState(#G_TB_Main_IA_Volume))
      WritePreferenceInteger("Misc_Repeat", GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Repeat))
      WritePreferenceInteger("Misc_Random", GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Random))
      WritePreferenceInteger("Misc_Preview", GetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Preview))
      WritePreferenceInteger("Misc_MLMisc", Pref\Misc_MLMisc)
      
      ; Column Orders
      PreferenceComment("")
      PreferenceComment("ColumnOrder")
      ; Playlist
      SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_GETCOLUMNORDERARRAY, #PlayList_Column_Last + 1, @ColumnOrderArray_PL())
      For iNext = 1 To #PlayList_Column_Last
        WritePreferenceInteger("CMNW_PL_" + Str(iNext), GetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, iNext))
        WritePreferenceInteger("CMNI_PL_" + Str(iNext), ColumnOrderArray_PL(iNext))
        WritePreferenceInteger("CMNA_PL_" + Str(iNext), ListIconGadget_GetColumnAlign(#G_LI_Main_PL_PlayList, iNext))
      Next
      
      ; MediaLibary
      SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_GETCOLUMNORDERARRAY, #MediaLib_Column_Last + 1, @ColumnOrderArray_ML())
      For iNext = 1 To #MediaLib_Column_Last
        WritePreferenceInteger("CMNW_ML_" + Str(iNext), GetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, iNext))
        WritePreferenceInteger("CMNI_ML_" + Str(iNext), ColumnOrderArray_ML(iNext))
        WritePreferenceInteger("CMNA_ML_" + Str(iNext), ListIconGadget_GetColumnAlign(#G_LI_Main_ML_MediaLib, iNext))
      Next
      
    ;Group Statistics
    PreferenceComment("")
    PreferenceGroup("Statistics")
      WritePreferenceInteger("Statistics_PlayStart", Statistics\play_start)
      WritePreferenceInteger("Statistics_PlayEnd",   Statistics\play_end)
      WritePreferenceInteger("Statistics_PlayDays",  Statistics\play_days)
      WritePreferenceQuad("Statistics_PlayTime",     Statistics\play_time)
      WritePreferenceInteger("Statistics_AppStart",  Statistics\app_start)
      WritePreferenceQuad("Statistics_RadioTraffic", Statistics\radio_traffic)
    
    ;Group Plugins
    PreferenceComment("")
    PreferenceGroup("Plugins")
      ForEach Plugin()
        If Plugin()\start = 1
          WritePreferenceString(Str(ListIndex(Plugin())), Plugin()\file)
        EndIf
      Next
    
    ;Group Position
    If ListSize(Position()) > 0
      PreferenceComment("")
      PreferenceGroup("Positions")
        WritePreferenceInteger("Amount", ListSize(Position()))
        ForEach Position()
          WritePreferenceString("F_" + Str(ListIndex(Position())), Position()\fingerprint)
          WritePreferenceInteger("P_" + Str(ListIndex(Position())), Position()\position)
        Next
    EndIf
    
    ;Group MLSearchHistory
    If CountGadgetItems(#G_SR_Main_ML_Search) > 0
      PreferenceComment("")
      PreferenceGroup("SearchHistory_ML")
      WritePreferenceInteger("Amount", CountGadgetItems(#G_SR_Main_ML_Search))
      For iNext = 0 To CountGadgetItems(#G_SR_Main_ML_Search) - 1
        WritePreferenceString(Str(iNext), GetGadgetItemText(#G_SR_Main_ML_Search, iNext))
      Next
    EndIf
    
    ;Group PlayLastPlay
    If Pref\misc_playlastplay And CurrPlay\channel[CurrPlay\curr]
      PreferenceComment("")
      PreferenceGroup("LastPlay")
        WritePreferenceString("Location",  CurrPlay\file)
        WritePreferenceInteger("PlayType", CurrPlay\playtype)
        If CurrPlay\playtype = #PlayType_PlayList
          WritePreferenceInteger("PlayListIndex", CurrPlay\plindex)
        EndIf
        WritePreferenceQuad("Position", Bass_GetPos())
    EndIf
    
    ; Gruppe Schriftarten
    PreferenceComment("")
    PreferenceGroup("Fonts")
      WritePreferenceInteger("InfoArea_Activ", GUIFont(#Font_InfoArea)\activ)
      WritePreferenceString("InfoArea_Name", GUIFont(#Font_InfoArea)\font)
      WritePreferenceInteger("InfoArea_Size", GUIFont(#Font_InfoArea)\size)
      WritePreferenceInteger("PlayList_Activ", GUIFont(#Font_PlayList)\activ)
      WritePreferenceString("PlayList_Name", GUIFont(#Font_PlayList)\font)
      WritePreferenceInteger("PlayList_Size", GUIFont(#Font_PlayList)\size)
      WritePreferenceInteger("MediaLib_Activ", GUIFont(#Font_MediaLib)\activ)
      WritePreferenceString("MediaLib_Name", GUIFont(#Font_MediaLib)\font)
      WritePreferenceInteger("MediaLib_Size", GUIFont(#Font_MediaLib)\size)
      WritePreferenceInteger("Tracker_Activ", GUIFont(#Font_Tracker)\activ)
      WritePreferenceString("Tracker_Name", GUIFont(#Font_Tracker)\font)
      WritePreferenceInteger("Tracker_Size", GUIFont(#Font_Tracker)\size)
      WritePreferenceInteger("MidiLyrics_Activ", GUIFont(#Font_MidiLyrics)\activ)
      WritePreferenceString("MidiLyrics_Name", GUIFont(#Font_MidiLyrics)\font)
      WritePreferenceInteger("MidiLyrics_Size", GUIFont(#Font_MidiLyrics)\size)
    
    ClosePreferences()
  Else
    If Msg : MsgBox_Error("Einstellungen konnten nicht gespeichert werden" + #CR$ + AppDataDirectory() + #Folder_AppData + #FileName_Preferences + "'") : EndIf
  EndIf
EndProcedure

; Speichert den Log in einer Datei ab
Procedure Save_Log()
  If ListSize(Logging()) > 0
    Protected iFile.i
    
    Log_Add("Schreibe Datei '" + AppDataDirectory() + #Folder_AppData + #FileName_Log + "'", #Log_Info)
    
    iFile = OpenFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_Log)
    If iFile
      
      ; Maximale Dateigröße erreicht
      If Lof(iFile) >= #MaxFileLogSize
        FileSeek(iFile, 0)
        TruncateFile(iFile)
      EndIf
      
      ; Neue Einträge reinschreiben
      FileSeek(iFile, Lof(iFile))
      FileBuffersSize(iFile, 0)
      
      ForEach Logging()
        WriteStringN(iFile, Str(Logging()\type) + "|" + FormatDate("%hh:%ii:%ss", Logging()\time) + "|" + Logging()\message)
      Next
      
      CloseFile(iFile)
    EndIf
  EndIf
EndProcedure

; Playlist laden
Procedure Open_PlayList()
  ClearList(PlayList())
  
  If Pref\pl_auto > 0
    Protected iFile.i, sInput.s
    
    iFile = ReadFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_PlayList)
    If iFile
      If ReadString(iFile) = #FileString_Check + "-PLV2"
        
        While Eof(iFile) = 0
          sInput = Trim(ReadString(iFile))
          If UCase(Left(sInput, 4)) = "ETY:"
            sInput = Mid(sInput, 5)
            
            AddElement(PlayList())
            PlayList()\tag\file         = StringField(sInput, 1, "|")
            PlayList()\tag\title        = StringField(sInput, 2, "|")
            PlayList()\tag\artist       = StringField(sInput, 3, "|")
            PlayList()\tag\album        = StringField(sInput, 4, "|")
            PlayList()\tag\year         = Val(StringField(sInput, 5, "|"))
            PlayList()\tag\comment      = StringField(sInput, 6, "|")
            PlayList()\tag\track        = Val(StringField(sInput, 7, "|"))
            PlayList()\tag\genre        = StringField(sInput, 8, "|")
            PlayList()\tag\bitrate      = Val(StringField(sInput, 9, "|"))
            PlayList()\tag\samplerate   = Val(StringField(sInput, 10, "|"))
            PlayList()\tag\channels     = Val(StringField(sInput, 11, "|"))
            PlayList()\tag\length       = Val(StringField(sInput, 12, "|"))
            PlayList()\tag\cType        = Val(StringField(sInput, 13, "|"))
            
            PlayList_AddItem(PlayList()\tag\title, PlayList()\tag\artist, PlayList()\tag\album, PlayList()\tag\track, PlayList()\tag\length, PlayList()\tag\year, PlayList()\tag\cType, -1)
          EndIf
        Wend
        
        PlayList_RefreshHeader()
        Playlist_RefreshAllTimes()
      EndIf
      
      CloseFile(iFile)
    EndIf
  EndIf
EndProcedure

; Medienbibliothek laden
Procedure Open_MediaLibary()
  Protected iFile.i
  Protected iDiference.i
  Protected fPlayPerDay.f
  Protected fCurrPlayPerDay.f
  
  iFile = ReadFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_MediaLib)
  If iFile <> 0
    Protected sRead.s
    Protected sPlayListName.s
    Protected iPlayListID.i
    
    If ReadString(iFile) = #FileString_Check + "-MLV1"
      LockMutex(MediaLibScan\Mutex)
      
      ClearList(MediaLibary())
      
      While Eof(iFile) = 0
        sRead = Trim(ReadString(iFile))
        
        ; Medienbibliothek
        If UCase(Left(sRead, 4)) = "ETY:"
          sRead = Mid(sRead, 5)
          
          AddElement(MediaLibary())
          MediaLibary()\tag\file       = StringField(sRead, 1, "|")
          MediaLibary()\tag\title      = StringField(sRead, 2, "|")
          MediaLibary()\tag\artist     = StringField(sRead, 3, "|")
          MediaLibary()\tag\album      = StringField(sRead, 4, "|")
          MediaLibary()\tag\year       = Val(StringField(sRead, 5, "|"))
          MediaLibary()\tag\comment    = StringField(sRead, 6, "|")
          MediaLibary()\tag\track      = Val(StringField(sRead, 7, "|"))
          MediaLibary()\tag\genre      = StringField(sRead, 8, "|")
          MediaLibary()\tag\bitrate    = Val(StringField(sRead, 9, "|"))
          MediaLibary()\tag\samplerate = Val(StringField(sRead, 10, "|"))
          MediaLibary()\tag\channels   = Val(StringField(sRead, 11, "|"))
          MediaLibary()\tag\length     = Val(StringField(sRead, 12, "|"))
          MediaLibary()\lastplay       = Val(StringField(sRead, 13, "|"))
          MediaLibary()\playcount      = Val(StringField(sRead, 14, "|"))
          MediaLibary()\flags          = Val(StringField(sRead, 15, "|"))
          MediaLibary()\tag\cType      = Val(StringField(sRead, 16, "|"))
          MediaLibary()\playlist       = Val(StringField(sRead, 17, "|"))
          MediaLibary()\firstplay      = Val(StringField(sRead, 18, "|"))
          MediaLibary()\added          = Val(StringField(sRead, 19, "|"))
          
          ; Werte korregieren
          If MediaLibary()\playcount < 0
            MediaLibary()\playcount = 0
          EndIf
          If MediaLibary()\lastplay < 0
            MediaLibary()\lastplay = 0
          EndIf
          If MediaLibary()\firstplay < 0
            MediaLibary()\firstplay = 0
          EndIf
          If MediaLibary()\firstplay = 0 And MediaLibary()\lastplay > 0
            MediaLibary()\firstplay = MediaLibary()\lastplay
          EndIf
          If MediaLibary()\added < 0
            MediaLibary()\added = 0
          EndIf
          If MediaLibary()\added = 0
            MediaLibary()\added = Date()
          EndIf
          
          ; Online
          If UCase(Left(MediaLibary()\tag\file, 7)) = "HTTP://" Or UCase(Left(MediaLibary()\tag\file, 6)) = "FTP://"
            
            ; Wiedergabecounter online
            If MediaLibary()\playcount > 0
              Statistics\ml_playstart_online + MediaLibary()\playcount
            EndIf
          
          ; Lokal  
          Else
            
            ; Wiedergabecounter lokal
            If MediaLibary()\playcount > 0
              Statistics\ml_playstart_local + MediaLibary()\playcount
            EndIf
            
            ; Größen Wiedergabe/Tag Faktor berechnen
            If MediaLibary()\playcount > 0 And DayDif(MediaLibary()\firstplay, MediaLibary()\lastplay) > 0
              fCurrPlayPerDay = MediaLibary()\playcount / DayDif(MediaLibary()\firstplay, MediaLibary()\lastplay)
              
              If fCurrPlayPerDay > fPlayPerDay
                fPlayPerDay = fCurrPlayPerDay
              EndIf
            EndIf
            
          EndIf
          
        ; Wiedergabeliste
        ElseIf UCase(Left(sRead, 4)) = "ETP:"
          sRead = Mid(sRead, 5)
          
          sPlayListName = StringField(sRead, 1, "|")
          iPlayListID   = Val(StringField(sRead, 2, "|"))
          
          If Trim(sPlayListName) And iPlayListID > 0
            MediaLibary_PlayList(sPlayListName)\id = iPlayListID
          EndIf
        EndIf
      Wend
      
      ; Sortieren
      SortStructuredList(MediaLibary(), #PB_Sort_Ascending, OffsetOf(_MediaLibary\tag) + OffsetOf(_Tag\file), #PB_Sort_String)
      
      ; Bewertung berechnen
      ForEach MediaLibary()
        If UCase(Left(MediaLibary()\tag\file, 7)) <> "HTTP://" And UCase(Left(MediaLibary()\tag\file, 6)) <> "FTP://"
          If MediaLibary()\playcount > 0 And DayDif(MediaLibary()\firstplay, MediaLibary()\lastplay) > 0
            fCurrPlayPerDay = MediaLibary()\playcount / DayDif(MediaLibary()\firstplay, MediaLibary()\lastplay)
            
            MediaLibary()\rating = ((fCurrPlayPerDay / fPlayPerDay) * 100) / 10
          EndIf
        EndIf
      Next
      
      UnlockMutex(MediaLibScan\Mutex)
    EndIf
    
    CloseFile(iFile)
  EndIf
  
EndProcedure

; Einstellungen laden
Procedure Open_Preferences()
  Protected iNext.i, sTemp.s, iTemp.i
  
  OpenPreferences(AppDataDirectory() + #Folder_AppData + #FileName_Preferences)
    
    ;Group WinSize
    PreferenceGroup("WinSize")
      For iNext = 1 To #Win_Last - 1
        WinSize(iNext)\posx   = ReadPreferenceInteger("WinSize_X" + Str(iNext), -1)
        WinSize(iNext)\posy   = ReadPreferenceInteger("WinSize_Y" + Str(iNext), -1)
        WinSize(iNext)\width  = ReadPreferenceInteger("WinSize_W" + Str(iNext), 0)
        WinSize(iNext)\height = ReadPreferenceInteger("WinSize_H" + Str(iNext), 0)
      Next
      
    ;Group WinSize_Main
    PreferenceGroup("WinSizeMain")
      iTemp             = ReadPreferenceInteger("WinSizeMain_SizeType", #SizeType_Normal)
      iWinW_Main_Normal = ReadPreferenceInteger("WinSizeMain_WinW_Normal", 0)
      iWinW_Main_Second = ReadPreferenceInteger("WinSizeMain_WinW_Second", 0)
      iWinH_Main_Second = ReadPreferenceInteger("WinSizeMain_WinH_Second", 0)
      lMediaLib_SPSize1 = ReadPreferenceInteger("WinSizeMain_MediaLibSP1", 85)
      lMediaLib_SPSize2 = ReadPreferenceInteger("WinSizeMain_MediaLibSP2", 250)
      
      If WinSize(#Win_Main)\posx = -1 And WinSize(#Win_Main)\posy = -1
        ResizeWindow(#Win_Main, GetSystemMetrics_(#SM_CXSCREEN)/2 - Window_GetWidth(#Win_Main)/2, GetSystemMetrics_(#SM_CYSCREEN)/2 - Window_GetHeight(#Win_Main)/2, #PB_Ignore, #PB_Ignore)
      Else
        ResizeWindow(#Win_Main, WinSize(#Win_Main)\posx, WinSize(#Win_Main)\posy, #PB_Ignore, #PB_Ignore)
      EndIf
      
      iSizeTypeOld = -1
      
      Window_ChangeSize(iTemp)
      
    ;Group Preferences
    PreferenceGroup("Preferences")
      ;Bass
      Pref\bass_device     = ReadPreferenceInteger("BASS_QutputDevice", -1)
      Pref\bass_rate       = ReadPreferenceInteger("BASS_OutputRate", 1)
      Pref\bass_fadein     = ReadPreferenceInteger("BASS_FadeIn", 2)
      Pref\bass_fadeout    = ReadPreferenceInteger("BASS_FadeOut", 2)
      Pref\bass_fadeoutend = ReadPreferenceInteger("BASS_FadeOutEnd", 2)
      
      Pref\bass_midisf2   = ReadPreferenceString("BASS_MidiSF2File", "")
      If Trim(Pref\bass_midisf2) = "" Or FileSize(Pref\bass_midisf2) < 1
        Pref\bass_midisf2 = ""
        
        If FileSize(ExecutableDirectory() + #FileName_MidiFont) > 0
          Pref\bass_midisf2 = ExecutableDirectory() + #FileName_MidiFont
        EndIf
      EndIf
      
      Pref\bass_midilyrics = ReadPreferenceInteger("BASS_MidiLyrics", 1)
      Pref\bass_preview   = ReadPreferenceInteger("BASS_Preview", 10)
      
      ;Inet Stream
      Pref\inetstream_savefile    = ReadPreferenceInteger("NETStream_SaveFile", 0)
      
      Pref\inetstream_savepath = ReadPreferenceString("NETStream_SavePath", "")
      If FileSize(Pref\inetstream_savepath) <> -2
        Pref\inetstream_savepath = MyMusicDirectory() + #Folder_Record
        CreateDirectory(Pref\inetstream_savepath)
      EndIf
      
      Pref\inetstream_savename    = ReadPreferenceInteger("NETStream_SaveName", 0)
      Pref\inetstream_timeout     = ReadPreferenceInteger("NETStream_TimeOut", 5)
      Pref\inetstream_buffer      = ReadPreferenceInteger("NETStream_Buffer", 5)
      Pref\inetstream_proxyserver = ReadPreferenceString("NETStream_Proxy", "")
      
      ;Equalizer
      Pref\equilizer = ReadPreferenceInteger("Equalizer_Active", 0)
      Pref\equilizerpreset = ReadPreferenceInteger("Equalizer_Preset", 0)
      BassEQ\iPreAmp = ReadPreferenceInteger("Equalizer_PreAmp", 120)
      For iNext = 0 To 9
        BassEQ\iCenter[iNext] = ReadPreferenceInteger("Equalizer_Pan" + Str(iNext), 120)
      Next
      Pref\speed = ReadPreferenceInteger("Equalizer_Speed", 100)
      Pref\panel = ReadPreferenceInteger("Equalizer_Panel", 100)
      
      ;Effects
      Effects\bReverb      = ReadPreferenceInteger("Effects_Reverb", 0)
      Effects\fReverbMix   = ReadPreferenceFloat("Effects_ReverbMix", 0)
      Effects\fReverbTime  = ReadPreferenceFloat("Effects_ReverbTime", 1000)
      Effects\bEcho        = ReadPreferenceInteger("Effects_Echo", 0)
      Effects\bEchoBack    = ReadPreferenceInteger("Effects_EchoBack", 50)
      Effects\iEchoDelay   = ReadPreferenceInteger("Effects_EchoDelay", 500)
      Effects\bFlanger     = ReadPreferenceInteger("Effects_Flanger", 0)
      
      ;GUI
      Pref\ontop = ReadPreferenceInteger("GUI_OnTop", 0)
      If Pref\ontop > 0
        StickyWindow(#Win_Main, 1)
      EndIf
      
      Pref\opacity    = ReadPreferenceInteger("GUI_Opacity", 0)
      Pref\opacityval = ReadPreferenceInteger("GUI_OpacityValue", 220)
      If Pref\opacityval < #MinOpacity Or Pref\opacityval > #MaxOpacity
        Pref\opacityval = 180
      EndIf
      Window_ChangeOpacity()
      
      Pref\magnetic        = ReadPreferenceInteger("GUI_Magnetic", 1)
      Pref\magneticval     = ReadPreferenceInteger("GUI_MagneticValue", 10)
      Pref\autoclnw_pl     = ReadPreferenceInteger("GUI_AutoColumnWidthPL", 0)
      Pref\autoclnw_ml     = ReadPreferenceInteger("GUI_AutoColumnWidthML", 0)
      Pref\lengthformat    = ReadPreferenceString("GUI_LengthFormat", "%ptime")
      Pref\lengthformat    = Trim(Pref\lengthformat)
      If Pref\lengthformat = ""
        Pref\lengthformat = "%ptime"
      EndIf
      Pref\gui_autocomplete = ReadPreferenceInteger("GUI_AutoComplete", 1)
      
      ;Colors
      Pref\color[#Color_TrackInfo_BG]   = ReadPreferenceInteger("CLR_TrackInfo_BG", $000000)
      Pref\color[#Color_TrackInfo_FG]   = ReadPreferenceInteger("CLR_TrackInfo_FG", $FFFFFF)
      Pref\color[#Color_Spectrum_BG]    = ReadPreferenceInteger("CLR_Spectrum_BG",  $000000)
      Pref\color[#Color_Spectrum_FG]    = ReadPreferenceInteger("CLR_Spectrum_FG",  $FFFFFF)
      Pref\color[#Color_Select_BG]      = ReadPreferenceInteger("CLR_Select_BG",    $000000)
      Pref\color[#Color_Select_FG]      = ReadPreferenceInteger("CLR_Select_FG",    $FFFFFF)
      Pref\color[#Color_Midi_BG]        = ReadPreferenceInteger("CLR_Midi_BG",      $000000)
      Pref\color[#Color_Midi_FG]        = ReadPreferenceInteger("CLR_Midi_FG",      $FFFFFF)
      Pref\color[#Color_Tracker_BG]     = ReadPreferenceInteger("CLR_Tracker_BG",   $000000)
      Pref\color[#Color_Tracker_FG]     = ReadPreferenceInteger("CLR_Tracker_FG",   $FFFFFF)
      Window_ChangeColor()
      
      ;HotKeys
      Pref\sk_enablemedia  = ReadPreferenceInteger("HK_MediaKeys", 1)
      Pref\sk_enableglobal = ReadPreferenceInteger("HK_Global", 0)
      
      For iNext = 0 To ArraySize(HotKey())
        HotKey(iNext)\active  = ReadPreferenceInteger("HK_" + Str(iNext) + "_AV", 0)
        HotKey(iNext)\control = ReadPreferenceInteger("HK_" + Str(iNext) + "_CL", 0)
        HotKey(iNext)\menu    = ReadPreferenceInteger("HK_" + Str(iNext) + "_MU", 0)
        HotKey(iNext)\shift   = ReadPreferenceInteger("HK_" + Str(iNext) + "_ST", 0)
        HotKey(iNext)\misc    = ReadPreferenceInteger("HK_" + Str(iNext) + "_MC", -1)
      Next
      
      ;Tracker
      Pref\tracker_enable   = ReadPreferenceInteger("Tracker_Enable", 0)
      Pref\tracker_corner   = ReadPreferenceInteger("Tracker_Corner", 3)
      Pref\tracker_align    = ReadPreferenceInteger("Tracker_Align", 0)
      Pref\tracker_gap      = ReadPreferenceInteger("Tracker_Gap", 8)
      Pref\tracker_spacing  = ReadPreferenceInteger("Tracker_Spacing", 20)
      Pref\tracker_minw     = ReadPreferenceInteger("Tracker_MinWidth", 200)
      Pref\tracker_minh     = ReadPreferenceInteger("Tracker_MinHeight", 50)
      Pref\tracker_showtime = ReadPreferenceInteger("Tracker_Time", 5000)
      Pref\tracker_text     = ReadPreferenceString("Tracker_Text", "%ARTI|%TITL")
      
      ;MediaLib
      iTemp = ReadPreferenceInteger("MediaLib_PathAmount", 0)
      If iTemp > 0
        iTemp = iTemp - 1
        For iNext = 0 To iTemp
          sTemp = ReadPreferenceString("MediaLib_Path" + Str(iNext), "")
          If FileSize(sTemp) = -2
            AddElement(MediaLib_Path())
            MediaLib_Path() = sTemp
          EndIf
        Next
      EndIf
      
      Pref\medialib_cpugentle      = ReadPreferenceInteger("MediaLib_CPU", 0)
      Pref\medialib_addplayfiles   = ReadPreferenceInteger("MediaLib_AddPlay", 1)
      Pref\medialib_searchin       = ReadPreferenceInteger("MediaLib_SearchIn", 63)
      Pref\medialib_backgroundscan = ReadPreferenceInteger("MediaLib_BackgroundScan", 1)
      Pref\medialib_startcheck     = ReadPreferenceInteger("MediaLib_StartCheck", 0)
      Pref\medialib_checkextension = ReadPreferenceInteger("MediaLib_CheckExtension", 1)
      Pref\medialib_maxsearchcount = ReadPreferenceInteger("MediaLib_MaxSearchCount", 0)
      
      MediaLibScan\BGIndex         = ReadPreferenceInteger("MediaLib_BGIndex", 0)
      
      ;Order
      Task\timeout = ReadPreferenceInteger("Order_TimeOut", 10000)
      
      ;Misc
      Pref\misc_laststart     = ReadPreferenceInteger("Misc_LastStart", 0)
      Pref\misc_clipboard     = ReadPreferenceInteger("Misc_Clipboard", 0)
      Pref\misc_dropclear     = ReadPreferenceInteger("Misc_DropClear", 0)
      Pref\pl_auto            = ReadPreferenceInteger("Misc_AutoPlayList", 1)
      Pref\misc_autosave_pf   = ReadPreferenceInteger("Misc_AutoSave_PF", 1)
      Pref\misc_autosave_pl   = ReadPreferenceInteger("Misc_AutoSave_PL", 1)
      Pref\misc_autosave_ml   = ReadPreferenceInteger("Misc_AutoSave_ML", 1)
      Pref\misc_autosave_time = ReadPreferenceInteger("Misc_AutoSave_IV", 300000)
      Pref\endquestion        = ReadPreferenceInteger("Misc_EndQuestion", 0)
      Pref\recursivfolder     = ReadPreferenceInteger("Misc_RecursiveFolder", 1)
      Pref\taskbar            = ReadPreferenceInteger("Misc_TaskBar", 1)
      Pref\startversioncheck  = ReadPreferenceInteger("Misc_StartUpdateCheck", 1)
      Pref\enablelogging      = ReadPreferenceInteger("Misc_Logging", 0)
      Pref\misc_changemsn     = ReadPreferenceInteger("Misc_ChangeMSN", 0)
      Pref\misc_playlastplay  = ReadPreferenceInteger("Misc_PlayLastPlay", 0)
      Pref\Misc_MLMisc        = ReadPreferenceInteger("Misc_MLMisc", 0)
      
      ;InfoArea
      Pref\spectrum = ReadPreferenceInteger("Misc_SpectrumType", #Spectrum_Waveform)
      If Pref\spectrum < #Spectrum_None Or Pref\spectrum > #Spectrum_Last
        Pref\spectrum = #Spectrum_Linear
      EndIf
      
      SetGadgetState(#G_TB_Main_IA_Volume, ReadPreferenceInteger("Misc_Volume", 100))
      Bass_Volume()
      
      SetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Repeat,  ReadPreferenceInteger("Misc_Repeat", 0))
      SetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Random,  ReadPreferenceInteger("Misc_Random", 0))
      SetToolBarButtonState(#Toolbar_Main2, #Mnu_Main_TB2_Preview, ReadPreferenceInteger("Misc_Preview", 0))
      
      ; Wiedergabeliste (Spalten)
      SetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_PL_1", 100), 1)
      SetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_PL_2", 80),  2)
      SetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_PL_3", 80),  3)
      SetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_PL_4", 80),  4)
      SetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_PL_5", 80),  5)
      SetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_PL_6", 80),  6)
      SetGadgetItemAttribute(#G_LI_Main_PL_PlayList, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_PL_7", 80),  7)
      
      ; Reihenfolge
      For iNext = 1 To #PlayList_Column_Last
        ColumnOrderArray_PL(iNext) = ReadPreferenceInteger("CMNI_PL_" + Str(iNext), iNext)
      Next
      SendMessage_(GadgetID(#G_LI_Main_PL_PlayList), #LVM_SETCOLUMNORDERARRAY, #PlayList_Column_Last + 1, @ColumnOrderArray_PL())
      
      ; Textausrichtung
      For iNext = 1 To #MediaLib_Column_Last
        iTemp = ReadPreferenceInteger("CMNA_PL_" + Str(iNext), #LVCFMT_LEFT)
        ListIconGadget_SetColumnAlign(#G_LI_Main_PL_PlayList, iNext, iTemp)
      Next
      
      ; Medienbibliothek (Spalten)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_1", 250), 1)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_2", 100), 2)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_3", 80),  3)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_4", 100), 4)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_5", 100), 5)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_6", 80),  6)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_7", 100), 7)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_8", 100), 8)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_9", 100), 9)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_10", 80), 10)
      SetGadgetItemAttribute(#G_LI_Main_ML_MediaLib, -1, #PB_ListIcon_ColumnWidth, ReadPreferenceInteger("CMNW_ML_11", 80), 11)
      
      ; Reihenfolge
      For iNext = 1 To #MediaLib_Column_Last
        ColumnOrderArray_ML(iNext) = ReadPreferenceInteger("CMNI_ML_" + Str(iNext), iNext)
      Next
      SendMessage_(GadgetID(#G_LI_Main_ML_MediaLib), #LVM_SETCOLUMNORDERARRAY, #MediaLib_Column_Last + 1, ColumnOrderArray_ML())
      
      ; Textausrichtung
      For iNext = 1 To #MediaLib_Column_Last
        iTemp = ReadPreferenceInteger("CMNA_ML_" + Str(iNext), #LVCFMT_LEFT)
        ListIconGadget_SetColumnAlign(#G_LI_Main_ML_MediaLib, iNext, iTemp)
      Next
    
    ; Statistiken
    PreferenceGroup("Statistics")
      Statistics\play_start    = ReadPreferenceInteger("Statistics_PlayStart", 0)
      Statistics\play_end      = ReadPreferenceInteger("Statistics_PlayEnd", 0)
      Statistics\play_days     = ReadPreferenceInteger("Statistics_PlayDays", 0)
      Statistics\play_time     = ReadPreferenceQuad("Statistics_PlayTime", 0)
      Statistics\app_start     = ReadPreferenceInteger("Statistics_AppStart", 0)
      Statistics\radio_traffic = ReadPreferenceQuad("Statistics_RadioTraffic", 0)
    
    ; Plugins
    PreferenceGroup("Plugins")
      iNext = 0
      Repeat
        sTemp = ReadPreferenceString(Str(iNext), ".")
        
        ForEach Plugin()
          If LCase(Plugin()\file) = LCase(sTemp)
            Plugin()\start = 1
            Break
          EndIf
        Next
        
        iNext + 1
      Until sTemp = "."
    
    ; Wiedergabepositionen
    PreferenceGroup("Position")
      iTemp = ReadPreferenceInteger("Amount", 0)
      If iTemp > 0
        For iNext = 0 To iTemp - 1
          AddElement(Position())
          Position()\fingerprint = ReadPreferenceString("F_" + Str(ListIndex(Position())), "")
          Position()\position    = ReadPreferenceInteger("P_" + Str(ListIndex(Position())), -1)
          If Position()\fingerprint = "" Or Position()\position = -1
            DeleteElement(Position())
          EndIf
        Next
      EndIf
    
    ; Suchhistory Medienbibliothek
    PreferenceGroup("SearchHistory_ML")
      iTemp = ReadPreferenceInteger("Amount", 0)
      If iTemp > 0
        
        If iTemp > #MaxSize_SHistoryML
          iTemp = #MaxSize_SHistoryML
        EndIf
        
        For iNext = 0 To iTemp - 1
          sTemp = Trim(ReadPreferenceString(Str(iNext), ""))
          If sTemp
            AddGadgetItem(#G_SR_Main_ML_Search, -1, sTemp)
          EndIf
        Next
        
      EndIf
    
    ; Letzte Wiedergabe
    PreferenceGroup("LastPlay")
      PlayLastPlay\file        = Trim(ReadPreferenceString("Location", ""))
      PlayLastPlay\playtype    = ReadPreferenceInteger("PlayType", -1)
      PlayLastPlay\plindex     = ReadPreferenceInteger("PlayListIndex", -1)
      PlayLastPlay\pos         = ReadPreferenceQuad("Position", -1)
    
    ; Schriftarten
    PreferenceGroup("Fonts")
      GUIFont(#Font_InfoArea)\activ   = ReadPreferenceInteger("InfoArea_Activ", 0)
      GUIFont(#Font_InfoArea)\font    = ReadPreferenceString("InfoArea_Name", "")
      GUIFont(#Font_InfoArea)\size    = ReadPreferenceInteger("InfoArea_Size", 0)
      GUIFont(#Font_PlayList)\activ   = ReadPreferenceInteger("PlayList_Activ", 0)
      GUIFont(#Font_PlayList)\font    = ReadPreferenceString("PlayList_Name", "")
      GUIFont(#Font_PlayList)\size    = ReadPreferenceInteger("PlayList_Size", 0)
      GUIFont(#Font_MediaLib)\activ   = ReadPreferenceInteger("MediaLib_Activ", 0)
      GUIFont(#Font_MediaLib)\font    = ReadPreferenceString("MediaLib_Name", "")
      GUIFont(#Font_MediaLib)\size    = ReadPreferenceInteger("MediaLib_Size", 0)
      GUIFont(#Font_Tracker)\activ    = ReadPreferenceInteger("Tracker_Activ", 0)
      GUIFont(#Font_Tracker)\font     = ReadPreferenceString("Tracker_Name", "")
      GUIFont(#Font_Tracker)\size     = ReadPreferenceInteger("Tracker_Size", 0)
      GUIFont(#Font_MidiLyrics)\activ = ReadPreferenceInteger("MidiLyrics_Activ", 0)
      GUIFont(#Font_MidiLyrics)\font  = ReadPreferenceString("MidiLyrics_Name", "")
      GUIFont(#Font_MidiLyrics)\size  = ReadPreferenceInteger("MidiLyrics_Size", 0)
      
      Preferences_ReloadFonts()
      Window_ChangeFonts()
      
  ClosePreferences()
EndProcedure

; Automatische Speicherung
Procedure AutoSave()
  If CreateBackup\Thread = 0
    Static iTime_Preferences.i
    Static iTime_PlayList.i
    Static iTime_MediaLibary.i
    
    If iTime_Preferences = 0
      iTime_Preferences = timeGetTime_()
    EndIf
    If iTime_PlayList = 0
      iTime_PlayList = timeGetTime_()
    EndIf
    If iTime_MediaLibary = 0
      iTime_MediaLibary = timeGetTime_()
    EndIf
    
    ; Einstellungen Speichern
    If Pref\misc_autosave_pf And timeGetTime_() - iTime_Preferences >= Pref\misc_autosave_time
      iTime_Preferences = timeGetTime_()
      Log_Add("Automatische Speicherung von Einstellungen..")
      Save_Preferences(0)
    EndIf
    
    ; Wiedergabeliste Sichern
    If Pref\misc_autosave_pl And timeGetTime_() - iTime_PlayList >= Pref\misc_autosave_time
      iTime_PlayList = timeGetTime_()
      Log_Add("Automatische Speicherung von Wiedergabeliste..")
      Save_PlayList(0)
    EndIf
    
    ; Medienbibliothek Sichern
    If Pref\misc_autosave_ml And timeGetTime_() - iTime_MediaLibary >= Pref\misc_autosave_time
      iTime_MediaLibary = timeGetTime_()
      Log_Add("Automatische Speicherung von Medienbibliothek")
      Save_MediaLibary(0)
    EndIf
    
  EndIf
EndProcedure

; Aktualisiert die verfügbaren Backups
Procedure Backup_RefreshOverview()
  If IsWindow(#Win_Preferences)
    Protected iDirectory.i
    
    ClearGadgetItems(#G_LI_Preferences_Backups_Overview)
    
    iDirectory = ExamineDirectory(#PB_Any, AppDataDirectory() + #Folder_AppData + #Folder_Backup, "*.pak")
    If iDirectory
      While NextDirectoryEntry(iDirectory)
        If DirectoryEntryType(iDirectory) = #PB_DirectoryEntry_File
          AddGadgetItem(#G_LI_Preferences_Backups_Overview, -1, DirectoryEntryName(iDirectory) + #LF$ + FormatDate("%dd.%mm.%yy - %hh:%ii:%mm", DirectoryEntryDate(iDirectory, #PB_Date_Created)))
        EndIf
      Wend
      FinishDirectory(iDirectory)
    EndIf
    
    SetGadgetItemAttribute(#G_LI_Preferences_Backups_Overview, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Preferences_Backups_Overview)) - GetGadgetItemAttribute(#G_LI_Preferences_Backups_Overview, -1, #PB_ListIcon_ColumnWidth, 0), 1)
  EndIf
EndProcedure

; Backup Erstellen, Hintergrundthread
Procedure Backup_CreateThread(*Dummy)
  Protected iPackFile.i
  Protected sFileName.s
  
  sFileName = AppDataDirectory() + #Folder_AppData + #Folder_Backup + FormatDate("%dd%mm%yy%hh%ii%ss.pak", Date())
  
  iPackFile = CreatePack(sFileName)
  If iPackFile
    CreateBackup\Success = 1
    
    If CreateBackup\Success = 1
      CreateBackup\Success = AddPackFile(AppDataDirectory() + #Folder_AppData + #FileName_Preferences, 9)
    EndIf
    If CreateBackup\Success = 1
      CreateBackup\Success = AddPackFile(AppDataDirectory() + #Folder_AppData + #FileName_PlayList, 9)
    EndIf
    If CreateBackup\Success = 1
      CreateBackup\Success = AddPackFile(AppDataDirectory() + #Folder_AppData + #FileName_MediaLib, 9)
    EndIf
    
    ClosePack()
    
    If CreateBackup\Success = 0
      DeleteFile(sFileName)
    EndIf
  EndIf
EndProcedure

; Backup Erstellen
Procedure Backup_Create()
  If IsThread(CreateBackup\Thread) = 0
    Log_Add("Erstelle Backup..")
    
    DisableGadget(#G_BN_Preferences_Backups_Create, 1)
    
    CreateBackup\Thread = CreateThread(@Backup_CreateThread(), 0)
    If CreateBackup\Thread = 0
      MsgBox_Error("Thread 'CreateBackup' konnte nicht erstellt werden")
    EndIf
  EndIf
EndProcedure

; Backup Wiederherstellen
Procedure Backup_Restore()
  Protected iSel.i
  Protected sFile.s, iFile.i
  Protected iPackFile.i, iSize.i
  Protected sPeek.s
  
  iSel = GetGadgetState(#G_LI_Preferences_Backups_Overview)
  If iSel > -1
    sFile = AppDataDirectory() + #Folder_AppData + #Folder_Backup + GetGadgetItemText(#G_LI_Preferences_Backups_Overview, iSel, 0)
    If FileSize(sFile) > 0
      
      If MessageRequester("Backup Wiederherstellen", "Soll die Datei '" + GetFilePart(sFile) + "' wirklich wiederhergestellt werden?", #MB_ICONQUESTION|#MB_YESNO) = #IDNO
        ProcedureReturn 0
      EndIf
      
      ; Restore
      If OpenPack(sFile)
        
        Log_Add("Backup Wiederherstellen..")
        
        Repeat
          iPackFile = NextPackFile()
          iSize     = PackFileSize()
          If iPackFile And iSize > 10
            sPeek = PeekS(iPackFile, 10)
            
            ; Preferences
            If LCase(Left(sPeek, 9)) = "[winsize]"
              iFile = CreateFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_Preferences + #FileExtension_Restore)
              If iFile
                WriteData(iFile, iPackFile, iSize)
                CloseFile(iFile)
                Log_Add("Einstellungen wiederhergestellt")
              EndIf
            EndIf
            
            ; Playlist
            If UCase(Left(sPeek, 9)) = "BK-F-PLV2"
              iFile = CreateFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_PlayList + #FileExtension_Restore)
              If iFile
                WriteData(iFile, iPackFile, iSize)
                CloseFile(iFile)
                Log_Add("Widergabeliste wiederhergestellt")
              EndIf
            EndIf
            
            ; MediaLibary
            If UCase(Left(sPeek, 9)) = "BK-F-MLV1"
              iFile = CreateFile(#PB_Any, AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + #FileExtension_Restore)
              If iFile
                WriteData(iFile, iPackFile, iSize)
                CloseFile(iFile)
                Log_Add("Medienbibliothek wiederhergestellt")
              EndIf
            EndIf
            
          EndIf
        Until iPackFile = 0
        
        ClosePack()
        
        MsgBox_Exclamation("Bitte Starten Sie BassKing neu, im die Wiederherstellung zu beenden.")
      EndIf
      
    EndIf
  EndIf
EndProcedure

Procedure Backup_Delete()
  Protected iSel.i
  Protected sFile.s
  
  iSel = GetGadgetState(#G_LI_Preferences_Backups_Overview)
  If iSel > -1
    sFile = AppDataDirectory() + #Folder_AppData + #Folder_Backup + GetGadgetItemText(#G_LI_Preferences_Backups_Overview, iSel, 0)
    If FileSize(sFile) > 0
      If MessageRequester("Warnung", "Soll die Datei '" + GetFilePart(sFile) + "' wirklich gelöscht werden?", #MB_ICONEXCLAMATION|#MB_YESNO) = #IDYES
        If DeleteFile(sFile)
          RemoveGadgetItem(#G_LI_Preferences_Backups_Overview, iSel)
        EndIf
      EndIf
    EndIf
  EndIf
EndProcedure

Procedure UpdateCheck_DownloadThread(ShowRequester)
  Protected sSetupFile.s
  
  sSetupFile = GetTemporaryDirectory() + "~" + Hex(Date()) + ".exe"
  
  Log_Add("Neue Version: Download wird durchgeführt..")
  
  If ReceiveHTTPFile(Update\URLDownload, sSetupFile)
    
    Log_Add("Neue Version: Download erfolgreich beendet", #Log_Info)
    
    If MessageRequester("Neue Version", "Der Download wurde erfolgreich durchgeführt, die Installation wird gestartet.", #MB_OKCANCEL|#MB_ICONINFORMATION) = #IDOK
      Update\UpdateReady = 1
      Update\SetupFile = sSetupFile
    Else
      CopyFile(sSetupFile, DesktopDirectory() + "BassKing_Setup.exe")
      DeleteFile(sSetupFile)
    EndIf
    
  Else
    Log_Add("Neue Version: Download fehlgeschlagen", #Log_Error)
    If ShowRequester
      MsgBox_Error("Download fehlgeschlagen")
    EndIf
  EndIf
  
  Update\Thread_Download = 0
EndProcedure

Procedure UpdateCheck_CheckThread(ShowRequester)
  Protected iResult.i
  Protected sTempFile.s
  Protected iNewVers.i
  Protected sDownloadURL.s
  Protected sVers.s
  
  Log_Add("Neue Version: Neue Programmversion wird gesucht..", #Log_Info)
  
  If iInitNetwork = 0
    
    ; InitNetwork Failed
    Log_Add("Neue Version: Netzwerkumgebung wurde nicht initialisiert", #Log_Error)
    If ShowRequester
      MsgBox_Error("Netzwerkumgebung wurde nicht initialisiert")
    EndIf
    
  Else
    
    ; Zufallsdateiname Erzeugen
    sTempFile = GetTemporaryDirectory() + "~" + Hex(Date()) + ".tmp"
    
    ; Updateinformationen Herunterladen
    If ReceiveHTTPFile(#URLUpdateC, sTempFile) = 0
      ; Fehlgeschlagen
      Log_Add("Neue Version: Versionsinformationen konnten nicht heruntergeladen werden", #Log_Error)
      If ShowRequester
        MsgBox_Error("Versionsinformationen konnten nicht heruntergeladen werden")
      EndIf
    Else
      
      ; Updateinformationen Öffnen
      If OpenPreferences(sTempFile)
        
        PreferenceGroup("version")
        iNewVers     = ReadPreferenceInteger("version", -1)
        sDownloadURL = ReadPreferenceString("download", "")
        
        If iNewVers > 0
          
          If iNewVers > #PrgVers
            
            Log_Add("Neue Version: Eine neue Programmversion ist verfügbar " + StrF(iNewVers / 100, 2), #Log_Info)
            
            sVers = "Aktuellste Version: "   + StrF(iNewVers/100, 2) + #CRLF$
            sVers + "Installierte Version: " + StrF(#PrgVers/100, 2) + #CRLF$ + #CRLF$
            
            If MessageRequester("Neue Version", sVers + "Eine neue Programmversion ist verfügbar, Aktualisierung starten?", #MB_ICONQUESTION|#MB_YESNO) = #IDYES
              
              Update\URLDownload = sDownloadURL
              
              Update\Thread_Download = CreateThread(@UpdateCheck_DownloadThread(), ShowRequester)
              If Update\Thread_Download = 0
                Log_Add("Neue Version: Downloadthread konnte nicht erstellt werden")
                MsgBox_Error("Downloadthread konnte nicht erstellt werden")
              EndIf
              
            EndIf
            
          Else
            
            ; Aktuelle Version
            Log_Add("Neue Version: Sie benutzen bereits die aktuellste Version", #Log_Info)
            If ShowRequester
              MessageRequester("Neue Version", "Sie benutzen bereits die aktuellste Version", #MB_ICONINFORMATION|#MB_OK)
            EndIf
            
          EndIf
          
          iResult = 1
        EndIf
        
        ClosePreferences()
        DeleteFile(sTempFile)
      
      Else
        
        ; Updateinformationen konnten nicht geöffnet werden
        Log_Add("Neue Version: Versionsinformationen konnten nicht geöffnet werden", #Log_Error)
        If ShowRequester
          MsgBox_Error("Versionsinformationen konnten nicht geöffnet werden")
        EndIf
        
      EndIf

    EndIf
    
  EndIf
  
  Update\Thread_Check = 0
EndProcedure

Procedure UpdateCheck_Start(ShowMessage = 1)
  If IsThread(Update\Thread_Check) = 0 And IsThread(Update\Thread_Download) = 0
    Update\Thread_Check = CreateThread(@UpdateCheck_CheckThread(), ShowMessage)
    If Update\Thread_Check = 0
      Log_Add("Updatecheck Fehlgeschlagen: Es konnte kein Thread Erstellt werden")
    EndIf
  EndIf
EndProcedure

Procedure Task_DoTask()
  Select Task\task
    Case #Task_End
      Application_End()
    Case #Task_Shutdown
      ShutdownWindows()
    Case #Task_Pause
      Bass_PauseMedia()
    Case #Task_Play
      PlayList_Play()
    Case #Task_Stop
      CurrPlay\playtype = #PlayType_Normal
      Bass_FadeOut()
    Case #Task_Next
      PlayList_NextTrack()
    Case #Task_Prev
      PlayList_PreviousTrack()
  EndSelect
EndProcedure

Procedure Task_StartTimeOut()
  Protected iBool.i
  
  If Task\cancel = 1
    KillTimer_(0, Task\timer)
  EndIf
  
  If timeGetTime_() - Task\timestart > Task\timeout And Task\cancel = 0
    CloseWindow_TaskRun()
    Task_DoTask()
    KillTimer_(0, Task\timer)
  Else
    If IsWindow(#Win_TaskRun)
      SetGadgetState(#G_PB_TaskRun, (((Task\timeout - (timeGetTime_() - Task\timestart)) * 100) / Task\timeout))
    EndIf
  EndIf  
EndProcedure

Procedure Task()
  If Task\event > 0
    Protected iBool.i
    
    Select Task\event
      Case #TaskEvent_Screensaver
        iBool = ScreenSaver_Active()
      Case #TaskEvent_Stop
        If CurrPlay\channel[0] = 0 And CurrPlay\channel[1] = 0
          iBool = 1
        EndIf
    EndSelect
    
    If iBool
      Task\event = 0
      If Task\timeout > 0
        OpenWindow_TaskRun()
        Task\timestart = timeGetTime_()
        Task\timer     = SetTimer_(0, 0, 25, @Task_StartTimeOut())
      Else
        Task_DoTask()
      EndIf
    EndIf
    
  EndIf
EndProcedure

; Sendet dem Plugin lediglich eine Nachricht
Procedure.i Plugin_SendMessage(Window, Message)
  Protected CDS.COPYDATASTRUCT
  
  If IsWindow_(Window)
    CDS\dwData = Message
    CDS\cbData = 0
    CDS\lpData = 0
    
    ProcedureReturn SendMessage_(Window, #WM_COPYDATA, 0, @CDS)
  EndIf
EndProcedure

; Sendet dem Plugin eine Zahl
Procedure.i Plugin_SendValue(Window.i, Message.i, Value.i)
  Protected CDS.COPYDATASTRUCT
  
  If IsWindow_(Window)
    CDS\dwData = Message
    CDS\cbData = SizeOf(Integer)
    CDS\lpData = @Value
    
    ProcedureReturn SendMessage_(Window, #WM_COPYDATA, 0, @CDS)
  EndIf
EndProcedure

; Sendet dem Plugin ein String
Procedure.i Plugin_SendString(Window, Message, String$)
  If Trim(String$)
    Protected CDS.COPYDATASTRUCT
    
    If IsWindow_(Window)
      CDS\dwData = Message
      CDS\cbData = Len(String$) + SizeOf(Character)
      CDS\lpData = @String$
      
      ProcedureReturn SendMessage_(Window, #WM_COPYDATA, 0, @CDS)
    EndIf
    
  EndIf
EndProcedure

; Sendet die aktuellen Wiedergabeinformationen an alle Plugins
Procedure Plugin_SendCurrPlay(Plugin = 0)
  ForEach PluginEXE()
    If Plugin = 0 Or Plugin = PluginEXE()\hWnd
      
      Plugin_SendValue(PluginEXE()\hWnd,  #BKR_Start,      CurrPlay\channel[CurrPlay\curr])
      
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagFile,    CurrPlay\file)
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagTitle,   CurrPlay\tag\title)
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagArtist,  CurrPlay\tag\artist)
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagAlbum,   CurrPlay\tag\album)
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagYear,    Str(CurrPlay\tag\year))
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagComment, CurrPlay\tag\comment)
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagTrack,   Str(CurrPlay\tag\track))
      Plugin_SendString(PluginEXE()\hWnd, #BKR_TagGenre,   CurrPlay\tag\genre)
      
      If Plugin <> 0
        Break
      EndIf
      
    EndIf
  Next
EndProcedure

; Entfernt nicht mehr vorhandene Plugins
Procedure Plugin_ClearLists()
  
  ; Angemeldete Plugins
  ForEach PluginEXE()
    If IsWindow_(PluginEXE()\hWnd) = 0
      DeleteElement(PluginEXE())
    EndIf
  Next
  ; Plugins Folder
  ForEach Plugin()
    If FileSize(ExecutableDirectory() + #Folder_Plugins + Plugin()\file) < 1
      DeleteElement(Plugin())
    EndIf
  Next
  
EndProcedure

; Sucht ob ein Plugin bereits in der Liste ist
Procedure Plugin_IsInList(File$)
  ForEach Plugin()
    If UCase(Plugin()\file) = UCase(File$)
      ProcedureReturn 1
    EndIf
  Next
  ProcedureReturn 0
EndProcedure

; Ließt den Plugins Ordner neu ein
Procedure Plugin_ScanFolder()
  Protected iFolder.i, sFile.s
  
  iFolder = ExamineDirectory(#PB_Any, ExecutableDirectory() + #Folder_Plugins, "*.exe")
  If iFolder
    While NextDirectoryEntry(iFolder)
      If DirectoryEntryType(iFolder) = #PB_DirectoryEntry_File
        sFile = DirectoryEntryName(iFolder)
        If Plugin_IsInList(sFile) = 0
          AddElement(Plugin())
          Plugin()\file = sFile
        EndIf
      EndIf
    Wend
    FinishDirectory(iFolder)
  EndIf
  
EndProcedure

; Aktualisiert die Liste der angemeldeten Plugins
Procedure Plugin_RefreshLists()
  If IsWindow(#Win_Preferences)
    
    ; Angemeldete Plugins
    ClearGadgetItems(#G_LI_Preferences_Plugins_RegPlugins)
    ForEach PluginEXE()
      AddGadgetItem(#G_LI_Preferences_Plugins_RegPlugins, -1, PluginEXE()\autor + Chr(10) + StrF(PluginEXE()\version/100, 2) + Chr(10) + PluginEXE()\description)
    Next
    
    ; Plugins Folder
    ClearGadgetItems(#G_LI_Preferences_Plugins_RunPlugins)
    ForEach Plugin()
      AddGadgetItem(#G_LI_Preferences_Plugins_RunPlugins, -1, Plugin()\file)
    Next
    
  EndIf
EndProcedure

; Startet ein Plugin
Procedure Plugin_Run(Plugin = -2)
  Protected iSel.i
  
  If Plugin = -2
    iSel = GetGadgetState(#G_LI_Preferences_Plugins_RunPlugins)
  Else
    iSel = Plugin
  EndIf
  
  If iSel > -1 And ListSize(Plugin()) >= iSel
    SelectElement(Plugin(), iSel)
    If FileSize(ExecutableDirectory() + #Folder_Plugins + Plugin()\file) > 0
      Log_Add("Starte Plugin " + Plugin()\file + "..")
      RunProgram(ExecutableDirectory() + #Folder_Plugins + Plugin()\file)
    EndIf
  EndIf
EndProcedure

; Öffnet das Einstellungen-Fenster vom Plugin
Procedure Plugin_RegPreferences()
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LI_Preferences_Plugins_RegPlugins)
  If iSel > -1 And ListSize(PluginEXE()) >= iSel
    SelectElement(PluginEXE(), iSel)
    
    Plugin_SendMessage(PluginEXE()\hWnd, #BKR_Preferences)
  EndIf
EndProcedure

; Beendet das Plugin
Procedure Plugin_RegEnd()
  Protected iSel.i
  
  iSel = GetGadgetState(#G_LI_Preferences_Plugins_RegPlugins)
  If iSel > -1 And ListSize(PluginEXE()) >= iSel
    SelectElement(PluginEXE(), iSel)
    
    Plugin_SendMessage(PluginEXE()\hWnd, #BKR_End)
  EndIf
EndProcedure

; Verarbeitet eine Plugin-Nachricht
Procedure Plugin_DoMessage(Msg, iParam1, iParam2, sParam1$, sParam2$)
  
  Log_Add("PluginMSG: '" + Str(Msg) + "'")
  
  Select Msg
    ; Register/Unregister
    Case #BKM_Register
      If IsWindow_(iParam1)
        
        AddElement(PluginEXE())
        PluginEXE()\hWnd        = iParam1
        PluginEXE()\file        = Window_GetPath(iParam1)
        PluginEXE()\version     = iParam2
        PluginEXE()\autor       = Trim(sParam1$)
        PluginEXE()\description = Trim(sParam2$)
        Plugin_RefreshLists()
        
        ; Send Curr Volume
        Plugin_SendValue(iParam1, #BKR_Volume, GetGadgetState(#G_TB_Main_IA_Volume))
        
        ; Send Curr TrackInfos
        If BASS_ChannelIsActive(CurrPlay\channel[CurrPlay\curr]) <> #BASS_ACTIVE_STOPPED
          Plugin_SendCurrPlay(iParam1)
        EndIf
        
      EndIf
      
    Case #BKM_Unsubscribe
      ForEach PluginEXE()
        If PluginEXE()\hWnd = iParam1
          If IsWindow(#Win_Preferences)
            RemoveGadgetItem(#G_LI_Preferences_Plugins_RegPlugins, ListIndex(PluginEXE()))
          EndIf
          DeleteElement(PluginEXE())
          Break
        EndIf
      Next
    ; End
    Case #BKM_End
      Application_End()
    ; Log
    Case #BKM_LogAdd
      If Trim(sParam1$) <> ""
        Log_Add(sParam1$)
      EndIf
    Case #BKM_LogClear
      If IsWindow(#Win_Log)
        ClearGadgetItems(#G_LI_Log_Overview)
      EndIf
    ; Show/Hide
    Case #BKM_Show
      If IsWindowVisible_(WinSize(#Win_Main)\winid) = 0 Or GetWindowState(#Win_Main) = #PB_Window_Minimize
        Window_MinimizeMaximize()
      EndIf
    Case #BKM_Hide
      If IsWindowVisible_(WinSize(#Win_Main)\winid) = 1 Or GetWindowState(#Win_Main) = #PB_Window_Normal
        Window_MinimizeMaximize()
      EndIf
    ; Play
    Case #BKM_Play
      PlayList_Play()
    Case #BKM_PlayFile
      If FileSize(sParam1$) > 0
        Bass_PlayMedia(sParam1$, #PlayType_Normal)
      EndIf
    ; Change Track
    Case #BKM_PrevTrack
      PlayList_NextTrack()
    Case #BKM_NextTrack
      PlayList_PreviousTrack()
    ; Pause/Stop
    Case #BKM_Pause
      Bass_PauseMedia()
    Case #BKM_Stop
      CurrPlay\playtype = #PlayType_Normal
      Bass_FadeOut()
    ; Volume/Panel/Speed
    Case #BKM_Volume
      If iParam1 >= 0 And iParam1 <= 100
        Bass_Volume(iParam1 / 100, 0)
      EndIf
    Case #BKM_Speed
      If iParam1 >= 1 And iParam1 <= 200
        Pref\speed = iParam1
        Bass_SetFrequenz()
      EndIf
    Case #BKM_Panel
      If iParam1 >= 1 And iParam1 <= 200
        Pref\panel = iParam1
        Bass_SetPanel()
      EndIf
    Case #BKM_PlayListSel
      If CountGadgetItems(#G_LI_Main_PL_PlayList) > 0
        If iParam1 >= -1 And iParam1 <= CountGadgetItems(#G_LI_Main_PL_PlayList) - 1
          SetGadgetState(#G_LI_Main_PL_PlayList, iParam1)
        EndIf
      EndIf
    Case #BKM_MediaLibSel
      If CountGadgetItems(#G_LI_Main_ML_MediaLib) > 0
        If iParam1 >= -1 And iParam1 <= CountGadgetItems(#G_LI_Main_ML_MediaLib) - 1
          SetGadgetState(#G_LI_Main_ML_MediaLib, iParam1)
        EndIf
      EndIf
    ; Open Window
    Case #BKM_OpenWindow
      Select iParam1
        Case #Win_Preferences       : OpenWindow_Preferences()
        Case #Win_Statistics        : OpenWindow_Statistics()
        Case #Win_Effects           : OpenWindow_Effects()
        Case #Win_Search            : OpenWindow_Search()
        Case #Win_Info              : OpenWindow_Info()
        Case #Win_Log               : OpenWindow_Log()
        Case #Win_Metadata          : OpenWindow_Metadata()
        Case #Win_PlaylistGenerator : OpenWindow_PlayListGenerator()
        Case #Win_TaskChange        : OpenWindow_TaskChange()
        Case #Win_AutoTag           : OpenWindow_AutoTag()
        Case #Win_RadioLog          : OpenWindow_RadioLog()
        Case #Win_Feedback          : OpenWindow_Feedback()
        Case #Win_MLSearchPref      : OpenWindow_MLSearchPref()
      EndSelect
    ; Close Window
    Case #BKM_CloseWindow
      Select iParam1
        Case #Win_Preferences       : CloseWindow_Preferences()
        Case #Win_Statistics        : CloseWindow_Statistics()
        Case #Win_Effects           : CloseWindow_Effects()
        Case #Win_Search            : CloseWindow_Search()
        Case #Win_Info              : CloseWindow_Info()
        Case #Win_Log               : CloseWindow_Log()
        Case #Win_Metadata          : CloseWindow_Metadata()
        Case #Win_PlaylistGenerator : CloseWindow_PlayListGenerator()
        Case #Win_TaskChange        : CloseWindow_TaskChange()
        Case #Win_AutoTag           : CloseWindow_AutoTag()
        Case #Win_RadioLog          : CloseWindow_RadioLog()
        Case #Win_Feedback          : CloseWindow_Feedback()
        Case #Win_MLSearchPref      : CloseWindow_MLSearchPref()
      EndSelect
  EndSelect
EndProcedure

Procedure HotKey_GlobalEvent()
  Protected iNext.i, iControl.i, iMenu.i, iShift.i, iMisc.i, iState.i
  
  For iNext = 0 To ArraySize(HotKey())
    iControl = 0
    iMenu    = 0
    iMisc    = 0
    iShift   = 0
    iState   = 0
    
    ;CheckKeys
    If HotKey(iNext)\active
      
      If HotKey(iNext)\control = 0
        iControl = 1
      Else
        If GetKeyState_(#VK_CONTROL) & %10000000
          iControl = 1
        EndIf
      EndIf
      
      If HotKey(iNext)\menu = 0
        iMenu = 1
      Else
        If GetKeyState_(#VK_MENU) & %10000000
          iMenu = 1
        EndIf
      EndIf

      If HotKey(iNext)\shift = 0
        iShift = 1
      Else
        If GetKeyState_(#VK_SHIFT) & %10000000
          iShift = 1
        EndIf
      EndIf
      
      If HotKey(iNext)\misc < 0
        iMisc = 1
      Else
        If GetKeyState_(Key(HotKey(iNext)\misc)\code) & %10000000
          iMisc = 1
        EndIf
      EndIf
      
      If iControl = 1 And iMenu = 1 And iShift = 1 And iMisc = 1
        iState = 1
      EndIf
      
      ;Release
      If iState = 1
        If HotKey(iNext)\release = 0
          HotKey(iNext)\release = 1
        EndIf
        iState = 0
      Else
        If HotKey(iNext)\release = 1
          HotKey(iNext)\release = 0
          iState = 1
        EndIf
      EndIf
      
    EndIf
    
    ;DoEvent
    If iState = 1
      Select iNext
        Case 0 ;Vorhäriger Titel
          PlayList_PreviousTrack()
        Case 1 ;Play
          PlayList_Play()
        Case 2 ;Pause
          Bass_PauseMedia()
        Case 3 ;Stop
          CurrPlay\playtype = #PlayType_Normal
          Bass_FadeOut()
        Case 4 ;Nächster Titel
          PlayList_NextTrack()
        Case 5 ;Stumm
          If GetGadgetState(#G_TB_Main_IA_Volume) = 0
            SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetData(#G_TB_Main_IA_Volume))
          Else
            SetGadgetData(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume))
            SetGadgetState(#G_TB_Main_IA_Volume, 0)
          EndIf
          Bass_Volume()
        Case 6 ;Lautstärke veringern
          SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume) - 2)
          Bass_Volume()
        Case 7 ;Lautstärke erhöhen
          SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume) + 2)
          Bass_Volume()
        Case 8 ;Minimieren/Anzeigen
          Window_MinimizeMaximize()
        Case 9 ;Beenden
          Application_End()
        Case 10 ;Einstellungen
          OpenWindow_Preferences()
          Preferences_ChangeArea(-1)
          Preferences_Init()
          Preferences_CheckApply()
        Case 11 ;Wiedergabeliste
          Window_ChangeSize(#SizeType_Playlist)
        Case 12 ;Medienbibliothek
          Window_ChangeSize(#SizeType_MediaLibary)
        Case 13 ;Alles auswählen
          If GetActiveWindow() = #Win_Main
            Select GetActiveGadget()
              Case #G_LI_Main_PL_PlayList : ListIconGadget_SelAll(#G_LI_Main_PL_PlayList)
              Case #G_LI_Main_ML_MediaLib : ListIconGadget_SelAll(#G_LI_Main_ML_MediaLib)
            EndSelect
          EndIf
        Case 14 ;Entfernen
          If GetActiveWindow() = #Win_Main And GetActiveGadget() = #G_LI_Main_PL_PlayList
            If GetGadgetState(#G_LI_Main_PL_PlayList) <> -1
              PlayList_Remove(GetGadgetState(#G_LI_Main_PL_PlayList))
            EndIf
          EndIf
        Case 15 ; WindowClose
          CloseWindowOwn(GetActiveWindow())
        Case 16 ; Search
          If GetActiveWindow() = #Win_Main
            Select iSizeTypeOld
              Case 1 ; PlayList
                If ListSize(PlayList()) > 1
                  OpenWindow_Search()
                EndIf
              Case 2 ; MediaLib
                SetActiveGadget(#G_SR_Main_ML_Search)
            EndSelect
          EndIf
      EndSelect
    EndIf
    
  Next
EndProcedure

Procedure HotKey_MediaEvent()
  
  ;Mute
  Static iMute.i
  
  If GetKeyState_(#VK_VOLUME_MUTE) & %10000000
    iMute = 1
  Else
    If iMute = 1
      iMute = 0
      If GetGadgetState(#G_TB_Main_IA_Volume) = 0
        SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetData(#G_TB_Main_IA_Volume))
      Else
        SetGadgetData(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume))
        SetGadgetState(#G_TB_Main_IA_Volume, 0)
      EndIf
      Bass_Volume()
    EndIf
  EndIf
  
  ;Volume Up and Down
  If GetAsyncKeyState_(#VK_VOLUME_UP) & $1
    SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume) + 2)
    Bass_Volume()
  EndIf
  If GetAsyncKeyState_(#VK_VOLUME_DOWN) & $1
    SetGadgetState(#G_TB_Main_IA_Volume, GetGadgetState(#G_TB_Main_IA_Volume) - 2)
    Bass_Volume()
  EndIf

  ;PrevTrack
  Static iPrevTrack.i
  
  If GetKeyState_(#VK_MEDIA_PREV_TRACK) & %10000000
    iPrevTrack = 1
  Else
    If iPrevTrack = 1
      iPrevTrack = 0
      PlayList_PreviousTrack()
    EndIf
  EndIf
  
  ;Play/Pause
  Static iPlay.i
  
  If GetKeyState_(#VK_MEDIA_PLAY_PAUSE) & %10000000
    iPlay = 1
  Else
    If iPlay = 1
      iPlay = 0
      
      If CurrPlay\channel[CurrPlay\curr]
        Bass_PauseMedia()
      Else
        PlayList_Play()
      EndIf
      
    EndIf
  EndIf
  
  ;Stop
  Static iStop.i
  
  If GetKeyState_(#VK_MEDIA_STOP) & %10000000
    iStop = 1
  Else
    If iStop = 1
      iStop = 0
      CurrPlay\playtype = #PlayType_Normal
      Bass_FadeOut()
    EndIf
  EndIf
  
  ;NextTrack
  Static iNextTrack.i
  
  If GetKeyState_(#VK_MEDIA_NEXT_TRACK) & %10000000
    iNextTrack = 1
  Else
    If iNextTrack = 1
      iNextTrack = 0
      PlayList_NextTrack()
    EndIf
  EndIf
EndProcedure

Procedure Timer_Hotkeys()
  ; Media Shortcuts
  If Pref\sk_enablemedia
    HotKey_MediaEvent()
  EndIf
  ; Globale Shortcuts
  If Pref\sk_enableglobal
    HotKey_GlobalEvent()
  EndIf
EndProcedure

Procedure Timer_Misc()
  Protected sCurrPath.s
  
  ; Tracker Schließen
  If IsWindow(#Win_Tracker)
    If timeGetTime_() - Pref\tracker_currtime >= Pref\tracker_showtime
      CloseWindow_Tracker()
    EndIf
  EndIf
  
  ; Backup
  If CreateBackup\Thread
    If IsThread(CreateBackup\Thread) = 0
      CreateBackup\Thread = 0
      If CreateBackup\Success = 1
        Log_Add("Backup erfolgreich Erstellt")
        Backup_RefreshOverview()
      Else
        Log_Add("Backup Fehlgeschlagen")
      EndIf
      DisableGadget(#G_BN_Preferences_Backups_Create, 0)
    EndIf
  EndIf
  
  ; Aktueler Medienbibliothek Scan Schritt
  If IsThread(MediaLibScan\Thread)
    Pref\enableworker = 1
    
    sCurrPath = MediaLibScan\CurrState
    
    If IsWindow(#Win_Preferences)
      If GetGadgetText(#G_TX_Preferences_MediaLib_CurrScan) <> sCurrPath
        SetGadgetText(#G_TX_Preferences_MediaLib_CurrScan, sCurrPath)
      EndIf
    EndIf
    
    ProcessMessage(sCurrPath, #ProcessMessage_Low, 0)
  Else
    If MediaLibScan\Thread
      Pref\enableworker = 0
      MediaLibScan\Thread = 0
      MediaLibScan\CurrState = ""
      MediaLibScan\Cancel = 0
      
      ProcessMessage_Remove()
      
      If IsWindow(#Win_Preferences)
        DisableGadget(#G_BI_Preferences_MediaLib_PathAdd, 0)
        DisableGadget(#G_BI_Preferences_MediaLib_PathRem, 0)
        DisableGadget(#G_BI_Preferences_MediaLib_FindInvalidFiles, 0)
        SetGadgetAttribute(#G_BI_Preferences_MediaLib_Scan, #PB_Button_Image, ImageList(#ImageList_FolderScan))
        GadgetToolTip(#G_BI_Preferences_MediaLib_Scan, "Ordner Durchsuchen")
        SetGadgetText(#G_TX_Preferences_MediaLib_CurrScan, "")
      EndIf
    Else
      ; Backgroundscan aktuelle Datei
      If Pref\medialib_backgroundscan
        If IsThread(MediaLibScan\BGThread)
          If WinSize(#Win_Preferences)\winid
            sCurrPath = MediaLibScan\CurrState ;TextGadget_CompactPath(#G_TX_Preferences_MediaLib_CurrScan, MediaLibScan\CurrState)
            If GetGadgetText(#G_TX_Preferences_MediaLib_CurrScan) <> sCurrPath
              SetGadgetText(#G_TX_Preferences_MediaLib_CurrScan, sCurrPath)
            EndIf
          EndIf
        EndIf
      Else
        If WinSize(#Win_Preferences)\winid
          If GetGadgetText(#G_TX_Preferences_MediaLib_CurrScan) <> ""
            SetGadgetText(#G_TX_Preferences_MediaLib_CurrScan, "")
          EndIf
        EndIf
      EndIf
    EndIf
  EndIf
  
  ; ProcessMessage
  If ProcessMessage\ShowTime
    If timeGetTime_() - ProcessMessage\AddTime > ProcessMessage\ShowTime
      StatusBarText(#Statusbar_Main, #SBField_Process, "")
      
      ClearStructure(@ProcessMessage, _ProcessMessage)
    EndIf
  EndIf
  
  ; Einträge Medienbibliothek
  Static iMediaLibCount.i
  
  If ListSize(MediaLibary()) <> iMediaLibCount
    iMediaLibCount = ListSize(MediaLibary())
    StatusBarText(#Statusbar_Main, #SBField_MediaLibCount, Str(ListSize(MediaLibary())))
  EndIf
  
EndProcedure

Procedure Application_Start()
  iEndApplication   = 0
  iStartApplication = 1
  
  ; Ladebildschirm
  OpenWindow_SplashScreen()
  
  ; Ordner überprüfen
  CreateDirectory(ExecutableDirectory() + #Folder_Colors)
  CreateDirectory(ExecutableDirectory() + #Folder_Plugins)
  CreateDirectory(AppDataDirectory() + #Folder_AppData)
  CreateDirectory(AppDataDirectory() + #Folder_AppData + #Folder_Backup)
  CreateDirectory(AppDataDirectory() + #Folder_AppData + #Folder_Colors)
  
  ; Backup wiederherstellen
  If FileSize(AppDataDirectory() + #Folder_AppData + #FileName_Preferences + #FileExtension_Restore) > 0
    If CopyFile(AppDataDirectory() + #Folder_AppData + #FileName_Preferences + #FileExtension_Restore, AppDataDirectory() + #Folder_AppData + #FileName_Preferences)
      DeleteFile(AppDataDirectory() + #Folder_AppData + #FileName_Preferences + #FileExtension_Restore)
    EndIf
  EndIf
  If FileSize(AppDataDirectory() + #Folder_AppData + #FileName_PlayList + #FileExtension_Restore) > 0
    If CopyFile(AppDataDirectory() + #Folder_AppData + #FileName_PlayList + #FileExtension_Restore, AppDataDirectory() + #Folder_AppData + #FileName_PlayList)
      DeleteFile(AppDataDirectory() + #Folder_AppData + #FileName_PlayList + #FileExtension_Restore)
    EndIf
  EndIf
  If FileSize(AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + #FileExtension_Restore) > 0
    If CopyFile(AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + #FileExtension_Restore, AppDataDirectory() + #Folder_AppData + #FileName_MediaLib)
      DeleteFile(AppDataDirectory() + #Folder_AppData + #FileName_MediaLib + #FileExtension_Restore)
    EndIf
  EndIf
  
  ; Verfügbare Plugins ermitteln
  Plugin_ScanFolder()
  
  ; Einstellungen und Datenbanken öffnen
  Window_SetSplashState("Öffne Einstellungen..")
  Open_Preferences()
  Window_SetSplashState("Öffne Medienbibliothek..")
  Open_MediaLibary()
  Window_SetSplashState("Öffne Wiedergabeliste..")
  Open_PlayList()
  
  Log_Add("Starte '" + #PrgName + "'", #Log_Info)
  
  ; Medienbibliothek überprüfen
  If Pref\medialib_startcheck
    Window_SetSplashState("Überprüfe Medienbibliothek..")
    MediaLib_CheckFiles()
  EndIf
  
  ; BASS initialisieren
  Window_SetSplashState("Initialisiere BASS..")
  Bass_InitSystem(Pref\bass_device, Pref\bass_rate)
  
  ; Timer/Threads erstellen
  Window_SetSplashState("Erstelle Timer..")
  
  AddElement(Timer()) : Timer() = SetTimer_(0, 0, 50,    @Bass_Callback())
  AddElement(Timer()) : Timer() = SetTimer_(0, 0, 150,   @Window_RefreshWorker())
  AddElement(Timer()) : Timer() = SetTimer_(0, 0, 1000,  @Task())
  AddElement(Timer()) : Timer() = SetTimer_(0, 0, 60000, @AutoSave())
  AddElement(Timer()) : Timer() = SetTimer_(0, 0, 25,    @Timer_Hotkeys())
  AddElement(Timer()) : Timer() = SetTimer_(0, 0, 100,   @Timer_Misc())
  
  MediaLibScan\BGThread = CreateThread(@MediaLib_BackgroundScan(), 0)
  
  ; Callbacks
  SetWindowCallback(@Window_Callback())
  
  Window_SubClass(GadgetID(#G_TB_Main_IA_Position), @GadgetCallback_Position())
  Window_SubClass(GadgetID(#G_TB_Main_IA_Volume), @GadgetCallback_Volume())
  
  ; Netzwerk initialisieren
  Window_SetSplashState("Initialisiere Netzwerkumgebung....")
  iInitNetwork = InitNetwork()
  
  ; Oberfläche initialisieren
  Window_SetSplashState("Erstelle Programmoberfläche..")
  
  WndEx_SetMagneticValue(Pref\magneticval)
  
  MediaLib_RefreshStatusText()
  Playlist_RefreshAllTimes()
  
  DisableGadget(#G_TB_Main_IA_Position, 1)
  
  GadgetToolTip(#G_TB_Main_IA_Volume, Str(GetGadgetState(#G_TB_Main_IA_Volume)) + "%")
  
  StatusBarText(#Statusbar_Main, #SBField_MediaLibCount, Str(ListSize(MediaLibary())))
  
  Window_RefreshTaskBar()
  
  If Pref\inetstream_savefile
    Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Record, #ImageList_RecordOn)
  Else
    Toolbar_ChangeIcon(#Toolbar_Main1, #Mnu_Main_TB1_Record, #ImageList_RecordOff)
  EndIf
  
  SetGadgetState(#G_CB_Main_ML_MiscType, Pref\Misc_MLMisc)
  If GetGadgetState(#G_CB_Main_ML_MiscType) = 3
    MediaLib_ShowMisc()
  EndIf
  
  DisableToolBarButton(#Toolbar_Main1, #Mnu_Main_TB1_Record, 1)
  
  EnableGadgetDrop(#G_LI_Main_PL_PlayList, #PB_Drop_Files, #PB_Drag_Copy)
  EnableGadgetDrop(#G_CN_Main_IA_Background, #PB_Drop_Files, #PB_Drag_Copy)
  EnableGadgetDrop(#G_CN_Main_IA_Background, #PB_Drop_Private, #PB_Drag_Copy, #PrivateDrop_InfoArea)
  EnableGadgetDrop(#G_CN_Main_IA_Background, #PB_Drop_Private, #PB_Drag_Copy, #PrivateDrop_MediaLib)
  
  AddKeyboardShortcut(#Win_Main, #PB_Shortcut_Return, #Shortcut_Main_Enter)
  
  ; Automatischer Start von Plugins
  Window_SetSplashState("Starte Plugins..")
  ForEach Plugin()
    If Plugin()\start = 1
      Plugin_Run(ListIndex(Plugin()))
    EndIf
  Next
  
  ; Start
  Window_SetSplashState("Starte..")
  Repeat
    WindowEvent()
    Delay(2)
  Until timeGetTime_() - GetGadgetData(#G_IG_SplashScreen_Image) >= 800
  CloseWindow_SplashScreen()
  
  ; Neue Version überprüfen
  If Pref\startversioncheck
    UpdateCheck_Start(0)
  EndIf
  
  ; Statistiken
  Statistics\app_start = Statistics\app_start + 1
  CurrPlay\curr = 1
  
  ; Programmparameter
  Protected sProgramParameter.s
  
  sProgramParameter = GetProgramParameter()
  If FileSize(sProgramParameter) > 0
    Select UCase(GetExtensionPart(sProgramParameter))
      Case "M3U", "M3U8"
        PlayList_AddPlayListM3U(sProgramParameter, 1)
        PlayList_PlayTrack(0)
      Case "PLS"
        PlayList_AddPlayListPLS(sProgramParameter, 1)
        PlayList_PlayTrack(0)
      Case "XSPF"
        PlayList_AddPlayListXSPF(sProgramParameter, 1)
        PlayList_PlayTrack(0)
      Default
        Bass_PlayMedia(sProgramParameter, #PlayType_Normal)
    EndSelect
  ; Automatische fortsetzung der letzten Wiedergabe
  Else
    If Trim(PlayLastPlay\file) <> ""
      If FileSize(PlayLastPlay\file) > 0 Or UCase(Left(PlayLastPlay\file, 4)) = "HTTP" Or UCase(Left(PlayLastPlay\file, 3)) = "FTP"
        
        If Bass_PlayMedia(PlayLastPlay\file, PlayLastPlay\playtype, 0)
          
          ; PlayList
          If PlayLastPlay\playtype = #PlayType_PlayList
            If PlayLastPlay\plindex >= 0 And PlayLastPlay\plindex <= CountGadgetItems(#G_LI_Main_PL_PlayList) - 1
              CurrPlay\plindex = PlayLastPlay\plindex
              SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_BackColor, Pref\color[#Color_Select_BG])
              SetGadgetItemColor(#G_LI_Main_PL_PlayList, CurrPlay\plindex, #PB_Gadget_FrontColor, Pref\color[#Color_Select_FG])
            EndIf
          EndIf
          
          Bass_SetPos(PlayLastPlay\pos)
        EndIf
        
      EndIf
    EndIf
  EndIf
  
  ; SysTrayIcon
  AddSysTrayIcon(0, WindowID(#Win_Main), ImageList(#ImageList_SysTray))
  SysTrayIconToolTip(0, #PrgName)
  
  DisableWindow(#Win_Main, 0)
  HideWindow(#Win_Main, 0)
  
  StatusBarText(#Statusbar_Main, #SBField_Process, "")
  
  iStartApplication = 0
EndProcedure

Procedure Application_End(FastEnd = 0)
  
  ; Beenden-Abfragen
  If Pref\endquestion > 0 And FastEnd = 0
    If MessageRequester("Beenden", "Soll " + #PrgName + " beendet werden?", #MB_YESNO|#MB_ICONQUESTION) = #IDNO
      ProcedureReturn -1
    EndIf
  EndIf
  
  iEndApplication = 1
  
  ; Fenster Schließen
  Log_Add("Fenster Schließen..")
  HideWindow(#Win_Main, 1)
  CloseWindow_Tracker()
  CloseAllWindows()
  
  CloseHelp()
  
  ; Threads beenden
  Log_Add("Threads Anhalten..")
  MediaLibScan\Cancel = 1
  If IsThread(MediaLibScan\Thread)
    WaitThread(MediaLibScan\Thread, 2500)
  EndIf
  If IsThread(MediaLibScan\BGThread)
    WaitThread(MediaLibScan\BGThread, 2500)
  EndIf
  
  ForEach Timer()
    KillTimer_(0, Timer())
  Next
  
  ; Einstellungen Beenden
  Log_Add("Save Data..")
  Save_Preferences(1)
  Save_MediaLibary(1)
  Save_PlayList(1)
  Save_Log()
  
  ; FadeOut
  Log_Add("Fade Out..")
  Bass_FadeOut()
  
  ; Bass Beenden
  Log_Add("Free Bass..")
  BASS_Free()
  
  ; Plugins Beenden
  ForEach PluginEXE()
    Plugin_SendMessage(PluginEXE()\hWnd, #BKR_End)
  Next
  
  If Pref\misc_changemsn
    ChangeMSNStatus(0, "Music", "")
  EndIf
  
  ; Ressources Schließen
  CompilerIf #PB_Compiler_Debugger = 0
    CloseHandle_(hMutex)
  CompilerEndIf
  
  ; Sonstiges
  RemoveSysTrayIcon(0)
  
  If Update\UpdateReady And FileSize(Update\SetupFile) > 0
    RunProgram(Update\SetupFile)
  EndIf
  
  End
  
EndProcedure

; Fügt einen Logeintrag hinzu
Procedure Log_Add(String$, Type = #Log_Normal, RefreshWin = 1)
  If String$ <> "" And Pref\enablelogging = 1
    Protected iImage.i
    
    ;Maximale Einträge überprüfen
    While ListSize(Logging()) >= #MaxLog
      FirstElement(Logging())
      DeleteElement(Logging())
      If IsGadget(#G_LI_Log_Overview)
        RemoveGadgetItem(#G_LI_Log_Overview, 0)
      EndIf
    Wend
    
    ;Eintrag hinzufügen
    LastElement(Logging())
    AddElement(Logging())
    Logging()\type     = Type
    Logging()\time     = Date()
    Logging()\message  = String$
    
    Select Type
      Case #Log_Error       : iImage = ImageList(#ImageList_Error)
      Case #Log_Exclamation : iImage = ImageList(#ImageList_Exclamation)
      Case #Log_Warning     : iImage = ImageList(#ImageList_Warning)
      Case #Log_Info        : iImage = ImageList(#ImageList_Info)
      Case #Log_Normal      : iImage = ImageList(#ImageList_Info)
    EndSelect
    
    ;Gadget aktualisieren
    If IsWindow(#Win_Log)
      AddGadgetItem(#G_LI_Log_Overview, -1, FormatDate("%hh:%ii:%ss - ", Logging()\time) + Logging()\message, iImage)
      If RefreshWin
        SetGadgetItemAttribute(#G_LI_Log_Overview, -1, #PB_ListIcon_ColumnWidth, Window_GetClientWidth(GadgetID(#G_LI_Log_Overview)), 0)
        SendMessage_(GadgetID(#G_LI_Log_Overview), #LVM_ENSUREVISIBLE, CountGadgetItems(#G_LI_Log_Overview) - 1, 1)
        While WindowEvent() : Wend
      EndIf
    EndIf
    
  EndIf
EndProcedure

; Speichert den Log als Datei
Procedure Log_Save()
  If ListSize(Logging()) > 0
    Protected iFile.i, sFile.s
    
    sFile = SaveFileRequester("Log Speichern", GetCurrentDirectory() + "Log", "Text Datei|*.txt|Alle Dateien|*.*", 0)
    If sFile
      If SelectedFilePattern() = 0 And GetExtensionPart(sFile) = ""
        sFile + ".txt"
      EndIf
      
      iFile = CreateFile(#PB_Any, sFile)
      If iFile
        ForEach Logging()
          WriteStringN(iFile, FormatDate("%hh:%ii:%ss - ", Logging()\time) + Logging()\message)
        Next
        
        CloseFile(iFile)
      Else
        MsgBox_Error("Datei '" + sFile + "' konnte nicht erstellt werden.")
      EndIf
    EndIf
  EndIf
EndProcedure

Procedure Log_Copy()
  Protected iNext.i
  Protected sCopy.s
  
  For iNext = 0 To CountGadgetItems(#G_LI_Log_Overview) - 1
    If GetGadgetItemState(#G_LI_Log_Overview, iNext) & #PB_ListIcon_Selected
      sCopy + GetGadgetItemText(#G_LI_Log_Overview, iNext, 0) + #CRLF$
    EndIf
  Next
  
  SetClipboardText(sCopy)
EndProcedure

; Leert den Log
Procedure Log_Clear()
  If IsGadget(#G_LI_Log_Overview)
    ClearGadgetItems(#G_LI_Log_Overview)
  EndIf
  ClearList(Logging())
EndProcedure

Procedure Log_ShowPopUp()
  Protected iSel.i, iCount.i
  
  iSel = GetGadgetState(#G_LI_Log_Overview)
  iCount = CountGadgetItems(#G_LI_Log_Overview)
  
  If iSel = -1
    DisableMenuItem(#Menu_Log, #Mnu_Log_Copy, 1)
  Else
    DisableMenuItem(#Menu_Log, #Mnu_Log_Copy, 0)
  EndIf
  
  If iCount < 1
    DisableMenuItem(#Menu_Log, #Mnu_Log_Clear, 1)
    DisableMenuItem(#Menu_Log, #Mnu_Log_Save, 1)
  Else
    DisableMenuItem(#Menu_Log, #Mnu_Log_Clear, 0)
    DisableMenuItem(#Menu_Log, #Mnu_Log_Save, 0)    
  EndIf

  DisplayPopupMenu(#Menu_Log, WindowID(#Win_Log))
EndProcedure
; IDE Options = PureBasic 4.60 (Windows - x86)
; CursorPosition = 5421
; FirstLine = 5405
; Folding = --------------------------------
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant