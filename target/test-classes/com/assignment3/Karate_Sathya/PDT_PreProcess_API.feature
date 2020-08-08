@citisandbox_api @PDT_PreProcess
Feature: POST_PDT-PreProcess APIs

  Background:
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')
    * def PDT_PreProcess_Payload = read('classpath:com/assignment3/karateFW/testData/PDT_preProcess_payload.json')

  @PDT_PreProcess_Positive
  Scenario: Initiate the PDT-PreProcessAPI with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karate_Sathya/PDT_Eligibility_API.feature@PDT_Eligibility_Positive')
    Given url testData.baseURI + testData.PDT_Preprocess_Resource
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    And header Content-Type = testData.Content_Type_PDT
    * set PDT_PreProcess_Payload.sourceAccountId = source_AccountId
    * set PDT_PreProcess_Payload.transactionAmount = testData.transaction_Amount
    * set PDT_PreProcess_Payload.destinationAccountId = destination_AccountId
    * print 'POST_PDT-PreProcess Payload Request : ' + PDT_PreProcess_Payload
    And request PDT_PreProcess_Payload
    When method post
    Then status 200
    And match responseType == 'json'
    * print response
    * match response.controlFlowId == '#present'
    * print 'control FlowId Generated : ' + response.controlFlowId
    * match response.debitDetails == '#present'
    * match response.debitDetails.transactionDebitAmount == '#number'
    * match response.debitDetails.currencyCode == 'BHD'
    * match response.creditDetails == '#present'
    * match response.creditDetails.transactionCreditAmount == '#number'
    * match response.creditDetails.currencyCode == 'BHD'
    * match response.foreignExchangeRate == '#notnull'
    * match response.transactionFee == '#present'
    * match response.feeCurrencyCode == 'BHD'
    * def Control_Flow_Id = response.controlFlowId
    * print Control_Flow_Id
    * print '********* PDT-PreProcess Done *********'

 @PDT_PreProcess_Negative
  Scenario: To verify the PDT-PreProcess API with invalid sourceAccountId
    * call read('classpath:com/assignment3/karate_Sathya/PDT_Eligibility_API.feature@PDT_Eligibility_Positive')
    Given url testData.baseURI + testData.PDT_Preprocess_Resource
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    And header Content-Type = testData.Content_Type_PDT
    * set PDT_PreProcess_Payload.sourceAccountId = testData.invalid_source_AccountId
    * set PDT_PreProcess_Payload.transactionAmount = testData.transaction_Amount
    * set PDT_PreProcess_Payload.destinationAccountId = destination_AccountId
    * print 'POST_PDT-PreProcess Payload Request : ' + PDT_PreProcess_Payload
    And request PDT_PreProcess_Payload
    When method post
    Then status 400
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == 'invalidRequest'
    * match response.details == 'Missing or invalid Parameters'
    * print '********* PDT-PreProcess with invalid_source_AccountId  *********'