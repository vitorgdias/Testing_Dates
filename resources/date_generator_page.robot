*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Library    String

*** Variables ***
${URL}                      https://www.random.org/calendar-dates/
${NUM_DATES_INPUT}          name=num
${START_DAY_SELECT}         //select[@name='start_day']
${START_MONTH_SELECT}       //select[@name='start_month']
${START_YEAR_SELECT}        //select[@name='start_year']
${END_DAY_SELECT}           //select[@name='end_day']
${END_MONTH_SELECT}         //select[@name='end_month']
${END_YEAR_SELECT}          //select[@name='end_year']
${GET_DATES_BUTTON}         css:input[value="Get Dates"]
${RESULT_PRE}               //*[@id="invisible"]/p[2]
${RESULT_HEADER_TEXT}       xpath://p[contains(text(), 'They were picked randomly')]

*** Keywords ***
Open Browser To Date Generator Page
    Open Browser    ${URL}    browser=chrome    options=add_argument("--headless")
    Maximize Browser Window
    Wait Until Page Contains    Step 1: The Dates

Set Number Of Dates
    [Arguments]    ${count}
    Input Text    ${NUM_DATES_INPUT}    ${count}

Select Date Range
    [Arguments]    ${start_day}    ${start_month}    ${start_year}    ${end_day}    ${end_month}    ${end_year}

    # O resto do código permanece o mesmo
    Select From List By Value    ${START_DAY_SELECT}      ${start_day}
    Select From List By Value    ${START_YEAR_SELECT}     ${start_year}
    Select From List By Value    ${END_DAY_SELECT}        ${end_day}
    Select From List By Value    ${END_YEAR_SELECT}       ${end_year}
    Select From List By Label    ${START_MONTH_SELECT}    ${start_month}
    Select From List By Label    ${END_MONTH_SELECT}      ${end_month}

Click Get Dates Button
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
        
        # [A SOLUÇÃO ESTÁ AQUI] Usamos Evaluate para fazer a comparação
        ${status}=    Evaluate    $start_date_obj <= $result_date_obj <= $end_date_obj
        Should Be True    ${status}    msg=A data ${result_date_obj} está fora do intervalo esperado.
    END