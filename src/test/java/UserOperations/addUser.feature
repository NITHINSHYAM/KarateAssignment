Feature: Add  user into documents

  Background:
    * def userDetails = read('classpath:UserOperations/userDetails1.json')
   #* def userDetailss = read('classpath:UserOperations/userDetails.json')

  @addUser
  Scenario:  Adding user into documents
    Given url 'https://sample-4e6d.restdb.io/rest/users'
    And header x-apikey = '9677194df0cd556c1bb2f9aeee86c7e218482'
    And request userDetails
    When method post
    Then status 201
    And match response.email == userDetails.email
    * print response
    * def id = response._id
    * print id


  @OutlineExample
  Scenario Outline:  Adding user into documents
    Given url 'https://sample-4e6d.restdb.io/rest/users'
    And header x-apikey = '9677194df0cd556c1bb2f9aeee86c7e218482'
    * set userDetails.email = '<email>'
    * set userDetails.active = '<active>'
    And request userDetails
    When method post
    Then status 201
    And match response.email == userDetails.email
    * print response
    * def id = response._id
    * print id
    Examples:

      #| (read('userDetails.json')) |

      |email                   | active |
     |'shriram@gmail.com'  | 'true' |
     # |'mani.guabrn@gmail.com' | 'false'|
    #  |'mani.guabr@gmail.com'  | 'true' |