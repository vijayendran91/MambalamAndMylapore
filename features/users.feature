Feature: User Accounts

  Scenario: User creates an account
    Given User with following details creates an account
      | uname | fname | lname | email | password_hash |
      | vijayendran3491 | vijayendran | gopalakrishnan | vijayendran3491@gmail.com | abcdf |
    And I get user details for username "vijayendran3491" successfully

  # Scenario: User Signs up without Username
  #   Given User with following details does not create an account
  #     | uname | fname | lname | email | password_hash |
  #     | vijayendran | gopalakrishnan | vijayendran3491 | abcdf |

  # Scenario: User provides Invalid values as Input for Username
  #   Given User with following details does not create an account
  #     | uname | fname | lname | email | password_hash |
  #     | vijayendran | gopalakrishnan | vijayendran3491 | abcdf |
  #
  #
  #   Given User with following details does not create an account
  # Scenario: User Signs up without email id
  #     | uname | fname | lname | email | password_hash |
  #     | vijayendran3491 | vijayendran | gopalakrishnan | vijayendran3491 | abcdf |

  Scenario: Listing all users
    Given User with following details cretes an account using post call
      | uname | fname | lname | email | password_hash |
      | vijayendran3491 | vijayendran | gopalakrishnan | vijayendran3491@gmail.com | abcdf |
    Given I visit "/v1/api/users"
