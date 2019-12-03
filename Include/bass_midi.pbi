EnableExplicit
; BASSMIDI 2.4 Visual Basic module
; Copyright (c) 2006-2009 Un4seen Developments Ltd.
;
; See the BASSMIDI.CHM file for more detailed documentation
;

; Additional BASS_SetConfig options
#BASS_CONFIG_MIDI_COMPACT   = $10400
#BASS_CONFIG_MIDI_VOICES    = $10401
#BASS_CONFIG_MIDI_AUTOFONT  = $10402

; Additional sync types
#BASS_SYNC_MIDI_MARKER  = $10000
#BASS_SYNC_MIDI_CUE     = $10001
#BASS_SYNC_MIDI_LYRIC   = $10002
#BASS_SYNC_MIDI_TEXT    = $10003
#BASS_SYNC_MIDI_EVENT   = $10004
#BASS_SYNC_MIDI_TICK    = $10005

; Additional BASS_MIDI_StreamCreateFile/etc flags
#BASS_MIDI_DECAYEND  = $1000
#BASS_MIDI_NOFX      = $2000
#BASS_MIDI_DECAYSEEK = $4000

Structure BASS_MIDI_FONT
  font.l            ; soundfont
  preset.l          ; preset number (-1=all)
  bank.l
EndStructure

Structure BASS_MIDI_FONTINFO
  name.l
  copyright.l
  comment.l
  presets.l         ; number of presets/instruments
  samsize.l         ; total size (in bytes) of the sample Data
  samload.l         ; amount of sample Data currently loaded
  samtype.l         ; sample format (CTYPE) If packed
EndStructure

Structure BASS_MIDI_MARK
  track.l           ; track containing marker
  pos.l             ; marker position
  text.l            ; marker text
EndStructure

; Marker types
#BASS_MIDI_MARK_MARKER = 0  ; marker events
#BASS_MIDI_MARK_CUE = 1     ; cue events
#BASS_MIDI_MARK_LYRIC = 2   ; lyric events
#BASS_MIDI_MARK_TEXT = 3    ; text events

; MIDI events
#MIDI_EVENT_NOTE = 1
#MIDI_EVENT_PROGRAM = 2
#MIDI_EVENT_CHANPRES = 3
#MIDI_EVENT_PITCH = 4
#MIDI_EVENT_PITCHRANGE = 5
#MIDI_EVENT_DRUMS = 6
#MIDI_EVENT_FINETUNE = 7
#MIDI_EVENT_COARSETUNE = 8
#MIDI_EVENT_MASTERVOL = 9
#MIDI_EVENT_BANK = 10
#MIDI_EVENT_MODULATION = 11
#MIDI_EVENT_VOLUME = 12
#MIDI_EVENT_PAN = 13
#MIDI_EVENT_EXPRESSION = 14
#MIDI_EVENT_SUSTAIN = 15
#MIDI_EVENT_SOUNDOFF = 16
#MIDI_EVENT_RESET = 17
#MIDI_EVENT_NOTESOFF = 18
#MIDI_EVENT_PORTAMENTO = 19
#MIDI_EVENT_PORTATIME = 20
#MIDI_EVENT_PORTANOTE = 21
#MIDI_EVENT_MODE = 22
#MIDI_EVENT_REVERB = 23
#MIDI_EVENT_CHORUS = 24
#MIDI_EVENT_CUTOFF = 25
#MIDI_EVENT_RESONANCE = 26
#MIDI_EVENT_REVERB_MACRO = 30
#MIDI_EVENT_CHORUS_MACRO = 31
#MIDI_EVENT_REVERB_TIME = 32
#MIDI_EVENT_REVERB_DELAY = 33
#MIDI_EVENT_REVERB_LOCUTOFF = 34
#MIDI_EVENT_REVERB_HICUTOFF = 35
#MIDI_EVENT_REVERB_LEVEL = 36
#MIDI_EVENT_CHORUS_DELAY = 37
#MIDI_EVENT_CHORUS_DEPTH = 38
#MIDI_EVENT_CHORUS_RATE = 39
#MIDI_EVENT_CHORUS_FEEDBACK = 40
#MIDI_EVENT_CHORUS_LEVEL = 41
#MIDI_EVENT_CHORUS_REVERB = 42
#MIDI_EVENT_DRUM_FINETUNE = 50
#MIDI_EVENT_DRUM_COARSETUNE = 51
#MIDI_EVENT_DRUM_PAN = 52
#MIDI_EVENT_DRUM_REVERB = 53
#MIDI_EVENT_DRUM_CHORUS = 54
#MIDI_EVENT_DRUM_CUTOFF = 55
#MIDI_EVENT_DRUM_RESONANCE = 56
#MIDI_EVENT_TEMPO = 62
#MIDI_EVENT_MIXLEVEL = $10000
#MIDI_EVENT_TRANSPOSE = $10001

; BASS_CHANNELINFO type
#BASS_CTYPE_STREAM_MIDI = $10D00

; Additional attributes
#BASS_ATTRIB_MIDI_PPQN = $12000
#BASS_ATTRIB_MIDI_TRACK_VOL = $12100 ; + track #

; Additional BASS_ChannelGetTags type
#BASS_TAG_MIDI_TRACK = $11000 ; + track #, track text : Array of null-terminated ANSI strings

; BASS_ChannelGetLength/GetPosition/SetPosition mode
#BASS_POS_MIDI_TICK = 2 ; tick position

Import "bassmidi.lib"
  BASS_MIDI_StreamCreate( channels.l, flags.l, freq.l )
  BASS_MIDI_StreamCreateFile( mem.l, *file, offset.q, length.q, flags.l, freq.l )
  BASS_MIDI_StreamCreateURL( url.s, offset.l, flags.l, proc.l, user.l, freq.l )
  BASS_MIDI_StreamCreateFileUser( system.l, flags.l, procs.l, user.l, freq.l )
  BASS_MIDI_StreamGetMark( handle.l, type_.l, index.l, marks.l )
  BASS_MIDI_StreamSetFonts( handle.l, fonts.i, count.l )
  BASS_MIDI_StreamGetFonts( handle.l, fonts.l, count.l )
  BASS_MIDI_StreamLoadSamples( handle.l )
  BASS_MIDI_StreamEvent( handle.l, chan.l, event_.l, param.l )
  BASS_MIDI_StreamGetEvent( handle.l, chan.l, event.l )
  BASS_MIDI_StreamGetChannel( handle.l, chan.l )
  BASS_MIDI_FontInit( file.l, flags.l )
  BASS_MIDI_FontFree( handle.l )
  BASS_MIDI_FontGetInfo( handle.l, info.l )
  BASS_MIDI_FontGetPreset( handle.l, preset.l, bank.l )
  BASS_MIDI_FontLoad( handle.l, preset.l, bank.l )
  BASS_MIDI_FontCompact( handle.l )
  BASS_MIDI_FontPack( handle.l, outfile.s, encoder.s, flags.l )
  BASS_MIDI_FontUnpack( handle.l, outfile.s, flags.l )
  BASS_MIDI_FontSetVolume( handle.l, volume.f )
  BASS_MIDI_FontGetVolume( handle.l )
EndImport
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 2
; EnableBuildCount = 0
; EnableExeConstant