Feature: EPP Revoke Access Token

  Background: 
    * call read('classpath:reusable.feature')

  @RevokeToken
  Scenario: Refresh the access token
   # * call read('classpath:Citibank/EPP/CardAuthorization.feature')
    #* call read('classpath:Citibank/EPP/CardAuthorizationAccessToken.feature')
    #* call read('classpath:Citibank/EPP/RefreshAccessToken.feature')
    Given url 'https://qa.sandbox.apihub.citi.com/gcb/gp/api/cardAuth/oauth2/revoke'
    And header Authorization = 'Basic MWFkMDE4NWItNTBmMi00ZjIxLThhYzMtZjM0MmU0NzA2ZTdlOmhBM2lIM2FBOGpDNW9BN2tZN2tCMGZWN3FHMHZKNWdON3BOM3dFM2VYOGlCMmpXNW1E'
    And header client_id = '1ad0185b-50f2-4f21-8ac3-f342e4706e7e'
    And header uuid = randomString(20)
    And header Accept = 'application/json'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field token = refreshAccessToken
    And form field token_type_hint = 'access_token'
    When method post
    Then status 200
    * print response
    * print '*********Revoked Token *********'
