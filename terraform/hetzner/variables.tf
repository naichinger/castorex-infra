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