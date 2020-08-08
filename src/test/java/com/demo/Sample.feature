Feature: Update JSON file

Scenario: To verify the whether we able to define and update the variable

* def myJson = { empId: 'M11' }
* set myJson.name = 'John'
* set myJson.phone = 954343458
* set myJson.role =  'Test'
* print myJson
* match myJson == {empId:'M11', name: 'John', phone:954343458, role:'Test'}
# update
* set myJson.empId = 'M12'
* print myJson
# Add a new key
* set myJson $.address = 'Chennai'
* print myJson
* match myJson.address == 'Chennai'

Scenario: To varify whether we able to update value in Json file
* def val = '456NewValue115'
 * def jsonFile = read('classpath:com/demo/Update.json')
 * set jsonFile.DynamicValue = val
 * print jsonFile
 * def otpRequest = read('classpath:com/demo/OTPValidationRequest.json')
 * print otpRequest
 * set otpRequest.controlFlowId = val
 * print otpRequest
