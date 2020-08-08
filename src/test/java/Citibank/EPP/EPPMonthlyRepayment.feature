Feature: EPP Monthly plan

  Background: 
    * call read('classpath:reusable.feature')

  @EPPMonthlyRepayment
  Scenario: check monthly payment plan schedule
    #* call read('classpath:Citibank/EPP/CardAuthorization.feature')
    #* call read('classpath:Citibank/EPP/CardAuthorizationAccessToken.feature')
    #* call read('classpath:Citibank/EPP/RefreshAccessToken.feature')
    #* call read('classpath:Citibank/EPP/RevokeToken.feature')
    #* call read('classpath:Citibank/EPP/EPP_Plan.feature')
    Given url 'https://qa.sandbox.apihub.citi.com/gcb/gp/api/v1/creditCards/'+cardid+'/easyPaymentPlans/repaymentSchedules?tenor=12&loanAmount=100000'
    And header Authorization = access_token
    And header uuid = randomString(20)
    And header Accept = 'application/json'
    And header client_id = '1ad0185b-50f2-4f21-8ac3-f342e4706e7e'
    When method get
    Then status 200
    * print response
    * match response.eppAmortizationSchedule[0].installmentNumber == '1'
    * match response.eppAmortizationSchedule[1].installmentNumber == '2'
    * match response.eppAmortizationSchedule[2].installmentNumber == '3'
    * match response.eppAmortizationSchedule[3].installmentNumber == '4'
    * match response.eppAmortizationSchedule[4].installmentNumber == '5'
    * match response.eppAmortizationSchedule[5].installmentNumber == '6'
    * match response.eppAmortizationSchedule[6].installmentNumber == '7'
    * match response.eppAmortizationSchedule[7].installmentNumber == '8'
    * match response.eppAmortizationSchedule[8].installmentNumber == '9'
    * match response.eppAmortizationSchedule[9].installmentNumber == '10'
    * match response.eppAmortizationSchedule[10].installmentNumber == '11'
    * match response.eppAmortizationSchedule[11].installmentNumber == '12'
    * print '********* Checked Monthly repayment plan *********'
