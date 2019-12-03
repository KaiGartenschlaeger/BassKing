; Enthällt alle Proceduren die nicht nur explizit für diesen Programm gelten
;
; Letzte Bearbeitung: 28.11.2009

Procedure.i CompareString(String$, CompareString$, CaseSensetive = 0, WholeWords = 0)
  Protected iResult.i

  If String$ And CompareString$

    If CaseSensetive = 0
      String$ = LCase(String$)
      CompareString$ = LCase(CompareString$)
    EndIf

    If WholeWords
      If String$ = CompareString$
        iResult = 1
      ElseIf FindString(String$, " " + CompareString$ + " ", 1)
        iResult = 1
      ElseIf Left(String$, Len(CompareString$) + 1) = CompareString$ + " "
        iResult = 1
      ElseIf Right(String$, Len(CompareString$) + 1) = " " + CompareString$
        iResult = 1
      EndIf
    Else
      If FindString(String$, CompareString$, 1)
        iResult = 1
      EndIf
    EndIf

  EndIf

  ProcedureReturn iResult.i
EndProcedure

Procedure.s GetFileNamePart(Path$)
  If GetExtensionPart(Path$) <> ""
    ProcedureReturn Left(GetFilePart(Path$), Len(GetFilePart(Path$)) - Len(GetExtensionPart(Path$)) - 1)
  Else
    ProcedureReturn GetFilePart(Path$)
  EndIf
EndProcedure

Procedure.s DesktopDirectory()
  Protected sPath.s = Space(#MAX_PATH)
  SHGetSpecialFolderPath_(#Null, @sPath, #CSIDL_DESKTOPDIRECTORY, 0)
  PathAddBackslash_(@sPath)
  ProcedureReturn sPath
EndProcedure

Procedure.s ExecutableDirectory()
  Protected sPath.s = Space(#MAX_PATH)
  GetModuleFileName_(0, @sPath, #MAX_PATH)
  sPath = GetPathPart(sPath)
  PathAddBackslash_(@sPath)
  ProcedureReturn sPath
EndProcedure

Procedure.s AppDataDirectory()
  Protected sPath.s = Space(#MAX_PATH)
  SHGetSpecialFolderPath_(#Null, @sPath, #CSIDL_APPDATA, 0)
  PathAddBackslash_(@sPath)
  ProcedureReturn sPath
EndProcedure

Procedure.s MyMusicDirectory()
  Protected sPath.s = Space(#MAX_PATH)
  SHGetSpecialFolderPath_(#Null, @sPath, #CSIDL_MYMUSIC, 0)
  PathAddBackslash_(@sPath)
  ProcedureReturn sPath
EndProcedure

Procedure.i MsgBox_Error(Text$, Title$ = "Fehler")
  MessageRequester(Title$, Text$, #MB_OK|#MB_ICONERROR)
EndProcedure

Procedure.i MsgBox_Exclamation(Text$, Title$ = "Hinweis")
  MessageRequester(Title$, Text$, #MB_OK|#MB_ICONEXCLAMATION)
EndProcedure

Procedure.s TimeString(Seconds.q)
  Protected qDays.q, qHours.q, qMinutes.q
  Protected sResult.s

  qMinutes = Seconds / 60
  Seconds  = Seconds - (qMinutes * 60)
  qHours   = qMinutes / 60
  qMinutes = qMinutes - (qHours * 60)
  qDays    = qHours / 24
  qHours   = qHours - (qDays * 24)

  If qDays > 0
    sResult + Str(qDays) + " Tage "
  EndIf
  sResult + RSet(Str(qHours), 2, "0") + ":" + RSet(Str(qMinutes), 2, "0") + ":" + RSet(Str(Seconds), 2, "0")

  ProcedureReturn sResult
EndProcedure

Procedure.i ColorBright(RGB, Bright)
  Protected iRed.i, iGreen.i, iBlue.i

  iRed   = Red(RGB)
  iGreen = Green(RGB)
  iBlue  = Blue(RGB)

  iRed + Bright
  iGreen + Bright
  iBlue + Bright

  If iRed < 0 : iRed = 0 : EndIf
  If iRed > 255 : iRed = 255: EndIf
  If iGreen < 0 : iGreen = 0 : EndIf
  If iGreen > 255 : iGreen = 255 : EndIf
  If iBlue < 0 : iBlue = 0 : EndIf
  If iBlue > 255 : iBlue = 255 : EndIf

  ProcedureReturn RGB(iRed, iGreen, iBlue)
EndProcedure

Procedure.i Clipboard_GetFileCount()
  If OpenClipboard_(0)
    Protected iClipboard.i
    Protected iAmount.i
    
    iClipboard = GetClipboardData_(#CF_HDROP)
    If iClipboard
      iAmount = DragQueryFile_(iClipboard, $FFFFFFFF, 0, 0)
    EndIf
    
    CloseClipboard_()
    
    ProcedureReturn iAmount
  EndIf
EndProcedure

Procedure.i ListIconGadget_SetColumnAlign(Gadget, Column, Align = #LVCFMT_LEFT)
  Protected L.lVCOLUMN, iResult.i = -1

  If IsGadget(Gadget) <> 0 And GadgetType(Gadget) = #PB_GadgetType_ListIcon
    If Align = #LVCFMT_LEFT Or Align = #LVCFMT_RIGHT Or Align = #LVCFMT_CENTER

      L\mask = #LVCF_FMT
      L\fmt  = Align

      InvalidateRect_(GadgetID(Gadget), #Null, #Null)

      iResult = SendMessage_(GadgetID(Gadget), #LVM_SETCOLUMN, Column, @L)
    EndIf
  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.i ListIconGadget_GetColumnAlign(Gadget, Column)
  Protected L.lVCOLUMN, iResult.i = -1

  If IsGadget(Gadget) <> 0 And GadgetType(Gadget) = #PB_GadgetType_ListIcon
    L\mask = #LVCF_FMT

    If SendMessage_(GadgetID(Gadget), #LVM_GETCOLUMN, Column, @L)
      If L\fmt & #LVCFMT_RIGHT
        iResult = #LVCFMT_RIGHT
      ElseIf L\fmt & #LVCFMT_CENTER
        iResult = #LVCFMT_CENTER
      Else
        iResult = #LVCFMT_LEFT
      EndIf
    EndIf

  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.i ListIconSort_SetColumnArrow(Gadget, Column, Sort)
  If IsGadget(Gadget) And GadgetType(Gadget) = #PB_GadgetType_ListIcon
    Protected HDI.HDITEM
    Protected iHeader.i
    Protected iResult.i
    Protected sTitle.s = Space(255)

    ; Header
    iHeader = SendMessage_(GadgetID(Gadget), #LVM_GETHEADER, 0, 0)

    ; Curr Format
    HDI\mask = #HDI_TEXT|#HDI_FORMAT
    HDI\cchTextMax = Len(sTitle)
    HDI\pszText = @sTitle
    SendMessage_(iHeader, #HDM_GETITEM, Column, @HDI)

    ; New Format
    HDI\mask = HDI\mask | #HDI_FORMAT|#HDI_TEXT

    HDI\fmt = HDI\fmt|#HDF_STRING
    If Sort > 0
      If Sort = 1
        HDI\fmt &~ $200
        HDI\fmt = HDI\fmt | $400
      Else
        HDI\fmt &~ $400
        HDI\fmt = HDI\fmt | $200
      EndIf
    Else
      HDI\fmt &~ $200
      HDI\fmt &~ $400
    EndIf

    HDI\pszText  = @sTitle

    SendMessage_(iHeader, #HDM_SETITEM, Column, @HDI)

    ProcedureReturn iResult
  EndIf
EndProcedure

Procedure.i ListIconSort_CompareString(lParam1, lParam2, lParamSort)
  Protected LVI.LV_ITEM
  Protected sString1.s = Space(255)
  Protected sString2.s = Space(255)
  Protected iResult.i

  LVI\iSubItem    = lParamSort
  LVI\cchTextMax  = 255

  LVI\pszText = @sString1
  SendMessage_(GadgetID(ListIconSort\LastGadget), #LVM_GETITEMTEXT, lParam1, @LVI)
  LVI\pszText = @sString2
  SendMessage_(GadgetID(ListIconSort\LastGadget), #LVM_GETITEMTEXT, lParam2, @LVI)

  If ListIconSort\LastAlign = #ListIconSort_Align_Ascending
    iResult = lstrcmpi_(sString1, sString2)
  Else
    iResult = lstrcmpi_(sString2, sString1)
  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.i ListIconSort_CompareValue(lParam1, lParam2, lParamSort)
  Protected LVI.LV_ITEM
  Protected sString1.s = Space(255)
  Protected iValue1.i
  Protected sString2.s = Space(255)
  Protected iValue2.i
  Protected iResult.i

  LVI\iSubItem    = lParamSort
  LVI\cchTextMax  = 255

  LVI\pszText = @sString1
  SendMessage_(GadgetID(ListIconSort\LastGadget), #LVM_GETITEMTEXT, lParam1, @LVI)
  LVI\pszText = @sString2
  SendMessage_(GadgetID(ListIconSort\LastGadget), #LVM_GETITEMTEXT, lParam2, @LVI)

  iValue1 = Val(sString1)
  iValue2 = Val(sString2)

  If iValue1 > iValue2
    If ListIconSort\LastAlign = #ListIconSort_Align_Ascending
      iResult = 1
    Else
      iResult = 0
    EndIf
  Else
    If ListIconSort\LastAlign = #ListIconSort_Align_Ascending
      iResult = 0
    Else
      iResult = 1
    EndIf
  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.i LISort_SortColumn(Gadget, Column, Type, Align)
  If IsGadget(Gadget) And GadgetType(Gadget) = #PB_GadgetType_ListIcon
    Static iGadget.i, iColumn.i

    ListIconSort\LastGadget = Gadget
    ListIconSort\LastColumn = Column
    ListIconSort\LastAlign  = Align

    If IsGadget(iGadget) And GadgetType(iGadget) = #PB_GadgetType_ListIcon
      ListIconSort_SetColumnArrow(iGadget, iColumn, 0)
    EndIf

    If Type = #ListIconSort_Type_Value
      SendMessage_(GadgetID(Gadget), #LVM_SORTITEMSEX, Column, @ListIconSort_CompareValue())
    Else
      SendMessage_(GadgetID(Gadget), #LVM_SORTITEMSEX, Column, @ListIconSort_CompareString())
    EndIf

    If Align = #ListIconSort_Align_Ascending
      ListIconSort_SetColumnArrow(Gadget, Column, #ListIconSort_Align_Ascending)
    Else
      ListIconSort_SetColumnArrow(Gadget, Column, #ListIconSort_Align_Descending)
    EndIf

    iGadget = Gadget
    iColumn = Column
  EndIf
EndProcedure

Procedure ComboBoxGadget_SetSel(Gadget, cpMin, cpMax)
  If IsGadget(Gadget) And GadgetType(Gadget) = #PB_GadgetType_ComboBox
    ProcedureReturn SendMessage_(GadgetID(Gadget), #CB_SETEDITSEL, 0, (cpMax & $ffff) << 16 | (cpMin & $ffff))
  EndIf
EndProcedure

Procedure.i Toolbar_Button(Toolbar, ButtonID, Pos, ImageIndex, Style = #TBSTYLE_BUTTON)
  If IsToolBar(Toolbar)
    Toolbar = ToolBarID(Toolbar)

    Protected TB.TBBUTTON

    TB\iBitmap    = ImageIndex
    TB\idCommand  = ButtonID
    TB\fsState    = #TBSTATE_ENABLED
    TB\fsStyle    = Style

    If Pos = -1
      Pos = SendMessage_(Toolbar, #TB_BUTTONCOUNT, 0, 0)
    EndIf

    ProcedureReturn SendMessage_(Toolbar, #TB_INSERTBUTTON, Pos, @TB)
  EndIf
EndProcedure

Procedure.i Toolbar_Seperator(Toolbar, Pos)
  If IsToolBar(Toolbar)
    Toolbar = ToolBarID(Toolbar)

    Protected TB.TBBUTTON

    TB\fsState    = #TBSTATE_ENABLED
    TB\fsStyle    = #TBSTYLE_SEP

    If Pos = -1
      Pos = SendMessage_(Toolbar, #TB_BUTTONCOUNT, 0, 0)
    EndIf

    ProcedureReturn SendMessage_(Toolbar, #TB_INSERTBUTTON, Pos, @TB)
  EndIf
EndProcedure

Procedure.i Toolbar_ChangeIcon(Toolbar, Pos, ImageIndex)
  If IsToolBar(Toolbar)
    Toolbar = ToolBarID(Toolbar)

    Protected TB.TBBUTTONINFO

    TB\cbSize = SizeOf(TBBUTTONINFO)
    TB\dwMask = #TBIF_IMAGE
    TB\iImage = ImageIndex

    If SendMessage_(Toolbar, #TB_BUTTONCOUNT, 0, 0) < Pos
      ProcedureReturn -1
    EndIf

    ProcedureReturn SendMessage_(Toolbar, #TB_SETBUTTONINFO, Pos, @TB)
  EndIf
EndProcedure

Procedure.i Toolbar_GetWidth(Toolbar)
  If IsToolBar(Toolbar) <> 0
    Protected _S.SIZE
    SendMessage_(ToolBarID(Toolbar), #TB_GETMAXSIZE, #Null, @_S)
    ProcedureReturn _S\cx
  EndIf
EndProcedure

Procedure.i Toolbar_GetHeight(Toolbar)
  If IsToolBar(Toolbar) <> 0
    Protected _S.SIZE
    SendMessage_(ToolBarID(Toolbar), #TB_GETMAXSIZE, #Null, @_S)
    ProcedureReturn _S\cy
  EndIf
EndProcedure

Procedure.s TextGadget_CompactPath(Gadget, Path$)
  If IsGadget(Gadget) And GadgetType(Gadget) = #PB_GadgetType_Text
    Static hDC.i, hFont.i, sResult.s

    hFont = SendMessage_(GadgetID(Gadget), #WM_GETFONT, 0, 0)
    hDC   = CreateCompatibleDC_(0)

    SelectObject_(hDC, hFont)

    If hFont And hDC
      PathCompactPath_(hDC, Path$, GadgetWidth(Gadget))

      sResult = Path$
    Else
      sResult = Path$
    EndIf

    DeleteDC_(hDC)
  EndIf

  ProcedureReturn sResult
EndProcedure

Procedure.s PeekStringDoubleNull(*String, Format = #PB_Ascii)
  If *String
    Protected sResult.s, sCurr.s, *Curr = *String

    Repeat
      sCurr = PeekS(*Curr, -1, Format)

      If sResult <> "" And sCurr <> ""
        sResult + "|"
      EndIf
      If sCurr <> ""
        sResult + sCurr
      EndIf

      *Curr + StringByteLength(sCurr, Format) + 1
    Until sCurr = ""
  EndIf
  ProcedureReturn sResult
EndProcedure

Procedure.i ChangeCursor(Gadget, Cursor)
  Protected CP.POINT, GR.RECT
  GetCursorPos_(@CP)
  GetWindowRect_(GadgetID(Gadget), GR)
  If PtInRect_(@GR, CP\X | (CP\Y << 32))
    ProcedureReturn SetCursor_(iCursor_Hand)
  EndIf
EndProcedure

Procedure.s EditorGadget_GetSelText(Gadget)
  If IsGadget(Gadget) And GadgetType(Gadget) = #PB_GadgetType_Editor
    Protected Sel.CHARRANGE, sText.s

    SendMessage_(GadgetID(Gadget), #EM_EXGETSEL, #Null, @Sel)

    sText = Space(Sel\cpMax - Sel\cpMin)

    SendMessage_(GadgetID(Gadget), #EM_GETSELTEXT, #Null, @sText)

    ProcedureReturn sText
  EndIf
EndProcedure

Procedure.i ListIconGadget_SelAll(Gadget)
  If IsGadget(Gadget) And GadgetType(Gadget) = #PB_GadgetType_ListIcon
    Protected L.LVITEM

    L\state     = #LVIS_SELECTED
    L\stateMask = #LVIS_SELECTED

    ProcedureReturn SendMessage_(GadgetID(Gadget), #LVM_SETITEMSTATE, -1, @L)
  EndIf
EndProcedure

Procedure.s GetLastPathPart(Path$)
  If Path$ <> ""
    Path$ = GetPathPart(Path$)
    PathStripPath_(@Path$)
    Path$ = RemoveString(Path$, "\")
    ProcedureReturn Path$
  EndIf
EndProcedure

Procedure.s FormatByteSize(ByteSize.q, RndCnt = 2, Ext = 1)
  Protected sResult.s

  If ByteSize > 0
    ; EB
    If ByteSize >= 1152921504606846976
      sResult = StrF(ByteSize / 1152921504606846976, RndCnt)
      If Ext : sResult + " EB" : EndIf
      ; PB
    ElseIf ByteSize >= 1125899906842624
      sResult = StrF(ByteSize / 1125899906842624, RndCnt)
      If Ext : sResult + " PB" : EndIf
      ; TB
    ElseIf ByteSize >= 1099511627776
      sResult = StrF(ByteSize / 1099511627776, RndCnt)
      If Ext : sResult + " TB" : EndIf
      ; GB
    ElseIf ByteSize >= 1073741824
      sResult = StrF(ByteSize / 1073741824, RndCnt)
      If Ext : sResult + " GB" : EndIf
      ; MB
    ElseIf ByteSize >= 1048576
      sResult = StrF(ByteSize / 1048576, RndCnt)
      If Ext : sResult + " MB" : EndIf
      ; KB
    ElseIf ByteSize >= 1024
      sResult = StrF(ByteSize / 1044, RndCnt)
      If Ext : sResult + " KB" : EndIf
      ; Byte
    Else
      sResult = Str(ByteSize)
      If Ext : sResult + " B" : EndIf
    EndIf

    ; Zero
  Else
    sResult = "0"
  EndIf

  ProcedureReturn sResult
EndProcedure

Procedure.i ScreenSaver_Active()
  Protected iBool.i
  SystemParametersInfo_(#SPI_GETSCREENSAVERRUNNING, 0, @iBool, 0)
  ProcedureReturn iBool
EndProcedure

Procedure.i ShutdownWindows(flags = #EWX_SHUTDOWN)
  Protected Privileges.TOKEN_PRIVILEGES
  Protected hToken.i

  OpenProcessToken_(GetCurrentProcess_(), 40, @hToken)

  Privileges\PrivilegeCount           = 1
  Privileges\Privileges[0]\Attributes = #SE_PRIVILEGE_ENABLED

  LookupPrivilegeValue_(0, "SeShutdownPrivilege", @Privileges\Privileges[0]\Luid)
  AdjustTokenPrivileges_(hToken, 0, @Privileges, 0, 0, 0)
  CloseHandle_(hToken)

  ProcedureReturn ExitWindowsEx_(flags, 0)
EndProcedure

Procedure.i REG_OpenKey(hKey, SubKey$, Access)
  Protected iKey.i

  If RegOpenKeyEx_(hKey, SubKey$, 0, Access, @iKey) = #ERROR_SUCCESS
    ProcedureReturn iKey
  EndIf
EndProcedure

Procedure.i REG_CreateKey(hKey, SubKey$, NewSubKey$)
  Protected iResult.i
  Protected iKeyOpen.i
  Protected iKeyNew.i
  Protected iDisposition.i
  Protected Security.SECURITY_ATTRIBUTES

  Security\nLength = SizeOf(SECURITY_ATTRIBUTES)

  If RegOpenKeyEx_(hKey, SubKey$, 0, #KEY_CREATE_SUB_KEY, @iKeyOpen) = #ERROR_SUCCESS
    If RegCreateKeyEx_(iKeyOpen, NewSubKey$, 0, 0, #REG_OPTION_NON_VOLATILE, #KEY_ALL_ACCESS, @Security, @iKeyNew, @iDisposition) = #ERROR_SUCCESS
      iResult = 1
    EndIf
  EndIf

  RegCloseKey_(iKeyOpen)
  RegCloseKey_(iKeyNew)

  ProcedureReturn iResult
EndProcedure

Procedure.i REG_SetValue(hKey, SubKey$, Value$)
  Protected iResult.i
  Protected iKeyOpen.i

  If RegOpenKeyEx_(hKey, SubKey$, 0, #KEY_SET_VALUE, @iKeyOpen) = #ERROR_SUCCESS
    If RegSetValue_(hKey, SubKey$, #REG_SZ, Value$, Len(Value$)) = #ERROR_SUCCESS
      iResult = 1
    EndIf
  EndIf

  RegCloseKey_(iKeyOpen)

  ProcedureReturn iResult
EndProcedure

Procedure.i RegisterFile(Extension$, Application$, Command$)
  If Extension$ <> "" And Application$ <> "" And Command$ <> ""
    Protected iResult.i

    If Left(Extension$, 1) <> "."
      Extension$ = "." + Extension$
    EndIf

    If REG_CreateKey(#HKEY_CURRENT_USER, "Software\Classes\", Extension$)
      If REG_SetValue(#HKEY_CURRENT_USER, "Software\Classes\" + Extension$, Application$)
        If REG_CreateKey(#HKEY_CURRENT_USER, "Software\Classes\", Application$)
          If REG_SetValue(#HKEY_CURRENT_USER, "Software\Classes\" + Application$, Extension$)
            If REG_CreateKey(#HKEY_CURRENT_USER, "Software\Classes\" + Application$, "Shell\Open\Command")
              If REG_SetValue(#HKEY_CURRENT_USER, "Software\Classes\" + Application$ + "\Shell\Open\Command", Command$)
                iResult = 1
              EndIf
            EndIf
          EndIf
        EndIf
      EndIf
    EndIf
  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.i ColorRequesterEx(Window, DefaultColor, *ClrArray)
  Protected iResult.i, cC.CHOOSECOLOR

  ZeroMemory_(@cC, SizeOf(cC))

  cC\hwndOwner     = Window
  cC\lStructSize   = SizeOf(cC)
  cC\lpCustColors  = *ClrArray
  cC\rgbResult     = DefaultColor
  cC\Flags         = #CC_RGBINIT|#CC_FULLOPEN

  Colors(0) = DefaultColor

  If ChooseColor_(@cC) = 1
    iResult = cC\rgbResult
  Else
    iResult = -1
  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.i ChangeMSNStatus(Enable, Category$, Message$)
  ; Ändert den Windows Live Messanger Statustext
  ; Enable      0, 1
  ; Category$   Music, Games, Office
  ; Message$    Nachricht
  Protected C.COPYDATASTRUCT
  Protected Buffer.s, iHandle.i
  Protected *Buffer

  iHandle = FindWindowEx_(0, iHandle, "MsnMsgrUIManager", 0)
  If iHandle
    Buffer = "\0" + Category$ + "\0" + Str(Enable) + "\0{0}\0" + Message$ + "\0\0\0\0"
    *Buffer = AllocateMemory(StringByteLength(Buffer, #PB_Unicode) + 2)

    If *Buffer
      PokeS(*Buffer, Buffer, Len(Buffer), #PB_Unicode)

      C\dwData = 1351
      C\lpData = *Buffer
      C\cbData = MemorySize(*Buffer)

      SendMessage_(iHandle, #WM_COPYDATA, 0, @C)

      FreeMemory(*Buffer)
    EndIf
  EndIf
EndProcedure

Procedure.i BassKing_SendMessage(Msg.i, iParam1.i = 0, iParam2.i = 0, sParam1.s = "", sParam2.s = "")
  Protected iWindow.i, iResult.i
  Protected CDS.COPYDATASTRUCT
  Protected BKM._BKM

  iWindow = FindWindow_("WindowClass_1", "BassKing")
  If IsWindow_(iWindow)
    BKM\Msg     = Msg
    BKM\iParam1 = iParam1
    BKM\iParam2 = iParam2
    BKM\sParam1 = sParam1
    BKM\sParam2 = sParam2

    CDS\dwData = #BK_PluginEvent
    CDS\cbData = SizeOf(_BKM)
    CDS\lpData = @BKM

    iResult = SendMessage_(iWindow, #WM_COPYDATA, 0, @CDS)
  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.s GetProgramParameter()
  Protected sResult.s
  Protected iCount.i
  Protected iNext.i
  
  iCount = CountProgramParameters()
  If iCount > 0
    If iCount > 1
      For iNext = 0 To iCount - 1
        sResult + ProgramParameter(iNext)
        If iNext < iCount - 1
          sResult + " "
        EndIf
      Next
    Else
      sResult = ProgramParameter(0)
    EndIf
  EndIf
  
  ProcedureReturn sResult
EndProcedure

Procedure.i DayDif(FirstDate, SecondDate)
  Protected iResult.i, iDifference.i

  If FirstDate > 0 And SecondDate > 0 And SecondDate > FirstDate
    iDifference = SecondDate - FirstDate
    iResult = iDifference / (24 * 60 * 60)
  EndIf

  ProcedureReturn iResult.i
EndProcedure
; IDE Options = PureBasic 4.60 (Windows - x86)
; CursorPosition = 42
; FirstLine = 28
; Folding = -------
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 0
; EnableBuildCount = 0
; EnableExeConstant