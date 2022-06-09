Feature: Display contactlist and check if list is sort is sorted

    Scenario: Check the contact list
        Given I have "listview" and "floatbutton"
        Then I have "tabbar"
        Then I tap "floatbutton"
        Then I scroll "tabview0" till "item30" is visible
        Then I have "tabbar1"
        Then I tap "tabbar1"
        Then I scroll "tabview1" till "item30" is visible
        Then I switch theme "theme"
        