Feature:  Varify Loan Booking confirmation

Background:
	* call read('classpath:reusable.feature')
	

@LoanBookingConfirmation
Scenario: varify the loan booking confirmation after OTP varification
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
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/accounts/loans/bookings/confirmation'
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	And header Content-Type = 'application/json'
	* def loanBookingConfirm = read('classpath:Citibank/lop/LoanBookingConfirmation.json')
	* set loanBookingConfirm.controlFlowId = loanBookingControlFlowId
	* print loanBookingConfirm
	And request loanBookingConfirm
	When method post
	Then status 200
	* print response
	* def LoanReferenceId = response.loanReferenceId
	* match response.loanReferenceId == '#present'
	* print LoanReferenceId
	* print '********* LoanReferenceId Generated *********'
	
	
