terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.45.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.cf_token
}

provider "hcloud" {
  token = var.hcloud_token
}

resource "local_file" "ansible_inventory" {
  content = templatefile("templates/inventory.yml.tpl",
    {
      server_hosts = hcloud_server.castorex_control_plane.*
      agent_hosts = hcloud_server.castorex_worker_nodes.*
    }
  )
  filename = "../ansible/inventory/inventory.yml"
}