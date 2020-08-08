Feature: E2EKey varification

Background:
	* call read('classpath:reusable.feature')

@E2EKey
Scenario: Generate modulus and exponent to validate OTP 
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/security/e2eKey' 
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	When method get 
	Then status 200
	* print response
	* match response.modulus == '#string'
	* match response.exponent == '#string'
	* print modulus = response.modulus
	* print exponent = response.exponent
	* print '********* Modulus and Exponent Generated *********'
	
	
