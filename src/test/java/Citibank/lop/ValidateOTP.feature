Feature: Verify OTP Validation

Background:
	* call read('classpath:reusable.feature')
	* def otpRequest = read('classpath:Citibank/lop/OTPValidationRequest.json')

@OTPValidation
Scenario: verify otp Validation
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/mfa/otp'
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	And header Content-Type = 'application/json'
	* set otpRequest.controlFlowId = loanBookingControlFlowId
	* print otpRequest
	And request otpRequest
	When method put
	Then status 200
	* print '********* Verified OTP *********'
	
	
