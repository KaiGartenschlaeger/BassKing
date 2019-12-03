EnableExplicit
;=============================================================================
; BASS_FX 2.4 - Copyright (c) 2002-2009 (: JOBnik! :) [Arthur Aminov, ISRAEL]
;                                                     [http://www.jobnik.org]
;
;         bugs/suggestions/questions:
;           forum  : http://www.un4seen.com/forum/?board=1
;                    http://www.jobnik.org/smforum
;           e-mail : bass_fx@jobnik.org
;        --------------------------------------------------
;
; NOTE: This module will work only With BASS_FX version 2.4.4
;       Check www.un4seen.com Or www.jobnik.org For any later versions.
;
; * Requires BASS 2.4 (available @ www.un4seen.com)
;=============================================================================

; Error codes returned by BASS_ErrorGetCode
#BASS_ERROR_FX_NODECODE = 4000    ; Not a decoding channel
#BASS_ERROR_FX_BPMINUSE = 4001    ; BPM/Beat detection is in use

; Tempo / Reverse / BPM / Beat flag
#BASS_FX_FREESOURCE = $10000      ; Free the source handle As well?

;=============================================================================================
;   D S P (Digital Signal Processing)
;=============================================================================================

;  Multi-channel order of each channel is As follows:
;   3 channels       left-front, right-front, center.
;   4 channels       left-front, right-front, left-rear/side, right-rear/side.
;   6 channels (5.1) left-front, right-front, center, LFE, left-rear/side, right-rear/side.
;   8 channels (7.1) left-front, right-front, center, LFE, left-rear/side, right-rear/side, left-rear center, right-rear center.

; DSP channels flags
#BASS_BFX_CHANALL   = -1            ; all channels at once (As by Default)
#BASS_BFX_CHANNONE  = 0             ; disable an effect For all channels
#BASS_BFX_CHAN1     = 1             ; left-front channel
#BASS_BFX_CHAN2     = 2             ; right-front channel
#BASS_BFX_CHAN3     = 4             ; see above info
#BASS_BFX_CHAN4     = 8             ; see above info
#BASS_BFX_CHAN5     = 16            ; see above info
#BASS_BFX_CHAN6     = 32            ; see above info
#BASS_BFX_CHAN7     = 64            ; see above info
#BASS_BFX_CHAN8     = 128           ; see above info

; if you have more than 8 channels, use BASS_BFX_CHANNEL_N(n) below

; DSP effects
Enumeration 
  #BASS_FX_BFX_ROTATE = $10000               ; A channels volume ping-pong  / stereo
  #BASS_FX_BFX_ECHO                          ; Echo                         / 2 channels max
  #BASS_FX_BFX_FLANGER                       ; Flanger                      / multi channel
  #BASS_FX_BFX_VOLUME                        ; Volume                       / multi channel
  #BASS_FX_BFX_PEAKEQ                        ; Peaking Equalizer            / multi channel
  #BASS_FX_BFX_REVERB                        ; Reverb                       / 2 channels max
  #BASS_FX_BFX_LPF                           ; Low Pass Filter              / multi channel
  #BASS_FX_BFX_MIX                           ; Swap, remap And mix channels / multi channel
  #BASS_FX_BFX_DAMP                          ; Dynamic Amplification        / multi channel
  #BASS_FX_BFX_AUTOWAH                       ; Auto WAH                     / multi channel
  #BASS_FX_BFX_ECHO2                         ; Echo 2                       / multi channel
  #BASS_FX_BFX_PHASER                        ; Phaser                       / multi channel
  #BASS_FX_BFX_ECHO3                         ; Echo 3                       / multi channel
  #BASS_FX_BFX_CHORUS                        ; Chorus                       / multi channel
  #BASS_FX_BFX_APF                           ; All Pass Filter              / multi channel
  #BASS_FX_BFX_COMPRESSOR                    ; Compressor                   / multi channel
  #BASS_FX_BFX_DISTORTION                    ; Distortion                   / multi channel
  #BASS_FX_BFX_COMPRESSOR2                   ; Compressor 2                 / multi channel
  #BASS_FX_BFX_VOLUME_ENV                    ; Volume envelope              / multi channel
EndEnumeration

; Echo
Structure BASS_BFX_ECHO
  fLevel.f                        ; [0....1....n] linear
  lDelay.l                        ; [1200..30000]
EndStructure

; Flanger
Structure BASS_BFX_FLANGER
  fWetDry.f                       ; [0....1....n] linear
  fSpeed.f                        ; [0......0.09]
  lChannel.l                      ; BASS_BFX_CHANxxx flag/s
EndStructure

; Volume
Structure BASS_BFX_VOLUME
  lChannel.l                      ; BASS_BFX_CHANxxx flag/s Or 0 For Global volume control
  fVolume.f                       ; [0....1....n] linear
EndStructure

; Peaking Equalizer
Structure BASS_BFX_PEAKEQ
  lBand.l                           ; [0...............n] more bands means more memory & cpu usage
  fBandwidth.f                      ; [0.1.....4.......n] in octaves - Q is not in use (but BW has a priority over Q)
  fQ.f                              ; [0.......1.......n] the EE kinda definition (linear) (if Bandwidth is not in use)
  fCenter.f                         ; [1Hz..<info.freq/2] in Hz
  fGain.f                           ; [-15dB...0...+15dB] in dB
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Reverb
Structure BASS_BFX_REVERB
  fLevel.f                          ; [0....1....n] linear
  lDelay.l                          ; [1200..10000]
EndStructure

; Low Pass Filter
Structure BASS_FX_DSPLPF
  fResonance.f                      ; [0.1.............10]
  fCutOffFreq.f                     ; [1Hz....info.freq/2] cutoff frequency
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Swap, remap and mix
Structure BASS_BFX_MIX
  lChannel.l                        ; a pointer to an array of channels to mix using BASS_BFX_CHANxxx flag/s (lChannel[0] is left channel...)
EndStructure

; Dynamic Amplification
Structure BASS_BFX_DAMP
  fTarget.f                         ; target volume level                      [0<......1] linear
  fQuiet.f                          ; quiet  volume level                      [0.......1] linear
  fRate.f                           ; amp adjustment rate                      [0.......1] linear
  fGain.f                           ; amplification level                      [0...1...n] linear
  fDelay.f                          ; delay in seconds before increasing level [0.......n] linear
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Auto WAH
Structure BASS_BFX_AUTOWAH
  fDryMix.f                         ; dry (unaffected) signal mix              [-2......2]
  fWetMix.f                         ; wet (affected) signal mix                [-2......2]
  fFeedback.f                       ; feedback                                 [-1......1]
  fRate.f                           ; rate of sweep in cycles per second       [0<....<10]
  fRange.f                          ; sweep range in octaves                   [0<....<10]
  fFreq.f                           ; base frequency of sweep Hz               [0<...1000]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Echo 2
Structure BASS_BFX_ECHO2
  fDryMix.f                         ; dry (unaffected) signal mix              [-2......2]
  fWetMix.f                         ; wet (affected) signal mix                [-2......2]
  fFeedback.f                       ; feedback                                 [-1......1]
  fDelay.f                          ; delay sec                                [0<......n]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Phaser
Structure BASS_BFX_PHASER
  fDryMix.f                         ; dry (unaffected) signal mix              [-2......2]
  fWetMix.f                         ; wet (affected) signal mix                [-2......2]
  fFeedback.f                       ; feedback                                 [-1......1]
  fRate.f                           ; rate of sweep in cycles per second       [0<....<10]
  fRange.f                          ; sweep range in octaves                   [0<....<10]
  fFreq.f                           ; base frequency of sweep                  [0<...1000]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Echo 3
Structure BASS_BFX_ECHO3
  fDryMix.f                         ; dry (unaffected) signal mix              [-2......2]
  fWetMix.f                         ; wet (affected) signal mix                [-2......2]
  fDelay.f                          ; delay sec                                [0<......n]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Chorus
Structure BASS_BFX_CHORUS
  fDryMix.f                         ; dry (unaffected) signal mix              [-2......2]
  fWetMix.f                         ; wet (affected) signal mix                [-2......2]
  fFeedback.f                       ; feedback                                 [-1......1]
  fMinSweep.f                       ; minimal delay ms                         [0<..<6000]
  fMaxSweep.f                       ; maximum delay ms                         [0<..<6000]
  fRate.f                           ; rate ms/s                                [0<...1000]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; All Pass Filter
Structure BASS_BFX_APF
  fGain.f                           ; reverberation time                       [-1=<..<=1]
  fDelay.f                          ; delay sec                                [0<....<=n]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Compressor
Structure BASS_BFX_COMPRESSOR
  fThreshold.f                      ; compressor threshold                     [0<=...<=1]
  fAttacktime.f                     ; attack time ms                           [0<.<=1000]
  fReleasetime.f                    ; release time ms                          [0<.<=5000]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Distortion
Structure BASS_BFX_DISTORTION
  fDrive.f                          ; distortion drive                         [0<=...<=5]
  fDryMix.f                         ; dry (unaffected) signal mix              [-5<=..<=5]
  fWetMix.f                         ; wet (affected) signal mix                [-5<=..<=5]
  fFeedback.f                       ; feedback                                 [-1<=..<=1]
  fVolume.f                         ; distortion volume                        [0=<...<=2]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Compressor 2
Structure BASS_BFX_COMPRESSOR2
  fGain.f                           ; output gain of signal after compression  [-60....60] in dB
  fThreshold.f                      ; point at which compression begins        [-60.....0] in dB
  fRatio.f                          ; compression ratio                        [1.......n]
  fAttack.f                         ; attack time in ms                        [0.01.1000]
  fRelease.f                        ; release time in ms                       [0.01.5000]
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
EndStructure

; Volume envelope
Structure BASS_BFX_ENV_NODE
  pos.d                             ; node position in seconds (1st envelope node must be at position 0)
  val.i                             ; node value
EndStructure

Structure BASS_BFX_VOLUME_ENV
  lChannel.l                        ; BASS_BFX_CHANxxx flag/s
  lNodeCount.l                      ; number of nodes
  pNodes.l                          ; the nodes. Pointer to nodes of BASS_BFX_ENV_NODE
  bFollow.l                         ; follow source position
EndStructure

Import "bass_fx.lib"
  BASS_FX_GetVersion.l()
  
  BASS_FX_TempoCreate.l( chan.l, flags.l )
  BASS_FX_TempoGetSource.l( chan.l )
  BASS_FX_TempoGetRateRatio.l( chan.l )
  
  BASS_FX_ReverseCreate.l( chan.l, dec_block.f, flags.l )
  BASS_FX_ReverseGetSource.l( chan.l )
  
  BASS_FX_BPM_DecodeGet.f( chan.l, startSec.d, endSec.d, minMaxBPM.l, flags.l, *proc )
  BASS_FX_BPM_CallbackSet.l( handle.l, *proc, period.d, minMaxBPM.l, flags.l, user.l )
  BASS_FX_BPM_CallbackReset.l( handle.l )
  BASS_FX_BPM_Translate.f( handle.l, val2tran.f, trans.l )
  BASS_FX_BPM_Free.l( handle.l )
  
  BASS_FX_BPM_BeatCallbackSet.l( handle.l, *proc, *user )
  BASS_FX_BPM_BeatCallbackReset.l( handle.l )
  BASS_FX_BPM_BeatDecodeGet.l( chan.l, startSec.d, endSec.d, flags.l, *proc, *user )
  BASS_FX_BPM_BeatSetParameters.l( handle.l, bandwidth.f, centerfreq.f, beat_rtime.f )
  BASS_FX_BPM_BeatGetParameters.l( handle.l, *bandwidth, *centerfreq, *beat_rtime )
  BASS_FX_BPM_BeatFree.l()
EndImport

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;       set dsp fx - BASS_ChannelSetFX
; ===========================================================================================
;       remove dsp fx - BASS_ChannelRemoveFX
; ===========================================================================================
;       set parameters - BASS_FXSetParameters
; ===========================================================================================
;       retrieve parameters - BASS_FXGetParameters
; ===========================================================================================
;       reset the state - BASS_FXReset
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

;=============================================================================================
;   TEMPO / PITCH SCALING / SAMPLERATE
;=============================================================================================

; NOTE: 1. Supported only - mono / stereo - channels
;       2. Enable Tempo supported flags in BASS_FX_TempoCreate and the others to source handle.

; tempo attributes (BASS_ChannelSet/GetAttribute)
Enumeration
  #BASS_ATTRIB_TEMPO        = $10000
  #BASS_ATTRIB_TEMPO_PITCH
  #BASS_ATTRIB_TEMPO_FREQ
EndEnumeration

; tempo attributes options
;         [option]                                      [value]
Enumeration
  #BASS_ATTRIB_TEMPO_OPTION_USE_AA_FILTER = $10010     ; TRUE (default) / FALSE
  #BASS_ATTRIB_TEMPO_OPTION_AA_FILTER_LENGTH           ; 32 default (8 .. 128 taps)
  #BASS_ATTRIB_TEMPO_OPTION_USE_QUICKALGO              ; TRUE / FALSE (default)
  #BASS_ATTRIB_TEMPO_OPTION_SEQUENCE_MS                ; 82 default, 0 = automatic
  #BASS_ATTRIB_TEMPO_OPTION_SEEKWINDOW_MS              ; 28 default, 0 = automatic
  #BASS_ATTRIB_TEMPO_OPTION_OVERLAP_MS                 ; 8  default
  #BASS_ATTRIB_TEMPO_OPTION_PREVENT_CLICK              ; TRUE / FALSE (default)
EndEnumeration

;=============================================================================================
;   R E V E R S E
;=============================================================================================

; NOTE: 1. MODs won't load without BASS_MUSIC_PRESCAN flag.
;       2. Enable Reverse supported flags in BASS_FX_ReverseCreate and the others to source handle.

; reverse attribute (BASS_ChannelSet/GetAttribute)
#BASS_ATTRIB_REVERSE_DIR = $11000

; playback directions
#BASS_FX_RVS_REVERSE = -1
#BASS_FX_RVS_FORWARD = 1

;=============================================================================================
;   B P M (Beats Per Minute)
;=============================================================================================

; bpm flags
#BASS_FX_BPM_BKGRND = 1   ; if in use, then you can do other processing while detection's in progress. (BPM/Beat)
#BASS_FX_BPM_MULT2 = 2    ; if in use, then will auto multiply bpm by 2 (if BPM < minBPM*2)

; translation options
Enumeration
  #BASS_FX_BPM_TRAN_X2         ; multiply the original BPM value by 2 (may be called only once & will change the original BPM as well!)
  #BASS_FX_BPM_TRAN_2FREQ      ; BPM value to Frequency
  #BASS_FX_BPM_TRAN_FREQ2      ; Frequency to BPM value
  #BASS_FX_BPM_TRAN_2PERCENT   ; BPM value to Percents
  #BASS_FX_BPM_TRAN_PERCENT2   ; Percents to BPM value
EndEnumeration
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; Folding = ----
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 1
; EnableBuildCount = 0
; EnableExeConstant