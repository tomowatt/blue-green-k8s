resource "kubernetes_config_map" "green" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "green-"
  }

  data = {
    "PORT"  = "8888"
    "TITLE" = "green"
    "TEXT"  = "green"
    "COLOR" = "green"
  }
}