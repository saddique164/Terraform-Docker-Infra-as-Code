
# variable "env" {    # the env is used to take the variables from terraform.tfvar file and pass it to the code for relevant environment like dev and prod.
                       
#   type =  string
#   default = "dev"
#   description = "Env to deploy to"
#   }

variable "image" {             #This helps to find the images mapping in lookup command. example lookup (var.image,"dev"). It will pick nodered/node-red:latest image.
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
  #   condition = max(var.ext_port["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980    #min and max value take the list from variable.ext_port and varify it in the
                                                                                                 # same range. "..." is very important to taking the value out of "[]".
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

  validation {                          # validation help to keeps int_port value same as 1880. If it gets changed in default, it will throw error_message.
    condition     = var.int_port == 1880
    error_message = "The internal port must be 1880."   # The "T" must be capital and there should be comma in the end.
  }
}

# variable "container_count" {
#   type = number
#   default = 3
# }

# locals {
#   container_count = length(var.ext_port[terraform.workspace])
# }
