Feature: retrieve Access token
  Background:

    * call read('classpath:reusable.feature')


  @rewardActivation
  Scenario:  fetch access token  from  Citi BANK
    Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/apac/rewards/'+rewardLinkCode+'/activations'
    And header client_id = 'cf652567-f5be-4d34-a77f-98374ee4b293'
    And header uuid = randomString(20)
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And header Authorization = accessToken
    And request {linkageConfirmationCode: '987654' }
    When method put
    Then status 200
    * print response
