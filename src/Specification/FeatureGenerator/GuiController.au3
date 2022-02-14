Func _CreateRandomText($iLength = 10)
    Local $sText = ''

    Dim $aChr[2]
    For $i = 1 To $iLength Step 1
        $aChr[0] = Chr(Random(65, 90, 1))  ; A-Z
        $aChr[1] = Chr(Random(97, 122, 1)) ; a-z
        $sText  &= $aChr[Random(0, 1, 1)]
    Next

    Return $sText
EndFunc

Func _GuiFadeIn($hGui, $iSleep = 10)
    For $i = 0 To 255 Step 5
        WinSetTrans($hGui, '', $i)
        Sleep($iSleep)
    Next
EndFunc

Func _GuiFadeOut($hGui, $iSleep = 10)
    For $i = 255 To 0 Step -5
        WinSetTrans($hGui, '', $i)
        Sleep($iSleep)
    Next
EndFunc

Func _IsMouseOnGui($hGui)
    $aMouseData = MouseGetPos()
    $aGuiData   = WinGetPos($hGui)

    If $aMouseData[0] >= $aGuiData[0] And _
       $aMouseData[1] >= $aGuiData[1] And _
       $aMouseData[0] <= $aGuiData[0] + $aGuiData[2] And _
       $aMouseData[1] <= $aGuiData[1] + $aGuiData[3] Then

       Return True
    EndIf

    Return False
EndFunc

Func _IsMouseOnControl($iXMouse, $iYMouse, $iXControl, $iYControl, $iWidthControl, $iHeightControl)
    If $iXMouse >= $iXControl And _
       $iYMouse >= $iYControl And _
       $iXMouse <= $iXControl + $iWidthControl  And _
       $iYMouse <= $iYControl + $iHeightControl Then
       Return True
    Else
        Return False
    EndIf
EndFunc

Func _SetControlFocusWithoutSelectedText($cControl)
    GUICtrlSetState($cControl, $GUI_FOCUS)
    ControlClick($aGui[$eHandle], '', $cControl)
EndFunc

Func _HoverMoveIcon()
    Return _IsMouseOnControl($aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aMoveIcon[$eXPosition], $aMoveIcon[$eYPosition], $aMoveIcon[$eWidth], $aMoveIcon[$eHeight])
EndFunc

Func _HoverCloseIcon()
    Return _IsMouseOnControl($aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aCloseIcon[$eXPosition], $aCloseIcon[$eYPosition], $aCloseIcon[$eWidth], $aCloseIcon[$eHeight])
EndFunc

Func _HoverThemeIcon()
    Return _IsMouseOnControl($aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aThemeIcon[$eXPosition], $aThemeIcon[$eYPosition], $aThemeIcon[$eWidth], $aThemeIcon[$eHeight])
EndFunc

Func _HoverButtonOkay()
    Return _IsMouseOnControl($aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aButtonAdd[$eXPosition], $aButtonAdd[$eYPosition], $aButtonAdd[$eWidth], $aButtonAdd[$eHeight])
EndFunc

Func _HoverActions()
    If _IsMouseOnGui($aGui[$eHandle]) Then
        Select
            Case _HoverCloseIcon()
                _ResetThemeIconColor()
                GUICtrlSetBkColor($aCloseIcon[$eBackground], $aCloseIcon[$eHoverColor])
                GUICtrlSetBkColor($aCloseIcon[$eLabel], $aCloseIcon[$eHoverColor])
                GUICtrlSetColor($aCloseIcon[$eLabel], $aCloseIcon[$eFontColor])

            Case _HoverThemeIcon()
                _ResetCloseIconColor()
                _ResetMoveIconColor()
                GUICtrlSetBkColor($aThemeIcon[$eBackground], _SetThemeColor($aThemeIcon[$eHoverColor], True))
                GUICtrlSetBkColor($aThemeIcon[$eLabel], _SetThemeColor($aThemeIcon[$eHoverColor], True))

            Case _HoverMoveIcon()
                _ResetThemeIconColor()
                GUICtrlSetBkColor($aMoveIcon[$eBackground], _SetThemeColor($aMoveIcon[$eHoverColor], True))
                GUICtrlSetBkColor($aMoveIcon[$eLabel], _SetThemeColor($aMoveIcon[$eHoverColor], True))

            Case _HoverButtonOkay()
                GUICtrlSetBkColor($aButtonAdd[$eBorderTop], _SetThemeColor($aColor[$eBorderInput], True))
                GUICtrlSetBkColor($aButtonAdd[$eBorderRight], _SetThemeColor($aColor[$eBorderInput], True))
                GUICtrlSetBkColor($aButtonAdd[$eBorderBottom], _SetThemeColor($aColor[$eBorderInput], True))
                GUICtrlSetBkColor($aButtonAdd[$eBorderLeft], _SetThemeColor($aColor[$eBorderInput], True))

            Case Else
                _ResetCloseIconColor()
                _ResetThemeIconColor()
                _ResetMoveIconColor()
                _ResetBorderColorButtonAdd()
        EndSelect
    EndIf
EndFunc

Func _ResetCloseIconColor()
    GUICtrlSetBkColor($aCloseIcon[$eBackground], _SetThemeColor($aColor[$eBackground], True))
    GUICtrlSetBkColor($aCloseIcon[$eLabel], _SetThemeColor($aColor[$eBackground], True))
    GUICtrlSetColor($aCloseIcon[$eLabel], _SetThemeColor($aColor[$eIcon], True))
EndFunc

Func _ResetThemeIconColor()
    GUICtrlSetBkColor($aThemeIcon[$eBackground], _SetThemeColor($aColor[$eBackground], True))
    GUICtrlSetBkColor($aThemeIcon[$eLabel], _SetThemeColor($aColor[$eBackground], True))
EndFunc

Func _ResetMoveIconColor()
    GUICtrlSetBkColor($aMoveIcon[$eBackground], _SetThemeColor($aColor[$eBackground], True))
    GUICtrlSetBkColor($aMoveIcon[$eLabel], _SetThemeColor($aColor[$eBackground], True))
EndFunc

Func _ResetBorderColorButtonAdd()
    GUICtrlSetBkColor($aButtonAdd[$eBorderTop], _SetThemeColor($aColor[$eBorder], True))
    GUICtrlSetBkColor($aButtonAdd[$eBorderRight], _SetThemeColor($aColor[$eBorder], True))
    GUICtrlSetBkColor($aButtonAdd[$eBorderBottom], _SetThemeColor($aColor[$eBorder], True))
    GUICtrlSetBkColor($aButtonAdd[$eBorderLeft], _SetThemeColor($aColor[$eBorder], True))
EndFunc
