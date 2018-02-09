resource "oci_core_instance" "client2" {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
    compartment_id = "${var.compartment_ocid}"
    display_name = "client2"
    image = "${lookup(data.oci_core_images.OLImageOCID.images[0], "id")}"
    shape = "${var.WEBShape}"
    subnet_id = "${oci_core_subnet.WEBSubNet_AD2.id}"
    hostname_label = "client2"
    metadata {
        ssh_authorized_keys = "${var.ssh_public_key}"
#        user_data = "${base64encode(file(var.XXXXXXXXXXXXXXX))}"
    }
  timeouts {
    create = "10m"
  }
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic_attachments" "InstanceVnics_client2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${oci_core_instance.client2.id}"
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic" "InstanceVnic_client2" {
  vnic_id = "${lookup(data.oci_core_vnic_attachments.InstanceVnics_client2.vnic_attachments[0],"vnic_id")}"
}

# Output the private and public IPs of the instance
output "client2_PrivateIP" {
value = "${data.oci_core_vnic.InstanceVnic_client2.private_ip_address}"
}
output "client2_PublicIP" {
value = "${data.oci_core_vnic.InstanceVnic_client2.public_ip_address}"
}
