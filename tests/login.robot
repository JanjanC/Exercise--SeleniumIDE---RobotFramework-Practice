*** Settings ***
Documentation     A test suite that tests the login feature
...
...               This test suite tests the login functionality
...               of different users
Resource          resources.robot
Test Teardown     Close Browser

*** Test Cases ***
Successful Login
    Open Browser to Login Page
    Input Username    ${STANDARD USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open

Locked Out Login
    Open Browser to Login Page
    Input Username    ${LOCKED OUT USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Error Message Shown    Epic sadface: Sorry, this user has been locked out.

Invalid Password
    Open Browser to Login Page
    Input Username    ${STANDARD USER}
    Input Pass    ${INVALID PASSWORD}
    Submit Credentials
    Error Message Shown    Epic sadface: Username and password do not match any user in this service

Problem User Login
    Open Browser to Login Page
    Input Username    ${PROBLEM USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    Product Images Should Be Similar    https://www.saucedemo.com/static/media/sl-404.168b1cce.jpg
