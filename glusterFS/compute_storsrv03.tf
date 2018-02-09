resource "oci_core_instance" "storsrv3" {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
    compartment_id = "${var.compartment_ocid}"
    display_name = "storsrv3"
    image = "${lookup(data.oci_core_images.OLImageOCID.images[0], "id")}"
    shape = "${var.STORShapeL}"
    subnet_id = "${oci_core_subnet.STORSubNet_AD3.id}"
    hostname_label = "storsrv3"
    metadata {
        ssh_authorized_keys = "${var.ssh_public_key}"
#        user_data = "${base64encode(file(var.storsrv3BootStrapFile))}"
    }
  timeouts {
    create = "10m"
  }
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic_attachments" "InstanceVnics_storsrv3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${oci_core_instance.storsrv3.id}"
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic" "InstanceVnic_storsrv3" {
  vnic_id = "${lookup(data.oci_core_vnic_attachments.InstanceVnics_storsrv3.vnic_attachments[0],"vnic_id")}"
}

# Output the private and public IPs of the instance
output "storsrv3_PrivateIP" {
value = "${data.oci_core_vnic.InstanceVnic_storsrv3.private_ip_address}"
}
output "storsrv3_PublicIP" {
value = "${data.oci_core_vnic.InstanceVnic_storsrv3.public_ip_address}"
}
