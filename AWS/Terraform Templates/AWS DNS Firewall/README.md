# AWS DNS Firewall Repository

This section contains Terraform IaC code to implement AWS DNS Firewall to Blacklist domains based on AWS Managed Lists or Self-Managed Blacklists.

There are 3 Terraform Modules where security engineers can opt to use, based on their use case.

1. AWS Managed Domain Blacklist
2. User Managed Domain Blacklist
3. User Managed Whitelist


AWS Managed Domain Blacklist: <br>
This Terraform module utilises AWS Managed Domain Blacklists based on their threat intelligence. For more information, refer to the following website: https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/resolver-dns-firewall-managed-domain-lists.html <br>
This Terraform module creates the following resources:
1.  AWS DNS Firewall Rule 

User Managed Domain Blacklist:
This Terraform module requires the security engineer to input their own domain blacklist as variables into the terraform.
1. AWS DNS Firewall rule group
2. AWS DNS Firewall rule 


User Managed Domain Whitelist:
This Terraform module requires the security engineer to input their own domain whitelist as variables into the terraform.
1. AWS DNS Firewall rule group
2. AWS DNS Firewall rule 
