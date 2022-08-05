; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 0.18.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, FormatBddTable)
#pragma compile(ProductVersion, 0.18.0 - 2022-08-05)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\icons\favicon.ico
#AutoIt3Wrapper_Outfile_x64=..\build\FormatBddTable.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=y



; opt and just singleton -------------------------------------------------------
Opt('MustDeclareVars', 1)
Global $aInst = ProcessList('FormatBddTable.exe')
If $aInst[0][0] > 1 Then Exit



; includes ---------------------------------------------------------------------
#include-once
#include <Array.au3>
#include <String.au3>



; processing -------------------------------------------------------------------
Global $sFormattedBddTable = _GetFormattedBddTable()
ClipPut($sFormattedBddTable)

Func _GetFormattedBddTable()
    Local $aBddTable = _GetBddTable()
          $aBddTable = _StripWhitespacesFromTable($aBddTable)

    Local $iColumns  = _GetColumnCount($aBddTable)
          $aBddTable = _Create2dArrayOfTable($aBddTable, $iColumns)
          $aBddTable = _ReformatColumnWidthInTable($aBddTable)

    Return _CreateTableStringOfArray($aBddTable)
EndFunc

Func _GetBddTable()
    Local Const $iEntireDelimiter = 1
    Local $sBddTable = ClipGet()

    Return StringSplit($sBddTable, @CRLF, $iEntireDelimiter)
EndFunc

Func _StripWhitespacesFromTable($aTable, $sTableBorderCharacter = '|')
    Local Const $iLeadingTrailingAndDoubleWhitespaces = 7
    Local $iRowCount = $aTable[0]

    For $i = 1 To $iRowCount Step 1
        $aTable[$i] = StringStripWS($aTable[$i], $iLeadingTrailingAndDoubleWhitespaces)
        $aTable[$i] = StringReplace($aTable[$i], ' ' & $sTableBorderCharacter & ' ', $sTableBorderCharacter)
        $aTable[$i] = StringReplace($aTable[$i], $sTableBorderCharacter & ' ', $sTableBorderCharacter)
        $aTable[$i] = StringReplace($aTable[$i], ' ' & $sTableBorderCharacter, $sTableBorderCharacter)
    Next

    Return $aTable
EndFunc

Func _GetColumnCount($aTable)
    Local $sFirstTableRow      = $aTable[1]
    Local $sTableRegExPattern  = '\|'
    Local $aPipesAsTableBorder = StringRegExp($sFirstTableRow, $sTableRegExPattern, 3)

    Return UBound($aPipesAsTableBorder) - 1
EndFunc

Func _Create2dArrayOfTable($aTable, $iCloumns)
    Local Const $iWithoutArrayCount = 2
    Local $iRowCount = $aTable[0]
    Local $aNewTable[$iRowCount + 1][$iCloumns]
          $aNewTable[0][0] = $iRowCount

    For $i = 1 To $iRowCount Step 1
        Local $aTableRowCells = StringSplit($aTable[$i], '|', $iWithoutArrayCount)
              $aTableRowCells = _RemoveFirstAndLastElementFromArray($aTableRowCells)

        Local $iTableCellsCount = UBound($aTableRowCells) - 1

        For $j = 0 To $iTableCellsCount Step 1
            Local $sTableCell = $aTableRowCells[$j]
            $aNewTable[$i][$j] = $sTableCell
        Next
    Next

    Return $aNewTable
EndFunc

Func _RemoveFirstAndLastElementFromArray($aArray)
    Local $iRowCount = Ubound($aArray) - 1

    _ArrayDelete($aArray, $iRowCount)
    _ArrayDelete($aArray, 0)

    Return $aArray
EndFunc

Func _ReformatColumnWidthInTable($aTable)
    Local $iColumnCount = UBound($aTable, 2) - 1

    For $i = 0 To $iColumnCount Step 1
        Local $iRowCount        = $aTable[0][0]
        Local $iMaxColumnLength = _GetMaxColumnLength($aTable, $i, $iRowCount)

        For $j = 1 To $iRowCount Step 1
            Local $sTableCell         = $aTable[$j][$i]
            Local $iCurrentCellLength = StringLen($sTableCell)

            $aTable[$j][$i] = '| ' & $aTable[$j][$i] & _StringRepeat(' ', $iMaxColumnLength - $iCurrentCellLength) & ' '
        Next
    Next

    Return $aTable
EndFunc

Func _GetMaxColumnLength($aTable, $iColumn, $iRowCount)
    Local $iMaxColumnLength = 0

    For $i = 1 To $iRowCount Step 1
        Local $sTableCell         = $aTable[$i][$iColumn]
        Local $iCurrentCellLength = StringLen($sTableCell)

        If $iCurrentCellLength > $iMaxColumnLength Then
            $iMaxColumnLength = $iCurrentCellLength
        EndIf
    Next

    Return $iMaxColumnLength
EndFunc

Func _CreateTableStringOfArray($aTable)
    Local $sTableString = ''
    Local $iRowCount    = $aTable[0][0]
    Local $iColumnCount = UBound($aTable, 2) - 1

    For $i = 1 To $iRowCount Step 1
        For $j = 0 To $iColumnCount Step 1
            $sTableString &= $aTable[$i][$j]

            If $j == $iColumnCount Then
                $sTableString &= '|' & @CRLF
            EndIf
        Next
    Next

    Return $sTableString
EndFunc
