variable "openstack_user" { } 
variable "openstack_pass" { } 
variable "openstack_tenant" { }
variable "home" { }
variable "image_name" {
  default = "Ubuntu 14.04"
}

variable "flavor_name" {
  default = "m1.medium"
}

variable "region" {
  default = "RegionOne"
}

