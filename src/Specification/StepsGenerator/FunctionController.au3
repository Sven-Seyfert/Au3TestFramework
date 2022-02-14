Func _CreateFilesWithStepsWrapperFunctions()
    Local $aFeatureFileList = _GetListOfFiles('Features', '.feature')

    If Not IsArray($aFeatureFileList) Then
        MsgBox(48, $aTexts[$eMessageTitleNote], $aTexts[$eMessageNoFeatureFileFound] & @CRLF & @CRLF & _
            'Folder:' & @CRLF & '*\Features\')

        Return False
    EndIf

    For $i = 1 To _GetCount($aFeatureFileList) Step 1
        Local $sFeatureFileContent = _GetFileContent($aFeatureFileList[$i])
        Local $sEndOfFileMark      = @CRLF & 'EOF'
        Local $aAllStepsList       = _GetAllStepsOfFeature($sFeatureFileContent & $sEndOfFileMark)

        If Not IsArray($aAllStepsList) And $aAllStepsList == -1 Then
            MsgBox(48, $aTexts[$eMessageTitleWrongStructure], $aTexts[$eMessageWrongStructure] & @CRLF & @CRLF & _
                'File:' & @CRLF & $aFeatureFileList[$i])
            ContinueLoop
        EndIf

        Local $aStepsFunctionsList = _GetStepsFunctions($aAllStepsList)

        If Not IsArray($aStepsFunctionsList) Then
            MsgBox(48, $aTexts[$eMessageTitleInvalidSingleQuoteCount], $aTexts[$eMessageInvalidSingleQuoteCount] & @CRLF & @CRLF & _
                'File:' & @CRLF & $aFeatureFileList[$i] & @CRLF & @CRLF & _
                'Scenario Step:' & @CRLF & $aStepsFunctionsList)
            ContinueLoop
        EndIf

        $aStepsFunctionsList = _AddTableParameterForFunctions($aStepsFunctionsList)

        _WriteStepsWrapperFunctionFile($aFeatureFileList[$i], $aStepsFunctionsList)
    Next
EndFunc

Func _GetListOfFiles($sFolder, $sFileExtension)
    If @Compiled Then
        Local $sFilePath = _PathFull('..\src\Specification\' & $sFolder & '\')
    EndIf

    If Not @Compiled Then
        Local $sFilePath = _PathFull('..\' & $sFolder & '\')
    EndIf

    Local Const $iOnlyFiles    = 1
    Local Const $iRecursive    = 1
    Local Const $iSortAsc      = 1
    Local Const $bAbsolutePath = 2

    Return _FileListToArrayRec($sFilePath, '*' & $sFileExtension, $iOnlyFiles, $iRecursive, $iSortAsc, $bAbsolutePath)
EndFunc

Func _GetAllStepsOfFeature($sFeatureFileContent)
    Local $aStepsList = _CreateStepList($sFeatureFileContent)

    If $aStepsList == -1 Then
        Return -1
    EndIf

    Local $aAllStepsList[1]

    If IsArray($aStepsList) Then
        Local Const $iEntireDelimiter = 1

        For $i = 1 To _GetCount($aStepsList) Step 1
            Local $aList = StringSplit($aStepsList[$i], @CRLF, $iEntireDelimiter)
            $aList = _RemoveEmptyLinesFromList($aList)
            $aList = _RemoveTagsFromList($aList)
            $aList = _RemoveDoubleWhitespacesFromList($aList)
            $aList = _RemoveScenarioTitleFromList($aList)

            _ArrayConcatenate($aAllStepsList, $aList)
        Next

        Return _RemoveDuplicateSteps($aAllStepsList)
    EndIf
EndFunc

Func _CreateStepList($sFeatureFileContent)
    Local $sBackgroundStepsRegExPattern = '(?s)Background:(.*?)Scenario'
    Local $sScenarioStepsRegExPattern   = '(?s)Scenario:.+?\r\n(.*?)EOF'

    Local $aBackgroundSteps = StringRegExp($sFeatureFileContent, $sBackgroundStepsRegExPattern, 3)
    Local $aScenarioSteps   = StringRegExp($sFeatureFileContent, $sScenarioStepsRegExPattern, 3)

    Local $aStepsList[1]

    If IsArray($aBackgroundSteps) Then
        If UBound($aBackgroundSteps) > 1 Then
            Return -1
        EndIf

        _ArrayConcatenate($aStepsList, $aBackgroundSteps)
    EndIf

    If IsArray($aScenarioSteps) Then
        _ArrayConcatenate($aStepsList, $aScenarioSteps)
    EndIf

    Return $aStepsList
EndFunc

Func _GetStepsFunctions($aAllStepsList)
    _ArrayDelete($aAllStepsList, 0)

    Local $iAllStepsListCount = _GetCount($aAllStepsList)
    Local $aStepsFunctionsList[$iAllStepsListCount + 1]

    For $j = 0 To $iAllStepsListCount Step 1
        If _IsThereAOddInvalidSingleQuoteSignCount($aAllStepsList[$j]) Then
            Return $aAllStepsList[$j]
        EndIf

        Local $sStepAttributeName   = _CreateStepAttributeName($aAllStepsList[$j])
        Local $sStepWrapperFunction = _CreateStepFunction($aAllStepsList[$j])

        $aStepsFunctionsList[$j] = '; [' & $sStepAttributeName & ']' & @CRLF & $sStepWrapperFunction & @CRLF & @CRLF
    Next

    Return _RemoveDuplicateStepsFunctions($aStepsFunctionsList)
EndFunc

Func _IsThereAOddInvalidSingleQuoteSignCount($sStepName)
    StringReplace($sStepName, "'", '')
    Local $iReplacementCount = @extended

    Return _IsNumberOdd($iReplacementCount) And StringLeft($sStepName, 1) <> '|'
EndFunc

Func _IsNumberOdd($iNumber)
    Return (Mod($iNumber, 2) <> 0) ? True : False
EndFunc

Func _CreateStepAttributeName($sStepName)
    Local $sParameterRegExPattern       = "'.*?'"
    Local $sParameterStringToBeReplaced = "'(.*)'"

    Return StringRegExpReplace($sStepName, $sParameterRegExPattern, $sParameterStringToBeReplaced)
EndFunc

Func _CreateStepFunction($sStepName)
    Local $sParameterRegExPattern = "'.*?'"
    Local $aMatchParameterList    = StringRegExp($sStepName, $sParameterRegExPattern, 3)
    Local $iParameterCount        = UBound($aMatchParameterList)

    $sStepName = _CreateStepAttributeName($sStepName)
    $sStepName = _ReformatStepName($sStepName)
    $sStepName = _SetFirstCharacterOfStringToLower($sStepName) & '('
    $sStepName = _AddParametersForFunction($iParameterCount, $sStepName)

    Local $sMessageBox = 'MsgBox(48, ''Your code pending'', ''_' & $sStepName & ''')'

    Return 'Func _' & $sStepName & @CRLF & _StringRepeat(' ', 4) & $sMessageBox & @CRLF & 'EndFunc'
EndFunc

Func _ReformatStepName($sStepName)
    Local $sParameterStringToBeReplaced = "'(.*)'"

    Local Const $iStripDoubleWhitespaces = 4
    Local Const $iStripAllWhitespaces    = 8

    $sStepName = StringReplace($sStepName, $sParameterStringToBeReplaced, '')
    $sStepName = StringStripWS($sStepName, $iStripDoubleWhitespaces)
    $sStepName = _StringProper($sStepName)

    Return StringStripWS($sStepName, $iStripAllWhitespaces)
EndFunc

Func _SetFirstCharacterOfStringToLower($sString)
    Local $sFirstCharacterAsLowerCase   = StringLower(StringLeft($sString, 1))
    Local $sStringWithoutFirstCharacter = StringTrimLeft($sString, 1)

    Return $sFirstCharacterAsLowerCase & $sStringWithoutFirstCharacter
EndFunc

Func _AddParametersForFunction($iParameterCount, $sStepName)
    For $i = 1 To $iParameterCount Step 1
        $sStepName &= '$sParam' & $i & ', '
    Next

    Return ($iParameterCount == 0) ? ($sStepName & ')') : (StringTrimRight($sStepName, 2) & ')')
EndFunc

Func _AddTableParameterForFunctions($aStepsFunctionsList)
    Local $bIsTable = False

    For $i = _GetCount($aStepsFunctionsList) To 1 Step - 1
        If StringInStr($aStepsFunctionsList[$i], '; [|', 2) <> 0 Then
            _ArrayDelete($aStepsFunctionsList, $i)
            $bIsTable = True
        Else
            If $bIsTable Then
                Local $sParamsRegExPattern = '(\$sParam\d+)\)'
                Local $sRegExReplace       = '$1, $aTable)'

                $aStepsFunctionsList[$i] = StringRegExpReplace($aStepsFunctionsList[$i], $sParamsRegExPattern, $sRegExReplace)
                Local $iReplacementCount = @extended

                If $iReplacementCount == 0 Then
                    $aStepsFunctionsList[$i] = StringReplace($aStepsFunctionsList[$i], '()', '($aTable)')
                EndIf
            EndIf

            $bIsTable = False
        EndIf
    Next

    Return $aStepsFunctionsList
EndFunc

Func _WriteStepsWrapperFunctionFile($sFile, $aStepsFunctionsList)
    Local $sStepFile = StringReplace($sFile, '\Features\', '\Steps\')
          $sStepFile = StringReplace($sStepFile, '.feature', 'Steps.au3')

    Local $iStepsFunctionListCount = _GetCount($aStepsFunctionsList)

    For $i = 0 To $iStepsFunctionListCount Step 1
        Local $sStepsAttributeNameRegExPattern       = '; (\[.+?\])'
        Local $sCurrentStepAttributeName             = StringRegExp($aStepsFunctionsList[$i], $sStepsAttributeNameRegExPattern, 3)[0]
        Local $aTableOfAllScenarioStepAttributeNames = _GetAllScenarioStepAttributeNames()

        Local $iFoundResult = _ArraySearch($aTableOfAllScenarioStepAttributeNames, $sCurrentStepAttributeName)
        Local $iStepFunctionDoesNotExistAlready = -1

        If $iFoundResult == $iStepFunctionDoesNotExistAlready Then
            _AppendToFile($sStepFile, $aStepsFunctionsList[$i])
        EndIf
    Next
EndFunc

Func _CheckForDuplicateScenarioSteps()
    Local $aTableOfAllScenarioStepAttributeNames = _GetAllScenarioStepAttributeNames()
    Local $aTableOfDuplicateScenarioSteps        = _GetDuplicateScenarioSteps($aTableOfAllScenarioStepAttributeNames)

    If UBound($aTableOfDuplicateScenarioSteps) > 0 Then
        Local $sDuplicateInformation = 'Scenario Step:' & @CRLF & $aTableOfDuplicateScenarioSteps[0][0] & @CRLF & @CRLF & 'In files:' & @CRLF

        For $i = 0 To _GetCount($aTableOfDuplicateScenarioSteps) Step 1
            $sDuplicateInformation &= $aTableOfDuplicateScenarioSteps[$i][1] & @CRLF & @CRLF
        Next

        MsgBox(48, $aTexts[$eMessageTitleDuplicatesFound], $aTexts[$eMessageDuplicateScenarioSteps] & @CRLF & @CRLF & _
            $sDuplicateInformation)
    EndIf
EndFunc

Func _GetAllScenarioStepAttributeNames()
    Local $aStepFileList = _GetListOfFiles('Steps', '*Steps.au3')

    If Not IsArray($aStepFileList) Then
        Return
    EndIf

    Local $aTableOfAllStepAttributeNames[1][2]

    For $i = 1 To _GetCount($aStepFileList) Step 1
        Local $sStepFileContent                = _GetFileContent($aStepFileList[$i])
        Local $sStepsAttributeNameRegExPattern = '; (\[.+?\])'
        Local $aAllStepsAttributeNames         = StringRegExp($sStepFileContent, $sStepsAttributeNameRegExPattern, 3)

        For $j = 0 To _GetCount($aAllStepsAttributeNames) Step 1
            _ArrayAdd($aTableOfAllStepAttributeNames, $aAllStepsAttributeNames[$j] & '|' & $aStepFileList[$i])
        Next
    Next

    _ArraySort($aTableOfAllStepAttributeNames)

    Return $aTableOfAllStepAttributeNames
EndFunc

Func _GetDuplicateScenarioSteps($aTableOfAllStepAttributeNames)
    Local $iTableCount = _GetCount($aTableOfAllStepAttributeNames)
    Local $aTableOfDuplicateStepAttributeNames[$iTableCount + 1][2]

    Local $iRowIndex      = 0
    Local $bIsDuplication = False

    For $i = 1 To $iTableCount Step 1
        Local $sCurrentStepAttributeName  = $aTableOfAllStepAttributeNames[$i][0]
        Local $sCurrentFilePath           = $aTableOfAllStepAttributeNames[$i][1]
        Local $sPreviousStepAttributeName = $aTableOfAllStepAttributeNames[$i - 1][0]
        Local $sPreviousFilePath          = $aTableOfAllStepAttributeNames[$i - 1][1]

        If $sCurrentStepAttributeName == $sPreviousStepAttributeName Then
            $aTableOfDuplicateStepAttributeNames[$iRowIndex][0] = $sPreviousStepAttributeName
            $aTableOfDuplicateStepAttributeNames[$iRowIndex][1] = $sPreviousFilePath
            $iRowIndex += 1

            $bIsDuplication = True
        Else
            If $bIsDuplication Then
                $aTableOfDuplicateStepAttributeNames[$iRowIndex][0] = $sPreviousStepAttributeName
                $aTableOfDuplicateStepAttributeNames[$iRowIndex][1] = $sPreviousFilePath
                $iRowIndex += 1

                $bIsDuplication = False
            EndIf
        EndIf

        If $i = $iTableCount And $bIsDuplication Then
            $aTableOfDuplicateStepAttributeNames[$iRowIndex][0] = $sCurrentStepAttributeName
            $aTableOfDuplicateStepAttributeNames[$iRowIndex][1] = $sCurrentFilePath
            $iRowIndex += 1
        EndIf
    Next

    Redim $aTableOfDuplicateStepAttributeNames[$iRowIndex][2]

    Return $aTableOfDuplicateStepAttributeNames
EndFunc
