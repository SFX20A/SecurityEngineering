
variable "blacklist_domains" {
  description = "Blacklisted Domains"
  type        = list(any)
  default     = ["example1.com", "example2.com", "example3.com"] # Add * if you want to block subdomains via wildcards.
}

# Note that priority has to be between 100 and 9900
variable "priority" {
  description = "Indicate rule priority"
  type        = number
}

# Indicate all VPC IDs 
variable "vpc_id" {
  description = "Indicate VPC ID to apply DNS Firewall rules"
  type        = set(string)
}

