resource "kubernetes_deployment" "green" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "green-"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app        = "blue-green"
        deployment = "green"
      }
    }

    template {
      metadata {
        labels = {
          app        = "blue-green"
          deployment = "green"
        }
        annotations = {
          "config-map-hash" = sha256(jsonencode(kubernetes_config_map.green.data))
        }
      }

      spec {
        service_account_name = kubernetes_service_account.blue_green.metadata[0].name
        container {
          image = "ghcr.io/tomowatt/blue-green:v1.0.0"
          name  = "green"

          env_from {
            config_map_ref {
              name = kubernetes_config_map.green.metadata[0].name
            }
          }

          liveness_probe {
            http_get {
              path = "/healthz"
              port = "green-http"
            }
          }

          readiness_probe {
            http_get {
              path = "/healthz"
              port = "green-http"
            }
          }

          port {
            name           = "green-http"
            container_port = 8888
          }
        }
      }
    }
  }
}
