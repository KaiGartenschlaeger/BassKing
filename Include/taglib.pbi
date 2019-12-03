EnableExplicit
; Current Version: 1.5 (http://developer.kde.org/~wheeler/taglib.html)
; LastEdit:        Kai Gartenschläger, 07.06.2009
; PureBasic:       4.31 x86

ImportC "tag_c.lib"
  taglib_audioproperties_bitrate(audioProperties.l) As "_taglib_audioproperties_bitrate"
  ; Returns the bitrate of the file in kb/s.
  
  taglib_audioproperties_channels(audioProperties.l) As "_taglib_audioproperties_channels"
  ; Returns the number of channels in the audio stream.
  
  taglib_audioproperties_length(audioProperties.l) As "_taglib_audioproperties_length"
  ; Returns the length of the file in seconds.
  
  taglib_audioproperties_samplerate(audioProperties.l) As "_taglib_audioproperties_samplerate"
  ; Returns the sample rate of the file in Hz.
  
  taglib_file_audioproperties(file.l) As "_taglib_file_audioproperties"
  ; Returns a pointer To the the audio properties associated With this file.  This will be freed automatically when the file is freed.
  
  taglib_file_free(file.l) As "_taglib_file_free"
  ; Frees And closes the file.
  
  taglib_file_is_valid(file.l) As "_taglib_file_is_valid"
  ; Unknown
  
  taglib_file_new(filename.s) As "_taglib_file_new"
  ; Creates a TagLib file based on \a filename.  TagLib will try To guess the file type.
  ; \returns NULL If the file type cannot be determined Or the file cannot be opened.
    
  taglib_file_new_type(filename.s,type.l) As "_taglib_file_new_type"
  ; Creates a TagLib file based on \a filename.  Rather than attempting To guess the type, it will use the one specified by \a type.
  
  taglib_file_save(file.l) As "_taglib_file_save"
  ; Saves the \a file To disk.
  
  taglib_file_tag(file.l) As "_taglib_file_tag"
  ; Returns a pointer To the tag associated With this file.  This will be freed automatically when the file is freed.
  
  taglib_id3v2_set_default_text_encoding(encoding.l) As "_taglib_id3v2_set_default_text_encoding" 
  ; This sets the Default encoding For ID3v2 frames that are written To tags.
  
  taglib_set_string_management_enabled(management.b) As "_taglib_set_string_management_enabled"
  ; TagLib can keep track of strings that are created when outputting tag values And clear them using taglib_tag_clear_strings().
  ; This is enabled by Default.
  ; However If you wish To do more fine grained management of strings, you can do so by setting \a management To FALSE.
  
  taglib_set_strings_unicode(unicode.b) As "_taglib_set_strings_unicode"
  ; By Default all strings coming into Or out of TagLib's C API are in UTF8.
  ; However, it may be desirable For TagLib To operate on Latin1 (ISO-8859-1) strings in which Case this should be set To FALSE.
  
  taglib_tag_title(tag.l) As "_taglib_tag_title"
  ; Sets the tag's title.
  ; By Default this string should be UTF8 encoded.
  
  taglib_tag_artist(tag.l) As "_taglib_tag_artist"
  ; Sets the tag's artist.
  ; By Default this string should be UTF8 encoded.
  
  taglib_tag_album(tag.l) As "_taglib_tag_album"
  ; Sets the tag's album.
  ; By Default this string should be UTF8 encoded.
  
  taglib_tag_comment(tag.l) As "_taglib_tag_comment"
  ; Sets the tag's comment.
  ; By Default this string should be UTF8 encoded.
  
  taglib_tag_genre(tag.l) As "_taglib_tag_genre"
  ; Sets the tag's genre.
  ; By Default this string should be UTF8 encoded.
  
  taglib_tag_year(tag.l) As "_taglib_tag_year"
  ; Sets the tag's year. 0 indicates that this field should be cleared.
  
  taglib_tag_track(tag.l) As "_taglib_tag_track"
  ; Sets the tag's track number.  0 indicates that this field should be cleared.
  
  taglib_tag_set_title(tag.l,title.s) As "_taglib_tag_set_title"
  ; Returns a string With this tag's title.
  ; By Default this string should be UTF8 encoded And its memory should be freed using taglib_tag_free_strings().
  
  taglib_tag_set_artist(tag.l,artist.s) As "_taglib_tag_set_artist"
  ; Returns a string With this tag's artist.
  ; By Default this string should be UTF8 encoded And its memory should be freed using taglib_tag_free_strings().
  
  taglib_tag_set_album(tag.l,album.s) As "_taglib_tag_set_album"
  ; Returns a string With this tag's album name.
  ; By Default this string should be UTF8 encoded And its memory should be freed using taglib_tag_free_strings().
  
  taglib_tag_set_comment(tag.l,comment.s) As "_taglib_tag_set_comment"
  ; Returns a string With this tag's comment.
  ; By Default this string should be UTF8 encoded And its memory should be freed using taglib_tag_free_strings().
  
  taglib_tag_set_genre(tag.l,genre.s) As "_taglib_tag_set_genre"
  ; Returns a string With this tag's genre.
  ; By Default this string should be UTF8 encoded And its memory should be freed using taglib_tag_free_strings().
  
  taglib_tag_set_year(tag.l,year.l) As "_taglib_tag_set_year"
  ; Returns the tag's year or 0 if year is not set.
  
  taglib_tag_set_track(tag.l,track.l) As "_taglib_tag_set_track"
  ; Returns the tag's track number or 0 if track number is not set.
  
  taglib_tag_free_strings() As "_taglib_tag_free_strings"
  ; Frees all of the strings that have been created by the tag.
EndImport

Enumeration 
  #TagLib_File_MPEG
  #TagLib_File_OggVorbis
  #TagLib_File_FLAC
  #TagLib_File_MPC
  #TagLib_File_OggFlac
  #TagLib_File_WavPack
  #TagLib_File_Speex
  #TagLib_File_TrueAudio
  #TagLib_File_Type
EndEnumeration

Enumeration 
  #TagLib_ID3v2_Latin1
  #TagLib_ID3v2_UTF16
  #TagLib_ID3v2_UTF16BE
  #TagLib_ID3v2_UTF8
  #TagLib_ID3v2_Encoding
EndEnumeration
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; CursorPosition = 126
; FirstLine = 80
; Folding = -
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 4
; EnableBuildCount = 0
; EnableExeConstant