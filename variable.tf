
# variable "env" {

#   type =  string
#   default = "dev"
#   description = "Env to deploy to"
#   }

variable "image" {
  type        = map(any)
  description = "Image for the different env"

  default = {
    nodered = {
      dev  = "nodered/node-red:latest"
      prod = "nodered/node-red:latest-minimal"
    }

    influxdb = {
      dev  = "quay.io/influxdb/influxdb:v2.0.2"
      prod = "quay.io/influxdb/influxdb:v2.0.2"
    }

    grafana = {
      dev  = "grafana/grafana"
      prod = "grafana/grafana"
    }
  }
}

variable "ext_port" {
  type = map(any)
  #  sensitive = true
  # validation {
  #   condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
  #   error_message = "The external port must be between the range 65535 to 0."
  # }
  # validation {
  #   condition = max(var.ext_port["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
  #   error_message = "The external port must be between the range 65535 to 0."
  # }

}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal port must be 1880."
  }
}

# variable "container_count" {
#   type = number
#   default = 3
# }

# locals {
#   container_count = length(var.ext_port[terraform.workspace])
# }