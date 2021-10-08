## Proposed changes

Describe the big picture of your changes here to communicate to the maintainers why we should accept this pull request. Please ensure you have read and noticed the checklist below.

## Pull request checklist

Put an `x` in the boxes that apply. If you're unsure about any of them, don't hesitate to ask. I'm here to help! This is simply a reminder of what we are going to look for before merging your code.

- [ ] I have read and noticed the [CODE OF CONDUCT](https://github.com/Sven-Seyfert/Au3TestFramework/blob/main/docs/CODE_OF_CONDUCT.md) document
- [ ] I have read and noticed the [CONTRIBUTING](https://github.com/Sven-Seyfert/Au3TestFramework/blob/main/docs/CONTRIBUTING.md) document
- [ ] I have added necessary documentation or screenshots (if appropriate)

## Pull request type

Please check the type of change your PR introduces:
- [ ] Bugfix
- [ ] Feature
- [ ] Code style update (formatting, renaming)
- [ ] Refactoring (functional, structural)
- [ ] Documentation content changes
- [ ] Other (please describe):

## What is the current behavior?

Please describe the current behavior that you are modifying, or link to a relevant issue.

## What is the new behavior?

Please describe the behavior or changes that are being added by this PR.

## What is your SUT (system under test)?

Please execute the following function and copy the console result here. Just to ensure your changes won't affect other versions negatively.

``` au3
Func _getSystemInfos()
    ConsoleWrite('@AutoItExe:      ' & @AutoItExe     & @CRLF)
    ConsoleWrite('@AutoItVersion:  ' & @AutoItVersion & @CRLF)
    ConsoleWrite('@CPUArch:        ' & @CPUArch       & @CRLF)
    ConsoleWrite('@OSArch:         ' & @OSArch        & @CRLF)
    ConsoleWrite('@OSVersion:      ' & @OSVersion     & @CRLF)
EndFunc
_getSystemInfos()
```

## Further information

If this is a relatively large or complex change, kick off the discussion by explaining why you chose the solution you did and what alternatives you considered, etc. Thanks!
