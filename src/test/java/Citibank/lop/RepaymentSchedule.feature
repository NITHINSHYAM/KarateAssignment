Feature: Check Monthly payment amount plan using AccountId and tenor

Background:
	* call read('classpath:reusable.feature')

@RePaymentSchedule
Scenario: check customer loan eligibility using access token
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/creditCards/'+accountId+'/easyPaymentPlans/repaymentSchedules?loanAmount=50000&tenor=6' 
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	When method get 
	Then status 200
	* print response
	* match response.eppAmortizationSchedule[0].installmentNumber == '1'
	* match response.eppAmortizationSchedule[1].installmentNumber == '2'
	* match response.eppAmortizationSchedule[2].installmentNumber == '3'
	* match response.eppAmortizationSchedule[3].installmentNumber == '4'
	* match response.eppAmortizationSchedule[4].installmentNumber == '5'
	* match response.eppAmortizationSchedule[5].installmentNumber == '6'
	* print '*********Checked reschedule payment plan using AccountId And Tenor*********'
	
	
