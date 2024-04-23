# AWS ECR Block Vulnerable Container

This section contains Terraform IaC code to detect and block vulnerable container images that has been uploaded into AWS ECR for deployment by utilising AWS Inspector, Eventbridge and a Lambda Function.

The terraform code creates the following resources:
1. AWS Eventbridge Rule
2. AWS Lambda Function
3. AWS IAM Role
4. AWS IAM POlicy
5. AWS Cloudwatch Log Group

For more details, please refer to: https://github.com/SFX20A/SecurityEngineering/tree/main/Mini%20Projects/Automated%20Deployment%20Block%20for%20Vulnerable%20Container%20Images