@citisandbox_api @PDT_Confirmation
Feature: POST_PDT-Confirmation APIs

  Background:
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @PDT_Confirmation_Positive
  Scenario: Initiate the PDT-ConfirmationAPI with valid fields and verify the Expected Result
      * call read('classpath:com/assignment3/karate_Sathya/PDT_PreProcess_API.feature@PDT_PreProcess_Positive')
      Given url testData.baseURI + testData.PDT_Confirmation_Resource
      And header Authorization = authorization
      And header Accept = testData.accept
      And header uuid = randomString(20)
      And header client_id = testData.client_Id
      And header Content-Type = testData.Content_Type_PDT
      #set controlflowid = Control_Flow_Id#
      * print Control_Flow_Id
      And request { controlFlowId: '#(Control_Flow_Id)'}
      When method post
      Then status 200
      And match responseType == 'json'
      * print response
      And match response.transactionReferenceId == '#present'
      * print "************ PDT_Confirmation process Completed *************"

  @PDT_Confirmation_Negative
  Scenario: To verify the APIs request with invalid controlFlowId
    * call read('classpath:com/assignment3/karate_Sathya/PDT_PreProcess_API.feature@PDT_PreProcess_Positive')
    Given url testData.baseURI + testData.PDT_Confirmation_Resource
    And header Authorization = authorization
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header client_id = testData.client_Id
    And header Content-Type = testData.Content_Type_PDT
    And request { controlFlowId: '#(invalid_controlflowid)'}
    When method post
    Then status 400
    And match responseType == 'json'
    * print response
    * match response.type == 'error'
    * match response.code == 'invalidControlFlowId'
    * match response.details == 'Control flow ID is invalid'
    * print '********* PDT-Confirmation with invalid_controlFlowId  *********'

