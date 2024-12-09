
resource "yandex_compute_disk" "disk" {
  count   = 3
  name	= "netology-disk-${count.index + 1}"
  size	= 1
}


resource "yandex_compute_instance" "storage" {
  name = "storage"
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

  dynamic "secondary_disk" {
   for_each = "${yandex_compute_disk.disk.*.id}"
   content {
 	    disk_id = secondary_disk.value
   }
  }

  network_interface {
	subnet_id = yandex_vpc_subnet.develop.id
	nat   	= true
  }

  metadata = {
	ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}