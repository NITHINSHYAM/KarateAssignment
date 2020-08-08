Feature: retrieve the  user from documents

  Background:

    @fetchUser
    Scenario: retrieve user
      Given url 'https://sample-4e6d.restdb.io/rest/users'
      And header x-apikey = '9677194df0cd556c1bb2f9aeee86c7e218482'
      When method get
      Then status 200
      * print response








