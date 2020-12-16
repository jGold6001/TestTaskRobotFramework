*** Settings ***
Library       SeleniumLibrary
Library       DebugLibrary
Library       Collections
Resource      src/OpenLoginKeywords.robot
Resource      src/SearchKeywords.robot
Resource      src/CommonKeywords.robot
Resource      src/ScrapDataKeywords.robot


*** Variables ***
${USERNAME}                     some_mail@gmail.com
${PASSWORD}                     some_p@ssword

${SEARCH_WORD_COMPANY_TYPE}      mortgage
${SEARCH_WORD_REGION}            US
${TOP_ITEMS_COUNT}               30


${BROWSER}                       chrome
${URL}                           https://www.aihitdata.com/
${DELAY}                         0
${TITLE}                         The Company Database | aiHit


*** Test Cases ***
Open And Login
    Open And Set Browser    ${URL}   ${BROWSER}    ${DELAY}    ${TITLE}
    Login   ${USERNAME}   ${PASSWORD}


Search Process
    Set Main Search Parameters      ${SEARCH_WORD_COMPANY_TYPE}     ${SEARCH_WORD_REGION}
    Set Filter
    Invoke Search

Scrap Data Process
    ${linksList}   Scrap Links      ${TOP_ITEMS_COUNT}

    FOR     ${index}     IN RANGE    0       ${TOP_ITEMS_COUNT}
        ${iteration}    Evaluate     ${index} + 1
        ${linkUrl}      Set Variable       ${linksList[${index}]}
        Log to Console      --------------------------------------
        Log to Console      ${iteration} ) ${linkUrl}
        ${companyDataDictionary}    Scrap Data Company Item By Link Url       ${linkUrl}
        Print Dictionary in Console     ${companyDataDictionary}
    END

Close
   Close Browser




