; compiler information for AutoIt
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\..\..\media\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\..\..\build\StepsGenerator.exe
#AutoIt3Wrapper_Res_Description=StepsGenerator (2021-07-07)
#AutoIt3Wrapper_Res_Fileversion=0.9
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt( 'MustDeclareVars', 1 )
Global $aInst = ProcessList( 'ProgramName.exe' )
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <File.au3>
#include <String.au3>



; references -------------------------------------------------------------------
#include "FileHandler.au3"
#include "TableHandler.au3"



; processing -------------------------------------------------------------------
_createStepsWrapperFunctionsFile()

Func _createStepsWrapperFunctionsFile()
    Local $aFeatureFileList = _getFeatureFiles()

    If IsArray( $aFeatureFileList ) Then
        Local $iFeatureFileCount = $aFeatureFileList[0]

        For $i = 1 To $iFeatureFileCount Step 1
            Local $sFeatureFileContent = _getFileContent( $aFeatureFileList[$i] )
            Local $sEndOfFileMark      = @CRLF & 'EOF'
            Local $aAllStepsList       = _getAllStepsOfFeature( $sFeatureFileContent & $sEndOfFileMark )

            If Not IsArray( $aAllStepsList ) And $aAllStepsList == -1 Then
                MsgBox( '', '', 'More then one "Background:" statements in file "' & $aFeatureFileList[$i] & '", which is wrong.' )
                ContinueLoop
            EndIf

            Local $aStepsFunctionsList = _getStepsFunctions( $aAllStepsList )

            If Not IsArray( $aStepsFunctionsList ) Then
                MsgBox( '', '', 'In file "' & $aFeatureFileList[$i] & '" exists a odd single quote sign count, for the step "' & $aStepsFunctionsList & '", which is invalid.')
                ContinueLoop
            EndIf

            $aStepsFunctionsList = _addTableParameterForFunctions( $aStepsFunctionsList )

            _writeStepsWrapperFunctionFile( $aFeatureFileList[$i], $aStepsFunctionsList )
        Next
    EndIf
EndFunc

Func _getFeatureFiles()
    If @Compiled Then       Local $sFeatureFilePath = _PathFull( '..\src\Specification\Features\' )
    If Not @Compiled Then   Local $sFeatureFilePath = _PathFull( '..\Features\' )

    Local Const $iOnlyFiles    = 1
    Local Const $iRecursive    = 1
    Local Const $iSortAsc      = 1
    Local Const $bAbsolutePath = 2

    Return _FileListToArrayRec( $sFeatureFilePath, '*.feature', $iOnlyFiles, $iRecursive, $iSortAsc, $bAbsolutePath )
EndFunc

Func _getAllStepsOfFeature( $sFeatureFileContent )
    Local $aAllStepsList[1]
    Local $aStepsList = _createStepList( $sFeatureFileContent )

    If $aStepsList == -1 Then
        Return -1
    EndIf

    If IsArray( $aStepsList ) Then
        Local Const $iEntireDelimiter = 1
        Local $iMatchStepListCount    = UBound( $aStepsList ) - 1

        For $i = 1 To $iMatchStepListCount Step 1
            Local $aList = StringSplit( $aStepsList[$i], @CRLF, $iEntireDelimiter )
            $aList = _removeEmptyLinesFromList( $aList )
            $aList = _removeTagsFromList( $aList )
            $aList = _removeDoubleWhitespacesFromList( $aList )
            $aList = _removeScenarioTitleFromList( $aList )

            _ArrayConcatenate( $aAllStepsList, $aList )
        Next

        Return _removeDuplicateSteps( $aAllStepsList )
    EndIf
EndFunc

Func _createStepList( $sFeatureFileContent )
    Local $sBackgroundStepsRegExPattern = '(?s)Background:(.*?)Scenario'
    Local $sScenarioStepsRegExPattern   = '(?s)Scenario:.+?\r\n(.*?)EOF'

    Local $aBackgroundSteps = StringRegExp( $sFeatureFileContent, $sBackgroundStepsRegExPattern, 3 )
    Local $aScenarioSteps   = StringRegExp( $sFeatureFileContent, $sScenarioStepsRegExPattern, 3 )

    Local $aStepsList[1]

    If IsArray( $aBackgroundSteps ) Then
        If UBound( $aBackgroundSteps ) > 1 Then
            Return -1
        EndIf

        _ArrayConcatenate( $aStepsList, $aBackgroundSteps )
    EndIf

    If IsArray( $aScenarioSteps ) Then
        _ArrayConcatenate( $aStepsList, $aScenarioSteps )
    EndIf

    Return $aStepsList
EndFunc

Func _getStepsFunctions( $aAllStepsList )
    _ArrayDelete( $aAllStepsList, 0 )

    Local $iAllStepsListCount = UBound( $aAllStepsList ) - 1
    Local $aStepsFunctionsList[$iAllStepsListCount + 1]

    For $j = 0 To $iAllStepsListCount Step 1
        If _isThereAOddInvalidSingleQuoteSignCount( $aAllStepsList[$j] ) Then
            Return $aAllStepsList[$j]
        EndIf

        Local $sStepAttributeName   = _createStepAttributeName( $aAllStepsList[$j] )
        Local $sStepWrapperFunction = _createStepFunction( $aAllStepsList[$j] )

        $aStepsFunctionsList[$j] = '; [' & $sStepAttributeName & ']' & @CRLF & $sStepWrapperFunction & @CRLF & @CRLF
    Next

    Return _removeDuplicateStepsFunctions( $aStepsFunctionsList )
EndFunc

Func _isThereAOddInvalidSingleQuoteSignCount( $sStepName )
    StringReplace( $sStepName, "'", '' )
    Local $iReplacementCount = @extended

    Return _isNumberOdd( $iReplacementCount ) And StringLeft( $sStepName, 1 ) <> '|'
EndFunc

Func _isNumberOdd( $iNumber )
    Return ( Mod( $iNumber, 2 ) <> 0 ) ? True : False
EndFunc

Func _createStepAttributeName( $sStepName )
    Local $sParameterRegExPattern       = "'.*?'"
    Local $sParameterStringToBeReplaced = "'(.*)'"

    Return StringRegExpReplace( $sStepName, $sParameterRegExPattern, $sParameterStringToBeReplaced )
EndFunc

Func _createStepFunction( $sStepName )
    Local $sParameterRegExPattern = "'.*?'"
    Local $aMatchParameterList    = StringRegExp( $sStepName, $sParameterRegExPattern, 3 )
    Local $iParameterCount        = UBound( $aMatchParameterList )

    Local $sParameterStringToBeReplaced  = "'(.*)'"
    Local Const $iStripDoubleWhitespaces = 4
    Local Const $iStripAllWhitespaces    = 8

    $sStepName = _createStepAttributeName( $sStepName )
    $sStepName = StringReplace( $sStepName, $sParameterStringToBeReplaced, '' )
    $sStepName = StringStripWS( $sStepName, $iStripDoubleWhitespaces )
    $sStepName = _StringProper( $sStepName )
    $sStepName = StringStripWS( $sStepName, $iStripAllWhitespaces )
    $sStepName = _setFirstCharacterOfStringToLower( $sStepName ) & '( '
    $sStepName = _addParametersForFunction( $iParameterCount, $sStepName )

    Return 'Func _' & $sStepName & @CRLF & _StringRepeat( ' ', 4 ) & '; your code pending' & @CRLF & 'EndFunc'
EndFunc

Func _setFirstCharacterOfStringToLower( $sString )
    Local $sFirstCharacterAsLowerCase   = StringLower( StringLeft( $sString, 1 ) )
    Local $sStringWithoutFirstCharacter = StringTrimLeft( $sString, 1 )

    Return $sFirstCharacterAsLowerCase & $sStringWithoutFirstCharacter
EndFunc

Func _addParametersForFunction( $iParameterCount, $sStepName )
    For $i = 1 To $iParameterCount Step 1
        $sStepName &= '$sParam' & $i & ', '
    Next

    Return ( $iParameterCount == 0 ) ? ( StringTrimRight( $sStepName, 1 ) & ')' ) : ( StringTrimRight( $sStepName, 2 ) & ' )' )
EndFunc

Func _addTableParameterForFunctions( $aStepsFunctionsList )
    Local $bIsTable = False
    Local $iStepsFunctionListCount = UBound( $aStepsFunctionsList ) - 1

    For $i = $iStepsFunctionListCount To 1 Step - 1
        If StringInStr( $aStepsFunctionsList[$i], '; [|', 2 ) <> 0 Then
            _ArrayDelete( $aStepsFunctionsList, $i )
            $bIsTable = True
        Else
            If $bIsTable Then
                Local $sParamsRegExPattern = '(\$sParam\d+) \)'
                Local $sRegExReplace       = '$1, $aTable )'

                $aStepsFunctionsList[$i] = StringRegExpReplace( $aStepsFunctionsList[$i], $sParamsRegExPattern, $sRegExReplace )
                Local $iReplacementCount = @extended

                If $iReplacementCount == 0 Then
                    $aStepsFunctionsList[$i] = StringReplace( $aStepsFunctionsList[$i], '()', '( $aTable )' )
                EndIf
            EndIf

            $bIsTable = False
        EndIf
    Next

    Return $aStepsFunctionsList
EndFunc

Func _writeStepsWrapperFunctionFile( $sFile, $aStepsFunctionsList )
    Local $sStepFile = StringReplace( $sFile, '\Features\', '\Steps\' )
          $sStepFile = StringReplace( $sStepFile, '.feature', 'Steps.au3' )

    Local $iStepsFunctionListCount = UBound( $aStepsFunctionsList ) - 1

    If Not FileExists( $sStepFile ) Then
        For $i = 0 To $iStepsFunctionListCount Step 1
            _appendToFile( $sStepFile, $aStepsFunctionsList[$i] )
        Next
    Else
        Local $sStepFileContent = _getFileContent( $sStepFile )

        For $i = 0 To $iStepsFunctionListCount Step 1
            Local $sStepsAttributeNameRegExPattern = '; (\[.+?\])'
            Local $aAllStepsAttributeNames         = StringRegExp( $sStepFileContent, $sStepsAttributeNameRegExPattern, 3 )
            Local $sCurrentStepAttributeName       = StringRegExp( $aStepsFunctionsList[$i], $sStepsAttributeNameRegExPattern, 3 )[0]
            Local $iFoundResult                    = _ArraySearch( $aAllStepsAttributeNames, $sCurrentStepAttributeName )

            Local $iStepFunctionDoesNotExistAlready = -1
            If $iFoundResult == $iStepFunctionDoesNotExistAlready Then
                _appendToFile( $sStepFile, $aStepsFunctionsList[$i] )
            EndIf
        Next
    EndIf
EndFunc
