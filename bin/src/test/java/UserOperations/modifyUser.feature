Feature: Modify  user into documents

  Background:

    * def userDetails = read('classpath:UserOperations/userDetails.json')


  @modifyuser
  Scenario:  Modifying user into documents
   call read('classpath:UserOperations/addUser.feature@addUser')
    * print userResponse
    Given url 'https://sample-4e6d.restdb.io/rest/users/'
    And path '<id>'
    And header x-apikey = '9677194df0cd556c1bb2f9aeee86c7e218482'
    And request userDetails
    * set userDetails.email = 'mani.gubaren@gmail.com'
    When method put
    Then status 201
    And match response.email == userDetails.email
    * print response
