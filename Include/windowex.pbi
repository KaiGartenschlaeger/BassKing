EnableExplicit

Enumeration
  #WndEx_Magnetic_Desktop  = $1
  #WndEx_Magnetic_Window   = $2
  #WndEx_Magnetic_WindowC  = $4
  #WndEx_Moveable          = $8
  #WndEx_All               = $1|$2|$8
EndEnumeration

Structure _WndEx
  win.i
  w.RECT
  c.RECT
  flags.i
EndStructure
Global NewList WndEx._WndEx()

Global iMagneticValue.i  = 25

Procedure.i WndEx_SetMagneticValue(Value)
  iMagneticValue = Value
EndProcedure

Procedure.i WndEx_AddWindow(Window, Flags = #WndEx_All)
  Protected iResult.i
  
  If IsWindow(Window) Or IsWindow_(Window)
    Protected iExist.i
    
    If IsWindow(Window) <> 0
      Window = WindowID(Window)
    EndIf
    
    ForEach WndEx()
      If WndEx()\win = Window
        iExist = 1 : Break
      EndIf
    Next
    
    If iExist = 0
      AddElement(WndEx())
      
      WndEx()\win = Window
      
      If Flags & #WndEx_Magnetic_Window And Flags & #WndEx_Magnetic_WindowC
        Flags &~ #WndEx_Magnetic_WindowC
      EndIf
      
      WndEx()\flags = Flags
      
      GetWindowRect_(Window, @WndEx()\w)
      GetClientRect_(Window, @WndEx()\c)
      
      iResult = 1
    Else
      iResult = -1
    EndIf
    
  Else
    iResult = 0
  EndIf
  
  ProcedureReturn iResult.i
EndProcedure

Procedure.i WndEx_RemoveWindow(Window)
  Protected iResult.i

  If IsWindow(Window) Or IsWindow_(Window)
    
    If IsWindow(Window)
      Window = WindowID(Window)
    EndIf
    
    ForEach WndEx()
      If WndEx()\win = Window
        DeleteElement(WndEx())
        iResult = 1
        Break
      EndIf
    Next
    
    iResult = 0
  Else
    iResult = -1
  EndIf

  ProcedureReturn iResult
EndProcedure

Procedure.l WndEx_Callback(hWnd, Msg, wParam, lParam)
  
  ForEach WndEx()
    If hWnd = WndEx()\win
      
      Protected iflags.i = WndEx()\flags
      
      ;Moveable
      If Msg = #WM_LBUTTONDOWN
        If iflags & #WndEx_Moveable
          ReleaseCapture_()
          SendMessage_(hWnd, #WM_NCLBUTTONDOWN, #HTCAPTION, #Null)
        EndIf
      EndIf
      
      ;Magnetic
      If Msg = #WM_WINDOWPOSCHANGING
        
        Protected *Win.WINDOWPOS = lParam
        Protected WorkArea.RECT
        
        If *Win > 0

          ;Desktop
          If iflags & #WndEx_Magnetic_Desktop
            If SystemParametersInfo_(#SPI_GETWORKAREA, #Null, @WorkArea, #Null) <> 0
              ;Screen Top
              If *Win\y >= 0 - iMagneticValue And *Win\y <= iMagneticValue
                *Win\y = 0
              EndIf
              ;Screen Right
              If *Win\x + *Win\cx >= GetSystemMetrics_(#SM_CXSCREEN) - iMagneticValue And *Win\x + *Win\cx <= GetSystemMetrics_(#SM_CXSCREEN) + iMagneticValue
                *Win\x = GetSystemMetrics_(#SM_CXSCREEN) - *Win\cx
              EndIf
              ;Screen Bottom
              If *Win\y + *Win\cy >= GetSystemMetrics_(#SM_CYSCREEN) - iMagneticValue And *Win\y + *Win\cy <= GetSystemMetrics_(#SM_CYSCREEN) + iMagneticValue
                *Win\y = GetSystemMetrics_(#SM_CYSCREEN) - *Win\cy
              EndIf
              ;Screen Left
              If *Win\x >= 0 - iMagneticValue And *Win\x <= iMagneticValue
                *Win\x = 0
              EndIf
              ;WorkArea Top
              If *Win\y >= WorkArea\top - iMagneticValue And *Win\y <= WorkArea\top + iMagneticValue
                *Win\y = WorkArea\top
              EndIf
              ;WorkArea Right
              If *Win\x + *Win\cx >= WorkArea\right - iMagneticValue And *Win\x + *Win\cx <= WorkArea\right + iMagneticValue
                *Win\x = WorkArea\right - *Win\cx
              EndIf
              ;WorkArea Bottom
              If *Win\y + *Win\cy >= WorkArea\bottom - iMagneticValue And *Win\y + *Win\cy <= WorkArea\bottom + iMagneticValue
                *Win\y = WorkArea\bottom - *Win\cy
              EndIf
              ;Workarea Left
              If *Win\x >= WorkArea\left - iMagneticValue And *Win\x <= WorkArea\left + iMagneticValue
                *Win\x = WorkArea\Left
              EndIf
            EndIf
          EndIf

          ;MagneticWindow
          If iflags & #WndEx_Magnetic_Window Or iflags & #WndEx_Magnetic_WindowC
            ForEach WndEx()

              If WndEx()\win <> hWnd And IsWindowVisible_(WndEx()\win) = 1

                ;WindowRect
                GetWindowRect_(WndEx()\win, @WndEx()\w)
                ;ClientRect
                GetClientRect_(WndEx()\win, @WndEx()\c)
                WndEx()\c\left   = WndEx()\w\Left + (WndEx()\w\right - WndEx()\w\left - WndEx()\c\right) / 2
                WndEx()\c\top    = WndEx()\w\top + WndEx()\w\bottom - WndEx()\w\top - WndEx()\c\bottom - (WndEx()\w\right - WndEx()\w\left - WndEx()\c\right) / 2
                WndEx()\c\right  = WndEx()\c\left + WndEx()\c\right
                WndEx()\c\bottom = WndEx()\c\top + WndEx()\c\bottom

                If *Win\y >= WndEx()\w\top - *Win\cy And *Win\y + *Win\cy <= WndEx()\w\bottom + *Win\cy
                  ;Right Outdoor
                  If *Win\x >= WndEx()\w\right - iMagneticValue And *Win\x <= WndEx()\w\right + iMagneticValue
                    *Win\x = WndEx()\w\right
                  EndIf
                  ;Left Outdoor
                  If *Win\x + *Win\cx >= WndEx()\w\left - iMagneticValue And *Win\x + *Win\cx <= WndEx()\w\left + iMagneticValue
                    *Win\x = WndEx()\w\left - *Win\cx
                  EndIf
                EndIf

                If *Win\x >= WndEx()\w\left - *Win\cx And *Win\x + *Win\cx <= WndEx()\w\right + *Win\cx
                  ;Top Outdoor
                  If *Win\y + *Win\cy >= WndEx()\w\top - iMagneticValue And *Win\y + *Win\cy <= WndEx()\w\top + iMagneticValue
                    *Win\y = WndEx()\w\top - *Win\cy
                  EndIf
                  ;Bottom Outdoor
                  If *Win\y >= WndEx()\w\bottom - iMagneticValue And *Win\y <= WndEx()\w\bottom + iMagneticValue
                    *Win\y = WndEx()\w\bottom
                  EndIf
                EndIf

                If iflags & #WndEx_Magnetic_Window
                  If *Win\y >= WndEx()\w\top - *Win\cy And *Win\y + *Win\cy <= WndEx()\w\bottom + *Win\cy
                    ;Right Indoor
                    If *Win\x + *Win\cx >= WndEx()\w\right - iMagneticValue And *Win\x + *Win\cx <= WndEx()\w\right + iMagneticValue
                      *Win\x = WndEx()\w\right - *Win\cx
                    EndIf
                    ;Left Indoor
                    If *Win\x  >= WndEx()\w\left - iMagneticValue And *Win\x  <= WndEx()\w\left + iMagneticValue
                      *Win\x = WndEx()\w\left
                    EndIf
                  EndIf
                EndIf

                If iflags & #WndEx_Magnetic_Window
                  If *Win\x >= WndEx()\w\left - *Win\cx - iMagneticValue And *Win\x + *Win\cx <= WndEx()\w\right + *Win\cx + iMagneticValue
                    ;Top Indoor
                    If *Win\y >= WndEx()\w\top - iMagneticValue And *Win\y <= WndEx()\w\top + iMagneticValue
                      *Win\y = WndEx()\w\top
                    EndIf
                    ;Bottom Indoor
                    If *Win\y + *Win\cy >= WndEx()\w\bottom - iMagneticValue And *Win\y + *Win\cy <= WndEx()\w\bottom + iMagneticValue
                      *Win\y = WndEx()\w\bottom - *Win\cy
                    EndIf
                  EndIf
                EndIf

                ;Client
                If iflags & #WndEx_Magnetic_WindowC
                  If *Win\y >= WndEx()\w\top - *Win\cy + iMagneticValue + 1 And *Win\y + *Win\cy <= WndEx()\w\bottom + *Win\cy - iMagneticValue - 1
                    ;Indoor Right Client
                    If *Win\x + *Win\cx >= WndEx()\c\right - iMagneticValue And *Win\x + *Win\cx <= WndEx()\c\right + iMagneticValue
                      *Win\x = WndEx()\c\right - *Win\cx
                    EndIf
                    ;Indoor Left Client
                    If *Win\x  >= WndEx()\c\left - iMagneticValue And *Win\x  <= WndEx()\c\left + iMagneticValue
                      *Win\x = WndEx()\c\left
                    EndIf
                  EndIf
                  If *Win\x + *Win\cx = WndEx()\w\left Or *Win\x = WndEx()\w\right
                    ;Outdoor Top Client
                    If *Win\y >= WndEx()\w\top - iMagneticValue And *Win\y <= WndEx()\w\top + iMagneticValue
                      *Win\y = WndEx()\w\top
                    EndIf
                    ;Outdoor Bottom Client
                    If *Win\y + *Win\cy >= WndEx()\w\bottom - iMagneticValue And *Win\y + *Win\cy <= WndEx()\w\bottom + iMagneticValue
                      *Win\y = WndEx()\w\bottom - *Win\cy
                    EndIf
                  EndIf
                EndIf

                ;Client
                If iflags & #WndEx_Magnetic_WindowC
                  If *Win\x >= WndEx()\w\left - *Win\cx + iMagneticValue + 1 And *Win\x + *Win\cx <= WndEx()\w\right + *Win\cx - iMagneticValue - 1
                    ;Indoor Top Client
                    If *Win\y >= WndEx()\c\top - iMagneticValue And *Win\y <= WndEx()\c\top + iMagneticValue
                      *Win\y = WndEx()\c\top
                    EndIf
                    ;Indoor Bottom Client
                    If *Win\y + *Win\cy >= WndEx()\c\bottom - iMagneticValue And *Win\y + *Win\cy <= WndEx()\c\bottom + iMagneticValue
                      *Win\y = WndEx()\c\bottom - *Win\cy
                    EndIf
                  EndIf
                  If *Win\y + *Win\cy = WndEx()\w\top Or *Win\y = WndEx()\w\bottom
                    ;Outdoor Left Client
                    If *Win\x >= WndEx()\w\left - iMagneticValue And *Win\x <= WndEx()\w\left + iMagneticValue
                      *Win\x = WndEx()\w\left
                    EndIf
                    ;Outdoor Right Client
                    If *Win\x + *Win\cx >= WndEx()\w\right - iMagneticValue And *Win\x + *Win\cx <= WndEx()\w\right + iMagneticValue
                      *Win\x = WndEx()\w\right - *Win\cx
                    EndIf
                  EndIf
                EndIf

              EndIf

            Next
          EndIf

        EndIf

      EndIf

    EndIf
  Next

EndProcedure
; IDE Options = PureBasic 4.40 Beta 7 (Windows - x86)
; Folding = --
; EnableXP
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 2
; EnableBuildCount = 0
; EnableExeConstant