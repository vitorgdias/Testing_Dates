*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

*** Variables ***
${URL}                          https://www.random.org/calendar-dates/
${NUMBER_OF_DATES_INPUT}        name=num
${INITIAL_DAY_SELECT}           //select[@name='start_day']
${INITIAL_MONTH_SELECT}         //select[@name='start_month']
${INITIAL_YEAR_SELECT}          //select[@name='start_year']
${FINAL_DAY_SELECT}             //select[@name='end_day']
${FINAL_MONTH_SELECT}           //select[@name='end_month']
${FINAL_YEAR_SELECT}            //select[@name='end_year']
${GET_DATES_BUTTON}             css:input[value="Get Dates"]
${RESULT_PRE}                   //*[@id="invisible"]/p[2]
${RESULT_HEADER_TEXT}           xpath://p[contains(text(), 'They were picked randomly')]

*** Keywords ***
Open Browser To Date Generator Page
    Open Browser    ${URL}    browser=chrome    options=add_argument("--headless")
    Wait Until Page Contains    Step 1: The Dates

Set Number Of Dates
    [Arguments]    ${number}
    Input Text    ${NUMBER_OF_DATES_INPUT}    ${number}

Set the Date Range
    [Arguments]    ${start_day}    ${start_month}    ${start_year}    ${end_day}    ${end_month}    ${end_year}
    Select From List By Value    ${INITIAL_DAY_SELECT}      ${start_day}
    Select From List By Value    ${INITIAL_YEAR_SELECT}     ${start_year}
    Select From List By Value    ${FINAL_DAY_SELECT}        ${end_day}
    Select From List By Value    ${FINAL_YEAR_SELECT}       ${end_year}
    Select From List By Label    ${INITIAL_MONTH_SELECT}    ${start_month}
    Select From List By Label    ${FINAL_MONTH_SELECT}      ${end_month}

Click On Get Dates Button
    Click Button    ${GET_DATES_BUTTON}
    Wait Until Page Contains Element    ${RESULT_PRE}

Verify Number Of Dates In Result
    [Arguments]    ${expected_count}
    ${result_text}=    Get Text    ${RESULT_PRE}
    @{lines}=    Split To Lines    ${result_text}
    ${line_count}=    Get Length    ${lines}
    Should Be Equal As Integers    ${line_count}    ${expected_count}

Verify Date Range In Result Header
    [Arguments]    ${expected_start_date}    ${expected_end_date}
    ${header_text}=    Get Text    ${RESULT_HEADER_TEXT}
    Should Contain    ${header_text}    ${expected_start_date}
    Should Contain    ${header_text}    ${expected_end_date}

Verify Resulting Dates Are Within Range
    [Arguments]    ${start_date_str}    ${end_date_str}
    ${start_date_obj}=    Convert Date    ${start_date_str}    result_format=%Y-%m-%d
    ${end_date_obj}=      Convert Date    ${end_date_str}    result_format=%Y-%m-%d

    ${result_text}=    Get Text    ${RESULT_PRE}
    @{lines}=    Split To Lines    ${result_text}

    FOR    ${line}    IN    @{lines}
        @{date_parts}=      Split String    ${line}
        ${date_part}=       Set Variable    ${date_parts[0]}
        ${result_date_obj}=    Convert Date    ${date_part}    result_format=%Y-%m-%d        
        ${status}=    Evaluate    $start_date_obj <= $result_date_obj <= $end_date_obj
        Should Be True    ${status}    msg=The date ${result_date_obj} is out of the expected range.
    END