resource "random_string" "random" {
  # count =  local.container_count
  count   = var.count_in
  length  = 4
  special = false
  upper   = false

}

resource "docker_container" "app_container" {
  count = var.count_in
  name  = join("-", [var.name_in, terraform.workspace, random_string.random[count.index].result])
  image = var.image_in


  ports {
    internal = var.int_port_in
    external = var.ext_port_in[count.index]
  }

  # volumes {
  #   container_path = var.container_path_in
  #   # host_path =  var.host_path_in
  #   # volume_name = "${var.name_in}-volume"
  #   volume_name = docker_volume.container_volume[count.index].name
  # }
  dynamic "volumes" {
    for_each = var.volumes_in
    content {
      # container_path = var.container_path_in
      container_path = volumes.value["container_path_each"]
      # volume_name = docker_volume.container_volume[volumes.key].name
      volume_name = module.volume[count.index].volume_output[volumes.key]
      # host_path =  var.host_path_in
      # volume_name = "${var.name_in}-volume"
      # volume_name = docker_volume.container_volume[count.index].name
    }
  }
  provisioner "local-exec" {
    command = "echo ${self.name}: ${self.ip_address}:${var.ext_port_in[count.index]}>> container.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -rf container.txt"

  }
}


# resource "docker_volume" "container_volume" {
#   # count = var.count_in
#   count = length(var.volumes_in)
#   # name = "${docker_container.nodered_container.name}-volume"  
#   # name = "${var.name_in}-${random_string.random[count.index].result}-volume"
#   name = "${var.name_in}-${count.index}-volume"
#   lifecycle { prevent_destroy = false }

#   provisioner "local-exec" {
#     when       = destroy
#     command    = "mkdir ${path.cwd}/../backup/"
#     on_failure = continue

#   }

#   provisioner "local-exec" {
#     when       = destroy
#     command    = "sudo tar -czvf ${path.cwd}/../backup/${self.name}.tar.gzip ${self.mountpoint}/"
#     on_failure = fail

#   }


# }

module "volume" {

  source       = "./volume"
  count        = var.count_in
  volume_count = length(var.volumes_in)
  volume_name  = "${var.name_in}-${terraform.workspace}-${random_string.random[count.index].result}-volume"
}