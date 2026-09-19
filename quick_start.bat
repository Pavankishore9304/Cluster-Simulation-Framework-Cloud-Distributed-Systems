@echo off
setlocal enabledelayedexpansion
set PYTHONUTF8=1

echo ===================================================
echo     Cluster Simulation Framework - Quick Start
echo ===================================================
echo.

:: 1. Check Python installation
where python >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Python is not found on your system PATH!
    echo Please install Python 3.8+ from https://www.python.org/
    pause
    exit /b 1
)

:: 2. Setup Virtual Environment
if not exist "venv\Scripts\activate.bat" (
    echo [*] Creating virtual environment (venv)...
    python -m venv venv
    if %ERRORLEVEL% NEQ 0 (
        echo [ERROR] Failed to create virtual environment.
        pause
        exit /b 1
    )
)

echo [*] Activating virtual environment...
call venv\Scripts\activate.bat

:: 3. Setup .env file
if not exist ".env" (
    if exist ".env.example" (
        echo [*] Creating .env from .env.example...
        copy .env.example .env >nul
        echo [!] Created .env file. Please ensure your MySQL password is set in .env if not default!
    )
)

:: 4. Install/Verify Dependencies
echo [*] Installing / verifying dependencies...
python -m pip install -r requirements.txt --quiet
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to install dependencies from requirements.txt.
    pause
    exit /b 1
)

:: 5. Test MySQL Connection
echo [*] Checking MySQL connection...
python test_mysql.py
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo ================================================================
    echo [ERROR] MySQL connection failed!
    echo 1. Ensure MySQL service is running (e.g. run 'net start MySQL80')
    echo 2. Check your credentials in the .env file.
    echo ================================================================
    pause
    exit /b 1
)

:: 6. Launch Server
echo [*] Starting cluster simulation server...
start "Cluster Simulator Server" python server_new.py

echo [*] Waiting for server initialization...
timeout /t 4 >nul

:: 7. Seed Initial Test Node & Pod
echo [*] Adding initial test node (8 CPU, 16GB RAM)...
python client.py add_node --cpu 8 --memory 16 --node_type balanced

echo [*] Launching initial test pod (2 CPU, 4GB RAM)...
python client.py launch_pod --cpu_required 2 --memory_required 4 --scheduling_algorithm first_fit

:: 8. Open Dashboard
echo.
echo ===================================================
echo [SUCCESS] Cluster Simulation Framework is running!
echo Dashboard: http://localhost:5000
echo ===================================================
python client.py dashboard
echo.
echo Press any key to exit this launcher (the server will keep running)...
pause >nul