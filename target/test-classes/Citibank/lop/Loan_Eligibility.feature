Feature: Loan Eligibility using Access Token

Background: 
	* call read('classpath:reusable.feature')

@LoanEligibility
Scenario: check customer loan eligibility using access token
	#* call read('classpath:Citibank/lop/CardAuthorization.feature')
	#* call read('classpath:Citibank/lop/CardAuthorizationAccessToken.feature')
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/accounts/loans/eligibility' 
	And header Authorization = access_token
	And header uuid = randomString(20)
	 And header Accept = 'application/json'
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	When method get 
	Then status 200
	* print response
	* match response.loanEligibilityDetails[0].displayAccountNumber == '#string'
	* match response.loanEligibilityDetails[0].accountId == '#present'
	* match response.loanEligibilityDetails[0].maximumEligibleLoanAmount == 500000
	* match response.loanEligibilityDetails[0].minimumEligibleLoanAmount == 50000
	* def displayAccountNumber = response.loanEligibilityDetails[0].displayAccountNumber
	* def accountId = response.loanEligibilityDetails[0].accountId
	* def maximumEligibleLoanAmount = response.loanEligibilityDetails[0].maximumEligibleLoanAmount
	* def minimumEligibleLoanAmount = response.loanEligibilityDetails[0].minimumEligibleLoanAmount
	* print displayAccountNumber
	* print accountId
	* print maximumEligibleLoanAmount
	* print minimumEligibleLoanAmount
	* print '********* Checked Loan Eligibility And AccountId Generated *********'