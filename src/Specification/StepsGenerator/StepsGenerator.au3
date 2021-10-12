; compiler information for AutoIt
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\..\..\media\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\..\..\build\StepsGenerator.exe
#AutoIt3Wrapper_Res_Description=StepsGenerator (2021-10-12)
#AutoIt3Wrapper_Res_Fileversion=0.11.0
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt('MustDeclareVars', 1)
Global $aInst = ProcessList('StepsGenerator.exe')
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <File.au3>
#include <String.au3>



; references -------------------------------------------------------------------
#include "Enum.au3"
#include "TextContainer.au3"
#include "FileHandler.au3"
#include "TableHandler.au3"
#include "FunctionController.au3"



; processing -------------------------------------------------------------------
_createStepsWrapperFunctionsFile()
_checkForDuplicateScenarioSteps()
