---
name: Bug report
about: Create a report to help to improve the project
title: ''
labels: ''
assignees: ''

---

**Describe the bug**
A clear and concise description of what the bug is.

**To Reproduce**
Steps to reproduce the behavior:
1. Go to '...'
2. Click on '....'
3. Scroll down to '....'
4. See error

**Expected behavior**
A clear and concise description of what you expected to happen.

**Screenshots**
If applicable, add screenshots to help explain your problem.

**SUT (system under test)**
Please execute the following function and copy the console result here.

``` au3
Func _getSystemInfos()
    ConsoleWrite( '@AutoItExe:      ' & @AutoItExe     & @CRLF )
    ConsoleWrite( '@AutoItVersion:  ' & @AutoItVersion & @CRLF )
    ConsoleWrite( '@CPUArch:        ' & @CPUArch       & @CRLF )
    ConsoleWrite( '@OSArch:         ' & @OSArch        & @CRLF )
    ConsoleWrite( '@OSVersion:      ' & @OSVersion     & @CRLF )
EndFunc
_getSystemInfos()
```

**Additional context**
Add any other context about the problem here.
