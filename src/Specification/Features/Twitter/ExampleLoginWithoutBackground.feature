Feature: Example Login Without Background
    As Software Test Engineer,
    I want to test the "Example Login Without Background" actions and their behavior,
    for the benefit to ensure a valid, automatically verified and stable functionality.



Scenario: Login works
    Given I am on page 'https://website.com/login'
    When I login with username and password

    | username     | password        |
    | Makenna_OKon | IcI3g07uif3dH8x |

    Then the login was successful
