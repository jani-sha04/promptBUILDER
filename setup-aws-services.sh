#!/bin/bash

# Create DynamoDB tables
aws dynamodb create-table \
    --table-name carbon_footprints \
    --attribute-definitions AttributeName=user_id,AttributeType=S AttributeName=timestamp,AttributeType=S \
    --key-schema AttributeName=user_id,KeyType=HASH AttributeName=timestamp,KeyType=RANGE \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

aws dynamodb create-table \
    --table-name challenges \
    --attribute-definitions AttributeName=id,AttributeType=S \
    --key-schema AttributeName=id,KeyType=HASH \
    --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

# Create S3 bucket for assets
aws s3api create-bucket \
    --bucket carbon-footprint-tracker-assets-$(aws sts get-caller-identity --query Account --output text) \
    --region $(aws configure get region)

# Enable CORS for S3 bucket
aws s3api put-bucket-cors \
    --bucket carbon-footprint-tracker-assets-$(aws sts get-caller-identity --query Account --output text) \
    --cors-configuration '{
        "CORSRules": [
            {
                "AllowedHeaders": ["*"],
                "AllowedMethods": ["GET", "PUT", "POST", "DELETE"],
                "AllowedOrigins": ["*"],
                "ExposeHeaders": []
            }
        ]
    }'

# Create Cognito User Pool
aws cognito-idp create-user-pool \
    --pool-name CarbonFootprintUsers \
    --policies '{"PasswordPolicy":{"MinimumLength":8,"RequireUppercase":true,"RequireLowercase":true,"RequireNumbers":true,"RequireSymbols":true}}' \
    --auto-verified-attributes email

# Save the User Pool ID
USER_POOL_ID=$(aws cognito-idp list-user-pools --max-results 1 --query 'UserPools[0].Id' --output text)

# Create User Pool Client
aws cognito-idp create-user-pool-client \
    --user-pool-id $USER_POOL_ID \
    --client-name CarbonFootprintApp \
    --no-generate-secret \
    --explicit-auth-flows ADMIN_NO_SRP_AUTH USER_PASSWORD_AUTH

echo "AWS services setup completed!"
