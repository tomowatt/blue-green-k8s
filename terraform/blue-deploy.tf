resource "kubernetes_deployment" "blue" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "blue-"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app        = "blue-green"
        deployment = "blue"
      }
    }

    template {
      metadata {
        labels = {
          app        = "blue-green"
          deployment = "blue"
        }
        annotations = {
          "config-map-hash" = sha256(jsonencode(kubernetes_config_map.blue.data))
        }
      }

      spec {
        service_account_name = kubernetes_service_account.blue_green.metadata[0].name
        container {
          image = "ghcr.io/tomowatt/blue-green:v1.0.0"
          name  = "blue"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.blue.metadata[0].name
            }
          }
          liveness_probe {
            http_get {
              path = "/healthz"
              port = "blue-http"
            }
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = "blue-http"
            }
          }
          port {
            name           = "blue-http"
            container_port = 8888
          }
        }
      }
    }
  }
}
