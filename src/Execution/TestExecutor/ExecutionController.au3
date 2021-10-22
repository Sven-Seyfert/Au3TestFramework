Func _executeScenarios()
    $aTableOfCheckboxesData = _setCheckboxesState($aTableOfCheckboxesData)

    Local $aTableOfSelectedScenarios = _getSelectedScenarios($aTableOfCheckboxesData)

    If UBound($aTableOfSelectedScenarios) == 0 Then
        MsgBox(48, $aTexts[$eMessageTitleNothingChosen], $aTexts[$eMessageNoScenarioChosen])

        Return
    EndIf

    _ArrayDisplay($aTableOfSelectedScenarios, 2)

    _includeStepFiles()

    ;~ TODO
EndFunc

Func _includeStepFiles()
    Local $aStepFileList = _getListOfFiles('Steps', '*Steps.au3')

    If Not IsArray($aStepFileList) Then
        MsgBox(48, $aTexts[$eMessageTitleNoStepFiles], $aTexts[$eMessageNoStepFiles] & @CRLF & @CRLF & _
            'Folder:' & @CRLF & '*\Specification\Steps\')

        Return
    EndIf

    _writeFile($sIncludeFileOfScenarioSteps, '')

    For $i = 1 To _getCount($aStepFileList) Step 1
        _appendToFile($sIncludeFileOfScenarioSteps, '#include "' & $aStepFileList[$i] & '"' & @CRLF )
    Next
EndFunc
