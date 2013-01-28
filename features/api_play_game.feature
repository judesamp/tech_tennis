@alerts
Feature: Retrieving System Alerts
  As a API user
  In order to display general system messages in my app
  I want to retrieve all current system alerts
  
  Background:
    Given I am a valid API user
    And I send and accept JSON
    And there are four system alerts
  
  Scenario: Retrieving a resource list of alerts
    Given I send a GET request to "/api/v1/start"
    Then the response code should be "200"
    And the JSON response should be:
    """
      { "game" : [
        { "game_id" : "2" },
		{ "current_role": "2"},
        { "user_score": "2"},
        { "user_game": "2"},
        { "user_set": "2"},
        { "opponent_score": "2"},
        { "opponent_game": "2"},
        { "opponent_set": "2"},
        { "completed_in": "2"},
        { "leftover_time": "2"},
        { "last_result": "2"},
        { "id": "2"},
        { "question": "2"},
        { "answer_option_a": "2"},
        { "answer_option_b": "2"},
        { "answer_option_c": "2"},
        { "answer_option_d": "2"},
        { "current_quiz_type": "2"},
        { "times_asked": "2"},
        { "game_id": "2"}
		]
      }
    """
    
  Scenario: Retrieving a specific alert
    Given I send a GET request to "/api/v1/alerts/3021"
    Then the response code should be "200"
    And the JSON response should be:
    """
      {
        "date_posted" : "2012-06-30T14:23:45Z",
        "date_expires" : "2012-07-02T00:00:00Z",
        "message": "The auth server will be <b>offline</b> from 3am to 5am.",
        "links": {
          "self": { "href": "api/v1/alerts/3021" },
          "index": { "href": "api/v1/alerts" }
        }
      }
    """