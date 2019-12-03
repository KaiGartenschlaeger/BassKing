;BASSmix 2.4 C/C++ header file
;Copyright (c) 2005-2008 Un4seen Developments Ltd.
;
;See the BASSMIX.CHM file for more detailed documentation
;
;BASSmix v2.4 include for PureBasic v4.20
;C to PB adaption by Roger "Rescator" Hågensen, 7th March 2008, http://EmSai.net/

;additional BASS_SetConfig option
#BASS_CONFIG_MIXER_FILTER	=$10600
#BASS_CONFIG_MIXER_BUFFER	=$10601

;BASS_Mixer_StreamCreate flags
#BASS_MIXER_END			  =$10000	;end the stream when there are no sources
#BASS_MIXER_NONSTOP	=$20000	;don't stall when there are no sources
#BASS_MIXER_RESUME		=$1000	 ;resume stalled immediately upon new/unpaused source

;source flags
#BASS_MIXER_FILTER		 =$1000	  ;resampling filter
#BASS_MIXER_BUFFER		 =$2000	  ;buffer data for BASS_Mixer_ChannelGetData/Level
#BASS_MIXER_MATRIX		 =$10000	 ;matrix mixing
#BASS_MIXER_PAUSE		  =$20000	 ;don't process the source
#BASS_MIXER_DOWNMIX	 =$400000 ;downmix to stereo/mono
#BASS_MIXER_NORAMPIN	=$800000 ;don't ramp-in the start

;envelope node
Structure BASS_MIXER_NODE
	pos.q
	value.f
EndStructure

;envelope types
#BASS_MIXER_ENV_FREQ	=1
#BASS_MIXER_ENV_VOL		=2
#BASS_MIXER_ENV_PAN		=3
#BASS_MIXER_ENV_LOOP	=$10000 ;FLAG: loop

;additional sync type
#BASS_SYNC_MIXER_ENVELOPE	=$10200

;BASS_CHANNELINFO type
#BASS_CTYPE_STREAM_MIXER	=$10800

;BASSmix Functions
Import "bassmix.lib"
 BASS_Mixer_GetVersion.l()
 
 BASS_Mixer_StreamCreate.l(freq.l,chans.l,flags.l)
 BASS_Mixer_StreamAddChannel.l(handle.l,channel.l,flags.l)
 BASS_Mixer_StreamAddChannelEx.l(handle.l,channel.l,flags.l,start.q,length.q)
 
 BASS_Mixer_ChannelGetMixer.l(handle.l)
 BASS_Mixer_ChannelFlags.l(handle.l,flags.l,mask.l)
 BASS_Mixer_ChannelRemove.l(handle.l)
 BASS_Mixer_ChannelSetPosition.l(handle.l,pos.q,mode.l)
 BASS_Mixer_ChannelGetPosition.q(handle.l,mode.l)
 BASS_Mixer_ChannelGetLevel.l(handle.l)
 BASS_Mixer_ChannelGetData.l(handle.l,*buffer,length.l)
 BASS_Mixer_ChannelSetSync.l(handle.l,type.l,param.q,*proc,*user)
 BASS_Mixer_ChannelRemoveSync.l(channel.l,sync.l)
 BASS_Mixer_ChannelSetMatrix.l(handle.l,*matrix)
 BASS_Mixer_ChannelGetMatrix.l(handle.l,*matrix)
 BASS_Mixer_ChannelSetEnvelope.l(handle.l,type.l,*nodes,count.l)
 BASS_Mixer_ChannelSetEnvelopePos.l(handle.l,type.l,pos.q)
 BASS_Mixer_ChannelGetEnvelopePos.q(handle.l,type.l,*value)
EndImport
; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 65
; FirstLine = 19
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant