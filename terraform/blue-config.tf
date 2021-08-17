resource "kubernetes_config_map" "blue" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "blue-"
  }

  data = {
    "PORT"  = "8888"
    "TITLE" = "blue"
    "TEXT"  = "blue"
    "COLOR" = "blue"
  }
}