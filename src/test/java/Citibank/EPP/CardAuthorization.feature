Feature: EPP CardAuthorization

  Background: 
    * call read('classpath:reusable.feature')
    * def CardAuthRequest = read('classpath:Citibank/EPP/CardAuthorizationRequest.json')
    * def testData = read('classpath:Citibank/EPP/TestData.json')

  @CardAuthorization
  Scenario: Get control flowId Using Authorization request payload
    Given url 'https://qa.sandbox.apihub.citi.com/gcb/gp/api/cardAuth/oauth2/authorize/SG/gcb'
    And header Authorization = testData.Auth
    And header uuid = randomString(20)
    And header Content-Type = testData.content_type
    And header Accept = testData.Accept
    
    And header client_id = testData.clientId
    And request CardAuthRequest
    When method post
    Then status 403
    * print response
    * def ControlflowId1 = response.moreInfo.controlFlowId
    * match ControlflowId1 == '#present'
    * print ControlflowId1
    * print '*********ControlFlowIdGenerated*********'
