Func _ApplyThemeGui()
    GUISetBkColor(_SetThemeColor($aColor[$eBackground]), $aGui[$eHandle])
    _SetBorderColor($aGui, _SetThemeColor($aColor[$eBorder]))
EndFunc

Func _ApplyThemeCloseIcon()
    GUICtrlSetBkColor($aCloseIcon[$eBackground], _SetThemeColor($aColor[$eBackground]))
    GUICtrlSetBkColor($aCloseIcon[$eLabel], _SetThemeColor($aColor[$eBackground]))
    GUICtrlSetColor($aCloseIcon[$eLabel], _SetThemeColor($aColor[$eIcon]))
EndFunc

Func _ApplyThemeThemeIcon()
    GUICtrlSetBkColor($aThemeIcon[$eBackground], _SetThemeColor($aColor[$eBackground]))
    GUICtrlSetBkColor($aThemeIcon[$eLabel], _SetThemeColor($aColor[$eBackground]))
    GUICtrlSetColor($aThemeIcon[$eLabel], _SetThemeColor($aColor[$eIcon]))
EndFunc

Func _ApplyMoveThemeIcon()
    GUICtrlSetBkColor($aMoveIcon[$eBackground], _SetThemeColor($aColor[$eBackground]))
    GUICtrlSetBkColor($aMoveIcon[$eLabel], _SetThemeColor($aColor[$eBackground]))
    GUICtrlSetColor($aMoveIcon[$eLabel], _SetThemeColor($aColor[$eIcon]))
EndFunc

Func _ApplyThemeHeadline()
    GUICtrlSetColor($aHeadline[$eLabel], _SetThemeColor($aColor[$eFont]))
EndFunc

Func _ApplyThemeSubHeadline()
    GUICtrlSetColor($aSubHeadline[$eLabel], _SetThemeColor($aColor[$eFont]))
EndFunc

Func _ApplyThemeInputFeatureName()
    GUICtrlSetBkColor($aInputFeatureName[$eBackground], _SetThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetBkColor($aInputFeatureName[$eInput], _SetThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetColor($aInputFeatureName[$eLabel], _SetThemeColor($aColor[$eFont]))
    GUICtrlSetColor($aInputFeatureName[$eInput], _SetThemeColor($aColor[$eFont]))
    _SetBorderColor($aInputFeatureName, _SetThemeColor($aColor[$eBorderInput]))
EndFunc

Func _ApplyThemeButtonOkay()
    GUICtrlSetBkColor($aButtonAdd[$eBackground], _SetThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetBkColor($aButtonAdd[$eLabel], _SetThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetColor($aButtonAdd[$eLabel], _SetThemeColor($aColor[$eFont]))
    _SetBorderColor($aButtonAdd, _SetThemeColor($aColor[$eBorder]))
EndFunc

Func _ThemeToggle()
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

Func _SetBorderColor($aControl, $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderTop], $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderRight], $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderBottom], $vBorderColor)
    GUICtrlSetBkColor($aControl[$eBorderLeft], $vBorderColor)
EndFunc

Func _SetThemeColor($vColor, $bShouldInvert = False)
    If Not $bShouldInvert Then Return $bIsDarkModeActive ? $vColor : _HexColorInvert($vColor)
    If $bShouldInvert     Then Return $bIsDarkModeActive ? _HexColorInvert($vColor) : $vColor
EndFunc

Func _HexColorInvert($vHexCode)
    Return '0x' & Hex (0xFFFFFF - $vHexCode, 6)
EndFunc
