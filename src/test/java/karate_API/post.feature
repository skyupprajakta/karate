Feature: API testing using POST method

Background: 
    *url 'https://restful-booker.herokuapp.com/'
    
Scenario: Verify whether the all data getting Retrived
    Given path 'booking'
    When method GET
    Then status 200

Scenario: Verify whether the booking id successfully getting Created
    Given path 'booking'
    #payload
    And request
      """
      {
      "firstname" : "Karate API 123",
      "lastname" : "WU",
      "totalprice" : 123,
      "depositpaid" : true,
      "bookingdates" : {
          "checkin" : "2018-01-01",
          "checkout" : "2019-01-01"
      },
      "additionalneeds" : "Breakfast"
      }
      """
    When method POST
    Then status 200
    Then match response.firstname=="Karate API 123"
    
    * def bookingId= response.id
    
Scenario: Verify whether the booking id successfully getting Retrieve
    
    Given path 'booking/' + bookingId
    When method GET
    Then status 200
    
Scenario: Verify whether the booking id successfully getting Updated
    
    Given path 'booking/' + bookingId
    #payload
    And request
      """
      {
      "firstname" : "Updated Karate API 123",
      "lastname" : "Updated WU",
      "totalprice" : 123,
      "depositpaid" : true,
      "bookingdates" : {
          "checkin" : "2018-01-01",
          "checkout" : "2019-01-01"
      },
      "additionalneeds" : "Breakfast"
      }
      """
    When method PATCH
    Then status 200
    Then match response=="#object"
    Then match response.firstname!="Karate API 123"
    
    
Scenario: Verify whether the booking id successfully getting deleted
     Given path 'booking/' + bookingId
     When method DELETE
     Then status 200
     And response=="#null"
  
