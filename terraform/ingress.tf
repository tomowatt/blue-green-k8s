resource "kubernetes_ingress" "blue" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "blue-"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }

  spec {
    rule {
      host = "blue.blue"
      http {
        path {
          path = "/"
          backend {
            service_name = module.blue.service_name
            service_port = "http"
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}

resource "kubernetes_ingress" "green" {
  metadata {
    namespace     = kubernetes_namespace.blue_green.metadata[0].name
    generate_name = "green-"
    annotations = {
      "kubernetes.io/ingress.class"             = "nginx"
      "nginx.ingress.kubernetes.io/auth-type"   = "basic"
      "nginx.ingress.kubernetes.io/auth-secret" = "basic-auth"
      # "nginx.ingress.kubernetes.io/auth-realm"  = "Authentication Required"
    }
  }

  spec {
    rule {
      host = "green.green"
      http {
        path {
          path = "/"
          backend {
            service_name = module.green.service_name
            service_port = "http"
          }
        }
      }
    }
  }

  depends_on = [
    helm_release.ingress_nginx
  ]
}