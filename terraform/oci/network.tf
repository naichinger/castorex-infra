resource "oci_core_vcn" "castorex_vcn" {
  cidr_block = "10.0.0.0/16"
  compartment_id = var.compartment_ocid
  dns_label      = "castorexvcn"
}

resource "oci_core_subnet" "castorex_subnet" {
  cidr_block        = "10.0.0.0/24"
  display_name      = "Castorex Infra Subnet"
  dns_label         = "castorexsubnet"
  compartment_id    = var.compartment_ocid
  vcn_id            = oci_core_vcn.castorex_vcn.id
  security_list_ids = [oci_core_security_list.castorex_security_list.id]
  route_table_id    = oci_core_vcn.castorex_vcn.default_route_table_id
  dhcp_options_id   = oci_core_vcn.castorex_vcn.default_dhcp_options_id
}

resource "oci_core_internet_gateway" "castorex_internet_gateway" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.castorex_vcn.id
}

resource "oci_core_default_route_table" "castorex_route_table" {
  manage_default_resource_id = oci_core_vcn.castorex_vcn.default_route_table_id
  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = oci_core_internet_gateway.castorex_internet_gateway.id
  }
}

resource "oci_core_security_list" "castorex_security_list" {
  compartment_id = var.compartment_ocid
  vcn_id         = oci_core_vcn.castorex_vcn.id

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
    stateless   = false
  }

  ingress_security_rules {
    protocol    = "all"
    source = "10.0.0.0/16"
    stateless   = false
    description = "Allow all traffic within subnet"
  }

  dynamic "ingress_security_rules" {
    for_each = [22, 80, 443, 6443]
    iterator = port
    content {
        protocol    = "6" # TCP
        stateless   = true
        source      = "0.0.0.0/0"
        description = "SSH and HTTP/S traffic from any origin"

        tcp_options {
            max = port.value
            min = port.value
        }
    }
  }
}