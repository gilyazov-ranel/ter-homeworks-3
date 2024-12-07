###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "cores" {
  type        = number
  default     = 2
  description = "cores"
}

variable "memory" {
  type        = number
  default     = 1
  description = "memory"
}

variable "core_fraction" {
  type        = number
  default     = 20
  description = "core_fraction"
} 

variable "public_key" {
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJKrfIvDPc0srFKuq4hSS1trpMfM7o/OpAvsbAm/BEx3 media-tel@mt-work-pc"
  description = "public_key"
} 

variable "size" {
  type        = number
  default     = 5
  description = "size"
} 

variable "vm_web_ubuntu" {
  type        = string
  default     = "ubuntu-2204-lts"
  description = "famyli operating system"
}

variable "inc_example_vm" {
  type = list(object({ vm_name = string, cpu = number, ram = number, disk_volume = number }))
  default = [{ vm_name = "main", cpu = 2, ram = 2, disk_volume = 20  }, { vm_name = "replica", cpu = 4, ram = 4, disk_volume = 50}]
  description = "each_vm"
}

locals {
  public_key = file("~/.ssh/id_ed25519.pub")
}