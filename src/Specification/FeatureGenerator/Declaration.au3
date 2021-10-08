
Global $bIsDarkModeActive              = True
Global $aMouseData
Global $aGuiData

Global $aColor[$iMaxEnumIndex]
       $aColor[$eBackground]           = 0x21252B
       $aColor[$eBackgroundInput]      = 0x282C34
       $aColor[$eBorder]               = 0x474A4F
       $aColor[$eBorderInput]          = 0x61AFEF
       $aColor[$eFont]                 = 0xCCCCCC
       $aColor[$eIcon]                 = 0x595C60

Global $aGui[$iMaxEnumIndex]
       $aGui[$eXPosition]              = Default
       $aGui[$eYPosition]              = Default
       $aGui[$eWidth]                  = 625
       $aGui[$eHeight]                 = 400
       $aGui[$eWidthLabel]             = 350
       $aGui[$eBorderSize]             = 1

Global $aCloseIcon[$iMaxEnumIndex]
       $aCloseIcon[$eXPosition]        = $aGui[$eWidth] - $aGui[$eBorderSize] - 41
       $aCloseIcon[$eYPosition]        = $aGui[$eBorderSize] + 1
       $aCloseIcon[$eWidth]            = 40
       $aCloseIcon[$eHeight]           = 27
       $aCloseIcon[$eLabelText]        = Chr(206)
       $aCloseIcon[$eFontColor]        = 0xFFFFFF
       $aCloseIcon[$eHoverColor]       = 0xD51324

Global $aThemeIcon[$iMaxEnumIndex]
       $aThemeIcon[$eXPosition]        = $aGui[$eWidth] - $aGui[$eBorderSize] - 82
       $aThemeIcon[$eYPosition]        = $aGui[$eBorderSize] + 1
       $aThemeIcon[$eWidth]            = 40
       $aThemeIcon[$eHeight]           = 27
       $aThemeIcon[$eLabelText]        = Chr(82)
       $aThemeIcon[$eHoverColor]       = 0x383B41

Global $aMoveIcon[$iMaxEnumIndex]
       $aMoveIcon[$eXPosition]         = $aGui[$eWidth] - $aGui[$eBorderSize] - 123
       $aMoveIcon[$eYPosition]         = $aGui[$eBorderSize] + 1
       $aMoveIcon[$eWidth]             = 40
       $aMoveIcon[$eHeight]            = 27
       $aMoveIcon[$eLabelText]         = Chr(177)
       $aMoveIcon[$eHoverColor]        = 0x383B41

Global $aHeadline[$iMaxEnumIndex]
       $aHeadline[$eXPosition]         = 40
       $aHeadline[$eYPosition]         = 45
       $aHeadline[$eWidth]             = $aGui[$eWidthLabel]
       $aHeadline[$eHeight]            = 40
       $aHeadline[$eLabelText]         = 'Add a feature file'

Global $aSubHeadline[$iMaxEnumIndex]
       $aSubHeadline[$eXPosition]      = 40
       $aSubHeadline[$eYPosition]      = 100
       $aSubHeadline[$eWidth]          = $aGui[$eWidthLabel]
       $aSubHeadline[$eHeight]         = 30
       $aSubHeadline[$eLabelText]      = 'Enter a feature name'

Global $aInputFeatureName[$iMaxEnumIndex]
       $aInputFeatureName[$eXPosition] = 40
       $aInputFeatureName[$eYPosition] = 150
       $aInputFeatureName[$eWidth]     = $aGui[$eWidthLabel]
       $aInputFeatureName[$eHeight]    = 50
       $aInputFeatureName[$eLabelText] = 'Feature name'

Global $aButtonOkay[$iMaxEnumIndex]
       $aButtonOkay[$eXPosition]       = $aGui[$eWidth] - 150
       $aButtonOkay[$eYPosition]       = $aGui[$eHeight] - 75
       $aButtonOkay[$eWidth]           = 105
       $aButtonOkay[$eHeight]          = 32
