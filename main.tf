module "labels" {
  source      = "git::https://github.com/opz0/terraform-digitalocean-labels.git?ref=v1.0.0"
  version     = "1.0.0"
  name        = var.name
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}
#tfsec:ignore:digitalocean-compute-no-public-egress
resource "digitalocean_firewall" "default" {
  count       = var.enabled == true && var.database_cluster_id == null ? 1 : 0
  name        = format("%s-firewall", module.labels.id)
  droplet_ids = var.droplet_ids
  dynamic "inbound_rule" {
    #    iterator = port
    for_each = var.inbound_rules
    content {
      port_range                = inbound_rule.value.allowed_ports
      protocol                  = lookup(inbound_rule.value, "protocol", "tcp")
      source_addresses          = inbound_rule.value.allowed_ip
      source_droplet_ids        = lookup(inbound_rule.value, "droplet_ids", null)
      source_load_balancer_uids = lookup(inbound_rule.value, "load_balancer_uids", null)
      source_kubernetes_ids     = lookup(inbound_rule.value, "kubernetes_ids", null)
      source_tags               = lookup(inbound_rule.value, "tags", [])
    }
  }
  dynamic "outbound_rule" {
    for_each = var.outbound_rule
    content {
      protocol                       = outbound_rule.value.protocol
      port_range                     = outbound_rule.value.port_range
      destination_addresses          = outbound_rule.value.destination_addresses
      destination_droplet_ids        = outbound_rule.value.droplet_ids
      destination_kubernetes_ids     = outbound_rule.value.kubernetes_ids
      destination_load_balancer_uids = outbound_rule.value.load_balancer_uids
      destination_tags               = outbound_rule.value.tags
    }
  }

  tags = [
    module.labels.name,
    module.labels.environment,
    module.labels.managedby
  ]
}

##------------------------------------------------------------------------------------------------------------------------------------------
#Description : Provides a DigitalOcean database firewall resource allowing you to restrict connections to your database to trusted sources.
##------------------------------------------------------------------------------------------------------------------------------------------
resource "digitalocean_database_firewall" "default" {
  count      = var.enabled == true && var.database_cluster_id != null ? 1 : 0
  cluster_id = var.database_cluster_id
  dynamic "rule" {
    for_each = var.rules
    content {
      type  = rule.value.type
      value = rule.value.value
    }
  }
}