Func _GetCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _RemoveEmptyLinesFromList($aList)
    _ArrayDelete($aList, 0)

    Local $sOnlySpacesOrTabsTillLineEndRegExPattern = '^\s+$'

    For $i = _GetCount($aList) To 0 Step - 1
        If $aList[$i] = '' Or StringRegExp($aList[$i], $sOnlySpacesOrTabsTillLineEndRegExPattern, 0) Then
            _ArrayDelete($aList, $i)
        EndIf
    Next

    Return $aList
EndFunc

Func _RemoveTagsFromList($aList)
    Local $sTagsRegExPattern = '^\s+@|^@\w+'

    For $i = _GetCount($aList) To 0 Step - 1
        If StringRegExp($aList[$i], $sTagsRegExPattern, 0) Then
            _ArrayDelete($aList, $i)
        EndIf
    Next

    Return $aList
EndFunc

Func _RemoveDoubleWhitespacesFromList($aList)
    Local Const $iLeadingTrailingAndDoubleWhitespaces = 7

    For $i = _GetCount($aList) To 0 Step - 1
        $aList[$i] = StringStripWS($aList[$i], $iLeadingTrailingAndDoubleWhitespaces)
    Next

    Return $aList
EndFunc

Func _RemoveScenarioTitleFromList($aList)
    Local $sScenarioTitleRegExPattern = 'Scenario:.+?$'

    For $i = _GetCount($aList) To 0 Step - 1
        If StringRegExp($aList[$i], $sScenarioTitleRegExPattern, 0) Then
            _ArrayDelete($aList, $i)
        EndIf
    Next

    Return $aList
EndFunc

Func _RemoveDuplicateSteps($aList)
    $aList = _ArrayUnique($aList)
    _ArrayDelete($aList, 0)
    $aList[0] = ''

    Return $aList
EndFunc

Func _RemoveDuplicateStepsFunctions($aList)
    $aList = _ArrayUnique($aList)
    _ArrayDelete($aList, 0)

    Return $aList
EndFunc
