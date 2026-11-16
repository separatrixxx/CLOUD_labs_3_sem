data "yandex_compute_image" "ubuntu" {
  family = var.image_family
}

resource "yandex_vpc_network" "lab4" {
  name = "lab4-network"
}

resource "yandex_vpc_subnet" "lab4" {
  name           = "lab4-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.lab4.id
  v4_cidr_blocks = [var.subnet_cidr]
}

resource "yandex_vpc_security_group" "lab4" {
  name       = "lab4-sg"
  network_id = yandex_vpc_network.lab4.id

  ingress {
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "ICMP"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_disk" "boot" {
  name     = "lab4-boot-disk"
  zone     = var.zone
  type     = "network-hdd"
  size     = var.disk_size
  image_id = data.yandex_compute_image.ubuntu.id
}

resource "yandex_compute_instance" "lab4" {
  name                      = "lab4-vm"
  hostname                  = "lab4-vm"
  description               = "Lab 4: infrastructure managed by Terraform"
  zone                      = var.zone
  platform_id               = "standard-v3"
  allow_stopping_for_update = true

  resources {
    cores         = 2
    memory        = var.vm_memory
    core_fraction = 20
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    disk_id     = yandex_compute_disk.boot.id
    auto_delete = false
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.lab4.id
    security_group_ids = [yandex_vpc_security_group.lab4.id]
    nat                = true
  }

  metadata = {
    ssh-keys = "ubuntu:${trimspace(file(pathexpand(var.ssh_public_key_path)))}"
  }
}
