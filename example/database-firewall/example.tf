provider "digitalocean" {}

locals {
  name        = "app"
  environment = "test"
}

##------------------------------------------------
## database Firewall module call
##------------------------------------------------
module "firewall" {
  source              = "./../../"
  name                = local.name
  environment         = local.environment
  enabled             = false
  database_cluster_id = "" # It's okay to leave this empty if enabled is false
  rules = [
    {
      type  = "ip_addr"
      value = "192.168.1.1"
    },
  ]
}

