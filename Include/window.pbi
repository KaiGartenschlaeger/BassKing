EnableExplicit

Procedure.i Window_GetWidth(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _RECT.RECT
    
    GetWindowRect_(Window, @_RECT)
    
    ProcedureReturn _RECT\right - _RECT\left
  EndIf
EndProcedure

Procedure.i Window_GetHeight(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _RECT.RECT
    
    GetWindowRect_(Window, @_RECT)
    
    ProcedureReturn _RECT\bottom - _RECT\top
  EndIf
EndProcedure

Procedure.i Window_GetClientWidth(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _RECT.RECT
    
    GetClientRect_(Window, @_RECT)
    
    ProcedureReturn _RECT\right - _RECT\left
  EndIf
EndProcedure

Procedure.i Window_GetClientHeight(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _RECT.RECT
    
    GetClientRect_(Window, @_RECT)
    
    ProcedureReturn _RECT\bottom - _RECT\top
  EndIf
EndProcedure

Procedure.i Window_GetPosX(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected R.RECT
    
    GetWindowRect_(Window, @R)
    
    ProcedureReturn R\left
  EndIf
EndProcedure

Procedure.i Window_GetPosY(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected R.RECT
    
    GetWindowRect_(Window, @R)
    
    ProcedureReturn R\top
  EndIf
EndProcedure

Procedure.i Window_GetClientPosX(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _WRECT.RECT, _CRECT.RECT
    
    GetWindowRect_(Window, @_WRECT)
    
    GetClientRect_(Window, @_CRECT)
    
    ProcedureReturn _WRECT\Left + (_WRECT\right - _WRECT\left - _CRECT\right) / 2
  EndIf
EndProcedure

Procedure.i Window_GetClientPosY(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _WRECT.RECT, _CRECT.RECT
    
    GetWindowRect_(Window, @_WRECT)
    GetClientRect_(Window, @_CRECT)
    
    ProcedureReturn _WRECT\top + _WRECT\bottom - _WRECT\top - _CRECT\bottom - (_WRECT\right - _WRECT\left - _CRECT\right) / 2
  EndIf
EndProcedure

Procedure.i Window_GetTitlebarHeight(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _WRECT.RECT, _CRECT.RECT
    
    GetWindowRect_(Window, @_WRECT)
    GetClientRect_(Window, @_CRECT)
    
    ProcedureReturn _WRECT\bottom - _WRECT\top - _CRECT\bottom - (_WRECT\right - _WRECT\left - _CRECT\right) / 2
  EndIf
EndProcedure

Procedure.i Window_GetBorderSize(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _WRECT.RECT, _CRECT.RECT
    
    GetWindowRect_(Window, @_WRECT)
    GetClientRect_(Window, @_CRECT)
    
    ProcedureReturn (_WRECT\right - _WRECT\left - _CRECT\right) / 2
  EndIf
EndProcedure

Procedure.s Window_GetTitle(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected Title$ = Space(GetWindowTextLength_(Window))
    
    GetWindowText_(Window, @Title$, GetWindowTextLength_(Window) + 1)
    
    ProcedureReturn Title$
  EndIf
EndProcedure

Procedure.i Window_IsVisible(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    ProcedureReturn IsWindowVisible_(Window)
  EndIf
EndProcedure

Procedure.i Window_IsEnabled(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    ProcedureReturn IsWindowEnabled_(Window)
  EndIf
EndProcedure

Procedure.i Window_Snap(Window, Corner, Gap)
  If (IsWindow(Window) Or IsWindow_(Window)) And Corner >= 1 And Corner <= 4 And Gap >= 0 And Gap <= 1000
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _DRECT.RECT, DesktopW.l, DesktopH.l, _WRECT.RECT, WindowW.l, WindowH.l
    
    SystemParametersInfo_(#SPI_GETWORKAREA, 0, @_DRECT, 0)
    
    DesktopW = _DRECT\right
    DesktopH = _DRECT\bottom
    
    GetWindowRect_(Window, @_WRECT)
    
    WindowW = _WRECT\right - _WRECT\left
    WindowH = _WRECT\bottom - _WRECT\top
    
    Select Corner
      Case 1:ProcedureReturn MoveWindow_(Window, Gap, Gap, WindowW, WindowH, 1)
      Case 2:ProcedureReturn MoveWindow_(Window, DesktopW - WindowW - Gap, Gap, WindowW, WindowH, 1)
      Case 3:ProcedureReturn MoveWindow_(Window, DesktopW - WindowW - Gap, DesktopH - WindowH - Gap, WindowW, WindowH, 1)
      Case 4:ProcedureReturn MoveWindow_(Window, Gap, DesktopH - WindowH - Gap, WindowW, WindowH, 1)
    EndSelect
  EndIf
EndProcedure

Procedure.i Window_CenterOnWindow(Children, Main)
  If (IsWindow(Children) Or IsWindow_(Children)) And (IsWindow(Main) Or IsWindow_(Main))
    If IsWindow(Children)
      Children = WindowID(Children)
    EndIf
    If IsWindow(Main)
      Main = WindowID(Main)
    EndIf
    
    Protected _W1RECT.RECT, _W2RECT.RECT
    
    GetWindowRect_(Children, @_W1RECT)
    GetWindowRect_(Main, @_W2RECT)
    
    ProcedureReturn SetWindowPos_(Children, 0, _W2RECT\left + ((_W2RECT\right - _W2RECT\left) - (_W1RECT\right - _W1RECT\left))/2, _W2RECT\top + ((_W2RECT\bottom - _W2RECT\top) - (_W1RECT\bottom - _W1RECT\top))/2, 0, 0, #SWP_NOZORDER|#SWP_NOSIZE|#SWP_NOACTIVATE)
  EndIf
EndProcedure

Procedure.i Window_CenterOnDesktop(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _WRECT.RECT
    
    GetWindowRect_(Window, @_WRECT)
    
    ProcedureReturn SetWindowPos_(Window, 0, GetSystemMetrics_(#SM_CXSCREEN)/2 - (_WRECT\right - _WRECT\left)/2, GetSystemMetrics_(#SM_CYSCREEN)/2 - (_WRECT\bottom - _WRECT\top)/2, 0, 0, #SWP_NOZORDER|#SWP_NOSIZE|#SWP_NOACTIVATE)
  EndIf
EndProcedure

Procedure.i Window_GetDesktopCenterPos(Window, Direction)
  If (IsWindow(Window) Or IsWindow_(Window)) And Direction > 0 And Direction < 3
    If IsWindow(Window) <> 0
      Window = WindowID(Window)
    EndIf
    
    Protected _WRECT.RECT
    
    GetWindowRect_(Window, @_WRECT)
    
    If Direction = 1
      ProcedureReturn (GetSystemMetrics_(#SM_CXSCREEN) - (_WRECT\right - _WRECT\left)) / 2
    Else
      ProcedureReturn (GetSystemMetrics_(#SM_CYSCREEN) - (_WRECT\bottom - _WRECT\top)) / 2
    EndIf
  EndIf
EndProcedure

Procedure.i Window_AlwaysOnTop(Window, Bool)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    If Bool
      ProcedureReturn SetWindowPos_(Window, #HWND_TOPMOST, 0, 0, 0, 0, #SWP_NOACTIVATE|#SWP_NOSIZE|#SWP_NOMOVE)
    Else
      ProcedureReturn SetWindowPos_(Window, #HWND_NOTOPMOST, 0, 0, 0, 0, #SWP_NOACTIVATE|#SWP_NOSIZE|#SWP_NOMOVE)
    EndIf
  EndIf
EndProcedure

Procedure.i Window_Refresh(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    InvalidateRect_(Window, 0, 1)
    
    ProcedureReturn UpdateWindow_(Window)
  EndIf
EndProcedure

Procedure.i Window_DisableCloseButton(Window, Bool)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected hSysMnu.l = GetSystemMenu_(Window, 0)
    
    If Bool
      Bool = 1
    EndIf
    
    If hSysMnu
      EnableMenuItem_(hSysMnu, #SC_CLOSE, #MF_BYCOMMAND|Bool)
      DrawMenuBar_(Window)
    EndIf
  EndIf
EndProcedure

Procedure.i Window_DisableTheme(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected iLib.i, wNull.w
    
    iLib = OpenLibrary(#PB_Any, "uxtheme.dll")
    If iLib
      CallFunction(iLib, "SetWindowTheme", Window, @wNull, @wNull)
      CloseLibrary(iLib)
    EndIf
  EndIf
EndProcedure

Procedure.i Window_SetBackroundImage(Window, Image)
  If IsImage(Image) And IsWindow(Window)
    Protected _LB.LOGBRUSH, hBrush.l
    
    _LB\lbStyle = #BS_PATTERN
    _LB\lbColor = #DIB_RGB_COLORS
    _LB\lbHatch = ImageID(Image)
    
    hBrush = CreateBrushIndirect_(@_LB)
    If hBrush <> 0
      SetClassLong_(WindowID(Window), #GCL_HBRBACKGROUND, hBrush)
      InvalidateRect_(WindowID(Window), 0, 1)
      ProcedureReturn hBrush
    EndIf
  EndIf
EndProcedure

Procedure.i Window_SetLayeredStyle(Window, Bool)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    If Bool
      ProcedureReturn SetWindowLong_(Window, #GWL_EXSTYLE, GetWindowLong_(Window, #GWL_EXSTYLE) | #WS_EX_LAYERED)
    Else
      ProcedureReturn SetWindowLong_(Window, #GWL_EXSTYLE, GetWindowLong_(Window, #GWL_EXSTYLE) & ~#WS_EX_LAYERED)
    EndIf
  EndIf
EndProcedure

Procedure.i Window_SetOpacity(Window, Opacity)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    ProcedureReturn SetLayeredWindowAttributes_(Window, #Null, Opacity, #LWA_ALPHA)
  EndIf
EndProcedure

Procedure.i Window_SetTransparentColor(Window, Color)
  If IsWindow(Window)
    ProcedureReturn SetLayeredWindowAttributes_(WindowID(Window), Color, #Null, #LWA_COLORKEY)
  EndIf
EndProcedure

Procedure.i Window_SetLayeredAttribute(Window, Color, Opacity)
  If IsWindow(Window)
    ProcedureReturn SetLayeredWindowAttributes_(WindowID(Window), Color, Opacity, #LWA_COLORKEY|#LWA_ALPHA)
  EndIf
EndProcedure

Procedure.i Window_SetIcon(Window, Icon)
  If (IsWindow(Window) Or IsWindow_(Window)) And Icon
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    SendMessage_(Window, #WM_SETICON, 1, Icon)
  EndIf
EndProcedure

Procedure.i Window_IsMouseOverGadget(Gadget)
  Protected _RECT.RECT, _POINT.POINT
  
  GetWindowRect_(GadgetID(Gadget), @_RECT)
  GetCursorPos_(@_POINT)

  If _POINT\x >= _RECT\Left And _POINT\x <= _RECT\right And _POINT\y >= _RECT\Top And _POINT\y <= _RECT\bottom
    ProcedureReturn 1
  EndIf
EndProcedure

Procedure.i Window_CheckPos(Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected _WRECT.RECT, _DRECT.RECT
    
    GetWindowRect_(Window, @_WRECT)
    SystemParametersInfo_(#SPI_GETWORKAREA, 0, @_DRECT, 0)
    
    If _WRECT\Left < _DRECT\left
      _WRECT\Left = _DRECT\left
    EndIf
    If _WRECT\Top < _DRECT\top
      _WRECT\Top = _DRECT\top
    EndIf
    If _WRECT\Right > _DRECT\right
      _WRECT\Left = _DRECT\right - (_WRECT\right - _WRECT\left)
    EndIf
    If _WRECT\bottom > _DRECT\bottom
      _WRECT\top = _DRECT\bottom - (_WRECT\bottom - _WRECT\top)
    EndIf
    
    SetWindowPos_(Window, 0, _WRECT\Left, _WRECT\Top, 0, 0, #SWP_NOSIZE|#SWP_NOZORDER)
    InvalidateRect_(Window, 0, 1)
    
    ProcedureReturn 1
  EndIf
EndProcedure

Procedure.i Window_TextWidth(Text$, Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window) : Window = WindowID(Window) : EndIf
    
    Protected hDC.i, iFNT.i, S.SIZE, iOld.i
    
    hDC  = GetDC_(Window)
    iFNT = SendMessage_(Window, #WM_GETFONT, 0, 0)
    iOld = SelectObject_(hDC, iFNT)
    GetTextExtentPoint32_(hDC, @Text$, Len(Text$), @S)
    iFNT = SelectObject_(hDC, iOld)
    ReleaseDC_(Window, hDC)
    
    ProcedureReturn S\cx
  EndIf
EndProcedure

Procedure.i Window_TextHeight(Text$, Window)
  If IsWindow(Window) Or IsWindow_(Window)
    If IsWindow(Window) : Window = WindowID(Window) : EndIf
    
    Protected hDC.i, iFNT.i, S.SIZE, iOld.i
    
    hDC  = GetDC_(Window)
    iFNT = SendMessage_(Window, #WM_GETFONT, 0, 0)
    iOld = SelectObject_(hDC, iFNT)
    GetTextExtentPoint32_(hDC, @Text$, Len(Text$), @S)
    iFNT = SelectObject_(hDC, iOld)
    ReleaseDC_(Window, hDC)
    
    ProcedureReturn S\cy
  EndIf
EndProcedure

Procedure.s Window_GetFontNameFromGadget(Gadget)
  Protected *otm.OUTLINETEXTMETRIC
  Protected bsize.l,Font.l,hWnd.l
  Protected FontName.s
  Protected hDC.i
 
  hWnd  =  GadgetID(Gadget)
 
  Font  = GetGadgetFont(Gadget)
  hdc   = GetDC_(hWnd)
  Font  = SelectObject_(hdc,Font)
  bsize = GetOutlineTextMetrics_(hdc,0,0)
 
  If bsize = 0
    SelectObject_(hdc,Font)
    ReleaseDC_(hWnd,hdc)
    ProcedureReturn
  EndIf
 
  *otm = AllocateMemory(bsize)
 
  *otm\otmSize = bsize
 
  GetOutlineTextMetrics_(hdc,bsize,*otm)
  FontName = PeekS(*otm+*otm\otmpFamilyName)
 
  FreeMemory(*otm)
  SelectObject_(hdc,Font)
  ReleaseDC_(hWnd,hdc)

  ProcedureReturn FontName
EndProcedure

Procedure.s Window_GetFontStyleFromGadget(gadget)
  Protected *otm.OUTLINETEXTMETRIC
  Protected bsize.l,Font.l,hWnd.l, hDC.i
  Protected FontStyle.s
 
  hWnd  =  GadgetID(gadget)
 
  Font  = GetGadgetFont(gadget)
  hdc   = GetDC_(hWnd)
  Font  = SelectObject_(hdc,Font)
  bsize = GetOutlineTextMetrics_(hdc,0,0)
 
  If bsize = 0
    SelectObject_(hdc,Font)
    ReleaseDC_(hWnd,hdc)
    ProcedureReturn
  EndIf
 
  *otm = AllocateMemory(bsize)
 
  *otm\otmSize = bsize
 
  GetOutlineTextMetrics_(hdc,bsize,*otm)

  FontStyle = PeekS(*otm+*otm\otmpStyleName)
 
  FreeMemory(*otm)
  SelectObject_(hdc,Font)
  ReleaseDC_(hWnd,hdc)

  ProcedureReturn FontStyle
EndProcedure

Procedure.i Window_GetFontSizeFromGadget(gadget)
  Protected *otm.OUTLINETEXTMETRIC
  Protected bsize.l,Font.l,hWnd.l
  Protected FontSize.l , val.f, hDC.i
 
  hWnd  =  GadgetID(gadget)
 
  Font  = GetGadgetFont(gadget)
  hdc   = GetDC_(hWnd)
  Font  = SelectObject_(hdc,Font)
  bsize = GetOutlineTextMetrics_(hdc,0,0)
 
  If bsize = 0
    SelectObject_(hdc,Font)
    ReleaseDC_(hWnd,hdc)
    ProcedureReturn
  EndIf
 
  *otm = AllocateMemory(bsize)
 
  *otm\otmSize = bsize
 
  GetOutlineTextMetrics_(hdc,bsize,*otm)

  val.f = (*otm\otmTextMetrics\tmHeight-*otm\otmTextMetrics\tmInternalLeading)
  FontSize = Int(Round((val * 72 / GetDeviceCaps_(hdc,#LOGPIXELSY)),1))
 
  FreeMemory(*otm)
  SelectObject_(hdc,Font)
  ReleaseDC_(hWnd,hdc)

  ProcedureReturn FontSize
EndProcedure

Procedure.s Window_GetPath(Window)
  If IsWindow_(Window) Or IsWindow(Window)
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected sResult.s, iPID.i, iHandle.i, sError.i
    Protected Entry.MODULEENTRY32
    
    Entry\dwSize = SizeOf(MODULEENTRY32)
    
    GetWindowThreadProcessId_(Window, @iPID)
    
    iHandle = CreateToolhelp32Snapshot_(#TH32CS_SNAPMODULE, iPID)
  
    If iHandle
      sError = Module32First_(iHandle, Entry)
      If sError
         sResult = PeekS(@Entry\szExePath)
      EndIf
      CloseHandle_(iHandle)
    EndIf
    
    ProcedureReturn sResult
  EndIf
EndProcedure

Procedure Window_Screenshot(Window, ImagePath$)
  If IsWindow(Window) Or IsWindow_(Window) And ImagePath$
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    Protected iDesktopDC.i, iDC.i
    Protected iImage.i
    Protected R.RECT
    
    GetWindowRect_(Window, @R)
    
    If R\left < 0
      R\right + R\left
      R\left = 0
    EndIf
    If R\top < 0
      R\bottom + R\top
      R\top = 0
    EndIf
    
    iImage = CreateImage(#PB_Any, R\right - R\left, R\bottom - R\top)
    If iImage
      
      iDC = StartDrawing(ImageOutput(iImage))
      If iDC
        iDesktopDC = GetDC_(GetDesktopWindow_())
        BitBlt_(iDC, 0, 0, R\right - R\left, R\bottom - R\top, iDesktopDC, R\left, R\top, #SRCCOPY)
        StopDrawing()
        ReleaseDC_(GetDesktopWindow_(), iDesktopDC)
      EndIf
      
      SaveImage(iImage, ImagePath$)
    EndIf
  EndIf
EndProcedure

Procedure.i Window_SubClass(hWnd, *Proc)
  If IsWindow_(hWnd)
    ProcedureReturn SetProp_(hWnd, "winproc", SetWindowLong_(hWnd, #GWL_WNDPROC, *Proc))
  EndIf
EndProcedure

Procedure.i Window_UnSubClass(hWnd)
  If IsWindow_(hWnd)
    SetWindowLong_(hWnd, #GWL_WNDPROC, GetProp_(hWnd, "winproc"))
    RemoveProp_(hWnd, "winproc")
  EndIf
EndProcedure
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; Folding = -------
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 7
; EnableBuildCount = 0
; EnableExeConstant