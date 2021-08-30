resource "kubernetes_service_account" "app" {
  metadata {
    namespace     = var.namespace
    generate_name = "${var.env_version}-"
  }
}