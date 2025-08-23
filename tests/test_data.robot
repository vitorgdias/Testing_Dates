*** Settings ***
Resource          ../resources/date_generator_page.robot
Test Teardown     Close Browser

*** Test Cases ***
Verify Random Date Generation Within A Specific Range
    [Documentation]    This test case verifies if 4 dates generated randomly 
    ...    fall within the specified range determined by the user in the test variables.

    # Test variables
    ${NUMBER_OF_DATES}=          Set Variable    4
    ${INITIAL_DAY}=              Set Variable    5
    ${INITIAL_MONTH}=            Set Variable    January
    ${INITIAL_YEAR}=             Set Variable    2024
    ${FINAL_DAY}=                Set Variable    25
    ${FINAL_MONTH}=              Set Variable    November
    ${FINAL_YEAR}=               Set Variable    2025

    # Test steps
    GIVEN Open Browser To Date Generator Page
    WHEN Set Number Of Dates         ${NUMBER_OF_DATES}
    AND Set the Date Range            ${INITIAL_DAY}    ${INITIAL_MONTH}    ${INITIAL_YEAR}    ${FINAL_DAY}    ${FINAL_MONTH}    ${FINAL_YEAR}
    AND Click On Get Dates Button
    THEN Verify Number Of Dates In Result      ${NUMBER_OF_DATES}
    AND Verify Date Range In Result Header     2024-01-05    2025-11-25
    AND Verify Resulting Dates Are Within Range    2024-01-05    2025-11-25