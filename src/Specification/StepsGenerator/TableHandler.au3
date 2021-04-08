Func _removeEmptyLinesFromList( $aList )
    _ArrayDelete( $aList, 0 )

    Local $sOnlySpacesOrTabsTillLineEndRegExPattern = '^\s+$'
    Local $iArrayCount = UBound( $aList ) - 1

    For $i = $iArrayCount To 0 Step - 1
        If $aList[$i] = '' Or StringRegExp( $aList[$i], $sOnlySpacesOrTabsTillLineEndRegExPattern, 0 ) Then
            _ArrayDelete( $aList, $i )
        EndIf
    Next

    Return $aList
EndFunc

Func _removeTagsFromList( $aList )
    Local $sTagsRegExPattern = '^\s+@|^@\w+'
    Local $iArrayCount = UBound( $aList ) - 1

    For $i = $iArrayCount To 0 Step - 1
        If StringRegExp( $aList[$i], $sTagsRegExPattern, 0 ) Then
            _ArrayDelete( $aList, $i )
        EndIf
    Next

    Return $aList
EndFunc

Func _removeDoubleWhitespacesFromList( $aList )
    Local $iArrayCount = UBound( $aList ) - 1
    Local Const $iLeadingTrailingAndDoubleWhitespaces = 7

    For $i = $iArrayCount To 0 Step - 1
        $aList[$i] = StringStripWS( $aList[$i], $iLeadingTrailingAndDoubleWhitespaces )
    Next

    Return $aList
EndFunc

Func _removeScenarioTitleFromList( $aList )
    Local $sScenarioTitleRegExPattern = 'Scenario:.+?$'
    Local $iArrayCount = UBound( $aList ) - 1

    For $i = $iArrayCount To 0 Step - 1
        If StringRegExp( $aList[$i], $sScenarioTitleRegExPattern, 0 ) Then
            _ArrayDelete( $aList, $i )
        EndIf
    Next

    Return $aList
EndFunc

Func _removeDuplicateSteps( $aList )
    $aList = _ArrayUnique( $aList )
    _ArrayDelete( $aList, 0 )
    $aList[0] = ''

    Return $aList
EndFunc

Func _removeDuplicateStepsFunctions( $aStepsFunctionsList )
    $aStepsFunctionsList = _ArrayUnique( $aStepsFunctionsList )
    _ArrayDelete( $aStepsFunctionsList, 0 )

    Return $aStepsFunctionsList
EndFunc
