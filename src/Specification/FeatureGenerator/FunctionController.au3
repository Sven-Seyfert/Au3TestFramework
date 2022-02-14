Func _CreateFeatureTemplateFile()
    Local $sFeatureName         = _GetFeatureName()
    Local $sFeatureFileTemplate = _GetFeatureFileTemplate($sFeatureName)

    Local Const $iStripAllSpaces = 8

    $sFeatureName = StringStripWS($sFeatureName, $iStripAllSpaces)

    If @Compiled Then
        _WriteFile('..\src\Specification\Features\' & $sFeatureName & '.feature', $sFeatureFileTemplate)
    EndIf

    If Not @Compiled Then
        _WriteFile('..\Features\' & $sFeatureName & '.feature', $sFeatureFileTemplate)
    EndIf

    _Exit($aGui[$eHandle])
EndFunc

Func _GetFeatureName()
    _ShowGui()

    AdlibRegister('_HoverActions', 150)

    Return _GetGuiInput()
EndFunc

Func _GetGuiInput()
    While True
        Switch GUIGetMsg()
            Case $aCloseIcon[$eBackground]
                _Exit($aGui[$eHandle])

            Case $aThemeIcon[$eBackground]
                _GuiApplyTheme()

            Case $aButtonAdd[$eBackground]
                Local $sInput = GUICtrlRead($aInputFeatureName[$eInput])
                ExitLoop
        EndSwitch
    WEnd

    Return _StringProper($sInput)
EndFunc

Func _GetFeatureFileTemplate($sFeatureName)
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

Func _WriteFile($sFile, $sText)
    Local Const $iWriteModeCreatePathUtf8 = 2 + 8 + 256
    Local $hFile = FileOpen($sFile, $iWriteModeCreatePathUtf8)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _Exit($hGui)
    AdlibUnRegister('_HoverActions')
    _GuiFadeOut($hGui)
    GUIDelete($hGui)

    Exit
EndFunc
