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
    Given I send a GET request to "/api/v1/alerts"
    Then the response code should be "200"
    And the JSON response should be:
    """
      [
        { "resource_uri" : "api/v1/alerts/3021" },
        { "resource_uri" : "api/v1/alerts/4251" },
        { "resource_uri" : "api/v1/alerts/76894" },
        { "resource_uri" : "api/v1/alerts/566421" }
      ]
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