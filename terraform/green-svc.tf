resource "kubernetes_service" "green" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "green-"
  }

  spec {
    port {
      name        = "http"
      target_port = "green-http"
      port        = 8888
    }
    selector = {
      "app"        = "blue-green"
      "deployment" = "green"
    }
  }
}
