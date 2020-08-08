Feature: Get access token using ControlFlowId 

Background: 

	* call read('classpath:reusable.feature')
      
@CardAuthAccessToken 
Scenario: fetch access token  from  Citi BANK Sandbox 
	* call read('classpath:Citibank/lop/CardAuthorization.feature')
	Given url 'https://sandbox.apihub.citi.com/gcb/api/cardAuth/oauth2/token/sg/gcb' 
	And header Authorization = 'Basic ZjJmMDhjMTQtOGU1My00YjEzLTg2MmMtYmRmMTgyZDQ2ZGY5Olk4eVAzYk43Z1MzbFEwYUMzd0UwcVkzb0M0Z1Uwa0swc0kxdUk1aEY2d0Y2cUw0a0Ez'
	And header Content-Type = 'application/x-www-form-urlencoded'
	 And header Accept = 'application/json'
	And header uuid = randomString(20)
	And header client_id = 'f2f08c14-8e53-4b13-862c-bdf182d46df9'
	And form field grant_type = 'card_authorization' 
	And form field controlFlowId = ControlflowId1 
	And form field linkageConfirmationCode = '987654' 
	And form field scope = 'lop_booking' 
	When method post 
	Then status 200 
	* print response
	* match response.token_type == '#string'
	* match response.access_token == '#string'
	* def tokenType = response.token_type 
	* def accessToken = response.access_token 
	* def access_token = tokenType+' '+accessToken
	* print access_token
	* print '*********AccessTokenGenerated*********'