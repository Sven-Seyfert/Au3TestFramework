Func _ShowTestExecutor()
    Local $aListOfFeatureFiles = _GetListOfFiles('Features', '.feature')
    Local $aTableOfFeatureFilesAndTheirScenarios = _GetTableOfFeatureFilesAndTheirScenarios($aListOfFeatureFiles)

    _WriteFile($sIncludeFileOfScenarioSteps, '; temporary dummy text')

    _CreateGui()
    _CreateDynamicGuiContent($aTableOfFeatureFilesAndTheirScenarios)
    _CreateButtonBar()
    _InitializeGuiScroll()
    _WaitForGuiEvent()
EndFunc

Func _GetListOfFiles($sFolder, $sFileExtension)
    If @Compiled Then
        Local $sFilePath = _PathFull('..\src\Specification\' & $sFolder & '\')
    EndIf

    If Not @Compiled Then
        Local $sFilePath = _PathFull('..\..\Specification\' & $sFolder & '\')
    EndIf

    Local Const $iOnlyFiles    = 1
    Local Const $iRecursive    = 1
    Local Const $iSortAsc      = 1
    Local Const $bAbsolutePath = 2

    Return _FileListToArrayRec($sFilePath, '*' & $sFileExtension, $iOnlyFiles, $iRecursive, $iSortAsc, $bAbsolutePath)
EndFunc

Func _GetTableOfFeatureFilesAndTheirScenarios($aList)
    Local $aTableOfFeatureFilesAndTheirScenarios[1][4]

    For $i = 1 To _GetCount($aList) Step 1
        Local $aFileContent = _GetFileContentAsList($aList[$i])

        $aTableOfFeatureFilesAndTheirScenarios = _CreateTableOfFeatureFilesAndTheirScenarios($aTableOfFeatureFilesAndTheirScenarios, $aFileContent, $aList[$i])
    Next

    Return $aTableOfFeatureFilesAndTheirScenarios
EndFunc

Func _CreateTableOfFeatureFilesAndTheirScenarios($aTable, $aFileContent, $sFeatureFilePath)
    Local $sRegExPatternOfFeatureSubFolderPath = '(.+?)Features'
    Local $sRegExPatternOfScenarioTitle        = 'Scenario:.+?$'

    For $j = 1 To _GetCount($aFileContent) Step 1
        If StringInStr($aFileContent[$j], 'Scenario:', 2) == 0 Then
            ContinueLoop
        EndIf

        Local $sFeature                 = _GetJustFileName($sFeatureFilePath)
        Local $sFeatureFolderPath       = StringTrimRight($sFeatureFilePath, StringLen($sFeature))
        Local $sFeatureSubFolderPath    = StringRegExpReplace($sFeatureFolderPath, $sRegExPatternOfFeatureSubFolderPath, '')
        Local $sFeatureFolderBreadcrumb = 'Features' & StringTrimRight(StringReplace($sFeatureSubFolderPath, '\', ' > '), 2)
        Local $sFeatureName             = _StringProperWithSpaces(StringReplace($sFeature, '.feature', ''))
        Local $sScenario                = StringRegExp($aFileContent[$j], $sRegExPatternOfScenarioTitle, 1)[0]
        Local $sScenarioName            = StringReplace($sScenario, 'Scenario: ', '')

        _ArrayAdd($aTable, $sFeatureFolderBreadcrumb & '|' & $sFeatureName & '|' & $sScenarioName & '|' & $sFeatureFilePath)
    Next

    Return $aTable
EndFunc
