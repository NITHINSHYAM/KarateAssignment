@Regression @GET_Account
Feature: GET_Account APIs

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @TC_007 @Accounts @Positive
  Scenario: Initiate the Account API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@ResourceOwner')
    Given url testData.baseURI + testData.Account_Resource
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
    * match response.accountGroupSummary == '#present'
    * match response.accountGroupSummary[0].accountGroup == 'SAVINGS_AND_INVESTMENTS'
    * match response.accountGroupSummary[1].accountGroup == 'CHECKING'
    * match response.accountGroupSummary[2].accountGroup == 'CREDIT_CARD'
    * def account_Id = response.accountGroupSummary[0].accounts[0].savingsAccountSummary.accountId
    * print 'Account Id : ' + account_Id
    * print '********* Account Summary Details Generated *********'

  @TC_008 @AccountsNegative @Negative
  Scenario: To verify the APIs request with invalid accessToken
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@ResourceOwner')
    Given url testData.baseURI + testData.Account_Resource
    And header Authorization = testData.Invalid_authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    When method get
    Then status 401
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'unAuthorized'
    * match response.code == '401'
    * match response.details == 'Authorization credentials are missing or invalid'
    * print '********* Account invalid Authorization Generated *********'

  @TC_009 @AccountsNegative @Negative
  Scenario: To verify the APIs request with invalid client_id
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@ResourceOwner')
    Given url testData.baseURI + testData.Account_Resource
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.Invalid_client_Id
    When method get
    Then status 401
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'unAuthorized'
    * match response.code == '401'
    * match response.details == 'Authorization credentials are missing or invalid'
    * print '********* Account invalid ClientId Generated *********'
