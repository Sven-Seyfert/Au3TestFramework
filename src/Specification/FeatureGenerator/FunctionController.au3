Func _createFeatureTemplateFile()
    Local $sFeatureName         = _getFeatureName()
    Local $sFeatureFileTemplate = _getFeatureFileTemplate($sFeatureName)

    Local Const $iStripAllSpaces = 8

    $sFeatureName = StringStripWS($sFeatureName, $iStripAllSpaces)

    If @Compiled Then
        _writeFile('..\src\Specification\Features\' & $sFeatureName & '.feature', $sFeatureFileTemplate)
    EndIf

    If Not @Compiled Then
        _writeFile('..\Features\' & $sFeatureName & '.feature', $sFeatureFileTemplate)
    EndIf

    _exit($aGui[$eHandle])
EndFunc

Func _getFeatureName()
    _showGui()

    AdlibRegister('_hoverActions', 150)

    Return _getGuiInput()
EndFunc

Func _getGuiInput()
    While True
        Switch GUIGetMsg()
            Case $aCloseIcon[$eBackground]
                _exit($aGui[$eHandle])

            Case $aThemeIcon[$eBackground]
                _guiApplyTheme()

            Case $aButtonAdd[$eBackground]
                Local $sInput = GUICtrlRead($aInputFeatureName[$eInput])
                ExitLoop
        EndSwitch
    WEnd

    Return _StringProper($sInput)
EndFunc

Func _getFeatureFileTemplate($sFeatureName)
    Return _
        'Feature: ' & $sFeatureName & @CRLF & _
        '    As Software Test Engineer,' & @CRLF & _
        '    I want to test the "' & $sFeatureName & '" actions and their behavior,' & @CRLF & _
        '    for the benefit to ensure a valid, automatically verified and stable functionality.' & @CRLF & _
        @CRLF & _
        @CRLF & _
        @CRLF & _
        'Background:' & @CRLF & _
        '    Given is a specific state' & @CRLF & _
        '    When I do a specific action as precondition' & @CRLF & _
        @CRLF & _
        @CRLF & _
        @CRLF & _
        '@tag' & @CRLF & _
        'Scenario: Login works' & @CRLF & _
        '    Given I am on page ''https://website.com/login''' & @CRLF & _
        '    When I login with username and password' & @CRLF & _
        @CRLF & _
        '    | username     | password        |' & @CRLF & _
        '    | Makenna_OKon | IcI3g07uif3dH8x |' & @CRLF & _
        @CRLF & _
        '    Then the login was successful'
EndFunc

Func _writeFile($sFile, $sText)
    Local Const $iWriteModeCreatePathUtf8 = 2 + 8 + 256
    Local $hFile = FileOpen($sFile, $iWriteModeCreatePathUtf8)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _exit($hGui)
    AdlibUnRegister('_hoverActions')
    _guiFadeOut($hGui)
    GUIDelete($hGui)

    Exit
EndFunc
