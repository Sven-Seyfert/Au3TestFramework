Func _getCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _removeEmptyLinesFromList($aList)
    _ArrayDelete($aList, 0)

    Local $sOnlySpacesOrTabsTillLineEndRegExPattern = '^\s+$'

    For $i = _getCount($aList) To 0 Step - 1
        If $aList[$i] = '' Or StringRegExp($aList[$i], $sOnlySpacesOrTabsTillLineEndRegExPattern, 0) Then
            _ArrayDelete($aList, $i)
        EndIf
    Next

    Return $aList
EndFunc

Func _removeTagsFromList($aList)
    Local $sTagsRegExPattern = '^\s+@|^@\w+'

    For $i = _getCount($aList) To 0 Step - 1
        If StringRegExp($aList[$i], $sTagsRegExPattern, 0) Then
            _ArrayDelete($aList, $i)
        EndIf
    Next

    Return $aList
EndFunc

Func _removeDoubleWhitespacesFromList($aList)
    Local Const $iLeadingTrailingAndDoubleWhitespaces = 7

    For $i = _getCount($aList) To 0 Step - 1
        $aList[$i] = StringStripWS($aList[$i], $iLeadingTrailingAndDoubleWhitespaces)
    Next

    Return $aList
EndFunc

Func _removeScenarioTitleFromList($aList)
    Local $sScenarioTitleRegExPattern = 'Scenario:.+?$'

    For $i = _getCount($aList) To 0 Step - 1
        If StringRegExp($aList[$i], $sScenarioTitleRegExPattern, 0) Then
            _ArrayDelete($aList, $i)
        EndIf
    Next

    Return $aList
EndFunc

Func _removeDuplicateSteps($aList)
    $aList = _ArrayUnique($aList)
    _ArrayDelete($aList, 0)
    $aList[0] = ''

    Return $aList
EndFunc

Func _removeDuplicateStepsFunctions($aList)
    $aList = _ArrayUnique($aList)
    _ArrayDelete($aList, 0)

    Return $aList
EndFunc
