; compiler information for AutoIt
#pragma compile(CompanyName, © SOLVE SMART)
#pragma compile(FileVersion, 0.15.0)
#pragma compile(LegalCopyright, © Sven Seyfert)
#pragma compile(ProductName, FormatBddTable)
#pragma compile(ProductVersion, 0.15.0 - 2022-02-09)

#AutoIt3Wrapper_AU3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Icon=..\media\favicon.ico
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
Global $sFormattedBddTable = _getFormattedBddTable()
ClipPut($sFormattedBddTable)

Func _getFormattedBddTable()
    Local $aBddTable = _getBddTable()
          $aBddTable = _stripWhitespacesFromTable($aBddTable)

    Local $iColumns  = _getColumnCount($aBddTable)
          $aBddTable = _create2dArrayOfTable($aBddTable, $iColumns)
          $aBddTable = _reformatColumnWidthInTable($aBddTable)

    Return _createTableStringOfArray($aBddTable)
EndFunc

Func _getBddTable()
    Local Const $iEntireDelimiter = 1
    Local $sBddTable = ClipGet()

    Return StringSplit($sBddTable, @CRLF, $iEntireDelimiter)
EndFunc

Func _stripWhitespacesFromTable($aTable, $sTableBorderCharacter = '|')
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

Func _getColumnCount($aTable)
    Local $sFirstTableRow      = $aTable[1]
    Local $sTableRegExPattern  = '\|'
    Local $aPipesAsTableBorder = StringRegExp($sFirstTableRow, $sTableRegExPattern, 3)

    Return UBound($aPipesAsTableBorder) - 1
EndFunc

Func _create2dArrayOfTable($aTable, $iCloumns)
    Local Const $iWithoutArrayCount = 2
    Local $iRowCount = $aTable[0]
    Local $aNewTable[$iRowCount + 1][$iCloumns]
          $aNewTable[0][0] = $iRowCount

    For $i = 1 To $iRowCount Step 1
        Local $aTableRowCells = StringSplit($aTable[$i], '|', $iWithoutArrayCount)
              $aTableRowCells = _removeFirstAndLastElementFromArray($aTableRowCells)

        Local $iTableCellsCount = UBound($aTableRowCells) - 1

        For $j = 0 To $iTableCellsCount Step 1
            Local $sTableCell = $aTableRowCells[$j]
            $aNewTable[$i][$j] = $sTableCell
        Next
    Next

    Return $aNewTable
EndFunc

Func _removeFirstAndLastElementFromArray($aArray)
    Local $iRowCount = Ubound($aArray) - 1

    _ArrayDelete($aArray, $iRowCount)
    _ArrayDelete($aArray, 0)

    Return $aArray
EndFunc

Func _reformatColumnWidthInTable($aTable)
    Local $iColumnCount = UBound($aTable, 2) - 1

    For $i = 0 To $iColumnCount Step 1
        Local $iRowCount        = $aTable[0][0]
        Local $iMaxColumnLength = _getMaxColumnLength($aTable, $i, $iRowCount)

        For $j = 1 To $iRowCount Step 1
            Local $sTableCell         = $aTable[$j][$i]
            Local $iCurrentCellLength = StringLen($sTableCell)

            $aTable[$j][$i] = '| ' & $aTable[$j][$i] & _StringRepeat(' ', $iMaxColumnLength - $iCurrentCellLength) & ' '
        Next
    Next

    Return $aTable
EndFunc

Func _getMaxColumnLength($aTable, $iColumn, $iRowCount)
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

Func _createTableStringOfArray($aTable)
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
