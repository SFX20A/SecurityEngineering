import boto3
import json

client = boto3.client('sns')

def lambda_handler(event, context):

    
    #Extract details from event
    accountId = event["account"]

    snsArn = 'arn:aws:sns:region-id:account-id:sns-name'
    

    #Extract details from finding
    findingSeverity = event["detail"]["severity"]["description"]
    findingResource = event["detail"]["resourcesAffected"]["s3Bucket"]["name"]
    findingOwner = event["detail"]["resourcesAffected"]["s3Bucket"]["owner"]["displayName"]
    findingDetail = event["detail"]["type"]

        
    message = "AWS Macie has detected violations in the following S3 Bucket: " + findingResource + "\n"
    message += "Severity: " + findingSeverity + "\n"
    message += "Resource Owner: " + findingOwner + "\n"
    
    #Check if it is a sensitive data finding
    if("SensitiveData" in findingDetail):
        sensitiveFile = event["detail"]["resourcesAffected"]["s3Object"]["path"]
        message += "Sensitive Data is found in: " + sensitiveFile + "\n"
    
    message += "\nPlease log in to AWS Macie to review the finding"
    
    response = client.publish(
        TopicArn = snsArn,
        Message = message ,
        Subject='AWS Macie Finding for Account ' + accountId
    )
    
    return {
        'statusCode' : 200,
        'body': json.dumps('Success!')
    }