Feature: Schedule booked loan repayment plan using AccountId, Amount and tenor

Background:
	* call read('classpath:reusable.feature')

@RePaymentSchedule
Scenario: Verify the booked loan amount monthly schedule
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/accounts/'+accountId+'/loans/repaymentSchedules?loanAmount=60000&tenor=12' 
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	When method get 
	Then status 200
	* print response
	* match response.amortizationSchedule[0].installmentNumber == '1'
	* match response.amortizationSchedule[1].installmentNumber == '2'
	* match response.amortizationSchedule[2].installmentNumber == '3'
	* match response.amortizationSchedule[3].installmentNumber == '4'
	* match response.amortizationSchedule[4].installmentNumber == '5'
	* match response.amortizationSchedule[5].installmentNumber == '6'
	* match response.amortizationSchedule[6].installmentNumber == '7'
	* match response.amortizationSchedule[7].installmentNumber == '8'
	* match response.amortizationSchedule[8].installmentNumber == '9'
	* match response.amortizationSchedule[9].installmentNumber == '10'
	* match response.amortizationSchedule[10].installmentNumber == '11'
	* match response.amortizationSchedule[11].installmentNumber == '12'
	* print '*********Checked repayment Schedule plan for particular customer using AccountId And Tenor*********'
	
	
