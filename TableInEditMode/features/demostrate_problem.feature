Feature: demonstrate the problem
  As an iOS developer
  I want to demonstrate my table-view query problem

  Background: put the table in non-edit mode and is scrolled to top
    Given that the table is not in edit mode
    Then I scroll up until I see the ":a" row limit 3

  Scenario: demonstrate touch behavior
    Then I touch row ":f"
    Then I should see that row ":f" has title "selected"
    Then I touch row ":g"
    Then I should see that row ":g" has title "selected"
    Then I should see that row ":f" has title "f"

  Scenario: demonstrate that the i row is visible, but not touchable
    # i can see the row - ideally this would fail because the horizontal
    # center of the row is hidden by the tabbar
    Then I should see row ":i"
    # i can see the row, but i cannot touch it
    Then I touch row ":i"
    Then I should see that row ":i" has title "selected"

  Scenario: demonstrate that the row is visible, but the row contents are not
    Then I scroll down
    # i can see the row - ideally this would fail because the horizontal
    # center of the row is hidden by the navigation bar
    Then I should see row ":d"
    Then I touch the edit button
    # i can see the row, but i cannot see the contents of the row (in this case
    # the edit-mode buttons
    Then I should be able to see the delete and reorder buttons in row ":d"






