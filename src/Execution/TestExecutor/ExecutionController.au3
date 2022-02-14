Func _ExecuteScenarios()
    $aTableOfCheckboxesData = _SetCheckboxesState($aTableOfCheckboxesData)

    Local $aTableOfSelectedScenarios = _GetSelectedScenarios($aTableOfCheckboxesData)

    If UBound($aTableOfSelectedScenarios) == 0 Then
        MsgBox(48, $aTexts[$eMessageTitleNothingChosen], $aTexts[$eMessageNoScenarioChosen])

        Return
    EndIf

    _ArrayDisplay($aTableOfSelectedScenarios, 2)

    _IncludeStepFiles()

    ;~ TODO
EndFunc

Func _IncludeStepFiles()
    Local $aStepFileList = _GetListOfFiles('Steps', '*Steps.au3')

    If Not IsArray($aStepFileList) Then
        MsgBox(48, $aTexts[$eMessageTitleNoStepFiles], $aTexts[$eMessageNoStepFiles] & @CRLF & @CRLF & _
            'Folder:' & @CRLF & '*\Specification\Steps\')

        Return
    EndIf

    _WriteFile($sIncludeFileOfScenarioSteps, '')

    For $i = 1 To _GetCount($aStepFileList) Step 1
        _AppendToFile($sIncludeFileOfScenarioSteps, '#include "' & $aStepFileList[$i] & '"' & @CRLF )
    Next
EndFunc
