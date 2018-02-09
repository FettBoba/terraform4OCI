# Test for SSH 
resource "null_resource" "storsrv01_sshdummy" {
   
   provisioner "remote-exec" {
   connection {
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.InstanceVnic_storsrv1.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "echo ssh_ready"
      ]
    }
}

# Execute remote commands

resource "null_resource" "storsrv01_Gluster" {
   depends_on = ["null_resource.storsrv01_sshdummy"]

   provisioner "file" {
   connection {
        agent = false
        timeout = "5m"
        host = "${data.oci_core_vnic.InstanceVnic_storsrv1.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      source = "./userdata/bootstrapGlusterNode"
      destination = "~/bootstrapGlusterNode"
    }

   provisioner "file" {
   connection {
        agent = false
        timeout = "5m"
        host = "${data.oci_core_vnic.InstanceVnic_storsrv1.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      source = "./userdata/initGlusterNode01"
      destination = "~/initGlusterNode01"
    }
}

resource "null_resource" "storsrv01_Gluster_RUN" {
   depends_on = ["null_resource.storsrv01_Gluster"]

   provisioner "remote-exec" {
   connection {
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.InstanceVnic_storsrv1.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "chmod 700 ~/bootstrapGlusterNode",
        "chmod 700 ~/initGlusterNode01",
        "sudo bash ~/bootstrapGlusterNode > ~/GlusterSetup.log 2>&1"
      ]
    }
}

resource "null_resource" "storsrv01_Gluster_INIT" {
   depends_on = ["null_resource.storsrv01_Gluster_RUN", "null_resource.storsrv02_Gluster_RUN", "null_resource.storsrv03_Gluster_RUN"]

   provisioner "remote-exec" {
   connection {
        agent = false
        timeout = "10m"
        host = "${data.oci_core_vnic.InstanceVnic_storsrv1.public_ip_address}"
        user = "opc"
        private_key = "${var.ssh_private_key}"
    }
      inline = [
        "sudo bash ~/initGlusterNode01 >> ~/GlusterSetup.log 2>&1"
      ]
    }
}

