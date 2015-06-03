provider "openstack" {
  auth_url = "http://10.0.0.1:5000/v2.0"
  user_name = "${var.openstack_user}"
  tenant_name = "${var.openstack_tenant}"
  password = "${var.openstack_pass}"
}

resource "openstack_compute_secgroup_v2" "elk_group" {
  name = "elk_group_${var.openstack_tenant}"
  description = "ELK Group"
  region = "RegionOne"

  rule {
    ip_protocol = "tcp"
    from_port = "22"
    to_port = "22"
    cidr = "0.0.0.0/0"
  }
  rule {
    ip_protocol = "tcp"
    from_port = "80"
    to_port = "80"
    cidr = "0.0.0.0/0"
  }
  rule {
    ip_protocol = "tcp"
    from_port = "9200"
    to_port = "9200"
    cidr = "0.0.0.0/0"
  }
  rule {
    ip_protocol = "tcp"
    from_port = "5000"
    to_port = "5000"
    cidr = "0.0.0.0/0"
  }
  rule {
    ip_protocol = "tcp"
    from_port = "22"
    to_port = "22"
    cidr = "::/0"
  }
}

resource "openstack_compute_instance_v2" "elk" {
  name = "elk_${var.openstack_tenant}"
  image_name = "${var.image_name}"
  flavor_name = "${var.flavor_name}"
  key_pair = "terraform"
  security_groups = [ "default", "${openstack_compute_secgroup_v2.elk_group.name}" ]
  region = "${var.region}"
  connection {
    user = "ubuntu"
    key_file = "key/cloud.key"
    host = "${openstack_compute_instance_v2.elk.access_ip_v4}"
  }

  provisioner file {
    source = "variables.tf"
    destination = "variables.tf"
  }

  provisioner "remote-exec" {
    inline = [
      "echo teste"
    ]
  }

  provisioner "local-exec" {
      command = "ssh-keygen -f ${var.home}/.ssh/known_hosts -R ${openstack_compute_instance_v2.elk.access_ip_v4}"
  }

  provisioner "local-exec" {
      command = "printf \"[elk]\n${openstack_compute_instance_v2.elk.access_ip_v4}\" > inventory.txt" 
  }
}


