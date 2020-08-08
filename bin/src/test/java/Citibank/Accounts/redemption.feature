Feature: Redeem points Balance


  Background:

    * call read('classpath:reusable.feature')
    * def redemptionRequest = read('classpath:Citibank/Accounts/redemptionRequest.json')

  @redemption
  Scenario: Redemption
    * call read('classpath:Citibank/Accounts/accessToken.feature')
    * call read('classpath:Citibank/Accounts/rewardlinkage.feature')
    * call read('classpath:Citibank/Accounts/rewardLinkageActivation.feature')
    * call read('classpath:Citibank/Accounts/pointBalanceInquiry.feature')
    Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/apac/rewards/'+rewardLinkCode+'/redemption'
    And header client_id = 'cf652567-f5be-4d34-a77f-98374ee4b293'
    And header uuid = randomString(20)
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And header Authorization = accessToken
    And request redemptionRequest
    When method post
    Then status 200
    * print response
    And match response.orderId == '#string'
   * def availablePointBalance = response.availablePointBalance
   * def pointsAfterRedemption = call read('classpath:Citibank/Accounts/pointBalanceInquiry.feature')
   And match pointsAfterRedemption.availablePointBalance == availablePointBalance
    * print availablePointBalance
    * print pointsAfterRedemption.availablePointBalance



