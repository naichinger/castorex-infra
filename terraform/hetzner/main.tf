terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "1.45.0"
    }
  }
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
  filename = "../../ansible/inventory/inventory.yml"
}