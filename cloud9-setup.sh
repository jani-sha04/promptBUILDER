#!/bin/bash

# Update system packages
sudo yum update -y

# Install Node.js 18.x (LTS)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 18
nvm use 18

# Install global npm packages
npm install -g npm@latest
npm install -g create-react-app
npm install -g aws-sdk

# Install Python 3 and pip
sudo yum install python3 python3-pip -y

# Install AWS CLI v2
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Install Git and configure
sudo yum install git -y

# Create project directory
mkdir -p ~/environment/carbon-footprint-tracker
cd ~/environment/carbon-footprint-tracker

# Initialize new React project
npx create-react-app .

# Install project dependencies
npm install react-bootstrap bootstrap axios react-router-dom \
    @aws-sdk/client-cognito-identity @aws-sdk/client-dynamodb \
    chart.js react-chartjs-2 react-icons

# Create necessary directories
mkdir -p src/components/{Challenges,Leaderboard,Notifications,Social}

# Clean up
rm -rf aws awscliv2.zip

echo "Setup completed! Your development environment is ready."
