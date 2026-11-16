output "external_ip" {
  value = yandex_compute_instance.lab4.network_interface[0].nat_ip_address
}

output "vm_id" {
  value = yandex_compute_instance.lab4.id
}

output "subnet_name" {
  value = yandex_vpc_subnet.lab4.name
}
