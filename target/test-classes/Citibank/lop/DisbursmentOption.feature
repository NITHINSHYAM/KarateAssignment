Feature: Check disbursment option details

Background:
	* call read('classpath:reusable.feature')
@Disbursment
Scenario: check disbursment option of customer
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/accounts/'+accountId+'/loans/disbursementOptions' 
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	When method get
	Then status 200
	* print response
	* match response.disbursementOptions[0].disbursementOption == 'BANK_ACCOUNT'
	* print '********* DisbursmentOption Details checked *********'