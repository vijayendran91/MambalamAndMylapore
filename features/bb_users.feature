Feature: Black Box testing for User Accounts


  Scenario: Listing all users
    Given User with following details creates an account using post call
      | uname | fname | lname | email | password_hash |
      | | vijayendran | gopalakrishnan | vijayendran3491@gmail.com | abcdf |
    And It should be successful
