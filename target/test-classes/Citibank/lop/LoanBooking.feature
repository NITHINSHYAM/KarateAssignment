Feature: Loan booking using accountId and payload

Background: 
	* call read('classpath:reusable.feature')
* def loanBookingRequest = read('classpath:Citibank/lop/LoanBookingRequest.json')
@LoanBooking 
Scenario: check customer loan eligibility using access token 
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/accounts/'+accountId+'/loans/bookings' 
	And header Authorization = access_token 
	And header uuid = randomString(20) 
	And header Accept = 'application/json' 
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9' 
	And header Content-Type = 'application/json' 
	And request loanBookingRequest 
	When method post 
	Then status 403 
	* print response 
	* match response.moreInfo.controlFlowId == '#string' 
	* def loanBookingControlFlowId = response.moreInfo.controlFlowId 
	* print loanBookingControlFlowId
	* print '********* Loan Booked And Control FlowId Generated *********'