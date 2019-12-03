EnableExplicit
; Additional error codes returned by BASS_ErrorGetCode
#BASS_ERROR_WMA_LICENSE      = 1000             ; the file is protected
#BASS_ERROR_WMA              = 1001             ; Windows Media (9 Or above) is Not installed
#BASS_ERROR_WMA_WM9          = #BASS_ERROR_WMA
#BASS_ERROR_WMA_DENIED       = 1002             ; access denied (user/pass is invalid)
#BASS_ERROR_WMA_INDIVIDUAL   = 1004             ; individualization is needed

; Additional BASS_SetConfig options
#BASS_CONFIG_WMA_PRECHECK    = $10100
#BASS_CONFIG_WMA_PREBUF      = $10101
#BASS_CONFIG_WMA_BASSFILE    = $10103
#BASS_CONFIG_WMA_VIDEO       = $10105
#BASS_CONFIG_WMA_NETSEEK     = $10104

; additional WMA sync types
#BASS_SYNC_WMA_CHANGE        = $10100
#BASS_SYNC_WMA_META          = $10101

; additional BASS_StreamGetFilePosition WMA mode
#BASS_FILEPOS_WMA_BUFFER     = 1000 ; internet buffering progress (0-100%)

; Additional flags For use With BASS_WMA_EncodeOpenFile/Network/Publish
#BASS_WMA_ENCODE_STANDARD    = $2000   ; standard WMA
#BASS_WMA_ENCODE_PRO         = $4000   ; WMA Pro
#BASS_WMA_ENCODE_24BIT       = 32768   ; 24-bit
#BASS_WMA_ENCODE_SCRIPT      = $20000  ; set script (mid-stream tags) in the WMA encoding

; Additional flag For use With BASS_WMA_EncodeGetRates
#BASS_WMA_ENCODE_RATES_VBR  = $10000  ; get available VBR quality settings

; WMENCODEPROC "type" values
#BASS_WMA_ENCODE_HEAD = 0
#BASS_WMA_ENCODE_DATA = 1
#BASS_WMA_ENCODE_DONE = 2

; BASS_WMA_EncodeSetTag "type" values
#BASS_WMA_TAG_ANSI     = 0
#BASS_WMA_TAG_UNICODE  = 1
#BASS_WMA_TAG_UTF8     = 2

; BASS_CHANNELINFO type
#BASS_CTYPE_STREAM_WMA      = $10300
#BASS_CTYPE_STREAM_WMA_MP3  = $10301

; Additional BASS_ChannelGetTags types
#BASS_TAG_WMA        = 8  ; WMA header tags : series of null-terminated UTF-8 strings
#BASS_TAG_WMA_META   = 11 ; WMA mid-stream tag : UTF-8 string

;- BASS Functions
Import "basswma.lib"
  BASS_WMA_StreamCreateFile.l(mem.l, *file, offset.q, length.q, flags.l)
  BASS_WMA_StreamCreateFileAuth( mem.l, *file, offset.l, length.l, flags.l, *user, *pass )
  BASS_WMA_StreamCreateFileUser( system.l, flags.l, *procs, *user )
  BASS_WMA_GetWMObject( handle.l )
  BASS_WMA_EncodeClose( handle.l )
  BASS_WMA_EncodeGetClients( handle.l )
  BASS_WMA_EncodeGetPort( handle.l )
  BASS_WMA_EncodeGetRates( freq.l, chans.l, flags.l )
  BASS_WMA_EncodeOpen( freq.l, chans.l, flags.l, bitrate.l, *proc, *user )
  BASS_WMA_EncodeOpenFile( freq.l, chans.l, flags.l, bitrate.l, *file )
  BASS_WMA_EncodeOpenNetwork( freq.l, chans.l, flags.l, bitrate.l, port.l, clients.l )
  BASS_WMA_EncodeOpenNetworkMulti( freq.l, chans.l, flags.l, *bitrates, port.l, clients.l )
  BASS_WMA_EncodeOpenPublish( freq.l, chans.l, flags.l, bitrate.l, *url, *user, *pass )
  BASS_WMA_EncodeOpenPublishMulti( freq.l, chans.l, flags.l, *bitrates, *url, *user, *pass )
  BASS_WMA_EncodeSetNotify( handle.l, *proc, *user )
  BASS_WMA_EncodeSetTag( handle.l, *tag, *value, type.l )
  BASS_WMA_EncodeWrite( handle.l, *buffer, length.l )
EndImport
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 5
; EnableBuildCount = 0
; EnableExeConstant