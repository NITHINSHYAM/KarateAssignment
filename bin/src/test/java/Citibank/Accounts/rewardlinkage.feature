Feature: retrieve Access token
  Background:

    * call read('classpath:reusable.feature')
    * def payloadRequest = read('classpath:Citibank/Accounts/payload.json')

  @rewardlinkage
  Scenario:  fetch access token  from  Citi BANK
    Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/apac/rewards/linkage'
    And header client_id = 'cf652567-f5be-4d34-a77f-98374ee4b293'
    And header uuid = randomString(20)
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And header Authorization = accessToken
    And request payloadRequest
    When method post
    Then status 200
    * print response
    * def rewardLinkCode = response.rewardLinkCode
