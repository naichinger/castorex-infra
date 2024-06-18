resource "hcloud_ssh_key" "instances_ssh_key" {
  name       = "ssh key"
  public_key = file(var.ssh_public_key_path)
}

resource "hcloud_server" "castorex_control_plane" {
  name        = "castorexcontrolplane"
  image       = var.instances_image
  server_type = var.instances_shape
  location    = var.region

  firewall_ids = [hcloud_firewall.castorex_firewall.id]

  ssh_keys = [ hcloud_ssh_key.instances_ssh_key.id ]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = hcloud_network.castorex_private_network.id
  }
  depends_on = [hcloud_network_subnet.castorex_subnet]
}

resource "hcloud_server" "castorex_worker_nodes" {
  count       = var.worker_node_count
  name        = "castorexworker${count.index}"
  image       = var.instances_image
  server_type = var.instances_shape
  location    = var.region

  firewall_ids = [hcloud_firewall.castorex_firewall.id]
  
  ssh_keys = [ hcloud_ssh_key.instances_ssh_key.id ]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  network {
    network_id = hcloud_network.castorex_private_network.id
  }
  depends_on = [hcloud_network_subnet.castorex_subnet]
}