# Terraform-digitalocean-firewall
# Terraform digitalocean Cloud firewall Module.

## Table of Contents

- [Introduction](#introduction)
- [Usage](#usage)
- [Examples](#examples)
- [Author](#author)
- [License](#license)
- [Inputs](#inputs)
- [Outputs](#outputs)

## Introduction
This Terraform configuration is designed to create and manage a DigitalOcean firewall.

## Usage

# Example: Database-Firewall
You can use this module in your Terraform configuration like this:
```hcl
module "firewall" {
  source              = "cypik/firewall/digitalocean"
  version             = "1.0.1"
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


# Example: Default
You can use this module in your Terraform configuration like this:
```hcl
module "firewall" {
  source      = "cypik/firewall/digitalocean"
  version     = "1.0.1"
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


## Examples
For detailed examples on how to use this module, please refer to the [examples](https://github.com/cypik/terraform-digitalocean-firewall/tree/master/example) directory within this repository.

## Author
Your Name Replace **MIT** and **Cypik** with the appropriate license and your information. Feel free to expand this README with additional details or usage instructions as needed for your specific use case.

## License
This Terraform module is provided under the **MIT** License. Please see the [LICENSE](https://github.com/cypik/terraform-digitalocean-firewall/blob/master/LICENSE) file for more details.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.4.6 |
| <a name="requirement_digitalocean"></a> [digitalocean](#requirement\_digitalocean) | >= 2.28.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_digitalocean"></a> [digitalocean](#provider\_digitalocean) | >= 2.28.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_labels"></a> [labels](#module\_labels) | cypik/labels/digitalocean | 1.0.1 |

## Resources

| Name | Type |
|------|------|
| [digitalocean_database_firewall.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/database_firewall) | resource |
| [digitalocean_firewall.default](https://registry.terraform.io/providers/digitalocean/digitalocean/latest/docs/resources/firewall) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_cluster_id"></a> [database\_cluster\_id](#input\_database\_cluster\_id) | The ID of the target database cluster. | `string` | `null` | no |
| <a name="input_droplet_ids"></a> [droplet\_ids](#input\_droplet\_ids) | The ID of the VPC that the instance security group belongs to. | `list(any)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Flag to control the firewall creation. | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| <a name="input_inbound_rules"></a> [inbound\_rules](#input\_inbound\_rules) | List of objects that represent the configuration of each inbound rule. | `any` | `[]` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| <a name="input_managedby"></a> [managedby](#input\_managedby) | ManagedBy, eg 'terraform-do-modules' or 'hello@Opz0.com' | `string` | `"terraform-do-modules"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| <a name="input_outbound_rule"></a> [outbound\_rule](#input\_outbound\_rule) | List of objects that represent the configuration of each outbound rule. | <pre>list(object({<br>    protocol              = string<br>    port_range            = string<br>    destination_addresses = list(string)<br>    droplet_ids           = list(any)<br>    kubernetes_ids        = list(any)<br>    load_balancer_uids    = list(any)<br>    tags                  = list(any)<br>  }))</pre> | <pre>[<br>  {<br>    "destination_addresses": [<br>      "0.0.0.0/0",<br>      "::/0"<br>    ],<br>    "droplet_ids": [],<br>    "kubernetes_ids": [],<br>    "load_balancer_uids": [],<br>    "port_range": "1-65535",<br>    "protocol": "tcp",<br>    "tags": []<br>  },<br>  {<br>    "destination_addresses": [<br>      "0.0.0.0/0",<br>      "::/0"<br>    ],<br>    "droplet_ids": [],<br>    "kubernetes_ids": [],<br>    "load_balancer_uids": [],<br>    "port_range": "1-65535",<br>    "protocol": "udp",<br>    "tags": []<br>  }<br>]</pre> | no |
| <a name="input_rules"></a> [rules](#input\_rules) | List of objects that represent the configuration of each inbound rule. | `any` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the target database cluster. |
| <a name="output_database_uuid"></a> [database\_uuid](#output\_database\_uuid) | A unique identifier for the firewall rule. |
| <a name="output_droplet_ids"></a> [droplet\_ids](#output\_droplet\_ids) | The list of the IDs of the Droplets assigned to the Firewall. |
| <a name="output_id"></a> [id](#output\_id) | A unique ID that can be used to identify and reference a Firewall. |
| <a name="output_inbound_rule"></a> [inbound\_rule](#output\_inbound\_rule) | The inbound access rule block for the Firewall. |
| <a name="output_name"></a> [name](#output\_name) | The name of the Firewall. |
| <a name="output_outbound_rule"></a> [outbound\_rule](#output\_outbound\_rule) | The name of the Firewall. |
<!-- END_TF_DOCS -->