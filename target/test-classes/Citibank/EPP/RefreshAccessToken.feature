Feature: EPP CardAuthorization Refresh Access Tolen

  Background: 
    * call read('classpath:reusable.feature')

  @RefreshToken
  Scenario: Refresh the access token
    #* call read('classpath:Citibank/EPP/CardAuthorization.feature')
    #* call read('classpath:Citibank/EPP/CardAuthorizationAccessToken.feature')
    Given url 'https://qa.sandbox.apihub.citi.com/gcb/gp/api/cardAuth/oauth2/refresh'
    And header Authorization = 'Basic MWFkMDE4NWItNTBmMi00ZjIxLThhYzMtZjM0MmU0NzA2ZTdlOmhBM2lIM2FBOGpDNW9BN2tZN2tCMGZWN3FHMHZKNWdON3BOM3dFM2VYOGlCMmpXNW1E'
    And header client_id = '1ad0185b-50f2-4f21-8ac3-f342e4706e7e'
    And header uuid = randomString(20)
    And header Accept = 'application/json'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'refresh_token'
    And form field refresh_token = refreshToken
    When method post
    Then status 200
    * print response
    * match response.refresh_token == '#string'
    * match response.refresh_token_expires_in == '#number'
    
    * def refreshAccessToken = response.access_token
    * def refreshTokenType = response.token_type
    * def refresh_access_token = refreshTokenType+' '+refreshAccessToken
    * print 'Refresh Access Token : '+refresh_access_token
    * def refreshTokenNew = response.refresh_token
    * def resfreshTokenExpireIn = response.refresh_token_expires_in
    * print 'Refresh Access Token : '+refreshTokenNew
    * print 'Expiration Duration : '+resfreshTokenExpireIn
    * print '*********Refresh Token Generated*********'
