Func _createStepsWrapperFunctionsFile()
    Local $aFeatureFileList = _getListOfFiles('Features', '.feature')

    If Not IsArray($aFeatureFileList) Then
        MsgBox(48, $aTexts[$eMessageTitleNote], $aTexts[$eMessageNoFeatureFileFound] & @CRLF & @CRLF & _
            'Folder:' & @CRLF & '*\Features\')

        Return False
    EndIf

    For $i = 1 To _getCount($aFeatureFileList) Step 1
        Local $sFeatureFileContent = _getFileContent($aFeatureFileList[$i])
        Local $sEndOfFileMark      = @CRLF & 'EOF'
        Local $aAllStepsList       = _getAllStepsOfFeature($sFeatureFileContent & $sEndOfFileMark)

        If Not IsArray($aAllStepsList) And $aAllStepsList == -1 Then
            MsgBox(48, $aTexts[$eMessageTitleWrongStructure], $aTexts[$eMessageWrongStructure] & @CRLF & @CRLF & _
                'File:' & @CRLF & $aFeatureFileList[$i])
            ContinueLoop
        EndIf

        Local $aStepsFunctionsList = _getStepsFunctions($aAllStepsList)

        If Not IsArray($aStepsFunctionsList) Then
            MsgBox(48, $aTexts[$eMessageTitleInvalidSingleQuoteCount], $aTexts[$eMessageInvalidSingleQuoteCount] & @CRLF & @CRLF & _
                'File:' & @CRLF & $aFeatureFileList[$i] & @CRLF & @CRLF & _
                'Scenario Step:' & @CRLF & $aStepsFunctionsList)
            ContinueLoop
        EndIf

        $aStepsFunctionsList = _addTableParameterForFunctions($aStepsFunctionsList)

        _writeStepsWrapperFunctionFile($aFeatureFileList[$i], $aStepsFunctionsList)
    Next
EndFunc

Func _getListOfFiles($sFolder, $sFileExtension)
    If @Compiled Then
        Local $sFeatureFilePath = _PathFull('..\src\Specification\' & $sFolder & '\')
    EndIf

    If Not @Compiled Then
        Local $sFeatureFilePath = _PathFull('..\' & $sFolder & '\')
    EndIf

    Local Const $iOnlyFiles    = 1
    Local Const $iRecursive    = 1
    Local Const $iSortAsc      = 1
    Local Const $bAbsolutePath = 2

    Return _FileListToArrayRec($sFeatureFilePath, '*' & $sFileExtension, $iOnlyFiles, $iRecursive, $iSortAsc, $bAbsolutePath)
EndFunc

Func _getAllStepsOfFeature($sFeatureFileContent)
    Local $aStepsList = _createStepList($sFeatureFileContent)

    If $aStepsList == -1 Then
        Return -1
    EndIf

    Local $aAllStepsList[1]

    If IsArray($aStepsList) Then
        Local Const $iEntireDelimiter = 1

        For $i = 1 To _getCount($aStepsList) Step 1
            Local $aList = StringSplit($aStepsList[$i], @CRLF, $iEntireDelimiter)
            $aList = _removeEmptyLinesFromList($aList)
            $aList = _removeTagsFromList($aList)
            $aList = _removeDoubleWhitespacesFromList($aList)
            $aList = _removeScenarioTitleFromList($aList)

            _ArrayConcatenate($aAllStepsList, $aList)
        Next

        Return _removeDuplicateSteps($aAllStepsList)
    EndIf
EndFunc

Func _createStepList($sFeatureFileContent)
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

Func _getStepsFunctions($aAllStepsList)
    _ArrayDelete($aAllStepsList, 0)

    Local $iAllStepsListCount = _getCount($aAllStepsList)
    Local $aStepsFunctionsList[$iAllStepsListCount + 1]

    For $j = 0 To $iAllStepsListCount Step 1
        If _isThereAOddInvalidSingleQuoteSignCount($aAllStepsList[$j]) Then
            Return $aAllStepsList[$j]
        EndIf

        Local $sStepAttributeName   = _createStepAttributeName($aAllStepsList[$j])
        Local $sStepWrapperFunction = _createStepFunction($aAllStepsList[$j])

        $aStepsFunctionsList[$j] = '; [' & $sStepAttributeName & ']' & @CRLF & $sStepWrapperFunction & @CRLF & @CRLF
    Next

    Return _removeDuplicateStepsFunctions($aStepsFunctionsList)
EndFunc

Func _isThereAOddInvalidSingleQuoteSignCount($sStepName)
    StringReplace($sStepName, "'", '')
    Local $iReplacementCount = @extended

    Return _isNumberOdd($iReplacementCount) And StringLeft($sStepName, 1) <> '|'
EndFunc

Func _isNumberOdd($iNumber)
    Return (Mod($iNumber, 2) <> 0) ? True : False
EndFunc

Func _createStepAttributeName($sStepName)
    Local $sParameterRegExPattern       = "'.*?'"
    Local $sParameterStringToBeReplaced = "'(.*)'"

    Return StringRegExpReplace($sStepName, $sParameterRegExPattern, $sParameterStringToBeReplaced)
EndFunc

Func _createStepFunction($sStepName)
    Local $sParameterRegExPattern = "'.*?'"
    Local $aMatchParameterList    = StringRegExp($sStepName, $sParameterRegExPattern, 3)
    Local $iParameterCount        = UBound($aMatchParameterList)

    $sStepName = _createStepAttributeName($sStepName)
    $sStepName = _reformatStepName($sStepName)
    $sStepName = _setFirstCharacterOfStringToLower($sStepName) & '('
    $sStepName = _addParametersForFunction($iParameterCount, $sStepName)

    Return 'Func _' & $sStepName & @CRLF & _StringRepeat(' ', 4) & '; your code pending' & @CRLF & 'EndFunc'
EndFunc

Func _reformatStepName($sStepName)
    Local $sParameterStringToBeReplaced = "'(.*)'"

    Local Const $iStripDoubleWhitespaces = 4
    Local Const $iStripAllWhitespaces    = 8

    $sStepName = StringReplace($sStepName, $sParameterStringToBeReplaced, '')
    $sStepName = StringStripWS($sStepName, $iStripDoubleWhitespaces)
    $sStepName = _StringProper($sStepName)

    Return StringStripWS($sStepName, $iStripAllWhitespaces)
EndFunc

Func _setFirstCharacterOfStringToLower($sString)
    Local $sFirstCharacterAsLowerCase   = StringLower(StringLeft($sString, 1))
    Local $sStringWithoutFirstCharacter = StringTrimLeft($sString, 1)

    Return $sFirstCharacterAsLowerCase & $sStringWithoutFirstCharacter
EndFunc

Func _addParametersForFunction($iParameterCount, $sStepName)
    For $i = 1 To $iParameterCount Step 1
        $sStepName &= '$sParam' & $i & ', '
    Next

    Return ($iParameterCount == 0) ? ($sStepName & ')') : (StringTrimRight($sStepName, 2) & ')')
EndFunc

Func _addTableParameterForFunctions($aStepsFunctionsList)
    Local $bIsTable = False

    For $i = _getCount($aStepsFunctionsList) To 1 Step - 1
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

Func _writeStepsWrapperFunctionFile($sFile, $aStepsFunctionsList)
    Local $sStepFile = StringReplace($sFile, '\Features\', '\Steps\')
          $sStepFile = StringReplace($sStepFile, '.feature', 'Steps.au3')

    Local $iStepsFunctionListCount = _getCount($aStepsFunctionsList)

    For $i = 0 To $iStepsFunctionListCount Step 1
        Local $sStepsAttributeNameRegExPattern       = '; (\[.+?\])'
        Local $sCurrentStepAttributeName             = StringRegExp($aStepsFunctionsList[$i], $sStepsAttributeNameRegExPattern, 3)[0]
        Local $aTableOfAllScenarioStepAttributeNames = _getAllScenarioStepAttributeNames()

        Local $iFoundResult = _ArraySearch($aTableOfAllScenarioStepAttributeNames, $sCurrentStepAttributeName)
        Local $iStepFunctionDoesNotExistAlready = -1

        If $iFoundResult == $iStepFunctionDoesNotExistAlready Then
            _appendToFile($sStepFile, $aStepsFunctionsList[$i])
        EndIf
    Next
EndFunc

Func _checkForDuplicateScenarioSteps()
    Local $aTableOfAllScenarioStepAttributeNames = _getAllScenarioStepAttributeNames()
    Local $aTableOfDuplicateScenarioSteps        = _getDuplicateScenarioSteps($aTableOfAllScenarioStepAttributeNames)

    If UBound($aTableOfDuplicateScenarioSteps) > 0 Then
        Local $sDuplicateInformation = 'Scenario Step:' & @CRLF & $aTableOfDuplicateScenarioSteps[0][0] & @CRLF & @CRLF & 'In files:' & @CRLF

        For $i = 0 To _getCount($aTableOfDuplicateScenarioSteps) Step 1
            $sDuplicateInformation &= $aTableOfDuplicateScenarioSteps[$i][1] & @CRLF & @CRLF
        Next

        MsgBox(48, $aTexts[$eMessageTitleDuplicatesFound], $aTexts[$eMessageDuplicateScenarioSteps] & @CRLF & @CRLF & _
            $sDuplicateInformation)
    EndIf
EndFunc

Func _getAllScenarioStepAttributeNames()
    Local $aStepFileList = _getListOfFiles('Steps', '*Steps.au3')

    If Not IsArray($aStepFileList) Then
        Return
    EndIf

    Local $aTableOfAllStepAttributeNames[1][2]

    For $i = 1 To _getCount($aStepFileList) Step 1
        Local $sStepFileContent                = _getFileContent($aStepFileList[$i])
        Local $sStepsAttributeNameRegExPattern = '; (\[.+?\])'
        Local $aAllStepsAttributeNames         = StringRegExp($sStepFileContent, $sStepsAttributeNameRegExPattern, 3)

        For $j = 0 To _getCount($aAllStepsAttributeNames) Step 1
            _ArrayAdd($aTableOfAllStepAttributeNames, $aAllStepsAttributeNames[$j] & '|' & $aStepFileList[$i])
        Next
    Next

    _ArraySort($aTableOfAllStepAttributeNames)

    Return $aTableOfAllStepAttributeNames
EndFunc

Func _getDuplicateScenarioSteps($aTableOfAllStepAttributeNames)
    Local $iTableCount = _getCount($aTableOfAllStepAttributeNames)
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
