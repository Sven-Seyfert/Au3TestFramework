Func _InitializeGuiScroll()
    Local Const $iHorizontal = 0
    Local Const $iVertical   = 1

    _GUIScroll_Init($aGui[$eHandle], $iHorizontal, 1)
    _GUIScroll_Init($aGui[$eHandle], $iVertical, 1)
EndFunc

Func _WaitForGuiEvent()
    GUISetState(@SW_SHOW, $aGui[$eHandle])

    While True
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                GUIDelete($aGui[$eHandle])
                _WriteFile($sIncludeFileOfScenarioSteps, '; temporary dummy text')
                Exit

            Case $GUI_EVENT_PRIMARYUP
                _SelectOrUnselectScenarioCheckboxes()

            Case $aCustomButtonRun[$eHandle]
                _ExecuteScenarios()

            Case $aCustomButtonSelectAll[$eHandle]
                _SelectAllScenarios()

            Case $aCustomButtonUnselectAll[$eHandle]
                _UnselectAllScenarios()
        EndSwitch
    WEnd
EndFunc

Func _GetScenarioCountOfTheFeatureFile($i, $iCount, $aTable)
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

Func _SelectOrUnselectScenarioCheckboxes()
    Local $aTableOfCheckboxesDataBefore = $aTableOfCheckboxesData

    $aTableOfCheckboxesData = _SetCheckboxesState($aTableOfCheckboxesData)

    Local $iCount = _GetCount($aTableOfCheckboxesData)

    For $i = 0 To $iCount Step 1
        Local $iCheckboxStateBefore = $aTableOfCheckboxesDataBefore[$i][2]
        Local $iCheckboxState       = $aTableOfCheckboxesData[$i][2]

        If $iCheckboxStateBefore <> $iCheckboxState Then
            _SelectScenarioCheckboxesIfFeatureIsChecked($i, $iCount, $aTableOfCheckboxesData)
            _UnselectScenarioCheckboxesIfFeatureIsUnchecked($i, $iCount, $aTableOfCheckboxesData)
        EndIf
    Next
EndFunc

Func _SetCheckboxesState($aTable)
    For $i = 0 To _GetCount($aTable) Step 1
        Local $iCheckboxId = $aTable[$i][0]

        $aTable[$i][2] = GUICtrlRead($iCheckboxId)
    Next

    Return $aTable
EndFunc

Func _SelectScenarioCheckboxesIfFeatureIsChecked($i, $iCount, $aTable, $iState = $GUI_CHECKED)
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

Func _UnselectScenarioCheckboxesIfFeatureIsUnchecked($i, $iCount, $aTable)
    _SelectScenarioCheckboxesIfFeatureIsChecked($i, $iCount, $aTable, $GUI_UNCHECKED)
EndFunc

Func _GetSelectedScenarios($aTable)
    Local $aTableOfSelectedScenarios[0][5]

    For $i = 0 To _GetCount($aTable) Step 1
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

Func _SelectAllScenarios()
    For $i = 0 To _GetCount($aTableOfCheckboxesData) Step 1
        GUICtrlSetState($aTableOfCheckboxesData[$i][0], $GUI_CHECKED)
    Next
EndFunc

Func _UnselectAllScenarios()
    For $i = 0 To _GetCount($aTableOfCheckboxesData) Step 1
        GUICtrlSetState($aTableOfCheckboxesData[$i][0], $GUI_UNCHECKED)
    Next
EndFunc
