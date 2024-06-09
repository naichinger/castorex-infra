data "oci_identity_availability_domain" "ad" {
  compartment_id = var.compartment_ocid
  ad_number      = var.availability_domain_number 
}


resource "oci_core_instance" "castorex_control_plane" {
    compartment_id      = var.compartment_ocid
    availability_domain = data.oci_identity_availability_domain.ad.name
    display_name        = "Castorex Control Plane Instance"
    shape               = var.instances_shape

    shape_config {
        ocpus         = var.control_plane_ocpu_count
        memory_in_gbs = var.control_plane_memory_gb
    }

    create_vnic_details {
        subnet_id        = oci_core_subnet.castorex_subnet.id
        assign_public_ip = true
        assign_private_dns_record = "true"
        assign_ipv6ip = "false"
        hostname_label   = "castorexcontrolplane"
    }

    metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
    }

    source_details {
      source_type = "image"
      #Canonical-Ubuntu-22.04-aarch64-2024.02.18-0
      source_id = var.instances_image
      boot_volume_size_in_gbs = 50
    }
}

resource "oci_core_instance" "castorex_worker_nodes" {
    compartment_id      = var.compartment_ocid
    availability_domain = data.oci_identity_availability_domain.ad.name
    display_name        = "Castorex Worker Instance ${count.index}"
    shape               = var.instances_shape
    count               = var.worker_node_count

    shape_config {
        ocpus         = var.worker_ocpu_count
        memory_in_gbs = var.worker_memory_gb
    }

    create_vnic_details {
        subnet_id        = oci_core_subnet.castorex_subnet.id
        hostname_label = "castorexworker${count.index}"
        assign_public_ip = true
        skip_source_dest_check = true
    }

    metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
    }

    source_details {
      source_type = "image"
      #Canonical-Ubuntu-22.04-aarch64-2024.02.18-0
      source_id = var.instances_image
      boot_volume_size_in_gbs = 50
    }
}