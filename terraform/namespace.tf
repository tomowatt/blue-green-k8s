resource "kubernetes_namespace" "blue_green" {
  metadata {
    name = "blue-green"
  }
}