Func _getFileContent($sFile)
    Local Const $iUtf8  = 256
    Local $hFile        = FileOpen($sFile, $iUtf8)
    Local $sFileContent = FileRead($hFile)
    FileClose($hFile)

    Return $sFileContent
EndFunc

Func _appendToFile($sFile, $sText)
    Local Const $iAppendModeCreatePathUtf8 = 1 + 8 + 256
    Local $hFile = FileOpen($sFile, $iAppendModeCreatePathUtf8)
    FileWrite($hFile, $sText)
    FileClose($hFile)
EndFunc
