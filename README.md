A project that uses terraform to provision a host on openstack

1. ```terraform plan -var openstack_user=admin -var openstack_pass=mypass -var openstack_tenant=admin -var home=$HOME```

2. ```terraform apply -var openstack_user=admin -var openstack_pass=mypass -var openstack_tenant=admin -var home=$HOME```

This generates at the end a inventory file to be used by ansible

To install ELK on that host

```ansible-playbook -i inventory.txt playbook.ym```

At the end, you can access kibana by seeing the IP of the host on inventory file zB:

http://10.0.0.7

You can also access kopf dashboard

http://10.0.0.7:9200/_plugin/kopf/#!/nodes

