Feature: Commande
    Scenario: Running greeting command
        When I run "php bin/console app:greeting"
        Then I should see "Hello World"