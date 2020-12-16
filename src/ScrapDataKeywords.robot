*** Settings ***
Library  SeleniumLibrary

*** Keywords ***
Scrap Links
    [Arguments]     ${top_items_count}
    ${linksFromPage}        Generate List Of Url Links  //div[@class='col-md-8']/div/div/div/div/div/a
    ${countLinksFromPage}   Get Length      ${linksFromPage}

     FOR    ${index}    IN RANGE    9999999
        Run Keyword If      ${countLinksFromPage} >= ${top_items_count}      Exit For Loop

        Go To The Next Page
        ${linksFromNextPage}        Generate List Of Url Links      //div[@class='col-md-8']/div/div/div/div/div/a
        Merge Lists     ${linksFromPage}      ${linksFromNextPage}
        ${countLinksFromPage}       Get Length      ${linksFromPage}
     END
    [Return]  ${linksFromPage}





Go To The Next Page
    Run Keyword And Ignore Error    Click Element       //a[@class = 'cc_btn cc_btn_accept_all']
    Wait Until Element Is Visible   //a[@rel='next']
    Click Element    //a[@rel='next']


Generate List Of Url Links
    [Arguments]     ${locator}
    ${elements}  Get WebElements    ${locator}
    @{linksList}    Create List

    FOR     ${ELEM}     IN      @{elements}
        ${companyLink}    Get Element Attribute   ${ELEM}     href
        Append To List    ${linksList}       ${companyLink}
    END

    [Return]  ${linksList}



Get Text Value By ParentElement And TipClassName
    [Arguments]  ${locator}   ${ClassName}
    ${elementsContainsInfo}     Get WebElements    ${locator}
    ${elementText}  Set Variable      None

    FOR     ${elemWithInfo}     IN      @{elementsContainsInfo}
        ${childrenElements}     Get Children Elements       ${elemWithInfo}
        ${CountOfchildrenElements}      Get Length      ${childrenElements}
        Run Keyword If       ${CountOfchildrenElements} ==0    Continue For Loop

        ${resultExpressionGetElemAttr}     Run Keyword And Ignore Error     Get Element Attribute    ${childrenElements[0]}     class
        Run Keyword If      '${resultExpressionGetElemAttr[1]}' != '${ClassName}'   Continue For Loop

        ${elementText}    Run Keyword If           ${CountOfchildrenElements} > 1         Get Text   ${childrenElements[1]}
                          Exit For Loop If       '${elementText}'!='None'
        ${elementText}     Run Keyword Unless       ${CountOfchildrenElements} > 1         Get Text   ${elemWithInfo}
                           Exit For Loop If       '${elementText}'!='None'
    END
    [Return]  ${elementText}



Create Comapany Data Dictionary
    [Arguments]     ${name}     ${webSite}      ${adress}       ${email}    ${phone}
    ${dictionary}   Create Dictionary       Name=${name}    Web Site=${webSite}     Address=${adress}   Email=${email}      Phone=${phone}
    [Return]        ${dictionary}



Scrap Data Company Item By Link Url
    [Arguments]      ${linkUrl}
    Go To           ${linkUrl}
    ${name}         Get Text                         //h1[@class ='text-info']
    ${adress}       Find Element And Get Text        //div[@class ='text-muted']                icon-sm icon-map-marker
    ${webSite}      Find Element And Get Text        //ul[@class ='list-inline']/li             icon-sm icon-home
    ${email}        Find Element And Get Text        //ul[@class ='list-inline']/li | //div     icon-sm icon-email
    ${phone}        Find Element And Get Text        //ul[@class ='list-inline']/li | //div     icon-sm icon-phone

    ${dictionary}   Create Comapany Data Dictionary       ${name}    ${webSite}     ${adress}   ${email}    ${phone}
    [Return]     ${dictionary}




Find Element And Get Text
     [Arguments]  ${locator}   ${ClassName}
     ${textValueFromOverviewPage}    Get Text Value By ParentElement And TipClassName      ${locator}    ${ClassName}
     ${textValue}=   Run Keyword If    '${textValueFromOverviewPage}'=='None'    Scrape Element Text From Contacts Page       ${locator}    ${ClassName}
                    ...     ELSE        Set Variable      ${textValueFromOverviewPage}
     [Return]  ${textValue}



Scrape Element Text From Contacts Page
     [Arguments]  ${locator}        ${ClassName}
     Click Element    //a[contains(text(),'Contacts')]
     ${elementText}    Get Text Value By ParentElement And TipClassName     ${locator}      ${ClassName}
     [Return]    ${elementText}



Print Dictionary in Console
    [Arguments]     ${dictionary}
    ${keys}   Get Dictionary Keys   ${dictionary}
    FOR     ${key}      IN      @{keys}
        ${value}    Get From Dictionary   ${dictionary}   ${key}
        ${msg}  Catenate   SEPARATOR= -     ${key}    ${value}
        Log To Console      ${msg}
    END

