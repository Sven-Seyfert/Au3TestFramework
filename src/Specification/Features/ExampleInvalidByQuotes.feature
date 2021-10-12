Feature: Example Invalid By Quotes
    As Software Test Engineer,
    I want to test the "Example Invalid By Quotes" actions and their behavior,
    for the benefit to ensure a valid, automatically verified and stable functionality.



@tag
Scenario: Login works
    Given I am on page 'https://website.com/login'
    When I login with 'username' and 'password

    | username     | password        |
    | Makenna_OKon | IcI3g07uif3dH8x |

    Then the login was successful
