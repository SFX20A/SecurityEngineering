# Edit blacklist domains
variable "blacklist_domain" {
  description = "List of blacklisted domains"
  type        = list(any)
  default     = ["domain1.com", "domain2.com"]
}

variable "capacity_domainblacklist" {
  description = "Rule group capacity" 
  type        = number
  default     = 10 #E dit accordingly if there is a need to increase the amount of rules.
}


variable "capacity_ipblacklist" {
  description = "Rule group capacity" 
  type        = number
  default     = 10 # Edit if there is a need to increase the amount of rules.
}

variable "blacklist_ip" {
  description = "List of blacklisted IP addresses"
  type        = list(string)
  default     = ["192.168.1.0/32", "192.168.0.0/32", "192.168.2.0/32"]
}

variable "priority_ingress" {
  description = "Blacklist IP rule priority for ingress rules"
  type        = number
  default     = 10 # Edit if there is a need to amend the priority number
}

variable "priority_egress" {
  description = "Blacklist IP rule priority for egress rules"
  type        = number
  default     = 20 # Edit if there is a need to amend the priority number
}



resource "aws_networkfirewall_rule_group" "domain_blacklist" {
  capacity    = var.capacity_domainblacklist
  name        = "domainblacklist"
  type        = "STATEFUL" # to block regardless of state
  rule_group {
    rules_source {
      rules_source_list {
        generated_rules_type = "DENYLIST"
        target_types         = ["HTTP_HOST", "TLS_SNI"]
        targets              = var.blacklist_domain
      }
    }
  }
}

resource "aws_networkfirewall_rule_group" "ip_blacklist_ingress" {
  capacity    = var.capacity_ipblacklist
  name        = "ipblacklist-ingress"
  type        = "STATELESS"
  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = var.priority_ingress
          rule_definition {
            actions = ["aws:drop"]
            match_attributes {
              dynamic "source" {
                for_each = var.blacklist_ip
                content {
                  address_definition = source.value
                }
              }
            }
          }
        }
      }
    }
  }
}


resource "aws_networkfirewall_rule_group" "ip_blacklist_egress" {
  capacity    = var.capacity_ipblacklist
  name        = "ipblacklist-egress"
  type        = "STATELESS"
  rule_group {
    rules_source {
      stateless_rules_and_custom_actions {
        stateless_rule {
          priority = var.priority_egress
          rule_definition {
            actions = ["aws:drop"]
            match_attributes {
              dynamic "destination" {
                for_each = var.blacklist_ip
                content {
                  address_definition = destination.value
                }
              }
            }
          }
        }
      }
    }
  }
}
