resource "kubectl_manifest" "users_cluster_role" {
  yaml_body = file("${path.module}/users-cluster-role.yaml")
}
