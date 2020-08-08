@Regression @GET_PDT_Eligibility
Feature: GET_PDT-Eligibility APIs

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @TC_015 @PDT_Eligibility @Positive
  Scenario: Initiate the sourceAccounts & destination Eligibility API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@ResourceOwner')
    Given url testData.baseURI + testData.PDT_Eligibility_Resource
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
    * match response.sourceAccounts == '#present'
    * match response.destinationSourceAcctCombinations == '#present'
    * def source_AccountId = response.sourceAccounts[1].sourceAccountId
    * def destination_AccountId = response.destinationSourceAcctCombinations[0].destinationAccountId
    * print 'sourceAccountId : ' + source_AccountId
    * print 'destinationAccountId : '+ destination_AccountId
    * print '********* Check PDT_Eligibility Details *********'

  @TC_016 @PDT_EligibilityNegative @Negative
  Scenario: To verify the sourceAccounts & destination Eligibility API with invalid accessToken
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@ResourceOwner')
    Given url testData.baseURI + testData.PDT_Eligibility_Resource
    And header Authorization = testData.invalid_authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    When method get
    Then status 401
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'error'
    * match response.code == 'unAuthorized'
    * match response.details == 'Authorization credential is missing or invalid'
    * print '********* Check PDT_Eligibility with invalid_authorization Details *********'
