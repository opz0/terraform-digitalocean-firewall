provider "digitalocean" {}


##------------------------------------------------
## VPC module call
##------------------------------------------------
module "vpc" {
  source      = "cypik/vpc/digitalocean"
  version     = "1.0.1"
  name        = "app"
  environment = "test"
  region      = "blr1"
  ip_range    = "10.20.0.0/24"
}

##------------------------------------------------
## Droplet module call
##------------------------------------------------
module "droplet" {
  source      = "cypik/droplet/digitalocean"
  version     = "1.0.1"
  name        = "app"
  environment = "test"
  region      = "blr1"
  vpc_uuid    = module.vpc.id
  ssh_key     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC6SAFyvG3N1ccEk/vidgdrthdhdherhdfb"
  user_data   = file("user-data.sh")
  ####firewall
  enable_firewall = false
}

##------------------------------------------------
## Firewall module call
##------------------------------------------------
module "firewall" {
  source      = "./../../"
  name        = "app"
  environment = "test"
  inbound_rules = [
    {
      allowed_ip    = ["0.0.0.0/0"]
      allowed_ports = "22"
    },
    {
      allowed_ip    = ["0.0.0.0/0"]
      allowed_ports = "80"
    }
  ]
  droplet_ids = module.droplet.id
}