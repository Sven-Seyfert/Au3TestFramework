#include-once

; #INDEX# =======================================================================================================================
; Title .........: GUIScroll
; AutoIt Version : 3.3.6.1
; Language ......: Deutsch
; Description ...: Funktionen für ein scrollbares GUI.
; Author(s) .....: Großvater & www.autoit.de
; ===============================================================================================================================

; #CURRENT# =====================================================================================================================
;_GUIScroll_Init
; ===============================================================================================================================

; #INTERNAL_USE_ONLY# ===========================================================================================================
;__GUIScroll_Delta
;__GUIScroll_Max
;__GUIScroll_GetInfo
;__GUIScroll_SetInfo
;__GUIScroll_Restore
;__GUIScroll_Wheel
;__GUIScroll_HWheel
;__GUIScroll_Scroll
; ===============================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name...........: _GUIScroll_Init
; Description ...: Initialisierung der Behandlung der Scrollnachrichten WM_HSCROLL und/oder WM_VSCROLL
;                  in "scrollbaren" GUIs.
;                  für die entsprechende Nachricht wird mit GUIRegisterMsg() eine Funktion registriert,
;                  die Scrollbars werden mit den passenden Werten initialisiert.
; Syntax.........: _GUIScroll_Init($hWnd, $fnBar[, $bWheel = False[, $iDelta = Default[, $iPage = Default[, $iMax = Default]]]])
; Parameters ....: $hWnd    - HWND des GUI
;                  $fnBar   - Art der Scrollbar:
;                  |0       - (SB_HORZ) = horizontal
;                  |1       - (SB_VERT) = vertikal
;                  $bWheel  - WM_MOUSEWHEEL/WM_MOUSEHWHEEL für das Scrollen registrieren (WM_MOUSEHWHEEL gibt es erst ab Vista)
;                  |False   : nein
;                  |True    : ja
;                  |Default : nein
;                  $iDelta  - Schrittweite in Pixeln
;                           - wird verwendet, wenn auf die äußeren Scrollbuttons geklickt oder per Mausrad gescrollt wird
;                  |Default : 5 Prozent von $iMax
;                  $iPage   - Größe einer "Seite" in Pixeln
;                           - wird verwendet, wenn neben dem "Schieber" in die Scrollbar geklickt wird
;                  |Default : Aktuelle Breite/Höhe des Clientbereichs
;                  $iMax    - Größe des Scrollbereichs in Pixeln
;                  |Default : für die Darstellung aller Controls benötigte Breite/Höhe
; Return values .: Im Erfolgsfall: True
;                  Im Fehlerfall: False
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: Das GUI muss mit den Styles WS_HSCROLL und/oder WS_VSCROLL versehen sein, sonst passiert nichts.
;                  Die Funktion darf erst dann aufgerufen werden, wenn das GUI in der gewünschten Größe erstellt worden ist.
;                  Dabei ist immer zu beachten, dass AutoIt den tatsächlich benötigten oder vorgegebenen Clientbereich um
;                  die Breite/Höhe der Scrollbars vermindert.
;                  Weil ich AutoIt nicht davon abbringen konnte, den Fensterinhalt nach einem Restore immer wieder ab
;                  Position 0-0 neu zu zeichnen, wird auch die Nachricht WM_SYSCOMMAND für SC_RESTORE registriert.
;                  Wer eine der registrierten Nachrichten selbst auswerten will oder muss, muss sie nach dem Aufruf
;                  von _GUIScroll_Init() für die eigenen Funktionen registrieren und am Anfang der eigenen Funktionen
;                  die entsprechenden "internen" __GuiScroll-Funktionen mit den 4 Originalparametern aufrufen.
; Related .......:
; Link ..........:
; Example .......:
; ===============================================================================================================================
Func _GUIScroll_Init($hWnd, $fnBar, $bWheel = False, $iDelta = Default, $iPage = Default, $iMax = Default)
    Local Static $GWL_STYLE = -16
    Local Static $SB_HORZ = 0, $SB_VERT = 1
    Local Static $WM_HSCROLL = 0x0114, $WM_VSCROLL = 0x0115, $WM_SYSCOMMAND = 0x0112
    Local Static $WM_MOUSEWHEEL = 0x020A, $WM_MOUSEHWHEEL = 0x020E
    Local Static $WS_HSCROLL = 0x100000, $WS_VSCROLL = 0x200000
    Local $aResult, $aScrollInfo, $aSize, $Msg
    If $fnBar <> $SB_HORZ And $fnBar <> $SB_VERT Then Return False
    $aResult = DllCall("User32.dll", "Bool", "IsWindow", "UInt", $hWnd)
    If Not $aResult[0] Then Return False
    $aResult = DllCall("User32.dll", "UInt", "GetWindowLong", "UInt", $hWnd, "Int", $GWL_STYLE)
    If $fnBar = $SB_HORZ And Not BitAND($aResult[0], $WS_HSCROLL) Then Return False
    If $fnBar = $SB_VERT And Not BitAND($aResult[0], $WS_VSCROLL) Then Return False
    If $iMax = Default Then
        $iMax = __GUIScroll_Max($hWnd, $fnBar)
    EndIf
    If $iPage = Default Then
        $aSize = WinGetClientSize($hWnd)
        If $fnBar = $SB_HORZ Then
            $iPage = $aSize[0]
        Else
            $iPage = $aSize[1]
        EndIf
    EndIf
    If $iDelta = Default Then
        $iDelta = Round($iMax / 20)
    EndIf
    __GUIScroll_Delta($fnBar, $iDelta)
    $aScrollInfo = __GUIScroll_GetInfo($hWnd, $fnBar)
    $aScrollInfo[0] = 0
    $aScrollInfo[1] = $iMax
    $aScrollInfo[2] = $iPage
    __GUIScroll_SetInfo($hWnd, $fnBar, $aScrollInfo)
    If $fnBar = $SB_HORZ Then
        GUIRegisterMsg($WM_HSCROLL, "__GUIScroll_Scroll")
    Else
        GUIRegisterMsg($WM_VSCROLL, "__GUIScroll_Scroll")
    EndIf
    GUIRegisterMsg($WM_SYSCOMMAND, "__GUIScroll_Restore")
    If $bWheel Then
        If $fnBar = $SB_VERT Then
            GUIRegisterMsg($WM_MOUSEWHEEL, "__GUIScroll_Wheel")
        Else
            GUIRegisterMsg($WM_MOUSEHWHEEL, "__GUIScroll_HWheel")
        EndIf
    EndIf
    Return True
EndFunc   ;==>_GUIScroll_Init

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_Delta
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_Delta($fnBar, $SetValue = "")
    Static Local $Delta0 = 1, $Delta1 = 1
    If @NumParams = 2 Then Assign("Delta" & $fnBar, $SetValue, 4)
    Return Eval("Delta" & $fnBar)
EndFunc   ;==>__GUIScroll_Delta

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_Max
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_Max($hWnd, $fnBar)
    Local Static $GW_CHILD = 5, $GW_HWNDNEXT = 2
    Local Static $Max0 = "INIT", $Max1 = "INIT"
    If $Max0 = "INIT" Then
        Local $aID, $aPos, $aResult, $Controls = False
        Local $aSize[4] = [99999, 99999, 0, 0]
        $aResult = DllCall("User32.dll", "HWND", "GetWindow", "HWND", $hWnd, "UInt", $GW_CHILD)
        If @error Or $aResult[0] = 0 Then Return False
        While $aResult[0]
            $aID = DllCall("User32.dll", "Int", "GetDlgCtrlID", "Hwnd", $aResult[0])
            $aPos = ControlGetPos($hWnd, "", $aID[0])
            $aPos[2] += $aPos[0]
            $aPos[3] += $aPos[1]
            If $aPos[0] < $aSize[0] Then $aSize[0] = $aPos[0]
            If $aPos[1] < $aSize[1] Then $aSize[1] = $aPos[1]
            If $aPos[2] > $aSize[2] Then $aSize[2] = $aPos[2]
            If $aPos[3] > $aSize[3] Then $aSize[3] = $aPos[3]
            $Controls = True
            $aResult = DllCall("User32.dll", "HWND", "GetWindow", "HWND", $aResult[0], "UInt", $GW_HWNDNEXT)
            If @error Then Return False
            $Max0 = $aSize[2] + $aSize[0]
            $Max1 = $aSize[3] + $aSize[1]
        WEnd
        If Not $Controls Then Return False
    EndIf
    Return Eval("Max" & $fnBar)
EndFunc   ;==>__GUIScroll_Max

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_GetInfo
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_GetInfo($hWnd, $fnBar)
    Local Static $SIF_ALL = 0x17
    Local Static $Size = 1, $Mask = 2, $Min = 3, $Max = 4, $Page = 5, $Pos = 6, $TrackPos = 7
    Local Static $SCROLLINFO = "INIT"
    If Not IsDllStruct($SCROLLINFO) Then
        $SCROLLINFO = DllStructCreate("UInt; UInt; Int; Int; UInt; Int; Int")
        DllStructSetData($SCROLLINFO, $Size, DllStructGetSize($SCROLLINFO))
        DllStructSetData($SCROLLINFO, $Mask, $SIF_ALL)
    EndIf
    Local $aResult = DllCall("User32.dll", "Bool", "GetScrollInfo", "Hwnd", $hWnd, "Int", $fnBar, "Ptr", DllStructGetPtr($SCROLLINFO))
    If @error Then Return SetError(@error, @extended, False)
    Local $aScrollInfo[5]
    $aScrollInfo[0] = DllStructGetData($SCROLLINFO, $Min)
    $aScrollInfo[1] = DllStructGetData($SCROLLINFO, $Max)
    $aScrollInfo[2] = DllStructGetData($SCROLLINFO, $Page)
    $aScrollInfo[3] = DllStructGetData($SCROLLINFO, $Pos)
    $aScrollInfo[4] = DllStructGetData($SCROLLINFO, $TrackPos)
    Return $aScrollInfo
EndFunc   ;==>__GUIScroll_GetInfo

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_SetInfo
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_SetInfo($hWnd, $fnBar, $aScrollInfo)
    Local Static $SIF_ALL = 0x17
    Local Static $Size = 1, $Mask = 2, $Min = 3, $Max = 4, $Page = 5, $Pos = 6, $TrackPos = 7
    Local Static $SCROLLINFO = "INIT"
    If Not IsArray($aScrollInfo) Or UBound($aScrollInfo) <> 5 Then Return SetError(1, 0, False)
    If Not IsDllStruct($SCROLLINFO) Then
        $SCROLLINFO = DllStructCreate("UInt; UInt; Int; Int; UInt; Int; Int")
        DllStructSetData($SCROLLINFO, $Size, DllStructGetSize($SCROLLINFO))
        DllStructSetData($SCROLLINFO, $Mask, $SIF_ALL)
    EndIf
    DllStructSetData($SCROLLINFO, $Min, $aScrollInfo[0])
    DllStructSetData($SCROLLINFO, $Max, $aScrollInfo[1])
    DllStructSetData($SCROLLINFO, $Page, $aScrollInfo[2])
    DllStructSetData($SCROLLINFO, $Pos, $aScrollInfo[3])
    DllStructSetData($SCROLLINFO, $TrackPos, $aScrollInfo[4])
    Local $aResult = DllCall("User32.dll", "Int", "SetScrollInfo", "Hwnd", $hWnd, "Int", $fnBar, "Ptr", DllStructGetPtr($SCROLLINFO), "Bool", 1)
    If @error Then Return SetError(@error, @extended, False)
    Return $aResult[0]
EndFunc   ;==>__GUIScroll_SetInfo

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_Restore
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_Restore($hWnd, $Msg, $wParam, $lParam)
    Local Static $SC_RESTORE = 0xF120
    Local Static $SB_HORZ = 0, $SB_VERT = 1
    Local $aScrollInfo
    If $wParam = $SC_RESTORE Then
        $aScrollInfo = __GUIScroll_GetInfo($hWnd, $SB_HORZ)
        $aScrollInfo[3] = 0
        __GUIScroll_SetInfo($hWnd, $SB_HORZ, $aScrollInfo)
        $aScrollInfo = __GUIScroll_GetInfo($hWnd, $SB_VERT)
        $aScrollInfo[3] = 0
        __GUIScroll_SetInfo($hWnd, $SB_VERT, $aScrollInfo)
    EndIf
    Return $GUI_RUNDEFMSG
EndFunc   ;==>__GUIScroll_Restore

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_Wheel
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_Wheel($hWnd, $Msg, $wParam, $lParam)
    Local Static $SB_LINEBACK = 0, $SB_LINEFORW = 1
    Local Static $WM_VSCROLL = 0x0115
    Local $UpDown
    If BitShift($wParam, 16) > 0 Then
        $UpDown = $SB_LINEBACK
    Else
        $UpDown = $SB_LINEFORW
    EndIf
    __GUIScroll_Scroll($hWnd, $WM_VSCROLL, $UpDown, 0)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>__GUIScroll_Wheel

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_HWheel
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_HWheel($hWnd, $Msg, $wParam, $lParam)
    Local Static $SB_LINEBACK = 0, $SB_LINEFORW = 1
    Local Static $WM_HSCROLL = 0x0114
    Local $UpDown
    If BitShift($wParam, 16) > 0 Then
        $UpDown = $SB_LINEBACK
    Else
        $UpDown = $SB_LINEFORW
    EndIf
    __GUIScroll_Scroll($hWnd, $WM_HSCROLL, $UpDown, 0)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>__GUIScroll_HWheel

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name...........: __GUIScroll_Scroll
; Author ........: Großvater & www.autoit.de
; Modified.......:
; Remarks .......: For Internal Use Only
; ===============================================================================================================================
Func __GUIScroll_Scroll($hWnd, $Msg, $wParam, $lParam)
    Local Static $SB_LINEBACK = 0, $SB_LINEFORW = 1
    Local Static $SB_PAGEBACK = 2, $SB_PAGEFORW = 3
    Local Static $SB_THUMBTRACK = 5
    Local Static $WM_HSCROLL = 0x0114, $WM_VSCROLL = 0x0115
    Local Static $SB_HORZ = 0, $SB_VERT = 1
    If Not $lParam = 0 Then Return $GUI_RUNDEFMSG
    Local $Delta = 0, $HScroll = 0, $VScroll = 0, $SB
    If $Msg = $WM_HSCROLL Then
        $SB = $SB_HORZ
    Else
        $SB = $SB_VERT
    EndIf
    Local $aScrollInfo = __GUIScroll_GetInfo($hWnd, $SB)
    Local $Pos = $aScrollInfo[3]
    $Delta = __GUIScroll_Delta($SB)
    Switch BitAND($wParam, 0x0000FFFF)
        Case $SB_LINEBACK
            $aScrollInfo[3] -= $Delta
        Case $SB_LINEFORW
            $aScrollInfo[3] += $Delta
        Case $SB_PAGEBACK
            $aScrollInfo[3] -= $aScrollInfo[2]
        Case $SB_PAGEFORW
            $aScrollInfo[3] += $aScrollInfo[2]
        Case $SB_THUMBTRACK
            $aScrollInfo[3] = $aScrollInfo[4]
    EndSwitch
    __GUIScroll_SetInfo($hWnd, $SB, $aScrollInfo)
    $aScrollInfo = __GUIScroll_GetInfo($hWnd, $SB)
    If ($Pos <> $aScrollInfo[3]) Then
        If $SB = $SB_HORZ Then
            $HScroll = $Pos - $aScrollInfo[3]
        Else
            $VScroll = $Pos - $aScrollInfo[3]
        EndIf
        DllCall("User32.dll", "Bool", "ScrollWindow", "Hwnd", $hWnd, "Int", $HScroll, "Int", $VScroll, "ptr", 0, "ptr", 0)
    EndIf
    Return $GUI_RUNDEFMSG
EndFunc   ;==>__GUIScroll_Scroll
