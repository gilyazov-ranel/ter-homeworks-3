resource "yandex_compute_instance" "bastion" {
  count = 2

  name        = "web-${count.index + 1}" 
  hostname    = "web-${count.index + 1}"
  platform_id = "standard-v3"

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${local.public_key}"
  }

  scheduling_policy { preemptible = true }

  network_interface {
    security_group_ids = ["enpqhisi96pqpn4ska3o"]
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }
  allow_stopping_for_update = true
}