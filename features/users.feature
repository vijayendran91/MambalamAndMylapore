Feature: User Accounts

  Scenario: User creates an account
    Given User with following details cretes an account
      | uname | fname | lname | email | password_hash |
      | vijayendran3491 | vijayendran | gopalakrishnan | vijayendran3491@gmail.com | abcdf |
    And I get user details for username "vijayendran3491" successfully

  Scenario: User Signs up without email id
    Given User with following details cretes an account
      | uname | fname | lname | email | password_hash |
      | vijayendran3491 | vijayendran | gopalakrishnan | vijayendran3491 | abcdf |
