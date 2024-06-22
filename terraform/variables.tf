variable "hcloud_token" {
  sensitive = true
}

variable "ssh_public_key_path" {
  type = string
}

variable "region" {
  type = string
}

variable "worker_node_count" {
  type = number
}

variable "instances_shape" {
  type = string
}

variable "instances_image" {
  type = string
}

variable "cf_domain" {
  type = string
}

variable "cf_token" {
  type = string
}

variable "cf_account_id" {
  type = string
}

variable "argocd_pw" {
  type = string
}

variable "letsencrypt_email" {
  type = string
}
