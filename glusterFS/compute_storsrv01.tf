resource "oci_core_instance" "storsrv1" {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
    compartment_id = "${var.compartment_ocid}"
    display_name = "storsrv1"
    image = "${lookup(data.oci_core_images.OLImageOCID.images[0], "id")}"
    shape = "${var.STORShapeL}"
    subnet_id = "${oci_core_subnet.STORSubNet_AD3.id}"
    hostname_label = "storsrv1"
    metadata {
        ssh_authorized_keys = "${var.ssh_public_key}"
#        user_data = "${base64encode(file(var.storsrv1BootStrapFile))}"
    }
  timeouts {
    create = "10m"
  }
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic_attachments" "InstanceVnics_storsrv1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${oci_core_instance.storsrv1.id}"
}

# Gets the OCID of the first (default) VNIC
data "oci_core_vnic" "InstanceVnic_storsrv1" {
  vnic_id = "${lookup(data.oci_core_vnic_attachments.InstanceVnics_storsrv1.vnic_attachments[0],"vnic_id")}"
}

# Output the private and public IPs of the instance
output "storsrv1_PrivateIP" {
value = "${data.oci_core_vnic.InstanceVnic_storsrv1.private_ip_address}"
}
output "storsrv1_PublicIP" {
value = "${data.oci_core_vnic.InstanceVnic_storsrv1.public_ip_address}"
}
