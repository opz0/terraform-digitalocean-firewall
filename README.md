# terraform-digitalocean-firewall
# DigitalOcean Terraform Configuration

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Module Inputs](#module-inputs)
- [Module Outputs](#module-outputs)
- [Examples](#examples)
- [License](#license)

## Introduction
This Terraform configuration is designed to create and manage a DigitalOcean firewall.

## Usage

## Example: database-firewall
You can use this module in your Terraform configuration like this:
```hcl
module "firewall" {
  source              = "git::https://github.com/cypik/terraform-digitalocean-firewall.git?ref=v1.0.0"
  name                = "app"
  environment         = "test"
  database_cluster_id = "your_database_cluster_id"
  rules = [
    {
      type  = "ip_addr"
      value = "192.168.1.1"
    },
    # Add more rules as needed
  ]
}
```
Please replace "your_database_cluster_id" with the actual ID of your DigitalOcean database cluster, and adjust the firewall rules as needed.

## Example: default
You can use this module in your Terraform configuration like this:
```hcl
module "firewall" {
  source      = "git::https://github.com/cypik/terraform-digitalocean-firewall.git?ref=v1.0.0"
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
```


## Module Inputs

- 'source': The source of the Firewall module.
- 'name' (string): A name for the firewall.
- 'environment' (string): The environment in which the firewall rules will be applied.
- 'database_cluster_id' (string): The ID of the DigitalOcean database cluster to which the firewall rules will be applied.
- 'rules' (list of objects): A list of firewall rules to define. Each rule should have a `type` and a `value`.
- 'inbound_rules': An array of rules that specify the allowed IP ranges and ports.
- 'droplet_ids': The IDs of the Droplets to associate with the firewall.

## Module Outputs

This module does not produce any outputs. It is primarily used for labeling resources within your Terraform configuration.

## Examples
For detailed examples on how to use this module, please refer to the '[examples](https://github.com/cypik/terraform-digitalocean-firewall/blob/master/_examples)' directory within this repository.

## License
This Terraform module is provided under the '[License Name]' License. Please see the [LICENSE](https://github.com/cypik/terraform-digitalocean-firewall/blob/master/LICENSE) file for more details.

## Author
Your Name
Replace '[License Name]' and '[Your Name]' with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.
