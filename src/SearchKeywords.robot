*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Set Filter
    Select Checkbox      hasWebsite
    Select Checkbox      hasEmail
    Select Checkbox      hasPhone
    Select Checkbox      hasAddress


Set Main Search Parameters
    [Arguments]     ${companyType}  ${region}
    Input Text   id:industry   ${companyType}          TR UE
    Input Text  id:location    ${region}         TRUE

    Click Element   //h2[contains(text(),'Filters')]
    Sleep   2


Invoke Search
    Click Button        Search
    Element Should Be Visible       //p[@class='text-muted']
    Log To Console    "The results page was displayed"
    Sleep   2
