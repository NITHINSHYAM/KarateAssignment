@Regression @GET_Card
Feature: GET_Card APIs

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @TC_010 @Card @Positive
  Scenario: Initiate the GET_Card API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@ResourceOwner')
    Given url testData.baseURI + testData.Card_Resource +testData.CardFunction
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    When method get
    Then status 200
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.cardDetails == '#present'
    * match response.cardDetails[0].cardId == '#notnull'
    * def card_Id = response.cardDetails[0].cardId
    * print card_Id
    * print '********* Cards Details Generated *********'

  @TC_011 @CardNegative @Negative
  Scenario: To verify the APIs request with invalid cardFunction
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@ResourceOwner')
    Given url testData.baseURI + testData.Card_Resource +testData.Invalid_CardFunction
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    When method get
    Then status 400
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == 'invalidRequest'
    * match response.details == 'Missing or invalid parameters'
    * print '********* Cards Invalid card function *********'
