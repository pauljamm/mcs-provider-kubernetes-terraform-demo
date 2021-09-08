variable "kubernetes_cluster_name" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = "1.20.4"
}

variable "kubernetes_master_flavor" {
  type    = string
  default = "Standard-2-4-50"
}

variable "kubernetes_master_count" {
  type    = number
  default = 1
}

variable "kubernetes_availability_zone" {
  type    = string
  default = "MS1"
}

variable "kubernetes_node_groups" {

  type = map(object({
    node_count         = number
    node_flavor        = string
  }))

  default = {
    "default_ng" = {
      "node_count"         = 1
      "node_flavor"        = "Basic-1-2-20"
    }
  }
}
