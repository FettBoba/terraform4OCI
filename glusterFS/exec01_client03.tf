# Test for SSH 
resource "null_resource" "clien03_sshdummy" {
   
   provisioner "remote-exec" {
   connection {
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.InstanceVnic_client3.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "echo ssh_ready"
      ]
    }
}

# Execute remote commands

resource "null_resource" "client03_Gluster" {
   depends_on = ["null_resource.clien03_sshdummy"]

   provisioner "file" {
   connection {
        agent = false
        timeout = "5m"
        host = "${data.oci_core_vnic.InstanceVnic_client3.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      source = "./userdata/bootstrapClient03"
      destination = "~/bootstrapClient03"
    }

   provisioner "remote-exec" {
   connection {
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.InstanceVnic_client3.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "chmod 700 ~/bootstrapClient03"
      ]
    }
}

