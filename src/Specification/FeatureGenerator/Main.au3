; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 0.18.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, FeatureGenerator)
#pragma compile(ProductVersion, 0.18.0 - 2022-08-05)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\..\..\media\icons\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\..\..\build\FeatureGenerator.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt('MustDeclareVars', 1)
Global $aInst = ProcessList('FeatureGenerator.exe')
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <GUIConstantsEx.au3>
#include <String.au3>
#include <WindowsConstants.au3>



; modules ----------------------------------------------------------------------
#include "Enum.au3"
#include "TextContainer.au3"
#include "Initializer.au3"
#include "GuiController.au3"
#include "GuiThemeController.au3"
#include "GuiBuilder.au3"
#include "FunctionController.au3"



; processing -------------------------------------------------------------------
_CreateFeatureTemplateFile()
