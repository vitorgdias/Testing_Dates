*** Settings ***
Resource          ../resources/date_generator_page.robot
Test Teardown     Close Browser

*** Test Cases ***
Verify Random Date Generation Within A Specific Range
    [Documentation]    This test verifies that the random.org calendar date
    ...    generator correctly produces 4 dates within the specified range
    ...    of Jan 5, 2024 to Nov 25, 2025.

    # --- Dados de Teste ---
    ${NUM_DATES_TO_GENERATE}=    Set Variable    4
    ${START_DAY}=                Set Variable    5
    ${START_MONTH}=              Set Variable    January
    ${START_YEAR}=               Set Variable    2024
    ${END_DAY}=                  Set Variable    25
    ${END_MONTH}=                Set Variable    November
    ${END_YEAR}=                 Set Variable    2025

    # --- Passos do Teste (Keywords) ---
    GIVEN Open Browser To Date Generator Page
    WHEN Set Number Of Dates         ${NUM_DATES_TO_GENERATE}
    AND Select Date Range            ${START_DAY}    ${START_MONTH}    ${START_YEAR}    ${END_DAY}    ${END_MONTH}    ${END_YEAR}
    AND Click Get Dates Button
    THEN Verify Number Of Dates In Result      ${NUM_DATES_TO_GENERATE}
    AND Verify Date Range In Result Header     2024-01-05    2025-11-25
    AND Verify Resulting Dates Are Within Range    2024-01-05    2025-11-25