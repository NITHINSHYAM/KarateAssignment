Feature: LOP Summary 

Background: 
	* call read('classpath:reusable.feature')
	
@LOPSummary 
Scenario: check LOP Summary Details 
	
	Given url 'https://sandbox.apihub.citi.com/gcb/api/v1/accounts/'+accountId+'/loans' 
	And header Authorization = access_token 
	And header uuid = randomString(20) 
	And header Accept = 'application/json' 
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9' 
	When method get 
	Then status 200 
	* print response 
	* match response.loans[0].loanReferenceId == '#present'
	* def SumLoanReferenceId = response.loans[0].loanReferenceId 
	* print SumLoanReferenceId 
	* print '********* Summary LoanReferenceId Generated *********' 
	
	
