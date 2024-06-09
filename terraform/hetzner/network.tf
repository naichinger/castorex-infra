resource "hcloud_network" "castorex_private_network" {
  name     = "castorex_private_network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "castorex_subnet" {
  type         = "cloud"
  network_id   = hcloud_network.castorex_private_network.id
  network_zone = "eu-central"
  ip_range     = "10.0.0.0/24"
}