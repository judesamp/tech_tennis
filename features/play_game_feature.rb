Feature: match begins
	As a tennis player (and student of the web)
	I want to defeat my opponent (and do a little studying at the same time)
	So that I can move on to the next round and learn a little HTML and CSS
	Scenario: Opponent serves
	Given I am ready to play and started tech_tennis
	When my match starts
	Then I should see an alert
	And I should see a question.