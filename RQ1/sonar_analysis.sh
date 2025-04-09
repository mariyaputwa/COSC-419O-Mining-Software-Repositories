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

echo "project_name,files,ncloc,bugs,code_smells,sqale_rating,sqale_index,duplicated_lines_density,vulnerabilities,blocker_violations,critical_violations,major_violations,minor_violations,info_violations" > sonar_results.csv


# Loop through each project in the list
while IFS= read -r repo_url; do
    # Extract the project name from the repo URL
    project_name="${repo_url##*/}"
    
    echo "Cloning $repo_url..."
    
    # Clone the repository
    git clone --depth 1 "$repo_url"
    
    # Navigate into the project directory
    cd "$project_name" || continue

    # Set exclusions using SonarQube API -> for manually identified tests
    curl -u "$SONAR_TOKEN:" -X POST "$SONAR_URL/api/settings/set" \
        -d "component=$project_name" \
        -d "key=sonar.exclusions" \
        -d "values=**/test_app.py,**/tests/**"

    # Run SonarQube analysis
    echo "Running SonarQube analysis for $project_name..."
    sonar-scanner \
        -Dsonar.projectKey=$project_name \
        -Dsonar.sources=. \
        -Dsonar.host.url=$SONAR_URL \
        -Dsonar.login=$SONAR_TOKEN \
        -Dsonar.language=py \
        -Dsonar.python.version=3

    # Navigate back to the main directory for the next project
    cd $CLONE_DIR || exit

    # Fetch analysis results and save as JSON
    echo "Fetching SonarQube results for $project_name..."
    curl -u $SONAR_TOKEN: "$SONAR_URL/api/measures/component?component=$project_name&metricKeys=bugs,code_smells,vulnerabilities,duplicated_lines_density,sqale_index,sqale_rating,ncloc,files,blocker_violations,critical_violations,major_violations,minor_violations,info_violations" | jq '.' > "$project_name.json"

done < $PROJECT_LIST

echo "Analysis complete for all projects!"