@citisandbox_api @Transactions
Feature: GET_Transactions APIs

  Background:
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @Transactions_Positive
  Scenario: Initiate the Transactions API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karate_Sathya/Accounts_API.feature@Accounts_Positive')
    Given url testData.baseURI + testData.TransactionResource+account_Id+testData.TransactionResource1+testData.transaction_Status
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    When method get
    Then status 200
    And match responseType == 'json'
    * print response
    * print response.transactions[0]
    * print '********* Transactions Details Generated *********'

  @Transactions_Negative
  Scenario: To verify the APIs request with invalid accountid
    * call read('classpath:com/assignment3/karate_Sathya/Accounts_API.feature@Accounts_Positive')
    Given url testData.baseURI + testData.TransactionResource+testData.invalid_accountId+testData.TransactionResource1+testData.transaction_Status
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    When method get
    Then status 400
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == 'invalidRequest'
    * match response.details == 'Missing or invalid Parameters'
    * print '********* Transactions invalid AccountId *********'