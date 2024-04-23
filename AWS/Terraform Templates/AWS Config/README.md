# AWS Config Repository

This section contains Terraform IaC code to detect AWS resource changes via AWS Config and trigger alerts via AWS SNS and Eventbridge.

The terraform code creates the following resources:
1. AWS SNS Topic 
2. AWS SNS Topic Subscription
3. AWS SNS IAM Access Policy
4. AWS Eventbridge Rule

For more details, please refer to: https://github.com/SFX20A/SecurityEngineering/tree/main/Mini%20Projects/Automated%20Detection%20and%20Alerts%20for%20AWS%20Resource%20Configuration%20Change