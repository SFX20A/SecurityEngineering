resource "aws_route53_resolver_firewall_domain_list" "blacklist_domains" {
  name    = "Blacklisted_Domains"
  domains = var.blacklist_domains
}

resource "aws_route53_resolver_firewall_rule_group" "blacklist_domains_rule_group" {
  name = "blacklist_domain_rule_group"
}

resource "aws_route53_resolver_firewall_rule" "blacklist_domains_rule" {
  name                    = "dns_firewall_rule"
  action                  = "BLOCK"
  block_response          = "NXDOMAIN" # Edit according based on block response, resource block is written based on NODATA or NXDOMAIN
  firewall_domain_list_id = aws_route53_resolver_firewall_domain_list.blacklist_domains.id
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.blacklist_domains_rule_group.id
  priority                = var.priority
}


resource "aws_route53_resolver_firewall_rule_group_association" "blacklist_domains_association" {
  for_each               = var.vpc_id
  name                   = "dns_firewall_rule_association-${each.value}"
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.blacklist_domains_rule_group.id
  priority               = var.priority
  vpc_id                 = each.value
}
