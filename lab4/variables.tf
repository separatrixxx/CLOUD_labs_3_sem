variable "cloud_id" {
  type = string
}

variable "folder_id" {
  type = string
}

variable "zone" {
  type    = string
  default = "ru-central1-a"
}

variable "subnet_cidr" {
  type    = string
  default = "10.128.1.0/24"
}

variable "disk_size" {
  type    = number
  default = 20
}

variable "ssh_public_key_path" {
  type = string
}

variable "vm_memory" {
  type    = number
  default = 2
}

variable "image_family" {
  type    = string
  default = "ubuntu-2204-lts"
}
