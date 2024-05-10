# Automated Deployment Block for Vulnerable Container Images

In companies where change processes and deployment changes from developers are not adequately controlled, developers may unknowningly deploy vulnerable containers into the production environment, thus increasing the risk of system compromise due to the exposure of vulnerabilities in the company's production systems.

It is paramount that container images are scanned for vulnerabilities via an established CI/CD pipeline, where vulnerabilities can be identified and addressed prior to the deployment of containers. 


# The Solution
In the event that vulnerable containers are pushed into their container registries due to an unestablished change process or unauthorised deployment, this solution mitigates the risk that vulnerable containers are pulled and deployed into production environments.

<img src="https://github.com/SFX20A/SecurityEngineering/blob/main/Mini%20Projects/Automated%20Deployment%20Block%20for%20Vulnerable%20Container%20Images/images/Architecture.jpg" />

Solution Workflow:
1. Developer uploads vulnerable container image into AWS ECR.
2. Upon upload, AWS Inspector initiates a vulnerability scan on the uploaded container image.
3. When AWS Inspector completes the scan and identifies a HIGH* vulnerability, AWS Eventbridge detects the finding and invokes a lambda function.
4. The lambda^ function replaces the container image repository's permissions with a deny all pull requests, preventing the deployment of vulnerable images into the production environment.

Terraform code to deploy the above can be found here: https://github.com/SFX20A/SecurityEngineering/tree/main/AWS/Terraform%20Templates/AWS%20ECR%20Block%20Vulnerable%20Container
The code assumes that AWS Inspector has already been enabled for ECR Repository scanning.

<i>*Note: AWS Inspector has 6 levels of severities: Informational, Low, Medium, High, Critical, Untriaged. This solution will only be invoked when a HIGH vulnerability is detected, edit accordingly based on project risk appetite. In this solution, multiple eventbridge rules are required to block multiple severity levels. </i>
<br><i>^Note: The lambda function requires ecr:SetRepositoryPolicy permissions to be able to modify permissions in the AWS ECR repository.</i>

# v1
Version 1 of the code implements the use of Eventbridge to trigger the Lambda with an identified severity level at Eventbridge, therefore, multiple Eventbridge rules needs to be created in order to cover mulitple severity levels  (i.e. 3 Eventbridge rules for Low, Medium and High).

# v2
Version 2 of the code implements a check at the lambda function (if severity level not equals UNTRIAGED or INFORMATIONAL), to run the IAM policy replacement. 

