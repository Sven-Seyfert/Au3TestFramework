Func _StringProperWithSpaces($sString)
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

Func _GetJustFileName($sFilePath)
    Return StringRegExpReplace($sFilePath, '(.+?)\\', '', 0)
EndFunc

Func _GetCount($aList)
    Return UBound($aList) - 1
EndFunc

Func _GetFileContentAsList($sFileContent)
    Return StringSplit(_GetFileContent($sFileContent), @LF, 1)
EndFunc

Func _GetFileContent($sFile)
    Local Const $iUtf8WithoutBomMode = 256

    Local $hFile        = FileOpen($sFile, $iUtf8WithoutBomMode)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc

Func _WriteFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndOverwriteCreationMode = 256 + 2 + 8

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndOverwriteCreationMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc

Func _AppendToFile($sFile, $sText)
    Local Const $iUtf8WithoutBomAndAppendMode = 256 + 1

    Local $hFile = FileOpen($sFile, $iUtf8WithoutBomAndAppendMode)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc
