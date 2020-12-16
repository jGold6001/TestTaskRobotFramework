*** Settings ***
Library           SeleniumLibrary


*** Keywords ***
Open And Set Browser
    [Arguments]  ${url}   ${browser}    ${delay}    ${title}
    Open Browser   ${url}   ${browser}
    Maximize Browser Window
    Set Selenium Speed    ${delay}
    Title Should Be     ${title}

Login
    [Arguments]  ${username}  ${password}
    Click Element    //a[contains(text(),'LOG IN')]
    Input Text       id:email      ${username}         True
    Input Password   id:password   ${password}         True
    Click Element    id:submit

    ${resultLogin}     Run Keyword And Return Status       Wait Until Page Contains Element   //button[contains(text(),'Search')]      3
    Run Keyword Unless       ${resultLogin}       LoginFailure



LoginFailure
    ${invalidPasswordResult}    Run Keyword And Ignore Error         Element Should Contain        //span[@class ='text-danger']       Invalid password
    Run Keyword If              '${invalidPasswordResult[0]}' == 'PASS'         Fail      Invalid password

    ${invalidUserNameResult}    Run Keyword And Ignore Error         Element Should Contain        //span[@class ='text-danger']       Specified user does not exist
    Run Keyword If              '${invalidUserNameResult[0]}' == 'PASS'         Fail      Invalid username
