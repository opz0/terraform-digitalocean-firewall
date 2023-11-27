variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "terraform-do-modules"
  description = "ManagedBy, eg 'terraform-do-modules' or 'hello@cypik.com'"
}

variable "enabled" {
  type        = bool
  default     = true
  description = "Flag to control the firewall creation."
}

variable "droplet_ids" {
  type        = list(any)
  default     = []
  description = "The ID of the VPC that the instance security group belongs to."
}

variable "database_cluster_id" {
  type        = string
  default     = null
  description = "The ID of the target database cluster."
}

variable "rules" {
  type        = any
  default     = []
  description = "List of objects that represent the configuration of each inbound rule."
}

variable "inbound_rules" {
  type        = any
  default     = []
  description = "List of objects that represent the configuration of each inbound rule."
}

variable "outbound_rule" {
  type = list(object({
    protocol              = string
    port_range            = string
    destination_addresses = list(string)
    droplet_ids           = list(any)
    kubernetes_ids        = list(any)
    load_balancer_uids    = list(any)
    tags                  = list(any)
  }))
  default = [
    {
      protocol   = "tcp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
      "::/0"]
      droplet_ids        = []
      kubernetes_ids     = []
      load_balancer_uids = []
      tags               = []
    },
    {
      protocol   = "udp"
      port_range = "1-65535"
      destination_addresses = [
        "0.0.0.0/0",
      "::/0"]
      droplet_ids        = []
      kubernetes_ids     = []
      load_balancer_uids = []
      tags               = []
    }
  ]
  description = "List of objects that represent the configuration of each outbound rule."
}
