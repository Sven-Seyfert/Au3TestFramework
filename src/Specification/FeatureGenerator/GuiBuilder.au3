Func _showGui()
    _gui()
    _guiCloseIcon()
    _guiThemeIcon()
    _guiMoveIcon()
    _guiHeadline()
    _guiSubHeadline()
    _guiInputFeatureName()
    _guiButtonAdd()

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

Func _guiButtonAdd()
    $aButtonAdd[$eBackground] = GUICtrlCreateLabel('', $aButtonAdd[$eXPosition], $aButtonAdd[$eYPosition], $aButtonAdd[$eWidth], $aButtonAdd[$eHeight])
    $aButtonAdd[$eLabel]      = GUICtrlCreateLabel($aTexts[$eButtonAdd], $aButtonAdd[$eXPosition] + 40, $aButtonAdd[$eYPosition] + 6, Default, Default)

    Local Const $iCursorIdHand = 0

    GUICtrlSetCursor($aButtonAdd[$eBackground], $iCursorIdHand)
    GUICtrlSetFont($aButtonAdd[$eLabel], 11)

    $aButtonAdd[$eBorderTop]    = GUICtrlCreateLabel('', $aButtonAdd[$eXPosition], $aButtonAdd[$eYPosition], $aButtonAdd[$eWidth], $aGui[$eBorderSize])
    $aButtonAdd[$eBorderRight]  = GUICtrlCreateLabel('', $aButtonAdd[$eXPosition] + $aButtonAdd[$eWidth] - $aGui[$eBorderSize], $aButtonAdd[$eYPosition], $aGui[$eBorderSize], $aButtonAdd[$eHeight])
    $aButtonAdd[$eBorderBottom] = GUICtrlCreateLabel('', $aButtonAdd[$eXPosition], $aButtonAdd[$eYPosition] + $aButtonAdd[$eHeight] - $aGui[$eBorderSize], $aButtonAdd[$eWidth], $aGui[$eBorderSize])
    $aButtonAdd[$eBorderLeft]   = GUICtrlCreateLabel('', $aButtonAdd[$eXPosition], $aButtonAdd[$eYPosition], $aGui[$eBorderSize], $aButtonAdd[$eHeight])
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
