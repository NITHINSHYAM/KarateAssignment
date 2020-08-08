@Regression @CardAuth
Feature: POST-Client_Credentials

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @TC_001 @access_token @Positive
  Scenario: Initiate the Client_Credentials API with valid fields and verify the Expected Result
    Given url testData.baseURI + testData.CardAuthResource
    And header Authorization = testData.base64
    And header Content-Type = testData.Content_Type
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And form field grant_type = testData.Grant_Type
    And form field scope = testData.Scope
    When method post
    Then status 200
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.token_type == '#string'
    * match response.access_token == '#present'
    * def tokenType = response.token_type
    * def accessToken = response.access_token
    * def accessToken = tokenType+' '+accessToken
    * print accessToken
    * print '********* Access Token Generated *********'

  @TC_002 @CardAuthNegative @Negative
  Scenario: To verify the request with invalid grant_type as loan_authorization
    Given url testData.baseURI + testData.CardAuthResource
    And header Authorization = testData.base64
    And header Content-Type = testData.Content_Type
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And form field grant_type = testData.Invalid_Grant_Type
    And form field scope = testData.Scope
    When method post
    Then status 400
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.error == 'invalid_grant'
    * print '********* Bad Request *********'

  @TC_003 @CardAuthNegative @Negative
  Scenario: To verify the request with invalid scope as apis
    Given url testData.baseURI + testData.CardAuthResource
    And header Authorization = testData.base64
    And header Content-Type = testData.Content_Type
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And form field grant_type = testData.Grant_Type
    And form field scope = testData.Invalid_Scope
    When method post
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    Then status 400
    * print response
    * match response.error == 'invalid_scope'
    * print '********* Bad Request *********'
