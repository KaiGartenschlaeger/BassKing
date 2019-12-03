EnableExplicit

Import "tags.lib"
  
  TAGS_GetLastErrorDesc()
  ; For Debug; the text description of the last TAGS_Read() call.
  ; It may say something like:
  ; ID3v2 tag: header is invalid", on poorly-added tags.
  
  TAGS_GetVersion()
  ; Returns tags.dll version.
  
  TAGS_Read( *hstream, fmt.s )
  ; Reads tag values from the stream And formats them according To given format string.

EndImport

; fmt:
;
;"%TITL"  - title;
;"%ARTI"  - artist;
;"%ALBM"  - album;
;"%GNRE"  - genre;
;"%YEAR"  - year;
;"%CMNT"  - comment;
;"%TRCK"  - track number;
;"%COMP"  - composer;
;"%COPY"  - copyright;
;"%SUBT"  - subtitle;
;"%AART"  - album artist;

;%IFV1(x,a)"        - if x is not empty, then %IFV1() evaluates to a, Or To an empty string otherwise;
;"%IFV2(x,a,b)"     - If x is Not empty, then %IFV2() evaluates To a, Else To b;
;"%IUPC(x)"         - brings x To uppercase, so "%IUPC(foO)" yields "FOO";
;"%ILWC(x)"         - brings x To lowercase, so "%ILWC(fOO)" yields "foo";
;"%ICAP(x)"         - capitalizes first letter in each word of x, so
;"%ICAP(FoO bAR)"   - yields "Foo Bar";
;"%ITRM(x)"         - removes beginning And trailing spaces from x;

;"%%" - "%"
;"%(" - "("
;"%," - ","
;"%)" - ")"
; IDE Options = PureBasic 4.31 (Windows - x86)
; CursorPosition = 5
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant