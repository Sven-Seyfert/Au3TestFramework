Func _stringProperWithSpaces($sString)
    Local $sCharacter          = ''
    Local $sProperString       = ''
    Local $iCharactersCount    = StringLen($sString)

    For $i = 1 To $iCharactersCount Step 1
        $sCharacter = StringMid($sString, $i, 1)

        If StringIsUpper($sCharacter) Then
            $sProperString &= ' ' & $sCharacter
        Else
            $sProperString &= $sCharacter
        EndIf
    Next

    Return StringTrimLeft($sProperString, 1)
EndFunc

Func _getJustFileName($sFilePath)
    Return StringRegExpReplace($sFilePath, '(.+?)\\', '', 0)
EndFunc

Func _getCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _getFileContentAsList($sFileContent)
    Return StringSplit(_getFileContent($sFileContent), @LF, 1)
EndFunc

Func _getFileContent($sFile)
    Local Const $iUtf8WithoutBomMode = 256

    Local $hFile        = FileOpen($sFile, $iUtf8WithoutBomMode)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc

Func _writeFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _appendToFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndAppendMode = 256 + 1

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndAppendMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc
