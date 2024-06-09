variable "compartment_ocid" {
  type = string
}

variable "user_ocid" {
  type = string
}

variable "fingerprint" {
  type = string
}

variable "private_key_path" {
  type = string
}

variable "region" {
  type = string
}

variable "ssh_public_key_path" {
  type = string
}

variable "ssh_private_key_path" {
  type = string
}

variable "worker_node_count" {
  type = number
}

variable "availability_domain_number" {
  type = number
}

variable "instances_shape" {
  type = string
}

variable "instances_image" {
  type = string
}

variable "control_plane_ocpu_count" {
  type = number
}

variable "control_plane_memory_gb" {
  type = number
}

variable "worker_ocpu_count" {
  type = number
}

variable "worker_memory_gb" {
  type = number
}