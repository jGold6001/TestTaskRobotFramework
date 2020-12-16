*** Settings ***
Library           SeleniumLibrary


*** Keywords ***

Get Children Elements
    [Arguments]    ${locator}

    ${element}    Get WebElement    ${locator}
    ${children}     Call Method
    ...                ${element}
    ...                find_elements
    ...                  by=xpath    value=child::*

    [Return]      ${children}


Get Parent Element
    [Arguments]    ${locator}

    ${element}    Get WebElement    ${locator}
    ${parent}     Call Method
    ...                ${element}
    ...                find_element
    ...                  by=xpath    value=parent::*

    [Return]    ${parent}


Merge Lists
    [Arguments]     ${firstList}    ${secondList}
    FOR    ${item}    IN    @{secondList}
           Append To List       ${firstList}    ${item}
    END
    [Return]    ${firstList}