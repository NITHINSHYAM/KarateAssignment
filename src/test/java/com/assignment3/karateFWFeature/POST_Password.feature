@Regression @Password
Feature: POST_Password

  Background: 
    * call read('classpath:reusable.feature')
    * def testData = read('classpath:com/assignment3/karateFW/testdata/testData.json')

  @e2eKey
  Scenario: Initiate the Password API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/POST-Client_Credentials.feature@access_token')
    Given url testData.baseURI + testData.e2eKey_Resource
    And header Authorization = accessToken
    And header client_id = testData.client_Id
    And header client_secret = testData.client_Secret
    And header uuid = randomString(20)
    And header Content-Type = testData.Content_Type_e2eKey
    And header Accept = testData.accept
    And header countryCode = testData.country_Code
    And header businessCode = testData.business_Code
    And header channelId = testData.channel_Id
    When method get
    Then status 200
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.modulus == '#present'
    * match response.exponent == '#string'
    * def biz_Token = responseHeaders['bizToken'][0]
    * print biz_Token
    * print '********* Modulus Exponent And bizToken Generated *********'

  @TC_004 @ResourceOwner @Positive
  Scenario: Initiate the Password API with valid fields and verify the Expected Result
    * call read('classpath:com/assignment3/karateFWFeature/POST-Client_Credentials.feature@access_token')
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@e2eKey')
    * print testData.baseURI + testData.ResourceOwner_Resource
    Given url testData.baseURI + testData.ResourceOwner_Resource
    And header Authorization = testData.base64
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header BizToken = biz_Token
    And header Content-Type = testData.Content_Type
    And form field grant_type = testData.ResourceOwner_Grant_Type
    And form field scope = testData.Scope
    And form field username = testData.Username
    And form field password = testData.encryptedStringPass
    When method post
    Then status 200
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.token_type == '#present'
    * match response.access_token == '#string'
    * def Re_tokenType = response.token_type
    * def Re_accessToken = response.access_token
    * print Re_tokenType
    * print Re_accessToken
    * def authorization = Re_tokenType+' '+Re_accessToken
    * print authorization
    * print '********* Resource Owner AccessToken Generated *********'

  @TC_005 @ResourceOwnerNegative @Negative
  Scenario: To verify the APIs request with invalid username
    * call read('classpath:com/assignment3/karateFWFeature/POST-Client_Credentials.feature@access_token')
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@e2eKey')
    * print testData.baseURI + testData.ResourceOwner_Resource
    Given url testData.baseURI + testData.ResourceOwner_Resource
    And header Authorization = testData.base64
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header BizToken = biz_Token
    And header Content-Type = testData.Content_Type
    And form field grant_type = testData.ResourceOwner_Grant_Type
    And form field scope = testData.Scope
    And form field username = testData.Invalid_Username
    And form field password = testData.encryptedStringPass
    When method post
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    Then status 401
    * print response
    * match response.type == 'invalid'
    * match response.code == '401'
    * match response.details == 'Authorization credentials are missing or invalid'
    * print '********* Resource Owner- Invalid Username *********'

  @TC_006 @ResourceOwnerNegative @Negative
  Scenario: To verify the APIs request with invalid username
    * call read('classpath:com/assignment3/karateFWFeature/POST-Client_Credentials.feature@access_token')
    * call read('classpath:com/assignment3/karateFWFeature/POST_Password.feature@e2eKey')
    * print testData.baseURI + testData.ResourceOwner_Resource
    Given url testData.baseURI + testData.ResourceOwner_Resource
    And header Authorization = testData.base64
    And header Accept = testData.accept
    And header uuid = randomString(20)
    And header BizToken = biz_Token
    And header Content-Type = testData.Content_Type
    And form field grant_type = testData.ResourceOwner_Grant_Type
    And form field scope = testData.Scope
    And form field username = testData.Username
    And form field password = testData.InvalidPass
    When method post
    Then status 401
    * print 'Response Time : ' + responseTime
    And assert responseTime < 10000
    And match responseType == 'json'
    * print response
    * match response.type == 'invalid'
    * match response.code == '401'
    * match response.details == 'Authorization credentials are missing or invalid'
    * print '********* Resource Owner- Invalid Password *********'
