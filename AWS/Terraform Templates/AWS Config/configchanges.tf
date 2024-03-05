# Get Account ID
data "aws_caller_identity" "current" {}

# Create SNS topic
resource "aws_sns_topic" "eventbridge_sns_topic" {
  name = var.sns_topic_name
}

# Add SNS Access Policy
resource "aws_sns_topic_policy" "sns_access_policy" {
  arn    = aws_sns_topic.eventbridge_sns_topic.arn
  policy = data.aws_iam_policy_document.sns_topic_policy.json

}

# SNS Access Policy Attachment
data "aws_iam_policy_document" "sns_topic_policy" {
  statement {
    sid     = "publish_eventbridge"
    actions = ["sns:Publish"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    resources = [aws_sns_topic.eventbridge_sns_topic.arn]

  }

  statement {
    sid     = "default_policy"
    actions = ["sns:GetTopicAttributes", "sns:SetTopicAttributes", "sns:AddPermission", "sns:RemovePermission", "sns:DeleteTopic", "sns:Subscribe", "sns:ListSubscriptionsByTopic", "sns:Publish"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [aws_sns_topic.eventbridge_sns_topic.arn]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [data.aws_caller_identity.current.account_id]

    }

  }
}

# Create SNS topic subscription
resource "aws_sns_topic_subscription" "cloudwatch_alarm_topic_subscription" {
  topic_arn = aws_sns_topic.eventbridge_sns_topic.arn
  protocol  = var.sns_subscription_protocol
  endpoint  = var.sns_subscription_endpoint

}

# Create EventBridge rule
resource "aws_cloudwatch_event_rule" "console" {
  name        = "${var.detect_config_changes}"
  description = "Alert on detection of CREATE/UPDATE/DELETE of AWS resources"

  # Edit if scope needs to be reduced (e.g. EC2 only)
  event_pattern = jsonencode({
    source      = ["aws.config"],
    detail-type = ["Config Configuration Item Change"]
  })
}

# Create EventBridge Target
resource "aws_cloudwatch_event_target" "sns" {
  rule = aws_cloudwatch_event_rule.console.name
  arn  = aws_sns_topic.eventbridge_sns_topic.arn
}
