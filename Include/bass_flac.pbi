EnableExplicit

#BASS_CHANNEL_STREAM_FLAC       = $10900
#BASS_CHANNEL_STREAM_FLAC_OGG   = $10901

Import "bassflac.lib"
  BASS_FLAC_StreamCreateFile( mem.l, *file, offset.q, length.q, flags.l )
  BASS_FLAC_StreamCreateFileUser( system.l, flags.l, *procs, *user )
  BASS_FLAC_StreamCreateURL( *url, offset.q, flags.l, *proc, *user )  
EndImport
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; CursorPosition = 9
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 3
; EnableBuildCount = 0
; EnableExeConstant