resource "local_file" "inventory_disk" {
  content = templatefile("${path.module}/inventory.tftpl",
	{
  	webservers	= yandex_compute_instance.bastion,
  	databases   = yandex_compute_instance.inc_example,
  	storage = [yandex_compute_instance.storage]
	}
  )

  filename = "${abspath(path.module)}/inventory"
}

resource "null_resource" "web_hosts_provision" {
  
  depends_on = [yandex_compute_instance.storage, local_file.inventory_disk]

  provisioner "local-exec" {
    command    = "> ~/.ssh/known_hosts &&eval $(ssh-agent) && cat ~/.ssh/id_ed25519 | ssh-add -"
    on_failure = continue #Продолжить выполнение terraform pipeline в случае ошибок
  }

  provisioner "local-exec" {

    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/for.ini ${abspath(path.module)}/test.yml"


    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }

  triggers = {
    always_run      = "${timestamp()}"
    always_run_uuid = "${uuid()}"

  }

}