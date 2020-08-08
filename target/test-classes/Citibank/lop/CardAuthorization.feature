Feature: Get control flowId Using Authorization request payload 

Background: 

	* call read('classpath:reusable.feature')
     * def CardAuthRequest = read('classpath:Citibank/lop/CardAuthorizationRequest.json')

@CardAuthorization
Scenario: fetch ControlflowId  from  Citi BANK Sandbox

	Given url 'https://sandbox.apihub.citi.com/gcb/api/cardAuth/oauth2/authorize/sg/gcb' 
	And header Authorization = 'Basic ZjJmMDhjMTQtOGU1My00YjEzLTg2MmMtYmRmMTgyZDQ2ZGY5Olk4eVAzYk43Z1MzbFEwYUMzd0UwcVkzb0M0Z1Uwa0swc0kxdUk1aEY2d0Y2cUw0a0Ez' 
	  And header Content-Type = 'application/json'
	 And header Accept = 'application/json'
	  And header uuid = randomString(20)
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	And request CardAuthRequest 
	When method post 
	Then status 403 
	* print response
	* def ControlflowId1 = response.moreInfo.controlFlowId
	* match ControlflowId1 == '#present'
	* print ControlflowId1
	* print '*********ControlFlowIdGenerated*********'
	
