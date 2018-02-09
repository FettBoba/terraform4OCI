resource "oci_core_volume" "StorSrv03Block01" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  compartment_id = "${var.compartment_ocid}"
  display_name = "StorSrv03Block01"
  size_in_gbs = "${var.256GB}"
}

resource "oci_core_volume_attachment" "StorSrv03Block01Attach" {
    attachment_type = "iscsi"
    compartment_id = "${var.compartment_ocid}"
    instance_id = "${oci_core_instance.storsrv3.id}"
    volume_id = "${oci_core_volume.StorSrv03Block01.id}"
}
