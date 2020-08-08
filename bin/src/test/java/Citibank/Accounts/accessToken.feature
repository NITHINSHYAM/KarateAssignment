Feature: retrieve Access token


  Background: 
     
     * call read('classpath:reusable.feature')


  @accessToken
  Scenario:  fetch access token  from  Citi BANK
    Given url 'https://sandbox.apihub.citi.com/gcb/api/clientCredentials/oauth2/token/hk/gcb'
    And header Authorization = 'Basic Y2Y2NTI1NjctZjViZS00ZDM0LWE3N2YtOTgzNzRlZTRiMjkzOkMxc0swak8xdFIyeUMxZU42ck4wZUswZ003eFA4ZUQ3dE81ckw1b0czeVkzeUo0ZFQ0'
    And header uuid = randomString(20)
    * print randomString(20)
    And header Accept = 'application/json'
    And header Content-Type = 'application/x-www-form-urlencoded'
    And form field grant_type = 'client_credentials'
    And form field scope = '/api'
    When method post
    Then status 200
    * print response.access_token
    * def accessToken = 'Bearer ' +response.access_token
    * print accessToken
