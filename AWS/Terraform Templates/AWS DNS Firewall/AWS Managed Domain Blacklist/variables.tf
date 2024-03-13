variable "blacklist_domains" {
  description = "Blacklisted Domains"
  type        = list(any)
  default     = ["example1.com", "example2.com", "example3.com"] # Add * if you want to block subdomains via wildcards.
}

variable "priority" {
  description = "Indicate rule priority"
  type        = number
}

variable "vpc_id" {
  description = "Indicate VPC ID to apply DNS Firewall rules"
  type        = set(string)
}

variable "managed_lists" {
  description = "List of AWS Managed DNS Firewall rules"
  type        = list(string)
  default     = ["rslvr-fdl-49099fd7fc3d4853", "rslvr-fdl-b1c1d04c32194010", "rslvr-fdl-2ff056c2bf334345", "rslvr-fdl-cc92cf0f3482427c"] # IDs of AWS Managed DNS Firewall Rules

}
