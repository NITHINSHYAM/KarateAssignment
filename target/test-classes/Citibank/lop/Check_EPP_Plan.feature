Feature: Check Monthlypayment pplan based on tenor using AccountId

Background:
	* call read('classpath:reusable.feature')

@EasyPaymentPlan
Scenario: check customer loan eligibility using access token
	#* call read('classpath:Citibank/lop/CardAuthorization.feature')
	#* call read('classpath:Citibank/lop/CardAuthorizationAccessToken.feature')
	#* call read('classpath:Citibank/lop/Loan_Eligibility.feature')
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/creditCards/'+accountId+'/transactions/eligibility/easyPaymentPlan?eligbleLoanAmount=50000' 
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	When method get 
	Then status 200
	* print response
	* match response.easyPaymentPlan[0].tenor == '3'
	* match response.easyPaymentPlan[1].tenor == '6'
	* match response.easyPaymentPlan[2].tenor == '12'
	* match response.easyPaymentPlan[3].tenor == '24'
	* print '*********Checked Easy payment plan using AccountId*********'
	
	