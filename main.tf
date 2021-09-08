data "openstack_compute_flavor_v2" "kubernetes_master_flavor" {
  name = var.kubernetes_master_flavor
}

data "openstack_compute_flavor_v2" "kubernetes_node_flavor" {
  for_each = var.kubernetes_node_groups
  name     = each.value.node_flavor
}

data "mcs_kubernetes_clustertemplate" "kubernetes_clustertemplate" {
  version = var.kubernetes_version
}

resource "mcs_kubernetes_cluster" "cluster" {
  depends_on = [
    openstack_networking_router_interface_v2.kubernetes_router_interface,
  ]

  name                = var.kubernetes_cluster_name
  master_flavor       = data.openstack_compute_flavor_v2.kubernetes_master_flavor.id
  master_count        = var.kubernetes_master_count
  cluster_template_id = data.mcs_kubernetes_clustertemplate.kubernetes_clustertemplate.id

  keypair             = openstack_compute_keypair_v2.ssh.id
  network_id          = openstack_networking_network_v2.kubernetes_network.id
  subnet_id           = openstack_networking_subnet_v2.kubernetes_subnet.id
  floating_ip_enabled = true
  availability_zone   = var.kubernetes_availability_zone
  labels = {
    "prometheus_monitoring" = "false"
  }
}

resource "mcs_kubernetes_node_group" "kubernetes_ng" {
  for_each           = var.kubernetes_node_groups
  cluster_id         = mcs_kubernetes_cluster.cluster.id
  name               = each.key
  node_count         = each.value.node_count
  flavor_id          = data.openstack_compute_flavor_v2.kubernetes_node_flavor[each.key].id
}

data "mcs_kubernetes_cluster" "cluster" {
  name = mcs_kubernetes_cluster.cluster.name
  depends_on = [
    mcs_kubernetes_cluster.cluster,
  ]
}

output "kubeconfig" {
  value = data.mcs_kubernetes_cluster.cluster.k8s_config
}
