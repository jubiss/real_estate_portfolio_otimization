@echo off

echo Creating Virtual Environment
python -m venv .venv
call .\.venv\Scripts\activate
python -m pip install -r requirements.txt

set /p add_dashboard="Do you want to add a dashboard to the repo? (y/n): "
if /i "%add_dashboard%"=="y" (

    echo Config to use dashboard
    (for /f "delims=" %%i in ('type .env') do (
        echo %%i | findstr /i /c:"USE_DASHBOARD=False" > nul && (
            echo USE_DASHBOARD=True
        ) || echo %%i
    )) > temp.env
    move /y temp.env .env

    rem Add dashboard-related commands here, if needed

    echo Dashboard will be added to the repo.
    git clone https://github.com/jubiss/dash_basic_repository.git
    cd dash_basic_repository

    echo Installing dashboard requirements
    python -m pip install -r requirements.txt
    rmdir /s /q .git
    rem Modify config.py to set use_dashboard to True

    echo Installing component submodule
    cd dash_custom_components
    git submodule add https://github.com/jubiss/dash_custom_components.git
    echo Installing requirements from components
    pip install -r requirements.txt
) else (
    echo No dashboard will be added to the repo.
)
