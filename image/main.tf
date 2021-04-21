resource "docker_image" "container_image" {

  # name = "nodered/node-red:latest"
  #  name = var.image[terraform.workspace]
  name = var.image_in
}