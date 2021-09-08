kubernetes_cluster_name = "test"

kubernetes_master_count = 1

kubernetes_node_groups = {
  "ng-1" = {
    "node_count"         = 1
    "node_flavor"        = "Basic-1-2-20"
  }
}
