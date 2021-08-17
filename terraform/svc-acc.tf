resource "kubernetes_service_account" "blue_green" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "blue-green-"
  }
}