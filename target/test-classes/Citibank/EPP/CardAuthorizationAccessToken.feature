Feature: EPP CardAuthorization Access Token

  Background: 
    * call read('classpath:reusable.feature')

  @CardAuthAccessToken
  Scenario: fetch access token  using ControlFlowId
    #* call read('classpath:Citibank/EPP/CardAuthorization.feature')
    Given url 'https://qa.sandbox.apihub.citi.com/gcb/gp/api/cardAuth/oauth2/token/SG/gcb'
    And header Authorization = 'Basic MWFkMDE4NWItNTBmMi00ZjIxLThhYzMtZjM0MmU0NzA2ZTdlOmhBM2lIM2FBOGpDNW9BN2tZN2tCMGZWN3FHMHZKNWdON3BOM3dFM2VYOGlCMmpXNW1E'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And header Accept = 'application/json'
    And header uuid = randomString(20)
    And header client_id = '1ad0185b-50f2-4f21-8ac3-f342e4706e7e'
    And form field grant_type = 'card_authorization'
    And form field controlFlowId = ControlflowId1
    And form field linkageConfirmationCode = '987654'
    And form field scope = 'epp_booking'
    When method post
    Then status 200
    * print response
    * match response.token_type == '#string'
    * match response.access_token == '#string'
    * def tokenType = response.token_type
    * def accessToken = response.access_token
    * def access_token = tokenType+' '+accessToken
    * def refreshToken = response.refresh_token
    * def cardid = response.cardId
    * print 'CardId : '+cardid
    * print access_token
    * print refreshToken
    * print '*********AccessTokenGenerated*********'
