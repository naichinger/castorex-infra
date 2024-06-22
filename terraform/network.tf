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

resource "hcloud_firewall" "castorex_firewall" {
  name = "castorex-firewall"
  rule {
    direction = "in"
    protocol  = "tcp"
    port = "22"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "random_password" "castorex_cf_tunnel_secret" {
  length           = 64
  special          = false
}

resource "cloudflare_tunnel" "castorex_cf_tunnel" {
  account_id = var.cf_account_id
  name       = "private-k3s-tunnel"
  secret     = base64sha256(random_password.castorex_cf_tunnel_secret.result)
}

resource "cloudflare_tunnel_route" "castorex_cf_tunnel_route" {
  account_id         = var.cf_account_id
  tunnel_id          = cloudflare_tunnel.castorex_cf_tunnel.id
  network            = "10.43.0.0/16"
  comment            = "Tunnel route for k3s cluster"
}

resource "cloudflare_fallback_domain" "castorex_cf_dns" {
  account_id = var.cf_account_id
  domains {
    suffix      = "cluster.local"
    description = "k3s cluster dns server"
    dns_server  = ["10.43.0.10"]
  }
}