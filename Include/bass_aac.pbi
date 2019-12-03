EnableExplicit

; Additional BASS_SetConfig options
#BASS_CONFIG_MP4_VIDEO = $10700 ; play the audio from MP4 videos

; Additional tags available from BASS_StreamGetTags
#BASS_TAG_MP4 = 7       ; MP4/iTunes metadata

#BASS_AAC_DOWNMATRIX = $400000  ; downmatrix To stereo

; BASS_CHANNELINFO type
#BASS_CTYPE_STREAM_AAC = $10B00
#BASS_CTYPE_STREAM_MP4 = $10B01

Import "bass_aac.lib"
  BASS_AAC_StreamCreateFile.l( mem.l, file.l, offset.l, length.l, flags.l )
  BASS_AAC_StreamCreateFileUser.l( system.l, flags.l, *procs, *user )
  BASS_AAC_StreamCreateURL.l( url.s, offset.l, flags.l, *proc, *user )
  BASS_MP4_StreamCreateFile.l( mem.l, file.l, offset.l, length.l, flags.l )
  BASS_MP4_StreamCreateFileUser.l( system.l, flags.l, *procs, *user )
EndImport
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; CursorPosition = 20
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant