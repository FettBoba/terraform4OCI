# VCN
  resource "oci_core_virtual_network" "VCN_GlusterDemo" {
  cidr_block = "${var.VPC-CIDR}"
  compartment_id = "${var.compartment_ocid}"
  dns_label = "glusterdemo"
  display_name = "VCN_GlusterDemo"
}

# IGW
resource "oci_core_internet_gateway" "IGW_GlusterDemo" {
    compartment_id = "${var.compartment_ocid}"
    display_name = "IGW_GlusterDemo"
    vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
}

# RouteTable
resource "oci_core_route_table" "RouteTable_GlusterDemo" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
    display_name = "RouteTable_GlusterDemo"
    route_rules {
        cidr_block = "0.0.0.0/0"
        network_entity_id = "${oci_core_internet_gateway.IGW_GlusterDemo.id}"
    }
}

resource "oci_core_dhcp_options" "DHCPoptions" {
    compartment_id = "${var.compartment_ocid}"
    vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
    display_name = "DHCPoptions"
 
    options {
      type = "DomainNameServer"
      server_type = "VcnLocalPlusInternet"
    }
}

resource "oci_core_security_list" "SecL_STORSubNets" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  display_name = "SecL_STORSubNets"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol = "6"
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 22
      "max" = 22
    }
  }

  // allow inbound Gluster brick traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 24007
      "max" = 24020
    }
  }

  // allow inter Gluster brick traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 49152
      "max" = 49251
    }
  }


  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      "type" = 3
      "code" = 4
    }
  }
}

resource "oci_core_security_list" "SecL_WEBSubNets" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  display_name = "SecL_WEBSubNets"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol = "6"
  }

  // allow inbound udp traffic 
  ingress_security_rules {
    source = "0.0.0.0/0"
    protocol = "17" // udp
    stateless = true

    udp_options {
      "min" = 111
      "max" = 111
    }
  }

  ingress_security_rules {
    source = "0.0.0.0/0"
    protocol = "17" // udp
    stateless = true

    udp_options {
      "min" = 963
      "max" = 963
    }
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 22
      "max" = 22
    }
  }

  // allow inbound http traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 80
      "max" = 80
    }
  }

  // allow inbound https traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 443
      "max" = 443
    }
  }

  // allow inbound https traffic for Aleks 2015er
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 2015
      "max" = 2015
    }
  }

  // allow inbound traffic 1
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 111
      "max" = 111
    }
  }

  // allow inbound traffic 2
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 139
      "max" = 139
    }
  }

  // allow inbound traffic 3
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 445
      "max" = 445
    }
  }

  // allow inbound traffic 4
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 631
      "max" = 631
    }
  }

  // allow inbound traffic 5
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 965
      "max" = 965
    }
  }

  // allow inbound traffic 6
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 2049
      "max" = 2049
    }
  }

  // allow inbound traffic 7
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 38465
      "max" = 38469
    }
  }

  // allow inbound traffic 8
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0" 
    stateless = false
    
    tcp_options {
      "min" = 49152
      "max" = 49251
    }
  }

 // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      "type" = 3
      "code" = 4
    }
  }
}

resource "oci_core_security_list" "SecL_LBSubNets" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  display_name = "SecL_LBSubNets"

  // allow outbound tcp traffic on all ports
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol = "6"
  }

  // allow inbound ssh traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 22
      "max" = 22
    }
  }

  // allow inbound http traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 80
      "max" = 80
    }
  }

  // allow inbound https traffic
  ingress_security_rules {
    protocol = "6" // tcp
    source = "0.0.0.0/0"
    stateless = false

    tcp_options {
      "min" = 443
      "max" = 443
    }
  }

  // allow inbound icmp traffic of a specific type
  ingress_security_rules {
    protocol  = 1
    source    = "0.0.0.0/0"
    stateless = true

    icmp_options {
      "type" = 3
      "code" = 4
    }
  }
}

# SubNets for Gluster Brick Servers
resource "oci_core_subnet" "STORSubNet_AD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block = "${var.STORSubNet1AD1CIDR}"
  display_name = "STORSubNet_AD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_STORSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
#  dhcp_options_id = "${oci_core_virtual_network.VCN_GlusterDemo.default_dhcp_options_id}"
  dns_label = "storsubnet1"
}

resource "oci_core_subnet" "STORSubNet_AD2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block = "${var.STORSubNet2AD2CIDR}"
  display_name = "STORSubNet_AD2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_STORSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
#  dhcp_options_id = "${oci_core_virtual_network.VCN_GlusterDemo.default_dhcp_options_id}"
  dns_label = "storsubnet2"
}

resource "oci_core_subnet" "STORSubNet_AD3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block = "${var.STORSubNet3AD3CIDR}"
  display_name = "STORSubNet_AD3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_STORSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
#  dhcp_options_id = "${oci_core_virtual_network.VCN_GlusterDemo.default_dhcp_options_id}"
  dns_label = "storsubnet3"
}

# SubNets for Web Servers
resource "oci_core_subnet" "WEBSubNet_AD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block = "${var.WEBSubNet1AD1CIDR}"
  display_name = "WEBSubNet_AD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_WEBSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
#  dhcp_options_id = "${oci_core_virtual_network.VCN_GlusterDemo.default_dhcp_options_id}"
  dns_label = "websubnet1"
}

resource "oci_core_subnet" "WEBSubNet_AD2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block = "${var.WEBSubNet2AD2CIDR}"
  display_name = "WEBSubNet_AD2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_WEBSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
#  dhcp_options_id = "${oci_core_virtual_network.VCN_GlusterDemo.default_dhcp_options_id}"
  dns_label = "websubnet2"
}

resource "oci_core_subnet" "WEBSubNet_AD3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block = "${var.WEBSubNet3AD3CIDR}"
  display_name = "WEBSubNet_AD3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_WEBSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
#  dhcp_options_id = "${oci_core_virtual_network.VCN_GlusterDemo.default_dhcp_options_id}"
  dns_label = "websubnet3"
}

# SubNets for LB
resource "oci_core_subnet" "LBSubNet_AD1" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[0],"name")}"
  cidr_block = "${var.LBSubNet1AD1CIDR}"
  display_name = "LBSubNet_AD1"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_LBSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
  dns_label = "lbsubnet1"
}

resource "oci_core_subnet" "LBSubNet_AD2" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[1],"name")}"
  cidr_block = "${var.LBSubNet2AD2CIDR}"
  display_name = "LBSubNet_AD2"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_LBSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
  dns_label = "lbsubnet2"
}

resource "oci_core_subnet" "LBSubNet_AD3" {
  availability_domain = "${lookup(data.oci_identity_availability_domains.ADs.availability_domains[2],"name")}"
  cidr_block = "${var.LBSubNet3AD3CIDR}"
  display_name = "LBSubNet_AD3"
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.VCN_GlusterDemo.id}"
  route_table_id = "${oci_core_route_table.RouteTable_GlusterDemo.id}"
  security_list_ids = ["${oci_core_security_list.SecL_LBSubNets.id}"]
  dhcp_options_id = "${oci_core_dhcp_options.DHCPoptions.id}"
  dns_label = "lbsubnet3"
}

