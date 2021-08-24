; compiler information for AutoIt
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\..\..\media\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\..\..\build\FeatureGenerator.exe
#AutoIt3Wrapper_Res_Description=FeatureGenerator (2021-08-24)
#AutoIt3Wrapper_Res_Fileversion=0.8.0
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt( 'MustDeclareVars', 1 )
Global $aInst = ProcessList( 'FeatureGenerator.exe' )
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <GUIConstantsEx.au3>
#include <String.au3>
#include <WindowsConstants.au3>



; references -------------------------------------------------------------------
#include "Enum.au3"
#include "Declaration.au3"
#include "Gui.au3"
#include "GuiFunctions.au3"



; processing -------------------------------------------------------------------
_createFeatureTemplateFile()

Func _createFeatureTemplateFile()
    Local $sFeatureName         = _getFeatureName()
    Local $sFeatureFileTemplate = _getFeatureFileTemplate( $sFeatureName )

    If @Compiled     Then _writeFile( '..\src\Specification\Features\' & $sFeatureName & '.feature', $sFeatureFileTemplate )
    If Not @Compiled Then _writeFile( '..\Features\' & $sFeatureName & '.feature', $sFeatureFileTemplate )

    _exit( $aGui[$eHandle] )
EndFunc

Func _getFeatureName()
    _showGui()

    AdlibRegister( '_hoverActions', 150 )

    Return _getGuiInput()
EndFunc

Func _getGuiInput()
    While 1
        Switch GUIGetMsg()
            Case $aCloseIcon[$eBackground]
                _exit( $aGui[$eHandle] )

            Case $aThemeIcon[$eBackground]
                _guiApplyTheme()

            Case $aButtonOkay[$eBackground]
                Local $sInput = GUICtrlRead( $aInputFeatureName[$eInput] )
                ExitLoop
        EndSwitch
    WEnd

    Local Const $iStripAllSpaces = 8

    Return StringStripWS( $sInput, $iStripAllSpaces )
EndFunc

Func _getFeatureFileTemplate( $sFeatureName )
    Return _
        'Feature: ' & $sFeatureName & @CRLF & _
        '    As Software Test Engineer,' & @CRLF & _
        '    I want to test the "' & $sFeatureName & '" actions and their behavior,' & @CRLF & _
        '    for the benefit to ensure a valid, automatically verified and stable functionality.' & @CRLF & _
        '' & @CRLF & _
        '' & @CRLF & _
        '' & @CRLF & _
        'Background:' & @CRLF & _
        '    Given is a specific state' & @CRLF & _
        '    When I do a specific action as precondition' & @CRLF & _
        '' & @CRLF & _
        '' & @CRLF & _
        '' & @CRLF & _
        '@tag' & @CRLF & _
        'Scenario: Login works' & @CRLF & _
        '    Given I am on page ''https://website.com/login''' & @CRLF & _
        '    When I login with username and password' & @CRLF & _
        '' & @CRLF & _
        '    | username     | password        |' & @CRLF & _
        '    | Makenna_OKon | IcI3g07uif3dH8x |' & @CRLF & _
        '' & @CRLF & _
        '    Then the login was successful'
EndFunc

Func _writeFile( $sFile, $sText )
    Local Const $iWriteModeCreatePathUtf8 = 2 + 8 + 256
    Local $hFile = FileOpen( $sFile, $iWriteModeCreatePathUtf8 )
    FileWrite( $hFile, $sText )
    FileClose( $hFile )
EndFunc

Func _exit( $hGui )
    AdlibUnRegister( '_hoverActions' )
    _guiFadeOut( $hGui )
    GUIDelete( $hGui )

    Exit
EndFunc

Func _createRandomText( $iLength = 10 )
    Local $sText = ''

    Dim $aChr[2]
    For $i = 1 To $iLength Step 1
        $aChr[0] = Chr( Random( 65, 90, 1 ) )  ; A-Z
        $aChr[1] = Chr( Random( 97, 122, 1 ) ) ; a-z
        $sText  &= $aChr[Random( 0, 1, 1 )]
    Next

    Return $sText
EndFunc
