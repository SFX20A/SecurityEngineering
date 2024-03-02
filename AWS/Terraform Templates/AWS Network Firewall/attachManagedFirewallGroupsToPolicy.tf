# Configure AWS provider
provider "aws" {
  region = "region"
}

# Variable to input firewallpolicy
variable "FirewallPolicyName" {

  type        = string
  description = "The Firewall Policy Name to attach the AWS managed rule groups"

}

# Attach the Managed Firewall Groups to the Policy
resource "aws_networkfirewall_firewall_policy" "firewallPolicytoAttach" {
  name = var.FirewallPolicyName

  firewall_policy {
    stateless_default_actions          = ["aws:forward_to_sfe"]
    stateless_fragment_default_actions = ["aws:forward_to_sfe"]

    stateful_engine_options {
      rule_order = "DEFAULT_ACTION_ORDER"
    }


    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesEmergingEventsActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesExploitsActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesMalwareCoinminingActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesMalwareMobileActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesWebAttacksActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/AbusedLegitMalwareDomainsActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesBotnetWindowsActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesMalwareWebActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesIOCActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesScannersActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/MalwareDomainsActionOrder"
    }
    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesSuspectActionOrder"
    }
    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesFUPActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesDoSActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesPhishingActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesBotnetActionOrder"
    }
    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/AbusedLegitBotNetCommandAndControlDomainsActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/BotNetCommandAndControlDomainsActionOrder"
    }

    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesMalwareActionOrder"
    }
    stateful_rule_group_reference {
      resource_arn = "arn:aws:network-firewall:region:aws-managed:stateful-rulegroup/ThreatSignaturesBotnetWebActionOrder"
    }

  }

  # Insert Appropriate Tag
  tags = {
    Tag1 = "Value1"
    Tag2 = "Value2"
  }
}
