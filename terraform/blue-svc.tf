resource "kubernetes_service" "blue" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "blue-"
  }

  spec {
    port {
      name        = "http"
      target_port = "blue-http"
      port        = 8888
    }
    selector = {
      "app"        = "blue-green"
      "deployment" = "blue"
    }
  }
}
