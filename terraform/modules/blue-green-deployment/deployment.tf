resource "kubernetes_deployment" "app" {
  metadata {
    namespace     = var.namespace
    generate_name = "${var.env_version}-"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app        = "blue-green"
        deployment = "${var.env_version}"
      }
    }

    template {
      metadata {
        labels = {
          app        = "blue-green"
          deployment = "${var.env_version}"
        }
        annotations = {
          "config-map-hash" = sha256(jsonencode(kubernetes_config_map.app.data))
        }
      }

      spec {
        service_account_name = kubernetes_service_account.app.metadata[0].name
        container {
          image = var.image
          name  = var.env_version

          env_from {
            config_map_ref {
              name = kubernetes_config_map.app.metadata[0].name
            }
          }
          liveness_probe {
            http_get {
              path = "/healthz"
              port = "http"
            }
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = "http"
            }
          }
          port {
            name           = "http"
            container_port = var.port
          }
        }
      }
    }
  }
}
