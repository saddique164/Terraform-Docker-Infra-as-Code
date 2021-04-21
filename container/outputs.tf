# output "ip_address" {
#   value = [for i in docker_container.nodered_container[*]: join(":", i.ip_address[*],i.ports[*]["external"])]
#   description = "The private IP address and port of second container the main server instance."
# # sensitive = true    # Since external has been refer here. for hidding it sensitive must be here as well.
# }

# output "container-name" {
#   value = docker_container.nodered_container.name
#   description = "The name of the main server instance."
# }

output "application_access" {
  value = { for x in docker_container.app_container[*] : x.name => join(":", x.ip_address[*], x.ports[*]["external"]) }
}