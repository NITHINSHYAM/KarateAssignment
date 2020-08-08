Feature:  UI Example
  Background:
  * configure driver = { type: 'chrome', showDriverLog: true }

 @UIExample
  Scenario: UI Example for Maveric system
    
    Given  driver 'https://www.google.com/'
    Then maximize()
    And input("input[name=q]", 'Maveric-systems')
   Then screenshot()
    When submit().click("input[name=btnI]")
    Then waitForUrl('https://maveric-systems.com/')
   And match getUrl() contains 'maveric-systems'
  