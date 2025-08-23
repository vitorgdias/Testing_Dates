# Testing_Dates

This repository is used to test dates based on predefined start and end dates using Robot Framework.

## Python Version

This project uses **Python 3.13.3**.

## How to Run

Change the current directory to .../Testing_Dates
To execute the test cases and save the results in the `results` folder, use the following command in your terminal:

`robot -d results tests/`

This will run the test case in the `tests` directory and generate the output files (`report.html`, `log.html`, `output.xml`) in the `results` folder.

## Project Structure

- `tests/` — Contains the Robot Framework test case.
- `resources/` — Contains reusable Robot Framework keywords as resources.
- `results/` — Output folder for test reports.
- `requirements.txt` — List of Python dependencies.

## Setup

1. Create and activate a Python virtual environment:

   `python -m venv .venv ..venv\Scripts\activate`

2. Install dependencies:

   `pip install -r requirements.txt`

## Core Requirements

- Python 3.10+
- Robot Framework

## Notes

The automation run headless, to improve the code performance, but it can be changed removing the parameter `options=add_argument("--headless")` from the date_generator_page.robot file.
Doing this change will be possible to see the entire actions of the test script.
