resource "yandex_compute_instance" "inc_example" {
depends_on = [ yandex_compute_instance.bastion ]

  for_each = { for vm in var.inc_example_vm: "${vm.vm_name}" => vm }
  name        = each.key 
  platform_id = "standard-v3"

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.disk_volume
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_key}"
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}