resource "helm_release" "ingress_nginx" {
  create_namespace = true
  name             = "ingress-nginx"
  namespace        = "ingress-nginx"
  repository       = "https://kubernetes.github.io/ingress-nginx/"
  chart            = "ingress-nginx"
  version          = "3.31.0"

  set {
    name  = "controller.autoscaling.enabled"
    value = "true"
  }
}