Feature: Example Login
    As Software Test Engineer,
    I want to test the "Example Login" actions and their behavior,
    for the benefit to ensure a valid, automatically verified and stable functionality.



Background:
    Given is a specific state
    When I do a specific action as precondition



@tag
Scenario: Login works
    Given I am on page 'https://website.com/login'
    When I login with username and password

    | username     | password        |
    | Makenna_OKon | IcI3g07uif3dH8x |

    Then the login was successful
