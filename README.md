# Exploring Technical Debt in AI-assisted Code Generation

This repository contains the dataset, scripts, analysis, and supplementary materials for the research project exploring the impact of Generative AI (GenAI) assistance on technical debt and code maintainability in software repositories.

## Overview

Generative AI tools like GitHub Copilot and ChatGPT are increasingly used in software development. While they promise increased productivity, their long-term effects on code quality, technical debt, and maintainability are not yet fully understood. This study empirically compares Python projects developed with AI assistance against purely human-written projects across three dimensions: technical debt levels, refactoring patterns, and code smell prevalence.

## Research Questions

This study aims to answer the following research questions:

*   **RQ1:** Does code co-authored by GenAI exhibit higher or lower levels of technical debt compared to purely human-written code?
*   **RQ2:** How do software developers refactor AI-assisted code in software repositories compared to human-written code?
*   **RQ3:** What types of code smells are most prevalent in code co-authored by GenAI compared to human-written code?

## Repository Structure

*   `Dataset/`: Contains the final pseudonymized list of repositories used in the study, and hashing script.
*   `RQ1/`: Includes scripts related to the Technical Debt analysis (RQ1).
*   `RQ2/`: Contains scripts (`aggregate_metrics.py`, `statistical_analysis.py`, `descriptive.py`, `visualizations.py`) used for detecting refactoring patterns with PyRef, calculating metrics, performing statistical tests, and generating visualizations for RQ2.
*   `RQ3/`: Includes scripts related to the Code Smell analysis using SonarQube data for RQ3.
*   `requirements.txt`: Lists the necessary Python packages required to run the analysis scripts.
*   `.gitignore`: Specifies files intentionally untracked by Git.
*   `README.md`: This file.

## Dataset

The study utilizes a curated dataset of 20 publicly available Python GitHub repositories:
*   10 repositories identified as **AI-assisted** (created post-2021 with explicit project-level acknowledgement of GenAI use).
*   10 comparable repositories identified as **Human-written** (last updated pre-2021, selected using SEART GHS for similarity).

Repositories were filtered based on size, language, functionality, and clarity of AI involvement. Due to privacy considerations, repository names and links within the dataset have been pseudonymized.

The dataset details can be found here: [Link to Google Sheet Dataset](https://docs.google.com/spreadsheets/d/1G8XTpUNMDfsR74OgtChQMiMAVazT8Exdet_M4lwGlcg/edit?usp=sharing)

## Methodology Overview

*   **RQ1 (Technical Debt):** Measured using metrics extracted from SonarQube analysis reports (e.g., Technical Debt Density, Issue Densities), normalized by lines of code. Compared groups using Mann-Whitney U tests.
*   **RQ2 (Refactoring Patterns):** Detected method-level refactorings using PyRef. Categorized refactoring types and calculated intensity metrics (counts, %, timing, contributors). Compared category distributions using Chi-Squared tests and intensity metrics using Mann-Whitney U tests. Included preliminary qualitative analysis.
*   **RQ3 (Code Smells):** Analyzed the distribution of code smell types identified by SonarQube tags. Compared normalized tag frequencies between groups using Mann-Whitney U tests.

For detailed methodology, please refer to the full research paper associated with this project.

## Key Findings Summary

Our quantitative analysis across all three research questions (Technical Debt, Refactoring Patterns, Code Smells) consistently found **no statistically significant differences** between the AI-assisted and purely human-written groups in our sample, using the specified tools and metrics (SonarQube, PyRef).

While these results challenge assumptions about inherent negative maintainability impacts of AI code based on these common measures, the findings should be interpreted cautiously due to study limitations (e.g., small sample size, specific tool scope).

## Running the Analysis

1.  Ensure Python 3 is installed.
2.  Install necessary dependencies: `pip install -r requirements.txt`
3.  Ensure SonarQube (for RQ1/RQ3) and PyRef (for RQ2) are set up in your environment.
4.  Explore the scripts within the `RQ1/`, `RQ2/`, and `RQ3/` directories for specific analysis steps. Note that absolute paths or environment configurations might need adjustment.

## Authors

*   Laura Quiroga-Sánchez
*   Mariya Putwa
*   Prateek Balani
*   Richard Pillaca Burga

## Course Information

This repository supports a project for COSC 419O (Mining Software Repositories) at the University of British Columbia, Okanagan Campus.
