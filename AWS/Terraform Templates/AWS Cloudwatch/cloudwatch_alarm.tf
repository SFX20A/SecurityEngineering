resource "aws_cloudwatch_metric_alarm" "configservice_change_alarm" {
  alarm_name          = "configservice_change_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "configservice_changes"
  namespace           = "LogMetrics"
  statistic           = "Sum"
  threshold           = 1
  period              = 10
  alarm_description   = "There are changes detected to ConfigService"
  alarm_actions       = ["arn:aws:sns:region:aws-account-id:sns_topic_name"]
}

resource "aws_cloudwatch_metric_alarm" "nacl_change_alarm" {
  alarm_name          = "nacl_change_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "nacl_changes"
  namespace           = "LogMetrics"
  statistic           = "Sum"
  threshold           = 1
  period              = 10
  alarm_description   = "There are changes detected to NACL configuration"
  alarm_actions       = ["arn:aws:sns:region:aws-account-id:sns_topic_name"]
}

resource "aws_cloudwatch_metric_alarm" "network_gateway_change_alarm" {
  alarm_name          = "network_gateway_change_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "network_gateway_changes"
  namespace           = "LogMetrics"
  statistic           = "Sum"
  threshold           = 1
  period              = 10
  alarm_description   = "There are changes detected to the network gateway configuration"
  alarm_actions       = ["arn:aws:sns:region:aws-account-id:sns_topic_name"]
}

resource "aws_cloudwatch_metric_alarm" "route_table_change_alarm" {
  alarm_name          = "route_table_change_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "route_table_changes"
  namespace           = "LogMetrics"
  statistic           = "Sum"
  threshold           = 1
  period              = 10
  alarm_description   = "There are changes detected to the route table configuration"
  alarm_actions       = ["arn:aws:sns:region:aws-account-id:sns_topic_name"]
}

resource "aws_cloudwatch_metric_alarm" "security_group_change_alarm" {
  alarm_name          = "security_group_change_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "security_group_changes"
  namespace           = "LogMetrics"
  statistic           = "Sum"
  threshold           = 1
  period              = 10
  alarm_description   = "There are changes detected to the security group configuration"
  alarm_actions       = ["arn:aws:sns:region:aws-account-id:sns_topic_name"]
}

resource "aws_cloudwatch_metric_alarm" "vpc_change_alarm" {
  alarm_name          = "vpc_change_alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 1
  metric_name         = "vpc_changes"
  namespace           = "LogMetrics"
  statistic           = "Sum"
  threshold           = 1
  period              = 10
  alarm_description   = "There are changes detected to the vpc configuration"
  alarm_actions       = ["arn:aws:sns:region:aws-account-id:sns_topic_name"]
}