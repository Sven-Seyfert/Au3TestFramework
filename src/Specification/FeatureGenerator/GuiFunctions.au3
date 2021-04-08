Func _guiFadeIn( $hGui, $iSleep = 10 )
    For $i = 0 To 255 Step 5
        WinSetTrans( $hGui, '', $i )
        Sleep( $iSleep )
    Next
EndFunc

Func _guiFadeOut( $hGui, $iSleep = 10 )
    For $i = 255 To 0 Step -5
        WinSetTrans( $hGui, '', $i )
        Sleep( $iSleep )
    Next
EndFunc

Func _isMouseOnGui( $hGui )
    $aMouseData = MouseGetPos()
    $aGuiData   = WinGetPos( $hGui )

    If $aMouseData[0] >= $aGuiData[0] And _
       $aMouseData[1] >= $aGuiData[1] And _
       $aMouseData[0] <= $aGuiData[0] + $aGuiData[2] And _
       $aMouseData[1] <= $aGuiData[1] + $aGuiData[3] Then

       Return True
    EndIf

    Return False
EndFunc

Func _isMouseOnControl( $iXMouse, $iYMouse, $iXControl, $iYControl, $iWidthControl, $iHeightControl )
    If $iXMouse >= $iXControl And _
       $iYMouse >= $iYControl And _
       $iXMouse <= $iXControl + $iWidthControl  And _
       $iYMouse <= $iYControl + $iHeightControl Then
       Return True
    Else
        Return False
    EndIf
EndFunc

Func _setBorderColor( $aControl, $vBorderColor )
    GUICtrlSetBkColor( $aControl[$eBorderTop], $vBorderColor )
    GUICtrlSetBkColor( $aControl[$eBorderRight], $vBorderColor )
    GUICtrlSetBkColor( $aControl[$eBorderBottom], $vBorderColor )
    GUICtrlSetBkColor( $aControl[$eBorderLeft], $vBorderColor )
EndFunc

Func _setControlFocusWithoutSelectedText( $cControl )
    GUICtrlSetState( $cControl, $GUI_FOCUS )
    ControlClick( $aGui[$eHandle], '', $cControl )
EndFunc

Func _hexColorInvert( $vHexCode )
    Return '0x' & Hex ( 0xFFFFFF - $vHexCode, 6 )
EndFunc

Func _setThemeColor( $vColor, $bShouldInvert = False )
    If Not $bShouldInvert Then Return $bIsDarkModeActive ? $vColor : _hexColorInvert( $vColor )
    If $bShouldInvert     Then Return $bIsDarkModeActive ? _hexColorInvert( $vColor ) : $vColor
EndFunc

Func _hoverMoveIcon()
    Return _isMouseOnControl( $aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aMoveIcon[$eXPosition], $aMoveIcon[$eYPosition], $aMoveIcon[$eWidth], $aMoveIcon[$eHeight] )
EndFunc

Func _hoverCloseIcon()
    Return _isMouseOnControl( $aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aCloseIcon[$eXPosition], $aCloseIcon[$eYPosition], $aCloseIcon[$eWidth], $aCloseIcon[$eHeight] )
EndFunc

Func _hoverThemeIcon()
    Return _isMouseOnControl( $aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aThemeIcon[$eXPosition], $aThemeIcon[$eYPosition], $aThemeIcon[$eWidth], $aThemeIcon[$eHeight] )
EndFunc

Func _hoverButtonOkay()
    Return _isMouseOnControl( $aMouseData[0] - $aGuiData[0], $aMouseData[1] - $aGuiData[1], $aButtonOkay[$eXPosition], $aButtonOkay[$eYPosition], $aButtonOkay[$eWidth], $aButtonOkay[$eHeight] )
EndFunc

Func _hoverActions()
    If _isMouseOnGui( $aGui[$eHandle] ) Then
        Select
            Case _hoverCloseIcon()
                _resetThemeIconColor()
                GUICtrlSetBkColor( $aCloseIcon[$eBackground], $aCloseIcon[$eHoverColor] )
                GUICtrlSetBkColor( $aCloseIcon[$eLabel], $aCloseIcon[$eHoverColor] )
                GUICtrlSetColor( $aCloseIcon[$eLabel], $aCloseIcon[$eFontColor] )

            Case _hoverThemeIcon()
                _resetCloseIconColor()
                _resetMoveIconColor()
                GUICtrlSetBkColor( $aThemeIcon[$eBackground], _setThemeColor( $aThemeIcon[$eHoverColor], True ) )
                GUICtrlSetBkColor( $aThemeIcon[$eLabel], _setThemeColor( $aThemeIcon[$eHoverColor], True ) )

            Case _hoverMoveIcon()
                _resetThemeIconColor()
                GUICtrlSetBkColor( $aMoveIcon[$eBackground], _setThemeColor( $aMoveIcon[$eHoverColor], True ) )
                GUICtrlSetBkColor( $aMoveIcon[$eLabel], _setThemeColor( $aMoveIcon[$eHoverColor], True ) )

            Case _hoverButtonOkay()
                GUICtrlSetBkColor( $aButtonOkay[$eBorderTop], _setThemeColor( $aColor[$eBorderInput], True ) )
                GUICtrlSetBkColor( $aButtonOkay[$eBorderRight], _setThemeColor( $aColor[$eBorderInput], True ) )
                GUICtrlSetBkColor( $aButtonOkay[$eBorderBottom], _setThemeColor( $aColor[$eBorderInput], True ) )
                GUICtrlSetBkColor( $aButtonOkay[$eBorderLeft], _setThemeColor( $aColor[$eBorderInput], True ) )

            Case Else
                _resetCloseIconColor()
                _resetThemeIconColor()
                _resetMoveIconColor()
                _resetBorderColorButtonOkay()
        EndSelect
    EndIf
EndFunc

Func _resetCloseIconColor()
    GUICtrlSetBkColor( $aCloseIcon[$eBackground], _setThemeColor( $aColor[$eBackground], True ) )
    GUICtrlSetBkColor( $aCloseIcon[$eLabel], _setThemeColor( $aColor[$eBackground], True ) )
    GUICtrlSetColor( $aCloseIcon[$eLabel], _setThemeColor( $aColor[$eIcon], True ) )
EndFunc

Func _resetThemeIconColor()
    GUICtrlSetBkColor( $aThemeIcon[$eBackground], _setThemeColor( $aColor[$eBackground], True ) )
    GUICtrlSetBkColor( $aThemeIcon[$eLabel], _setThemeColor( $aColor[$eBackground], True ) )
EndFunc

Func _resetMoveIconColor()
    GUICtrlSetBkColor( $aMoveIcon[$eBackground], _setThemeColor( $aColor[$eBackground], True ) )
    GUICtrlSetBkColor( $aMoveIcon[$eLabel], _setThemeColor( $aColor[$eBackground], True ) )
EndFunc

Func _resetBorderColorButtonOkay()
    GUICtrlSetBkColor( $aButtonOkay[$eBorderTop], _setThemeColor( $aColor[$eBorder], True ) )
    GUICtrlSetBkColor( $aButtonOkay[$eBorderRight], _setThemeColor( $aColor[$eBorder], True ) )
    GUICtrlSetBkColor( $aButtonOkay[$eBorderBottom], _setThemeColor( $aColor[$eBorder], True ) )
    GUICtrlSetBkColor( $aButtonOkay[$eBorderLeft], _setThemeColor( $aColor[$eBorder], True ) )
EndFunc
