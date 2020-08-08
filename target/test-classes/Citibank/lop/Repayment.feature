Feature: Repayment

Background:
	* call read('classpath:reusable.feature')
	
@NextRepayment
Scenario: Upcomming next Payment details
	* call read('classpath:Citibank/lop/CardAuthorization.feature')
	* call read('classpath:Citibank/lop/CardAuthorizationAccessToken.feature')
	* call read('classpath:Citibank/lop/Loan_Eligibility.feature')
	* call read('classpath:Citibank/lop/Check_EPP_Plan.feature')
	* call read('classpath:Citibank/lop/RepaymentSchedule.feature')
	* call read('classpath:Citibank/lop/LoanBooking.feature')
	* call read('classpath:Citibank/lop/DisbursmentOption.feature')
	* call read('classpath:Citibank/lop/BookedLoanRepayment.feature')
	* call read('classpath:Citibank/lop/E2E_Key.feature')
	* call read('classpath:Citibank/lop/ValidateOTP.feature')
	* call read('classpath:Citibank/lop/LoanBookingConfirmation.feature')
	* call read('classpath:Citibank/lop/LOPSummary.feature')
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/accounts/loans/'+SumLoanReferenceId+'/repaymentSchedules'
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	When method get
	Then status 200
	* print response
	* match response.amortizationSchedule[0].installmentNumber == '1'
	* print '********* Upcomming Payments details Generated *********'
	
	
