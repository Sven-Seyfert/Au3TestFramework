Func _initializeGuiScroll()
    Local Const $iHorizontal = 0
    Local Const $iVertical   = 1

    _GUIScroll_Init($aGui[$eHandle], $iHorizontal, 1)
    _GUIScroll_Init($aGui[$eHandle], $iVertical, 1)
EndFunc

Func _waitForGuiEvent()
    GUISetState(@SW_SHOW, $aGui[$eHandle])

    While True
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                GUIDelete($aGui[$eHandle])
                _writeFile($sIncludeFileOfScenarioSteps, '; temporary dummy text')
                Exit

            Case $GUI_EVENT_PRIMARYUP
                _selectOrUnselectScenarioCheckboxes()

            Case $aCustomButtonRun[$eHandle]
                _executeScenarios()

            Case $aCustomButtonSelectAll[$eHandle]
                _selectAllScenarios()

            Case $aCustomButtonUnselectAll[$eHandle]
                _unselectAllScenarios()
        EndSwitch
    WEnd
EndFunc

Func _getScenarioCountOfTheFeatureFile($i, $iCount, $aTable)
    Local $iScenarioCounter = 1

    For $j = 1 To $iCount Step 1
        If ($i + $j < $iCount) Then
            Local $sFeatureFilePath     = $aTable[$i][3]
            Local $sNextFeatureFilePath = $aTable[$i + $j][3]

            If $sFeatureFilePath == $sNextFeatureFilePath Then
                $iScenarioCounter += 1
            EndIf
        EndIf
    Next

    Return $iScenarioCounter
EndFunc

Func _selectOrUnselectScenarioCheckboxes()
    Local $aTableOfCheckboxesDataBefore = $aTableOfCheckboxesData

    $aTableOfCheckboxesData = _setCheckboxesState($aTableOfCheckboxesData)

    Local $iCount = _getCount($aTableOfCheckboxesData)

    For $i = 0 To $iCount Step 1
        Local $iCheckboxStateBefore = $aTableOfCheckboxesDataBefore[$i][2]
        Local $iCheckboxState       = $aTableOfCheckboxesData[$i][2]

        If $iCheckboxStateBefore <> $iCheckboxState Then
            _selectScenarioCheckboxesIfFeatureIsChecked($i, $iCount, $aTableOfCheckboxesData)
            _unselectScenarioCheckboxesIfFeatureIsUnchecked($i, $iCount, $aTableOfCheckboxesData)
        EndIf
    Next
EndFunc

Func _setCheckboxesState($aTable)
    For $i = 0 To _getCount($aTable) Step 1
        Local $iCheckboxId = $aTable[$i][0]

        $aTable[$i][2] = GUICtrlRead($iCheckboxId)
    Next

    Return $aTable
EndFunc

Func _selectScenarioCheckboxesIfFeatureIsChecked($i, $iCount, $aTable, $iState = $GUI_CHECKED)
    Local $sCheckboxCategory = $aTable[$i][1]
    Local $iCheckboxState    = $aTable[$i][2]

    If $sCheckboxCategory == $sCheckboxLevelFeatureName And $iCheckboxState == $iState Then
        Local $iCounter = 1

        While ($i + $iCounter) < $iCount + 1 And $aTable[$i + $iCounter][1] <> $sCheckboxLevelFeatureName
            GUICtrlSetState($aTable[$i + $iCounter][0], $iState)
            $iCounter += 1
        WEnd
    EndIf

EndFunc

Func _unselectScenarioCheckboxesIfFeatureIsUnchecked($i, $iCount, $aTable)
    _selectScenarioCheckboxesIfFeatureIsChecked($i, $iCount, $aTable, $GUI_UNCHECKED)
EndFunc

Func _getSelectedScenarios($aTable)
    Local $aTableOfSelectedScenarios[0][5]

    For $i = 0 To _getCount($aTable) Step 1
        Local $iControlId        = $aTable[$i][0]
        Local $sCheckboxCategory = $aTable[$i][1]
        Local $iCheckboxState    = $aTable[$i][2]
        Local $sScenarioName     = $aTable[$i][3]
        Local $sFeatureFilePath  = $aTable[$i][4]

        If $sCheckboxCategory == $sCheckboxLevelScenarioName And $iCheckboxState == $GUI_CHECKED Then
            Local $iScenarioDurationControl = $iControlId - 1
            Local $sScenarioDuration   = GUICtrlRead($iControlId - 1)

            _ArrayAdd($aTableOfSelectedScenarios, $iControlId & '|' & $sScenarioName & '|' & $sFeatureFilePath & '|' & $iScenarioDurationControl & '|' & $sScenarioDuration)
        EndIf
    Next

    Return $aTableOfSelectedScenarios
EndFunc

Func _selectAllScenarios()
    For $i = 0 To _getCount($aTableOfCheckboxesData) Step 1
        GUICtrlSetState($aTableOfCheckboxesData[$i][0], $GUI_CHECKED)
    Next
EndFunc

Func _unselectAllScenarios()
    For $i = 0 To _getCount($aTableOfCheckboxesData) Step 1
        GUICtrlSetState($aTableOfCheckboxesData[$i][0], $GUI_UNCHECKED)
    Next
EndFunc
