Func _CreateGui()
    $aGui[$eHandle] = GUICreate($aGui[$eTitle], $aGui[$eWidth], $aGui[$eHeight], $aGui[$eXPosition], $aGui[$eYPosition], $aGui[$eStyle])
                      GUISetFont(Default, Default, Default, $aGui[$eFont])
EndFunc

Func _CreateDynamicGuiContent($aTable)
    ;~ _ArrayDisplay($aTable, 1)

    Local $iCount = _GetCount($aTable)
    Local $sLastFeatureName = Null
    Local $iY = 30

    For $i = 1 To $iCount Step 1
        Local $sFeatureFolderBreadcrumb = $aTable[$i][0]
        Local $sFeatureName             = $aTable[$i][1]
        Local $sScenarioName            = $aTable[$i][2]
        Local $sFeatureFilePath         = $aTable[$i][3]

        If $sFeatureName <> $sLastFeatureName Then
            $sLastFeatureName = $sFeatureName

            Local $iScenarioCounter = _GetScenarioCountOfTheFeatureFile($i, $iCount, $aTable)

            $iY += 15

            _CreateHorizontalLine($iY - 5)

            $iY += 5

            GUICtrlCreateLabel($aIcon[$eFolder], 14, $iY - 4, Default, Default)
            GUICtrlSetFont(-1, 12)
            GUICtrlCreateLabel($sFeatureFolderBreadcrumb, 32, $iY, Default, Default)

            $iY += 15

            $aCheckboxFeature[$eTitle]     = $sFeatureName & ' (' & $iScenarioCounter & ')'
            $aCheckboxFeature[$eYPosition] = $iY
            $aCheckboxFeature[$eHandle]    = GUICtrlCreateCheckbox($aCheckboxFeature[$eTitle], $aCheckboxFeature[$eXPosition], $aCheckboxFeature[$eYPosition], $aCheckboxFeature[$eWidth], $aCheckboxFeature[$eHeight])
                                             GUICtrlSetFont(-1, Default, 700)

            _SetHandCursor()
            _FillTableOfCheckboxesData($aCheckboxFeature[$eHandle], $sCheckboxLevelFeatureName, $sFeatureFilePath)

            $iY += 20
        EndIf

        Local $iNumber = Random(1, 3, 1)

        Switch $iNumber
            Case 1
                _CreateScenarioRunIndicator($aIcon[$eSuccess], $iY, $aColor[$eGreen])
                $iSuccessCounter += 1
            Case 2
                _CreateScenarioRunIndicator($aIcon[$eFail], $iY, $aColor[$eRed])
                $iFailureCounter += 1
            Case 3
                _CreateScenarioRunIndicator($aIcon[$eNotExecuted], $iY, $aColor[$eBlue])
                $iNoExecutionCounter += 1
        EndSwitch

        _CreateScenarioDuration($i, $iY)

        $aCheckboxScenario[$eTitle]     = $sScenarioName
        $aCheckboxScenario[$eYPosition] = $iY
        $aCheckboxScenario[$eHandle]    = GUICtrlCreateCheckbox($aCheckboxScenario[$eTitle], $aCheckboxScenario[$eXPosition], $aCheckboxScenario[$eYPosition], $aCheckboxScenario[$eWidth], $aCheckboxScenario[$eHeight])

        _SetHandCursor()
        _FillTableOfCheckboxesData($aCheckboxScenario[$eHandle], $sCheckboxLevelScenarioName, $sFeatureFilePath)

        $iY += 20
    Next

    _CreateHorizontalLine($iY + 10)

    GUICtrlCreateLabel('', 0, $iY + 300, 0, 0) ; this is only for a margin bottom purpose
EndFunc

Func _CreateButtonBar()
                                          GUICtrlCreateLabel('', 0, 0, $aGui[$eWidth] - 18, 41)
                                          GUICtrlSetBkColor(-1, $aColor[$eGray])
                                          GUICtrlSetState(-1, $GUI_DISABLE)

    $aCustomButtonRun[$eHandle]         = GUICtrlCreateLabel($aCustomButtonRun[$eTitle], $aCustomButtonRun[$eXPosition], $aCustomButtonRun[$eYPosition], $aCustomButtonRun[$eWidth], $aCustomButtonRun[$eHeight])
                                          _SetButtonStyle(16)

    $aCustomButtonSelectAll[$eHandle]   = GUICtrlCreateLabel($aCustomButtonSelectAll[$eTitle], $aCustomButtonSelectAll[$eXPosition], $aCustomButtonSelectAll[$eYPosition], $aCustomButtonSelectAll[$eWidth], $aCustomButtonSelectAll[$eHeight])
                                          _SetButtonStyle(12)

    $aCustomButtonUnselectAll[$eHandle] = GUICtrlCreateLabel($aCustomButtonUnselectAll[$eTitle], $aCustomButtonUnselectAll[$eXPosition], $aCustomButtonUnselectAll[$eYPosition], $aCustomButtonUnselectAll[$eWidth], $aCustomButtonUnselectAll[$eHeight])
                                          _SetButtonStyle(23)

    _CreateExecutionIndicator($aIcon[$eSum], $iCount, 130, 0x000000)
    _CreateExecutionIndicator($aIcon[$eSuccess], $iSuccessCounter, 180, $aColor[$eGreen])
    _CreateExecutionIndicator($aIcon[$eFail], $iFailureCounter, 230, $aColor[$eRed])
    _CreateExecutionIndicator($aIcon[$eNotExecuted], $iNoExecutionCounter, 280, $aColor[$eBlue])
EndFunc

Func _FillTableOfCheckboxesData($iControlId, $sCheckboxLevelName, $sFeatureFilePath)
    Local $sScenarioName = GUICtrlRead($iControlId, 1)
    _ArrayAdd($aTableOfCheckboxesData, $iControlId & '|' & $sCheckboxLevelName & '|' & $GUI_UNCHECKED & '|' & $sScenarioName & '|' & $sFeatureFilePath)
EndFunc

Func _CreateHorizontalLine($iY)
    GUICtrlCreateLabel('', 14, $iY, $aGui[$eWidth] - 45, 1)
    GUICtrlSetBkColor(-1, $aColor[$eGray])
EndFunc

Func _CreateScenarioRunIndicator($sSign, $iY, $vColor)
    GUICtrlCreateLabel($sSign, 32, $iY + 2)
    GUICtrlSetFont(-1, 11)
    GUICtrlSetColor(-1, $vColor)
EndFunc

Func _CreateScenarioDuration($i, $iY)
    GUICtrlCreateLabel($aIcon[$eClock], $aGui[$eWidth] - 96, $iY + 2, Default, Default)
    GUICtrlSetFont(-1, 11)

    GUICtrlCreateLabel($i & ' sec', $aGui[$eWidth] - 80, $iY + 4, Default, Default)
EndFunc

Func _SetButtonStyle($iFontSize)
    GUICtrlSetFont(-1, $iFontSize)
    GUICtrlSetBkColor(-1, $aColor[$eGray])

    _SetHandCursor()
EndFunc

Func _SetHandCursor()
    GUICtrlSetCursor(-1, 0)
EndFunc

Func _CreateExecutionIndicator($sSign, $sText, $iX, $vColor)
    GUICtrlCreateLabel($sSign, $iX, 14)
    GUICtrlSetFont(-1, 11)
    GUICtrlSetColor(-1, $vColor)
    GUICtrlSetBkColor(-1, $aColor[$eGray])

    GUICtrlCreateLabel($sText, $iX + 16, 16, 40)
    GUICtrlSetBkColor(-1, $aColor[$eGray])
EndFunc
