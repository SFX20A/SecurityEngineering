import boto3
import json

def lambda_handler(event, context):
    # Extract repository name from the event
    repoName = event['detail']['resources'][0]['details']['awsEcrContainerImage']['repositoryName']
    
    # Extract severity finding
    severity = event['detail']['severity']
    
    # Initialize ECR client
    ecr = boto3.client('ecr')
    
    print(severity)
    
    if severity != 'UNTRIAGED' or severity != 'INFORMATIONAL':
        try:
            # Get AWS account ID
            aws_account_id = boto3.client('sts').get_caller_identity().get('Account')
            
            
            policyText = '''{
              "Version": "2008-10-17",
              "Statement": [
                {
                "Sid": "deny all",
                "Effect": "Deny",
                "Principal": "*",
                "Action": [
                    "ecr:BatchGetImage",
                    "ecr:GetDownloadUrlForLayer"
                ]
            },
            {
                "Sid": "Allow push",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::%s:root"
                },
                "Action": [
                    "ecr:BatchCheckLayerAvailability",
                    "ecr:CompleteLayerUpload",
                    "ecr:InitiateLayerUpload",
                    "ecr:PutImage",
                    "ecr:UploadLayerPart"
                ]
            }
              ]
            }''' % aws_account_id
            
            response = ecr.set_repository_policy(
                repositoryName=repoName,
                policyText=policyText
            )
            
            print("Repository policy set successfully.")
        
        except Exception as e:
            print("Error:", e)
            print("Failed to set repository policy.")
            raise
    
    return {
        'statusCode': 200,
        'body': json.dumps('Repository policy set successfully.')
    }
