# this file is used to define variable values for different region and repositories or environments and later you can call it in variable.tf files.
# If you need to use the different files like west.tfvar, you can use it. Then you call user "terraform apply --var-file west.tfvar" to utilize those values 
ext_port = {

  nodered = {
    dev  = [1980]
    prod = [1880]
  }

  influxdb = {
    dev  = [8180]
    prod = [8086]
  }

  grafana = {
    dev  = [3000]
    prod = [3001]
  }

}
