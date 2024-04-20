# Automated Detection and ALerts for AWS Resource Configuration Changes

The proliferation of IaC and DevOps has allowed companies to use CI/CD pipelines to deploy their changes in the cloud. With more and more companies adopting this modernised approach, the percentage of changes that require administrators to deploy changes to infrastructure via the cloud console has seen significant reduction, due to the benefits of utilising DevOps to deploy changes, such as:
1. Changes can be controlled, monitored and approved via internal change management processes;
2. Changes can be assessed for misconfigurations via code (e.g. via IaC scanning or peer reviews)

It is important to detect any unauthorised & malicious changes happening in the cloud, be it due to insider attacks or to any current breaches in the system to allow quick response and recovery to the affected system.

Now, as changes are mostly controlled via the CI/CD pipeline, we can then enhance detection of unauthorised or malicious changes that are happening in the cloud, by creating rules to detect and alert upon any changes that occur in the cloud, that is out of the system's maintenance window.

# The Solution

In AWS, AWS Config can detect and create events for every change that is happening in the AWS, leveraging on this feature, we can then use AWS Eventbridge and AWS SNS to detect Config Change events and notify administrators on detection of such events.



The workflow of the solution:
1. AWS Config detects changes to AWS resources.
2. AWS Eventbridge picks up the event published by AWS Config.
3. AWS Eventbridge sends the relevant notification to AWS SNS Topic.
4. AWS SNS sends the notification to the administrator.


A Terraform module of the solution has been created here: https://github.com/SFX20A/SecurityEngineering/tree/main/AWS/Terraform%20Templates/AWS%20Config