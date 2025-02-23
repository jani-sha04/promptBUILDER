@echo off
echo Starting Carbon Footprint Tracker...

echo Installing dependencies...
npm install

echo Starting backend server...
start cmd /k "cd backend && python app.py"

echo Starting frontend server...
start cmd /k "npm start"

echo Application starting... Please wait a moment.
echo Backend will be available at http://localhost:5000
echo Frontend will be available at http://localhost:3000
