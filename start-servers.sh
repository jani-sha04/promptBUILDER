#!/bin/bash

# Start the Python backend server
echo "Starting Python backend server..."
cd backend
python app.py &

# Wait a few seconds for the backend to start
sleep 5

# Start the React frontend
echo "Starting React frontend..."
cd ..
npm start
