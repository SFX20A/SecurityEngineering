# Get Account ID
data "aws_caller_identity" "current" {}

# Get current region
data "aws_region" "current" {}

# Create EventBridge rule
resource "aws_cloudwatch_event_rule" "console" {
  name        = "ecr-vuln-block-detection"
  description = "Detects vulnerable container images uploaded"

  # Edit severity as requried
  event_pattern = jsonencode({
    "source" : ["aws.inspector2"],
    "detail-type" : ["Inspector2 Finding"],
    "detail" : {
      "severity" : ["HIGH"],
      "resources" : {
        "type" : ["AWS_ECR_CONTAINER_IMAGE"]
      }
    }
  })
}

# Create EventBridge Target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.console.name
  arn  = aws_lambda_function.ecr_block_vuln_lambda.arn
}


# Create IAM policy for Lambda
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

# Create IAM role for lambda
resource "aws_iam_role" "iam_for_lambda" {
  name               = "ecr-vuln-block-iam-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  inline_policy {
    name = "ECR_Lambda_inline_policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          "Effect" : "Allow",
          "Action" : "logs:CreateLogGroup",
          "Resource" : "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "logs:CreateLogStream",
            "logs:PutLogEvents"
          ],
          "Resource" : [
            "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/ecr-vuln-block:*"
          ]
        },
        {
          "Effect" : "Allow",
          "Action" : "ecr:SetRepositoryPolicy",
          "Resource" : "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*"
        }
      ]
    })
  }
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "ecr-lambda-code.py"
  output_path = "ecr-lambda-code.zip"
}

# Create lambda function
resource "aws_lambda_function" "ecr_block_vuln_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "ecr-lambda-code.zip"
  function_name = "ecr-vuln-block"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "ecr-lambda-code.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.12"

  timeout = 10


}

# Attached resource based policy
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventbridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ecr_block_vuln_lambda.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.console.arn
}

# Create Lambda Cloudwatch Log Group
resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/aws/lambda/${aws_lambda_function.ecr_block_vuln_lambda.function_name}"
  retention_in_days = 14
}