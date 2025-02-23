const { exec } = require('child_process');
const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

console.log('AWS Credentials Configuration');
console.log('----------------------------');

rl.question('Enter your AWS Access Key ID: ', (accessKeyId) => {
  rl.question('Enter your AWS Secret Access Key: ', (secretAccessKey) => {
    rl.question('Enter your preferred AWS region (default: us-east-1): ', (region) => {
      const awsRegion = region || 'us-east-1';
      
      // Set AWS credentials using environment variables
      process.env.AWS_ACCESS_KEY_ID = accessKeyId;
      process.env.AWS_SECRET_ACCESS_KEY = secretAccessKey;
      process.env.AWS_REGION = awsRegion;

      console.log('\nConfiguring AWS credentials...');
      
      // Create .env file with credentials
      const fs = require('fs');
      const envContent = `
AWS_ACCESS_KEY_ID=${accessKeyId}
AWS_SECRET_ACCESS_KEY=${secretAccessKey}
AWS_REGION=${awsRegion}
`;
      
      fs.writeFileSync('.env', envContent);
      console.log('Credentials saved to .env file');
      
      // Test the credentials by listing Cloud9 environments
      require('./aws-setup');
      
      rl.close();
    });
  });
});
