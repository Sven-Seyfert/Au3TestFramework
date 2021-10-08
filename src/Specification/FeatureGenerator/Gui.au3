Func _showGui()
    _gui()
    _guiCloseIcon()
    _guiThemeIcon()
    _guiMoveIcon()
    _guiHeadline()
    _guiSubHeadline()
    _guiInputFeatureName()
    _guiButtonOkay()

    _guiApplyTheme()

    GUISetState(@SW_SHOW, $aGui[$eHandle])

    _guiFadeIn($aGui[$eHandle])
EndFunc

Func _gui()
    $aGui[$eHandle] = GUICreate('', $aGui[$eWidth], $aGui[$eHeight], $aGui[$eXPosition], $aGui[$eXPosition], $WS_POPUP, $WS_EX_TOPMOST)
    GUISetFont(Default, 400, Default, 'Segoe UI')

    $aGui[$eBorderTop]    = GUICtrlCreateLabel('', 0, 0, $aGui[$eWidth], $aGui[$eBorderSize])
    $aGui[$eBorderRight]  = GUICtrlCreateLabel('', 0 + $aGui[$eWidth] - $aGui[$eBorderSize], 0, $aGui[$eBorderSize], $aGui[$eHeight])
    $aGui[$eBorderBottom] = GUICtrlCreateLabel('', 0, 0 + $aGui[$eHeight] - $aGui[$eBorderSize], $aGui[$eWidth], $aGui[$eBorderSize])
    $aGui[$eBorderLeft]   = GUICtrlCreateLabel('', 0, 0, $aGui[$eBorderSize], $aGui[$eHeight])
EndFunc

Func _guiCloseIcon()
    $aCloseIcon[$eBackground] = GUICtrlCreateLabel('', $aCloseIcon[$eXPosition], $aCloseIcon[$eYPosition], $aCloseIcon[$eWidth], $aCloseIcon[$eHeight])
    $aCloseIcon[$eLabel]      = GUICtrlCreateLabel($aCloseIcon[$eLabelText], $aCloseIcon[$eXPosition] + 11, $aCloseIcon[$eYPosition] + 4, $aCloseIcon[$eWidth] / 2)

    Local Const $iCursorIdHand = 0

    GUICtrlSetCursor($aCloseIcon[$eBackground], $iCursorIdHand)
    GUICtrlSetFont($aCloseIcon[$eLabel], 15, 500, Default, 'WingDings 2')
EndFunc

Func _guiThemeIcon()
    $aThemeIcon[$eBackground] = GUICtrlCreateLabel('', $aThemeIcon[$eXPosition], $aThemeIcon[$eYPosition], $aThemeIcon[$eWidth], $aThemeIcon[$eHeight])
    $aThemeIcon[$eLabel]      = GUICtrlCreateLabel($aThemeIcon[$eLabelText], $aThemeIcon[$eXPosition] + 11, $aThemeIcon[$eYPosition] + 1, $aThemeIcon[$eWidth] / 2)

    Local Const $iCursorIdHand = 0

    GUICtrlSetCursor($aThemeIcon[$eBackground], $iCursorIdHand)
EndFunc

Func _guiMoveIcon()
    $aMoveIcon[$eBackground] = GUICtrlCreateLabel('', $aMoveIcon[$eXPosition], $aMoveIcon[$eYPosition], $aMoveIcon[$eWidth], $aMoveIcon[$eHeight])
    $aMoveIcon[$eLabel]      = GUICtrlCreateLabel($aMoveIcon[$eLabelText], $aMoveIcon[$eXPosition] + 11, $aMoveIcon[$eYPosition] + 3, $aMoveIcon[$eWidth] / 2)
    GUICtrlSetStyle($aMoveIcon[$eBackground], -1, $GUI_WS_EX_PARENTDRAG)

    Local Const $iCursorIdHand = 9

    GUICtrlSetCursor($aMoveIcon[$eBackground], $iCursorIdHand)
    GUICtrlSetFont($aMoveIcon[$eLabel], 15, 600, Default, 'WingDings')
EndFunc

Func _guiHeadline()
    $aHeadline[$eLabel] = GUICtrlCreateLabel($aHeadline[$eLabelText], $aHeadline[$eXPosition], $aHeadline[$eYPosition], $aHeadline[$eWidth], $aHeadline[$eHeight])
    GUICtrlSetFont($aHeadline[$eLabel], 20, 600)
EndFunc

Func _guiSubHeadline()
    $aSubHeadline[$eLabel] = GUICtrlCreateLabel($aSubHeadline[$eLabelText], $aSubHeadline[$eXPosition], $aSubHeadline[$eYPosition], $aSubHeadline[$eWidth], $aSubHeadline[$eHeight])
    GUICtrlSetFont($aSubHeadline[$eLabel], 14, 400)
EndFunc

Func _guiInputFeatureName()
    Local $iFontSize  = 9

    $aInputFeatureName[$eLabel]      = GUICtrlCreateLabel($aInputFeatureName[$eLabelText], $aInputFeatureName[$eXPosition], $aInputFeatureName[$eYPosition], $aInputFeatureName[$eWidth], $aInputFeatureName[$eHeight])
    $aInputFeatureName[$eBackground] = GUICtrlCreateLabel('', $aInputFeatureName[$eXPosition], $aInputFeatureName[$eYPosition] + 25, $aInputFeatureName[$eWidth], $aInputFeatureName[$eHeight] - 10)
    $aInputFeatureName[$eInput]      = GUICtrlCreateInput(_StringProper('Example ' & _createRandomText(7)), $aInputFeatureName[$eXPosition] + 5, $aInputFeatureName[$eYPosition] + 35, $aInputFeatureName[$eWidth] - 30, $aInputFeatureName[$eHeight] - 30, -1, $WS_EX_TOOLWINDOW)

    GUICtrlSetFont($aInputFeatureName[$eLabel], $iFontSize)
    GUICtrlSetFont($aInputFeatureName[$eInput], $iFontSize + 2)

    $aInputFeatureName[$eBorderTop]    = GUICtrlCreateLabel('', $aInputFeatureName[$eXPosition], $aInputFeatureName[$eYPosition] + 25, $aInputFeatureName[$eWidth], $aGui[$eBorderSize])
    $aInputFeatureName[$eBorderRight]  = GUICtrlCreateLabel('', $aInputFeatureName[$eXPosition] + $aInputFeatureName[$eWidth] - $aGui[$eBorderSize], $aInputFeatureName[$eYPosition] + 25, $aGui[$eBorderSize], $aInputFeatureName[$eHeight] - 10)
    $aInputFeatureName[$eBorderBottom] = GUICtrlCreateLabel('', $aInputFeatureName[$eXPosition], $aInputFeatureName[$eYPosition] + 25 + $aInputFeatureName[$eHeight] - 10 - $aGui[$eBorderSize], $aInputFeatureName[$eWidth], $aGui[$eBorderSize])
    $aInputFeatureName[$eBorderLeft]   = GUICtrlCreateLabel('', $aInputFeatureName[$eXPosition], $aInputFeatureName[$eYPosition] + 25, $aGui[$eBorderSize], $aInputFeatureName[$eHeight] - 10)

    _setControlFocusWithoutSelectedText($aInputFeatureName[$eInput])
EndFunc

Func _guiButtonOkay()
    $aButtonOkay[$eBackground] = GUICtrlCreateLabel('', $aButtonOkay[$eXPosition], $aButtonOkay[$eYPosition], $aButtonOkay[$eWidth], $aButtonOkay[$eHeight])
    $aButtonOkay[$eLabel]      = GUICtrlCreateLabel('Add', $aButtonOkay[$eXPosition] + 40, $aButtonOkay[$eYPosition] + 6, Default, Default)

    Local Const $iCursorIdHand = 0

    GUICtrlSetCursor($aButtonOkay[$eBackground], $iCursorIdHand)
    GUICtrlSetFont($aButtonOkay[$eLabel], 11)

    $aButtonOkay[$eBorderTop]    = GUICtrlCreateLabel('', $aButtonOkay[$eXPosition], $aButtonOkay[$eYPosition], $aButtonOkay[$eWidth], $aGui[$eBorderSize])
    $aButtonOkay[$eBorderRight]  = GUICtrlCreateLabel('', $aButtonOkay[$eXPosition] + $aButtonOkay[$eWidth] - $aGui[$eBorderSize], $aButtonOkay[$eYPosition], $aGui[$eBorderSize], $aButtonOkay[$eHeight])
    $aButtonOkay[$eBorderBottom] = GUICtrlCreateLabel('', $aButtonOkay[$eXPosition], $aButtonOkay[$eYPosition] + $aButtonOkay[$eHeight] - $aGui[$eBorderSize], $aButtonOkay[$eWidth], $aGui[$eBorderSize])
    $aButtonOkay[$eBorderLeft]   = GUICtrlCreateLabel('', $aButtonOkay[$eXPosition], $aButtonOkay[$eYPosition], $aGui[$eBorderSize], $aButtonOkay[$eHeight])
EndFunc

Func _guiApplyTheme()
    _applyThemeGui()
    _applyThemeCloseIcon()
    _applyThemeThemeIcon()
    _applyMoveThemeIcon()
    _applyThemeHeadline()
    _applyThemeSubHeadline()
    _applyThemeInputFeatureName()
    _applyThemeButtonOkay()
    _themeToggle()
EndFunc

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
    GUICtrlSetBkColor($aButtonOkay[$eBackground], _setThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetBkColor($aButtonOkay[$eLabel], _setThemeColor($aColor[$eBackgroundInput]))
    GUICtrlSetColor($aButtonOkay[$eLabel], _setThemeColor($aColor[$eFont]))
    _setBorderColor($aButtonOkay, _setThemeColor($aColor[$eBorder]))
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
