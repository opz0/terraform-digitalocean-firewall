output "name" {
  value       = module.firewall[*].name
  description = "The name of the Firewall."
}