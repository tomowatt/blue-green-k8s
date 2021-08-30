resource "kubernetes_service" "app" {
  metadata {
    namespace     = var.namespace
    generate_name = "${var.env_version}-"
  }

  spec {
    port {
      name        = "http"
      target_port = "http"
      port        = 8888
    }
    selector = {
      "app"        = "blue-green"
      "deployment" = "${var.env_version}"
    }
  }
}
