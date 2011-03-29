Feature: Manage users
  In order to [goal]
  [stakeholder]
  wants [behaviour]
  
  Scenario: Register new user
    Given I am on the new user page
    When I fill in "First name" with "first_name 1"
    And I fill in "Last name" with "last_name 1"
    And I press "Create"
    Then I should see "first_name 1"
    And I should see "last_name 1"

#  Scenario: Delete user
#    Given the following users:
#      |first_name|last_name|
#      |first_name 1|last_name 1|
#      |first_name 2|last_name 2|
#      |first_name 3|last_name 3|
#      |first_name 4|last_name 4|
#    When I delete the 3rd user
#    Then I should see the following users:
#      |First name|Last name|
#      |first_name 1|last_name 1|
#      |first_name 2|last_name 2|
#      |first_name 4|last_name 4|
