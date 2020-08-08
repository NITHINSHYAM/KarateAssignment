Feature: retrieve Access token


  Background:

    * call read('classpath:reusable.feature')

@PointsBalance
Scenario: Points Balance Inquiry
  Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/apac/rewards/'+rewardLinkCode+'/pointBalance'
  And header client_id = 'cf652567-f5be-4d34-a77f-98374ee4b293'
  And header uuid = randomString(20)
  And header Accept = 'application/json'
  And header Content-Type = 'application/json'
  And header Authorization = accessToken
  When method get
  Then status 200
  * print response
  And match response.maximumPointsToRedeem == 15000
  And match response.minimumPointsToRedeem == 100
  And match response.currencyCode == 'HKD'
