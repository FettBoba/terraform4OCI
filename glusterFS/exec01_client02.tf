# Test for SSH 
resource "null_resource" "client02_sshdummy" {
   
   provisioner "remote-exec" {
   connection {
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.InstanceVnic_client2.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "echo ssh_ready"
      ]
    }
}

# Execute remote commands

resource "null_resource" "client02_Gluster" {
   depends_on = ["null_resource.client02_sshdummy"]

   provisioner "file" {
   connection {
        agent = false
        timeout = "5m"
        host = "${data.oci_core_vnic.InstanceVnic_client2.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      source = "./userdata/bootstrapClient02"
      destination = "~/bootstrapClient02"
    }

   provisioner "remote-exec" {
   connection {
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.InstanceVnic_client2.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "chmod 700 ~/bootstrapClient02"

      ]
    }
}

