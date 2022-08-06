# resource "docker_image" "nodered_image" {

# #  name = "nodered/node-red:latest"
#   name = var.image[terraform.workspace]
# }

module "image" {
  source = "./image"
  # image_in= var.image[terraform.workspace]    # workspace helps to define the environment like dev and prod. Terraform.workspace brings the env which are being selected by
                                                # terraform workspace select prod. New environment command is terraform workspace new prod.
  for_each = local.deployment
  image_in = each.value.image
  # image_in= var.image["nodered"][terraform.workspace]
}

# module "influxdb_image" {
#   source = "./image"
#   image_in= var.image["influxdb"][terraform.workspace]
# }

# resource "null_resource" "dockervol" {

#   provisioner "local-exec" {
#     command = "mkdir noderedvol/ || true && sudo chown -R 1000:1000 noderedvol/"
#   }

# }

module "container" {
  source = "./container"
  # depends_on = [null_resource.dockervol]
  count_in = each.value.container_count
  for_each = local.deployment
  # count = local.container_count
  # name_in = join("-",["nodered",terraform.workspace,random_string.random[count.index].result])
  #   name_in = join("-",[each.key,terraform.workspace,random_string.random[each.key].result])
  name_in = each.key
  # image_in = module.nodered_image.image_out
  # image_in = module.image["nodered"].image_out
  image_in    = module.image[each.key].image_out
  int_port_in = each.value.int
  ext_port_in = each.value.ext
  # container_path_in = each.value.container_path
  volumes_in = each.value.volumes
  # int_port_in = var.int_port
  # ext_port_in = var.ext_port[terraform.workspace][count.index]
  # container_path_in = "/data"
  # host_path_in = "${path.cwd}/noderedvol"

}

