; BASSCD 2.4 Visual Basic module
; Copyright (c) 2003-2009 Un4seen Developments Ltd.
;
; See the BASSCD.CHM file For more detailed documentation

; Additional error codes returned by BASS_ErrorGetCode
#BASS_ERROR_NOCD     = 12  ; no CD in drive
#BASS_ERROR_CDTRACK  = 13  ; invalid track number
#BASS_ERROR_NOTAUDIO = 17  ; Not an audio track

; Additional BASS_SetConfig options
#BASS_CONFIG_CD_FREEOLD    = $10200
#BASS_CONFIG_CD_RETRY      = $10201
#BASS_CONFIG_CD_AUTOSPEED  = $10202
#BASS_CONFIG_CD_SKIPERROR  = $10203

; BASS_CD_SetInterface options
#BASS_CD_IF_AUTO  = 0
#BASS_CD_IF_SPTI  = 1
#BASS_CD_IF_ASPI  = 2
#BASS_CD_IF_WIO   = 3

Structure BASS_CD_INFO
  vendor.l      ; manufacturer
  product.l     ; model
  rev.l         ; revision
  letter.l      ; drive letter
  rwflags.l     ; read/write capability flags
  canopen.l     ; BASS_CD_DOOR_OPEN/CLOSE is supported?
  canlock.l     ; BASS_CD_DOOR_LOCK/UNLOCK is supported?
  maxspeed.l    ; max Read speed (KB/s)
  cache.l       ; cache size (KB)
  cdtext.l      ; can Read CD-TEXT
EndStructure

; "rwflag" Read capability flags
#BASS_CD_RWFLAG_READCDR       = 1
#BASS_CD_RWFLAG_READCDRW      = 2
#BASS_CD_RWFLAG_READCDRW2     = 4
#BASS_CD_RWFLAG_READDVD       = 8
#BASS_CD_RWFLAG_READDVDR      = 16
#BASS_CD_RWFLAG_READDVDRAM    = 32
#BASS_CD_RWFLAG_READANALOG    = $10000
#BASS_CD_RWFLAG_READM2F1      = $100000
#BASS_CD_RWFLAG_READM2F2      = $200000
#BASS_CD_RWFLAG_READMULTI     = $400000
#BASS_CD_RWFLAG_READCDDA      = $1000000
#BASS_CD_RWFLAG_READCDDASIA   = $2000000
#BASS_CD_RWFLAG_READSUBCHAN   = $4000000
#BASS_CD_RWFLAG_READSUBCHANDI = $8000000
#BASS_CD_RWFLAG_READC2        = $10000000
#BASS_CD_RWFLAG_READISRC      = $20000000
#BASS_CD_RWFLAG_READUPC       = $40000000

; additional BASS_CD_StreamCreate/File flags
#BASS_CD_SUBCHANNEL       = $200
#BASS_CD_SUBCHANNEL_NOHW  = $400
#BASS_CD_C2ERRORS         = $800

; additional CD sync types
#BASS_SYNC_CD_ERROR = 1000
#BASS_SYNC_CD_SPEED = 1002

; BASS_CD_Door actions
#BASS_CD_DOOR_CLOSE = 0
#BASS_CD_DOOR_OPEN = 1
#BASS_CD_DOOR_LOCK = 2
#BASS_CD_DOOR_UNLOCK = 3

; BASS_CD_GetID flags
#BASS_CDID_UPC         = 1
#BASS_CDID_CDDB        = 2
#BASS_CDID_CDDB2       = 3
#BASS_CDID_TEXT        = 4
#BASS_CDID_CDPLAYER    = 5
#BASS_CDID_MUSICBRAINZ = 6
#BASS_CDID_ISRC        = $100 ; + track #

; BASS_CHANNELINFO type
#BASS_CTYPE_STREAM_CD  = $10200

Import "basscd.lib"
  BASS_CD_SetInterface.l( iface.l )
  
  BASS_CD_GetInfo.l( drive.l, *info )
  BASS_CD_Door( drive.l, action.l )
  BASS_CD_DoorIsLocked( drive.l )
  BASS_CD_DoorIsOpen( drive.l )
  BASS_CD_IsReady( drive.l )
  BASS_CD_GetTracks( drive.l )
  BASS_CD_GetTrackLength.i( drive.l, track.l )
  BASS_CD_GetTrackPregap.i( drive.l, track.l )
  BASS_CD_GetID( drive.l, id.l )
  BASS_CD_GetSpeed( drive.l )
  BASS_CD_SetSpeed( drive.l, speed.l )
  BASS_CD_Release( drive.l )
  
  BASS_CD_StreamCreate( drive.l, track.l, flags.l )
  BASS_CD_StreamCreateFile( f.s, flags.l )
  BASS_CD_StreamGetTrack( handle.l )
  BASS_CD_StreamSetTrack( handle.l, track.l )
  
  BASS_CD_Analog_Play( drive.l, track.l, pos.l )
  BASS_CD_Analog_PlayFile( f.s, pos.l )
  BASS_CD_Analog_Stop( drive.l )
  BASS_CD_Analog_IsActive( drive.l )
  BASS_CD_Analog_GetPosition( drive.l)
EndImport
; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 61
; FirstLine = 35
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant