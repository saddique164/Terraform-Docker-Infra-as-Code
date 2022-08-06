# In variable.tf file, we can't define or take the reference to the any value like count=length(ext_port). It will throw error. So to easy way to do it to define loca
# variables. Then you can refer them like local.ext_port.
locals {
  deployment = {

    nodered = {
      container_count = length(var.ext_port["nodered"][terraform.workspace])
      image           = var.image["nodered"][terraform.workspace]
      int             = 1880
      ext             = var.ext_port["nodered"][terraform.workspace]
      # container_path = "/data"
      volumes = [
        { container_path_each = "/data" }
      ]
    }

    influxdb = {
      container_count = length(var.ext_port["influxdb"][terraform.workspace])
      image           = var.image["influxdb"][terraform.workspace]
      int             = 8086
      ext             = var.ext_port["influxdb"][terraform.workspace]
      # container_path = "/var/lib/influxdb"
      volumes = [
        { container_path_each = "/var/lib/influxdb" }
      ]
    }

    grafana = {
      container_count = length(var.ext_port["grafana"][terraform.workspace])
      image           = var.image["grafana"][terraform.workspace]
      int             = 3000
      ext             = var.ext_port["grafana"][terraform.workspace]
      volumes = [
        { container_path_each = "/var/lib/grafana" },
        { container_path_each = "/etc/grafana" }
      ]
    }
  }
}
