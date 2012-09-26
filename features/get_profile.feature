Feature: after greeting, play as guest or create profile
	As an interested party
	I want to play some Tech Tennis
	So that I can have fun and learn a little about HTML, CSS, and Ruby
	Scenario:
	Given I have arrived at Tech Tennis site
	When my page loads
	Then I should see a welcome message
	And I should have the option to play as a guest or create a profile