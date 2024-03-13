resource "aws_route53_resolver_firewall_rule_group" "blacklist_domains_rule_group" {
  name = "managed_list_rule_group"
}

resource "aws_route53_resolver_firewall_rule" "blacklist_domains_rule" {
  count                   = length(var.managed_lists)
  name                    = "${var.managed_lists[count.index]}-dns_firewall_rule"
  action                  = "BLOCK"
  block_response          = "NXDOMAIN" # Edit according based on block response, resource block is written based on NODATA or NXDOMAIN
  firewall_domain_list_id = var.managed_lists[count.index]
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.blacklist_domains_rule_group.id
  priority                = var.priority + count.index
}

resource "aws_route53_resolver_firewall_rule_group_association" "blacklist_domains_association" {
  for_each               = var.vpc_id
  name                   = "dns_firewall_rule_association-${each.value}"
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.blacklist_domains_rule_group.id
  priority               = var.priority
  vpc_id                 = each.value
}
