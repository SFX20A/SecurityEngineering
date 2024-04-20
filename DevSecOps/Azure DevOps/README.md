# DevSecOps in Azure DevOps

This repository contains templates with regards to enabling DevSecOps using Azure DevOps.
The respective folders contains yaml templates which enable the integration of the following technologies into their Azure DevOps environment:

1. Infrastructure-as-Code: Ansible
2. Compliance-as-Code: ChefInspec
3. SAST,SCA, Secrets Scanning, Infrastructure scan

# Ansible
The solution installs Ansible during the CI/CD pipeline run in the runner which uses an ubuntu image. 
Utilising the ansible playbook from dev-sec.os-hardening, it implements the hardening configuration towards the targeted machines indicated in the inventory.ini file.

# ChefInspec
The solution installs Ansible during the CI/CD pipeline run in the runner which uses an ubuntu image. 
Utilising the ChefInspec compliance profile from https://github.com/dev-sec/linux-baseline , it runs a hardening verification based on the indicated compliance profile. 

# Code Scanning
The solution utilises the following open source tools to conduct SAST, SCA, Secrets Scanning and Infrastructure Scan:
1. SAST: Bandit
2. SCA: Safety
3. Secrets Scan: Trufflehog
4. Infrastructure Scan: nmap