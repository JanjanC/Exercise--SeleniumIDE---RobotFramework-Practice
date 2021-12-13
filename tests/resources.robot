*** Settings ***
Documentation     A resource file with reusable keywords and variables
...
...               Creating system specific keywords from default keywords
...               from SeleniumLibrary
Library           SeleniumLibrary
Library           Collections
Library           String

*** Variables ***
${SERVER}         www.saucedemo.com
${BROWSER}        chrome
${DELAY}          0
${STANDARD USER}    standard_user
${LOCKED OUT USER}    locked_out_user
${PROBLEM USER}    problem_user
${VALID PASSWORD}    secret_sauce
${INVALID PASSWORD}    HOTDOG?
${LOGIN URL}      https://${SERVER}/
${HOME URL}       https://${SERVER}/inventory.html

*** Keywords ***
Open Browser to Login Page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Login Page Should Be Open

Login Page Should Be Open
    Page Should Contain Element    login-button

Product Page Should Be Open
    Element Text Should Be    class:title    PRODUCTS

Input Username
    [Arguments]    ${username}
    Input Text    user-name    ${username}

Input Pass
    [Arguments]    ${password}
    Input Password    password    ${password}

Submit Credentials
    Click Button    login-button

Error Message Shown
    [Arguments]    ${error}
    Element Text Should Be    css:*[data-test="error"]    ${error}

Product Images Should Be Similar
    [Arguments]    ${src}
    ${images} =    Get WebElements    xpath: //img[@class="inventory_item_img"]
    FOR    ${image}    IN    @{images}
        ${image_src} =    Get Element Attribute    ${image}    src
        Should Be Equal As Strings    ${image_src}    ${src}
    END

Check List Descending
    [Arguments]    ${list}
    ${length}=    Get Length    ${list}
    FOR    ${i}    IN RANGE    ${length-1}
        ${first}=    Set Variable    ${list}[${i}]    # element at index i in ${list}
        ${second}=    Set Variable    ${list}[${i+1}]    # element at index i+1 in ${list}
        Run Keyword If    ${first} <= ${second}    Fail    Element ${first} is not greater than ${second}.
    END

Get All Product Names
    ${names} =    Get WebElements    class:inventory_item_name
    ${names_text} =    Create List
    FOR    ${name}    IN    @{names}
        Append To List    ${names_text}    ${name.text}
    END
    [Return]    ${names_text}

Product Names Should Be Sorted A to Z
    ${original_names} =    Get All Product Names
    ${sorted_names} =    Copy List    ${original_names}
    Sort List    ${sorted_names}
    Lists Should Be Equal    ${original_names}    ${sorted_names}

Product Names Should Be Sorted Z to A
    ${original_names} =    Get All Product Names
    ${sorted_names} =    Copy List    ${original_names}
    Sort List    ${sorted_names}
    Reverse List    ${sorted_names}
    Lists Should Be Equal    ${original_names}    ${sorted_names}

Get All Product Prices
    ${prices} =    Get WebElements    class:inventory_item_price
    ${prices_float} =    Create List
    FOR    ${price}    IN    @{prices}
        #    Append To List    ${names_text}    ${name.text}
        ${price_string} =    Remove String    ${price.text}    $
        ${price_float} =    Convert To Number    ${price_string}
        Append To List    ${prices_float}    ${price_float}
    END
    [Return]    ${prices_float}

Product Prices Should Be Sorted Low to High
    ${original_prices} =    Get All Product Prices
    ${sorted_prices} =    Copy List    ${original_prices}
    Sort List    ${sorted_prices}
    Lists Should Be Equal    ${original_prices}    ${sorted_prices}

Product Prices Should Be Sorted High to Low
    ${original_prices} =    Get All Product Prices
    ${sorted_prices} =    Copy List    ${original_prices}
    Sort List    ${sorted_prices}
    Reverse List    ${sorted_prices}
    Lists Should Be Equal    ${original_prices}    ${sorted_prices}
