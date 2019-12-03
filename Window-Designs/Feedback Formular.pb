EnableExplicit

Enumeration 
  #Win_Feedback
EndEnumeration
Enumeration 
  #G_TX_Feedback_Name
  #G_SR_Feedback_Name
  #G_TX_Feedback_Mail
  #G_SR_Feedback_Mail
  #G_TX_Feedback_Subject
  #G_SR_Feedback_Subject
  #G_TX_Feedback_Message
  #G_SR_Feedback_Message
  #G_FR_Feedback_Gap
  #G_BN_Feedback_Reset
  #G_BN_Feedback_Send
  #G_BN_Feedback_Cancel
  #G_WB_Feedback_Hide
EndEnumeration

Procedure Feedback_Send()
  Protected iError.i
  Protected iConnect.i
  Protected sName.s, sMail.s, sSubject.s, sMessage.s, sURL.s
  
  ; Eingaben überprüfen
  sName    = Trim(GetGadgetText(#G_SR_Feedback_Name))
  sMail    = Trim(GetGadgetText(#G_SR_Feedback_Mail))
  sSubject = Trim(GetGadgetText(#G_SR_Feedback_Subject))
  sMessage = Trim(GetGadgetText(#G_SR_Feedback_Message))
  
  If sName = ""
    SetGadgetColor(#G_SR_Feedback_Name, #PB_Gadget_BackColor, $0095FF)
    iError = 1
  Else
    SetGadgetColor(#G_SR_Feedback_Name, #PB_Gadget_BackColor, -1)
  EndIf
  If sMail = "" Or FindString(sMail, ".", 1) = 0 Or FindString(sMail, "@", 1) = 0
    SetGadgetColor(#G_SR_Feedback_Mail, #PB_Gadget_BackColor, $0095FF)
    iError = 1
  Else
    SetGadgetColor(#G_SR_Feedback_Mail, #PB_Gadget_BackColor, -1)
  EndIf
  If sSubject = ""
    SetGadgetColor(#G_SR_Feedback_Subject, #PB_Gadget_BackColor, $0095FF)
    iError = 1
  Else
    SetGadgetColor(#G_SR_Feedback_Subject, #PB_Gadget_BackColor, -1)
  EndIf
  If sMessage = ""
    SetGadgetColor(#G_SR_Feedback_Message, #PB_Gadget_BackColor, $0095FF)
    iError = 1
  Else
    SetGadgetColor(#G_SR_Feedback_Message, #PB_Gadget_BackColor, -1)
  EndIf
  
  If iError = 0
    
    ; URL erzeugen
    sMessage = "BassKing Feedback:" + #CRLF$
    sMessage + "---" + #CRLF$
    sMessage + "Name: " + sName + #CRLF$
    sMessage + "Mail: " + sMail + #CRLF$
    sMessage + "---" + #CRLF$
    sMessage + Trim(GetGadgetText(#G_SR_Feedback_Message))
    
    sURL = "http://www.kaisnet.de/includes/misc/dmail.php?betreff=" + sSubject + "&nachricht=" + sMessage
    sURL = URLEncoder(sURL)
    
    ; URL aufrufen
    SetGadgetText(#G_WB_Feedback_Hide, sURL)
    
  EndIf
EndProcedure

InitNetwork()

If OpenWindow(#Win_Feedback, 0, 0, 445, 335, "Feedback", #PB_Window_SystemMenu|#PB_Window_SizeGadget|#PB_Window_ScreenCentered)
  TextGadget(#G_TX_Feedback_Name, 5, 5, 280, 15, "Name:")
  StringGadget(#G_SR_Feedback_Name, 5, 20, 280, 20, "")
  TextGadget(#G_TX_Feedback_Mail, 5, 45, 280, 15, "Mail:")
  StringGadget(#G_SR_Feedback_Mail, 5, 60, 280, 20, "")
  TextGadget(#G_TX_Feedback_Subject, 5, 85, 280, 15, "Betreff:")
  StringGadget(#G_SR_Feedback_Subject, 5, 100, 280, 20, "")
  TextGadget(#G_TX_Feedback_Message, 5, 125, 435, 15, "Nachricht:")
  StringGadget(#G_SR_Feedback_Message, 5, 140, 435, 150, "", #ES_MULTILINE|#ES_AUTOVSCROLL|#WS_VSCROLL)
  Frame3DGadget(#G_FR_Feedback_Gap, -5, WindowHeight(#Win_Feedback) - 37, WindowWidth(#Win_Feedback) + 10, 2, "", #PB_Frame3D_Single)
  ButtonGadget(#G_BN_Feedback_Reset, WindowWidth(#Win_Feedback) - 275, WindowHeight(#Win_Feedback) - 30, 100, 25, "Zurücksetzen")
  ButtonGadget(#G_BN_Feedback_Send, WindowWidth(#Win_Feedback) - 170, WindowHeight(#Win_Feedback) - 30, 80, 25, "Senden")
  ButtonGadget(#G_BN_Feedback_Cancel, WindowWidth(#Win_Feedback) - 85, WindowHeight(#Win_Feedback) - 30, 80, 25, "Abbrechen")
  WebGadget(#G_WB_Feedback_Hide, 0, 0, 0, 0, "")
    HideGadget(#G_WB_Feedback_Hide, 1)
  
  WindowBounds(#Win_Feedback, WindowWidth(#Win_Feedback), WindowHeight(#Win_Feedback), #PB_Ignore, #PB_Ignore)
  
  Repeat
    Select WaitWindowEvent()
      Case #PB_Event_Gadget
        Select EventGadget()
          Case #G_BN_Feedback_Cancel
            End
          Case #G_BN_Feedback_Send
            Feedback_Send()
        EndSelect
      Case #PB_Event_CloseWindow
        End
      Case #PB_Event_SizeWindow
        ResizeGadget(#G_SR_Feedback_Message, #PB_Ignore, #PB_Ignore, WindowWidth(#Win_Feedback) - 10, WindowHeight(#Win_Feedback) - 185)
        ResizeGadget(#G_FR_Feedback_Gap, #PB_Ignore, WindowHeight(#Win_Feedback) - 37, WindowWidth(#Win_Feedback) + 10, #PB_Ignore)
        ResizeGadget(#G_BN_Feedback_Reset, WindowWidth(#Win_Feedback) - 275, WindowHeight(#Win_Feedback) - 30, #PB_Ignore, #PB_Ignore)
        ResizeGadget(#G_BN_Feedback_Send, WindowWidth(#Win_Feedback) - 170, WindowHeight(#Win_Feedback) - 30, #PB_Ignore, #PB_Ignore)
        ResizeGadget(#G_BN_Feedback_Cancel, WindowWidth(#Win_Feedback) - 85, WindowHeight(#Win_Feedback) - 30, #PB_Ignore, #PB_Ignore)
    EndSelect
  ForEver
  
EndIf
; IDE Options = PureBasic 4.40 Beta 6 (Windows - x86)
; CursorPosition = 61
; FirstLine = 49
; Folding = -
; EnableXP
; Executable = C:\Users\Kai\Desktop\SendMail.exe
; CPU = 1
; CompileSourceDirectory
; EnableCompileCount = 89
; EnableBuildCount = 1
; EnableExeConstant