Func _showTestExecutor()
    Local $aListOfFeatureFiles = _getListOfFiles('Features', '.feature')
    Local $aTableOfFeatureFilesAndTheirScenarios = _getTableOfFeatureFilesAndTheirScenarios($aListOfFeatureFiles)

    _writeFile($sIncludeFileOfScenarioSteps, '; temporary dummy text')

    _createGui()
    _createDynamicGuiContent($aTableOfFeatureFilesAndTheirScenarios)
    _createButtonBar()
    _initializeGuiScroll()
    _waitForGuiEvent()
EndFunc

Func _getListOfFiles($sFolder, $sFileExtension)
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

Func _getTableOfFeatureFilesAndTheirScenarios($aList)
    Local $aTableOfFeatureFilesAndTheirScenarios[1][4]

    For $i = 1 To _getCount($aList) Step 1
        Local $aFileContent = _getFileContentAsList($aList[$i])

        $aTableOfFeatureFilesAndTheirScenarios = _createTableOfFeatureFilesAndTheirScenarios($aTableOfFeatureFilesAndTheirScenarios, $aFileContent, $aList[$i])
    Next

    Return $aTableOfFeatureFilesAndTheirScenarios
EndFunc

Func _createTableOfFeatureFilesAndTheirScenarios($aTable, $aFileContent, $sFeatureFilePath)
    Local $sRegExPatternOfFeatureSubFolderPath = '(.+?)Features'
    Local $sRegExPatternOfScenarioTitle        = 'Scenario:.+?$'

    For $j = 1 To _getCount($aFileContent) Step 1
        If StringInStr($aFileContent[$j], 'Scenario:', 2) == 0 Then
            ContinueLoop
        EndIf

        Local $sFeature                 = _getJustFileName($sFeatureFilePath)
        Local $sFeatureFolderPath       = StringTrimRight($sFeatureFilePath, StringLen($sFeature))
        Local $sFeatureSubFolderPath    = StringRegExpReplace($sFeatureFolderPath, $sRegExPatternOfFeatureSubFolderPath, '')
        Local $sFeatureFolderBreadcrumb = 'Features' & StringTrimRight(StringReplace($sFeatureSubFolderPath, '\', ' > '), 2)
        Local $sFeatureName             = _stringProperWithSpaces(StringReplace($sFeature, '.feature', ''))
        Local $sScenario                = StringRegExp($aFileContent[$j], $sRegExPatternOfScenarioTitle, 1)[0]
        Local $sScenarioName            = StringReplace($sScenario, 'Scenario: ', '')

        _ArrayAdd($aTable, $sFeatureFolderBreadcrumb & '|' & $sFeatureName & '|' & $sScenarioName & '|' & $sFeatureFilePath)
    Next

    Return $aTable
EndFunc
