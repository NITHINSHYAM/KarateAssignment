Feature: EPP Booking

  Background: 
    * call read('classpath:reusable.feature')
    * def eppBookingPayload = read('classpath:Citibank/EPP/EPP_BookingPayload.json')

  @EPPBooking
  Scenario: check monthly payment plan schedule
    * call read('classpath:Citibank/EPP/CardAuthorization.feature')
    * call read('classpath:Citibank/EPP/CardAuthorizationAccessToken.feature')
    * call read('classpath:Citibank/EPP/RefreshAccessToken.feature')
    * call read('classpath:Citibank/EPP/RevokeToken.feature')
    * call read('classpath:Citibank/EPP/EPP_Plan.feature')
    * call read('classpath:Citibank/EPP/EPPMonthlyRepayment.feature')
    Given url 'https://qa.sandbox.apihub.citi.com/gcb/gp/api/v1/creditCards/'+cardid+'/easyPaymentPlans/bookings'
    And header Authorization = access_token
    And header client_id = '1ad0185b-50f2-4f21-8ac3-f342e4706e7e'
    And header uuid = randomString(20)
    And header Accept = 'application/json'
    And header Content-Type = 'application/json'
    And request eppBookingPayload
    When method post
    Then status 200
    * print response
    * print '********* EPP Booked *********'
