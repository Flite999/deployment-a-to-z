# terraform

## create a backend to store state
1. Create an S3 bucket
2. Create a DynamoDB table
3. Create an IAM policy to allow access to the S3 bucket and DynamoDB table, and attach to the IAM user.
4. Update the root main.tf with the backend.