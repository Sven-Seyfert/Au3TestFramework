; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 0.16.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, StepsGenerator)
#pragma compile(ProductVersion, 0.16.0 - 2022-02-10)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\..\..\media\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\..\..\build\StepsGenerator.exe
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
_createFilesWithStepsWrapperFunctions()
_checkForDuplicateScenarioSteps()
