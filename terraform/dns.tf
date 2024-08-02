resource "cloudflare_record" "castorex_record_k3s" {
  zone_id = data.cloudflare_zone.castorex_zone.id
  name    = "k3s"
  value   = hcloud_server.castorex_control_plane.ipv4_address
  type    = "A"
  proxied = false
}

resource "cloudflare_record" "castorex_record_any_k3s" {
  zone_id = data.cloudflare_zone.castorex_zone.id
  name    = "*.k3s"
  value   = "k3s.${data.cloudflare_zone.castorex_zone.name}"
  type    = "CNAME"
  proxied = false
}

data "cloudflare_zone" "castorex_zone" {
  name = var.cf_domain
}