const AWS = require('aws-sdk');
const cloud9 = new AWS.Cloud9();

async function listEnvironments() {
  try {
    const environments = await cloud9.listEnvironments().promise();
    console.log('Cloud9 Environments:', environments);
    return environments;
  } catch (error) {
    console.error('Error listing Cloud9 environments:', error);
    throw error;
  }
}

// Configure AWS credentials
AWS.config.update({
  region: process.env.AWS_REGION || 'us-east-1',
  credentials: new AWS.Credentials({
    accessKeyId: process.env.AWS_ACCESS_KEY_ID,
    secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY
  })
});

listEnvironments();
