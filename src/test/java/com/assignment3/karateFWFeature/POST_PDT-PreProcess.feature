@Regression @POST_PDT_PreProcess
Feature: POST_PDT-PreProcess APIs

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')
    * def PDT_PreProcess_Payload = read('classpath:com/assignment3/karateFW/testData/PDT_preProcess_payload.json')

  @TC_017 @PDT_Eligibility @Positive
  Scenario: Initiate the PDT-PreProcessAPI with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/GET_PDT-Eligibility.feature@PDT_Eligibility')
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
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
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
    * print '********* PDT-PreProcess Done *********'

  @TC_018 @PDT_EligibilityNegative @Negative
  Scenario: To verify the PDT-PreProcess API with invalid sourceAccountId
    * call read('classpath:com/assignment3/karateFWFeature/GET_PDT-Eligibility.feature@PDT_Eligibility')
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
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == 'invalidRequest'
    * match response.details == 'Missing or invalid Parameters'
    * print '********* PDT-PreProcess with invalid_source_AccountId  *********'

  @TC_019 @PDT_EligibilityNegative @Negative
  Scenario: To verify the PDT-PreProcess API with invalid destinationAccountId
    * call read('classpath:com/assignment3/karateFWFeature/GET_PDT-Eligibility.feature@PDT_Eligibility')
    Given url testData.baseURI + testData.PDT_Preprocess_Resource
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    And header Content-Type = testData.Content_Type_PDT
    * set PDT_PreProcess_Payload.sourceAccountId = source_AccountId
    * set PDT_PreProcess_Payload.transactionAmount = testData.transaction_Amount
    * set PDT_PreProcess_Payload.destinationAccountId = testData.invalid_destination_AccountId
    * print 'POST_PDT-PreProcess Payload Request : ' + PDT_PreProcess_Payload
    And request PDT_PreProcess_Payload
    When method post
    Then status 400
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == 'invalidRequest'
    * match response.details == 'Missing or invalid Parameters'
    * print '********* PDT-PreProcess with invalid_destination_AccountId  *********'

  @TC_020 @PDT_EligibilityNegative @Negative
  Scenario: To verify the PDT-PreProcess API with invalid chargeBearer
    * call read('classpath:com/assignment3/karateFWFeature/GET_PDT-Eligibility.feature@PDT_Eligibility')
    Given url testData.baseURI + testData.PDT_Preprocess_Resource
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    And header Content-Type = testData.Content_Type_PDT
    * set PDT_PreProcess_Payload.sourceAccountId = source_AccountId
    * set PDT_PreProcess_Payload.transactionAmount = testData.transaction_Amount
    * set PDT_PreProcess_Payload.destinationAccountId = destination_AccountId
    * set PDT_PreProcess_Payload.chargeBearer = testData.invalid_chargeBearer
    * print 'POST_PDT-PreProcess Payload Request : ' + PDT_PreProcess_Payload
    And request PDT_PreProcess_Payload
    When method post
    Then status 400
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == 'invalidRequest'
    * match response.details == 'Missing or invalid Parameters'
    * print '********* PDT-PreProcess with invalid_chargeBearer  *********'
