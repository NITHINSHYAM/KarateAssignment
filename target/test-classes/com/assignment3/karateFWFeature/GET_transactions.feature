@Regression @GET_Transactions
Feature: GET_Transactions APIs

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @TC_012 @Transactions @Positive
  Scenario: Initiate the Transactions API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/GET_Account.feature@Accounts')
    Given url testData.baseURI + testData.TransactionResource+account_Id+testData.TransactionResource1+testData.transaction_Status
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
    * print response.transactions[0]
    * print '********* Transactions Details Generated *********'

  @TC_013 @TransactionsNegative @Negative
  Scenario: Initiate the Transactions API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/GET_Account.feature@Accounts')
    Given url testData.baseURI + testData.TransactionResource+testData.invalidCoountId+testData.TransactionResource1+testData.transaction_Status
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
    * match response.details == 'Missing or invalid Parameters'
    * print '********* Transactions invalidCoountId *********'

  @TC_014 @TransactionsNegative @Negative
  Scenario: Initiate the Transactions API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/GET_Account.feature@Accounts')
    Given url testData.baseURI + testData.TransactionResource+account_Id+testData.TransactionResource1+testData.invalid_Transaction_Status
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
    * match response.details == 'Missing or invalid Parameters'
    * print '********* Transactions invalidCoountId *********'
