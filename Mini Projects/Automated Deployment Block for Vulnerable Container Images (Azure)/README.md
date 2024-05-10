# Automated Deployment Block for Vulnerable Container Images

In companies where change processes and deployment changes from developers are not adequately controlled, developers may unknowningly deploy vulnerable containers into the production environment, thus increasing the risk of system compromise due to the exposure of vulnerabilities in the company's production systems.

It is paramount that container images are scanned for vulnerabilities via an established CI/CD pipeline, where vulnerabilities can be identified and addressed prior to the deployment of containers. 


# The Solution
In the event that vulnerable containers are pushed into their container registries due to an unestablished change process or unauthorised deployment, this solution mitigates the risk that vulnerable containers are pulled and deployed into production environments.

<img src="https://github.com/SFX20A/SecurityEngineering/blob/main/Mini%20Projects/Automated%20Deployment%20Block%20for%20Vulnerable%20Container%20Images%20(Azure)/images/Architecture.jpg" />

Solution Workflow:
1. Developer uploads vulnerable container image into Azure ACR.
2. Upon upload, Defender for Containers initiates a vulnerability scan on the uploaded container image.
3. When Defender for Containers completes the scan and identifies a vulnerability, Defender for Cloud automation will trigger an Azure logic app.
4. The logic app is triggered when there is a Defender for Cloud recommendation, in which it will send an email notification, do a KQL query on a log analytics workspace to fetch the container image details and then execute an API call to change the repository attribute to disable read/pull.

# Steps

1. Create a Logic App which is triggered by Defender for Cloud Recommendation:

<img src="https://github.com/SFX20A/SecurityEngineering/blob/main/Mini%20Projects/Automated%20Deployment%20Block%20for%20Vulnerable%20Container%20Images%20(Azure)/images/LogicApp1.png" />

2. [Optional Step] With a created Azure Communication Service which is configured for email notifications, add an action to the logic app to execute an email notification using Azure Communication Service.

<img src="https://github.com/SFX20A/SecurityEngineering/blob/main/Mini%20Projects/Automated%20Deployment%20Block%20for%20Vulnerable%20Container%20Images%20(Azure)/images/ACSNotification.png" />

3. Create a managed identity for the Logic App under your logic app -> Settings -> Identity -> On 
4. Give a Log Analytics Reader Permission to the Logic App to allow the Logic App to execute KQL queries.
5. Add an action in the logic app to run Azure Monitor Queries and list results

<img src="https://github.com/SFX20A/SecurityEngineering/blob/main/Mini%20Projects/Automated%20Deployment%20Block%20for%20Vulnerable%20Container%20Images%20(Azure)/images/LogAnalyticsQuery.png" />

SecurityRecommendation <br>
| where RecommendationDisplayName == "[Preview] Container images in Azure registry should have vulnerability findings resolved" <br>
| extend PropertiesData = parse_json(Properties) <br>
| project  <br>
    containerRepo = PropertiesData.resourceDetails.resourceName, <br>
    RecommendationSeverity, <br>
    registry = tostring(split(PropertiesData.resourceDetails.id, '/')[8]),  <br>
    repositorylink = tostring(split(PropertiesData.additionalData.imageId, '/')[0]), <br>
    TimeGenerated <br>
| summarize TimeGenerated = make_list(TimeGenerated) by tostring(containerRepo), RecommendationSeverity, registry, repositorylink <br>

* Note: This KQL query leverages on a preview feature as indicated above. The name may change and thus the KQL query will need to modify accordingly.

The KQL query filters for the specific Defender for Cloud Recommendation within 24 hours, and parses the column "Properties" for the following data: Container Repository, Registry, Registry Link and displays the KQL query with the following columns (summarised):
a. TImeGenerated
b. ContainerRepo
c. Vulnerability Severity
d. Registry Name
e. Registry Link

6. Add an HTTP request action, with the following parameters, take note to provide the specific authorization headers (Recommended to use Managed Identities):

<img src="https://github.com/SFX20A/SecurityEngineering/blob/main/Mini%20Projects/Automated%20Deployment%20Block%20for%20Vulnerable%20Container%20Images%20(Azure)/images/APICall.png" />