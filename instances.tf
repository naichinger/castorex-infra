resource "oci_core_instance" "castorex_control_plane" {
    compartment_id      = var.compartment_ocid
    availability_domain = data.oci_identity_availability_domain.ad.name
    display_name        = "Castorex Control Plane Instance"
    shape               = "VM.Standard.A1.Flex"

    shape_config {
        ocpus         = 2
        memory_in_gbs = 12
    }

    create_vnic_details {
        subnet_id        = oci_core_subnet.castorex_subnet.id
        assign_public_ip = true
        hostname_label   = "castorexcontrolplane"
        skip_source_dest_check = true
    }

    metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
    }

    source_details {
      source_type = "image"
      #Canonical-Ubuntu-22.04-aarch64-2024.02.18-0
      source_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa6odzhcjyusigce7aenknxyk3fw44xcsmmqqc7a4hrmyvnhgbll7q"
      boot_volume_size_in_gbs = 50
    }
}

resource "oci_core_instance" "castorex_worker_nodes" {
    compartment_id      = var.compartment_ocid
    availability_domain = data.oci_identity_availability_domain.ad.name
    display_name        = "Castorex Worker Instance"
    shape               = "VM.Standard.A1.Flex"
    count               = var.worker_node_count

    shape_config {
        ocpus         = 1
        memory_in_gbs = 6
    }

    create_vnic_details {
        subnet_id        = oci_core_subnet.castorex_subnet.id
        assign_public_ip = true
        skip_source_dest_check = true
    }

    metadata = {
        ssh_authorized_keys = file(var.ssh_public_key_path)
    }

    source_details {
      source_type = "image"
      #Canonical-Ubuntu-22.04-aarch64-2024.02.18-0
      source_id = "ocid1.image.oc1.eu-frankfurt-1.aaaaaaaa6odzhcjyusigce7aenknxyk3fw44xcsmmqqc7a4hrmyvnhgbll7q"
      boot_volume_size_in_gbs = 50
    }
}