Global $sCheckboxLevelFeatureName             = 'Feature'
Global $sCheckboxLevelScenarioName            = 'Scenario'
Global $sIncludeFileOfScenarioSteps           = 'IncludeFileOfScenarioSteps.au3'

Global $iCount                                = 0
Global $iSuccessCounter                       = 0
Global $iFailureCounter                       = 0
Global $iNoExecutionCounter                   = 0

Global $aTableOfCheckboxesData[0][5]

Global $aGui[$iMaxEnumIndex]
       $aGui[$eHandle]                        = Null
       $aGui[$eTitle]                         = 'TestExecutor'
       $aGui[$eXPosition]                     = Default
       $aGui[$eYPosition]                     = Default
       $aGui[$eWidth]                         = 800
       $aGui[$eHeight]                        = 600
       $aGui[$eStyle]                         = BitOR($GUI_SS_DEFAULT_GUI, $WS_HSCROLL, $WS_VSCROLL)
       $aGui[$eFont]                          = 'Consolas'

Global $aCustomButtonRun[$iMaxEnumIndex]
       $aCustomButtonRun[$eHandle]            = Null
       $aCustomButtonRun[$eTitle]             = '▷'
       $aCustomButtonRun[$eXPosition]         = 15
       $aCustomButtonRun[$eYPosition]         = 9
       $aCustomButtonRun[$eWidth]             = Default
       $aCustomButtonRun[$eHeight]            = Default

Global $aCustomButtonSelectAll[$iMaxEnumIndex]
       $aCustomButtonSelectAll[$eHandle]      = Null
       $aCustomButtonSelectAll[$eTitle]       = '☑'
       $aCustomButtonSelectAll[$eXPosition]   = 43
       $aCustomButtonSelectAll[$eYPosition]   = 12
       $aCustomButtonSelectAll[$eWidth]       = Default
       $aCustomButtonSelectAll[$eHeight]      = Default

Global $aCustomButtonUnselectAll[$iMaxEnumIndex]
       $aCustomButtonUnselectAll[$eHandle]    = Null
       $aCustomButtonUnselectAll[$eTitle]     = '□'
       $aCustomButtonUnselectAll[$eXPosition] = 62
       $aCustomButtonUnselectAll[$eYPosition] = 1
       $aCustomButtonUnselectAll[$eWidth]     = 28
       $aCustomButtonUnselectAll[$eHeight]    = 28

Global $aCheckboxFeature[$iMaxEnumIndex]
       $aCheckboxFeature[$eHandle]            = Null
       $aCheckboxFeature[$eTitle]             = Null
       $aCheckboxFeature[$eXPosition]         = 32
       $aCheckboxFeature[$eYPosition]         = Null
       $aCheckboxFeature[$eWidth]             = $aGui[$eWidth] - 150
       $aCheckboxFeature[$eHeight]            = Default

Global $aCheckboxScenario[$iMaxEnumIndex]
       $aCheckboxScenario[$eHandle]           = Null
       $aCheckboxScenario[$eTitle]            = Null
       $aCheckboxScenario[$eXPosition]        = 49
       $aCheckboxScenario[$eYPosition]        = Null
       $aCheckboxScenario[$eWidth]            = $aGui[$eWidth] - 150
       $aCheckboxScenario[$eHeight]           = Default

Global $aColor[$iMaxEnumIndex]
       $aColor[$eGreen]                       = 0x8BB965
       $aColor[$eRed]                         = 0xF03A17
       $aColor[$eBlue]                        = 0x1BA1E2
       $aColor[$eGray]                        = 0xCDCDCD

Global $aIcon[$iMaxEnumIndex]
       $aIcon[$eSum]                          = '∑'
       $aIcon[$eSuccess]                      = '✔'
       $aIcon[$eFail]                         = '❌'
       $aIcon[$eNotExecuted]                  = '⚠'
       $aIcon[$eFolder]                       = '📂'
       $aIcon[$eClock]                        = '⏱'
