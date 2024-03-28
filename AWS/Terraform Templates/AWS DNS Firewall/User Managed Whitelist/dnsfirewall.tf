# Implement block all for whitelist approach

resource "aws_route53_resolver_firewall_domain_list" "blockall_domains" {
  name    = "blockall_domains"
  domains = ["*"]
}

resource "aws_route53_resolver_firewall_rule_group" "dns_firewall_rule_group" {
  name = "dns_firewall_rule_group"
}

resource "aws_route53_resolver_firewall_rule" "block_all_rule" {
  name                    = "dns_firewall_blockall_rule"
  action                  = "BLOCK"
  block_response          = "NXDOMAIN" # Consider using NXDOMAIN or NODATA
  firewall_domain_list_id = aws_route53_resolver_firewall_domain_list.blockall_domains.id
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.dns_firewall_rule_group.id
  priority                = var.blockall_priority
}

# Implement whitelist domains 

resource "aws_route53_resolver_firewall_domain_list" "whitelist_domains" {
  name    = "whitelist_domains"
  domains = var.whitelisted_domains
}

resource "aws_route53_resolver_firewall_rule" "whitelist_domains_rule" {
  name                    = "dns_firewall_whitelist_rule"
  action                  = "ALLOW"
  firewall_domain_list_id = aws_route53_resolver_firewall_domain_list.whitelist_domains.id
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.dns_firewall_rule_group.id
  priority                = var.whitelist_priority
}


resource "aws_route53_resolver_firewall_rule_group_association" "domains_association" {
  for_each               = var.vpc_id
  name                   = "dns_firewall_rule_association-${each.value}"
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.dns_firewall_rule_group.id
  priority               = var.rule_group_priority
  vpc_id                 = each.value
}
