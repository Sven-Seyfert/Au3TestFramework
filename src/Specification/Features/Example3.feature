Feature: Example3
    As Software Test Engineer,
    I want to test the "Example3" actions and their behavior,
    for the benefit to ensure a valid, automatically verified and stable functionality.



Background:
    Given is a specific state
    When I do a specific action as precondition with 'thisIsAExample' parameter and table

    | first name | last name |
    | john       | doe       |

    And this is a test 'dummyParam' with more params 'dummy2'

    | column one           | column two           |
    | row one column one   | row one column two   |
    | row two column one   | row two column two   |
    | row three column one | row three column two |



Scenario: Login works
    Given I am on page 'https://website.com/login'
    When I login with username and password

    | username     | password        |
    | Makenna_OKon | IcI3g07uif3dH8x |

    Then the login was successful
