;BASSenc 2.4 C/C++ header file
;Copyright (c) 2003-2008 Un4seen Developments Ltd.
;
;See the BASSENC.CHM file for more detailed documentation
;
;BASSenc v2.4 include for PureBasic v4.20
;C to PB adaption by Roger "Rescator" Hågensen, 5th March 2008, http://EmSai.net/

;Additional error codes returned by BASS_ErrorGetCode
#BASS_ERROR_ACM_CANCEL	 =2000	;ACM codec selection cancelled
#BASS_ERROR_CAST_DENIED	=2100	;access denied (invalid password)

;Additional BASS_SetConfig options
#BASS_CONFIG_ENCODE_PRIORITY		   =$10300 ;encoder DSP priority
#BASS_CONFIG_ENCODE_CAST_TIMEOUT	=$10310 ;cast timeout

;BASS_Encode_Start flags
#BASS_ENCODE_NOHEAD		 =1	     ;do not send a WAV header to the encoder
#BASS_ENCODE_FP_8BIT		=2	     ;convert floating-point sample Data To 8-bit integer
#BASS_ENCODE_FP_16BIT	=4	     ;convert floating-point sample Data To 16-bit integer
#BASS_ENCODE_FP_24BIT	=6	     ;convert floating-point sample Data To 24-bit integer
#BASS_ENCODE_FP_32BIT	=8	     ;convert floating-point sample Data To 32-bit integer
#BASS_ENCODE_BIGEND		 =16	    ;big-endian sample data
#BASS_ENCODE_PAUSE		  =32	    ;start encording paused
#BASS_ENCODE_PCM			   =64	    ;write PCM sample Data (no encoder)
#BASS_ENCODE_AUTOFREE	=$40000	;free the encoder when the channel is freed

;BASS_Encode_GetACMFormat flags
#BASS_ACM_DEFAULT	=1	;use the format as default selection
#BASS_ACM_RATE			 =2	;only list formats with same sample rate as the source channel
#BASS_ACM_CHANS			=4	;only list formats with same number of channels (eg. mono/stereo)
#BASS_ACM_SUGGEST	=8	;suggest a format (HIWORD=format tag)

;BASS_Encode_GetCount counts
#BASS_ENCODE_COUNT_IN	  =0	;sent to encoder
#BASS_ENCODE_COUNT_OUT	 =1	;received from encoder
#BASS_ENCODE_COUNT_CAST	=2	;sent to cast server

;BASS_Encode_CastInit content MIME types
#BASS_ENCODE_TYPE_MP3	="audio/mpeg"
#BASS_ENCODE_TYPE_OGG	="application/ogg"
#BASS_ENCODE_TYPE_AAC	="audio/aacp"

;BASS_Encode_CastGetStats types
#BASS_ENCODE_STATS_SHOUT		 =0	;Shoutcast stats
#BASS_ENCODE_STATS_ICE		   =1	;Icecast mount-point stats
#BASS_ENCODE_STATS_ICESERV	=2	;Icecast server stats

; typedef void (CALLBACK ENCODEPROC)(HENCODE handle, DWORD channel, const void *buffer, DWORD length, void *user);
; /* Encoding callback function.
; handle : The encoder
; channel: The channel handle
; buffer : Buffer containing the encoded Data
; length : Number of bytes
; user   : The 'user' parameter value given when calling BASS_Encode_Start */
 
; typedef void (CALLBACK ENCODENOTIFYPROC)(HENCODE handle, DWORD status, void *user);
; /* Encoder death notification callback function.
; handle : The encoder
; status : Notification (BASS_ENCODE_NOTIFY_xxx)
; user   : The 'user' parameter value given when calling BASS_Encode_SetNotify */

;Encoder notifications
#BASS_ENCODE_NOTIFY_ENCODER	     =1	;encoder died
#BASS_ENCODE_NOTIFY_CAST		       =2	;cast server connection died
#BASS_ENCODE_NOTIFY_CAST_TIMEOUT	=$10000 ;cast timeout

;BASSenc Functions
Import "bassenc.lib"
 BASS_Encode_GetVersion.l()
 BASS_Encode_Start.l(handle.l,*cmdline,flags.l,*proc,*user)
 BASS_Encode_IsActive.l(handle.l)
 BASS_Encode_Stop.l(handle.l)
 BASS_Encode_SetPaused.l(handle.l,paused.l)
 BASS_Encode_Write.l(handle.l,*buffer,length.l)
 BASS_Encode_SetNotify.l(handle.l,*proc,*user)
 BASS_Encode_GetCount.q(handle.l,count.l)
 BASS_Encode_SetChannel.l(handle.l,channel.l)
 BASS_Encode_GetChannel.l(handle.l)
 CompilerIf #PB_Compiler_OS=#PB_OS_Windows
  BASS_Encode_GetACMFormat.l(handle.l,*form,formlen.l,*title,flags.l)
  BASS_Encode_StartACM.l(handle.l,*form,flags.l,*proc,*user)
  BASS_Encode_StartACMFile.l(handle.l,*form,flags.l,*file)
 CompilerEndIf
 BASS_Encode_CastInit.l(handle.l,*server,*pass,*content,*name,*url,*genre,*desc,*headers,bitrate.l,pub.l)
 BASS_Encode_CastSetTitle.l(handle.l,*title,*url)
 BASS_Encode_CastGetStats.l(handle.l,type.l,*pass)
EndImport
