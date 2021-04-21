
# output "IP-Address" {
#   value = flatten(module.container[*].ip_address)
#   description = "The private IP address and port of second container the main server instance."
# # sensitive = true    # Since external has been refer here. for hidding it sensitive must be here as well.
# }

# output "container-name" {
#   value = module.container[*].container-name
#   description = "The name of the main server instance."
# }

output "application_access" {
  value       = [for x in module.container[*] : x]
  description = "The name and socket for each container"
}
