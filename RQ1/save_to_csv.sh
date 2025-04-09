#!/bin/bash

# SonarQube URL and authentication token
SONAR_URL="http://localhost:9000"
SONAR_TOKEN="" # Add squ token

# File containing the list of GitHub projects
PROJECT_LIST="$(pwd)/all_projects.txt"

# Directory where projects will be cloned
CLONE_DIR="$(pwd)/sonarqube-analysis"

# Create the directory if it doesn't exist
mkdir -p $CLONE_DIR
cd $CLONE_DIR

echo "project_name,files,ncloc,bugs,code_smells,sqale_rating,sqale_index,duplicated_lines_density,vulnerabilities,blocker_violations,critical_violations,major_violations,minor_violations,info_violations" > sonar_results_new.csv


# Loop through each project in the list
while IFS= read -r repo_url; do
    # Extract the project name from the repo URL
    project_name="${repo_url##*/}"
    
    # Save JSON to a common CSV and save
    echo "Writing $project_name results into csv file..."
    jq -r '.component as $c | [$c.name, 
    (.component.measures | map(select(.metric == "files").value) | first // "0"),
    (.component.measures | map(select(.metric == "ncloc").value) | first // "0"),
    (.component.measures | map(select(.metric == "bugs").value) | first // "0"),
    (.component.measures | map(select(.metric == "code_smells").value) | first // "0"),
    (.component.measures | map(select(.metric == "sqale_rating").value) | first // "0"),
    (.component.measures | map(select(.metric == "sqale_index").value) | first // "0"),
    (.component.measures | map(select(.metric == "duplicated_lines_density").value) | first // "0"),
    (.component.measures | map(select(.metric == "vulnerabilities").value) | first // "0"),
    (.component.measures | map(select(.metric == "blocker_violations").value) | first // "0"),
    (.component.measures | map(select(.metric == "critical_violations").value) | first // "0"),
    (.component.measures | map(select(.metric == "major_violations").value) | first // "0"),
    (.component.measures | map(select(.metric == "minor_violations").value) | first // "0"),
    (.component.measures | map(select(.metric == "info_violations").value) | first // "0")
    ] | @csv' $project_name.json >> sonar_results.csv

done < $PROJECT_LIST

echo "All projects saved into csv!"