#!/bin/bash

echo "Creating Virtual Environment"
python -m venv .venv
source ./.venv/Scripts/activate
python -m pip install -r requirements.txt

read -p "Do you want to add a dashboard to the repo? (y/n): " add_dashboard

if [ "$add_dashboard" == "y" ]; then
    echo Config to use dashboard
    (while IFS= read -r line; do
        echo "$line" | grep -i "USE_DASHBOARD=False" > /dev/null && echo "USE_DASHBOARD=True" || echo "$line"
    done < .env) > temp.env
    mv -f temp.env .env

    # Add dashboard-related commands here, if needed

    echo "Dashboard will be added to the repo."
    git clone https://github.com/jubiss/dash_basic_repository.git
    cd dash_basic_repository

    echo "Installing dashboard requirements"
    python -m pip install -r requirements.txt
    rm -rf .git
    # Modify config.py to set use_dashboard to True

    echo "Installing component submodule"
    cd dash_custom_components
    git submodule add https://github.com/jubiss/dash_custom_components.git
    echo "Installing requirements from components"
    pip install -r requirements.txt
else
    echo "No dashboard will be added to the repo."
fi