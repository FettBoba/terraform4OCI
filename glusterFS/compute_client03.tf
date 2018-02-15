resource "oci_core_instance" "client3" {
    availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
    compartment_id = "${var.compartment_ocid}"
    display_name = "client3"
    image = "${lookup(data.oci_core_images.OLImageOCID.images[0], "id")}"
    shape = "${var.WEBShape}"
    subnet_id = "${oci_core_subnet.WEBSubNet_AD3.id}"
    hostname_label = "client3"
    metadata {
        ssh_authorized_keys = "${var.ssh_public_key}"
    }
  timeouts {
    create = "10m"
  }
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic_attachments" "InstanceVnics_client3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  instance_id = "${oci_core_instance.client3.id}"
}

# Gets a list of vNIC attachments on the instance
data "oci_core_vnic" "InstanceVnic_client3" {
  vnic_id = "${lookup(data.oci_core_vnic_attachments.InstanceVnics_client3.vnic_attachments[0],"vnic_id")}"
}

# Output the private and public IPs of the instance
output "client3_PrivateIP" {
value = "${data.oci_core_vnic.InstanceVnic_client3.private_ip_address}"
}
output "client3_PublicIP" {
value = "${data.oci_core_vnic.InstanceVnic_client3.public_ip_address}"
}
