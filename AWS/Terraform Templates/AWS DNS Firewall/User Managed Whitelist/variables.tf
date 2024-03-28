variable "whitelisted_domains" {
  description = "Whitelisted Domains"
  type        = list(any)
  default     = ["example1.com", "example2.com", "example3.com"]
}

# Priority should be between 100 - 9900
variable "whitelist_priority" {
  description = "Indicate rule priority for whitelisted domains" # Number should be of higher priority before the block all rule 
  type        = number
}

# Priority should be between 100 - 9900
variable "blockall_priority" {
  description = "Indicate rule priority for whitelisted domains" # Number should be of lower priority
  type        = number
}

# Priority should be between 100 - 9900
variable "rule_group_priority" {
  description = "Indicate rule priority for rule group" 
  type        = number
}

# Indicate all VPC IDs 
variable "vpc_id" {
  description = "Indicate VPC ID to apply DNS Firewall rules"
  type        = set(string)
}

