#!/bin/bash

# Create a temporary directory for the code
mkdir -p ~/environment/temp-sync

# Copy all relevant files
cp -r src/* ~/environment/carbon-footprint-tracker/src/
cp package.json ~/environment/carbon-footprint-tracker/
cp README.md ~/environment/carbon-footprint-tracker/

# Install dependencies
cd ~/environment/carbon-footprint-tracker
npm install

# Clean up
rm -rf ~/environment/temp-sync

echo "Code sync completed!"
