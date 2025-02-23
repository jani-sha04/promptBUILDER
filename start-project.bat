@echo off
echo Starting Carbon Footprint Tracker...

REM Create virtual environment if it doesn't exist
if not exist "venv" (
    echo Creating virtual environment...
    python -m venv venv
)

REM Activate virtual environment
call venv\Scripts\activate

REM Install Python dependencies
echo Installing Python dependencies...
pip install fastapi uvicorn python-dotenv pydantic

REM Start backend server in a new window
echo Starting backend server...
start cmd /k "venv\Scripts\activate && cd app && python -m uvicorn main:app --reload --port 8000"

REM Install frontend dependencies and start React app
echo Installing frontend dependencies...
cd frontend
npm install

echo Starting frontend...
start cmd /k "npm start"

echo.
echo Backend will be available at http://localhost:8000
echo Frontend will be available at http://localhost:3000
echo.
echo Press any key to close all servers...
pause

REM Kill all node and python processes
taskkill /F /IM node.exe
taskkill /F /IM python.exe
