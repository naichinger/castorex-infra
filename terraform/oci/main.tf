provider "oci" {
  tenancy_ocid     = var.compartment_ocid
  user_ocid        = var.user_ocid
  private_key_path = var.private_key_path
  fingerprint      = var.fingerprint
  region           = var.region
}

resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.yml.tpl",
    {
      server_hosts = oci_core_instance.castorex_control_plane.*
      agent_hosts = oci_core_instance.castorex_worker_nodes.*
    }
  )
  filename = "../../ansible/inventory/inventory.yml"
}