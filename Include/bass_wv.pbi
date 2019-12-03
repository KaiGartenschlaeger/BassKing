EnableExplicit
; BASSWV 2.4 Visual Basic module
; Copyright (c) 2007-2008 Un4seen Developments Ltd.
;
; See the BASSWV.CHM file For more detailed documentation
;
; Additional tags available from BASS_StreamGetTags
#BASS_TAG_APE = 6 ; APE tags

; BASS_CHANNELINFO type
#BASS_CTYPE_STREAM_WV = $10500

Import "basswv.lib"
  BASS_WV_StreamCreateFile( mem.l, *file, offset.q, length.q, flags.l )
  BASS_WV_StreamCreateFileUser( system.l, flags.l, *procs, *user )
EndImport
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant