data "openstack_networking_network_v2" "extnet" {
  name = "ext-net"
}

resource "openstack_networking_network_v2" "kubernetes_network" {
  name = "kubernetes_network"
}

resource "openstack_networking_subnet_v2" "kubernetes_subnet" {
  name       = "kubernetes_subnet"
  network_id = openstack_networking_network_v2.kubernetes_network.id
  cidr       = "10.100.0.0/16"
  ip_version = 4
}

resource "openstack_networking_router_v2" "kubernetes_router" {
  name                = "kubernetes_router"
  external_network_id = data.openstack_networking_network_v2.extnet.id
}

resource "openstack_networking_router_interface_v2" "kubernetes_router_interface" {
  router_id = openstack_networking_router_v2.kubernetes_router.id
  subnet_id = openstack_networking_subnet_v2.kubernetes_subnet.id
}
