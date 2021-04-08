Feature: Profile
    As Software Test Engineer,
    I want to test the profile actions and their behavior,
    for the benefit to ensure a valid, automatically verified and stable functionality.



Background:
    Given I am on page 'https://github.com'
    When I choose the 'Sign in' button
    Then I am on the '/login' page
    When I login with username and password

    | username   | password   |
    | myUsername | myPassword |



@all
@smokeTest
Scenario: Login works
    When I choose my avatar icon
    Then I am signed in as 'Sven-Seyfert'
    And I could choose 'Your profile' from the user menu



@all
Scenario: Profile data is correct
    When I choose 'Your profile' from the user menu
    Then I am on page '/Sven-Seyfert'
    And the personal bio text 'Hi, I am Sven, a software test engineer specializing in test automation. Private I am a husband, father, friend, son, IT geek and very involved.' is correct



@all
Scenario: Profile data is editable
    When I choose 'Edit profile'
    And fill the profile specific fields with

    | bio text         | Hi, I am Sven, a software test engineer specializing in test automation. Private I am a husband, father, friend, son, IT geek and very involved. |
    | company          |                                                                                                                                                 |
    | location         | Germany                                                                                                                                         |
    | email            | info@sven-seyfert.de                                                                                                                            |
    | website          | http://sven-seyfert.de/                                                                                                                         |
    | twitter username | Sven_Seyfert                                                                                                                                    |

    Then I am on page '/Sven-Seyfert'
    And the personal bio text 'Hi, I am Sven, a software test engineer specializing in test automation. Private I am a husband, father, friend, son, IT geek and very involved.' is correct
