variable "sns_topic_name" {
  description = "Name of SNS topic"
  type        = string
}

variable "sns_subscription_protocol" {
  description = "Protocol of SNS to send notification/messages"
  type        = string
}

variable "sns_subscription_endpoint" {
  description = "Endpoint of SNS to send notification/messages"
  type        = string
}


variable "detect_config_changes" {
  description = "Name of the Eventbridge Rule"
  type        = string
}