Func _applyThemeGui()
    GUISetBkColor(_setThemeColor($aColor[$eBackground]), $aGui[$eHandle])
    _setBorderColor($aGui, _setThemeColor($aColor[$eBorder]))
EndFunc

Func _applyThemeCloseIcon()
    GUICtrlSetBkColor($aCloseIcon[$eBackground], _setThemeColor($aColor[$eBackground]))
    GUICtrlSetBkColor($aCloseIcon[$eLabel], _setThemeColor($aColor[$eBackground]))
    GUICtrlSetColor($aCloseIcon[$eLabel], _setThemeColor($aColor[$eIcon]))
EndFunc

Func _applyThemeThemeIcon()
    GUICtrlSetBkColor($aThemeIcon[$eBackground], _setThemeColor($aColor[$eBackground]))
    GUICtrlSetBkColor($aThemeIcon[$eLabel], _setThemeColor($aColor[$eBackground]))
    GUICtrlSetColor($aThemeIcon[$eLabel], _setThemeColor($aColor[$eIcon]))
EndFunc

Func _applyMoveThemeIcon()
    GUICtrlSetBkColor($aMoveIcon[$eBackground], _setThemeColor($aColor[$eBackground]))
    GUICtrlSetBkColor($aMoveIcon[$eLabel], _setThemeColor($aColor[$eBackground]))
    GUICtrlSetColor($aMoveIcon[$eLabel], _setThemeColor($aColor[$eIcon]))
EndFunc

Func _applyThemeHeadline()
    GUICtrlSetColor($aHeadline[$eLabel], _setThemeColor($aColor[$eFont]))
EndFunc

Func _applyThemeSubHeadline()
    GUICtrlSetColor($aSubHeadline[$eLabel], _setThemeColor($aColor[$eFont]))
EndFunc

Func _applyThemeInputFeatureName()
    GUICtrlSetBkColor($aInputFeatureName[$eBackground], _setThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetBkColor($aInputFeatureName[$eInput], _setThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetColor($aInputFeatureName[$eLabel], _setThemeColor($aColor[$eFont]))
    GUICtrlSetColor($aInputFeatureName[$eInput], _setThemeColor($aColor[$eFont]))
    _setBorderColor($aInputFeatureName, _setThemeColor($aColor[$eBorderInput]))
EndFunc

Func _applyThemeButtonOkay()
    GUICtrlSetBkColor($aButtonAdd[$eBackground], _setThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetBkColor($aButtonAdd[$eLabel], _setThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetColor($aButtonAdd[$eLabel], _setThemeColor($aColor[$eFont]))
    _setBorderColor($aButtonAdd, _setThemeColor($aColor[$eBorder]))
EndFunc

Func _themeToggle()
    If $bIsDarkModeActive Then
        GUICtrlSetData($aThemeIcon[$eLabel], Chr(82))
        GUICtrlSetFont($aThemeIcon[$eLabel], 17, 500, Default, 'WingDings')
        GUICtrlSetPos($aThemeIcon[$eLabel], $aThemeIcon[$eXPosition] + 10, $aThemeIcon[$eYPosition] + 1)

        $bIsDarkModeActive = False
    Else
        GUICtrlSetData($aThemeIcon[$eLabel], Chr(131))
        GUICtrlSetFont($aThemeIcon[$eLabel], 15, 500, Default, 'WingDings 2')
        GUICtrlSetPos($aThemeIcon[$eLabel], $aThemeIcon[$eXPosition] + 13, $aThemeIcon[$eYPosition] + 4)

        $bIsDarkModeActive = True
    EndIf
EndFunc

Func _setBorderColor($aControl, $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderTop], $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderRight], $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderBottom], $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderLeft], $vBorderColor)
EndFunc

Func _setThemeColor($vColor, $bShouldInvert = False)
    If Not $bShouldInvert Then Return $bIsDarkModeActive ? $vColor : _hexColorInvert($vColor)
    If $bShouldInvert     Then Return $bIsDarkModeActive ? _hexColorInvert($vColor) : $vColor
EndFunc

Func _hexColorInvert($vHexCode)
    Return '0x' & Hex (0xFFFFFF - $vHexCode, 6)
EndFunc
