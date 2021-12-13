*** Settings ***
Documentation     A test suite that tests the sort feature
...
...               This test suite tests the sort functionality
...               in the products page
Resource          resources.robot
Test Teardown     Close Browser

*** Test Cases ***
Sort Product Name (A to Z)
    Open Browser to Login Page
    Input Username    ${STANDARD USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    Select Sort Filter    az
    Product Names Should Be Sorted A to Z

Sort Product Name (Z to A)
    Open Browser to Login Page
    Input Username    ${STANDARD USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    Select Sort Filter    za
    Product Names Should Be Sorted Z to A

Sort Product Price (Low to High)
    Open Browser to Login Page
    Input Username    ${STANDARD USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    Select Sort Filter    lohi
    Product Prices Should Be Sorted Low to High

Sort Product Price (High to Low)
    Open Browser to Login Page
    Input Username    ${STANDARD USER}
    Input Pass    ${VALID PASSWORD}
    Submit Credentials
    Product Page Should Be Open
    Select Sort Filter    hilo
    Product Prices Should Be Sorted High to Low
